create or replace function FN_T_D_PayDelayFund(
	p_CommodityID    varchar2, --商品代码
    p_DelayFunds     number   --延期补偿费
) return number
/****
 * 付交易商延期补偿费
 * 返回付交易商的延期补偿费
****/
as
	v_version varchar2(10):='1.0.2.2';
    v_OrderQtySum        number(10);   --总量
    v_DelayFundOneInit    number(15,4);   --某交易商应付延期费，未化零
    v_DelayFundOne    number(15,2);   --某交易商应付延期费，化零精确到分
    v_DelayFunds      number(15,2):=0;   --延期补偿费合计
    v_Balance      number(15,2);   --可用资金
    v_OrderQtyOne       number(10); --交易商量
begin
	--1、计算应得补偿费的总数量
	select nvl(sum(DiffQty),0)
	into v_OrderQtySum
    from
    (
    	(select nvl(sum(Quantity-TradeQty),0) DiffQty from T_DelayOrders where DelayOrderType=1 and Status in(5,6) and WithdrawType=4 and CommodityID=p_CommodityID) union all
        (select nvl(sum(TradeQty),0) DiffQty from T_DelayOrders where DelayOrderType=2 and CommodityID=p_CommodityID)
    );

	--2、申报后未能交收的交易商和参与中立仓成交的交易商按量平均分配总补偿费
    for cur_DelayFund in(
		select FirmID,nvl(sum(DiffQty),0) DiffQty
		from
		(
			(select FirmID,nvl(sum(Quantity-TradeQty),0) DiffQty from T_DelayOrders where DelayOrderType=1 and Status in(5,6) and WithdrawType=4 and CommodityID=p_CommodityID group by FirmID) union all
			(select FirmID,nvl(sum(TradeQty),0) DiffQty from T_DelayOrders where DelayOrderType=2 and CommodityID=p_CommodityID group by FirmID)
		)
		group by FirmID
    )
    loop
    	v_OrderQtyOne := cur_DelayFund.DiffQty;
		if(v_OrderQtyOne > 0) then
			--某交易商应补补偿金＝总补偿费÷总数量×此交易商应得数量,采用小数化零的原则，精确到分
			v_DelayFundOneInit := p_DelayFunds/v_OrderQtySum*v_OrderQtyOne;
			v_DelayFundOne := trunc(v_DelayFundOneInit,2);
	        --付交易商延期费 ，并写流水
    		v_Balance := FN_F_UpdateFundsFull(cur_DelayFund.FirmID,'15021',v_DelayFundOne,null,p_CommodityID,null,null);
    		v_DelayFunds := v_DelayFunds + v_DelayFundOne;
		end if;
    end loop;
	--3、返回总补的延期费
    return v_DelayFunds;
end;
/

