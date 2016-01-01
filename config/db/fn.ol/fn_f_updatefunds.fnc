create or replace function FN_F_UpdateFunds
(
  p_firmID varchar2,     --交易商代码
  p_oprcode char,         --业务代码
  p_amount number,       --发生额
  p_contractNo varchar2  --成交合同号
) return number
/***
 * 更新资金
 * version 1.0.0.1 此方法公用
 *
 * 返回值：资金余额
 ****/
is
begin
  return fn_f_updatefundsFull(p_firmid,p_oprcode,p_amount,p_contractNo,null,null,null);
end;
/

