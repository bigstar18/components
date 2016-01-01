create or replace procedure SP_F_BalanceAccount(p_beginDate date) as
     v_lastDate date;
     v_curDate date;

     v_lvl number(2);
     v_cnt number(10);
begin
     --清除开始日期以后的结算
     delete from F_DailyBalance where b_Date >= p_beginDate;
     delete from F_FirmBalance where b_Date >= p_beginDate;
     --取得上日日期
     select max(b_Date) into v_lastDate from F_DailyBalance;
     if(v_lastDate is null) then
          v_lastDate := to_date('2000-01-01','yyyy-MM-dd');
     end if;

     for curDate in (select distinct b_date from f_Accountbook where b_date > v_lastDate order by b_date)
     loop
         v_curDate:=curDate.b_Date;

         --对所有科目初始化当日结算记录
         insert into F_DailyBalance(b_date,accountcode,lastdaybalance,debitamount,creditamount,todaybalance)
         select v_curDate,a.Code,nvl(b.todaybalance,0),0,0,nvl(b.todaybalance,0)
         from f_account a,(select * from F_DailyBalance where b_date = v_lastDate) b
         where a.Code = b.accountCode(+) and a.code not like '%\_' escape '\';

         --更新叶子节点当日借贷方发生额
         for debit in (select debitCode,sum(amount) amount from f_accountBook where b_date = v_curDate group by debitCode)
         loop
             update F_DailyBalance set DebitAmount=debit.amount where b_date = v_curDate and accountCode = debit.debitcode;
         end loop;
         for credit in (select creditCode,sum(amount) amount from f_accountBook where b_date = v_curDate group by creditCode)
         loop
             update F_DailyBalance set creditAmount=credit.amount where b_date = v_curDate and accountCode = credit.creditCode;
         end loop;

         select max(accountlevel) into v_lvl from F_Account;
         --更新当日借方、贷方发生额
         for account in (select code,accountlevel,dcFlag from f_account where accountlevel<v_lvl order by accountlevel desc)
         loop
             select count(1) into v_cnt from f_account
             where code like account.code||'%' and accountlevel=account.accountlevel+1;
             if(v_cnt>0) then
                 update F_DailyBalance a
                 set (DebitAmount,CreditAmount)=
                 (
                    select nvl(sum(DebitAmount),0),nvl(sum(CreditAmount),0)
                    from F_DailyBalance fd,f_account fa
                    where fd.b_date=v_curDate and fd.accountcode=fa.code and fd.accountcode like account.code||'%'
                      and fa.accountlevel=account.accountlevel+1
                 ) where accountcode=account.code and a.b_date=v_curDate;
             end if;
         end loop;

         --更新当日结算余额
         update (select a.*,b.dcflag from F_DailyBalance a,F_Account b
                 where b_date = v_curDate and a.accountCode=b.code) c
         set TodayBalance=c.LastdayBalance+(case dcflag when 'D' then DebitAmount-CreditAmount else CreditAmount-DebitAmount end);


         --------------------------------更新交易商结算表及担保金
         insert into F_FirmBalance
            (b_date, firmid, lastbalance, todaybalance, lastwarranty, todaywarranty)
         select b_date, substr(accountcode,7) firmid, lastdaybalance, todaybalance, 0, 0
         from f_dailybalance
         where b_Date=v_curDate
         and accountCode like '200100%' and substr(accountCode,7) is not null;

         --更新上日担保金
         update F_FirmBalance f
         set lastwarranty=nvl((select todaywarranty from F_FirmBalance where b_date=v_lastDate and firmid=f.firmid),0)
         where b_Date=v_curDate;

         --更新当日担保金
         update F_FirmBalance f set todaywarranty=lastwarranty where b_Date=v_curDate;
         for wfirm in (select distinct debitcode firmCode from f_accountbook
                       where b_Date=v_curDate and summaryno in ('15097','15096') and debitcode like '200101%'
                 union select distinct creditcode firmCode from f_accountbook
                       where b_Date=v_curDate and summaryno in ('15097','15096') and creditcode like '200101%')
         loop
             update F_FirmBalance f set todaywarranty=todaywarranty+
               nvl(
                 (
                   select sum(decode(summaryno,'15097',amount,-amount)) inAmount
                   from f_accountbook
                   where b_Date=v_curDate and (debitcode=wfirm.firmcode or creditcode=wfirm.firmcode) and summaryno in ('15097','15096')
                 )
               ,0)
             where b_Date=v_curDate and firmid=substr(wfirm.firmcode,7);
         end loop;

         --更新交易商资金表
         update F_Firmfunds f set (lastbalance,lastwarranty)=
           (select nvl(todaybalance,0),nvl(todaywarranty,0) from F_FirmBalance b where b_Date=v_curDate and b.firmid=f.firmid);
         --------------------------------end warranty
         --更新上日日期
         v_lastDate := v_curDate;
     end loop;

end;
/

