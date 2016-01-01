create or replace function FN_F_UpdateFrozenFunds
(
  p_firmid varchar2,   --交易商代码
  p_amount number,     --发生额（正值增加，负值减少）
  p_moduleID char   --交易模块ID 15：远期 23：现货 21：竞价
)  return number
/***
 * 更新冻结资金
 * version 1.0.0.1 此方法公用
 *
 * 返回值：冻结资金余额
 ****/
is
  v_frozenfunds number(15,2);
  v_moduleFrozenfunds number(15,2);
begin
  update f_firmfunds set frozenfunds=frozenfunds + p_amount where firmid=p_firmid
  returning frozenfunds into v_frozenfunds;
  if(SQL%ROWCOUNT = 0) then
    Raise_application_error(-21001, 'FirmID not existed !'); --不存在的交易商代码
  end if;

  update f_frozenfunds set frozenfunds=frozenfunds + p_amount where moduleid=p_moduleID and firmid=p_firmid;
  if(SQL%ROWCOUNT = 0) then
    insert into f_frozenfunds
      (moduleid, firmid, frozenfunds)
    values
      (p_moduleID, p_FirmID, p_amount);
  end if;

  --不允许银行接口将冻结资金减为负值
  if(p_moduleID = '28') then
    select frozenfunds into v_moduleFrozenfunds from f_frozenfunds where moduleid=p_moduleID and firmid=p_firmid;
    if(v_moduleFrozenfunds<0)then
      Raise_application_error(-21011, 'Module 28:frozen funds<0!');
    end if;
  end if;

  return v_frozenfunds;
end;
/

