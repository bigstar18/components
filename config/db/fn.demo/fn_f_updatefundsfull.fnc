create or replace function FN_F_UpdateFundsFull
(
  p_firmID varchar2,      --�����̴���
  p_oprcode char,         --ҵ�����
  p_amount number,        --������
  p_contractNo varchar2,  --�ɽ���ͬ��
  p_extraCode varchar2,   --��Զ����Ʒ���룬����Ϊ��Ŀ����
  p_appendAmount number,  --��Զ��(��ֵ˰,������)
  p_voucherNo number      --ƾ֤��(�ֹ�ƾ֤ʹ��)
) return number
/***
 * �����ʽ�
 * version 1.0.0.1 �˷�������
 *
 * ����ֵ���ʽ����
 ****/
is
  v_fundsign number(1); -- 1 ���� -1 ����
  v_balance number(15,2);
  v_amount number(15,2):= p_amount;
begin
  begin
    select decode(funddcflag,'C',1,'D',-1,0) into v_fundsign from f_summary where summaryno=p_oprcode;
    if(v_fundsign=0) then
      Raise_application_error(-21003, 'Fund DCflag not defined in F_Summary!'); --δ����ҵ����루ժҪ���ʽ�������
    end if;
  exception when NO_DATA_FOUND then
    Raise_application_error(-21002, 'Undefined operation code(summaryNo)!'); --�����ڵ�ҵ����루ժҪ��
  end;

  update f_firmfunds set balance=balance + v_fundsign*v_amount where firmid=p_firmid
  returning balance into v_balance;
  if(SQL%ROWCOUNT = 0) then
    Raise_application_error(-21001, 'FirmID not existed !'); --�����ڵĽ����̴���
  end if;

  --�����ʽ���ˮ
  insert into f_fundflow
    (fundflowid, firmid, oprcode, contractno, commodityid, amount, balance,appendamount, voucherno, createtime)
  values
    (seq_f_fundflow.nextval, p_firmid, p_oprcode, p_contractno, p_extraCode, v_amount, v_balance,p_appendAmount,p_voucherNo, sysdate);

  return v_balance;
end;
/

