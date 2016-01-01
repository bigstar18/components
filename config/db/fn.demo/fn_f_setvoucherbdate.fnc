create or replace function FN_F_SetVoucherBDate(
  p_endAuditTime date, --审核时间截止时间
  p_b_date date --归属结算日
)
return number
as
/***
 * 凭证划分结算日
 * version 1.0.0.1
 *
 *
 ****/

  v_cnt number(8):=0;
  v_endAuditTime date;
  v_b_date date;

begin
  v_endAuditTime:=p_endAuditTime;
  if(p_endAuditTime is null) then
    v_endAuditTime:= sysdate;
  end if;
  v_b_date:=p_b_date;
  if(p_b_date is null) then
    v_b_date:= trunc(sysdate);
  end if;

  update f_voucher set b_date=v_b_date where b_date is null and audittime<=v_endAuditTime and status='audited';

  v_cnt:=SQL%ROWCOUNT;

  update f_fundflow set b_date=v_b_date where b_date is null and createtime<=v_endAuditTime;

  return v_cnt;

end;
/

