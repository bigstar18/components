create or replace function FN_T_ComputeFloatingProfit(
    p_EvenPrice         number, --持仓均价
    p_Price         number, --行情价
    p_HoldQty number, --持仓数量
    p_ContractFactor    number, --合约因子
    p_BS_Flag number --买卖标志
) return number
/****
 * 计算浮动盈亏
 * 返回值 成功返回浮动盈亏
****/
as
	v_version varchar2(10):='1.0.0.1';
    v_FL_new number(15,2) default 0;
begin
    --计算浮动盈亏
    if(p_BS_Flag = 1) then
      v_FL_new := (p_Price-p_EvenPrice)*p_HoldQty*p_ContractFactor;
    else
      v_FL_new := (p_EvenPrice-p_Price)*p_HoldQty*p_ContractFactor;
    end if;
    return v_FL_new;
end;
/

