CREATE OR REPLACE FUNCTION FN_T_D_ChgCustHoldByQty
(
  p_CustomerID varchar2,   --交易客户代码
  p_CommodityID varchar2, --商品代码
  p_BS_Flag        number, --买卖标志
  p_TradeQty number     --数量
)  return number
/***
 * 更新交易客户持仓合计信息，根据数量平均分配金额
 *
 * 返回值：1成功
 ****/
is
  v_version varchar2(10):='1.0.2.2';
  v_ContractFactor    number(12,2);
begin
    --更改交易客户持仓合计表中的持仓记录
    update T_CustomerHoldSum
    set holdqty = holdqty - p_TradeQty,
        FrozenQty = FrozenQty - decode(sign(p_TradeQty),-1,0,p_TradeQty), --当p_TradeQty<0时，不需要冻结数量，mod by lizs
        holdfunds = holdfunds - (holdfunds*p_TradeQty/holdqty),
        HoldMargin = HoldMargin - (HoldMargin*p_TradeQty/holdqty),
        HoldAssure = HoldAssure - (HoldAssure*p_TradeQty/holdqty)
    where CustomerID = p_CustomerID
      and CommodityID = p_CommodityID
      and bs_flag = p_BS_Flag;
    select ContractFactor into v_ContractFactor from T_Commodity where CommodityID = p_CommodityID;
    update T_CustomerHoldSum
    set EvenPrice = decode(HoldQty+GageQty,0,0,HoldFunds/((HoldQty+GageQty)*v_ContractFactor))
    where CustomerID = p_CustomerID
      and CommodityID = p_CommodityID
      and bs_flag = p_BS_Flag;

   return 1;
end;
/

