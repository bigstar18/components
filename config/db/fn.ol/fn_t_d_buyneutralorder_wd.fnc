create or replace function FN_T_D_BuyNeutralOrder_WD(
  p_FirmID     varchar2,   --������ID
  p_CustomerID     varchar2,  --���׿ͻ�ID
  p_CommodityID varchar2 ,--��ƷID
  p_Quantity       number ,--ί������
  p_TradeQty       number ,--�ѳɽ�����
  p_Price       number ,--ί�м۸���������
  p_A_OrderNo_W     number,  --����ί�е���
  p_quantity_wd       number,  --��������
  p_frozenfunds     number,  --�����ʽ�
  p_unfrozenfunds       number  --�ⶳ�ʽ�
) return number
/****
 * ��������ί�г������ú���������ִ���ύ�ͻع�����
 * ����ֵ
 * 1  �ɹ�
****/
as
  v_version varchar2(10):='1.0.0.0';
  v_Payout_B    number(15,2);   --�򷽽��ջ���
  v_SettleMargin    number(15,2);   --�򷽽��ձ�֤��
  v_to_unfrozenF   number(15,2);
  v_F_FrozenFunds   number(15,2);   --�����̶����ʽ�
  v_HoldFunds   number(15,2);   --�����̷���ֱֲ�֤��
begin
  --1. �ͷ�ʣ��Ķ����ʽ𣬸���δ�ɽ�����
  if(p_Quantity - p_TradeQty = p_quantity_wd) then
    v_to_unfrozenF := p_frozenfunds - p_unfrozenfunds;
  else
    --�����ʽ�
    --�򷽶����ʽ��򷽻���򷽽��ձ�֤�𣫷���ֱֲ�֤��
    v_Payout_B := FN_T_ComputePayout(p_FirmID,p_CommodityID,1,p_quantity_wd,p_Price);
    --���㽻�ձ�֤��
    v_SettleMargin := FN_T_ComputeSettleMargin(p_FirmID,p_CommodityID,1,p_quantity_wd,p_Price);
    --���㷴��ֱֲ�֤��
    v_HoldFunds := FN_T_ComputeMargin(p_FirmID,p_CommodityID,2,p_quantity_wd,p_Price);
    --Ӧ�����ʽ�
    v_to_unfrozenF := v_Payout_B + v_SettleMargin + v_HoldFunds;
  end if;
  update T_DelayOrders set unfrozenfunds = unfrozenfunds + v_to_unfrozenF
  where A_orderNo = p_a_orderno_w;
  --2. ���½����̲��񶳽��ʽ�
  v_F_FrozenFunds := FN_F_UpdateFrozenFunds(p_FirmID,-v_to_unfrozenF,'15');

  return 1;
end;
/

