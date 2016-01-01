create or replace function FN_T_D_BuyNeutralOrder_WD(
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
 * 中立仓买委托撤单，该函数不可以执行提交和回滚操作
 * 返回值
 * 1  成功
****/
as
  v_version varchar2(10):='1.0.0.0';
  v_Payout_B    number(15,2);   --买方交收货款
  v_SettleMargin    number(15,2);   --买方交收保证金
  v_to_unfrozenF   number(15,2);
  v_F_FrozenFunds   number(15,2);   --交易商冻结资金
  v_HoldFunds   number(15,2);   --交易商反向持仓保证金
begin
  --1. 释放剩余的冻结资金，根据未成交数量
  if(p_Quantity - p_TradeQty = p_quantity_wd) then
    v_to_unfrozenF := p_frozenfunds - p_unfrozenfunds;
  else
    --冻结资金：
    --买方冻结资金：买方货款＋买方交收保证金＋反向持仓保证金
    v_Payout_B := FN_T_ComputePayout(p_FirmID,p_CommodityID,1,p_quantity_wd,p_Price);
    --计算交收保证金
    v_SettleMargin := FN_T_ComputeSettleMargin(p_FirmID,p_CommodityID,1,p_quantity_wd,p_Price);
    --计算反向持仓保证金
    v_HoldFunds := FN_T_ComputeMargin(p_FirmID,p_CommodityID,2,p_quantity_wd,p_Price);
    --应冻结资金
    v_to_unfrozenF := v_Payout_B + v_SettleMargin + v_HoldFunds;
  end if;
  update T_DelayOrders set unfrozenfunds = unfrozenfunds + v_to_unfrozenF
  where A_orderNo = p_a_orderno_w;
  --2. 更新交易商财务冻结资金
  v_F_FrozenFunds := FN_F_UpdateFrozenFunds(p_FirmID,-v_to_unfrozenF,'15');

  return 1;
end;
/

