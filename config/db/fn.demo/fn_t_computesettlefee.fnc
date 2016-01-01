create or replace function FN_T_ComputeSettleFee(
    p_FirmID     varchar2,
    p_CommodityID varchar2,
    p_bs_flag        number,
    p_quantity       number,
    p_price          number
) return number
/****
 * 计算交收手续费
 * 返回值 成功返回手续费;-1 计算交易费用所需数据不全;-100 其它错误
****/
as
	v_version varchar2(10):='1.0.0.1';
    v_feeRate_b         number(15,9);
    v_feeRate_s         number(15,9);
    v_feeAlgr       number(2);
    v_contractFactor  number(12,2);
    v_LowestSettleFee             number(15,2) default 0;
    v_fee             number(15,2) default 0;
begin
    --获取商品信息：合约因子，手续费系数，手续费算法。
    select SettleFeeRate_B,SettleFeeRate_S,SettleFeeAlgr,contractfactor,LowestSettleFee
    into v_feeRate_b,v_feeRate_s,v_feeAlgr,v_contractFactor,v_LowestSettleFee
    from T_Commodity where CommodityID=p_CommodityID;

    begin
        --获取特户的手续费系数，手续费算法
        select SettleFeeRate_B,SettleFeeRate_S,SettleFeeAlgr
   		into v_feeRate_b,v_feeRate_s,v_feeAlgr
        from T_A_FirmSettleFee
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
    --交收手续费和最低交收手续费取最大者，
    --2009-07-06改成不比较了，直接返回计算的手续费，让函数外围去比较
	/*
    if(v_fee >= v_LowestSettleFee) then
        return v_fee;
	else
	    return v_LowestSettleFee;
    end if;
    */
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

