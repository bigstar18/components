create or replace function FN_T_D_ChargeDelayFund(
	p_CommodityID    varchar2, --商品代码
	p_BS_Flag        number, --收取延期费方向；1买2卖
    p_DelayFunds     number   --延期补偿费
) return number
/****
 * 收取交易商延期补偿费
 * 返回收取的交易商延期补偿费
 * 根据配置，修改收取交易商补偿费时是按净订货量还是单边订货量（不包含中立仓的数量）来计算 by chenxc 2011-09-21
****/
as
	v_version varchar2(10):='1.0.2.2';
	v_TradeDate date;
    v_NotOrderQtySum        number(10);   --未申报订货总量
    v_DelayFundOneInit    number(15,4);   --某交易商应缴延期费，未进位
    v_DelayFundOne    number(15,2);   --某交易商应缴延期费，进位精确到分
    v_DelayFunds      number(15,2):=0;   --延期补偿费合计
    v_Balance      number(15,2);   --可用资金
    v_NotOrderQtyOne       number(10); --交易商未申报订货量
	v_ChargeDelayFeeType       number(2); --收取延期补偿金类型
begin
	--1、获取结算日期
	select TradeDate into v_TradeDate from T_SystemStatus;
	--收取延期补偿金类型字段，0按净订货量收取（默认）；1按单边订货总量收取
	select ChargeDelayFeeType into v_ChargeDelayFeeType from T_A_Market;
	--2、查询未申报订货总量
	--根据配置，修改收取交易商补偿费时是按净订货量还是单边订货量（不包含中立仓的数量）来计算 by chenxc 2011-09-21
	select decode(v_ChargeDelayFeeType,1,
		nvl(sum(
			decode(p_BS_Flag,1,BuyCleanQty,SellCleanQty)),0)
		,
		nvl(sum(
			decode(p_BS_Flag,1,
			case when BuyCleanQty-SellCleanQty<=0 then 0 else BuyCleanQty-SellCleanQty end,
			case when SellCleanQty-BuyCleanQty<=0 then 0 else SellCleanQty-BuyCleanQty end
			)
		),0))
	into v_NotOrderQtySum
	from
	(
		select (a.BuyQty-nvl(b.BuyNeutralQty,0)-nvl(c.BuyNotTradeQty,0)) BuyCleanQty,(a.SellQty-nvl(b.SellNeutralQty,0)-nvl(c.SellNotTradeQty,0)) SellCleanQty
		from
			(select FirmID,nvl(sum(decode(BS_Flag,1,HoldQty+GageQty,0)),0) BuyQty,nvl(sum(decode(BS_Flag,2,HoldQty+GageQty,0)),0) SellQty
			from T_FirmHoldSum
			where CommodityID=p_CommodityID
			group by FirmID) a,
			(select FirmID,nvl(sum(decode(BS_Flag,1,HoldQty+GageQty,0)),0) BuyNeutralQty,nvl(sum(decode(BS_Flag,2,HoldQty+GageQty,0)),0) SellNeutralQty
			from T_HoldPosition
			where CommodityID=p_CommodityID and AtClearDate=v_TradeDate and HoldType=2
			group by FirmID) b,
			(select FirmID,nvl(sum(decode(BS_Flag,1,Quantity-TradeQty,0)),0) BuyNotTradeQty,nvl(sum(decode(BS_Flag,2,Quantity-TradeQty,0)),0) SellNotTradeQty
			from T_DelayOrders
			where CommodityID=p_CommodityID and DelayOrderType=1 and Status in(5,6) and WithdrawType=4
			group by FirmID) c
		where a.FirmID=b.FirmID(+) and a.FirmID=c.FirmID(+)
	);
	--2.5、更新延期行情的净订货量
	update T_DelayQuotation set DelayCleanHoldQty=v_NotOrderQtySum where CommodityID=p_CommodityID;
	--3、计算某交易商应缴补偿金＝总补偿费÷未申报订货总量×此交易商未申报订货量，采用小数进整的原则，精确到分
    for cur_DelayFund in(
		select a.FirmID,(a.BuyQty-nvl(b.BuyNeutralQty,0)-nvl(c.BuyNotTradeQty,0)) BuyCleanQty,(a.SellQty-nvl(b.SellNeutralQty,0)-nvl(c.SellNotTradeQty,0)) SellCleanQty
		from
			(select FirmID,nvl(sum(decode(BS_Flag,1,HoldQty+GageQty,0)),0) BuyQty,nvl(sum(decode(BS_Flag,2,HoldQty+GageQty,0)),0) SellQty
			from T_FirmHoldSum
			where CommodityID=p_CommodityID
			group by FirmID) a,
			(select FirmID,nvl(sum(decode(BS_Flag,1,HoldQty+GageQty,0)),0) BuyNeutralQty,nvl(sum(decode(BS_Flag,2,HoldQty+GageQty,0)),0) SellNeutralQty
			from T_HoldPosition
			where CommodityID=p_CommodityID and AtClearDate=v_TradeDate and HoldType=2
			group by FirmID) b,
			(select FirmID,nvl(sum(decode(BS_Flag,1,Quantity-TradeQty,0)),0) BuyNotTradeQty,nvl(sum(decode(BS_Flag,2,Quantity-TradeQty,0)),0) SellNotTradeQty
			from T_DelayOrders
			where CommodityID=p_CommodityID and DelayOrderType=1 and Status in(5,6) and WithdrawType=4
			group by FirmID) c
		where a.FirmID=b.FirmID(+) and a.FirmID=c.FirmID(+)
    )
    loop
    	--根据配置，修改收取交易商补偿费时是按净订货量还是单边订货量（不包含中立仓的数量）来计算 by chenxc 2011-09-21
		if(v_ChargeDelayFeeType = 1) then
	    	if(p_BS_Flag = 1) then
				v_NotOrderQtyOne := cur_DelayFund.BuyCleanQty;
			else
				v_NotOrderQtyOne := cur_DelayFund.SellCleanQty;
			end if;
		else
	    	if(p_BS_Flag = 1) then
				if(cur_DelayFund.BuyCleanQty-cur_DelayFund.SellCleanQty<=0) then
					v_NotOrderQtyOne := 0;
				else
					v_NotOrderQtyOne := cur_DelayFund.BuyCleanQty-cur_DelayFund.SellCleanQty;
				end if;
			else
				if(cur_DelayFund.SellCleanQty-cur_DelayFund.BuyCleanQty<=0) then
					v_NotOrderQtyOne := 0;
				else
					v_NotOrderQtyOne := cur_DelayFund.SellCleanQty-cur_DelayFund.BuyCleanQty;
				end if;
			end if;
		end if;
		if(v_NotOrderQtyOne > 0) then
			--某交易商应缴补偿金＝总补偿费÷未申报订货总量×此交易商未申报订货量,采用小数进整的原则，精确到分
			v_DelayFundOneInit := p_DelayFunds/v_NotOrderQtySum*v_NotOrderQtyOne;
			v_DelayFundOne := trunc(v_DelayFundOneInit,2);
			if(v_DelayFundOneInit > v_DelayFundOne) then
				v_DelayFundOne := v_DelayFundOne + 0.01;
			end if;
	        --收交易商延期费 ，并写流水
    		v_Balance := FN_F_UpdateFundsFull(cur_DelayFund.FirmID,'15020',v_DelayFundOne,null,p_CommodityID,null,null);
    		v_DelayFunds := v_DelayFunds + v_DelayFundOne;
		end if;
    end loop;
	--4、返回总收的延期费
    return v_DelayFunds;
end;
/

