create or replace function FN_T_ComputeSettleMargin(
    p_FirmID varchar2,
    p_CommodityID varchar2,
    p_bs_flag        number,
    p_quantity number,
    p_price number
) return number
/****
 * 计算交收保证金
 * 返回值 成功返回交收保证金;-1 计算所需数据不全;-100 其它错误
****/
as
	v_version varchar2(10):='1.0.0.1';
    v_marginRate_b         number(10,4);
    v_marginRate_s         number(10,4);
    v_marginAlgr_b         number(2);
    v_marginAlgr_s         number(2);
    v_contractFactor     number(12,2);
    v_margin             number(15,2) default 0;
    v_settleMarginType number;   --交收保证金计算方式
    v_BeforeDays number;   --提前几日
    v_price number;
    tradeFundSum         number(15,2);
    tradeQtySum  number(10);
    v_SettleDate date;
    v_num            number(10);
    v_Quantity  number(10);
    i            number(4);
begin
select settleMargintype into v_settleMarginType from t_commodity where commodityid=p_CommodityID;--查询交收保证金计算方式  add by lizhenli 2011-12-5
if(v_settleMarginType = 0) then  --按交收日的闭市结算价
	    --找出交收日的行情结算价
	    begin
	    	select nvl(Price,0) into v_price from T_Quotation where CommodityID=p_CommodityID;
	    exception
	        when NO_DATA_FOUND then
	            select nvl(Price,0) into v_price from T_H_Quotation where CommodityID=p_CommodityID and ClearDate in(select max(ClearDate) from T_H_Quotation where CommodityID=p_CommodityID);
	    end;
      elsif(v_settleMarginType = 1) then  --按交收日前几日的闭市结算价的加权平均价
		--找出提前日，交收日期
	    select SettleDate,BeforeDays_M into v_SettleDate,v_BeforeDays from T_Commodity where CommodityID=p_CommodityID;
        tradeQtySum := 0;
        tradeFundSum := 0;
        --判断是否资金结算完成，不根据状态，因为重做结算时状态会变化
        --如果资金结算完成的话当前成交会删除，从而导致当天的价格没有参与计算 2010-05-24 by chenxc
        select count(*) into v_num from T_H_Quotation where CommodityID=p_CommodityID and ClearDate = v_SettleDate;
        if(v_num = 0) then
		    --从当前表中计算交收金额和数量
		    begin
		    	select nvl(Price,0) into v_price from T_Quotation where CommodityID=p_CommodityID;
		    	select nvl(sum(Quantity),0) into v_Quantity from T_Trade where CommodityID=p_CommodityID;
		    	tradeFundSum := tradeFundSum + v_price*v_Quantity;
				tradeQtySum := tradeQtySum + v_Quantity;
		    	i := 1;
		    exception
		        when NO_DATA_FOUND then
		           i := 0;
		    end;
        else
			i := 0;
		end if;
	    --循环计算交收日前的v_BeforeDays的金额和数量，包括交收日当天的v_BeforeDays的交易日期
        while i<v_BeforeDays loop
        	--加上下面的判断是表示如果设置的提前几日的加权价的天数大于实际的交易天数时不造成循环超出变量的范围，也即是设置的天数大于交易天数则按交易天数计算加权价格
            if(v_BeforeDays>=999 or i>=999) then
            	exit;
   			end if;
		    --从历史表中计算交收金额和数量
		    begin
		    	select nvl(Price,0) into v_price from T_H_Quotation where CommodityID=p_CommodityID and ClearDate = v_SettleDate-i;
		    	select nvl(sum(Quantity),0) into v_Quantity from T_H_Trade where CommodityID=p_CommodityID and ClearDate = v_SettleDate-i;
		    	tradeFundSum := tradeFundSum + v_price*v_Quantity;
		    	tradeQtySum := tradeQtySum + v_Quantity;
		    exception
		        when NO_DATA_FOUND then
		            v_BeforeDays := v_BeforeDays + 1;
		    end;
            i := i+1;
        end loop;
        --计算加权平均价，如果数量为0的话则用上面查出的交收价
		if(tradeQtySum <> 0) then
        	v_price := round(tradeFundSum/tradeQtySum,0);
        end if;

        else   --如果按订立价。则使用传递过来的价格
        v_price:=p_price;
     end if;
    --获取商品信息：合约因子，交收保证金系数，交收保证金算法
    select Settlemarginrate_b,Settlemarginrate_s,SettleMarginAlgr_B,SettleMarginAlgr_S,contractfactor
    into v_marginRate_b,v_marginRate_s,v_marginAlgr_b,v_marginAlgr_s,v_contractFactor
    from T_Commodity where CommodityID=p_CommodityID;

    begin
        --获取特殊的交收保证金系数，交收保证金算法
        select Settlemarginrate_b,Settlemarginrate_s,SettleMarginAlgr_B,SettleMarginAlgr_S
    	into v_marginRate_b,v_marginRate_s,v_marginAlgr_b,v_marginAlgr_s
        from T_A_FirmSettleMargin
        where FirmID=p_FirmID and CommodityID=p_CommodityID;
    exception
        when NO_DATA_FOUND then
            null;
    end;
    --交收保证金算法分买卖
    if(p_bs_flag = 1) then  --买
		if(v_marginAlgr_b = 1) then  --应收交收保证金=数量*合约因子*价格*交收保证金系数
			if(v_marginRate_b = -1) then --  -1表示收全款
				v_margin:=p_quantity*v_contractFactor*v_price;
			else
        		v_margin:=p_quantity*v_contractFactor*v_price*v_marginRate_b;
        	end if;
        elsif(v_marginAlgr_b = 2) then  --应收交收保证金=数量*交收保证金系数
			if(v_marginRate_b = -1) then --  -1表示收全款
				v_margin:=p_quantity*v_contractFactor*v_price;
			else
				v_margin:=p_quantity*v_marginRate_b;
			end if;
        end if;
    elsif(p_bs_flag = 2) then  --卖
    	if(v_marginAlgr_s = 1) then  --应收交收保证金=数量*合约因子*价格*交收保证金系数
			if(v_marginRate_s = -1) then --  -1表示收全款
				v_margin:=p_quantity*v_contractFactor*v_price;
			else
        		v_margin:=p_quantity*v_contractFactor*v_price*v_marginRate_s;
        	end if;
        elsif(v_marginAlgr_s = 2) then  --应收交收保证金=数量*交收保证金系数
			if(v_marginRate_s = -1) then --  -1表示收全款
				v_margin:=p_quantity*v_contractFactor*v_price;
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

