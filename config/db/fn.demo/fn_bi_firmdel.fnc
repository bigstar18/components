create or replace function FN_BI_FirmDel
(
    p_FirmID   m_firm.firmid%type--�����̴���
)
return integer is
  /**
  * ɾ��������
  * ����ֵ�� 1 �ɹ�
  **/
  v_cnt                number(4); --���ֱ���
  RET_RESULT integer:=-130;--�ֵ����ֱ���
begin
    --�鿴�ֵ�����״̬�Ƿ���0:δע��1:ע��ֵ�4:���� ������ע���ֵ�
    select count(*) into v_cnt from bi_stock s where s.ownerfirm=p_FirmID and s.stockstatus in(0,1,4);
    if(v_cnt>0)then
    return RET_RESULT;
    end if;
    return 1;
end;
/

