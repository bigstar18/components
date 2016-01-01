create or replace function FN_T_ComputeFeeByArgs(
    p_bs_flag        number,
    p_quantity       number,
    p_price          number,
    p_contractFactor        number,
    p_feeAlgr number,
    p_feeRate_b number,
    p_feeRate_s number
) return number
/****
 * ���ݲ�������������
 * ����ֵ �ɹ�����������;-1 ���㽻�׷����������ݲ�ȫ;-100 ��������
****/
as
	v_version varchar2(10):='1.0.0.1';
    v_fee             number(15,2) default 0;
begin
    if(p_feeAlgr=1) then  --Ӧ��������=����*��Լ����*�۸�*������
    	if(p_bs_flag = 1) then  --��
        	v_fee:=p_quantity*p_contractFactor*p_price*p_feeRate_b;
        elsif(p_bs_flag = 2) then  --��
        	v_fee:=p_quantity*p_contractFactor*p_price*p_feeRate_s;
        end if;
    elsif(p_feeAlgr=2) then  --Ӧ��������=����*������
    	if(p_bs_flag = 1) then  --��
        	v_fee:=p_quantity*p_feeRate_b;
        elsif(p_bs_flag = 2) then  --��
        	v_fee:=p_quantity*p_feeRate_s;
        end if;
    end if;
    if(v_fee is null) then
    	rollback;
        return -1;
    end if;
    return v_fee;
exception
    when no_data_found then
    	rollback;
        return -1;
    when others then
    	rollback;
   		return -100;
end;
/

