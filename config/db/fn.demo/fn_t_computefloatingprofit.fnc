create or replace function FN_T_ComputeFloatingProfit(
    p_EvenPrice         number, --�ֲ־���
    p_Price         number, --�����
    p_HoldQty number, --�ֲ�����
    p_ContractFactor    number, --��Լ����
    p_BS_Flag number --������־
) return number
/****
 * ���㸡��ӯ��
 * ����ֵ �ɹ����ظ���ӯ��
****/
as
	v_version varchar2(10):='1.0.0.1';
    v_FL_new number(15,2) default 0;
begin
    --���㸡��ӯ��
    if(p_BS_Flag = 1) then
      v_FL_new := (p_Price-p_EvenPrice)*p_HoldQty*p_ContractFactor;
    else
      v_FL_new := (p_EvenPrice-p_Price)*p_HoldQty*p_ContractFactor;
    end if;
    return v_FL_new;
end;
/

