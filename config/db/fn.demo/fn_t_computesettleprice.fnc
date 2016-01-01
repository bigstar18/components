create or replace function FN_T_ComputeSettlePrice(
    p_CommodityID varchar2,  --商品代码
    p_SettlePriceType number    --计算交收价类型
) return number
/****
 * 计算交收价格
 * 计算交收价类型=2的按开仓价不用计算，直接按持仓明细中开仓价
 * 返回值 成功返回交收价格
****/
as
	v_version varchar2(10):='1.0.2.1';
    v_SettlePrice         number(15,2);
    tradeFundSum         number(15,2);
    tradeQtySum  number(10);
    v_BeforeDays  number(4);
    v_SettleDate date;
    v_Quantity  number(10);
    i            number(4);
    v_num            number(10);
begin
	if(p_SettlePriceType = 0) then  --按交收日的闭市结算价
	    --找出交收日的行情结算价
	    begin
	    	select nvl(Price,0) into v_SettlePrice from T_Quotation where CommodityID=p_CommodityID;
	    exception
	        when NO_DATA_FOUND then
           begin
	            select nvl(Price,0) into v_SettlePrice from T_H_Quotation where CommodityID=p_CommodityID and ClearDate in(select max(ClearDate) from T_H_Quotation where CommodityID=p_CommodityID);
	        exception
	        when NO_DATA_FOUND then
           return 0;
           end;
      end;
	elsif(p_SettlePriceType = 1) then  --按交收日前几日的闭市结算价的加权平均价
		--找出提前日，交收日期
	    select SettleDate,BeforeDays into v_SettleDate,v_BeforeDays from T_Commodity where CommodityID=p_CommodityID;
        tradeQtySum := 0;
        tradeFundSum := 0;
        --判断是否资金结算完成，不根据状态，因为重做结算时状态会变化
        --如果资金结算完成的话当前成交会删除，从而导致当天的价格没有参与计算 2010-05-24 by chenxc
        select count(*) into v_num from T_H_Quotation where CommodityID=p_CommodityID and ClearDate = v_SettleDate;
        if(v_num = 0) then
		    --从当前表中计算交收金额和数量
		    begin
		    	select nvl(Price,0) into v_SettlePrice from T_Quotation where CommodityID=p_CommodityID;
		    	select nvl(sum(Quantity),0) into v_Quantity from T_Trade where CommodityID=p_CommodityID;
		    	tradeFundSum := tradeFundSum + v_SettlePrice*v_Quantity;
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
		    	select nvl(Price,0) into v_SettlePrice from T_H_Quotation where CommodityID=p_CommodityID and ClearDate = v_SettleDate-i;
		    	select nvl(sum(Quantity),0) into v_Quantity from T_H_Trade where CommodityID=p_CommodityID and ClearDate = v_SettleDate-i;
		    	tradeFundSum := tradeFundSum + v_SettlePrice*v_Quantity;
		    	tradeQtySum := tradeQtySum + v_Quantity;
		    exception
		        when NO_DATA_FOUND then
		            v_BeforeDays := v_BeforeDays + 1;
		    end;
            i := i+1;
        end loop;
        --计算加权平均价，如果数量为0的话则用上面查出的交收价
		if(tradeQtySum <> 0) then
        	v_SettlePrice := round(tradeFundSum/tradeQtySum,0);
        end if;
	elsif(p_SettlePriceType = 3) then  --按指定交收价
		select SpecSettlePrice into v_SettlePrice from T_Commodity where CommodityID=p_CommodityID;
    end if;
    return v_SettlePrice;
end;
/

