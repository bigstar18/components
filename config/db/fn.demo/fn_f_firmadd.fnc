create or replace function FN_F_firmADD
(
    p_FirmID m_firm.firmid%type --交易商代码
)
return integer is
  /**
  * 现货系统添加交易商
  * 返回值： 1 成功
  **/
  v_cnt                number(4); --数字变量
  v_enabled char(1);
begin
  select count(*) into v_cnt from f_account where Code='200100'||p_FirmID;
  if(v_cnt=0)then
    insert into f_account(Code,Name,accountLevel,dCFlag)
    select '200100'||p_FirmID,name||p_FirmID,3,'C' from f_account
    where code='200100';
  end if;
  select count(*) into v_cnt from f_account where Code='200101'||p_FirmID;
  if(v_cnt=0)then
    insert into f_account(Code,Name,accountLevel,dCFlag)
    select '200101'||p_FirmID,name||p_FirmID,3,'C' from f_account
    where code='200101';
  end if;
  select count(*) into v_cnt from f_firmfunds where firmid=p_FirmID;
  if(v_cnt=0)then
    insert into f_firmfunds
      (firmid, balance, frozenfunds)
    values
      (p_FirmID, 0, 0);
  end if;

  return 1;
end;
/

