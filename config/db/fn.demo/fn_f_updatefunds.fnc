create or replace function FN_F_UpdateFunds
(
  p_firmID varchar2,     --�����̴���
  p_oprcode char,         --ҵ�����
  p_amount number,       --������
  p_contractNo varchar2  --�ɽ���ͬ��
) return number
/***
 * �����ʽ�
 * version 1.0.0.1 �˷�������
 *
 * ����ֵ���ʽ����
 ****/
is
begin
  return fn_f_updatefundsFull(p_firmid,p_oprcode,p_amount,p_contractNo,null,null,null);
end;
/

