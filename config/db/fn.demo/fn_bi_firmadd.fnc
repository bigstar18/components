create or replace function FN_BI_firmADD
(
    p_FirmID m_firm.firmid%type --�����̴���
)
return integer is
  /**
  * �ֻ�ϵͳ��ӽ�����
  * ����ֵ�� 1 �ɹ�
  **/
  v_cnt                number(4); --���ֱ���
begin
  select count(*) into v_cnt from BI_firm where firmid = p_FirmID;
   if (v_cnt > 0) then
    --����������Ѿ��������������ý�������Ϣ
    update BI_firm set password=FN_M_MD5(p_FirmID||'111111'),createtime= sysdate  where firmid=p_FirmID;
  end if;

  insert into BI_firm
      (firmid, password, createtime)
  values
      (p_FirmID, FN_M_MD5(p_FirmID||'111111'), sysdate);

  return 1;
end;
/

