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
 * 根据参数计算手续费
 * 返回值 成功返回手续费;-1 计算交易费用所需数据不全;-100 其它错误
****/
as
	v_version varchar2(10):='1.0.0.1';
    v_fee             number(15,2) default 0;
begin
    if(p_feeAlgr=1) then  --应收手续费=数量*合约因子*价格*手续费
    	if(p_bs_flag = 1) then  --买
        	v_fee:=p_quantity*p_contractFactor*p_price*p_feeRate_b;
        elsif(p_bs_flag = 2) then  --卖
        	v_fee:=p_quantity*p_contractFactor*p_price*p_feeRate_s;
        end if;
    elsif(p_feeAlgr=2) then  --应收手续费=数量*手续费
    	if(p_bs_flag = 1) then  --买
        	v_fee:=p_quantity*p_feeRate_b;
        elsif(p_bs_flag = 2) then  --卖
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

