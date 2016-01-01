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
       count (1) cnt,                     --�ٲ�����
       trunc(t.applytime) applydate       --�ٲ�����
from e_arbitration t
where 1=1
group by trunc(t.applytime)
;

prompt
prompt Creating view V_E_BREED_ORDER_SEQUENCE
prompt ======================================
prompt
create or replace force view v_e_breed_order_sequence as
select b.breedid,                                      --Ʒ��ID
       b.breedname,                                    --Ʒ��
       nvl(sum(cnt), 0) cnt,                           --ί�б���
       nvl(sum(TotalPrice)/sum(quantity), 0) EvenPrice,    --����
       nvl(sum(TotalPrice), 0) TotalPrice,             --ί�н��
       nvl(sum(quantity), 0) quantity,                 --ί������
       nvl(sum(tradeqty), 0) tradeqty                  --�ɽ�����
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
select b.breedid,                                                               --Ʒ��ID
       b.breedname,                                                             --Ʒ��
       b.bsflag bsflag,                                                         --��������
       nvl(sum(cnt), 0) cnt,                                                    --ί�б���
       nvl(sum(TotalPrice) / sum(quantity), 0) EvenPrice,                             --����
       nvl(sum(TotalPrice), 0) TotalPrice,                                      --ί�н��
       nvl(sum(quantity), 0) quantity,                                          --ί������
       nvl(sum(tradeqty), 0) tradeqty                                           --�ɽ�����
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
select g.breedid,                               --Ʒ��ID
       g.breedname,                             --Ʒ��
       sum(s.xiyie) tradefee,                   --����������
       sum(s.jiaoshou) deliveryfee,             --����������
       sum(s.xiyie) + sum(s.jiaoshou) sumfee    --�������ܶ�
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
select b.breedid, --Ʒ��ID
       b.breedname, --Ʒ��
       sum(a.tradeamount) tradeamount --�ɽ���
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
select b.breedid,                                                     --Ʒ��ID
       b.breedname,                                                   --Ʒ��
       nvl(sum(cnt), 0) cnt,                                          --�ɽ�����
       nvl(sum(TotalPrice) / sum(TotalQuantity), 0) EvenPrice,        --�ɽ�����
       nvl(sum(TotalPrice), 0) TotalPrice,                            --�ɽ����
       nvl(sum(TotalQuantity), 0) TotalQuantity,                      --�ɽ�����
       nvl(sum(TotalQuantity) / sum(cnt), 0) EvenQuantity             --�ɽ�����
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
select m.breedid,           --Ʒ��ID
       g.breedname,         --Ʒ��
       sum(xieyi) xieyi,    --Э�齻�պ�ͬ
       sum(zizhu) zizhu     --�������պ�ͬ
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
select b.categoryid,                                        --��Ʒ�����
       b.categoryname,                                      --��Ʒ��������
       nvl(sum(cnt), 0) cnt,                                --ί�б���
       nvl(sum(TotalPrice) / sum(quantity), 0) EvenPrice,   --����
       nvl(sum(TotalPrice), 0) TotalPrice,                  --ί�н��
       nvl(sum(quantity), 0) quantity,                      --ί������
       nvl(sum(tradeqty), 0) tradeqty                       --�ɽ�����
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
select b.categoryid,                                      --��Ʒ�����
       b.categoryname,                                    --��Ʒ��������
       b.bsflag bsflag,                                   --��������
       nvl(sum(cnt), 0) cnt,                              --ί�б���
       nvl(sum(TotalPrice) / sum(quantity), 0) EvenPrice, --����
       nvl(sum(TotalPrice), 0) TotalPrice,                --ί�н��
       nvl(sum(quantity), 0) quantity,                    --ί������
       nvl(sum(tradeqty), 0) tradeqty                     --�ɽ�����
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
select c.categoryid, --��Ʒ�����
       c.categoryname, --��Ʒ��������
       sum(s.xiyie) tradefee, --����������
       sum(s.jiaoshou) deliveryfee, --����������
       sum(s.xiyie) + sum(s.jiaoshou) sumfee --�������ܶ�
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
select c.categoryid,                                    --��Ʒ�����
       c.categoryname,                                  --��Ʒ����
       sum(a.tradeamount) tradeamount                   --�ɽ���
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
select i.categoryid,                                              --��Ʒ�����
       i.categoryname,                                            --��Ʒ��������
       nvl(sum(cnt), 0) cnt,                                      --�ɽ�����
       nvl(sum(TotalPrice) / sum(TotalQuantity), 0) EvenPrice,    --�ɽ�����
       nvl(sum(TotalPrice), 0) TotalPrice,                        --�ɽ����
       nvl(sum(TotalQuantity), 0) TotalQuantity,                  --�ɽ�����
       nvl(sum(TotalQuantity) / sum(cnt), 0) EvenQuantity         --�ɽ�����
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
select y.categoryid, --��Ʒ�����
       y.categoryname, --��������
        sum(xieyi) xieyi,    --Э�齻�պ�ͬ
       sum(zizhu) zizhu     --�������պ�ͬ
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
select b.firmid firmid,                             --�����̴���
       b.name name,                                 --����������
       b.bsflag bsflag,                             --��������
       nvl(sum(cnt), 0) cnt,                        --ί�б���
       nvl(sum(TotalPrice) /sum(quantity), 0) EvenPrice, --����
       nvl(sum(TotalPrice), 0) TotalPrice,          --ί�н��
       nvl(sum(quantity), 0) quantity,              --ί������
       nvl(sum(tradeqty), 0) tradeqty               --�ɽ�����
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
select b.firmid,                                                   --�����̴���
       b.name,                                                     --����������
       nvl(sum(cnt), 0) cnt,                                       --�ɽ�����
       nvl(sum(TotalQuantity), 0) TotalQuantity                    --�ɽ�����
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
select b.firmid,                                               --�����̴���
       b.name,                                                 --����������
       nvl(sum(cnt), 0) cnt,                                   --�ɽ�����
       nvl(sum(TotalPrice) / sum(TotalQuantity), 0) EvenPrice, --�ɽ�����
       nvl(sum(TotalPrice), 0) TotalPrice,                     --�ɽ����
       nvl(sum(TotalQuantity), 0) TotalQuantity,               --�ɽ�����
       nvl(sum(TotalQuantity) / sum(cnt), 0) EvenQuantity      --�ɽ�����
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
         a.firmid,            --�����̴���
         a.margin,            --ռ�ñ�֤��
         a.goodsmoney,        --ռ�û���
         a.subscription,      --���ű��Ͻ�
         b.balance,           --���
         a.margin + a.goodsmoney + a.subscription + b.balance equity--Ȩ��
from e_funds a, f_firmfunds b
    where a.firmid = b.firmid
;

prompt
prompt Creating view V_E_PLATFORM_REVENUE_STAT
prompt =======================================
prompt
create or replace force view v_e_platform_revenue_stat as
select
    sum(tradefee) tradefee,         --���������ѣ�ҵ�����Ϊ��23001����
    sum(deliveryfee) deliveryfee,   --���������ѣ�ҵ�����Ϊ��23004����
    dat tradedate                   --ƽ̨��������
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
select tradedate,                            --�ɽ�����
       sum(cnt) cnt,                         --ΥԼ����
       sum(quantity) quantity                --ΥԼ����
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
create or replace function FN_E_CanOutSubscription(p_firmid varchar2, --�����̴���
                                                   p_lock   number --�Ƿ����� 1:���� 0��������
                                                   ) return number
/***
  * ��ȡ�ɳ����ű�֤��
  * ����ֵ���ɳ����ű�֤��
  ****/
 is
  v_LeastSubscription     number(15, 2); --����Ӧ�ñ����ĳ��ű��Ͻ�
  v_SumSubscription       number(15, 2); --����ȫ��ΥԼ������ű��Ͻ�
  v_CanOut                number(15, 2); --�ɳ����ű��Ͻ�
  v_UnTradecnt            number(10); --δ�ɽ���ί������
  v_OneTradeMargin        number(15, 2); --����ί��������ű��Ͻ�
  v_OrderHoldSubscription number(15, 2); --ί��ռ�õĳ��ű��Ͻ�
begin

  select a.totalOrder + b.totalSubOrder
    into v_UnTradecnt
    from -- ί��״̬ 0��δ�ɽ� 1�����ֳɽ� 2��ȫ���ɽ� 3�����¼� 11������̨����Ա���
         (select count(*) totalOrder
            from E_order o
           where o.firmid = p_firmid
             and (o.status = 0 or o.status = 1 or o.status = 11)
             and o.ispaymargin = 'N' --û��֧����֤��
             and o.pledgeflag = 0) a, --�������ֵ�
         --��۱�״̬ 0���ȴ����Ʒ��� ������û�н���֤���
         (select count(*) totalSubOrder from(
           select case
                    when o.bsflag = 'B' then
                     t.deliverymargin_s
                    else
                     t.deliverymargin_b
                  end as margin,t.frozenmargin
             from E_suborder t, E_order o
             where t.subFirmID = p_firmid and t.orderid=o.orderid and t.status = 0) where margin!=frozenmargin) b;

  --����ȫ������ΥԼ������ű�֤��
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
   where x.key = 'OneTradeMargin'; --����ί��������ű��Ͻ�
  --����ί��ռ�õĳ��ű��Ͻ�
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
    p_FirmID m_firm.firmid%type --�����̴���
)
return integer is
  /**
  * �ֻ�ϵͳ��ӽ�����
  * ����ֵ�� 1 �ɹ�
  **/
  v_cnt                number(4); --���ֱ���
begin
  select count(*) into v_cnt from E_firm where firmid = p_FirmID;
   if (v_cnt > 0) then
    --����������Ѿ��������������ý�������Ϣ
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

  --��������200800��Ŀ�����ڼ�¼�����̳��ű�֤��
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
    p_FirmID   m_firm.firmid%type--�����̴���
)
return integer is
  /**
  * ɾ��������
  * ����ֵ�� 1 �ɹ�
  **/
  v_cnt                number(4); --���ֱ���
  v_ordercount         number(4); --ί�����ֱ���
  v_tradecount         number(4); --��ͬ���ֱ���
  v_subordercount      number(4); --������ֱ���
  f_margin               number(15,2); --��֤�����
  f_goodsmoney           number(15,2); --�������
  f_transferloss         number(15,2); --ת��������
  f_subscription         number(15,2); --���ű�֤�����
  RET_ORDERERROR integer:=-230;--��δ������ί��
  RET_TRADEERROR integer:=-231;--��δ�����ĺ�ͬ
  RET_SUBORDERERROR integer:=-232;--��δ�𸴵����
  RET_MARGINERROR integer:=-233;--�����̱�֤��Ϊ0
  RET_MONEYERROR integer:=-234;--�����̻��Ϊ0
  RET_TRANERROR integer:=-235;--������ת����Ϊ0
  RET_SUBERROR integer:=-236;--�����̳��Ž�Ϊ0
begin
   --ί��������״̬����2:ȫ���ɽ�����3:���¼� ����ע��������
   select count(*) into v_ordercount from e_order o where o.firmid=p_FirmID and o.status not in(2,3);
   if(v_ordercount>0)then
   return RET_ORDERERROR;
   end if;
    --��ͬ������״̬����8:��������1:�����׶�ΥԼ ����2:ϵͳ������������4:�ɽ��׶�ΥԼ ����ע��������
   select count(*) into v_tradecount from e_trade t where (t.bfirmid=p_FirmID or t.sfirmid=p_FirmID) and t.status not in (1,2,4,8);
   if(v_tradecount>0)then
   return RET_TRADEERROR;
   end if;
   --���������״̬Ϊ0:�ȴ��� ����ע��������
   select count(*) into v_subordercount from e_suborder s where s.subfirmid=p_FirmID and s.status=0;
   if(v_subordercount>0)then
   return RET_SUBORDERERROR;
   end if;

    --�ý����̵��ʽ���Ϣ��ĳһ���ʽ�ֵ��Ϊ0 ����ע��������
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
   Forѭ�������ڸý����̵�ģ����Ϣ��ɾ��ģ�����Բ�ѯ������

   for template in (select g.templateid from e_goodstemplate g where g.belongtouser=p_FirmID) loop
       delete from e_goodstemplateproperty tp where tp.templateid=template.templateid;
       end loop;
   --ɾ���ý�����ģ����Ϣ
   delete from e_goodstemplate te where te.belongtouser=p_FirmID;
    **/
   /**
   Forѭ�������ڸý����̵�Ԥ��ί����Ϣ��ɾ��Ԥ��ί�����Բ�ѯ������

   for goodsresource in (select r.resourceid from e_goodsresource r where r.firmid=p_FirmID) loop
       delete from e_goodsresourceproperty rp where rp.resourceid=goodsresource.resourceid;
       delete from e_goodsresourcepic gpic where gpic.resourceid=goodsresource.resourceid;
       end loop;
    --ɾ���ý�����Ԥ��ί����Ϣ
   delete from e_goodsresource r where r.firmid=p_FirmID;
   --ɾ�����⽻��������
   delete from e_tradefee f where f.firmid=p_FirmID;
   --ɾ�����⽻��������
   delete from e_deliveryfee f where f.firmid=p_FirmID;
   --ɾ��������Լ��֤��
   delete from e_deliverymargin f where f.firmid=p_FirmID;
   --ɾ�����⽻����Ȩ��
   delete from e_traderight f where f.firmid=p_FirmID;
   **/
   --ɾ���Ƽ�����
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
    p_FirmID   m_firm.firmid%type--�����̴���
)
return integer is
  /**
  * �޸Ľ�����״̬
  * ����ֵ�� 1 �ɹ�
  **/
  v_cnt                number(4); --���ֱ���
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
 * ת��ʷ
 **/
begin
  ---------------------------ί�����
  --ת���
  insert into e_suborder_h(suborderid, orderid, subfirmid, quantity, price, warehouseid, TradePreTime, deliverymargin_b, deliverymargin_s,FrozenMargin, remark, status, createtime, reply, replytime, withdrawer, withdrawtime, DeliveryPreTime, DeliveryDayType, DeliveryDay)
  select suborderid, orderid, subfirmid, quantity, price, warehouseid, TradePreTime, deliverymargin_b, deliverymargin_s,FrozenMargin, remark, status, createtime, reply, replytime, withdrawer, withdrawtime, DeliveryPreTime, DeliveryDayType, DeliveryDay
    from e_suborder s where s.orderid in
         (select o.orderid from e_order o where o.ordertime <= p_EndDate and o.status in (2,3));--ȫ���ɽ������¼�
  delete from e_suborder s where s.orderid in
         (select o.orderid from e_order o where o.ordertime <= p_EndDate and o.status in (2,3));
  --תί������
  insert into e_goodsproperty_h(orderid, propertyname, propertyvalue, propertyTypeID)
  select orderid, propertyname, propertyvalue, propertyTypeID
    from e_goodsproperty p where p.orderid in
         (select o.orderid from e_order o where o.ordertime <= p_EndDate and o.status in (2,3));
  delete from e_goodsproperty p where p.orderid in
         (select o.orderid from e_order o where o.ordertime <= p_EndDate and o.status in (2,3));
  --תί��ͼƬ
  insert into e_OrderPic_H(ID,OrderID,picture)
  select ID,OrderID,picture
    from e_OrderPic p where p.OrderID in
	     (select o.orderid from e_order o where o.ordertime <= p_EndDate and o.status in (2,3));
  delete from e_OrderPic p where p.OrderID in
	     (select o.orderid from e_order o where o.ordertime <= p_EndDate and o.status in (2,3));
  --תί��
  insert into e_order_h(orderid, ordertitle, breedid, bsflag, firmid, price, quantity, unit, TradePreTime, trademargin_b, trademargin_s, deliverydaytype, DeliveryPreTime, deliveryday, deliverymargin_b, deliverymargin_s, deliverytype, warehouseid, deliveryaddress, status, tradedqty, remark, ordertime, traderid, withdrawtime, withdrawtraderid, categoryid, ValidTime, pledgeflag, mintradeqty,TradeUnit,IsPickOff,IsSuborder,IsPayMargin,FrozenMargin,TradeType,PayType,EffectOfTime,StockID)
  select orderid, ordertitle, breedid, bsflag, firmid, price, quantity, unit, TradePreTime, trademargin_b, trademargin_s, deliverydaytype, DeliveryPreTime, deliveryday, deliverymargin_b, deliverymargin_s, deliverytype, warehouseid, deliveryaddress, status, tradedqty, remark, ordertime, traderid, withdrawtime, withdrawtraderid, categoryid, ValidTime, pledgeflag, mintradeqty,TradeUnit,IsPickOff,IsSuborder,IsPayMargin,FrozenMargin,TradeType,PayType,EffectOfTime,StockID
    from e_order o where o.ordertime <= p_EndDate and o.status in (2,3);
  delete from e_order o where o.ordertime <= p_EndDate and o.status in (2,3);


  ---------------------------��ͬ���
  --1�������׶�ΥԼ 2�������׶�ϵͳ���� 4���ɽ��׶�ΥԼ 8����������
  --ת����
  insert into e_reserve_h(reserveid, tradeno, firmid, realmoney, bsflag, payablereserve, payreserve, backreserve, goodsquantity, status, breachapplyid)
  select reserveid, tradeno, firmid, realmoney, bsflag, payablereserve, payreserve, backreserve, goodsquantity, status, breachapplyid
    from e_reserve r where r.tradeno in
         (select t.tradeno from e_trade t where t.time <= p_EndDate and t.status in (1,2,4,8));
  delete from e_reserve r where r.tradeno in
         (select t.tradeno from e_trade t where t.time <= p_EndDate and t.status in (1,2,4,8));
  --ת�ֲ�
  insert into e_holding_h(holdingid, tradeno, firmid, bsflag, realmoney, paymargin, paygoodsmoney, payoff,Receive, transfermoney, status, breachapplyid, offsetid)
  select holdingid, tradeno, firmid, bsflag, realmoney, paymargin, paygoodsmoney, payoff,Receive, transfermoney, status, breachapplyid, offsetid
    from e_holding h where h.tradeno in
         (select t.tradeno from e_trade t where t.time <= p_EndDate and t.status in (1,2,4,8));
  delete from e_holding h where h.tradeno in
         (select t.tradeno from e_trade t where t.time <= p_EndDate and t.status in (1,2,4,8));
  --ת��ͬ������־
  insert into e_tradeprocesslog_h(logid, tradeno, firmid, operator, processinfo, processtime)
  select logid, tradeno, firmid, operator, processinfo, processtime
    from e_tradeprocesslog l where l.tradeno in
         (select t.tradeno from e_trade t where t.time <= p_EndDate and t.status in (1,2,4,8));
  delete from e_tradeprocesslog l where l.tradeno in
         (select t.tradeno from e_trade t where t.time <= p_EndDate and t.status in (1,2,4,8));
  --ת��ͬ����
  insert into e_trade_goodsproperty_h
    (propertyname, tradeno, propertyvalue, propertyTypeID)
  select propertyname, tradeno, propertyvalue, propertyTypeID
    from e_trade_goodsproperty p where p.tradeno in
         (select t.tradeno from e_trade t where t.time <= p_EndDate and t.status in (1,2,4,8));
  delete from e_trade_goodsproperty p where p.tradeno in
         (select t.tradeno from e_trade t where t.time <= p_EndDate and t.status in (1,2,4,8));
  --תβ������
  insert into e_GoodsMoneyApply_H
    (ID, tradeNO, status,type, CreateTime, ProcessTime)
  select ID, tradeNO, status,type, CreateTime, ProcessTime
    from e_GoodsMoneyApply h where h.tradeNO in
	     (select t.tradeno from e_trade t where t.time <= p_EndDate and t.status in (1,2,4,8));
  delete from e_GoodsMoneyApply l where l.tradeNO in
         (select t.tradeno from e_trade t where t.time <= p_EndDate and t.status in (1,2,4,8));
  --ת�������
  insert into e_NoOffset_h
    (id, tradeno,createtime)
  select id, tradeno,createtime
    from e_NoOffset p where p.tradeno in
         (select t.tradeno from e_trade t where t.time <= p_EndDate and t.status in (1,2,4,8));
  delete from e_NoOffset p where p.tradeno in
         (select t.tradeno from e_trade t where t.time <= p_EndDate and t.status in (1,2,4,8));
  --ת�ɽ���ͬ
  insert into e_trade_h(tradeno, ordertitle, breedid, bfirmid, sfirmid, price, quantity, unit, TradePreTime, trademargin_b, trademargin_s, deliveryday, deliverymargin_b, deliverymargin_s, BuyTradeFee,BuyPayTradeFee,BuyDeliveryFee,BuyPayDeliveryFee,SellTradeFee,SellPayTradeFee,SellDeliveryFee,SellPayDeliveryFee,deliverytype, warehouseid, deliveryaddress, time, remark, status, orderid,TradeType,PayType)
  select tradeno, ordertitle, breedid, bfirmid, sfirmid, price, quantity, unit, TradePreTime, trademargin_b, trademargin_s, deliveryday, deliverymargin_b, deliverymargin_s,BuyTradeFee,BuyPayTradeFee,BuyDeliveryFee,BuyPayDeliveryFee,SellTradeFee,SellPayTradeFee,SellDeliveryFee,SellPayDeliveryFee,deliverytype, warehouseid, deliveryaddress, time, remark, status, orderid,TradeType,PayType
    from e_trade t where t.time <= p_EndDate and t.status in (1,2,4,8);
  delete from e_trade t where t.time <= p_EndDate and t.status in (1,2,4,8);
end;
/


spool off
