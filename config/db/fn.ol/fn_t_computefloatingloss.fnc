create or replace function FN_T_ComputeFloatingLoss(
    p_EvenPrice         number, --�ֲ־���
    p_Price         number, --�����
    p_HoldQty number, --�ֲ�����
    p_ContractFactor    number, --��Լ����
    p_BS_Flag number --������־
) return number
/****
 * ���㸡������
 * ����ֵ �ɹ����ظ�������
****/
as
	v_version varchar2(10):='1.0.0.1';
    v_FL_new number(15,2) default 0;
begin
    --���㸡��
    v_FL_new := (p_EvenPrice-p_Price)*p_HoldQty*p_ContractFactor;
    --�������������жϣ������Ӯʱ����Ϊ0
    if(p_BS_Flag = 1) then
        if(v_FL_new < 0) then
          v_FL_new := 0;
        end if;
    else
        if(v_FL_new > 0) then
          v_FL_new := 0;
        end if;
    end if;
    if(v_FL_new < 0) then
      v_FL_new := -v_FL_new;
    end if;
    return v_FL_new;
end;
/

