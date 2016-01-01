create or replace function FN_T_ComputeAssureByArgs(
    p_bs_flag        number,
    p_quantity number,
    p_price number,
    p_contractFactor        number,
    p_marginAlgr number,
    p_marginRate_b number,
    p_marginRate_s number
) return number
/****
 * 根据参数计算担保金
 * 返回值 成功返回担保金;-1 计算所需数据不全;-100 其它错误
****/
as
	v_version varchar2(10):='1.0.0.1';
    v_margin             number(15,2) default 0;
begin
    if(p_marginAlgr=1) then  --应收保证金=数量*合约因子*价格*担保金
    	if(p_bs_flag = 1) then  --买
        	v_margin:=p_quantity*p_contractFactor*p_price*p_marginRate_b;
        elsif(p_bs_flag = 2) then  --卖
        	v_margin:=p_quantity*p_contractFactor*p_price*p_marginRate_s;
        end if;
    elsif(p_marginAlgr=2) then  --应收保证金=数量*担保金
    	if(p_bs_flag = 1) then  --买
        	v_margin:=p_quantity*p_marginRate_b;
        elsif(p_bs_flag = 2) then  --卖
        	v_margin:=p_quantity*p_marginRate_s;
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

