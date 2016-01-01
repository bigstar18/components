create or replace procedure SP_F_StatusInit
as
/*********************
 ���������״̬�洢
 �洢˵�������ǽ��г�ʼ����ϵͳ
 ���ȵ��ñ��洢���Բ���ϵͳ���г�ʼ��

**********************/
v_status F_systemstatus.Status%type;
begin
  --1.������ϵͳ����״̬
  begin
     select status into v_status  from F_systemstatus t where rownum < 2;
  exception
     when NO_DATA_FOUND then
       return;
  end;
  --2.���״̬��Ϊ�������״̬��������
  if(v_status <> 2) then
    return;
  end if;

  --3.���״̬Ϊ������ɣ����޸�״̬Ϊδ����
  update F_systemstatus set status = 0,note = 'δ����';
  update F_CLEARSTATUS set status = 'N',finishtime = null;
end;
/

