CREATE OR REPLACE FUNCTION FN_T_UpdateRuntimeSettleMargin
(
  p_FirmID varchar2,   --�����̴���
  p_RuntimeSettleMargin number     --�������ֵ���ӣ���ֵ���٣�
)  return number
/***
 * ���½����̵��ս��ձ�֤��
 * version 1.0.0.6
 *
 * ����ֵ�������̵��ս��ձ�֤��
 ****/
is
  v_RuntimeSettleMargin number(15,2);
begin
  update T_Firm set RuntimeSettleMargin=RuntimeSettleMargin + p_RuntimeSettleMargin where FirmID=p_FirmID
  returning RuntimeSettleMargin into v_RuntimeSettleMargin;
  if(SQL%ROWCOUNT = 0) then
    Raise_application_error(-20099, 'FirmID not existed !'); --�����ڵĽ����̴���
  end if;

  return v_RuntimeSettleMargin;
end;
/

