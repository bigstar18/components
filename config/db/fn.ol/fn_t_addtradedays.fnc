create or replace function FN_T_AddTradeDAYS
/**
  * 添加交易日
  */
 return number is
  v_curdate date;
  v_cnt     number;
begin

  delete from t_tradedays;
  begin
    select max(cleardate) + 1 into v_curdate from t_h_trade;
  exception
    when NO_DATA_FOUND then
      select tradedate into v_curdate from t_systemstatus;
  end;

  if (v_curdate is null) then
    select tradedate into v_curdate from t_systemstatus;
  end if;

  for i in 1 .. 2000 loop
    select count(*)
      into v_cnt
      from t_a_nottradeday t
     where t.week like '%' || to_char(v_curdate, 'D') || '%';

    if (v_cnt = 0) then
      --交易日
      select count(*)
        into v_cnt
        from t_a_nottradeday t
       where t.day like '%' || to_char(v_curdate, 'YYYY-MM-DD') || '%';
      if (v_cnt = 0) then
        insert into t_tradedays (day) values (v_curdate);
      end if;
    end if;
    v_curdate := v_curdate + 1;
  end loop;

  return 0;
end;
/

