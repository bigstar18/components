create or replace function FN_F_GetRealFunds
(
  p_firmid varchar2,   --交易商代码
  p_lock number      --是否上锁 1:上锁 0：不上锁
) return number
/***
 * 获取可用资金
 * version 1.0.0.1 公用方法
 * 返回值：可用余额
 ****/
is
  v_realfunds number(15,2);
begin
  if(p_lock=1) then
    select balance-frozenfunds into v_realfunds from f_firmfunds where firmid=p_firmid for update;
  else
    select balance-frozenfunds into v_realfunds from f_firmfunds where firmid=p_firmid;
  end if;
  return v_realfunds;
end;
/

