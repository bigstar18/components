create or replace function FN_BR_BrokerPayDate(p_date date) return date is
/**
 * 计算付会员佣金尾款日期
 **/
  v_paydate    date;             --付会员佣金尾款日期
  v_dateString varchar2(32);
  v_payPeriod     number(1);     --付款周期
  v_payPeriodDate number(3);     --付款周期日
begin

  select PayPeriod,PayPeriodDate into v_payPeriod,v_payPeriodDate from BR_RewardParameterProps ;
  if(v_payPeriod=1)then  --按月计算
     v_dateString := to_char(ADD_MONTHS(trunc(p_date), 1), 'yyyy-MM');
  --dbms_output.put_line('--v_dateString:'||v_dateString);
     v_dateString := v_dateString || '-'||v_payPeriodDate;
     v_paydate    := to_date(v_dateString, 'yyyy-MM-dd');
  elsif(v_payPeriod=2)then --按周计算
    -- if(v_payPeriodDate>6 and v_payPeriodDate<1)then

    -- end if;
     select next_day(p_date,v_payPeriodDate) into v_paydate from dual;
     v_paydate    := trunc(v_paydate);
  end if;
  return v_paydate;
end;
/

