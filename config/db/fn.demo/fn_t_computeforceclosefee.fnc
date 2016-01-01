create or replace function FN_T_ComputeForceCloseFee(
    p_FirmID     varchar2,
    p_CommodityID varchar2,
    p_bs_flag        number,
    p_quantity       number,
    p_price          number
) return number
/****
 * 计算代为转让(即强平)手续费
 * 返回值 成功返回手续费;-1 计算交易费用所需数据不全;-100 其它错误
****/
as
	v_version varchar2(10):='1.0.0.1';
    v_feeRate_b         number(15,9);
    v_feeRate_s         number(15,9);
    v_feeAlgr       number(2);
    v_contractFactor  number(12,2);
    v_fee             number(15,2) default 0;
begin
    --获取商品信息：合约因子，手续费系数，手续费算法。
    select ForceCloseFeeRate_B,ForceCloseFeeRate_S,ForceCloseFeeAlgr,contractfactor
    into v_feeRate_b,v_feeRate_s,v_feeAlgr,v_contractFactor
    from T_Commodity where CommodityID=p_CommodityID;

    begin
        --获取交易商对应套餐手续费系数，手续费算法
        select ForceCloseFeeRate_B,ForceCloseFeeRate_S,ForceCloseFeeAlgr
   		into v_feeRate_b,v_feeRate_s,v_feeAlgr
        from T_A_Tariff
        where TariffID=(select TariffID from t_firm where FirmID=p_FirmID) and CommodityID=p_CommodityID;
    exception
        when NO_DATA_FOUND then
            null;
    end;

    begin
        --获取特户的手续费系数，手续费算法
        select ForceCloseFeeRate_B,ForceCloseFeeRate_S,ForceCloseFeeAlgr
   		into v_feeRate_b,v_feeRate_s,v_feeAlgr
        from T_A_FirmFee
        where FirmID=p_FirmID and CommodityID=p_CommodityID;
    exception
        when NO_DATA_FOUND then
            null;
    end;
    if(v_feeAlgr=1) then  --应收手续费=数量*合约因子*价格*手续费
    	if(p_bs_flag = 1) then  --买
        	v_fee:=p_quantity*v_contractFactor*p_price*v_feeRate_b;
        elsif(p_bs_flag = 2) then  --卖
        	v_fee:=p_quantity*v_contractFactor*p_price*v_feeRate_s;
        end if;
    elsif(v_feeAlgr=2) then  --应收手续费=数量*手续费
    	if(p_bs_flag = 1) then  --买
        	v_fee:=p_quantity*v_feeRate_b;
        elsif(p_bs_flag = 2) then  --卖
        	v_fee:=p_quantity*v_feeRate_s;
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

