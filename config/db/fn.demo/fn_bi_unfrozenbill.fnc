create or replace function FN_BI_UnfrozenBill
(
    p_moduleID   BI_FrozenStock.moduleid%type, --ģ����
	p_stockID    BI_FrozenStock.stockid%type --�ֵ����
)
return integer is
  /**
  * �ⶳ������
  * ����ֵ�� 1 �ɹ���-2 �Ѿ��ⶳ����
  **/
  v_cnt number(4); --���ֱ���

  RET_RESULT integer:=-2;--�ֵ����ֱ���
begin
    --�鿴�ֵ�����״̬�Ƿ���0:δע��1:ע��ֵ�4:���� ������ע���ֵ�
    select count(*) into v_cnt from BI_FrozenStock where moduleid=p_moduleID and stockID=p_stockID and status=0;
    if(v_cnt<=0)then
		return RET_RESULT;
    end if;
	--ɾ���ֵ�ҵ��
	delete from BI_StockOperation where stockID=p_stockID and operationID=4;
	--�ͷŶ���ֵ�
	update BI_FrozenStock set status=1,releaseTime=sysdate where stockID=p_stockID;
	--���سɹ�
    return 1;
end;
/

