create or replace function FN_T_UPDATEHOLDDAYS(p_commodityid varchar2)
/**
  * 更新指定商品的所有持仓的到期日期、到期天数
  */
 return number is
  v_date       date;
  v_deadline   date;
  v_remaindays number;
  v_ret        number;
begin

  for days in (select atcleardate
                 from t_holdposition
                where commodityid = p_commodityid
                group by atcleardate) loop
    --计算到期日期
    v_deadline := FN_T_GETHOLDDEADLINE(days.atcleardate, p_commodityid);
    --计算到期天数
    select count(*)
      into v_remaindays
      from t_tradedays
     where day <= v_deadline;
    --更新所有符合该条件的持仓
    update t_holdposition t
       set t.deadline = v_deadline, t.remainday = v_remaindays
     where t.atcleardate = days.atcleardate
       and commodityid = p_commodityid;

  end loop;
  return(0);
end;
/

