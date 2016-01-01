create or replace function FN_T_ConferCloseAudit(
    p_ID            varchar2,       --Э�齻��ID
    p_CommodityID   varchar2,       --��Ʒ����
    p_bCustomerID   varchar2,       --�򷽽��׿ͻ�ID
    p_sCustomerID   varchar2,       --�������׿ͻ�ID
    p_price         number,         --�۸�
    p_quantity      number          --����
) return number
/****
 * Э�齻�����
 * ����ֵ
 * 1 �ɹ�
 * -1  ��ƽ����ֲ���������
 * -3  ƽ����ֲ��������ڿ�ƽ����ֲ�����
 * -11  ��ƽ�����ֲ���������
 * -13  ƽ�����ֲ��������ڿ�ƽ�����ֲ�����
 * -21  �ⶳ�ֲ�ʧ��
 * -100 ��������
****/
as
     v_ret          number(5):=0;
begin
     --�ⶳ�ֲֺϼƱ�ֲ�
     --1.�ͻ��ֲֺϼƱ�(��)
     --update t_customerholdsum set frozenQty=frozenQty-p_quantity where commodityid = p_CommodityID and customerid = p_bCustomerID and bs_flag = 1;
     --2.�ͻ��ֲֺϼƱ�(����)
     --update t_customerholdsum set frozenQty=frozenQty-p_quantity where commodityid = p_CommodityID and customerid = p_sCustomerID and bs_flag = 2;
     --�ⶳ�ֲֶ����
     delete T_Holdfrozen where Operation = p_ID and frozentype = 1;
     --�޸����״̬
     update T_E_ApplyTreatySettle set Status = 2,modifytime = sysdate where ApplyID = p_ID;

     v_ret := FN_T_ConferClose(p_CommodityID,p_price,p_bCustomerID,p_quantity,0,p_sCustomerID,p_quantity,0);
     return v_ret;
exception
    when OTHERS then
    rollback;
    return -21;
end;
/

