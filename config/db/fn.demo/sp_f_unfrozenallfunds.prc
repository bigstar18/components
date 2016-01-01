create or replace procedure SP_F_UnFrozenAllFunds
(
  p_moduleID char   --����ģ��ID 2��Զ�� 3���ֻ� 4������
)
/***
 * ���¶����ʽ�
 * version 1.0.0.1 �˷�������
 *
 * ����ֵ�������ʽ����
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

