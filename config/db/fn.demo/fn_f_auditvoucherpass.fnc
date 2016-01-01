create or replace function FN_F_AuditVoucherPass(p_voucherNo number)
return number
/***
 * 审核凭证通过
 *
 * version 1.0.0.3
 *
 * 返回 1 成功 -1 未找到该笔待审核凭证
 ***/
as
  v_cnt number(10);

  v_contractno varchar2(16);
  v_summaryNo f_summary.summaryno%type;
  v_fundDCflag char(1);

  v_firmID varchar2(32);

  v_accountcode varchar2(38);
  v_debitamount number(15,2);
  v_creditamount number(15,2);

  v_amount number(15,2); --发生额
  v_balance number(15,2); --余额

  v_negCount number;

  cursor c_entry is
    select accountcode, debitamount, creditamount from f_voucherentry where voucherno=p_voucherNo and accountcode like '200100%';

begin
  begin
    select contractno,summaryno into v_contractno,v_summaryNo from f_voucher where voucherNo=p_voucherNo and status='auditing' for update;
  exception when NO_DATA_FOUND then
    return -1;
  end;
  select count(*) into v_cnt from f_voucherentry where voucherno=p_voucherNo and accountcode like '200100%';
  if(v_cnt>0) then
    select fundDCflag into v_fundDCflag from f_summary where summaryno=v_summaryNo;
    if(v_fundDCflag<>'D' and v_fundDCflag<>'C') then  --与交易商资金无关凭证
      Raise_application_error(-21003, 'Fund DCflag not defined in F_Summary!'); --未设置业务代码（摘要）资金借贷方向
    else  --有交易商资金变动
      open c_entry;
      loop
        fetch c_entry into v_accountcode,v_debitamount,v_creditamount;
        exit when c_entry%NOTFOUND;
        v_firmid:=substr(v_accountcode,7);

        if(v_fundDCflag='C') then
          v_amount:=v_creditamount-v_debitamount;
        else
          v_amount:=v_debitamount-v_creditamount;
        end if;

        v_balance:=fn_f_updatefundsFull(v_firmid,v_summaryNo,v_amount,v_contractno,null,null,p_voucherNo);

        select count(*) into v_negCount
        from f_firmfunds a,
            (
              select substr(accountCode,7) firmid,sum(creditAmount)-sum(debitAmount) amount
              from f_voucherentry
              where voucherNo=p_voucherNo and accountCode like '2001%' group by accountCode
            ) b
        where  a.firmid = b.firmid and (a.balance - a.frozenfunds)<0 and b.amount<0;
        if(v_negCount>0) then
            rollback;
            return -2;            --造成负值
        end if;
      end loop;
    end if;
  end if;

  --更新凭证状态为已审核
  update f_voucher set status = 'audited',audittime=sysdate where voucherNo = p_voucherNo;

  return 1;
end;
/

