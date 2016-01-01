create or replace function FN_F_FirmDel
(
    p_FirmID   m_firm.firmid%type--交易商代码
)
return integer is
  /**
  * 删除交易商
  * 返回值： 1 成功
  *          -900 资金不为0
  **/
 -- v_cnt                number(4); --数字变量
  v_balance      f_firmfunds.balance%type;
  RET_FundNotZero integer := -901;

begin

   select balance - frozenfunds into v_balance from f_firmfunds where firmid = p_FirmID;
   if(v_balance <>0) then
            return RET_FundNotZero;
   end if;

  /*---mengyu 2013.8.29 注销交易商表数据不变也不删除--start-*/
  /*select count(*) into v_cnt from f_voucherentry f where f.accountcode='20100'||p_FirmID;
  if(v_cnt>0) then
    select count(*) into v_cnt from f_account f where code='200100'||p_FirmID||'_';
     if(v_cnt=0) then
        update f_account set code='200100'||p_FirmID||'_' where code='200100'||p_FirmID;
     else
        delete from f_account where Code='200100'||p_FirmID;
     end if;
  else
    delete from f_account where Code='200100'||p_FirmID;
  end if;
  */
   /*---mengyu 2013.8.29 注销交易商表数据不变也不删除--end-*/
  /*select count(*) into v_cnt from f_voucherentry f where f.accountcode='200101'||p_FirmID;
  if(v_cnt>0) then
    select count(*) into v_cnt from f_account f where code='200101'||p_FirmID||'_';
     if(v_cnt=0) then
        update f_account set code='200101'||p_FirmID||'_' where code='200101'||p_FirmID;
     else
        delete from f_account where Code='200101'||p_FirmID;
     end if;
  else
  delete from f_account where Code='200101'||p_FirmID;
  end if;*/
 /*---mengyu 2013.8.29 注销交易商表数据不变也不删除--start-*/
 -- delete from f_firmfunds where firmid=p_FirmID;

 -- update f_accountbook set debitcode=debitcode||'_' where debitcode in ('200100'||p_FirmID/*, '20101'||p_FirmID*/);
 -- update f_accountbook set creditcode=creditcode||'_' where creditcode in ('200100'||p_FirmID/*, '20101'||p_FirmID*/);
 -- update f_clientledger set firmid=firmid||'_' where firmid=p_FirmID;
 -- update f_dailybalance set accountcode=accountcode||'_' where accountcode in ('200100'||p_FirmID/*, '20101'||p_FirmID*/);
 -- update f_firmbalance set firmid=firmid||'_' where firmid=p_FirmID;
 -- update f_h_fundflow set firmid=firmid||'_' where firmid=p_FirmID;
 -- update f_voucherentry set accountcode=accountcode||'_' where accountcode in ('200100'||p_FirmID/*, '20101'||p_FirmID*/);
 /*---mengyu 2013.8.29 注销交易商表数据不变也不删除--end-*/
  return 1;
end;
/

