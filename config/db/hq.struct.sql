-----------------------------------------------
-- Export file for user HQUSER_GNNT@XHDBDEMO --
-- Created by hxx on 2015/11/17, 21:50:34 -----
-----------------------------------------------

set define off
spool hq.struct.log

prompt
prompt Creating table ADDRDIC
prompt ======================
prompt
create table ADDRDIC
(
  addrcode   VARCHAR2(10) default '00' not null,
  addrname   CHAR(12) not null,
  updatetime TIMESTAMP(6) not null
)
;
alter table ADDRDIC
  add constraint PK_ADDRDIC primary key (ADDRCODE);

prompt
prompt Creating table COMMODITY
prompt ========================
prompt
create table COMMODITY
(
  marketid     VARCHAR2(4) default '00' not null,
  commodityid  VARCHAR2(16) not null,
  addrcode     VARCHAR2(10) default '00',
  industrycode VARCHAR2(10) default '00',
  breedname    CHAR(32),
  fullname     VARCHAR2(128),
  status       CHAR(1) not null,
  tradingsec   VARCHAR2(20),
  ctrtsize     NUMBER(10,2),
  type         NUMBER(10),
  spread       NUMBER(10,2),
  maxspread    NUMBER(10),
  tradecomm    NUMBER(12,4),
  settlecomm   NUMBER(12,4),
  cashcomm     NUMBER(12,4),
  margin       NUMBER(10),
  tradeno      NUMBER(10) default 0,
  reservecount NUMBER(10) default 0 not null,
  ttlopen      NUMBER(10) default 0,
  balanceprice NUMBER(12,4) default 0 not null,
  listdate     VARCHAR2(10),
  delistdate   VARCHAR2(10),
  curchange    NUMBER(10),
  maxholding   NUMBER(10),
  modifytime   DATE not null,
  remarks      NVARCHAR2(60)
)
;
alter table COMMODITY
  add constraint PK_COMMODITY primary key (MARKETID, COMMODITYID);

prompt
prompt Creating table COMMODITYPROPERTY
prompt ================================
prompt
create table COMMODITYPROPERTY
(
  marketid     VARCHAR2(4) default '00' not null,
  commodityid  VARCHAR2(16) not null,
  addrcode     VARCHAR2(10) default '00' not null,
  industrycode VARCHAR2(10) default '00' not null
)
;
alter table COMMODITYPROPERTY
  add constraint PK_COMMODITYPROPERTY primary key (MARKETID, COMMODITYID);

prompt
prompt Creating table CO_CLASS
prompt =======================
prompt
create table CO_CLASS
(
  cc_classid      VARCHAR2(10) not null,
  market          VARCHAR2(20),
  cc_name         VARCHAR2(64) not null,
  cc_fullname     VARCHAR2(60),
  cc_remark       VARCHAR2(80),
  cc_pricetype    NUMBER(4),
  cc_commodity_id VARCHAR2(16) not null,
  market_name     VARCHAR2(60),
  cc_desc         VARCHAR2(2000),
  marketid        VARCHAR2(4) default '00' not null
)
;

prompt
prompt Creating table CURRENTDATA
prompt ==========================
prompt
create table CURRENTDATA
(
  marketid           VARCHAR2(4) default '00' not null,
  commodityid        VARCHAR2(16) not null,
  time               DATE not null,
  yesterbalanceprice NUMBER(12,4) not null,
  closeprice         NUMBER(12,4) not null,
  openprice          NUMBER(12,4) not null,
  balanceprice       NUMBER(12,4) default 0 not null,
  highprice          NUMBER(12,4) not null,
  lowprice           NUMBER(12,4) not null,
  curprice           NUMBER(12,4) not null,
  curamount          NUMBER(10) not null,
  openamount         NUMBER(10) not null,
  closeamount        NUMBER(10) not null,
  reservecount       NUMBER(10) not null,
  reservechange      NUMBER(10) not null,
  totalmoney         NUMBER(20,4) not null,
  totalamount        NUMBER(10) not null,
  buyprice1          NUMBER(12,4) not null,
  sellprice1         NUMBER(12,4) not null,
  buyamount1         NUMBER(10) not null,
  sellamount1        NUMBER(10) not null,
  buyprice2          NUMBER(12,4) not null,
  sellprice2         NUMBER(12,4) not null,
  buyamount2         NUMBER(10) not null,
  sellamount2        NUMBER(10) not null,
  buyprice3          NUMBER(12,4) not null,
  sellprice3         NUMBER(12,4) not null,
  buyamount3         NUMBER(10) not null,
  sellamount3        NUMBER(10) not null,
  buyprice4          NUMBER(12,4) not null,
  sellprice4         NUMBER(12,4) not null,
  buyamount4         NUMBER(10) not null,
  sellamount4        NUMBER(10) not null,
  buyprice5          NUMBER(12,4) not null,
  sellprice5         NUMBER(12,4) not null,
  buyamount5         NUMBER(10) not null,
  sellamount5        NUMBER(10) not null,
  outamount          NUMBER(10) not null,
  inamount           NUMBER(10) not null,
  tradecue           NUMBER(10),
  no                 NUMBER(10) default 0 not null,
  tradeno            NUMBER(10) not null
)
;
alter table CURRENTDATA
  add constraint PK_CURRENTDATA primary key (MARKETID, COMMODITYID);

prompt
prompt Creating table HISTORY5MINDATA
prompt ==============================
prompt
create table HISTORY5MINDATA
(
  marketid     VARCHAR2(4) default '00' not null,
  commodityid  VARCHAR2(16) not null,
  tradedate    DATE not null,
  openprice    NUMBER(12,4) not null,
  closeprice   NUMBER(12,4) not null,
  highprice    NUMBER(12,4) not null,
  lowprice     NUMBER(12,4) not null,
  balanceprice NUMBER(12,4) default 0 not null,
  totalamount  NUMBER(10) not null,
  totalmoney   NUMBER(20,4) not null,
  reservecount NUMBER(10) default 0 not null
)
;
alter table HISTORY5MINDATA
  add constraint PK_HISTORY5MINDATA primary key (MARKETID, COMMODITYID, TRADEDATE);

prompt
prompt Creating table HISTORYBILLDATA
prompt ==============================
prompt
create table HISTORYBILLDATA
(
  marketid     VARCHAR2(4) default '00' not null,
  commodityid  VARCHAR2(16) not null,
  totalamount  NUMBER(10) not null,
  time         DATE not null,
  curprice     NUMBER(12,4) not null,
  openamount   NUMBER(10) not null,
  closeamount  NUMBER(10) not null,
  reservecount NUMBER(10) default 0 not null,
  balanceprice NUMBER(12,4) default 0 not null,
  totalmoney   NUMBER(20,4) not null,
  buyprice1    NUMBER(12,4),
  sellprice1   NUMBER(12,4),
  buyamount1   NUMBER(10),
  sellamount1  NUMBER(10),
  buyprice2    NUMBER(12,4),
  sellprice2   NUMBER(12,4),
  buyamount2   NUMBER(10),
  sellamount2  NUMBER(10),
  buyprice3    NUMBER(12,4),
  sellprice3   NUMBER(12,4),
  buyamount3   NUMBER(10),
  sellamount3  NUMBER(10),
  tradecue     NUMBER(10)
)
;
alter table HISTORYBILLDATA
  add constraint PK_HISTORYBILLDATA primary key (MARKETID, COMMODITYID, TOTALAMOUNT, TIME);

prompt
prompt Creating table HISTORYDAYDATA
prompt =============================
prompt
create table HISTORYDAYDATA
(
  marketid     VARCHAR2(4) default '00' not null,
  commodityid  VARCHAR2(16) not null,
  tradedate    DATE not null,
  openprice    NUMBER(12,4) not null,
  closeprice   NUMBER(12,4) not null,
  highprice    NUMBER(12,4) not null,
  lowprice     NUMBER(12,4) not null,
  balanceprice NUMBER(12,4) default 0 not null,
  totalamount  NUMBER(10) not null,
  totalmoney   NUMBER(20,4) not null,
  reservecount NUMBER(10) default 0 not null
)
;
alter table HISTORYDAYDATA
  add constraint PK_HISTORYDAYDATA primary key (MARKETID, COMMODITYID, TRADEDATE);

prompt
prompt Creating table HISTORYMINDATA
prompt =============================
prompt
create table HISTORYMINDATA
(
  marketid     VARCHAR2(4) default '00' not null,
  commodityid  VARCHAR2(16) not null,
  tradedate    DATE not null,
  openprice    NUMBER(12,4) not null,
  highprice    NUMBER(12,4) not null,
  lowprice     NUMBER(12,4) not null,
  closeprice   NUMBER(12,4) not null,
  balanceprice NUMBER(12,4) default 0 not null,
  totalamount  NUMBER(10) not null,
  totalmoney   NUMBER(20,4) not null,
  reservecount NUMBER(10) default 0 not null
)
;
alter table HISTORYMINDATA
  add constraint PK_HISTORYMINDATA primary key (MARKETID, COMMODITYID, TRADEDATE);

prompt
prompt Creating table INDUSTRYDIC
prompt ==========================
prompt
create table INDUSTRYDIC
(
  industrycode VARCHAR2(10) default '00' not null,
  industryname VARCHAR2(10) not null,
  updatetime   TIMESTAMP(6) not null
)
;
alter table INDUSTRYDIC
  add constraint PK_INDUSTRYDIC primary key (INDUSTRYCODE);

prompt
prompt Creating table MARKETINFO
prompt =========================
prompt
create table MARKETINFO
(
  marketid    VARCHAR2(4) default '00' not null,
  marketname  VARCHAR2(64),
  direction   CHAR(10),
  updatetime  TIMESTAMP(6) not null,
  description BLOB
)
;
alter table MARKETINFO
  add constraint PK_MARKETINFO primary key (MARKETID);

prompt
prompt Creating table Q_MARKET
prompt =======================
prompt
create table Q_MARKET
(
  marketid  VARCHAR2(4) default '00' not null,
  marketurl VARCHAR2(512) not null,
  hqurl     VARCHAR2(512) not null,
  status    CHAR(1) not null
)
;
alter table Q_MARKET
  add constraint PK_Q_MARKET primary key (MARKETID);

prompt
prompt Creating table TODAYBILLDATA
prompt ============================
prompt
create table TODAYBILLDATA
(
  marketid     VARCHAR2(4) default '00' not null,
  commodityid  VARCHAR2(16) not null,
  totalamount  NUMBER(10) not null,
  time         DATE not null,
  curprice     NUMBER(12,4) not null,
  openamount   NUMBER(10) not null,
  closeamount  NUMBER(10) not null,
  reservecount NUMBER(10) not null,
  balanceprice NUMBER(12,4) default 0 not null,
  totalmoney   NUMBER(20,4) not null,
  buyprice1    NUMBER(12,4) not null,
  sellprice1   NUMBER(12,4) not null,
  buyamount1   NUMBER(10) not null,
  sellamount1  NUMBER(10) not null,
  buyprice2    NUMBER(12,4) not null,
  sellprice2   NUMBER(12,4) not null,
  buyamount2   NUMBER(10) not null,
  sellamount2  NUMBER(10) not null,
  buyprice3    NUMBER(12,4) not null,
  sellprice3   NUMBER(12,4) not null,
  buyamount3   NUMBER(10) not null,
  sellamount3  NUMBER(10) not null,
  tradecue     NUMBER(10) not null
)
;
alter table TODAYBILLDATA
  add constraint PK_TODAYBILLDATA primary key (MARKETID, COMMODITYID, TOTALAMOUNT, TIME);

prompt
prompt Creating table TRADETIME
prompt ========================
prompt
create table TRADETIME
(
  marketid     VARCHAR2(4) default '00' not null,
  tradesection NUMBER(4) not null,
  endtime      VARCHAR2(32) not null,
  begintime    VARCHAR2(32) not null,
  breakon      VARCHAR2(14),
  begindate    VARCHAR2(14),
  enddate      VARCHAR2(14),
  breakoff     VARCHAR2(14),
  status       NUMBER(4) default 1 not null,
  modifytime   DATE not null,
  tradedate    VARCHAR2(14) not null
)
;
alter table TRADETIME
  add constraint PK_TRADETIME primary key (MARKETID, TRADESECTION);


spool off
