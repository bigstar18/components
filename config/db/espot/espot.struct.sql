----------------------------------------------
-- Export file for user TRADE_GNNT@XHDBDEMO --
-- Created by hxx on 2015/11/9, 1:40:02 ------
----------------------------------------------

set define off
spool espot.struct.log

prompt
prompt Creating sequence SEQ_E_APPLY
prompt =============================
prompt
create sequence SEQ_E_APPLY
minvalue 1
maxvalue 9999999999999999999999999999
start with 1000000
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_E_ARBITRATION
prompt ===================================
prompt
create sequence SEQ_E_ARBITRATION
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_E_BREACHAPPLY
prompt ===================================
prompt
create sequence SEQ_E_BREACHAPPLY
minvalue 1
maxvalue 9999999999999999999999999999
start with 1000020
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_E_DELIVERYFEE
prompt ===================================
prompt
create sequence SEQ_E_DELIVERYFEE
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_E_DELIVERYMARGIN
prompt ======================================
prompt
create sequence SEQ_E_DELIVERYMARGIN
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_E_ENDTRADEAPPLY
prompt =====================================
prompt
create sequence SEQ_E_ENDTRADEAPPLY
minvalue 1
maxvalue 9999999999999999999999999999
start with 1000000
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_E_GOODSMONEYAPPLY
prompt =======================================
prompt
create sequence SEQ_E_GOODSMONEYAPPLY
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_E_GOODSRESOURCE
prompt =====================================
prompt
create sequence SEQ_E_GOODSRESOURCE
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_E_GOODSRESOURCEPIC
prompt ========================================
prompt
create sequence SEQ_E_GOODSRESOURCEPIC
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_E_GOODSTEMPLATE
prompt =====================================
prompt
create sequence SEQ_E_GOODSTEMPLATE
minvalue 1
maxvalue 9999999999999999999999999999
start with 21
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_E_HOLDING
prompt ===============================
prompt
create sequence SEQ_E_HOLDING
minvalue 1
maxvalue 9999999999999999999999999999
start with 1000040
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_E_NOOFFSET
prompt ================================
prompt
create sequence SEQ_E_NOOFFSET
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_E_OFFSET
prompt ==============================
prompt
create sequence SEQ_E_OFFSET
minvalue 1
maxvalue 9999999999999999999999999999
start with 21
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_E_ORDER
prompt =============================
prompt
create sequence SEQ_E_ORDER
minvalue 1
maxvalue 9999999999999999999999999999
start with 1000040
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_E_ORDERPIC
prompt ================================
prompt
create sequence SEQ_E_ORDERPIC
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_E_RESERVE
prompt ===============================
prompt
create sequence SEQ_E_RESERVE
minvalue 1
maxvalue 9999999999999999999999999999
start with 1000060
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_E_SHOP
prompt ============================
prompt
create sequence SEQ_E_SHOP
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_E_SUBORDER
prompt ================================
prompt
create sequence SEQ_E_SUBORDER
minvalue 1
maxvalue 9999999999999999999999999999
start with 1000040
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_E_SUBSCRIPTIONFLOW
prompt ========================================
prompt
create sequence SEQ_E_SUBSCRIPTIONFLOW
minvalue 1
maxvalue 9999999999999999999999999999
start with 41
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_E_TRADE
prompt =============================
prompt
create sequence SEQ_E_TRADE
minvalue 1
maxvalue 9999999999999999999999999999
start with 1000040
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_E_TRADEFEE
prompt ================================
prompt
create sequence SEQ_E_TRADEFEE
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_E_TRADEPROCESSLOG
prompt =======================================
prompt
create sequence SEQ_E_TRADEPROCESSLOG
minvalue 1
maxvalue 9999999999999999999999999999
start with 141
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_E_TRADERIGHT
prompt ==================================
prompt
create sequence SEQ_E_TRADERIGHT
minvalue 1
maxvalue 9999999999999999999999999999
start with 21
increment by 1
cache 20;

prompt
prompt Creating view V_E_ARBITRATION_STAT
prompt ==================================
prompt
create or replace force view v_e_arbitration_stat as
select
       count (1) cnt,                     --仲裁数量
       trunc(t.applytime) applydate       --仲裁日期
from e_arbitration t
where 1=1
group by trunc(t.applytime)
;

prompt
prompt Creating view V_E_BREED_ORDER_SEQUENCE
prompt ======================================
prompt
create or replace force view v_e_breed_order_sequence as
select b.breedid,                                      --品名ID
       b.breedname,                                    --品名
       nvl(sum(cnt), 0) cnt,                           --委托笔数
       nvl(sum(TotalPrice)/sum(quantity), 0) EvenPrice,    --均价
       nvl(sum(TotalPrice), 0) TotalPrice,             --委托金额
       nvl(sum(quantity), 0) quantity,                 --委托数量
       nvl(sum(tradeqty), 0) tradeqty                  --成交数量
  from (select breedid, breedname from m_breed  where status <>2 and belongmodule like '%23%') b
  left join (select n.breedid,
                    count(*) cnt,
                    sum(price * quantity) TotalPrice,
                    sum(quantity) quantity,
                    sum(tradedqty) tradeqty,
                    trunc(n.ordertime) as ordertime
               from e_order n
              group by n.breedid, trunc(n.ordertime)
             union all
             select n.breedid,
                    count(*) cnt,
                    sum(price * quantity) TotalPrice,
                    sum(quantity) quantity,
                    sum(tradedqty) tradeqty,
                    trunc(n.ordertime) as ordertime
               from e_Order_h n
              group by n.breedid, trunc(n.ordertime)) a on a.breedid =
                                                           b.breedid
                                                       and ordertime >=
                                                           to_date(date_view_param.get_start(),
                                                                   'yyyy-MM-dd')
                                                       and ordertime <=
                                                           to_date(date_view_param.get_end(),
                                                                   'yyyy-MM-dd')
 group by b.breedid, b.breedname
;

prompt
prompt Creating view V_E_BREED_ORDER_STAT
prompt ==================================
prompt
create or replace force view v_e_breed_order_stat as
select b.breedid,                                                               --品名ID
       b.breedname,                                                             --品名
       b.bsflag bsflag,                                                         --买卖方向
       nvl(sum(cnt), 0) cnt,                                                    --委托笔数
       nvl(sum(TotalPrice) / sum(quantity), 0) EvenPrice,                             --均价
       nvl(sum(TotalPrice), 0) TotalPrice,                                      --委托金额
       nvl(sum(quantity), 0) quantity,                                          --委托数量
       nvl(sum(tradeqty), 0) tradeqty                                           --成交数量
  from (select 'B' bsflag, breedid, breedname
          from m_breed where status <> 2  and belongmodule like '%23%'
        union
        select 'S' bsflag, breedid, breedname from m_breed where status <> 2 and belongmodule like '%23%') b
  left join (select n.breedid,
                    'B' bsflag,
                    count(*) cnt,
                    sum(price * quantity) TotalPrice,
                    sum(quantity) quantity,
                    sum(tradedqty) tradeqty,
                    trunc(n.ordertime) as ordertime
               from e_order n
              where n.bsflag = 'B'
              group by n.breedid, trunc(n.ordertime)
             union
             select n.breedid,
                    'B' bsflag,
                    count(*) cnt,
                    sum(price * quantity) TotalPrice,
                    sum(quantity) quantity,
                    sum(tradedqty) tradeqty,
                    trunc(n.ordertime) as ordertime
               from e_Order_h n
              where n.bsflag = 'B'
              group by n.breedid, trunc(n.ordertime)
             union
             select n.breedid,
                    'S' bsflag,
                    count(*) cnt,
                    sum(price * quantity) TotalPrice,
                    sum(quantity) quantity,
                    sum(tradedqty) tradeqty,
                    trunc(n.ordertime) as ordertime
               from e_order n
              where n.bsflag = 'S'
              group by n.breedid, trunc(n.ordertime)
             union
             select n.breedid,
                    'S' bsflag,
                    count(*) cnt,
                    sum(price * quantity) TotalPrice,
                    sum(quantity) quantity,
                    sum(tradedqty) tradeqty,
                    trunc(n.ordertime) as ordertime
               from e_order_h n
              where n.bsflag = 'S'
              group by n.breedid, trunc(n.ordertime)) a on a.breedid =
                                                           b.breedid
                                                       and b.bsflag =
                                                           a.bsflag
                                                       and ordertime >=
                                                           to_date(date_view_param.get_start(),
                                                                   'yyyy-MM-dd')
                                                       and ordertime <=
                                                           to_date(date_view_param.get_end(),
                                                                   'yyyy-MM-dd')
 group by b.breedid, b.bsflag, b.breedname
;

prompt
prompt Creating view V_E_BREED_REVENUE_STAT
prompt ====================================
prompt
create or replace force view v_e_breed_revenue_stat as
select g.breedid,                               --品名ID
       g.breedname,                             --品名
       sum(s.xiyie) tradefee,                   --交易手续费
       sum(s.jiaoshou) deliveryfee,             --交收手续费
       sum(s.xiyie) + sum(s.jiaoshou) sumfee    --手续费总额
  from (select m.tradecode,
               sum(m.xiyie) xiyie,
               m.deliverycode,
               sum(m.jiaoshou) jiaoshou,
               m.tradeno,
               m.dat,
               n.breedid
          from (select a.oprcode tradecode,
                       a.xiyie xiyie,
                       b.oprcode deliverycode,
                       b.jiaoshou jiaoshou,
                       a.tradeno,
                       a.dat dat
                  from (select t.oprcode,
                               sum(amount) xiyie,
                               t.contractno tradeno,
                               trunc(t.createtime) dat
                          from f_fundflow t
                         where t.oprcode = '23001'
                         group by t.oprcode, trunc(t.createtime), t.contractno
                         order by trunc(t.createtime) desc) a,
                       (select t.oprcode,
                               sum(amount) jiaoshou,
                               t.contractno tradeno,
                               trunc(t.createtime) dat
                          from f_fundflow t
                         where t.oprcode = '23004'
                         group by t.oprcode, trunc(t.createtime), t.contractno
                         order by trunc(t.createtime) desc) b
                 where a.dat = b.dat
                   and a.tradeno = b.tradeno) m,
               e_trade n
         where m.tradeno = n.tradeno
           and trunc(m.dat) >=
               to_date(date_view_param.get_start(), 'yyyy-MM-dd')
           and trunc(m.dat) <=
               to_date(date_view_param.get_end(), 'yyyy-MM-dd')
         group by m.dat, m.tradeno, m.tradecode, m.deliverycode, n.breedid
        union all
        select m.tradecode,
               sum(m.xiyie) xiyie,
               m.deliverycode,
               sum(m.jiaoshou) jiaoshou,
               m.tradeno,
               m.dat,
               n.breedid
          from (select a.oprcode tradecode,
                       a.xiyie xiyie,
                       b.oprcode deliverycode,
                       b.jiaoshou jiaoshou,
                       a.tradeno,
                       a.dat dat
                  from (select t.oprcode,
                               sum(amount) xiyie,
                               t.contractno tradeno,
                               trunc(t.createtime) dat
                          from f_fundflow t
                         where t.oprcode = '23001'
                         group by t.oprcode, trunc(t.createtime), t.contractno
                         order by trunc(t.createtime) desc) a,
                       (select t.oprcode,
                               sum(amount) jiaoshou,
                               t.contractno tradeno,
                               trunc(t.createtime) dat
                          from f_fundflow t
                         where t.oprcode = '23004'
                         group by t.oprcode, trunc(t.createtime), t.contractno
                         order by trunc(t.createtime) desc) b
                 where a.dat = b.dat
                   and a.tradeno = b.tradeno) m,
               e_trade_h n
         where m.tradeno = n.tradeno
           and trunc(m.dat) >=
               to_date(date_view_param.get_start(), 'yyyy-MM-dd')
           and trunc(m.dat) <=
               to_date(date_view_param.get_end(), 'yyyy-MM-dd')
         group by m.dat, m.tradeno, m.tradecode, m.deliverycode, n.breedid
        union all
        select m.tradecode,
               sum(m.xiyie) xiyie,
               m.deliverycode,
               sum(m.jiaoshou) jiaoshou,
               m.tradeno,
               m.dat,
               n.breedid
          from (select a.oprcode tradecode,
                       a.xiyie xiyie,
                       b.oprcode deliverycode,
                       b.jiaoshou jiaoshou,
                       a.tradeno,
                       a.dat dat
                  from (select t.oprcode,
                               sum(amount) xiyie,
                               t.contractno tradeno,
                               trunc(t.createtime) dat
                          from f_h_fundflow t
                         where t.oprcode = '23001'
                         group by t.oprcode, trunc(t.createtime), t.contractno
                         order by trunc(t.createtime) desc) a,
                       (select t.oprcode,
                               sum(amount) jiaoshou,
                               t.contractno tradeno,
                               trunc(t.createtime) dat
                          from f_h_fundflow t
                         where t.oprcode = '23004'
                         group by t.oprcode, trunc(t.createtime), t.contractno
                         order by trunc(t.createtime) desc) b
                 where a.dat = b.dat
                   and a.tradeno = b.tradeno) m,
               e_trade n
         where m.tradeno = n.tradeno
           and trunc(m.dat) >=
               to_date(date_view_param.get_start(), 'yyyy-MM-dd')
           and trunc(m.dat) <=
               to_date(date_view_param.get_end(), 'yyyy-MM-dd')
         group by m.dat, m.tradeno, m.tradecode, m.deliverycode, n.breedid
        union all
        select m.tradecode,
               sum(m.xiyie) xiyie,
               m.deliverycode,
               sum(m.jiaoshou) jiaoshou,
               m.tradeno,
               m.dat,
               n.breedid
          from (select a.oprcode tradecode,
                       a.xiyie xiyie,
                       b.oprcode deliverycode,
                       b.jiaoshou jiaoshou,
                       a.tradeno,
                       a.dat dat
                  from (select t.oprcode,
                               sum(amount) xiyie,
                               t.contractno tradeno,
                               trunc(t.createtime) dat
                          from f_h_fundflow t
                         where t.oprcode = '23001'
                         group by t.oprcode, trunc(t.createtime), t.contractno
                         order by trunc(t.createtime) desc) a,
                       (select t.oprcode,
                               sum(amount) jiaoshou,
                               t.contractno tradeno,
                               trunc(t.createtime) dat
                          from f_h_fundflow t
                         where t.oprcode = '23004'
                         group by t.oprcode, trunc(t.createtime), t.contractno
                         order by trunc(t.createtime) desc) b
                 where a.dat = b.dat
                   and a.tradeno = b.tradeno) m,
               e_trade_h n
         where m.tradeno = n.tradeno
           and trunc(m.dat) >=
               to_date(date_view_param.get_start(), 'yyyy-MM-dd')
           and trunc(m.dat) <=
               to_date(date_view_param.get_end(), 'yyyy-MM-dd')
         group by m.dat, m.tradeno, m.tradecode, m.deliverycode, n.breedid) s,
       m_breed g
 where s.breedid = g.breedid
   and g.status <> 2
   and belongmodule like '%23%'
 group by g.breedid, g.breedname
;

prompt
prompt Creating view V_E_BREED_TRADE_AMOUNT_STAT
prompt =========================================
prompt
create or replace force view v_e_breed_trade_amount_stat as
select b.breedid, --品名ID
       b.breedname, --品名
       sum(a.tradeamount) tradeamount --成交额
  from (select sum(price * quantity) tradeamount,
               trunc(time) tradedate,
               breedid
          from e_trade
         where status = '8'
           and trunc(time) >=
               to_date(date_view_param.get_start(), 'yyyy-MM-dd')
           and trunc(time) <=
               to_date(date_view_param.get_end(), 'yyyy-MM-dd')
         group by trunc(time), breedid
        union
        select sum(price * quantity) tradeamount,
               trunc(time) tradedate,
               breedid
          from e_trade_h
         where status = '8'
           and trunc(time) >=
               to_date(date_view_param.get_start(), 'yyyy-MM-dd')
           and trunc(time) <=
               to_date(date_view_param.get_end(), 'yyyy-MM-dd')
         group by trunc(time), breedid) a,
       m_breed b
 where a.breedid = b.breedid
   and b.status <> 2
   and belongmodule like '%23%'
 group by b.breedid, b.breedname
;

prompt
prompt Creating view V_E_BREED_TRADE_STAT
prompt ==================================
prompt
create or replace force view v_e_breed_trade_stat as
select b.breedid,                                                     --品名ID
       b.breedname,                                                   --品名
       nvl(sum(cnt), 0) cnt,                                          --成交笔数
       nvl(sum(TotalPrice) / sum(TotalQuantity), 0) EvenPrice,        --成交均价
       nvl(sum(TotalPrice), 0) TotalPrice,                            --成交金额
       nvl(sum(TotalQuantity), 0) TotalQuantity,                      --成交数量
       nvl(sum(TotalQuantity) / sum(cnt), 0) EvenQuantity             --成交均量
  from (select breedid, breedname from m_breed where status <> 2 and belongmodule like '%23%') b
  left join (select m.breedid breedid,
                    count(1) cnt,
                    sum(m.price * m.quantity) TotalPrice,
                    sum(quantity) TotalQuantity,
                    trunc(time) tradedate
               from (select breedid, price, quantity, time, tradeno
                       from e_trade
                      where status = '8'
                     union
                     select breedid, price, quantity, time, tradeno
                       from e_trade_h
                      where status = '8') m
              group by m.breedid, trunc(time)) a on a.breedid = b.breedid
                                                and tradedate >=
                                                    to_date(date_view_param.get_start(),
                                                            'yyyy-MM-dd')
                                                and tradedate <=
                                                    to_date(date_view_param.get_end(),
                                                            'yyyy-MM-dd')
 group by b.breedid, b.breedname
;

prompt
prompt Creating view V_E_BREED_TRADE_TYPE_STAT
prompt =======================================
prompt
create or replace force view v_e_breed_trade_type_stat as
select m.breedid,           --品名ID
       g.breedname,         --品名
       sum(xieyi) xieyi,    --协议交收合同
       sum(zizhu) zizhu     --自主交收合同
  from (select n.breedid, tradedate, sum(xieyi) xieyi, sum(zizhu) zizhu
          from (select count(tradetype) xieyi,
                       null zizhu,
                       trunc(time) tradedate,
                       t.breedid
                  from e_trade t
                 where tradetype = '0'
                 group by trunc(time), t.breedid
                union all
                select count(tradetype) xieyi,
                       null zizhu,
                       trunc(time) tradedate,
                       t.breedid
                  from e_trade_h t
                 where tradetype = '0'
                 group by trunc(time), t.breedid
                union all
                select null xieyi,
                       count(tradetype) zizhu,
                       trunc(time) tradedate,
                       t.breedid
                  from e_trade t
                 where tradetype = '1'
                 group by trunc(time), t.breedid
                union all
                select null xieyi,
                       count(tradetype) zizhu,
                       trunc(time) tradedate,
                       t.breedid
                  from e_trade_h t
                 where tradetype = '1'
                 group by trunc(time), t.breedid) n
         where trunc(n.tradedate) >=
               to_date(date_view_param.get_start(), 'yyyy-MM-dd')
           and trunc(n.tradedate) <=
               to_date(date_view_param.get_end(), 'yyyy-MM-dd')
         group by n.breedid, n.tradedate) m,
       m_breed g
 where m.breedid = g.breedid
       and g.status <> 2
       and belongmodule like '%23%'
 group by m.breedid, g.breedname
;

prompt
prompt Creating view V_E_CATEGORY_ORDER_SEQUENCE
prompt =========================================
prompt
create or replace force view v_e_category_order_sequence as
select b.categoryid,                                        --商品分类号
       b.categoryname,                                      --商品分类名称
       nvl(sum(cnt), 0) cnt,                                --委托笔数
       nvl(sum(TotalPrice) / sum(quantity), 0) EvenPrice,   --均价
       nvl(sum(TotalPrice), 0) TotalPrice,                  --委托金额
       nvl(sum(quantity), 0) quantity,                      --委托数量
       nvl(sum(tradeqty), 0) tradeqty                       --成交数量
  from (select categoryid, categoryname
          from m_category
         where categoryid <> -1
           and status <> 2
           and type = 'leaf'
           and belongmodule like '%23%') b
  left join (select n.categoryid,
                    count(*) cnt,
                    sum(price * quantity) TotalPrice,
                    sum(quantity) quantity,
                    sum(tradedqty) tradeqty,
                    trunc(n.ordertime) as ordertime
               from e_order n
              group by n.categoryid, trunc(n.ordertime)
             union
             select n.categoryid,
                    count(*) cnt,
                    sum(price * quantity) TotalPrice,
                    sum(quantity) quantity,
                    sum(tradedqty) tradeqty,
                    trunc(n.ordertime) as ordertime
               from e_Order_h n
              group by n.categoryid, trunc(n.ordertime)) a on a.categoryid =
                                                              b.categoryid
                                                          and ordertime > =
                                                              to_date(date_view_param.get_start(),
                                                                      'yyyy-MM-dd')
                                                          and ordertime <=
                                                              to_date(date_view_param.get_end(),
                                                                      'yyyy-MM-dd')
 group by b.categoryid, b.categoryname
;

prompt
prompt Creating view V_E_CATEGORY_ORDER_STAT
prompt =====================================
prompt
create or replace force view v_e_category_order_stat as
select b.categoryid,                                      --商品分类号
       b.categoryname,                                    --商品分类名称
       b.bsflag bsflag,                                   --买卖方向
       nvl(sum(cnt), 0) cnt,                              --委托笔数
       nvl(sum(TotalPrice) / sum(quantity), 0) EvenPrice, --均价
       nvl(sum(TotalPrice), 0) TotalPrice,                --委托金额
       nvl(sum(quantity), 0) quantity,                    --委托数量
       nvl(sum(tradeqty), 0) tradeqty                     --成交数量
  from (select 'B' bsflag, categoryid, categoryname
          from m_category
         where categoryid <> -1
           and status <> 2
           and type = 'leaf'
           and belongmodule like '%23%'
        union
        select 'S' bsflag, categoryid, categoryname
          from m_category
         where categoryid <> -1
         and status <> 2
         and type = 'leaf'
         and belongmodule like '%23%') b
  left join (select n.categoryid,
                    'B' bsflag,
                    count(*) cnt,
                    sum(price * quantity) TotalPrice,
                    sum(quantity) quantity,
                    sum(tradedqty) tradeqty,
                    trunc(n.ordertime) as ordertime
               from e_order n
              where n.bsflag = 'B'
              group by n.categoryid, trunc(n.ordertime)
             union
             select n.categoryid,
                    'B' bsflag,
                    count(*) cnt,
                    sum(price * quantity) TotalPrice,
                    sum(quantity) quantity,
                    sum(tradedqty) tradeqty,
                    trunc(n.ordertime) as ordertime
               from e_Order_h n
              where n.bsflag = 'B'
              group by n.categoryid, trunc(n.ordertime)
             union
             select n.categoryid,
                    'S' bsflag,
                    count(*) cnt,
                    sum(price * quantity) TotalPrice,
                    sum(quantity) quantity,
                    sum(tradedqty) tradeqty,
                    trunc(n.ordertime) as ordertime
               from e_order n
              where n.bsflag = 'S'
              group by n.categoryid, trunc(n.ordertime)
             union
             select n.categoryid,
                    'S' bsflag,
                    count(*) cnt,
                    sum(price * quantity) TotalPrice,
                    sum(quantity) quantity,
                    sum(tradedqty) tradeqty,
                    trunc(n.ordertime) as ordertime
               from e_order_h n
              where n.bsflag = 'S'
              group by n.categoryid, trunc(n.ordertime)) a on a.categoryid =
                                                              b.categoryid
                                                          and b.bsflag =
                                                              a.bsflag
                                                          and ordertime >=
                                                              to_date(date_view_param.get_start(),
                                                                      'yyyy-MM-dd')
                                                          and ordertime <=
                                                              to_date(date_view_param.get_end(),
                                                                      'yyyy-MM-dd')
 group by b.categoryid, b.bsflag, b.categoryname
;

prompt
prompt Creating view V_E_CATEGORY_REVENUE_STAT
prompt =======================================
prompt
create or replace force view v_e_category_revenue_stat as
select c.categoryid, --商品分类好
       c.categoryname, --商品分类名称
       sum(s.xiyie) tradefee, --交易手续费
       sum(s.jiaoshou) deliveryfee, --教授手续费
       sum(s.xiyie) + sum(s.jiaoshou) sumfee --手续费总额
  from (select m.tradecode,
               sum(m.xiyie) xiyie,
               m.deliverycode,
               sum(m.jiaoshou) jiaoshou,
               m.tradeno,
               m.dat,
               n.breedid
          from (select a.oprcode tradecode,
                       a.xiyie xiyie,
                       b.oprcode deliverycode,
                       b.jiaoshou jiaoshou,
                       a.tradeno,
                       a.dat dat
                  from (select t.oprcode,
                               sum(amount) xiyie,
                               t.contractno tradeno,
                               trunc(t.createtime) dat
                          from f_fundflow t
                         where t.oprcode = '23001'
                         group by t.oprcode, trunc(t.createtime), t.contractno
                         order by trunc(t.createtime) desc) a,
                       (select t.oprcode,
                               sum(amount) jiaoshou,
                               t.contractno tradeno,
                               trunc(t.createtime) dat
                          from f_fundflow t
                         where t.oprcode = '23004'
                         group by t.oprcode, trunc(t.createtime), t.contractno
                         order by trunc(t.createtime) desc) b
                 where a.dat = b.dat
                   and a.tradeno = b.tradeno) m,
               e_trade n
         where m.tradeno = n.tradeno
           and trunc(m.dat) >=
               to_date(date_view_param.get_start(), 'yyyy-MM-dd')
           and trunc(m.dat) <=
               to_date(date_view_param.get_end(), 'yyyy-MM-dd')
         group by m.dat, m.tradeno, m.tradecode, m.deliverycode, n.breedid
        union all
        select m.tradecode,
               sum(m.xiyie) xiyie,
               m.deliverycode,
               sum(m.jiaoshou) jiaoshou,
               m.tradeno,
               m.dat,
               n.breedid
          from (select a.oprcode tradecode,
                       a.xiyie xiyie,
                       b.oprcode deliverycode,
                       b.jiaoshou jiaoshou,
                       a.tradeno,
                       a.dat dat
                  from (select t.oprcode,
                               sum(amount) xiyie,
                               t.contractno tradeno,
                               trunc(t.createtime) dat
                          from f_fundflow t
                         where t.oprcode = '23001'
                         group by t.oprcode, trunc(t.createtime), t.contractno
                         order by trunc(t.createtime) desc) a,
                       (select t.oprcode,
                               sum(amount) jiaoshou,
                               t.contractno tradeno,
                               trunc(t.createtime) dat
                          from f_fundflow t
                         where t.oprcode = '23004'
                         group by t.oprcode, trunc(t.createtime), t.contractno
                         order by trunc(t.createtime) desc) b
                 where a.dat = b.dat
                   and a.tradeno = b.tradeno) m,
               e_trade_h n
         where m.tradeno = n.tradeno
           and trunc(m.dat) >=
               to_date(date_view_param.get_start(), 'yyyy-MM-dd')
           and trunc(m.dat) <=
               to_date(date_view_param.get_end(), 'yyyy-MM-dd')
         group by m.dat, m.tradeno, m.tradecode, m.deliverycode, n.breedid
        union all
        select m.tradecode,
               sum(m.xiyie) xiyie,
               m.deliverycode,
               sum(m.jiaoshou) jiaoshou,
               m.tradeno,
               m.dat,
               n.breedid
          from (select a.oprcode tradecode,
                       a.xiyie xiyie,
                       b.oprcode deliverycode,
                       b.jiaoshou jiaoshou,
                       a.tradeno,
                       a.dat dat
                  from (select t.oprcode,
                               sum(amount) xiyie,
                               t.contractno tradeno,
                               trunc(t.createtime) dat
                          from f_h_fundflow t
                         where t.oprcode = '23001'
                         group by t.oprcode, trunc(t.createtime), t.contractno
                         order by trunc(t.createtime) desc) a,
                       (select t.oprcode,
                               sum(amount) jiaoshou,
                               t.contractno tradeno,
                               trunc(t.createtime) dat
                          from f_h_fundflow t
                         where t.oprcode = '23004'
                         group by t.oprcode, trunc(t.createtime), t.contractno
                         order by trunc(t.createtime) desc) b
                 where a.dat = b.dat
                   and a.tradeno = b.tradeno) m,
               e_trade n
         where m.tradeno = n.tradeno
           and trunc(m.dat) >=
               to_date(date_view_param.get_start(), 'yyyy-MM-dd')
           and trunc(m.dat) <=
               to_date(date_view_param.get_end(), 'yyyy-MM-dd')
         group by m.dat, m.tradeno, m.tradecode, m.deliverycode, n.breedid
        union all
        select m.tradecode,
               sum(m.xiyie) xiyie,
               m.deliverycode,
               sum(m.jiaoshou) jiaoshou,
               m.tradeno,
               m.dat,
               n.breedid
          from (select a.oprcode tradecode,
                       a.xiyie xiyie,
                       b.oprcode deliverycode,
                       b.jiaoshou jiaoshou,
                       a.tradeno,
                       a.dat dat
                  from (select t.oprcode,
                               sum(amount) xiyie,
                               t.contractno tradeno,
                               trunc(t.createtime) dat
                          from f_h_fundflow t
                         where t.oprcode = '23001'
                         group by t.oprcode, trunc(t.createtime), t.contractno
                         order by trunc(t.createtime) desc) a,
                       (select t.oprcode,
                               sum(amount) jiaoshou,
                               t.contractno tradeno,
                               trunc(t.createtime) dat
                          from f_h_fundflow t
                         where t.oprcode = '23004'
                         group by t.oprcode, trunc(t.createtime), t.contractno
                         order by trunc(t.createtime) desc) b
                 where a.dat = b.dat
                   and a.tradeno = b.tradeno) m,
               e_trade_h n
         where m.tradeno = n.tradeno
           and trunc(m.dat) >=
               to_date(date_view_param.get_start(), 'yyyy-MM-dd')
           and trunc(m.dat) <=
               to_date(date_view_param.get_end(), 'yyyy-MM-dd')
         group by m.dat, m.tradeno, m.tradecode, m.deliverycode, n.breedid) s, m_breed g, m_category c
 where s.breedid = g.breedid
   and g.status <> 2
   and g.categoryid = c.categoryid
   and c.status <> 2
   and c.categoryid <> -1
   and c.type = 'leaf'
   and c.belongmodule like '%23%'
 group by c.categoryid, c.categoryname
;

prompt
prompt Creating view V_E_CATEGORY_TRADE_AMOUNT_STAT
prompt ============================================
prompt
create or replace force view v_e_category_trade_amount_stat as
select c.categoryid,                                    --商品分类号
       c.categoryname,                                  --商品名称
       sum(a.tradeamount) tradeamount                   --成交额
  from (select sum(price * quantity) tradeamount,
               trunc(time) tradedate,
               breedid
          from e_trade
         where status = '8'
           and trunc(time) >=
               to_date(date_view_param.get_start(), 'yyyy-MM-dd')
           and trunc(time) <=
               to_date(date_view_param.get_end(), 'yyyy-MM-dd')
         group by trunc(time), breedid
        union
        select sum(price * quantity) tradeamount,
               trunc(time) tradedate,
               breedid
          from e_trade_h
         where status = '8'
           and trunc(time) >=
               to_date(date_view_param.get_start(), 'yyyy-MM-dd')
           and trunc(time) <=
               to_date(date_view_param.get_end(), 'yyyy-MM-dd')
         group by trunc(time), breedid) a,
       m_breed b,
       m_category c
 where a.breedid = b.breedid
   and b.categoryid = c.categoryid
   and b.status <> 2
   and c.status <> 2
   and c.categoryid <> -1
   and type = 'leaf'
   and c.belongmodule like '%23%'
 group by c.categoryid, c.categoryname
;

prompt
prompt Creating view V_E_CATEGORY_TRADE_STAT
prompt =====================================
prompt
create or replace force view v_e_category_trade_stat as
select i.categoryid,                                              --商品分类号
       i.categoryname,                                            --商品分类名称
       nvl(sum(cnt), 0) cnt,                                      --成交笔数
       nvl(sum(TotalPrice) / sum(TotalQuantity), 0) EvenPrice,    --成交均价
       nvl(sum(TotalPrice), 0) TotalPrice,                        --成交金额
       nvl(sum(TotalQuantity), 0) TotalQuantity,                  --成交数量
       nvl(sum(TotalQuantity) / sum(cnt), 0) EvenQuantity         --成交均量
  from (select x.categoryid, x.categoryname
          from m_category x
         where categoryid <> -1
           and status <> 2
           and type = 'leaf'
           and belongmodule like '%23%') i
  left join (select TotalQuantity,
                    TotalPrice,
                    cnt,
                    a.tradetime,
                    a.breedid,
                    g.categoryid
               from (select sum(t.quantity) TotalQuantity,
                            sum(t.price * t.quantity) TotalPrice,
                            count(1) cnt,
                            trunc(tradetime) tradetime,
                            breedid
                       from (select price,
                                    quantity,
                                    trunc(time) tradetime,
                                    tradeno,
                                    breedid
                               from e_trade
                              where status = '8'
                             union
                             select price,
                                    quantity,
                                    trunc(time) tradetime,
                                    tradeno,
                                    breedid
                               from e_trade_h
                              where status = '8') t
                      group by t.breedid, trunc(tradetime)) a,
                    m_breed g
              where a.breedid = g.breedid
                and g.status <> 2) u on i.categoryid = u.categoryid
                                    and tradetime >=
                                        to_date(date_view_param.get_start(),
                                                'yyyy-MM-dd')
                                    and tradetime <=
                                        to_date(date_view_param.get_end(),
                                                'yyyy-MM-dd')
 group by i.categoryid, i.categoryname
;

prompt
prompt Creating view V_E_CATEGORY_TRADE_TYPE_STAT
prompt ==========================================
prompt
create or replace force view v_e_category_trade_type_stat as
select y.categoryid, --商品分类号
       y.categoryname, --分类名称
        sum(xieyi) xieyi,    --协议交收合同
       sum(zizhu) zizhu     --自主交收合同
  from (select n.breedid, tradedate, sum(xieyi) xieyi, sum(zizhu) zizhu
          from (select count(tradetype) xieyi,
                       null zizhu,
                       trunc(time) tradedate,
                       t.breedid
                  from e_trade t
                 where tradetype = '0'
                 group by trunc(time), t.breedid
                union all
                select count(tradetype) xieyi,
                       null zizhu,
                       trunc(time) tradedate,
                       t.breedid
                  from e_trade_h t
                 where tradetype = '0'
                 group by trunc(time), t.breedid
                union all
                select null xieyi,
                       count(tradetype) zizhu,
                       trunc(time) tradedate,
                       t.breedid
                  from e_trade t
                 where tradetype = '1'
                 group by trunc(time), t.breedid
                union all
                select null xieyi,
                       count(tradetype) zizhu,
                       trunc(time) tradedate,
                       t.breedid
                  from e_trade_h t
                 where tradetype = '1'
                 group by trunc(time), t.breedid) n
         where trunc(n.tradedate) >=
               to_date(date_view_param.get_start(), 'yyyy-MM-dd')
           and trunc(n.tradedate) <=
               to_date(date_view_param.get_end(), 'yyyy-MM-dd')
         group by n.breedid, n.tradedate) m,
       m_breed g,
       m_category y
 where m.breedid = g.breedid
   and g.categoryid = y.categoryid
   and g.status <> 2
   and y.status <> 2
   and y.categoryid <> -1
   and type = 'leaf'
   and y.belongmodule like '%23%'
 group by y.categoryid, y.categoryname
;

prompt
prompt Creating view V_E_FIRM_ORDER_STAT
prompt =================================
prompt
create or replace force view v_e_firm_order_stat as
select b.firmid firmid,                             --交易商代码
       b.name name,                                 --交易商名称
       b.bsflag bsflag,                             --买卖方向
       nvl(sum(cnt), 0) cnt,                        --委托笔数
       nvl(sum(TotalPrice) /sum(quantity), 0) EvenPrice, --均价
       nvl(sum(TotalPrice), 0) TotalPrice,          --委托金额
       nvl(sum(quantity), 0) quantity,              --委托数量
       nvl(sum(tradeqty), 0) tradeqty               --成交数量
  from (select 'B' bsflag, firmid, name
          from m_firm
        union
        select 'S' bsflag, firmid, name from m_firm) b
  left join (select n.firmid,
                    'B' bsflag,
                    count(*) cnt,
                    sum(price * quantity) TotalPrice,
                    sum(quantity) quantity,
                    sum(tradedqty) tradeqty,
                    trunc(n.ordertime) as ordertime
               from e_order n
              where n.bsflag = 'B'
              group by n.firmid, trunc(n.ordertime)
             union
             select n.firmid,
                    'B' bsflag,
                    count(*) cnt,
                    sum(price * quantity) TotalPrice,
                    sum(quantity) quantity,
                    sum(tradedqty) tradeqty,
                    trunc(n.ordertime) as ordertime
               from e_Order_h n
              where n.bsflag = 'B'
              group by n.firmid, trunc(n.ordertime)
             union
             select n.firmid,
                    'S' bsflag,
                    count(*) cnt,
                    sum(price * quantity) TotalPrice,
                    sum(quantity) quantity,
                    sum(tradedqty) tradeqty,
                    trunc(n.ordertime) as ordertime
               from e_order n
              where n.bsflag = 'S'
              group by n.firmid, trunc(n.ordertime)
             union
             select n.firmid,
                    'S' bsflag,
                    count(*) cnt,
                    sum(price * quantity) TotalPrice,
                    sum(quantity) quantity,
                    sum(tradedqty) tradeqty,
                    trunc(n.ordertime) as ordertime
               from e_order_h n
              where n.bsflag = 'S'
              group by n.firmid, trunc(n.ordertime)) a on a.firmid =
                                                          b.firmid
                                                      and b.bsflag =
                                                          a.bsflag
                                                      and ordertime >=
                                                          to_date(date_view_param.get_start(),
                                                                  'yyyy-MM-dd')
                                                      and ordertime <=
                                                          to_date(date_view_param.get_end(),
                                                                  'yyyy-MM-dd')
 group by b.firmid, b.bsflag, b.name
;

prompt
prompt Creating view V_E_FIRM_RANKING_STAT
prompt ===================================
prompt
create or replace force view v_e_firm_ranking_stat as
select b.firmid,                                                   --交易商代码
       b.name,                                                     --交易商名称
       nvl(sum(cnt), 0) cnt,                                       --成交笔数
       nvl(sum(TotalQuantity), 0) TotalQuantity                    --成交数量
  from (select firmid, name from m_firm) b
  left join (select n.firmid firmid,
                    count(1) cnt,
                    sum(quantity) TotalQuantity,
                    trunc(time) tradedate
               from (select quantity, time, tradeno
                       from e_trade
                      where status = '8'
                     union
                     select quantity, time, tradeno
                       from e_trade_h
                      where status = '8') m,
                    (select firmid, tradeno
                       from e_holding
                     union
                     select firmid, tradeno from e_holding_h) n
              where m.tradeno = n.tradeno
              group by n.firmid, trunc(time)) a on a.firmid = b.firmid
                                               and tradedate >=
                                                   to_date(date_view_param.get_start(),
                                                           'yyyy-MM-dd')
                                               and tradedate <=
                                                   to_date(date_view_param.get_end(),
                                                           'yyyy-MM-dd')
 group by b.firmid, b.name
;

prompt
prompt Creating view V_E_FIRM_TRADE_STAT
prompt =================================
prompt
create or replace force view v_e_firm_trade_stat as
select b.firmid,                                               --交易商代码
       b.name,                                                 --交易商名称
       nvl(sum(cnt), 0) cnt,                                   --成交笔数
       nvl(sum(TotalPrice) / sum(TotalQuantity), 0) EvenPrice, --成交均价
       nvl(sum(TotalPrice), 0) TotalPrice,                     --成交金额
       nvl(sum(TotalQuantity), 0) TotalQuantity,               --成交数量
       nvl(sum(TotalQuantity) / sum(cnt), 0) EvenQuantity      --成交均量
  from (select firmid, name from m_firm) b
  left join (select n.firmid firmid,
                    count(1) cnt,
                    sum(m.price * m.quantity) TotalPrice,
                    sum(quantity) TotalQuantity,
                    trunc(time) tradedate
               from (select price, quantity, time, tradeno
                       from e_trade
                      where status = '8'
                     union
                     select price, quantity, time, tradeno
                       from e_trade_h
                      where status = '8') m,
                    (select firmid, tradeno
                       from e_holding
                     union
                     select firmid, tradeno from e_holding_h) n
              where m.tradeno = n.tradeno
              group by n.firmid, trunc(time)) a on a.firmid = b.firmid
                                               and tradedate >=
                                                   to_date(date_view_param.get_start(),
                                                           'yyyy-MM-dd')
                                               and tradedate <=
                                                   to_date(date_view_param.get_end(),
                                                           'yyyy-MM-dd')
 group by b.firmid, b.name
;

prompt
prompt Creating view V_E_FUND_RANKING_STAT
prompt ===================================
prompt
create or replace force view v_e_fund_ranking_stat as
select
         a.firmid,            --交易商代码
         a.margin,            --占用保证金
         a.goodsmoney,        --占用货款
         a.subscription,      --诚信保障金
         b.balance,           --余额
         a.margin + a.goodsmoney + a.subscription + b.balance equity--权益
from e_funds a, f_firmfunds b
    where a.firmid = b.firmid
;

prompt
prompt Creating view V_E_PLATFORM_REVENUE_STAT
prompt =======================================
prompt
create or replace force view v_e_platform_revenue_stat as
select
    sum(tradefee) tradefee,         --交易手续费（业务代码为‘23001‘）
    sum(deliveryfee) deliveryfee,   --交收手续费（业务代码为‘23004‘）
    dat tradedate                   --平台收入日期
from(
    select a.dat dat,a.code shou,a.amount deliveryfee,b.code yi,b.amount tradefee from
        (select oprcode code,sum(amount) amount,trunc(createtime) dat from f_fundflow where oprcode='23004' group by oprcode,trunc(createtime)) a,
        (select oprcode code,sum(amount) amount,trunc(createtime) dat from f_fundflow where oprcode='23001' group by oprcode,trunc(createtime)) b
      where a.dat=b.dat and b.amount <> 0 and a.amount <> 0
    union
    select c.dat dat,c.code shou,c.amount deliveryfee,d.code yi,d.amount tradefee from
        (select oprcode code,sum(amount) amount,trunc(createtime) dat from f_h_fundflow where oprcode='23004' group by oprcode,trunc(createtime)) c,
        (select oprcode code,sum(amount) amount,trunc(createtime) dat from f_h_fundflow where oprcode='23001' group by oprcode,trunc(createtime)) d
      where c.dat=d.dat and d.amount <> 0 and c.amount <> 0
) where 1=1
group by dat
;

prompt
prompt Creating view V_E_TRADE_BREACH_STAT
prompt ===================================
prompt
create or replace force view v_e_trade_breach_stat as
select tradedate,                            --成交日期
       sum(cnt) cnt,                         --违约笔数
       sum(quantity) quantity                --违约数量
  from
      (select trunc(time) tradedate,
           count(1) cnt,
           sum(quantity) quantity
           from e_trade where status in (1,4) group by trunc(time)
           union
        select trunc(time) tradedate,
           count(1) cnt,
           sum(quantity) quantity
           from e_trade_h where status in (1,4) group by trunc(time))
            group by tradedate
;

prompt
prompt Creating function FN_E_CANOUTSUBSCRIPTION
prompt =========================================
prompt
create or replace function FN_E_CanOutSubscription(p_firmid varchar2, --交易商代码
                                                   p_lock   number --是否上锁 1:上锁 0：不上锁
                                                   ) return number
/***
  * 获取可出诚信保证金
  * 返回值：可出诚信保证金
  ****/
 is
  v_LeastSubscription     number(15, 2); --最少应该保留的诚信保障金
  v_SumSubscription       number(15, 2); --订单全部违约所需诚信保障金
  v_CanOut                number(15, 2); --可出诚信保障金
  v_UnTradecnt            number(10); --未成交的委托数量
  v_OneTradeMargin        number(15, 2); --单笔委托所需诚信保障金
  v_OrderHoldSubscription number(15, 2); --委托占用的诚信保障金
begin

  select a.totalOrder + b.totalSubOrder
    into v_UnTradecnt
    from -- 委托状态 0：未成交 1：部分成交 2：全部成交 3：已下架 11：待后台管理员审核
         (select count(*) totalOrder
            from E_order o
           where o.firmid = p_firmid
             and (o.status = 0 or o.status = 1 or o.status = 11)
             and o.ispaymargin = 'N' --没有支付保证金
             and o.pledgeflag = 0) a, --不是卖仓单
         --议价表状态 0：等待挂牌方答复 并且是没有交保证金的
         (select count(*) totalSubOrder from(
           select case
                    when o.bsflag = 'B' then
                     t.deliverymargin_s
                    else
                     t.deliverymargin_b
                  end as margin,t.frozenmargin
             from E_suborder t, E_order o
             where t.subFirmID = p_firmid and t.orderid=o.orderid and t.status = 0) where margin!=frozenmargin) b;

  --计算全部订单违约所需诚信保证金
  select sum(trademargin)
    into v_SumSubscription
    from (select case
                   when r.bsflag = 'B' then
                    t.trademargin_b
                   else
                    t.trademargin_s
                 end as trademargin
            from E_reserve r, E_trade t
           where r.tradeno = t.tradeno
             and r.firmid = p_firmid
             and r.status = 0);

  select x.runtimevalue
    into v_OneTradeMargin
    from E_systemprops x
   where x.key = 'OneTradeMargin'; --单笔委托所需诚信保障金
  --计算委托占用的诚信保障金
  v_OrderHoldSubscription := v_UnTradecnt * v_OneTradeMargin;

  if v_SumSubscription is NULL then
    v_SumSubscription := 0;
  end if;

  if v_OrderHoldSubscription is NULL then
    v_OrderHoldSubscription := 0;
  end if;

  v_LeastSubscription := v_OrderHoldSubscription + v_SumSubscription;

  if (p_lock = 1) then
    select f.subscription - v_LeastSubscription
      into v_CanOut
      from E_funds f
     where firmid = p_firmid
       for update;
  else
    select f.subscription - v_LeastSubscription
      into v_CanOut
      from E_funds f
     where firmid = p_firmid;
  end if;

  if (v_CanOut < 0) then
    v_CanOut := 0;
  end if;

  return v_CanOut;
end;
/

prompt
prompt Creating function FN_E_FIRMADD
prompt ==============================
prompt
create or replace function FN_E_firmADD
(
    p_FirmID m_firm.firmid%type --交易商代码
)
return integer is
  /**
  * 现货系统添加交易商
  * 返回值： 1 成功
  **/
  v_cnt                number(4); --数字变量
begin
  select count(*) into v_cnt from E_firm where firmid = p_FirmID;
   if (v_cnt > 0) then
    --如果交易商已经存在则重新设置交易商信息
    update E_firm set firmlevel=1,createtime= sysdate  where firmid=p_FirmID;
    update E_funds set margin=0,goodsmoney= 0,transferloss=0,subscription=0  where firmid=p_FirmID;
    update E_firminfo set firmsummary=null,firmxml=null  where firmid=p_FirmID;
    update E_shop set ShopName=' ',ShopLevel= 0  where firmid=p_FirmID;
  end if;

  insert into E_firm
      (firmid, firmlevel, createtime)
  values
      (p_FirmID, 1, sysdate);
  insert into E_funds
      (firmid, margin, goodsmoney, transferloss, subscription)
  values
      (p_FirmID, 0, 0, 0, 0);
  insert into E_firminfo
      (firmid, firmsummary, firmxml)
  values
      (p_FirmID, null, null);
  insert into E_shop
      (firmid,ShopName,ShopLevel)
  values
      (p_FirmID,' ',0);

  --财务增加200800科目，用于记录交易商诚信保证金
  select count(*) into v_cnt from f_account where Code='200800'||p_FirmID;
  if(v_cnt=0)then
    insert into f_account(Code,Name,accountLevel,dCFlag)
    select '200800'||p_FirmID,name||p_FirmID,3,'C' from f_account
    where code='200800';
  end if;

  return 1;
end;
/

prompt
prompt Creating function FN_E_FIRMDEL
prompt ==============================
prompt
create or replace function FN_E_FirmDel
(
    p_FirmID   m_firm.firmid%type--交易商代码
)
return integer is
  /**
  * 删除交易商
  * 返回值： 1 成功
  **/
  v_cnt                number(4); --数字变量
  v_ordercount         number(4); --委托数字变量
  v_tradecount         number(4); --合同数字变量
  v_subordercount      number(4); --议价数字变量
  f_margin               number(15,2); --保证金变量
  f_goodsmoney           number(15,2); --货款变量
  f_transferloss         number(15,2); --转出金额变量
  f_subscription         number(15,2); --诚信保证金变量
  RET_ORDERERROR integer:=-230;--有未结束的委托
  RET_TRADEERROR integer:=-231;--有未结束的合同
  RET_SUBORDERERROR integer:=-232;--有未答复的议价
  RET_MARGINERROR integer:=-233;--交易商保证金不为0
  RET_MONEYERROR integer:=-234;--交易商货款不为0
  RET_TRANERROR integer:=-235;--交易商转出金额不为0
  RET_SUBERROR integer:=-236;--交易商诚信金不为0
begin
   --委托若存在状态不是2:全部成交或者3:已下架 不能注销交易商
   select count(*) into v_ordercount from e_order o where o.firmid=p_FirmID and o.status not in(2,3);
   if(v_ordercount>0)then
   return RET_ORDERERROR;
   end if;
    --合同若存在状态不是8:结束或者1:订单阶段违约 或者2:系统撤销订单或者4:成交阶段违约 不能注销交易商
   select count(*) into v_tradecount from e_trade t where (t.bfirmid=p_FirmID or t.sfirmid=p_FirmID) and t.status not in (1,2,4,8);
   if(v_tradecount>0)then
   return RET_TRADEERROR;
   end if;
   --议价若存在状态为0:等待答复 不能注销交易商
   select count(*) into v_subordercount from e_suborder s where s.subfirmid=p_FirmID and s.status=0;
   if(v_subordercount>0)then
   return RET_SUBORDERERROR;
   end if;

    --该交易商的资金信息若某一项资金值不为0 不能注销交易商
   select f.margin,f.goodsmoney,f.transferloss,f.subscription into f_margin,f_goodsmoney,f_transferloss,f_subscription from e_funds f where f.firmid=p_FirmID;
   if(f_margin>0)then
     return RET_MARGINERROR;
   end if;
   if(f_goodsmoney>0)then
     return RET_MONEYERROR;
   end if;
   if(f_transferloss>0)then
     return RET_TRANERROR;
   end if;
   if(f_subscription>0)then
     return RET_SUBERROR;
   end if;
   /**
   For循环是属于该交易商的模版信息并删除模版属性查询出来。

   for template in (select g.templateid from e_goodstemplate g where g.belongtouser=p_FirmID) loop
       delete from e_goodstemplateproperty tp where tp.templateid=template.templateid;
       end loop;
   --删除该交易商模版信息
   delete from e_goodstemplate te where te.belongtouser=p_FirmID;
    **/
   /**
   For循环是属于该交易商的预备委托信息并删除预备委托属性查询出来。

   for goodsresource in (select r.resourceid from e_goodsresource r where r.firmid=p_FirmID) loop
       delete from e_goodsresourceproperty rp where rp.resourceid=goodsresource.resourceid;
       delete from e_goodsresourcepic gpic where gpic.resourceid=goodsresource.resourceid;
       end loop;
    --删除该交易商预备委托信息
   delete from e_goodsresource r where r.firmid=p_FirmID;
   --删除特殊交易手续费
   delete from e_tradefee f where f.firmid=p_FirmID;
   --删除特殊交收手续费
   delete from e_deliveryfee f where f.firmid=p_FirmID;
   --删除特殊履约保证金
   delete from e_deliverymargin f where f.firmid=p_FirmID;
   --删除特殊交易商权限
   delete from e_traderight f where f.firmid=p_FirmID;
   **/
   --删除推荐店铺
   delete from e_recommendshop f where f.firmid=p_FirmID;
   return 1;
end;
/

prompt
prompt Creating function FN_E_FIRMTOSTATUS
prompt ===================================
prompt
create or replace function FN_E_FirmToStatus
(
    p_FirmID   m_firm.firmid%type--交易商代码
)
return integer is
  /**
  * 修改交易商状态
  * 返回值： 1 成功
  **/
  v_cnt                number(4); --数字变量
begin

    return 1;
end;
/

prompt
prompt Creating procedure SP_E_MOVEHISTORY
prompt ===================================
prompt
create or replace procedure SP_E_MoveHistory(p_EndDate Date) as
/**
 * 转历史
 **/
begin
  ---------------------------委托相关
  --转议价
  insert into e_suborder_h(suborderid, orderid, subfirmid, quantity, price, warehouseid, TradePreTime, deliverymargin_b, deliverymargin_s,FrozenMargin, remark, status, createtime, reply, replytime, withdrawer, withdrawtime, DeliveryPreTime, DeliveryDayType, DeliveryDay)
  select suborderid, orderid, subfirmid, quantity, price, warehouseid, TradePreTime, deliverymargin_b, deliverymargin_s,FrozenMargin, remark, status, createtime, reply, replytime, withdrawer, withdrawtime, DeliveryPreTime, DeliveryDayType, DeliveryDay
    from e_suborder s where s.orderid in
         (select o.orderid from e_order o where o.ordertime <= p_EndDate and o.status in (2,3));--全部成交，已下架
  delete from e_suborder s where s.orderid in
         (select o.orderid from e_order o where o.ordertime <= p_EndDate and o.status in (2,3));
  --转委托属性
  insert into e_goodsproperty_h(orderid, propertyname, propertyvalue, propertyTypeID)
  select orderid, propertyname, propertyvalue, propertyTypeID
    from e_goodsproperty p where p.orderid in
         (select o.orderid from e_order o where o.ordertime <= p_EndDate and o.status in (2,3));
  delete from e_goodsproperty p where p.orderid in
         (select o.orderid from e_order o where o.ordertime <= p_EndDate and o.status in (2,3));
  --转委托图片
  insert into e_OrderPic_H(ID,OrderID,picture)
  select ID,OrderID,picture
    from e_OrderPic p where p.OrderID in
	     (select o.orderid from e_order o where o.ordertime <= p_EndDate and o.status in (2,3));
  delete from e_OrderPic p where p.OrderID in
	     (select o.orderid from e_order o where o.ordertime <= p_EndDate and o.status in (2,3));
  --转委托
  insert into e_order_h(orderid, ordertitle, breedid, bsflag, firmid, price, quantity, unit, TradePreTime, trademargin_b, trademargin_s, deliverydaytype, DeliveryPreTime, deliveryday, deliverymargin_b, deliverymargin_s, deliverytype, warehouseid, deliveryaddress, status, tradedqty, remark, ordertime, traderid, withdrawtime, withdrawtraderid, categoryid, ValidTime, pledgeflag, mintradeqty,TradeUnit,IsPickOff,IsSuborder,IsPayMargin,FrozenMargin,TradeType,PayType,EffectOfTime,StockID)
  select orderid, ordertitle, breedid, bsflag, firmid, price, quantity, unit, TradePreTime, trademargin_b, trademargin_s, deliverydaytype, DeliveryPreTime, deliveryday, deliverymargin_b, deliverymargin_s, deliverytype, warehouseid, deliveryaddress, status, tradedqty, remark, ordertime, traderid, withdrawtime, withdrawtraderid, categoryid, ValidTime, pledgeflag, mintradeqty,TradeUnit,IsPickOff,IsSuborder,IsPayMargin,FrozenMargin,TradeType,PayType,EffectOfTime,StockID
    from e_order o where o.ordertime <= p_EndDate and o.status in (2,3);
  delete from e_order o where o.ordertime <= p_EndDate and o.status in (2,3);


  ---------------------------合同相关
  --1：订单阶段违约 2：订单阶段系统撤销 4：成交阶段违约 8：正常结束
  --转订单
  insert into e_reserve_h(reserveid, tradeno, firmid, realmoney, bsflag, payablereserve, payreserve, backreserve, goodsquantity, status, breachapplyid)
  select reserveid, tradeno, firmid, realmoney, bsflag, payablereserve, payreserve, backreserve, goodsquantity, status, breachapplyid
    from e_reserve r where r.tradeno in
         (select t.tradeno from e_trade t where t.time <= p_EndDate and t.status in (1,2,4,8));
  delete from e_reserve r where r.tradeno in
         (select t.tradeno from e_trade t where t.time <= p_EndDate and t.status in (1,2,4,8));
  --转持仓
  insert into e_holding_h(holdingid, tradeno, firmid, bsflag, realmoney, paymargin, paygoodsmoney, payoff,Receive, transfermoney, status, breachapplyid, offsetid)
  select holdingid, tradeno, firmid, bsflag, realmoney, paymargin, paygoodsmoney, payoff,Receive, transfermoney, status, breachapplyid, offsetid
    from e_holding h where h.tradeno in
         (select t.tradeno from e_trade t where t.time <= p_EndDate and t.status in (1,2,4,8));
  delete from e_holding h where h.tradeno in
         (select t.tradeno from e_trade t where t.time <= p_EndDate and t.status in (1,2,4,8));
  --转合同处理日志
  insert into e_tradeprocesslog_h(logid, tradeno, firmid, operator, processinfo, processtime)
  select logid, tradeno, firmid, operator, processinfo, processtime
    from e_tradeprocesslog l where l.tradeno in
         (select t.tradeno from e_trade t where t.time <= p_EndDate and t.status in (1,2,4,8));
  delete from e_tradeprocesslog l where l.tradeno in
         (select t.tradeno from e_trade t where t.time <= p_EndDate and t.status in (1,2,4,8));
  --转合同属性
  insert into e_trade_goodsproperty_h
    (propertyname, tradeno, propertyvalue, propertyTypeID)
  select propertyname, tradeno, propertyvalue, propertyTypeID
    from e_trade_goodsproperty p where p.tradeno in
         (select t.tradeno from e_trade t where t.time <= p_EndDate and t.status in (1,2,4,8));
  delete from e_trade_goodsproperty p where p.tradeno in
         (select t.tradeno from e_trade t where t.time <= p_EndDate and t.status in (1,2,4,8));
  --转尾款申请
  insert into e_GoodsMoneyApply_H
    (ID, tradeNO, status,type, CreateTime, ProcessTime)
  select ID, tradeNO, status,type, CreateTime, ProcessTime
    from e_GoodsMoneyApply h where h.tradeNO in
	     (select t.tradeno from e_trade t where t.time <= p_EndDate and t.status in (1,2,4,8));
  delete from e_GoodsMoneyApply l where l.tradeNO in
         (select t.tradeno from e_trade t where t.time <= p_EndDate and t.status in (1,2,4,8));
  --转无损益表
  insert into e_NoOffset_h
    (id, tradeno,createtime)
  select id, tradeno,createtime
    from e_NoOffset p where p.tradeno in
         (select t.tradeno from e_trade t where t.time <= p_EndDate and t.status in (1,2,4,8));
  delete from e_NoOffset p where p.tradeno in
         (select t.tradeno from e_trade t where t.time <= p_EndDate and t.status in (1,2,4,8));
  --转成交合同
  insert into e_trade_h(tradeno, ordertitle, breedid, bfirmid, sfirmid, price, quantity, unit, TradePreTime, trademargin_b, trademargin_s, deliveryday, deliverymargin_b, deliverymargin_s, BuyTradeFee,BuyPayTradeFee,BuyDeliveryFee,BuyPayDeliveryFee,SellTradeFee,SellPayTradeFee,SellDeliveryFee,SellPayDeliveryFee,deliverytype, warehouseid, deliveryaddress, time, remark, status, orderid,TradeType,PayType)
  select tradeno, ordertitle, breedid, bfirmid, sfirmid, price, quantity, unit, TradePreTime, trademargin_b, trademargin_s, deliveryday, deliverymargin_b, deliverymargin_s,BuyTradeFee,BuyPayTradeFee,BuyDeliveryFee,BuyPayDeliveryFee,SellTradeFee,SellPayTradeFee,SellDeliveryFee,SellPayDeliveryFee,deliverytype, warehouseid, deliveryaddress, time, remark, status, orderid,TradeType,PayType
    from e_trade t where t.time <= p_EndDate and t.status in (1,2,4,8);
  delete from e_trade t where t.time <= p_EndDate and t.status in (1,2,4,8);
end;
/


spool off
