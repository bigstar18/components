create or replace function FN_T_FirmDel
(
    p_FirmID m_firm.firmid%type --�����̴���
)return integer is
  /**
  * ����ϵͳɾ��������
  * ����ֵ�� 1 �ɹ�
  ע�ⲻҪ�ύcommit����Ϊ��ĺ���Ҫ��������
  **/
  v_cnt                number(5); --���ֱ���
begin
  /*---mengyu 2013.08.29  ע�����ײ���ɾ���������ݱ�������*/
  /*  --2��ɾ�����������Ᵽ֤���˽����̼�¼����ʷ��¼���½�����ID����_
  update T_H_FirmMargin set FirmID=FirmID || '_' where FirmID=p_FirmID;
    delete from T_A_FirmMargin where FirmID=p_FirmID;
    --3��ɾ�����������������ѱ�˽����̼�¼����ʷ��¼���½�����ID����_
    update T_H_FirmFee set FirmID=FirmID || '_' where FirmID=p_FirmID;
    delete from T_A_FirmFee where FirmID=p_FirmID;
    --4��ɾ������ֲ�����˽����̼�¼
    delete from T_A_FirmMaxHoldQty where FirmID=p_FirmID;
    --5��ɾ��ί�б�˽����̼�¼����ʷ��¼���½�����ID����_
    update T_H_Orders set FirmID=FirmID || '_' where FirmID=p_FirmID;
    delete from T_Orders where FirmID=p_FirmID;
    --6��ɾ���ɽ���˽����̼�¼����ʷ��¼���½�����ID����_
    update T_H_Trade set FirmID=FirmID || '_' where FirmID=p_FirmID;
    delete from T_Trade where FirmID=p_FirmID;
    --7��ɾ���ֲ���ϸ���д˽����̼�¼����ʷ��¼���½�����ID����_
    update T_H_HoldPosition set FirmID=FirmID || '_' where FirmID=p_FirmID;
    delete from T_HoldPosition where FirmID=p_FirmID;
    --8��ɾ�����׿ͻ��ֲֺϼƱ�˽����̼�¼����ʷ��¼���½�����ID����_
    update T_H_CustomerHoldSum set FirmID=FirmID || '_' where FirmID=p_FirmID;
    delete from T_CustomerHoldSum where FirmID=p_FirmID;
    --9��ɾ�������ֲֺ̳ϼƱ�˽����̼�¼����ʷ��¼���½�����ID����_
    update T_H_FirmHoldSum set FirmID=FirmID || '_' where FirmID=p_FirmID;
    delete from T_FirmHoldSum where FirmID=p_FirmID;
    --11�����½��ս��׿ͻ��ֲֺϼƱ�˽����̼�¼��������ID����_
    update T_SettleHoldPosition set FirmID=FirmID || '_' where FirmID=p_FirmID;
    --14��ɾ������Ա��˽����̼�¼
    delete from T_Trader where TraderID in(select TraderID from M_Trader where FirmID=p_FirmID);
    --15��ɾ�����׿ͻ���˽����̼�¼
    delete from T_Customer where FirmID=p_FirmID;
    --16��ɾ�������̱�˽����̣���ʷ��¼���½�����ID����_
    update T_H_Firm set FirmID=FirmID || '_' where FirmID=p_FirmID;
    delete from T_Firm where FirmID=p_FirmID;
    */
    return 1;

end;
/

