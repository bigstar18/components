create or replace function FN_T_D_SellNeutralOrder(
  p_FirmID     varchar2,   --������ID
  p_TraderID       varchar2,  --����ԱID
  p_CommodityID varchar2 ,--��ƷID
  p_Quantity       number ,--����
  p_Price       number ,--ί�м۸���������
  p_CustomerID     varchar2,  --���׿ͻ�ID
  p_ConsignerID    varchar2,  --��Ϊί��ԱID
  p_DelayQuoShowType number, --����������ʾ���ͣ�0�������걨�������������걨������ʾ�� 1��ʵʱ��ʾ��
  p_DelayNeedBill    number  --���ڽ����Ƿ���Ҫ�ֵ���0������Ҫ�� 1����Ҫ��
) return number
/****
 * �������걨ί��
 * ����ֵ
 * >0  �ɹ��ύ��������ί�е���
 * -2  �����̿����ʽ���
 * -32 �ֵ���������
****/
as
  v_version varchar2(10):='1.0.0.0';
  v_Payout_B    number(15,2);   --�򷽽��ջ���
  v_SettleMargin    number(15,2);   --���ձ�֤��
  v_HoldFunds     number(15,2);   --����ֲֶ����ʽ�
  v_F_Funds      number(15,2):=0;   --Ӧ�����ʽ�
  v_F_FrozenFunds  number(15,2); --���񶳽��ʽ�
  v_A_Funds      number(15,2);   --�����ʽ�
  v_A_OrderNo       number(15); --ί�е���
  v_b_s_unsettleqty number(15);--�����걨������֮��Ĳ�ֵ
  v_NeutralSide number(2); --�����ַ���
  v_ret  number(4);
  v_errorcode number;
  v_errormsg  varchar2(200);
begin
  --1. ���ݲ����Ƿ���Ҫ��鲢����ֵ�
  if(p_DelayNeedBill = 1) then
	v_ret := FN_T_D_CheckAndFrozenBill(p_FirmID,p_CommodityID,p_Quantity);
	if(v_ret = -1) then
		rollback;
		return -32;  --�ֵ���������
	end if;
  end if;
  --2. ��鲢�����ʽ�
  --���������ʽ��������ձ�֤�𣫷���ֱֲ�֤��
  --���㽻�ձ�֤��
  v_SettleMargin := FN_T_ComputeSettleMargin(p_FirmID,p_CommodityID,2,p_Quantity,p_Price);
  --���㷴��ֱֲ�֤��
  v_HoldFunds := FN_T_ComputeMargin(p_FirmID,p_CommodityID,1,p_Quantity,p_Price);
  --Ӧ�����ʽ�
  v_F_Funds := v_SettleMargin + v_HoldFunds;
  --��������ʽ𣬲���ס�����ʽ�
  v_A_Funds := FN_F_GetRealFunds(p_FirmID,1);
  if (v_F_Funds>v_A_Funds) then
    rollback;
    return -2; --�����ʽ���
  end if;
  --3. ���¶����ʽ�
  v_F_FrozenFunds := FN_F_UpdateFrozenFunds(p_FirmID,v_F_Funds,'15');
  --4. ��������ί�б�������ί�е���
  select SEQ_T_DelayOrders.nextval into v_A_OrderNo from dual;
  insert into T_DelayOrders
    ( a_orderno,    CommodityID,   CustomerID,    traderid,   bs_flag, DelayOrderType, status, quantity, price, tradeqty, frozenfunds, unfrozenfunds, ordertime, withdrawtime, ordererip, signature,  FirmID ,ConsignerID)
  values
    (v_A_OrderNo,  p_CommodityID, p_CustomerID,  p_TraderID,         2,           2,         1,p_Quantity, p_Price,  0,     v_F_Funds,       0,         sysdate,      null,       null,     null,     p_FirmID ,p_ConsignerID);

  --5. ����ʵʱ��ʾ��Ҫ��������
  if(p_DelayQuoShowType = 1) then
    update T_DelayQuotation set SellNeutralQty=nvl(SellNeutralQty,0) + p_Quantity,CreateTime=sysdate where CommodityID = p_CommodityID;
  end if;

  commit;
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
  values(sysdate,'FN_T_D_SellNeutralOrder',v_errorcode,v_errormsg);
  commit;
  return -100;
end;
/

