create or replace function FN_F_CreateVoucher(
  p_summaryNo varchar2,
  p_summary varchar2,
  p_debitCode varchar2,
  p_creditCode varchar2,
  p_amount number,
  p_contractno varchar2,
  p_inputUser varchar2
) return number  --凭证号
/**
 * 创建凭证，凭证为编辑状态
 * version 1.0.0.3
 *
 **/
as
  v_level number;
  v_cnt number;
   v_voucherno number;
   v_summary varchar2(32);
begin
  --判断科目是否合法
  select accountlevel into v_level from f_account where code=p_debitCode;

  select count(*) into v_cnt from f_account where code like p_debitCode||'%' and accountlevel>v_level;
  if(v_cnt>0) then
   Raise_application_error(-21004, 'Fund accountcode not a leaf node!'||p_debitCode); --对方科目非叶子科目
  end if;

  select accountlevel into v_level from f_account where code=p_creditCode;

  select count(*) into v_cnt from f_account where code like p_creditCode||'%' and accountlevel>v_level;
  if(v_cnt>0) then
   Raise_application_error(-21004, 'Fund accountcode not a leaf node!'||p_creditCode); --对方科目非叶子科目
  end if;

  --如果没有指定摘要内容，查询出来。
  if(p_summary is null) then
    select summary into v_summary from F_Summary where summaryno=p_summaryNo;
  end if;
  select seq_f_voucher.nextval into v_voucherno from dual;

  --插入凭证
  insert into f_voucher
   (voucherno, summaryno, summary, inputuser, inputtime, status, contractno)
  values
   (v_voucherno, p_summaryNo, p_summary, p_inputUser, sysdate, 'editing', p_contractno);

  insert into f_voucherentry
   (entryid, voucherno, accountcode, debitamount, creditamount)
  values
   (seq_f_voucherentry.nextval, v_voucherno, p_debitCode, p_amount, 0);
  insert into f_voucherentry
   (entryid, voucherno, accountcode, debitamount, creditamount)
  values
   (seq_f_voucherentry.nextval, v_voucherno, p_creditCode, 0, p_amount);

  return v_voucherno;
end;
/

