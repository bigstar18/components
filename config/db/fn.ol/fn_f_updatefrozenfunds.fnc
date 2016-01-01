create or replace function FN_F_UpdateFrozenFunds
(
  p_firmid varchar2,   --�����̴���
  p_amount number,     --�������ֵ���ӣ���ֵ���٣�
  p_moduleID char   --����ģ��ID 15��Զ�� 23���ֻ� 21������
)  return number
/***
 * ���¶����ʽ�
 * version 1.0.0.1 �˷�������
 *
 * ����ֵ�������ʽ����
 ****/
is
  v_frozenfunds number(15,2);
  v_moduleFrozenfunds number(15,2);
begin
  update f_firmfunds set frozenfunds=frozenfunds + p_amount where firmid=p_firmid
  returning frozenfunds into v_frozenfunds;
  if(SQL%ROWCOUNT = 0) then
    Raise_application_error(-21001, 'FirmID not existed !'); --�����ڵĽ����̴���
  end if;

  update f_frozenfunds set frozenfunds=frozenfunds + p_amount where moduleid=p_moduleID and firmid=p_firmid;
  if(SQL%ROWCOUNT = 0) then
    insert into f_frozenfunds
      (moduleid, firmid, frozenfunds)
    values
      (p_moduleID, p_FirmID, p_amount);
  end if;

  --���������нӿڽ������ʽ��Ϊ��ֵ
  if(p_moduleID = '28') then
    select frozenfunds into v_moduleFrozenfunds from f_frozenfunds where moduleid=p_moduleID and firmid=p_firmid;
    if(v_moduleFrozenfunds<0)then
      Raise_application_error(-21011, 'Module 28:frozen funds<0!');
    end if;
  end if;

  return v_frozenfunds;
end;
/

