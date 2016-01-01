create or replace function FN_T_D_SellSettleOrder_WD(
    p_FirmID     varchar2,   --交易商ID
    p_CustomerID     varchar2,  --交易客户ID
    p_CommodityID varchar2 ,--商品ID
    p_Quantity       number ,--委托数量
    p_TradeQty       number ,--已成交数量
    p_Price       number ,--委托价格，行情结算价
    p_A_OrderNo_W     number,  --被撤委托单号
    p_quantity_wd       number,  --撤单数量
    p_frozenfunds     number,  --冻结资金
    p_unfrozenfunds       number  --解冻资金
) return number
/****
 * 卖交收申报委托撤单
 * 返回值
 * 1 成功
****/
as
    v_version varchar2(10):='1.0.2.3';
	v_DelayNeedBill number(2);    --延期交收是否需要仓单，0：不需要； 1：需要；
    v_Margin         number(15,2);   --应收保证金
    v_SettleMargin_S    number(15,2);   --卖方交收保证金
    v_to_unfrozenF   number(15,2);
    v_F_FrozenFunds   number(15,2);   --交易商冻结资金
    v_MarginPriceType         number(1);     --计算成交保证金结算价类型 0:实时和闭市时都按开仓价；1:实时按昨结算价，闭市按当日结算价
    v_LastPrice    number(15,2);   --昨结算价
    v_ret  number(4);
begin
	--1、释放剩余的冻结持仓
    update T_CustomerHoldSum set frozenQty = frozenQty - p_quantity_wd
    where CustomerID = p_CustomerID
      and CommodityID = p_CommodityID
      and bs_flag = 2;
	--2、根据参数是否需要释放冻结仓单
	select DelayNeedBill into v_DelayNeedBill from T_A_Market;
	if(v_DelayNeedBill = 1) then
		v_ret := FN_T_D_UnFrozenBill(p_FirmID,p_CommodityID,p_quantity_wd);
	end if;
    --<<Added by Lizs 2010/7/16 卖交收申报时冻结交收保证金，撤单时解冻
    --3、释放剩余的冻结资金，根据未成交数量
    if(p_Quantity - p_TradeQty = p_quantity_wd) then
        v_to_unfrozenF := p_frozenfunds - p_unfrozenfunds;
    else
        --冻结资金：卖方交收保证金-卖方占用的交易保证金
        --计算交收保证金
        v_SettleMargin_S := FN_T_ComputeSettleMargin(p_FirmID,p_CommodityID,2,p_quantity_wd,p_Price);
        --计算交易保证金
        select MarginPriceType,LastPrice
        into v_MarginPriceType,v_LastPrice
        from T_Commodity where CommodityID=p_CommodityID;
        if(v_MarginPriceType = 1) then
            v_Margin := FN_T_ComputeMargin(p_FirmID,p_CommodityID,2,p_quantity_wd,v_LastPrice);
        else
            v_Margin := FN_T_ComputeMargin(p_FirmID,p_CommodityID,2,p_quantity_wd,p_Price);
        end if;
        if(v_Margin < 0) then
            Raise_application_error(-20040, 'computeMargin error');
        end if;
        v_to_unfrozenF := v_SettleMargin_S - v_Margin;
    end if;
    update T_DelayOrders set unfrozenfunds = unfrozenfunds + v_to_unfrozenF
    where A_orderNo = p_a_orderno_w;
    --更新冻结资金
    v_F_FrozenFunds := FN_F_UpdateFrozenFunds(p_FirmID,-v_to_unfrozenF,'15');
    -->>
    return 1;
end;
/

