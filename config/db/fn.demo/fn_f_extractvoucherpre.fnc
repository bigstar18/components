create or replace function FN_F_ExtractVoucherPre
return number
/***
 * Զ�ڽ���
 * ���أ�-1:Զ�ڽ��㲻�ɹ�
 *       -2������С�ڵ���Զ�ڵ�ǰ�����յ���ˮ��δ�������
 ***/
as
  v_lastDate date;
  v_beginDate date;
  v_b_date date;
  v_cnt number(10);
  v_rtn varchar2(10);
  v_enabled char(1);
begin
  return 1;
end;
/

