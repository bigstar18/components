CREATE OR REPLACE FUNCTION FN_T_D_ChgFirmMarginByQty
(
  p_FirmID varchar2,   --交易客户代码
  p_CommodityID varchar2, --商品代码
  p_BS_Flag        number, --买卖标志
  p_TradeQty       number     --数量
)  return number
/***
 * 更新临时保证金和临时担保金，根据数量平均分配金额
 *
 * 返回值：1成功
 ****/
is
  v_version varchar2(10):='1.0.2.2';
  v_HoldMargin    number(15,2);
  v_HoldAssure    number(15,2);
begin
    --更改交易商持仓合计表中的持仓记录
    select HoldMargin*p_TradeQty/holdqty,HoldAssure*p_TradeQty/holdqty into v_HoldMargin,v_HoldAssure from T_FirmHoldSum
    where FirmID = p_FirmID
      and CommodityID = p_CommodityID
      and bs_flag = p_BS_Flag;
    --更新临时保证金和临时担保金
    update T_Firm
    set runtimemargin = runtimemargin - v_HoldMargin,
	    RuntimeAssure = RuntimeAssure - v_HoldAssure
    where Firmid = p_FirmID;
    return v_HoldMargin-v_HoldAssure;
end;
/

