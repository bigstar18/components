create or replace function FN_F_B_FirmDEL
(
    p_FirmID   m_firm.firmid%type --交易商代码
)
return integer is
  /**
  * 删除交易商
  * 返回值： 1 成功
  **/
  v_cnt                number(4); --数字变量
  v_firmstatus         F_B_FIRMUSER.status%type; --交易商状态
  RET_TradeModuleError integer := -901;--与errorInfo配合使用
begin
  --检查交易商是否存在签约信息
  select count(*) into v_cnt from F_B_FIRMIDANDACCOUNT where isOpen=1 and firmid=p_FirmID;
  if (v_cnt > 0) then
    return -1;
  end if;

  --检查交易商是否存在
  select count(*) into v_cnt from F_B_FIRMUSER where firmid=p_FirmID;
  if (v_cnt = 0) then
    return 1;
  end if;

  --检查交易商状态
  select status into v_firmstatus from F_B_FIRMUSER where firmid=p_FirmID;
  if (v_firmstatus = 1) then
	return 1;
  end if;

  --注销交易商
  update F_B_FIRMUSER set status=1 where firmid=p_FirmID;

  return 1;
end;
/

