create or replace function FN_F_B_firmADD
(
    p_FirmID m_firm.firmid%type --交易商代码
)
return integer is
  /**
  * 银行系统添加交易商
  * 返回值： 1 成功
  **/
  v_cnt                number(4); --数字变量
  v_name               m_firm.name%type;
begin
  select count(*) into v_cnt from F_B_FIRMUSER where firmid = p_FirmID;
  if (v_cnt <= 0) then
	select name into v_name from m_firm where firmid = p_FirmID;
    insert into F_B_FIRMUSER (firmID,name,maxPersgltransMoney,maxPertransMoney,maxPertranscount,status,registerDate,maxAuditMoney) values (p_FirmID,v_name,0,0,0,1,sysdate,0);
  end if;
  return 1;
end;
/

