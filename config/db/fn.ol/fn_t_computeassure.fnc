create or replace function FN_T_ComputeAssure(
    p_FirmID varchar2,
    p_CommodityID varchar2,
    p_bs_flag        number,
    p_quantity number,
    p_price number
) return number
/****
 * ���㵣����
 * ����ֵ �ɹ����ص�����;-1 �����������ݲ�ȫ;-100 ��������
****/
as
	v_version varchar2(10):='1.0.0.1';
    v_marginRate_b         number(10,4);
    v_marginRate_s         number(10,4);
    v_marginAlgr         number(2);
    v_contractFactor     number(12,2);
    v_margin             number(15,2) default 0;
begin
    --��ȡ��Ʒ��Ϣ����Լ���ӣ����׵����𣬱�֤���㷨
    select marginAssure_b,marginAssure_s,marginalgr,contractfactor
    into v_marginRate_b,v_marginRate_s,v_marginAlgr,v_contractFactor
    from T_Commodity where CommodityID=p_CommodityID;

    begin
        --��ȡ�ػ��Ľ��׵����𣬱�֤���㷨
        select marginAssure_b,marginAssure_s,marginalgr
    	into v_marginRate_b,v_marginRate_s,v_marginAlgr
        from T_A_FirmMargin
        where FirmID=p_FirmID and CommodityID=p_CommodityID;
    exception
        when NO_DATA_FOUND then
            null;
    end;
    if(v_marginAlgr=1) then  --Ӧ�ձ�֤��=����*��Լ����*�۸�*������
    	if(p_bs_flag = 1) then  --��
        	v_margin:=p_quantity*v_contractFactor*p_price*v_marginRate_b;
        elsif(p_bs_flag = 2) then  --��
        	v_margin:=p_quantity*v_contractFactor*p_price*v_marginRate_s;
        end if;
    elsif(v_marginAlgr=2) then  --Ӧ�ձ�֤��=����*������
    	if(p_bs_flag = 1) then  --��
        	v_margin:=p_quantity*v_marginRate_b;
        elsif(p_bs_flag = 2) then  --��
        	v_margin:=p_quantity*v_marginRate_s;
        end if;
    end if;
    if(v_margin is null) then
    	rollback;
        return -1;
    end if;
    return v_margin;
exception
    when no_data_found then
    	rollback;
        return -1;
    when others then
    	rollback;
    	return -100;
end;
/

