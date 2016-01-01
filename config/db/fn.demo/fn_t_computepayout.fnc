create or replace function FN_T_ComputePayout(
    p_FirmID varchar2,
    p_CommodityID varchar2,
    p_bs_flag        number,
    p_quantity number,
    p_price number
) return number
/****
 * ���㽻�ջ���
 * ����ֵ �ɹ����ؽ��ջ���;-1 �����������ݲ�ȫ;-100 ��������
 *
 * ������ڼ����������ʱ�������Ʒ��˰���۳���˰��   by ������  2015/09/11
****/
as
	v_version varchar2(10):='1.0.0.1';
    v_marginRate_b         number(10,4);
    v_marginAlgr_b         number(2);
    v_contractFactor     number(12,2);
    v_margin             number(15,2) default 0;
    v_taxinclusive      number(1);                              --��Ʒ�Ƿ�˰ 1Ϊ����˰ 0Ϊ��˰
    v_addedtax         number(10,4);                          --��Ʒ˰��
    
begin
    --��ȡ��Ʒ��Ϣ����Լ���ӣ����ջ���ϵ�������ջ����㷨 , ��Ʒ�Ƿ�˰����Ʒ˰��
    select PayoutRate,PayoutAlgr,contractfactor,taxinclusive,addedtax
    into v_marginRate_b,v_marginAlgr_b,v_contractFactor,v_taxinclusive,v_addedtax
    from T_Commodity where CommodityID=p_CommodityID;

    begin
        --��ȡ����Ľ��ջ���ϵ�������ջ����㷨
        select PayoutRate,PayoutAlgr
    	into v_marginRate_b,v_marginAlgr_b
        from T_A_FirmSettleMargin
        where FirmID=p_FirmID and CommodityID=p_CommodityID;
    exception
        when NO_DATA_FOUND then
            null;
    end;
  
	if(v_marginAlgr_b = 1) then  
             --�����Ʒ����˰
            if(v_taxinclusive = 1 ) then --Ӧ�ս��ջ��� =���� * ��Լ���� * �۸� * ���ջ���ϵ�� ���հٷֱ���
            v_margin:=p_quantity*v_contractFactor*p_price*v_marginRate_b;
            else -- ��Ʒ��˰ Ӧ�ս��ջ��� =���� * ��Լ���� * �۸� * ���ջ���ϵ�� * ��Ʒ��˰ϵ��  ���հٷֱ���
             v_margin:=p_quantity*v_contractFactor*p_price*v_marginRate_b*(1/(1+v_addedtax));
             end if;
    elsif(v_marginAlgr_b = 2) then  --Ӧ�ս��ջ��� =���� * ���ջ���ϵ�� ������ֵ��
		v_margin:=p_quantity*v_marginRate_b;
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

