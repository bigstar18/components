--------------------------------------------------
-- Export file for user TRADE_GNNT@SPOT.DEV.183 --
-- Created by hxx on 2015/12/3, 23:36:43 ---------
--------------------------------------------------

set define off
spool ipo.struct.log

prompt
prompt Creating table IPO_BALLOTNO_INFO
prompt ================================
prompt
create table IPO_BALLOTNO_INFO
(
  id               NUMBER not null,
  commodityid      VARCHAR2(32) not null,
  ballotnostartlen NUMBER not null,
  ballotnoendlen   NUMBER not null,
  ballotno         VARCHAR2(32),
  createtime       DATE not null
)
;
comment on table IPO_BALLOTNO_INFO
  is '摇号信息';
comment on column IPO_BALLOTNO_INFO.commodityid
  is '商品编号';
comment on column IPO_BALLOTNO_INFO.ballotnostartlen
  is '尾号起始位';
comment on column IPO_BALLOTNO_INFO.ballotnoendlen
  is '尾号结束位';
comment on column IPO_BALLOTNO_INFO.ballotno
  is '尾号';
comment on column IPO_BALLOTNO_INFO.createtime
  is '尾号创建时间';
alter table IPO_BALLOTNO_INFO
  add primary key (ID);

prompt
prompt Creating table IPO_BREED
prompt ========================
prompt
create table IPO_BREED
(
  breedid            NUMBER(10) not null,
  breedname          VARCHAR2(50) not null,
  sortid             NUMBER(10) not null,
  contractfactor     NUMBER(12,2) not null,
  minpricemove       NUMBER(10,2) not null,
  spreadalgr         NUMBER(1) not null,
  spreaduplmt        NUMBER(10,2) not null,
  spreaddownlmt      NUMBER(10,2) not null,
  minquantitymove    NUMBER(3) not null,
  contractfactorname VARCHAR2(10) not null,
  minapplynum        NUMBER(10) not null,
  maxapplynum        NUMBER(32) not null,
  minapplyquamove    NUMBER(8) not null,
  publishalgr        NUMBER(1) not null,
  dealerpubcharatio  NUMBER(10,2) not null,
  mktdeapubcharatio  NUMBER(10,2) not null,
  publishercharatio  NUMBER(10,2) not null,
  mktpubcharatio     NUMBER(10,2) not null,
  contractcurrency   VARCHAR2(32) not null,
  tradedays          NUMBER(8) not null
)
;
comment on column IPO_BREED.breedid
  is '品种ID';
comment on column IPO_BREED.breedname
  is '品种姓名';
comment on column IPO_BREED.sortid
  is '分类ID(对应mbreed表的categoryid)';
comment on column IPO_BREED.contractfactor
  is '交易单位';
comment on column IPO_BREED.minpricemove
  is '最小变动价位(元)';
comment on column IPO_BREED.spreadalgr
  is '涨跌停板算法(1、按百分比  2、按绝对值)';
comment on column IPO_BREED.spreaduplmt
  is '涨幅上限';
comment on column IPO_BREED.spreaddownlmt
  is '跌幅下限';
comment on column IPO_BREED.minquantitymove
  is '最小变动数量';
comment on column IPO_BREED.contractfactorname
  is '报价单位(对应mbreed表的unit)';
comment on column IPO_BREED.minapplynum
  is '最小申购数量';
comment on column IPO_BREED.maxapplynum
  is '最大申购数量';
comment on column IPO_BREED.minapplyquamove
  is '最小申购变动量';
comment on column IPO_BREED.publishalgr
  is '发行手续费算法(1、按百分比  2、按绝对值)';
comment on column IPO_BREED.dealerpubcharatio
  is '交易商发行手续费比例';
comment on column IPO_BREED.mktdeapubcharatio
  is '交易商发行手续费市场留存比例';
comment on column IPO_BREED.publishercharatio
  is '发行商发行手续费比例';
comment on column IPO_BREED.mktpubcharatio
  is '发行商发行手续费市场留存比例';
comment on column IPO_BREED.contractcurrency
  is '报价货币';
comment on column IPO_BREED.tradedays
  is 'T+N交易天数';
alter table IPO_BREED
  add constraint PK_IPO_BREED primary key (BREEDID);

prompt
prompt Creating table IPO_CLEARSTATUS
prompt ==============================
prompt
create table IPO_CLEARSTATUS
(
  actionid   NUMBER(3) not null,
  actionnote VARCHAR2(32) not null,
  status     CHAR(1) not null,
  finishtime DATE
)
;
alter table IPO_CLEARSTATUS
  add constraint PK_IPO_ACTIONID primary key (ACTIONID);

prompt
prompt Creating table IPO_COMMODITY_CONF
prompt =================================
prompt
create table IPO_COMMODITY_CONF
(
  commodityid        VARCHAR2(32) not null,
  commodityname      VARCHAR2(32) not null,
  price              NUMBER(11,3) not null,
  units              NUMBER not null,
  counts             NUMBER not null,
  starttime          DATE not null,
  endtime            DATE not null,
  maxapplynum        NUMBER(32) not null,
  status             NUMBER,
  breedid            NUMBER(10) not null,
  tradedays          NUMBER(8) not null,
  codedelivery       NUMBER not null,
  nonissuereg        NUMBER not null,
  pubmemberid        VARCHAR2(32) not null,
  minapplynum        NUMBER(10) not null,
  minapplyquamove    NUMBER(8) not null,
  publishalgr        NUMBER(1) not null,
  dealerpubcharatio  NUMBER(10,2) not null,
  mktdeapubcharatio  NUMBER(10,2) not null,
  publishercharatio  NUMBER(10,2) not null,
  mktpubcharatio     NUMBER(10,2) not null,
  currstatus         NUMBER(1) not null,
  supervisedprice    NUMBER not null,
  listingdate        DATE not null,
  lasttradate        DATE not null,
  contractfactor     NUMBER(12,2) not null,
  minpricemove       NUMBER(10,2) not null,
  minquantitymove    NUMBER(8) not null,
  spreadalgr         NUMBER(1) not null,
  spreaduplmt        NUMBER(10,2) not null,
  spreaddownlmt      NUMBER(10,2) not null,
  contractfactorname VARCHAR2(32) not null,
  mapperid           VARCHAR2(32)
)
;
comment on column IPO_COMMODITY_CONF.commodityid
  is '商品编号';
comment on column IPO_COMMODITY_CONF.commodityname
  is '商品名称';
comment on column IPO_COMMODITY_CONF.price
  is '发行价';
comment on column IPO_COMMODITY_CONF.units
  is '发售单位';
comment on column IPO_COMMODITY_CONF.counts
  is '发售数量';
comment on column IPO_COMMODITY_CONF.starttime
  is '起始时间';
comment on column IPO_COMMODITY_CONF.endtime
  is '结束时间';
comment on column IPO_COMMODITY_CONF.maxapplynum
  is '申购额度（最大申购数量）';
comment on column IPO_COMMODITY_CONF.status
  is '0：申购成功
1：配号成功
2：摇号成功
3：结算成功';
comment on column IPO_COMMODITY_CONF.breedid
  is '品种编号';
comment on column IPO_COMMODITY_CONF.tradedays
  is 'T+N交易天数';
comment on column IPO_COMMODITY_CONF.codedelivery
  is '是否开启标码提货';
comment on column IPO_COMMODITY_CONF.nonissuereg
  is '非发行注册';
comment on column IPO_COMMODITY_CONF.pubmemberid
  is '发行会员编号';
comment on column IPO_COMMODITY_CONF.minapplynum
  is '最小申购数量';
comment on column IPO_COMMODITY_CONF.minapplyquamove
  is '最小申购变动量';
comment on column IPO_COMMODITY_CONF.publishalgr
  is '发行手续费算法(1、按百分比  2、按绝对值)';
comment on column IPO_COMMODITY_CONF.dealerpubcharatio
  is '交易商发行手续费比例';
comment on column IPO_COMMODITY_CONF.mktdeapubcharatio
  is '交易商发行手续费市场留存比例';
comment on column IPO_COMMODITY_CONF.publishercharatio
  is '发行商发行手续费比例';
comment on column IPO_COMMODITY_CONF.mktpubcharatio
  is '发行商发行手续费市场留存比例';
comment on column IPO_COMMODITY_CONF.currstatus
  is '当前状态 0、有效 1、暂停交易';
comment on column IPO_COMMODITY_CONF.supervisedprice
  is '开市指导价';
comment on column IPO_COMMODITY_CONF.listingdate
  is '上市日期';
comment on column IPO_COMMODITY_CONF.lasttradate
  is '最后交易日';
comment on column IPO_COMMODITY_CONF.contractfactor
  is '交易单位';
comment on column IPO_COMMODITY_CONF.minpricemove
  is '最小变动价位';
comment on column IPO_COMMODITY_CONF.minquantitymove
  is '最小变动量';
comment on column IPO_COMMODITY_CONF.spreadalgr
  is '涨跌停板算法';
comment on column IPO_COMMODITY_CONF.spreaduplmt
  is '涨幅上限';
comment on column IPO_COMMODITY_CONF.spreaddownlmt
  is '下限涨幅';
comment on column IPO_COMMODITY_CONF.contractfactorname
  is '交易单位（量词）';
comment on column IPO_COMMODITY_CONF.mapperid
  is '对应现货商品ID';
alter table IPO_COMMODITY_CONF
  add constraint PK_IPO_COMMODITY_CONF primary key (COMMODITYID);

prompt
prompt Creating table IPO_COMMODITY_SALE
prompt =================================
prompt
create table IPO_COMMODITY_SALE
(
  commodityid     VARCHAR2(32) not null,
  commodityname   VARCHAR2(32) not null,
  price           NUMBER(11,3) not null,
  units           NUMBER not null,
  counts          NUMBER not null,
  starttime       DATE not null,
  endtime         DATE not null,
  purchasecredits NUMBER,
  status          NUMBER,
  id              NUMBER not null
)
;
comment on table IPO_COMMODITY_SALE
  is '商品列表';
comment on column IPO_COMMODITY_SALE.commodityid
  is '商品编号';
comment on column IPO_COMMODITY_SALE.commodityname
  is '商品名称';
comment on column IPO_COMMODITY_SALE.price
  is '发售价';
comment on column IPO_COMMODITY_SALE.units
  is '发售单位';
comment on column IPO_COMMODITY_SALE.counts
  is '发售数量';
comment on column IPO_COMMODITY_SALE.starttime
  is '起始时间';
comment on column IPO_COMMODITY_SALE.endtime
  is '结束时间';
comment on column IPO_COMMODITY_SALE.purchasecredits
  is '申购额度';
comment on column IPO_COMMODITY_SALE.status
  is '0：申购成功
1：配号成功
2：摇号成功
3：结算成功';
comment on column IPO_COMMODITY_SALE.id
  is '主键';
alter table IPO_COMMODITY_SALE
  add constraint PK_IPO_COMMODITY_SALE primary key (ID);

prompt
prompt Creating table IPO_DISTRIBUTION
prompt ===============================
prompt
create table IPO_DISTRIBUTION
(
  id            NUMBER(8) not null,
  userid        VARCHAR2(32) not null,
  commodityname VARCHAR2(32) not null,
  startnumber   NUMBER not null,
  pcounts       NUMBER(8) not null,
  ptime         TIMESTAMP(6) not null,
  zcounts       NUMBER(8),
  numbers       BLOB,
  commodityid   VARCHAR2(32)
)
;
comment on table IPO_DISTRIBUTION
  is '配号，中签结果';
comment on column IPO_DISTRIBUTION.userid
  is '客户编号';
comment on column IPO_DISTRIBUTION.commodityname
  is '商品名称';
comment on column IPO_DISTRIBUTION.startnumber
  is '起始配号';
comment on column IPO_DISTRIBUTION.pcounts
  is '配号数量';
comment on column IPO_DISTRIBUTION.ptime
  is '配号时间';
comment on column IPO_DISTRIBUTION.zcounts
  is '中签数量';
comment on column IPO_DISTRIBUTION.numbers
  is '中签号码';
comment on column IPO_DISTRIBUTION.commodityid
  is '商品编号';
alter table IPO_DISTRIBUTION
  add primary key (ID);

prompt
prompt Creating table IPO_NOTTRADEDAY
prompt ==============================
prompt
create table IPO_NOTTRADEDAY
(
  id         NUMBER(10) not null,
  week       VARCHAR2(30),
  day        VARCHAR2(1024),
  modifytime DATE not null
)
;
comment on column IPO_NOTTRADEDAY.week
  is '星期几';
comment on column IPO_NOTTRADEDAY.day
  is '日期';
comment on column IPO_NOTTRADEDAY.modifytime
  is '修改时间';
alter table IPO_NOTTRADEDAY
  add constraint PK_IPO_NOTTRADEDAY primary key (ID);

prompt
prompt Creating table IPO_NUMBEROFRECORDS
prompt ==================================
prompt
create table IPO_NUMBEROFRECORDS
(
  id          NUMBER(8) not null,
  commodityid VARCHAR2(32),
  counts      NUMBER,
  nowtime     TIMESTAMP(6)
)
;
comment on column IPO_NUMBEROFRECORDS.commodityid
  is '商品编号';
comment on column IPO_NUMBEROFRECORDS.counts
  is '已配个数';
comment on column IPO_NUMBEROFRECORDS.nowtime
  is '时间';
alter table IPO_NUMBEROFRECORDS
  add primary key (ID);

prompt
prompt Creating table IPO_NUMBEROFRECORDS_H
prompt ====================================
prompt
create table IPO_NUMBEROFRECORDS_H
(
  id          NUMBER(8) not null,
  commodityid VARCHAR2(32),
  counst      NUMBER,
  nowtime     TIMESTAMP(6)
)
;
comment on column IPO_NUMBEROFRECORDS_H.id
  is 'ID';
comment on column IPO_NUMBEROFRECORDS_H.commodityid
  is '商品编码';
comment on column IPO_NUMBEROFRECORDS_H.nowtime
  is '时间';
alter table IPO_NUMBEROFRECORDS_H
  add primary key (ID);

prompt
prompt Creating table IPO_ORDER
prompt ========================
prompt
create table IPO_ORDER
(
  orderid       NUMBER not null,
  userid        VARCHAR2(32) not null,
  username      VARCHAR2(12),
  commodityid   VARCHAR2(12) not null,
  commodityname VARCHAR2(12) not null,
  counts        NUMBER not null,
  createtime    TIMESTAMP(6) not null,
  frozenfunds   NUMBER(15,2) not null,
  frozenst      NUMBER default 0,
  commodity_id  NUMBER
)
;
comment on table IPO_ORDER
  is '订单表';
comment on column IPO_ORDER.userid
  is '客户编号';
comment on column IPO_ORDER.username
  is '客户姓名';
comment on column IPO_ORDER.commodityid
  is '商品编号';
comment on column IPO_ORDER.commodityname
  is '商品名称';
comment on column IPO_ORDER.counts
  is '客户申购数';
comment on column IPO_ORDER.createtime
  is '申购时间';
comment on column IPO_ORDER.frozenfunds
  is '资金冻结';
alter table IPO_ORDER
  add primary key (ORDERID);

prompt
prompt Creating table IPO_ORDER_H
prompt ==========================
prompt
create table IPO_ORDER_H
(
  orderid       NUMBER not null,
  userid        VARCHAR2(32) not null,
  username      VARCHAR2(12),
  commodityid   VARCHAR2(12) not null,
  commodityname VARCHAR2(12) not null,
  counts        NUMBER not null,
  createtime    TIMESTAMP(6) not null,
  frozenfunds   NUMBER(15,2) not null,
  frozenst      NUMBER,
  commodity_id  NUMBER not null
)
;
comment on column IPO_ORDER_H.userid
  is '客户编号';
comment on column IPO_ORDER_H.username
  is '客户姓名';
comment on column IPO_ORDER_H.commodityid
  is '商品编号';
comment on column IPO_ORDER_H.commodityname
  is '商品名称';
comment on column IPO_ORDER_H.counts
  is '客户申购数';
comment on column IPO_ORDER_H.createtime
  is '申购时间';
comment on column IPO_ORDER_H.frozenfunds
  is '资金冻结';
comment on column IPO_ORDER_H.commodity_id
  is '发售id';
alter table IPO_ORDER_H
  add primary key (ORDERID);

prompt
prompt Creating table IPO_SYSSTATUS
prompt ============================
prompt
create table IPO_SYSSTATUS
(
  tradedate   DATE not null,
  status      NUMBER(2) default 3 not null,
  sectionid   NUMBER(4),
  note        VARCHAR2(256),
  recovertime VARCHAR2(10)
)
;
alter table IPO_SYSSTATUS
  add constraint PK_IPO_SYSSTATUS primary key (TRADEDATE);

prompt
prompt Creating table IPO_TRADETIME
prompt ============================
prompt
create table IPO_TRADETIME
(
  sectionid  NUMBER(4) not null,
  name       VARCHAR2(20),
  starttime  VARCHAR2(10) not null,
  endtime    VARCHAR2(10) not null,
  status     NUMBER(2) not null,
  modifytime DATE not null
)
;
comment on column IPO_TRADETIME.sectionid
  is 'ID';
comment on column IPO_TRADETIME.name
  is '交易节名称';
comment on column IPO_TRADETIME.starttime
  is '开始时间';
comment on column IPO_TRADETIME.endtime
  is '结束时间';
comment on column IPO_TRADETIME.status
  is '状态
0:有效
1:无效';
alter table IPO_TRADETIME
  add primary key (SECTIONID);

prompt
prompt Creating table IPO_TRADETIME_COMM
prompt =================================
prompt
create table IPO_TRADETIME_COMM
(
  id          NUMBER not null,
  tradetimeid NUMBER(4),
  commodityid VARCHAR2(32)
)
;
comment on column IPO_TRADETIME_COMM.id
  is '主键';
comment on column IPO_TRADETIME_COMM.tradetimeid
  is '交易节ID';
comment on column IPO_TRADETIME_COMM.commodityid
  is '商品ID';
alter table IPO_TRADETIME_COMM
  add constraint PK_TRADETIME_COMM_ID primary key (ID);

prompt
prompt Creating sequence SEQ_IPO_BALLOTNO_INFO
prompt =======================================
prompt
create sequence SEQ_IPO_BALLOTNO_INFO
minvalue 1
maxvalue 9999999999999999999999999999
start with 2221
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_IPO_BREED
prompt ===============================
prompt
create sequence SEQ_IPO_BREED
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_IPO_COMMODITY_SALE
prompt ========================================
prompt
create sequence SEQ_IPO_COMMODITY_SALE
minvalue 1
maxvalue 9999999999999999999999999999
start with 41
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_IPO_DISTRIBUTION
prompt ======================================
prompt
create sequence SEQ_IPO_DISTRIBUTION
minvalue 1
maxvalue 9999999999999999999999999999
start with 281
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_IPO_NOTTRADEDAY
prompt =====================================
prompt
create sequence SEQ_IPO_NOTTRADEDAY
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_IPO_NUMBEROFRECORDS
prompt =========================================
prompt
create sequence SEQ_IPO_NUMBEROFRECORDS
minvalue 1
maxvalue 9999999999999999999999999999
start with 301
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_IPO_NUMBEROFRECORDS_H
prompt ===========================================
prompt
create sequence SEQ_IPO_NUMBEROFRECORDS_H
minvalue 1
maxvalue 9999999999999999999999999999
start with 61
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_IPO_ORDER
prompt ===============================
prompt
create sequence SEQ_IPO_ORDER
minvalue 1
maxvalue 9999999999999999999999999999
start with 141
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_IPO_ORDER_H
prompt =================================
prompt
create sequence SEQ_IPO_ORDER_H
minvalue 1
maxvalue 9999999999999999999999999999
start with 81
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_IPO_TRADETIME
prompt ===================================
prompt
create sequence SEQ_IPO_TRADETIME
minvalue 1
maxvalue 9999999999999999999999999999
start with 181
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_IPO_TRADETIME_COMM
prompt ========================================
prompt
create sequence SEQ_IPO_TRADETIME_COMM
minvalue 1
maxvalue 9999999999999999999999999999
start with 101
increment by 1
cache 20;


spool off
