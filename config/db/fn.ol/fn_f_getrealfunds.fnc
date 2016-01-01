create or replace function FN_F_GetRealFunds
(
  p_firmid varchar2,   --�����̴���
  p_lock number      --�Ƿ����� 1:���� 0��������
) return number
/***
 * ��ȡ�����ʽ�
 * version 1.0.0.1 ���÷���
 * ����ֵ���������
 ****/
is
  v_realfunds number(15,2);
begin
  if(p_lock=1) then
    select balance-frozenfunds into v_realfunds from f_firmfunds where firmid=p_firmid for update;
  else
    select balance-frozenfunds into v_realfunds from f_firmfunds where firmid=p_firmid;
  end if;
  return v_realfunds;
end;
/

