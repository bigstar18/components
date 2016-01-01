CREATE OR REPLACE FUNCTION FN_T_UpdateQuotation
(
    p_CommodityID varchar2,   --��Ʒ����
    p_YesterBalancePrice number, --������
    p_ClosePrice number,               --�����̼�
    p_OpenPrice number,               --���м�
    p_HighPrice number,               --��߼�
    p_LowPrice number,               --��ͼ�
    p_CurPrice number,               --���¼�
    p_CurAmount number,               --����(���¼�����Ӧ�ĳɽ���)
    p_OpenAmount number,               --����
	p_BuyOpenAmount number,               --�򿪲�
	p_SellOpenAmount number,               --������
    p_CloseAmount number,               --ƽ��
    p_BuyCloseAmount number,               --��ƽ��
    p_SellCloseAmount number,               --��ƽ��
    p_ReserveCount number,               --������
    p_ReserveChange number,               --�ֲ�
    p_Price number,                --�����
    p_TotalMoney number,                --�ܳɽ���
    p_TotalAmount number,                --�ܳɽ���
    p_Spread number,                --�ǵ�
    p_BuyPrice1 number,                --�����1
    p_SellPrice1 number,                --������1
    p_BuyAmount1 number,                --������1
    p_SellAmount1 number,                --������1
    p_BuyPrice2 number,                --�����2
    p_SellPrice2 number ,               --������2
    p_BuyAmount2 number ,               --������2
    p_SellAmount2 number,                --������2
    p_BuyPrice3 number,                --�����3
    p_SellPrice3 number,                --������3
    p_BuyAmount3 number,                --������3
    p_SellAmount3 number ,               --������3
    p_BuyPrice4 number ,               --�����4
    p_SellPrice4 number,                --������4
    p_BuyAmount4 number,                --������4
    p_SellAmount4 number,                --������4
    p_BuyPrice5 number,                --�����5
    p_SellPrice5 number,                --������5
    p_BuyAmount5 number,                --������5
    p_SellAmount5 number,                --������5
    p_OutAmount number,                --����
    p_InAmount number,                --����
    p_TradeCue number,                --������ʾ
    p_NO number,                --�����ֶ�
    p_CreateTime timestamp      --2009-09-21 ���Ӹ���ʱ�䣬Ϊnull��ȡsystimestamp(3)�������Ͼ�������ʱ����³ɿ���ʱ��
) RETURN NUMBER
/****
 * ��������
 * ����ֵ
 * 1 �ɹ�
 * -100 ʧ��
****/
as
	v_version varchar2(10):='1.0.0.9';
    v_num   number(10);
    v_errorcode number;
    v_errormsg  varchar2(200);
begin
    select count(*) into v_num from T_Quotation where CommodityID = p_CommodityID;
    if(v_num >0) then
        update T_Quotation set YesterBalancePrice=p_YesterBalancePrice,ClosePrice=p_ClosePrice,OpenPrice=p_OpenPrice,HighPrice=p_HighPrice,
        LowPrice=p_LowPrice,CurPrice=p_CurPrice,CurAmount=p_CurAmount,OpenAmount=p_OpenAmount,BuyOpenAmount=p_BuyOpenAmount,SellOpenAmount=p_SellOpenAmount,CloseAmount=p_CloseAmount,BuyCloseAmount=p_BuyCloseAmount,SellCloseAmount=p_SellCloseAmount,
        ReserveCount=p_ReserveCount,ReserveChange=p_ReserveChange,Price=p_Price,TotalMoney=p_TotalMoney,TotalAmount=p_TotalAmount,Spread=p_Spread,BuyPrice1=p_BuyPrice1,SellPrice1=p_SellPrice1
        ,BuyAmount1=p_BuyAmount1,SellAmount1=p_SellAmount1,BuyPrice2=p_BuyPrice2,SellPrice2=p_SellPrice2,BuyAmount2=p_BuyAmount2,SellAmount2=p_SellAmount2,BuyPrice3=p_BuyPrice3,SellPrice3=p_SellPrice3,BuyAmount3=p_BuyAmount3,SellAmount3=p_SellAmount3
        ,BuyPrice4=p_BuyPrice4,SellPrice4=p_SellPrice4,BuyAmount4=p_BuyAmount4,SellAmount4=p_SellAmount4,BuyPrice5=p_BuyPrice5,SellPrice5=p_SellPrice5,BuyAmount5=p_BuyAmount5,SellAmount5=p_SellAmount5,OutAmount=p_OutAmount,InAmount=p_InAmount
        ,TradeCue=p_TradeCue,NO=p_NO,CreateTime=decode(p_CreateTime,null,systimestamp(3),p_CreateTime)
        where CommodityID = p_CommodityID;
    else
        insert into T_Quotation(CommodityID,YesterBalancePrice,ClosePrice,OpenPrice,HighPrice,
        LowPrice,CurPrice,CurAmount,OpenAmount,BuyOpenAmount,SellOpenAmount,CloseAmount,BuyCloseAmount,SellCloseAmount,ReserveCount,ReserveChange,Price,TotalMoney,TotalAmount,Spread,
        BuyPrice1,SellPrice1,BuyAmount1,SellAmount1,BuyPrice2,SellPrice2,BuyAmount2,SellAmount2,BuyPrice3,SellPrice3,
        BuyAmount3,SellAmount3,BuyPrice4,SellPrice4,BuyAmount4,SellAmount4,BuyPrice5,SellPrice5,BuyAmount5,SellAmount5,
        OutAmount,InAmount,TradeCue,NO,CreateTime)
        values(p_CommodityID,p_YesterBalancePrice,p_ClosePrice,p_OpenPrice,p_HighPrice,p_LowPrice,p_CurPrice,p_CurAmount,p_OpenAmount,p_BuyOpenAmount,p_SellOpenAmount,p_CloseAmount,p_BuyCloseAmount,p_SellCloseAmount,p_ReserveCount,p_ReserveChange,p_Price,p_TotalMoney,p_TotalAmount,p_Spread,p_BuyPrice1,
        p_SellPrice1,p_BuyAmount1,p_SellAmount1,p_BuyPrice2,p_SellPrice2,p_BuyAmount2,p_SellAmount2,p_BuyPrice3,p_SellPrice3,p_BuyAmount3,
        p_SellAmount3,p_BuyPrice4,p_SellPrice4,p_BuyAmount4,p_SellAmount4,p_BuyPrice5,p_SellPrice5,p_BuyAmount5,p_SellAmount5,
        p_OutAmount,p_InAmount,p_TradeCue,p_NO,decode(p_CreateTime,null,systimestamp(3),p_CreateTime));
    end if;
    commit;
    return 1;
exception
    when OTHERS then
    v_errorcode:=sqlcode;
    v_errormsg :=sqlerrm;
    rollback;
    insert into T_DBLog(err_date,name_proc,err_code,err_msg)
    values(sysdate,'FN_T_UpdateQuotation',v_errorcode,v_errormsg);
    commit;
    return -100;
end;
/

