create or replace function FN_T_ComputePayout(
    p_FirmID varchar2,
    p_CommodityID varchar2,
    p_bs_flag        number,
    p_quantity number,
    p_price number
) return number
/****
 * 计算交收货款
 * 返回值 成功返回交收货款;-1 计算所需数据不全;-100 其它错误
****/
as
	v_version varchar2(10):='1.0.0.1';
    v_marginRate_b         number(10,4);
    v_marginAlgr_b         number(2);
    v_contractFactor     number(12,2);
    v_margin             number(15,2) default 0;
begin
    --获取商品信息：合约因子，交收货款系数，交收货款算法
    select PayoutRate,PayoutAlgr,contractfactor
    into v_marginRate_b,v_marginAlgr_b,v_contractFactor
    from T_Commodity where CommodityID=p_CommodityID;

    begin
        --获取特殊的交收货款系数，交收货款算法
        select PayoutRate,PayoutAlgr
    	into v_marginRate_b,v_marginAlgr_b
        from T_A_FirmSettleMargin
        where FirmID=p_FirmID and CommodityID=p_CommodityID;
    exception
        when NO_DATA_FOUND then
            null;
    end;

	if(v_marginAlgr_b = 1) then  --应收交收货款=数量*合约因子*价格*交收货款系数
    	v_margin:=p_quantity*v_contractFactor*p_price*v_marginRate_b;
    elsif(v_marginAlgr_b = 2) then  --应收交收货款=数量*交收货款系数
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

