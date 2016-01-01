create or replace procedure SP_F_UnFrozenAllFunds
(
  p_moduleID char   --交易模块ID 2：远期 3：现货 4：竞价
)
/***
 * 更新冻结资金
 * version 1.0.0.1 此方法公用
 *
 * 返回值：冻结资金余额
 ****/
is
begin
  update f_firmfunds f set frozenfunds=frozenfunds -
    nvl((select frozenfunds from f_frozenfunds where moduleid=p_moduleID and firmid=f.firmid and frozenfunds<>0),0)
  ;

  update f_frozenfunds set frozenfunds=0 where moduleid=p_moduleID and frozenfunds<>0;

  insert into f_log
    (occurtime, type, userid, description)
  values
    (sysdate, 'sysinfo', 'system', 'UnFrozen specifid module funds:'||p_moduleID);

end;
/

