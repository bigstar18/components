create or replace function FN_BR_BrokerPayDate(p_date date) return date is
/**
 * ���㸶��ԱӶ��β������
 **/
  v_paydate    date;             --����ԱӶ��β������
  v_dateString varchar2(32);
  v_payPeriod     number(1);     --��������
  v_payPeriodDate number(3);     --����������
begin

  select PayPeriod,PayPeriodDate into v_payPeriod,v_payPeriodDate from BR_RewardParameterProps ;
  if(v_payPeriod=1)then  --���¼���
     v_dateString := to_char(ADD_MONTHS(trunc(p_date), 1), 'yyyy-MM');
  --dbms_output.put_line('--v_dateString:'||v_dateString);
     v_dateString := v_dateString || '-'||v_payPeriodDate;
     v_paydate    := to_date(v_dateString, 'yyyy-MM-dd');
  elsif(v_payPeriod=2)then --���ܼ���
    -- if(v_payPeriodDate>6 and v_payPeriodDate<1)then

    -- end if;
     select next_day(p_date,v_payPeriodDate) into v_paydate from dual;
     v_paydate    := trunc(v_paydate);
  end if;
  return v_paydate;
end;
/

