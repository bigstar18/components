create or replace procedure SP_F_ClientLedger(p_beginDate date) as
begin
    --清除开始日期以后的结算
    delete from F_ClientLedger where b_Date >= p_beginDate;

    insert into f_clientledger
      (b_date, firmid, code, value)
    select b_date,substr(accountcode,7),ledgeritem,d.fieldsign*amount from
    (
      select b_date,accountcode,ledgeritem,sum(amount) amount from
      (
        select b_date,debitcode accountcode,ledgeritem, -amount amount
        from f_accountbook a,f_summary b
        where a.summaryno=b.summaryno and a.b_date>=p_beginDate and a.debitcode like '200100%'
        union all
        select b_date,creditcode accountcode,ledgeritem, amount
        from f_accountbook a,f_summary b
        where a.summaryno=b.summaryno and a.b_date>=p_beginDate and a.creditcode like '200100%'
      ) group by b_date,accountcode,ledgeritem
    ) c,f_ledgerfield d
    where c.ledgeritem=d.code;

end;
/

