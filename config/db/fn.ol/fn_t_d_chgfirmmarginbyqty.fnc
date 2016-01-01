CREATE OR REPLACE FUNCTION FN_T_D_ChgFirmMarginByQty
(
  p_FirmID varchar2,   --���׿ͻ�����
  p_CommodityID varchar2, --��Ʒ����
  p_BS_Flag        number, --������־
  p_TradeQty       number     --����
)  return number
/***
 * ������ʱ��֤�����ʱ�����𣬸�������ƽ��������
 *
 * ����ֵ��1�ɹ�
 ****/
is
  v_version varchar2(10):='1.0.2.2';
  v_HoldMargin    number(15,2);
  v_HoldAssure    number(15,2);
begin
    --���Ľ����ֲֺ̳ϼƱ��еĳֲּ�¼
    select HoldMargin*p_TradeQty/holdqty,HoldAssure*p_TradeQty/holdqty into v_HoldMargin,v_HoldAssure from T_FirmHoldSum
    where FirmID = p_FirmID
      and CommodityID = p_CommodityID
      and bs_flag = p_BS_Flag;
    --������ʱ��֤�����ʱ������
    update T_Firm
    set runtimemargin = runtimemargin - v_HoldMargin,
	    RuntimeAssure = RuntimeAssure - v_HoldAssure
    where Firmid = p_FirmID;
    return v_HoldMargin-v_HoldAssure;
end;
/

