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
  is 'ҡ����Ϣ';
comment on column IPO_BALLOTNO_INFO.commodityid
  is '��Ʒ���';
comment on column IPO_BALLOTNO_INFO.ballotnostartlen
  is 'β����ʼλ';
comment on column IPO_BALLOTNO_INFO.ballotnoendlen
  is 'β�Ž���λ';
comment on column IPO_BALLOTNO_INFO.ballotno
  is 'β��';
comment on column IPO_BALLOTNO_INFO.createtime
  is 'β�Ŵ���ʱ��';
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
  is 'Ʒ��ID';
comment on column IPO_BREED.breedname
  is 'Ʒ������';
comment on column IPO_BREED.sortid
  is '����ID(��Ӧmbreed���categoryid)';
comment on column IPO_BREED.contractfactor
  is '���׵�λ';
comment on column IPO_BREED.minpricemove
  is '��С�䶯��λ(Ԫ)';
comment on column IPO_BREED.spreadalgr
  is '�ǵ�ͣ���㷨(1�����ٷֱ�  2��������ֵ)';
comment on column IPO_BREED.spreaduplmt
  is '�Ƿ�����';
comment on column IPO_BREED.spreaddownlmt
  is '��������';
comment on column IPO_BREED.minquantitymove
  is '��С�䶯����';
comment on column IPO_BREED.contractfactorname
  is '���۵�λ(��Ӧmbreed���unit)';
comment on column IPO_BREED.minapplynum
  is '��С�깺����';
comment on column IPO_BREED.maxapplynum
  is '����깺����';
comment on column IPO_BREED.minapplyquamove
  is '��С�깺�䶯��';
comment on column IPO_BREED.publishalgr
  is '�����������㷨(1�����ٷֱ�  2��������ֵ)';
comment on column IPO_BREED.dealerpubcharatio
  is '�����̷��������ѱ���';
comment on column IPO_BREED.mktdeapubcharatio
  is '�����̷����������г��������';
comment on column IPO_BREED.publishercharatio
  is '�����̷��������ѱ���';
comment on column IPO_BREED.mktpubcharatio
  is '�����̷����������г��������';
comment on column IPO_BREED.contractcurrency
  is '���ۻ���';
comment on column IPO_BREED.tradedays
  is 'T+N��������';
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
  is '��Ʒ���';
comment on column IPO_COMMODITY_CONF.commodityname
  is '��Ʒ����';
comment on column IPO_COMMODITY_CONF.price
  is '���м�';
comment on column IPO_COMMODITY_CONF.units
  is '���۵�λ';
comment on column IPO_COMMODITY_CONF.counts
  is '��������';
comment on column IPO_COMMODITY_CONF.starttime
  is '��ʼʱ��';
comment on column IPO_COMMODITY_CONF.endtime
  is '����ʱ��';
comment on column IPO_COMMODITY_CONF.maxapplynum
  is '�깺��ȣ�����깺������';
comment on column IPO_COMMODITY_CONF.status
  is '0���깺�ɹ�
1����ųɹ�
2��ҡ�ųɹ�
3������ɹ�';
comment on column IPO_COMMODITY_CONF.breedid
  is 'Ʒ�ֱ��';
comment on column IPO_COMMODITY_CONF.tradedays
  is 'T+N��������';
comment on column IPO_COMMODITY_CONF.codedelivery
  is '�Ƿ����������';
comment on column IPO_COMMODITY_CONF.nonissuereg
  is '�Ƿ���ע��';
comment on column IPO_COMMODITY_CONF.pubmemberid
  is '���л�Ա���';
comment on column IPO_COMMODITY_CONF.minapplynum
  is '��С�깺����';
comment on column IPO_COMMODITY_CONF.minapplyquamove
  is '��С�깺�䶯��';
comment on column IPO_COMMODITY_CONF.publishalgr
  is '�����������㷨(1�����ٷֱ�  2��������ֵ)';
comment on column IPO_COMMODITY_CONF.dealerpubcharatio
  is '�����̷��������ѱ���';
comment on column IPO_COMMODITY_CONF.mktdeapubcharatio
  is '�����̷����������г��������';
comment on column IPO_COMMODITY_CONF.publishercharatio
  is '�����̷��������ѱ���';
comment on column IPO_COMMODITY_CONF.mktpubcharatio
  is '�����̷����������г��������';
comment on column IPO_COMMODITY_CONF.currstatus
  is '��ǰ״̬ 0����Ч 1����ͣ����';
comment on column IPO_COMMODITY_CONF.supervisedprice
  is '����ָ����';
comment on column IPO_COMMODITY_CONF.listingdate
  is '��������';
comment on column IPO_COMMODITY_CONF.lasttradate
  is '�������';
comment on column IPO_COMMODITY_CONF.contractfactor
  is '���׵�λ';
comment on column IPO_COMMODITY_CONF.minpricemove
  is '��С�䶯��λ';
comment on column IPO_COMMODITY_CONF.minquantitymove
  is '��С�䶯��';
comment on column IPO_COMMODITY_CONF.spreadalgr
  is '�ǵ�ͣ���㷨';
comment on column IPO_COMMODITY_CONF.spreaduplmt
  is '�Ƿ�����';
comment on column IPO_COMMODITY_CONF.spreaddownlmt
  is '�����Ƿ�';
comment on column IPO_COMMODITY_CONF.contractfactorname
  is '���׵�λ�����ʣ�';
comment on column IPO_COMMODITY_CONF.mapperid
  is '��Ӧ�ֻ���ƷID';
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
  is '��Ʒ�б�';
comment on column IPO_COMMODITY_SALE.commodityid
  is '��Ʒ���';
comment on column IPO_COMMODITY_SALE.commodityname
  is '��Ʒ����';
comment on column IPO_COMMODITY_SALE.price
  is '���ۼ�';
comment on column IPO_COMMODITY_SALE.units
  is '���۵�λ';
comment on column IPO_COMMODITY_SALE.counts
  is '��������';
comment on column IPO_COMMODITY_SALE.starttime
  is '��ʼʱ��';
comment on column IPO_COMMODITY_SALE.endtime
  is '����ʱ��';
comment on column IPO_COMMODITY_SALE.purchasecredits
  is '�깺���';
comment on column IPO_COMMODITY_SALE.status
  is '0���깺�ɹ�
1����ųɹ�
2��ҡ�ųɹ�
3������ɹ�';
comment on column IPO_COMMODITY_SALE.id
  is '����';
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
  is '��ţ���ǩ���';
comment on column IPO_DISTRIBUTION.userid
  is '�ͻ����';
comment on column IPO_DISTRIBUTION.commodityname
  is '��Ʒ����';
comment on column IPO_DISTRIBUTION.startnumber
  is '��ʼ���';
comment on column IPO_DISTRIBUTION.pcounts
  is '�������';
comment on column IPO_DISTRIBUTION.ptime
  is '���ʱ��';
comment on column IPO_DISTRIBUTION.zcounts
  is '��ǩ����';
comment on column IPO_DISTRIBUTION.numbers
  is '��ǩ����';
comment on column IPO_DISTRIBUTION.commodityid
  is '��Ʒ���';
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
  is '���ڼ�';
comment on column IPO_NOTTRADEDAY.day
  is '����';
comment on column IPO_NOTTRADEDAY.modifytime
  is '�޸�ʱ��';
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
  is '��Ʒ���';
comment on column IPO_NUMBEROFRECORDS.counts
  is '�������';
comment on column IPO_NUMBEROFRECORDS.nowtime
  is 'ʱ��';
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
  is '��Ʒ����';
comment on column IPO_NUMBEROFRECORDS_H.nowtime
  is 'ʱ��';
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
  is '������';
comment on column IPO_ORDER.userid
  is '�ͻ����';
comment on column IPO_ORDER.username
  is '�ͻ�����';
comment on column IPO_ORDER.commodityid
  is '��Ʒ���';
comment on column IPO_ORDER.commodityname
  is '��Ʒ����';
comment on column IPO_ORDER.counts
  is '�ͻ��깺��';
comment on column IPO_ORDER.createtime
  is '�깺ʱ��';
comment on column IPO_ORDER.frozenfunds
  is '�ʽ𶳽�';
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
  is '�ͻ����';
comment on column IPO_ORDER_H.username
  is '�ͻ�����';
comment on column IPO_ORDER_H.commodityid
  is '��Ʒ���';
comment on column IPO_ORDER_H.commodityname
  is '��Ʒ����';
comment on column IPO_ORDER_H.counts
  is '�ͻ��깺��';
comment on column IPO_ORDER_H.createtime
  is '�깺ʱ��';
comment on column IPO_ORDER_H.frozenfunds
  is '�ʽ𶳽�';
comment on column IPO_ORDER_H.commodity_id
  is '����id';
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
  is '���׽�����';
comment on column IPO_TRADETIME.starttime
  is '��ʼʱ��';
comment on column IPO_TRADETIME.endtime
  is '����ʱ��';
comment on column IPO_TRADETIME.status
  is '״̬
0:��Ч
1:��Ч';
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
  is '����';
comment on column IPO_TRADETIME_COMM.tradetimeid
  is '���׽�ID';
comment on column IPO_TRADETIME_COMM.commodityid
  is '��ƷID';
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
