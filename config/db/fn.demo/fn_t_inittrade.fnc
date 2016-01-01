CREATE OR REPLACE FUNCTION FN_T_InitTrade
(
    p_ClearDate Date  --��������
)
RETURN NUMBER
/****
 * ��ʼ������ϵͳ
 * ����ֵ 1 �ɹ�;-100 ��������
****/
as
	v_version varchar2(10):='1.0.2.2';
	v_CommodityID varchar2(16);
	v_Price         number(15,2);
	v_ReserveCount   number(10);
	v_num            number(10);
        v_ret            number(10);
	v_quotationTwoSide  number(10);
    v_errorcode number;
    v_errormsg  varchar2(200);
    --���������α�,����������Ʒ��������
    cursor cur_T_Quotation is select CommodityID,Price from T_Quotation;
    --��Ʒ�����α�
    cursor cur_T_Commodity is
        select CommodityID
        from T_Commodity
        where SettleDate<trunc(p_ClearDate);
begin
    --1�������α���½�����Ʒ��ֻ�н�������С�ڵ������ڲ��ҳֱֲ���û�д���Ʒ�ĳֲ֣�����Դ���Ʒ����ɾ������Ʒ
  	open cur_T_Commodity;
    loop
    	fetch cur_T_Commodity into v_CommodityID;
    	exit when cur_T_Commodity%notfound;
        select count(*) into v_num from T_FirmHoldSum where CommodityID = v_CommodityID and (HoldQty+GageQty)>0;
        if(v_num <= 0) then
		    delete from T_Commodity where CommodityID=v_CommodityID;
		    --2009-11-27 ����ɾ���������õı�
		    delete from T_A_FirmMargin where CommodityID=v_CommodityID;
		    delete from T_A_FirmFee where CommodityID=v_CommodityID;
		    delete from T_A_FirmMaxHoldQty where CommodityID=v_CommodityID;
        else
           update T_Commodity set status=1 where CommodityID=v_CommodityID;
        end if;
 	end loop;
    close cur_T_Commodity;
    --2��ɾ�����׿ͻ��ֲ���ϸ��ĳֲ������͵ֶ�����������0�ļ�¼
    delete from T_HoldPosition where HoldQty=0 and GageQty=0;
    --3��ɾ�����׿ͻ��ֲֺϼƱ�ĳֲ������͵ֶ�����������0�ļ�¼
    delete from T_CustomerHoldSum where HoldQty=0 and GageQty=0;
    --4��ɾ�������ֲֺ̳ϼƱ�ĳֲ������͵ֶ�����������0�ļ�¼
    delete from T_FirmHoldSum where HoldQty=0 and GageQty=0;
    --5�������α������Ʒ�����ۺͶ�������by cxc 2009-08-17���������ڴӳֲ����ϻ��ܣ�����ֻ����������
  	open cur_T_Quotation;
    loop
    	fetch cur_T_Quotation into v_CommodityID,v_Price;
    	exit when cur_T_Quotation%notfound;
    	update T_Commodity set LastPrice=v_Price where CommodityID=v_CommodityID;
 	end loop;
    close cur_T_Quotation;
    --6��������Ʒ�ϵĶ�����������˫�ߵģ� ���ºͳֲ��ϵĶ�һ�Σ���֤ÿ�춼��ȷ����ΪЭ��ƽ�֣���ǰ������û�и��������ϵĶ�����
    --add 2010-09-07 �������鵥˫���ж�
	select quotationTwoSide into v_quotationTwoSide from T_A_MARKET;
	update T_Commodity a
    set ReserveCount =
    nvl((
          select decode(v_quotationTwoSide,2,sum(HoldQty+GageQty),sum(HoldQty+GageQty)/2)
      	  from T_FirmHoldSum
      	  where CommodityID=a.CommodityID
          group by CommodityID
    ),0);
    --7����յ��������
    delete from T_Quotation;
    --8��������Ʒ�����ʼ����
    insert into T_Quotation(CommodityID,Price,YesterBalancePrice,ReserveCount,CreateTime)
                 select     CommodityID,LastPrice,LastPrice,      ReserveCount,sysdate
                 from T_Commodity where Status<>1;
    --8.5 ��������������̼�
    update T_Quotation a
    set (ClosePrice) =nvl(
    (
      select nvl(CurPrice,0)
      from T_H_Quotation
      where ClearDate =(select max(ClearDate) from T_H_Quotation) and CommodityID=a.CommodityID
    ),0);

    --9����յ������������
    delete from T_DelayQuotation;
    --10��������Ʒ�����ʼ��������
    insert into T_DelayQuotation(CommodityID,BuySettleQty,SellSettleQty,BuyNeutralQty,SellNeutralQty,CreateTime,NeutralSide)
                 select          CommodityID,       0,           0,            0,             0,       sysdate ,     0
                 from T_Commodity where Status<>1 and SettleWay=1;

    --11����ʼ��������С��ű�  2011-2-15 by feijl
    select count(*) into v_num from T_CurMinNo where TradeDate = TO_NUMBER(TO_CHAR(p_ClearDate,'yyMMdd'));
    if(v_num <= 0) then
		update T_CurMinNo set TradeDate = TO_NUMBER(TO_CHAR(p_ClearDate,'yyMMdd')),A_OrderNo=SEQ_T_Orders.nextval,A_TradeNo=SEQ_T_Trade.nextval,A_HoldNo=SEQ_T_HoldPosition.nextval;
    end if;
    --���ò���ϵͳ��ʼ���洢 liuchao 20130411
    SP_F_StatusInit();

    --���³ֲֵĵ������� add by zhaodc 2013-12-25
    select count(*) into v_ret from  t_commodity c where c.maxholdpositionday is not null;
    if ( v_ret > 0) then
      v_ret := fn_t_addTradeDays();
      for cmd in (select commodityid from t_commodity c where c.maxholdpositionday is not null)
      loop
        v_ret := fn_t_updateholddays(cmd.commodityid);
      end loop;
    end if;
    --��û���������ֲ�������Ҳ�������������ڣ��Ķ�����ϸ�ĵ������ں͵����������
    update t_holdposition
       set deadline = null,remainday=null
     where commodityid in ( select commodityid from t_commodity where maxholdpositionday is null );

    commit;
    return 1;
exception
    when OTHERS then
    v_errorcode:=sqlcode;
    v_errormsg :=sqlerrm;
    rollback;
    insert into T_DBLog(err_date,name_proc,err_code,err_msg)
    values(sysdate,'FN_T_InitTrade',v_errorcode,v_errormsg);
    commit;
    return -100;
end;
/

