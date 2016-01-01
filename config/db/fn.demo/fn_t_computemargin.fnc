create or replace function FN_T_ComputeMargin(
    p_FirmID varchar2,
    p_CommodityID varchar2,
    p_bs_flag        number,
    p_quantity number,
    p_price number
) return number
/****
 * 计算保证金
 * 返回值 成功返回保证金;-1 计算所需数据不全;-100 其它错误
****/
as
	v_version varchar2(10):='1.0.0.1';
    v_marginRate_b         number(10,4);
    v_marginRate_s         number(10,4);
    v_marginAlgr         number(2);
    v_contractFactor     number(12,2);
    v_margin             number(15,2) default 0;
begin
    --获取商品信息：合约因子，交易保证金，保证金算法
    select marginrate_b,marginrate_s,marginalgr,contractfactor
    into v_marginRate_b,v_marginRate_s,v_marginAlgr,v_contractFactor
    from T_Commodity where CommodityID=p_CommodityID;

    begin
        --获取特户的交易保证金，保证金算法
        select marginrate_b,marginrate_s,marginalgr
    	into v_marginRate_b,v_marginRate_s,v_marginAlgr
        from T_A_FirmMargin
        where FirmID=p_FirmID and CommodityID=p_CommodityID;
    exception
        when NO_DATA_FOUND then
            null;
    end;
    if(v_marginAlgr=1) then  --应收保证金=数量*合约因子*价格*保证金
    	if(p_bs_flag = 1) then  --买
		    if(v_marginRate_b = -1) then --  -1表示收全款
		    	v_margin:=p_quantity*v_contractFactor*p_price;
		    else
			    v_margin:=p_quantity*v_contractFactor*p_price*v_marginRate_b;
		    end if;
        elsif(p_bs_flag = 2) then  --卖
		    if(v_marginRate_s = -1) then --  -1表示收全款
		    	v_margin:=p_quantity*v_contractFactor*p_price;
		    else
			    v_margin:=p_quantity*v_contractFactor*p_price*v_marginRate_s;
		    end if;
        end if;
    elsif(v_marginAlgr=2) then  --应收保证金=数量*保证金
    	if(p_bs_flag = 1) then  --买
		    if(v_marginRate_b = -1) then --  -1表示收全款
		    	v_margin:=p_quantity*v_contractFactor*p_price;
		    else
			    v_margin:=p_quantity*v_marginRate_b;
		    end if;
        elsif(p_bs_flag = 2) then  --卖
		    if(v_marginRate_s = -1) then --  -1表示收全款
		    	v_margin:=p_quantity*v_contractFactor*p_price;
		    else
			    v_margin:=p_quantity*v_marginRate_s;
		    end if;
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

