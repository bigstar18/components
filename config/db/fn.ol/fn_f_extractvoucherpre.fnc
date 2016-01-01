create or replace function FN_F_ExtractVoucherPre
return number
/***
 * 远期结算
 * 返回：-1:远期结算不成功
 *       -2：存在小于等于远期当前结算日的流水，未设结算日
 ***/
as
  v_lastDate date;
  v_beginDate date;
  v_b_date date;
  v_cnt number(10);
  v_rtn varchar2(10);
  v_enabled char(1);
begin
  return 1;
end;
/

