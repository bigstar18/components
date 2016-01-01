CREATE OR REPLACE FUNCTION FN_T_FirmExitCheck
(
    p_FirmID in varchar2       --������ID
) RETURN NUMBER
/****
 * ���������м��
 * 1��ע�ⲻҪ�ύcommit����Ϊ��ĺ���Ҫ��������
 * ����ֵ
 * 1 �ɹ�
 * -1���˽����̴��ڳֲ֣��������У�
****/
as
	v_version varchar2(10):='1.0.0.1';
    v_num   number(10);
begin
    --1����齻�����Ƿ���ڳֲ�
    select nvl(sum(HoldQty+GageQty),0) into v_num from T_FirmHoldSum where FirmID=p_FirmID;
    if(v_num > 0) then
        return -1;
    end if;

    return 1;
end;
/

