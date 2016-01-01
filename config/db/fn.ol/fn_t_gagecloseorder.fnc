create or replace function FN_T_GageCloseOrder(
    p_FirmID         varchar2,   --������ID
    p_TraderID       varchar2,  --����ԱID
    p_CommodityID    varchar2 default null,
    p_bs_flag        number default null,
    p_price          number default null,
    p_quantity       number default null,
    p_closeMode      number default null,
    p_specPrice      number default null,
    p_timeFlag       number default null,
    p_closeFlag      number default null,   --ƽ�ֱ�־
	  p_CustomerID     varchar2,  --���׿ͻ�ID
	  p_ConsignerID    varchar2  --ί��ԱID
) return number
/****
 * �ֶ�ת��ί�� add by yukx 20100424
 * ����ֵ
 * >0  �ɹ��ύ��������ί�е���
 * -21  �ֲֲ���
 * -22  ָ���ֲ���
 * -99  �������������
 * -100 ��������
****/
as
	v_version varchar2(10):='1.0.3.x';
  v_HoldSum        number(10);
    v_A_OrderNo      number(15);   --ί�к�
    v_errorcode number;
    v_errormsg  varchar2(200);
begin
	--1��֤����
	begin
	    select nvl(GageQty - GageFrozenQty, 0) into v_HoldSum
	    from T_CustomerHoldSum
	    where CustomerID = p_CustomerID
	      and CommodityID = p_CommodityID
	      and bs_flag != p_bs_flag for update;
    exception
        when NO_DATA_FOUND then
	        rollback;
	        return -21;  --�ֲֲ���
    end;
    if(v_HoldSum < p_quantity) then
        rollback;
        return -21;  --�ֲֲ���
    end if;

    --2�ͻ��ֲֺϼƵֶ�������������
    update T_CustomerHoldSum set GageFrozenQty = GageFrozenQty+p_quantity
           where CustomerID = p_CustomerID and CommodityID = p_CommodityID and BS_Flag != p_bs_flag;

    commit;

     --3������ί�е��Ų�����ί�б�
	--���ü��㺯���޸�ί�е��� 2011-2-15 by feijl
    select FN_T_ComputeOrderNo(SEQ_T_Orders.nextval) into v_A_OrderNo from dual;
    insert into T_Orders
      ( a_orderno,  a_orderno_w,   CommodityID,   Firmid,    traderid,   bs_flag,   ordertype, status, quantity, price, closemode, specprice,       timeflag,tradeqty, frozenfunds, unfrozenfunds, ordertime, withdrawtime, ordererip, signature,closeFlag,   CustomerID,ConsignerID,BillTradeType)
    values
      (v_A_OrderNo,   null,        p_CommodityID, p_Firmid,  p_traderid, p_bs_flag,     2,        1,  p_quantity, p_price, p_closemode, p_specprice, p_timeflag, 0,        0,              0,         sysdate,      null,       null,     null,  p_closeFlag,p_CustomerID,p_ConsignerID,2);

    return v_A_OrderNo;

exception
    when NO_DATA_FOUND then
        rollback;
        return -99;  --�������������
    when others then
    v_errorcode:=sqlcode;
    v_errormsg :=sqlerrm;
    rollback;
    insert into T_DBLog(err_date,name_proc,err_code,err_msg)
    values(sysdate,'FN_T_GageCloseOrder',v_errorcode,v_errormsg);
    commit;
    return -100;
end;
/

