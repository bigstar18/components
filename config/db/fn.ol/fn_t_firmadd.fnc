create or replace function FN_T_FirmAdd
(
    p_FirmID m_firm.firmid%type --�����̴���
)return integer is
  /**
  * ����ϵͳ��ӽ�����
  * ����ֵ�� 1 �ɹ�
  ע�ⲻҪ�ύcommit����Ϊ��ĺ���Ҫ��������
  **/
  v_cnt                number(5); --���ֱ���
begin
  --1�����뽻���̱�Ĭ������״̬
    select count(*) into v_cnt from T_Firm where firmid=p_firmid;
    if(v_cnt=0) then
        insert into T_Firm(FirmID,Status,ModifyTime) values(p_FirmID,0,sysdate);
    end if;
    --2������һ��Ĭ�Ͻ�����ID+00С�ŵĿͻ����ͻ���
    select count(*) into v_cnt from T_Customer where CustomerID=p_firmid||'00';
    if(v_cnt=0) then
        insert into T_Customer(CustomerID, FirmID,  Code,Status,CreateTime,ModifyTime)
        values( p_FirmID||'00', p_FirmID ,'00', 0, sysdate, sysdate);
    end if;

    return 1;
end;
/

