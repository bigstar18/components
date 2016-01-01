CREATE OR REPLACE FUNCTION FN_T_SubHoldSum
(
  p_HoldQty      number,   --持仓数量
  p_GageQty      number,   --抵数量
  p_Margin      number,   --保证金
  p_Assure      number,   --担保金
  p_CommodityID varchar2, --商品代码
  p_ContractFactor        number, --合约因子
  p_BS_Flag        number, --买卖标志
  p_FirmID varchar2,   --交易商代码
  p_HoldFunds      number,   --交易商持仓金额
  p_CustomerID varchar2,   --交易客户代码
  p_CustomerHoldFunds      number,   --交易客户持仓金额
  p_GageMode number,     --抵顶模式，0全抵顶；1半抵顶
  p_FrozenQty number     --交易客户冻结数量
)  return number
/***
 * 减少交易客户，交易商的持仓合计信息
 *
 * 返回值：1成功
 ****/
is
  v_version varchar2(10):='1.0.0.10';
  v_num   number(10);
begin
    --更改交易客户持仓合计表中的持仓记录
    update T_CustomerHoldSum
    set holdqty = holdqty - p_HoldQty,
        GageQty = GageQty - p_GageQty,
        FrozenQty = FrozenQty - p_FrozenQty,
        holdfunds = holdfunds - p_CustomerHoldFunds,
        HoldMargin = HoldMargin - p_Margin,
        HoldAssure = HoldAssure - p_Assure,
        evenprice = decode((holdqty+GageQty - p_HoldQty-p_GageQty),0,0,(holdfunds - p_CustomerHoldFunds)/((holdqty+GageQty - p_HoldQty-p_GageQty)*p_ContractFactor))
    where CustomerID = p_CustomerID
      and CommodityID = p_CommodityID
      and bs_flag = p_BS_Flag;
    --更改交易商持仓合计表中的持仓记录
    update T_FirmHoldSum
    set holdqty = holdqty - p_HoldQty,
        GageQty = GageQty - p_GageQty,
        holdfunds = holdfunds - p_HoldFunds,
        HoldMargin = HoldMargin - p_Margin,
        HoldAssure = HoldAssure - p_Assure,
        evenprice = decode(p_GageMode,1,decode((holdqty+GageQty - p_HoldQty-p_GageQty),0,0,(holdfunds - p_HoldFunds)/((holdqty+GageQty - p_HoldQty-p_GageQty)*p_ContractFactor)),
        decode((holdqty - p_HoldQty),0,0,(holdfunds - p_HoldFunds)/((holdqty - p_HoldQty)*p_ContractFactor)))
    where Firmid = p_FirmID
      and CommodityID = p_CommodityID
      and bs_flag = p_BS_Flag;

   return 1;
end;
/

