create or replace function FN_T_GETHOLDDEADLINE(p_begindate   date,
                                                p_commodityid varchar2)
/**
  * 获取持仓的到期日期
  */
 return date is
  v_date        date;
  v_cnt1        number;
  v_maxHoldDays number;

begin

  select c.maxholdpositionday
    into v_maxHoldDays
    from t_commodity c
   where c.commodityid = p_commodityid;
  if (v_maxHoldDays = 0) then   --如果持仓天数设置为0，则直接返回持仓日期
    return p_begindate;
  end if;

  select count(cleardate)
    into v_cnt1
    from t_h_market
   where cleardate >= p_begindate;

  if (v_maxHoldDays - v_cnt1 > 0) then    --未过期持仓
    select max(day)
      into v_date
      from (select *
              from (select day from t_tradedays order by day)
             where rownum <= v_maxHoldDays - v_cnt1);
  elsif (v_maxHoldDays - v_cnt1 <= 0) then   --过期持仓
    select max(cleardate)
      into v_date
      from (select *
              from (select cleardate
                      from t_h_market
                     where cleardate >= p_begindate
                     order by cleardate)
             where rownum <= v_maxHoldDays);
  end if;
  return v_date;
end;
/

