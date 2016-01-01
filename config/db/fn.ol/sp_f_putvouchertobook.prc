create or replace procedure SP_F_PutVoucherToBook(p_beginDate date) as
begin
     --清除开始日期以后的帐簿
     delete from f_accountbook where b_Date>=p_beginDate;
     --将凭证记入会计账簿
     insert into f_accountbook
     (b_date,summaryno,summary,voucherno,debitcode,creditcode,amount,contractno)
      select a.b_date,a.summaryNo,a.summary,a.voucherno,a.accountcode,b.accountcode,
          case
            when (m.debitcount=n.creditcount) then a.debitamount
            when (m.debitcount<n.creditcount) then b.creditamount
            else a.debitamount
          end amount,a.contractno
      from (  select v.b_date,v.summaryNo,v.summary,v.voucherno,v.contractno,v.audittime,ve.accountcode,ve.debitamount
              from f_voucher v,f_voucherentry ve
              where v.b_date>=p_beginDate and v.voucherno=ve.voucherNo and ve.debitamount<>0
            ) a,
           (  select v.voucherno,ve.accountcode,ve.creditamount
              from f_voucher v,f_voucherentry ve
              where v.b_date>=p_beginDate and v.voucherno=ve.voucherNo and ve.creditamount<>0
            ) b,
           (  select ve.voucherno,count(1) debitcount
              from f_voucherentry ve,f_voucher v
              where ve.voucherno=v.voucherno
                and v.b_date>=p_beginDate and debitamount<>0
              group by ve.voucherno
            ) m,
           (  select ve.voucherno,count(1) creditcount
              from f_voucherentry ve,f_voucher v
              where ve.voucherno=v.voucherno
                and v.b_date>=p_beginDate and creditamount<>0
              group by ve.voucherno
            ) n
      where a.voucherno = b.voucherno and a.voucherno=m.voucherno and a.voucherno=n.voucherno;

     update f_voucher set status='accounted' where status='audited' and b_date>=p_beginDate;
end;
/

