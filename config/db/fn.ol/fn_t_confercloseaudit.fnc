create or replace function FN_T_ConferCloseAudit(
    p_ID            varchar2,       --协议交收ID
    p_CommodityID   varchar2,       --商品代码
    p_bCustomerID   varchar2,       --买方交易客户ID
    p_sCustomerID   varchar2,       --卖方交易客户ID
    p_price         number,         --价格
    p_quantity      number          --数量
) return number
/****
 * 协议交收审核
 * 返回值
 * 1 成功
 * -1  可平仓买持仓数量不足
 * -3  平仓买持仓数量大于可平仓买持仓数量
 * -11  可平仓卖持仓数量不足
 * -13  平仓卖持仓数量大于可平仓卖持仓数量
 * -21  解冻持仓失败
 * -100 其它错误
****/
as
     v_ret          number(5):=0;
begin
     --解冻持仓合计表持仓
     --1.客户持仓合计表(买方)
     --update t_customerholdsum set frozenQty=frozenQty-p_quantity where commodityid = p_CommodityID and customerid = p_bCustomerID and bs_flag = 1;
     --2.客户持仓合计表(卖方)
     --update t_customerholdsum set frozenQty=frozenQty-p_quantity where commodityid = p_CommodityID and customerid = p_sCustomerID and bs_flag = 2;
     --解冻持仓冻结表
     delete T_Holdfrozen where Operation = p_ID and frozentype = 1;
     --修改审核状态
     update T_E_ApplyTreatySettle set Status = 2,modifytime = sysdate where ApplyID = p_ID;

     v_ret := FN_T_ConferClose(p_CommodityID,p_price,p_bCustomerID,p_quantity,0,p_sCustomerID,p_quantity,0);
     return v_ret;
exception
    when OTHERS then
    rollback;
    return -21;
end;
/

