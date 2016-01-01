CREATE OR REPLACE FUNCTION FN_T_D_ChgFirmHoldByQty
(
  p_FirmID varchar2,   --交易客户代码
  p_CommodityID varchar2, --商品代码
  p_BS_Flag        number, --买卖标志
  p_TradeQty       number,     --数量
  p_GageMode       number     --数量
)  return number
/***
 * 更新交易商持仓合计信息，根据数量平均分配金额
 *
 * 返回值：1成功
 ****/
is
  v_version varchar2(10):='1.0.2.2';
  v_ContractFactor    number(12,2);
begin
    --更改交易商持仓合计表中的持仓记录
    update T_FirmHoldSum
    set holdqty = holdqty - p_TradeQty,
        holdfunds = holdfunds - (holdfunds*p_TradeQty/holdqty),
        HoldMargin = HoldMargin - (HoldMargin*p_TradeQty/holdqty),
        HoldAssure = HoldAssure - (HoldAssure*p_TradeQty/holdqty)
    where FirmID = p_FirmID
      and CommodityID = p_CommodityID
      and bs_flag = p_BS_Flag;
    select ContractFactor into v_ContractFactor from T_Commodity where CommodityID = p_CommodityID;
    update T_FirmHoldSum
    set EvenPrice = decode(p_GageMode,1,decode(HoldQty+GageQty,0,0,HoldFunds/((HoldQty+GageQty)*v_ContractFactor)),
        decode(HoldQty,0,0,HoldFunds/((HoldQty)*v_ContractFactor)))
    where FirmID = p_FirmID
      and CommodityID = p_CommodityID
      and bs_flag = p_BS_Flag;

   return 1;
end;
/

