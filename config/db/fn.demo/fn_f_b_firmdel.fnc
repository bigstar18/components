create or replace function FN_F_B_FirmDEL
(
    p_FirmID   m_firm.firmid%type --�����̴���
)
return integer is
  /**
  * ɾ��������
  * ����ֵ�� 1 �ɹ�
  **/
  v_cnt                number(4); --���ֱ���
  v_firmstatus         F_B_FIRMUSER.status%type; --������״̬
  RET_TradeModuleError integer := -901;--��errorInfo���ʹ��
begin
  --��齻�����Ƿ����ǩԼ��Ϣ
  select count(*) into v_cnt from F_B_FIRMIDANDACCOUNT where isOpen=1 and firmid=p_FirmID;
  if (v_cnt > 0) then
    return -1;
  end if;

  --��齻�����Ƿ����
  select count(*) into v_cnt from F_B_FIRMUSER where firmid=p_FirmID;
  if (v_cnt = 0) then
    return 1;
  end if;

  --��齻����״̬
  select status into v_firmstatus from F_B_FIRMUSER where firmid=p_FirmID;
  if (v_firmstatus = 1) then
	return 1;
  end if;

  --ע��������
  update F_B_FIRMUSER set status=1 where firmid=p_FirmID;

  return 1;
end;
/

