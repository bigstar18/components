create or replace function FN_T_ComputeFloatingLoss(
    p_EvenPrice         number, --持仓均价
    p_Price         number, --行情价
    p_HoldQty number, --持仓数量
    p_ContractFactor    number, --合约因子
    p_BS_Flag number --买卖标志
) return number
/****
 * 计算浮动亏损
 * 返回值 成功返回浮动亏损
****/
as
	v_version varchar2(10):='1.0.0.1';
    v_FL_new number(15,2) default 0;
begin
    --计算浮亏
    v_FL_new := (p_EvenPrice-p_Price)*p_HoldQty*p_ContractFactor;
    --浮亏分买卖来判断，如果浮赢时则置为0
    if(p_BS_Flag = 1) then
        if(v_FL_new < 0) then
          v_FL_new := 0;
        end if;
    else
        if(v_FL_new > 0) then
          v_FL_new := 0;
        end if;
    end if;
    if(v_FL_new < 0) then
      v_FL_new := -v_FL_new;
    end if;
    return v_FL_new;
end;
/

