CREATE OR REPLACE FUNCTION FN_T_SubHoldSum
(
  p_HoldQty      number,   --�ֲ�����
  p_GageQty      number,   --������
  p_Margin      number,   --��֤��
  p_Assure      number,   --������
  p_CommodityID varchar2, --��Ʒ����
  p_ContractFactor        number, --��Լ����
  p_BS_Flag        number, --������־
  p_FirmID varchar2,   --�����̴���
  p_HoldFunds      number,   --�����ֲֽ̳��
  p_CustomerID varchar2,   --���׿ͻ�����
  p_CustomerHoldFunds      number,   --���׿ͻ��ֲֽ��
  p_GageMode number,     --�ֶ�ģʽ��0ȫ�ֶ���1��ֶ�
  p_FrozenQty number     --���׿ͻ���������
)  return number
/***
 * ���ٽ��׿ͻ��������̵ĳֲֺϼ���Ϣ
 *
 * ����ֵ��1�ɹ�
 ****/
is
  v_version varchar2(10):='1.0.0.10';
  v_num   number(10);
begin
    --���Ľ��׿ͻ��ֲֺϼƱ��еĳֲּ�¼
    update T_CustomerHoldSum
    set holdqty = holdqty - p_HoldQty,
        GageQty = GageQty - p_GageQty,
        FrozenQty = FrozenQty - p_FrozenQty,
        holdfunds = holdfunds - p_CustomerHoldFunds,
        HoldMargin = HoldMargin - p_Margin,
        HoldAssure = HoldAssure - p_Assure,
        evenprice = decode((holdqty+GageQty - p_HoldQty-p_GageQty),0,0,(holdfunds - p_CustomerHoldFunds)/((holdqty+GageQty - p_HoldQty-p_GageQty)*p_ContractFactor))
    where CustomerID = p_CustomerID
      and CommodityID = p_CommodityID
      and bs_flag = p_BS_Flag;
    --���Ľ����ֲֺ̳ϼƱ��еĳֲּ�¼
    update T_FirmHoldSum
    set holdqty = holdqty - p_HoldQty,
        GageQty = GageQty - p_GageQty,
        holdfunds = holdfunds - p_HoldFunds,
        HoldMargin = HoldMargin - p_Margin,
        HoldAssure = HoldAssure - p_Assure,
        evenprice = decode(p_GageMode,1,decode((holdqty+GageQty - p_HoldQty-p_GageQty),0,0,(holdfunds - p_HoldFunds)/((holdqty+GageQty - p_HoldQty-p_GageQty)*p_ContractFactor)),
        decode((holdqty - p_HoldQty),0,0,(holdfunds - p_HoldFunds)/((holdqty - p_HoldQty)*p_ContractFactor)))
    where Firmid = p_FirmID
      and CommodityID = p_CommodityID
      and bs_flag = p_BS_Flag;

   return 1;
end;
/

