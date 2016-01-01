CREATE OR REPLACE FUNCTION FN_T_UpdateRuntimeSettleMargin
(
  p_FirmID varchar2,   --交易商代码
  p_RuntimeSettleMargin number     --发生额（正值增加，负值减少）
)  return number
/***
 * 更新交易商当日交收保证金
 * version 1.0.0.6
 *
 * 返回值：交易商当日交收保证金
 ****/
is
  v_RuntimeSettleMargin number(15,2);
begin
  update T_Firm set RuntimeSettleMargin=RuntimeSettleMargin + p_RuntimeSettleMargin where FirmID=p_FirmID
  returning RuntimeSettleMargin into v_RuntimeSettleMargin;
  if(SQL%ROWCOUNT = 0) then
    Raise_application_error(-20099, 'FirmID not existed !'); --不存在的交易商代码
  end if;

  return v_RuntimeSettleMargin;
end;
/

