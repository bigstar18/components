--------------------------------------------------
-- Export file for user TRADE_GNNT@SPOT.DEV.183 --
-- Created by hxx on 2015/11/11, 22:33:51 --------
--------------------------------------------------

set define off
spool finance.struct.log

prompt
prompt Creating table F_ACCOUNT
prompt ========================
prompt
create table F_ACCOUNT
(
  code         VARCHAR2(38) not null,
  name         VARCHAR2(64) not null,
  accountlevel NUMBER(2) not null,
  dcflag       CHAR(1) not null,
  isinit       CHAR(1) default 'Y' not null
)
;
comment on column F_ACCOUNT.dcflag
  is 'D:Debit ��
C:Credit ��
';
comment on column F_ACCOUNT.isinit
  is 'Y:�ǳ�ʼ������,ҳ�治����ɾ�����޸�
N:���ǳ�ʼ������';
alter table F_ACCOUNT
  add constraint PK_F_ACCOUNT primary key (CODE);

prompt
prompt Creating table F_ACCOUNTBOOK
prompt ============================
prompt
create table F_ACCOUNTBOOK
(
  b_date     DATE not null,
  summaryno  CHAR(5) not null,
  summary    VARCHAR2(32),
  voucherno  NUMBER(10) not null,
  contractno VARCHAR2(16),
  debitcode  VARCHAR2(38) not null,
  creditcode VARCHAR2(38) not null,
  amount     NUMBER(15,2) default 0 not null
)
;
create index IX_F_ACCOUNTBOOK_BD on F_ACCOUNTBOOK (B_DATE);
create index IX_F_ACCOUNTBOOK_C on F_ACCOUNTBOOK (CREDITCODE);
create index IX_F_ACCOUNTBOOK_D on F_ACCOUNTBOOK (DEBITCODE);

prompt
prompt Creating table F_BANKCLEARLEDGERCONFIG
prompt ======================================
prompt
create table F_BANKCLEARLEDGERCONFIG
(
  ledgercode VARCHAR2(16) not null,
  feetype    NUMBER(2) not null,
  fieldsign  NUMBER(1) not null
)
;
alter table F_BANKCLEARLEDGERCONFIG
  add constraint PK_F_BANKCLEARLEDGERCONFIG primary key (LEDGERCODE);

prompt
prompt Creating table F_B_BANKACCOUNT
prompt ==============================
prompt
create table F_B_BANKACCOUNT
(
  bankid       VARCHAR2(32) not null,
  account      VARCHAR2(32) not null,
  status       NUMBER(1) default 0 not null,
  accountname  VARCHAR2(100),
  bankname     VARCHAR2(128),
  bankprovince VARCHAR2(128),
  bankcity     VARCHAR2(128),
  mobile       VARCHAR2(32),
  email        VARCHAR2(128),
  cardtype     VARCHAR2(2) default 1 not null,
  card         VARCHAR2(32)
)
;
comment on table F_B_BANKACCOUNT
  is '���������ʻ���';
comment on column F_B_BANKACCOUNT.bankid
  is '���б��';
comment on column F_B_BANKACCOUNT.account
  is '�����ʺ�';
comment on column F_B_BANKACCOUNT.status
  is '״̬(0 ����,1 ����)';
comment on column F_B_BANKACCOUNT.accountname
  is '�˻���';
comment on column F_B_BANKACCOUNT.bankname
  is '��������';
comment on column F_B_BANKACCOUNT.bankprovince
  is '����ʡ��';
comment on column F_B_BANKACCOUNT.bankcity
  is '����������';
comment on column F_B_BANKACCOUNT.mobile
  is '�绰����';
comment on column F_B_BANKACCOUNT.email
  is '����';
comment on column F_B_BANKACCOUNT.cardtype
  is '�ʻ�����(1 ���֤,2����֤,3���ڻ���,4���ڱ�,5ѧԱ֤,6����֤,7��ʱ���֤,8��֯��������,9Ӫҵִ��,A����֤,B��ž�ʿ��֤,C����֤,D�������,E�۰�̨�������֤,F̨��ͨ��֤��������Ч����֤,G����ͻ����,H��ž���ְ�ɲ�֤,I�侯��ְ�ɲ�֤,J�侯ʿ��֤,X������Ч֤��,Z�غ����֤)(��Ҫ�õ��� 1��8,���� 9 �� ������û���õ�';
comment on column F_B_BANKACCOUNT.card
  is '֤������';

prompt
prompt Creating table F_B_BANKCAPITALRESULT
prompt ====================================
prompt
create table F_B_BANKCAPITALRESULT
(
  bankid     VARCHAR2(20) not null,
  firmid     VARCHAR2(20) not null,
  bankright  NUMBER(10,2) not null,
  maketright NUMBER(10,2) not null,
  reason     NUMBER,
  bdate      TIMESTAMP(6) not null
)
;
comment on table F_B_BANKCAPITALRESULT
  is '�ַֺ˶Ա�';
comment on column F_B_BANKCAPITALRESULT.bankid
  is '���б��';
comment on column F_B_BANKCAPITALRESULT.firmid
  is '�����̴���';
comment on column F_B_BANKCAPITALRESULT.bankright
  is '����Ȩ��';
comment on column F_B_BANKCAPITALRESULT.maketright
  is '�г�Ȩ��';
comment on column F_B_BANKCAPITALRESULT.reason
  is '��ƽԭ��(0��ƽ 1���ж��˻�δ���� 2�������˻�δ����)';
comment on column F_B_BANKCAPITALRESULT.bdate
  is '����ʱ��';
alter table F_B_BANKCAPITALRESULT
  add constraint PK_F_B_BANKCAPITALRESULT primary key (BANKID, FIRMID, BDATE);

prompt
prompt Creating table F_B_BANKCOMPAREINFO
prompt ==================================
prompt
create table F_B_BANKCOMPAREINFO
(
  id          NUMBER(12) not null,
  funid       VARCHAR2(100) not null,
  firmid      VARCHAR2(32),
  account     VARCHAR2(32) not null,
  type        NUMBER(1) not null,
  money       NUMBER(12,2) not null,
  comparedate DATE not null,
  note        VARCHAR2(128),
  createtime  DATE not null,
  status      NUMBER(1) not null,
  bankid      VARCHAR2(32) not null
)
;
comment on table F_B_BANKCOMPAREINFO
  is '���ж�����Ϣ��';
comment on column F_B_BANKCOMPAREINFO.id
  is '���ж�����ϢID';
comment on column F_B_BANKCOMPAREINFO.funid
  is '������ˮ��';
comment on column F_B_BANKCOMPAREINFO.firmid
  is '�����̴���';
comment on column F_B_BANKCOMPAREINFO.account
  is '�������˺�';
comment on column F_B_BANKCOMPAREINFO.type
  is '��������(0 ���,1 ����)';
comment on column F_B_BANKCOMPAREINFO.money
  is '���';
comment on column F_B_BANKCOMPAREINFO.comparedate
  is '��������';
comment on column F_B_BANKCOMPAREINFO.note
  is '��ע';
comment on column F_B_BANKCOMPAREINFO.createtime
  is '��������';
comment on column F_B_BANKCOMPAREINFO.status
  is '����״̬';
comment on column F_B_BANKCOMPAREINFO.bankid
  is '���б��';
alter table F_B_BANKCOMPAREINFO
  add constraint PK_F_B_BANKCOMPAREINFO primary key (FUNID, BANKID, COMPAREDATE);

prompt
prompt Creating table F_B_BANKQSDATE
prompt =============================
prompt
create table F_B_BANKQSDATE
(
  bankid      VARCHAR2(32) not null,
  tradedate   DATE not null,
  tradetype   NUMBER(2),
  tradestatus NUMBER(2),
  note        VARCHAR2(32),
  createdate  DATE default sysdate not null
)
;
comment on table F_B_BANKQSDATE
  is '��������ʱ���';
comment on column F_B_BANKQSDATE.bankid
  is '���б��';
comment on column F_B_BANKQSDATE.tradedate
  is '��������';
comment on column F_B_BANKQSDATE.tradetype
  is '��������';
comment on column F_B_BANKQSDATE.tradestatus
  is '����״̬(0 �ɹ�,1 ʧ��)';
comment on column F_B_BANKQSDATE.note
  is '��ע��Ϣ';
comment on column F_B_BANKQSDATE.createdate
  is '��¼����ʱ��';

prompt
prompt Creating table F_B_BANKS
prompt ========================
prompt
create table F_B_BANKS
(
  bankid              VARCHAR2(32) not null,
  bankname            VARCHAR2(64) not null,
  maxpersgltransmoney NUMBER(12,2) not null,
  maxpertransmoney    NUMBER(12,2) not null,
  maxpertranscount    NUMBER(7) not null,
  adapterclassname    VARCHAR2(50) not null,
  validflag           NUMBER(1) not null,
  maxauditmoney       NUMBER(12,2),
  begintime           VARCHAR2(8) default '00:00:00',
  endtime             VARCHAR2(8) default '23:59:59',
  control             NUMBER(2) default 0
)
;
comment on table F_B_BANKS
  is '���б�';
comment on column F_B_BANKS.bankid
  is '���б��';
comment on column F_B_BANKS.bankname
  is '��������';
comment on column F_B_BANKS.maxpersgltransmoney
  is '�������ת�˽��';
comment on column F_B_BANKS.maxpertransmoney
  is 'ÿ�����ת�˽��';
comment on column F_B_BANKS.maxpertranscount
  is 'ÿ�����ת�˴���';
comment on column F_B_BANKS.adapterclassname
  is '������ʵ��������';
comment on column F_B_BANKS.validflag
  is '����״̬(0 ����,1 ������)';
comment on column F_B_BANKS.maxauditmoney
  is '�������г�����˶��';
comment on column F_B_BANKS.begintime
  is '������ʼת��ʱ��';
comment on column F_B_BANKS.endtime
  is '���н���ת��ʱ��';
comment on column F_B_BANKS.control
  is '�Ƿ��ܵ������պͽ���ʱ���Լ�� (0 ��˫��Լ��,1 ����Լ��,2 �ܽ�����Լ��,3 �ܽ���ʱ��Լ��)';
alter table F_B_BANKS
  add constraint PK_F_B_BANKS primary key (BANKID);

prompt
prompt Creating table F_B_BANKTRANSFER
prompt ===============================
prompt
create table F_B_BANKTRANSFER
(
  id         NUMBER(12) not null,
  paybankid  VARCHAR2(32) not null,
  recbankid  VARCHAR2(32) not null,
  money      NUMBER(15,2) default 0.00 not null,
  moneytype  VARCHAR2(2) default 0,
  funid      VARCHAR2(100),
  maerketid  VARCHAR2(100),
  note       VARCHAR2(100),
  status     NUMBER(2) not null,
  createtime TIMESTAMP(6) not null,
  updatetime TIMESTAMP(6) not null
)
;
comment on table F_B_BANKTRANSFER
  is '��������ת�˱�';
comment on column F_B_BANKTRANSFER.paybankid
  is 'ת������ID���б��';
comment on column F_B_BANKTRANSFER.recbankid
  is 'תת������ID���б��';
comment on column F_B_BANKTRANSFER.money
  is '�����ʽ�';
comment on column F_B_BANKTRANSFER.moneytype
  is '0Ϊ�����';
comment on column F_B_BANKTRANSFER.funid
  is '������ˮ��';
comment on column F_B_BANKTRANSFER.maerketid
  is '������ˮ��';
comment on column F_B_BANKTRANSFER.status
  is '0 �ɹ�,1 ʧ��,2 ������,3 һ�����,4 �������,5 ���з�����ϢΪ��,6 ���з����г���ˮ�ź��г�������ˮ�Ų�һ��,13 �г������г��������״̬';

prompt
prompt Creating table F_B_BATCUSTFILE
prompt ==============================
prompt
create table F_B_BATCUSTFILE
(
  custacctid   VARCHAR2(32) not null,
  custname     VARCHAR2(120),
  thirdcustid  VARCHAR2(32),
  bankbalance  NUMBER(18,2),
  bankfrozen   NUMBER(18,2),
  maketbalance NUMBER(18,2),
  maketfrozen  NUMBER(18,2),
  balanceerror NUMBER(18,2),
  frozenerror  NUMBER(18,2),
  tradedate    DATE not null,
  bankid       VARCHAR2(32),
  createdate   DATE default sysdate,
  note         VARCHAR2(120)
)
;
comment on table F_B_BATCUSTFILE
  is '���˲�ƽ��¼';
comment on column F_B_BATCUSTFILE.custacctid
  is '���˺�';
comment on column F_B_BATCUSTFILE.custname
  is '����';
comment on column F_B_BATCUSTFILE.thirdcustid
  is '��Ա����';
comment on column F_B_BATCUSTFILE.bankbalance
  is '���������������';
comment on column F_B_BATCUSTFILE.bankfrozen
  is '��������󶳽����';
comment on column F_B_BATCUSTFILE.maketbalance
  is '�������������';
comment on column F_B_BATCUSTFILE.maketfrozen
  is '�������������';
comment on column F_B_BATCUSTFILE.balanceerror
  is '�����������п������-������������';
comment on column F_B_BATCUSTFILE.frozenerror
  is '�����������ж������-������������';
comment on column F_B_BATCUSTFILE.tradedate
  is '����ʱ��';
comment on column F_B_BATCUSTFILE.bankid
  is '���б��';
comment on column F_B_BATCUSTFILE.createdate
  is '��������';
comment on column F_B_BATCUSTFILE.note
  is '��ע��Ϣ';
alter table F_B_BATCUSTFILE
  add constraint PK_F_B_BATCUSTFILE primary key (CUSTACCTID, TRADEDATE);

prompt
prompt Creating table F_B_CAPITALINFO
prompt ==============================
prompt
create table F_B_CAPITALINFO
(
  id         NUMBER(12) not null,
  firmid     VARCHAR2(32) not null,
  funid      VARCHAR2(100),
  bankid     VARCHAR2(32) not null,
  debitid    VARCHAR2(32) not null,
  creditid   VARCHAR2(32) not null,
  type       NUMBER(2) not null,
  money      NUMBER(12,2) not null,
  operator   VARCHAR2(32),
  createtime DATE not null,
  banktime   DATE,
  status     NUMBER(2) not null,
  note       VARCHAR2(128),
  actionid   NUMBER(12) not null,
  express    NUMBER(1) default 0,
  bankname   VARCHAR2(50),
  account    VARCHAR2(21),
  createdate VARCHAR2(32) not null,
  funid2     VARCHAR2(100) not null
)
;
comment on table F_B_CAPITALINFO
  is '�г���ˮ��';
comment on column F_B_CAPITALINFO.id
  is '��ˮID';
comment on column F_B_CAPITALINFO.firmid
  is '�����̴���';
comment on column F_B_CAPITALINFO.funid
  is '������ˮ��';
comment on column F_B_CAPITALINFO.bankid
  is '���б��';
comment on column F_B_CAPITALINFO.debitid
  is '��������';
comment on column F_B_CAPITALINFO.creditid
  is '�跽����';
comment on column F_B_CAPITALINFO.type
  is '��ˮ����(0 ���,1 ����,2�����������';
comment on column F_B_CAPITALINFO.money
  is '��ˮ���';
comment on column F_B_CAPITALINFO.operator
  is 'ҵ�����';
comment on column F_B_CAPITALINFO.createtime
  is '����ʱ��';
comment on column F_B_CAPITALINFO.banktime
  is '�����¼�';
comment on column F_B_CAPITALINFO.status
  is '״̬(0 �ɹ�,1 ʧ��,2 ������,3 һ�����,4 �������,5 ���з�����ϢΪ��,6 ���з����г���ˮ�ź��г�������ˮ�Ų�һ��,13 �г������г��������״̬)';
comment on column F_B_CAPITALINFO.note
  is '��ע��Ϣ';
comment on column F_B_CAPITALINFO.actionid
  is 'ҵ����ˮ';
comment on column F_B_CAPITALINFO.express
  is '�Ƿ�Ӽ�';
comment on column F_B_CAPITALINFO.bankname
  is '����ӵ�(��������)';
comment on column F_B_CAPITALINFO.account
  is '����ӵ�(�����˺�)';
comment on column F_B_CAPITALINFO.createdate
  is '����ʱ��';
comment on column F_B_CAPITALINFO.funid2
  is '��ˮ2';
alter table F_B_CAPITALINFO
  add constraint PK_F_B_CAPITALINFO primary key (BANKID, TYPE, CREATEDATE, FUNID2);

prompt
prompt Creating table F_B_DICTIONARY
prompt =============================
prompt
create table F_B_DICTIONARY
(
  id     NUMBER(5) not null,
  type   NUMBER(5) not null,
  bankid VARCHAR2(32),
  name   VARCHAR2(128) not null,
  value  VARCHAR2(128),
  note   VARCHAR2(256) not null
)
;
comment on table F_B_DICTIONARY
  is '�ֵ��';
comment on column F_B_DICTIONARY.id
  is '�ֵ�ID';
comment on column F_B_DICTIONARY.type
  is '����';
comment on column F_B_DICTIONARY.bankid
  is '���б��';
comment on column F_B_DICTIONARY.name
  is '�ֵ���';
comment on column F_B_DICTIONARY.value
  is '�ֵ�ֵ';
comment on column F_B_DICTIONARY.note
  is '��ע';
alter table F_B_DICTIONARY
  add constraint PK_F_B_DICTIONARY primary key (ID);

prompt
prompt Creating table F_B_FEEINFO
prompt ==========================
prompt
create table F_B_FEEINFO
(
  id           NUMBER(12) not null,
  uplimit      NUMBER(12,2) not null,
  downlimit    NUMBER(12,2) not null,
  tmode        NUMBER(1) not null,
  rate         NUMBER not null,
  type         VARCHAR2(128) not null,
  createtime   DATE default SYSDATE,
  updatetime   DATE,
  userid       VARCHAR2(12) not null,
  maxratevalue NUMBER,
  minratevalue NUMBER
)
;
comment on table F_B_FEEINFO
  is '��׼���ñ�';
comment on column F_B_FEEINFO.id
  is '�����б�ID';
comment on column F_B_FEEINFO.uplimit
  is '�������';
comment on column F_B_FEEINFO.downlimit
  is '��ʼ���';
comment on column F_B_FEEINFO.tmode
  is '�������(0 �ٷֱ�,2 ����ֵ)';
comment on column F_B_FEEINFO.rate
  is '������';
comment on column F_B_FEEINFO.type
  is '�շ�����';
comment on column F_B_FEEINFO.createtime
  is '��¼ʱ��';
comment on column F_B_FEEINFO.updatetime
  is '�޸�ʱ��';
comment on column F_B_FEEINFO.userid
  is '�û�ID(��¼��,������,����)';
comment on column F_B_FEEINFO.maxratevalue
  is '�����';
comment on column F_B_FEEINFO.minratevalue
  is '��С���';
alter table F_B_FEEINFO
  add constraint PK_F_B_FEEINFO primary key (UPLIMIT, DOWNLIMIT, USERID, TYPE);

prompt
prompt Creating table F_B_FFHD
prompt =======================
prompt
create table F_B_FFHD
(
  bankid      VARCHAR2(32) not null,
  tradedate   DATE not null,
  firmid      VARCHAR2(32) not null,
  account     VARCHAR2(32) not null,
  currency    VARCHAR2(10) default '001' not null,
  type        NUMBER(2) default 0 not null,
  reasion     NUMBER(2) default 0 not null,
  balancem    NUMBER(15,2),
  cashm       NUMBER(15,2),
  billm       NUMBER(15,2),
  usebalancem NUMBER(15,2),
  frozencashm NUMBER(15,2),
  frozenloanm NUMBER(15,2),
  balanceb    NUMBER(15,2),
  cashb       NUMBER(15,2),
  billb       NUMBER(15,2),
  usebalanceb NUMBER(15,2),
  frozencashb NUMBER(15,2),
  frozenloanb NUMBER(15,2),
  createdate  DATE default sysdate not null
)
;
comment on table F_B_FFHD
  is '�ַֺ˶Ա�';
comment on column F_B_FFHD.bankid
  is '���б��';
comment on column F_B_FFHD.tradedate
  is '��������';
comment on column F_B_FFHD.firmid
  is '�����̱��';
comment on column F_B_FFHD.account
  is '�����������˺�';
comment on column F_B_FFHD.currency
  is '�ұ� (001������� 013���۱� 014����Ԫ)';
comment on column F_B_FFHD.type
  is '�����ʶ (0���� 1����)';
comment on column F_B_FFHD.reasion
  is '��ƽԭ�� (0:��ƽ 1:���ж��ʽ����˻�δ���� 2:�г��˽����̴��벻����)';
comment on column F_B_FFHD.balancem
  is '�г���Ȩ��';
comment on column F_B_FFHD.cashm
  is '�г��ֽ�Ȩ��';
comment on column F_B_FFHD.billm
  is '�г�Ʊ��Ȩ��';
comment on column F_B_FFHD.usebalancem
  is '�г������ʽ�';
comment on column F_B_FFHD.frozencashm
  is '�г�ռ���ֽ�';
comment on column F_B_FFHD.frozenloanm
  is '�г�ռ�ô�����';
comment on column F_B_FFHD.balanceb
  is '������Ȩ��';
comment on column F_B_FFHD.cashb
  is '�����ֽ�Ȩ��';
comment on column F_B_FFHD.billb
  is '����Ʊ��Ȩ��';
comment on column F_B_FFHD.usebalanceb
  is '���п����ʽ�';
comment on column F_B_FFHD.frozencashb
  is '����ռ���ֽ�';
comment on column F_B_FFHD.frozenloanb
  is '����ռ�ô�����';
comment on column F_B_FFHD.createdate
  is '����ʱ��';
alter table F_B_FFHD
  add constraint PK_F_B_FFHD primary key (BANKID, TRADEDATE, FIRMID);

prompt
prompt Creating table F_B_FIRMBALANCE
prompt ==============================
prompt
create table F_B_FIRMBALANCE
(
  custacctid    VARCHAR2(32) not null,
  custname      VARCHAR2(120),
  thirdcustid   VARCHAR2(32),
  status        NUMBER(2),
  type          NUMBER(2),
  istruecont    NUMBER(2),
  balance       NUMBER(18,2),
  usrbalance    NUMBER(18,2),
  frozenbalance NUMBER(18,2),
  interest      NUMBER(18,2),
  bankid        VARCHAR2(32),
  tradedate     DATE not null,
  createdate    DATE
)
;
comment on table F_B_FIRMBALANCE
  is '��Ա����¼';
comment on column F_B_FIRMBALANCE.custacctid
  is '���˺�';
comment on column F_B_FIRMBALANCE.custname
  is '�˻���';
comment on column F_B_FIRMBALANCE.thirdcustid
  is '��Ա����';
comment on column F_B_FIRMBALANCE.status
  is '״̬(1������  2���˳�  3����ȷ��)';
comment on column F_B_FIRMBALANCE.type
  is '�˺�����(1����ͨ��Ա���˺�  2���������˺�  3�����������˺�  4����Ϣ���˺�  6���������˺�)';
comment on column F_B_FIRMBALANCE.istruecont
  is '�Ƿ�ʵ���˺�(Ĭ��Ϊ 1�������˺�)';
comment on column F_B_FIRMBALANCE.balance
  is '�ܶ�';
comment on column F_B_FIRMBALANCE.usrbalance
  is '�������';
comment on column F_B_FIRMBALANCE.frozenbalance
  is '�����ʽ�';
comment on column F_B_FIRMBALANCE.interest
  is '��Ϣ����';
comment on column F_B_FIRMBALANCE.bankid
  is '���д���';
comment on column F_B_FIRMBALANCE.tradedate
  is '��������';
comment on column F_B_FIRMBALANCE.createdate
  is '��Ϣ����ʱ��';
alter table F_B_FIRMBALANCE
  add constraint PK_F_B_FIRMBALANCE primary key (CUSTACCTID, TRADEDATE);

prompt
prompt Creating table F_B_FIRMBALANCEERROR
prompt ===================================
prompt
create table F_B_FIRMBALANCEERROR
(
  trandatetime    DATE not null,
  counterid       VARCHAR2(12),
  supacctid       VARCHAR2(32),
  funccode        VARCHAR2(4),
  custacctid      VARCHAR2(32) not null,
  custname        VARCHAR2(120),
  thirdcustid     VARCHAR2(32),
  thirdlogno      VARCHAR2(20),
  ccycode         VARCHAR2(3),
  freezeamount    NUMBER(18,2),
  unfreezeamount  NUMBER(18,2),
  addtranamount   NUMBER(18,2),
  cuttranamount   NUMBER(18,2),
  profitamount    NUMBER(18,2),
  lossamount      NUMBER(18,2),
  tranhandfee     NUMBER(18,2),
  trancount       NUMBER(30),
  newbalance      NUMBER(18,2),
  newfreezeamount NUMBER(18,2),
  note            VARCHAR2(120),
  reserve         VARCHAR2(120),
  rspcode         VARCHAR2(6),
  rspmsg          VARCHAR2(256),
  bankid          VARCHAR2(32),
  createtime      DATE
)
;
comment on table F_B_FIRMBALANCEERROR
  is '���ж���ʧ���ļ�';
comment on column F_B_FIRMBALANCEERROR.trandatetime
  is '����ʱ��';
comment on column F_B_FIRMBALANCEERROR.counterid
  is '����Ա';
comment on column F_B_FIRMBALANCEERROR.supacctid
  is '�ʽ�����ʺ�';
comment on column F_B_FIRMBALANCEERROR.funccode
  is '���ܴ���';
comment on column F_B_FIRMBALANCEERROR.custacctid
  is '���˻��˺�';
comment on column F_B_FIRMBALANCEERROR.custname
  is '���˻�����';
comment on column F_B_FIRMBALANCEERROR.thirdcustid
  is '��������Ա����';
comment on column F_B_FIRMBALANCEERROR.thirdlogno
  is '��������ˮ��';
comment on column F_B_FIRMBALANCEERROR.ccycode
  is '����';
comment on column F_B_FIRMBALANCEERROR.freezeamount
  is '�����ܶ����ʽ�';
comment on column F_B_FIRMBALANCEERROR.unfreezeamount
  is '�����ܽⶳ�ʽ�';
comment on column F_B_FIRMBALANCEERROR.addtranamount
  is '����ɽ����ܻ���(����)';
comment on column F_B_FIRMBALANCEERROR.cuttranamount
  is '����ɽ����ܻ���(��)';
comment on column F_B_FIRMBALANCEERROR.profitamount
  is 'ӯ���ܽ��';
comment on column F_B_FIRMBALANCEERROR.lossamount
  is '�����ܽ��';
comment on column F_B_FIRMBALANCEERROR.tranhandfee
  is '�����̵���Ӧ������������������';
comment on column F_B_FIRMBALANCEERROR.trancount
  is '���콻���ܱ���';
comment on column F_B_FIRMBALANCEERROR.newbalance
  is '�����������µĽ����̿��ý��';
comment on column F_B_FIRMBALANCEERROR.newfreezeamount
  is '�����������µĶ����ʽ�';
comment on column F_B_FIRMBALANCEERROR.note
  is '˵��';
comment on column F_B_FIRMBALANCEERROR.reserve
  is '������';
comment on column F_B_FIRMBALANCEERROR.rspcode
  is '������';
comment on column F_B_FIRMBALANCEERROR.rspmsg
  is 'Ӧ������';
comment on column F_B_FIRMBALANCEERROR.bankid
  is '���д���';
comment on column F_B_FIRMBALANCEERROR.createtime
  is '��Ϣ����ʱ��';
alter table F_B_FIRMBALANCEERROR
  add constraint PK_F_B_FIRMBALANCEERROR primary key (TRANDATETIME, CUSTACCTID);

prompt
prompt Creating table F_B_FIRMIDANDACCOUNT
prompt ===================================
prompt
create table F_B_FIRMIDANDACCOUNT
(
  bankid       VARCHAR2(32) not null,
  firmid       VARCHAR2(32) not null,
  account      VARCHAR2(32) not null,
  account1     VARCHAR2(32),
  status       NUMBER(1) default 0 not null,
  accountname  VARCHAR2(100),
  bankname     VARCHAR2(128),
  bankprovince VARCHAR2(128),
  bankcity     VARCHAR2(128),
  mobile       VARCHAR2(32),
  email        VARCHAR2(128),
  isopen       NUMBER(1) default 1 not null,
  cardtype     VARCHAR2(2) default 1 not null,
  card         VARCHAR2(32),
  frozenfuns   NUMBER(15,2) default 0.00 not null,
  accountname1 VARCHAR2(100),
  opentime     DATE,
  deltime      DATE,
  inmarketcode VARCHAR2(120)
)
;
comment on table F_B_FIRMIDANDACCOUNT
  is '�����������˺Ŷ�Ӧ��';
comment on column F_B_FIRMIDANDACCOUNT.bankid
  is '���б��';
comment on column F_B_FIRMIDANDACCOUNT.firmid
  is '�����̴���';
comment on column F_B_FIRMIDANDACCOUNT.account
  is '�����ʺ�';
comment on column F_B_FIRMIDANDACCOUNT.account1
  is '�����ڲ��˺�';
comment on column F_B_FIRMIDANDACCOUNT.status
  is '״̬(0 ����,1 ����)';
comment on column F_B_FIRMIDANDACCOUNT.accountname
  is '�˻���';
comment on column F_B_FIRMIDANDACCOUNT.bankname
  is '��������';
comment on column F_B_FIRMIDANDACCOUNT.bankprovince
  is '����ʡ��';
comment on column F_B_FIRMIDANDACCOUNT.bankcity
  is '����������';
comment on column F_B_FIRMIDANDACCOUNT.mobile
  is '�绰����';
comment on column F_B_FIRMIDANDACCOUNT.email
  is '����';
comment on column F_B_FIRMIDANDACCOUNT.isopen
  is '�Ƿ���ǩԼ(0 δǩԼ,1 ��ǩԼ)';
comment on column F_B_FIRMIDANDACCOUNT.cardtype
  is '--�ʻ�����(1 ���֤,2����֤,3���ڻ���,4���ڱ�,5ѧԱ֤,6����֤,7��ʱ���֤,8��֯��������,9Ӫҵִ��,A����֤,B��ž�ʿ��֤,C����֤,D�������,E�۰�̨�������֤,F̨��ͨ��֤��������Ч����֤,G����ͻ����,H��ž���ְ�ɲ�֤,I�侯��ְ�ɲ�֤,J�侯ʿ��֤,X������Ч֤��,Z�غ����֤)(��Ҫ�õ��� 1��8,���� 9 �� ������û���õ�)';
comment on column F_B_FIRMIDANDACCOUNT.card
  is '֤������';
comment on column F_B_FIRMIDANDACCOUNT.frozenfuns
  is '�����ʽ�';
comment on column F_B_FIRMIDANDACCOUNT.accountname1
  is '�����ڲ��˻�����';
comment on column F_B_FIRMIDANDACCOUNT.opentime
  is '����ʱ��';
comment on column F_B_FIRMIDANDACCOUNT.inmarketcode
  is '����������Э���';
alter table F_B_FIRMIDANDACCOUNT
  add constraint PK_F_B_FIRMIDANDACCOUNT primary key (BANKID, FIRMID);

prompt
prompt Creating table F_B_FIRMKXH
prompt ==========================
prompt
create table F_B_FIRMKXH
(
  funid        VARCHAR2(32) not null,
  status       NUMBER(2) not null,
  account1     VARCHAR2(32) not null,
  type         NUMBER(1) not null,
  account1name VARCHAR2(120) not null,
  firmid       VARCHAR2(32) not null,
  tradedate    DATE not null,
  counterid    VARCHAR2(12),
  bankid       VARCHAR2(32),
  createdate   DATE default sysdate    --��¼��������
)
;
comment on table F_B_FIRMKXH
  is '�����Ա��������Ϣ��';
comment on column F_B_FIRMKXH.funid
  is '����ǰ����ˮ��';
comment on column F_B_FIRMKXH.status
  is '����״̬(1������ 2������ 3����ȷ��)';
comment on column F_B_FIRMKXH.account1
  is '��Ա���˺�';
comment on column F_B_FIRMKXH.type
  is '���˻�����';
comment on column F_B_FIRMKXH.account1name
  is '���˻�����';
comment on column F_B_FIRMKXH.firmid
  is '�����̴���';
comment on column F_B_FIRMKXH.tradedate
  is '��������';
comment on column F_B_FIRMKXH.counterid
  is '������Ա��';
comment on column F_B_FIRMKXH.bankid
  is '���д���';
comment on column F_B_FIRMKXH.createdate
  is '��¼��������';
alter table F_B_FIRMKXH
  add constraint PK_F_B_FIRMKXH primary key (FUNID, TRADEDATE);

prompt
prompt Creating table F_B_FIRMTRADESTATUS
prompt ==================================
prompt
create table F_B_FIRMTRADESTATUS
(
  bankid      VARCHAR2(20) not null,
  dealid      VARCHAR2(20) not null,
  cobrn       VARCHAR2(20),
  txdate      VARCHAR2(20) not null,
  bankacc     VARCHAR2(32) not null,
  fundacc     VARCHAR2(32) not null,
  custname    VARCHAR2(100) not null,
  curcode     VARCHAR2(10) not null,
  status      VARCHAR2(10) not null,
  comparedate DATE not null
)
;
comment on table F_B_FIRMTRADESTATUS
  is '�ͻ�Э��״̬�����������˱�';
comment on column F_B_FIRMTRADESTATUS.bankid
  is '����id';
comment on column F_B_FIRMTRADESTATUS.dealid
  is '�г���֯��������';
comment on column F_B_FIRMTRADESTATUS.cobrn
  is '������������';
comment on column F_B_FIRMTRADESTATUS.txdate
  is '��������';
comment on column F_B_FIRMTRADESTATUS.bankacc
  is '�����˺�';
comment on column F_B_FIRMTRADESTATUS.fundacc
  is '�����̴���';
comment on column F_B_FIRMTRADESTATUS.custname
  is '����������';
comment on column F_B_FIRMTRADESTATUS.curcode
  is '����';
comment on column F_B_FIRMTRADESTATUS.status
  is '״̬';
comment on column F_B_FIRMTRADESTATUS.comparedate
  is '��������';
alter table F_B_FIRMTRADESTATUS
  add constraint F_B_FIRMTRADESTATUS primary key (BANKID, BANKACC, COMPAREDATE);

prompt
prompt Creating table F_B_FIRMUSER
prompt ===========================
prompt
create table F_B_FIRMUSER
(
  firmid              VARCHAR2(32) not null,
  name                VARCHAR2(64),
  maxpersgltransmoney NUMBER(12,2),
  maxpertransmoney    NUMBER(12,2),
  maxpertranscount    NUMBER(7),
  status              NUMBER(1) not null,
  registerdate        DATE not null,
  logoutdate          DATE,
  maxauditmoney       NUMBER(12,2),
  password            VARCHAR2(64)
)
;
comment on table F_B_FIRMUSER
  is '���нӿڲ����û���';
comment on column F_B_FIRMUSER.firmid
  is '�����̴���';
comment on column F_B_FIRMUSER.name
  is '����������';
comment on column F_B_FIRMUSER.maxpersgltransmoney
  is '�������ת�˽��';
comment on column F_B_FIRMUSER.maxpertransmoney
  is 'ÿ�����ת�˽��';
comment on column F_B_FIRMUSER.maxpertranscount
  is 'ÿ�����ת�˴���';
comment on column F_B_FIRMUSER.status
  is '������״̬(0 ��ע��,1 ���û�δע��,2ע��)';
comment on column F_B_FIRMUSER.registerdate
  is 'ע������';
comment on column F_B_FIRMUSER.logoutdate
  is 'ע������';
comment on column F_B_FIRMUSER.maxauditmoney
  is '��˶��';
comment on column F_B_FIRMUSER.password
  is '����';
alter table F_B_FIRMUSER
  add constraint PK_F_B_FIRMUSER primary key (FIRMID);

prompt
prompt Creating table F_B_HXQS
prompt =======================
prompt
create table F_B_HXQS
(
  bankid     VARCHAR2(32) not null,
  firmid     VARCHAR2(32) not null,
  tradedate  DATE not null,
  money      NUMBER(15,2) not null,
  type       NUMBER(2) not null,
  tradetype  NUMBER(2) not null,
  note       VARCHAR2(120),
  createdate DATE default sysdate not null,
  status     NUMBER(2)
)
;
comment on table F_B_HXQS
  is '��ӻ��������';
comment on column F_B_HXQS.bankid
  is '���б��';
comment on column F_B_HXQS.firmid
  is '�����̱��';
comment on column F_B_HXQS.tradedate
  is '��������';
comment on column F_B_HXQS.money
  is '���';
comment on column F_B_HXQS.type
  is '�����ʾ (1:�裬�ʽ���� 2:�����ʽ�����)';
comment on column F_B_HXQS.tradetype
  is '�ʽ�����';
comment on column F_B_HXQS.note
  is '��ע��Ϣ';
comment on column F_B_HXQS.createdate
  is '����д��ʱ��';
comment on column F_B_HXQS.status
  is '��ǰ״̬(0:�ɹ� 1:ʧ�� 2:���δ֪)';
alter table F_B_HXQS
  add constraint PK_F_B_HXQS primary key (BANKID, FIRMID, TRADEDATE);

prompt
prompt Creating table F_B_INTERFACELOG
prompt ===============================
prompt
create table F_B_INTERFACELOG
(
  logid      NUMBER(12) not null,
  bankid     VARCHAR2(32) not null,
  launcher   NUMBER(2) not null,
  type       NUMBER(2) not null,
  contact    VARCHAR2(32),
  account    VARCHAR2(32),
  beginmsg   VARCHAR2(512),
  endmsg     VARCHAR2(512),
  result     NUMBER(2) default 0 not null,
  createtime DATE default sysdate not null
)
;
comment on column F_B_INTERFACELOG.bankid
  is '���д���
���д���';
comment on column F_B_INTERFACELOG.launcher
  is '����
0 �г�
1 ����';
comment on column F_B_INTERFACELOG.type
  is '��������
1 ǩ��
2 ǩ��
3 ǩԼ
4 ��Լ
5 ��ѯ���
6 ����
7 ���
8 ����';
alter table F_B_INTERFACELOG
  add constraint PK_F_B_INTERFACELOG primary key (LOGID);
alter table F_B_INTERFACELOG
  add constraint REFF_B_BANKS235 foreign key (BANKID)
  references F_B_BANKS (BANKID)
  disable
  novalidate;

prompt
prompt Creating table F_B_LOG
prompt ======================
prompt
create table F_B_LOG
(
  logid      NUMBER not null,
  logopr     VARCHAR2(50) not null,
  logcontent VARCHAR2(4000) not null,
  logdate    DATE not null,
  logip      VARCHAR2(20)
)
;
comment on table F_B_LOG
  is '���нӿڲ��ֲ�����ָ��';
comment on column F_B_LOG.logid
  is '��־���';
comment on column F_B_LOG.logopr
  is '����Ա';
comment on column F_B_LOG.logcontent
  is '��������';
comment on column F_B_LOG.logdate
  is '��־��¼����';
comment on column F_B_LOG.logip
  is '��־��¼��¼����';
alter table F_B_LOG
  add constraint PK_F_B_LOG primary key (LOGID);

prompt
prompt Creating table F_B_MAKETMONEY
prompt =============================
prompt
create table F_B_MAKETMONEY
(
  id         NUMBER(15) not null,
  bankid     VARCHAR2(32) not null,
  banknumber VARCHAR2(50),
  type       NUMBER(2) not null,
  adddelt    NUMBER(2) not null,
  money      NUMBER(15,2) not null,
  note       VARCHAR2(120),
  createtime DATE default sysdate   --����ʱ��
)
;
comment on table F_B_MAKETMONEY
  is '����г������ʽ���Ϣ��';
comment on column F_B_MAKETMONEY.id
  is '�����ʽ���';
comment on column F_B_MAKETMONEY.bankid
  is '���б��';
comment on column F_B_MAKETMONEY.banknumber
  is ' ����ת�˺�';
comment on column F_B_MAKETMONEY.type
  is '�ʽ����� (1:������,2:��Ϣ)';
comment on column F_B_MAKETMONEY.adddelt
  is '���ӡ������ʽ�(1:���� 2:����)';
comment on column F_B_MAKETMONEY.money
  is '���ӡ����ٽ����';
comment on column F_B_MAKETMONEY.note
  is '��ע��Ϣ';
comment on column F_B_MAKETMONEY.createtime
  is '����ʱ��';
alter table F_B_MAKETMONEY
  add constraint PK_F_B_MAKETMONEY primary key (ID);

prompt
prompt Creating table F_B_MARGINS
prompt ==========================
prompt
create table F_B_MARGINS
(
  serial_id     VARCHAR2(15) not null,
  bargain_code  VARCHAR2(10) not null,
  trade_type    VARCHAR2(1),
  trade_money   NUMBER(15,2),
  member_code   VARCHAR2(32),
  member_name   VARCHAR2(120),
  trade_date    DATE,
  good_code     VARCHAR2(10),
  good_name     VARCHAR2(120),
  good_quantity NUMBER(15),
  flag          VARCHAR2(1),
  bankid        VARCHAR2(32) not null,
  createdate    DATE,
  note          VARCHAR2(120)
)
;
comment on table F_B_MARGINS
  is '�������ʽ𶳽�ⶳ��';
comment on column F_B_MARGINS.serial_id
  is 'ҵ����ˮ��';
comment on column F_B_MARGINS.bargain_code
  is '�ɽ���ͬ��';
comment on column F_B_MARGINS.trade_type
  is '�������� (1 ���᣻2 �ⶳ)';
comment on column F_B_MARGINS.trade_money
  is '���׽��';
comment on column F_B_MARGINS.member_code
  is '���׻�Ա��';
comment on column F_B_MARGINS.member_name
  is '���׻�Ա����';
comment on column F_B_MARGINS.trade_date
  is '��������';
comment on column F_B_MARGINS.good_code
  is '��Ʒ���';
comment on column F_B_MARGINS.good_name
  is '��Ʒ����';
comment on column F_B_MARGINS.good_quantity
  is '��Ʒ����';
comment on column F_B_MARGINS.flag
  is '����״̬ (N δ���ͣ�F ���д���ʧ�ܣ�Y ���д���ɹ�)';
comment on column F_B_MARGINS.bankid
  is '���б��';
comment on column F_B_MARGINS.createdate
  is '����ʱ��';
comment on column F_B_MARGINS.note
  is '�ʽ𶳽�ⶳ��ע�ֶ�';
alter table F_B_MARGINS
  add constraint PK_F_B_MARGINS primary key (SERIAL_ID, BARGAIN_CODE, BANKID);

prompt
prompt Creating table F_B_PLATFORMMSG
prompt ==============================
prompt
create table F_B_PLATFORMMSG
(
  firmid     VARCHAR2(15) not null,
  platfirmid VARCHAR2(15) not null
)
;
alter table F_B_PLATFORMMSG
  add constraint F_B_PLATFORMMSG_PRIMARY primary key (FIRMID);

prompt
prompt Creating table F_B_PROPERBALANCE
prompt ================================
prompt
create table F_B_PROPERBALANCE
(
  bankid     VARCHAR2(20) not null,
  allmoney   NUMBER not null,
  gongmoney  NUMBER not null,
  othermoney NUMBER not null,
  bdate      TIMESTAMP(6) not null
)
;
comment on table F_B_PROPERBALANCE
  is '�ܷ�ƽ���';
comment on column F_B_PROPERBALANCE.bankid
  is '���б��';
comment on column F_B_PROPERBALANCE.allmoney
  is '���ʽ�';
comment on column F_B_PROPERBALANCE.gongmoney
  is '�������ʽ�';
comment on column F_B_PROPERBALANCE.othermoney
  is '�������ʽ�';
comment on column F_B_PROPERBALANCE.bdate
  is '����ʱ��';

prompt
prompt Creating table F_B_QSRESULT
prompt ===========================
prompt
create table F_B_QSRESULT
(
  resultid   NUMBER(12) not null,
  bankid     VARCHAR2(32) not null,
  bankname   VARCHAR2(120),
  firmid     VARCHAR2(32),
  firmname   VARCHAR2(120),
  account    VARCHAR2(20),
  account1   VARCHAR2(20),
  kymoneym   NUMBER(18,2),
  kymoneyb   NUMBER(18,2),
  djmoneym   NUMBER(18,2),
  djmoneyb   NUMBER(18,2),
  zckymoney  NUMBER(18,2),
  zcdjmoney  NUMBER(18,2),
  moneym     NUMBER(18,2),
  moneyb     NUMBER(18,2),
  zcmoney    NUMBER(18,2),
  createdate DATE default sysdate,
  tradedate  DATE not null,
  status     NUMBER(2) not null,
  note       VARCHAR2(120)
)
;
comment on table F_B_QSRESULT
  is '���˲�ƽ��¼��Ϣ';
comment on column F_B_QSRESULT.resultid
  is '��ˮ���';
comment on column F_B_QSRESULT.bankid
  is '���б��';
comment on column F_B_QSRESULT.bankname
  is '��������';
comment on column F_B_QSRESULT.firmid
  is '�����̴���';
comment on column F_B_QSRESULT.firmname
  is '����������';
comment on column F_B_QSRESULT.account
  is '�����˺�';
comment on column F_B_QSRESULT.account1
  is '���˺�';
comment on column F_B_QSRESULT.kymoneym
  is '�г��������';
comment on column F_B_QSRESULT.kymoneyb
  is '���п������';
comment on column F_B_QSRESULT.djmoneym
  is '�г������ʽ�';
comment on column F_B_QSRESULT.djmoneyb
  is '���ж����ʽ�';
comment on column F_B_QSRESULT.zckymoney
  is '�����ʽ�����';
comment on column F_B_QSRESULT.zcdjmoney
  is '�����ʽ�����';
comment on column F_B_QSRESULT.moneym
  is '�г�Ȩ��';
comment on column F_B_QSRESULT.moneyb
  is '����Ȩ��';
comment on column F_B_QSRESULT.zcmoney
  is 'Ȩ������';
comment on column F_B_QSRESULT.createdate
  is '��¼����ʱ��';
comment on column F_B_QSRESULT.tradedate
  is '��������';
comment on column F_B_QSRESULT.status
  is '����״̬(0:�ɹ���1:ʧ�ܡ�2:�������ȡ�3:�������ȡ�4:�����ȡ�6:�˺��ʽ��쳣)';
comment on column F_B_QSRESULT.note
  is '��ע��Ϣ';
alter table F_B_QSRESULT
  add constraint PK_F_B_QSRESULT primary key (RESULTID);

prompt
prompt Creating table F_B_QUANYI
prompt =========================
prompt
create table F_B_QUANYI
(
  id                 NUMBER(12) not null,
  firmid             VARCHAR2(32) not null,
  venduebalance      NUMBER(12,2) not null,
  zcjsbalance        NUMBER(12,2) not null,
  timebargainbalance NUMBER(12,2) not null,
  avilablebalance    NUMBER(12,2) not null,
  bankbalance        NUMBER(12,2) not null,
  payment            NUMBER(12,2) not null,
  income             NUMBER(12,2) not null,
  fee                NUMBER(12,2) not null,
  jie                NUMBER(12,2) not null,
  dai                NUMBER(12,2) not null,
  dealtime           DATE not null
)
;
comment on table F_B_QUANYI
  is '����Ȩ���';
comment on column F_B_QUANYI.id
  is '��ID';
comment on column F_B_QUANYI.firmid
  is '�����̴���';
comment on column F_B_QUANYI.venduebalance
  is '���۲���ռ�ñ�֤��';
comment on column F_B_QUANYI.zcjsbalance
  is '���Ʋ���ռ�ñ�֤��';
comment on column F_B_QUANYI.timebargainbalance
  is '��Զ�ڲ���Ȩ��';
comment on column F_B_QUANYI.avilablebalance
  is '�������';
comment on column F_B_QUANYI.bankbalance
  is '�������';
comment on column F_B_QUANYI.payment
  is '�ջ���';
comment on column F_B_QUANYI.income
  is '������';
comment on column F_B_QUANYI.fee
  is '������';
comment on column F_B_QUANYI.jie
  is '�Ӵ����';
comment on column F_B_QUANYI.dai
  is '������';
comment on column F_B_QUANYI.dealtime
  is '��¼����';
alter table F_B_QUANYI
  add primary key (ID);

prompt
prompt Creating table F_B_RGSTCAPITALVALUE
prompt ===================================
prompt
create table F_B_RGSTCAPITALVALUE
(
  id          NUMBER(12) not null,
  actionid    NUMBER(12) not null,
  firmid      VARCHAR2(32) not null,
  account     VARCHAR2(32) not null,
  bankid      VARCHAR2(32) not null,
  type        NUMBER(2) not null,
  createtime  DATE not null,
  banktime    DATE,
  status      NUMBER(2) not null,
  accountname VARCHAR2(32) not null,
  cardtype    VARCHAR2(2) default 1 not null,
  card        VARCHAR2(32),
  note        VARCHAR2(128)
)
;
comment on column F_B_RGSTCAPITALVALUE.id
  is '��¼��ˮ��';
comment on column F_B_RGSTCAPITALVALUE.actionid
  is '�г���ˮ��';
comment on column F_B_RGSTCAPITALVALUE.firmid
  is '�����̴���';
comment on column F_B_RGSTCAPITALVALUE.account
  is 'ǩԼЭ���';
comment on column F_B_RGSTCAPITALVALUE.bankid
  is '���д���';
comment on column F_B_RGSTCAPITALVALUE.type
  is '��ˮ���� 1ǩԼ  2��Լ';
comment on column F_B_RGSTCAPITALVALUE.createtime
  is '����ʱ��';
comment on column F_B_RGSTCAPITALVALUE.banktime
  is '���ʱ��';
comment on column F_B_RGSTCAPITALVALUE.status
  is '��ˮ״̬ 0�ɹ� 1ʧ�� 2������';
comment on column F_B_RGSTCAPITALVALUE.accountname
  is '����';
comment on column F_B_RGSTCAPITALVALUE.cardtype
  is '֤������';
comment on column F_B_RGSTCAPITALVALUE.card
  is '֤����';
comment on column F_B_RGSTCAPITALVALUE.note
  is '��ע';
alter table F_B_RGSTCAPITALVALUE
  add constraint PK_F_B_RGSTCAPITALVALUE primary key (FIRMID, BANKID, TYPE, CREATETIME);

prompt
prompt Creating table F_B_TRADEDATA
prompt ============================
prompt
create table F_B_TRADEDATA
(
  firmid           VARCHAR2(32) not null,
  account1         VARCHAR2(32),
  money            NUMBER(12,2) default 1 not null,
  type             NUMBER(2) not null,
  status           NUMBER(2) not null,
  transferdate     DATE not null,
  accountname1     VARCHAR2(100),
  actionid         VARCHAR2(32) not null,
  funid            VARCHAR2(32),
  compareresult    NUMBER(1) default 2 not null,
  banktime         VARCHAR2(32),
  realtransferdate VARCHAR2(32),
  sendperson       VARCHAR2(32)
)
;
comment on table F_B_TRADEDATA
  is '�������ݱ�';
comment on column F_B_TRADEDATA.firmid
  is '������id';
comment on column F_B_TRADEDATA.account1
  is '�����˺� [��Ӧ�����������ʺŶ�Ӧ����ڲ��ʺ�]';
comment on column F_B_TRADEDATA.money
  is '�䶯���';
comment on column F_B_TRADEDATA.type
  is '����(0��Ȩ����  1��Ȩ���  2���ջ���  3��������   4�������� 5�� �ʽ���� 6�� �ʽ����)';
comment on column F_B_TRADEDATA.status
  is '���ͽ��(1��δ����   0�����ͳɹ�)';
comment on column F_B_TRADEDATA.transferdate
  is 'Ӧ����ʱ��';
comment on column F_B_TRADEDATA.accountname1
  is '�����˺�����';
comment on column F_B_TRADEDATA.actionid
  is '�г���ˮ��';
comment on column F_B_TRADEDATA.funid
  is '������ˮ��';
comment on column F_B_TRADEDATA.compareresult
  is '����ת��';
comment on column F_B_TRADEDATA.banktime
  is '����ʱ��';
comment on column F_B_TRADEDATA.realtransferdate
  is 'ʵ�ʷ���ʱ��';
comment on column F_B_TRADEDATA.sendperson
  is '������';
alter table F_B_TRADEDATA
  add primary key (ACTIONID);

prompt
prompt Creating table F_B_TRADEDETAILACC
prompt =================================
prompt
create table F_B_TRADEDETAILACC
(
  batchno     VARCHAR2(20) not null,
  bankid      VARCHAR2(20) not null,
  dealid      VARCHAR2(20) not null,
  cobrn       VARCHAR2(20),
  txdate      VARCHAR2(20),
  txtime      VARCHAR2(20),
  bkserial    VARCHAR2(32) not null,
  coserial    VARCHAR2(32) not null,
  bankacc     VARCHAR2(32) not null,
  fundacc     VARCHAR2(32) not null,
  custname    VARCHAR2(100) not null,
  txopt       VARCHAR2(20) not null,
  txcode      VARCHAR2(20) not null,
  curcode     VARCHAR2(20) not null,
  comparedate DATE not null
)
;
comment on table F_B_TRADEDETAILACC
  is '�˻��ཻ�׶�����ϸ��';
comment on column F_B_TRADEDETAILACC.batchno
  is '�������';
comment on column F_B_TRADEDETAILACC.bankid
  is '����id';
comment on column F_B_TRADEDETAILACC.dealid
  is '�г���֯��������';
comment on column F_B_TRADEDETAILACC.cobrn
  is '��������������';
comment on column F_B_TRADEDETAILACC.txdate
  is '��������';
comment on column F_B_TRADEDETAILACC.txtime
  is '����ʱ��';
comment on column F_B_TRADEDETAILACC.bkserial
  is '������ˮ';
comment on column F_B_TRADEDETAILACC.coserial
  is '�г���ˮ';
comment on column F_B_TRADEDETAILACC.bankacc
  is '�����˺�';
comment on column F_B_TRADEDETAILACC.fundacc
  is '�����̴���';
comment on column F_B_TRADEDETAILACC.custname
  is '����������';
comment on column F_B_TRADEDETAILACC.txopt
  is '���׷���';
comment on column F_B_TRADEDETAILACC.txcode
  is '��������';
comment on column F_B_TRADEDETAILACC.curcode
  is '����';
comment on column F_B_TRADEDETAILACC.comparedate
  is '��������';
alter table F_B_TRADEDETAILACC
  add constraint F_B_TRADEDETAILACC primary key (BANKID, BKSERIAL, COMPAREDATE);

prompt
prompt Creating table F_B_TRADELIST
prompt ============================
prompt
create table F_B_TRADELIST
(
  trade_money   NUMBER(15,2),
  trade_type    VARCHAR2(2),
  b_member_code VARCHAR2(6),
  b_member_name VARCHAR2(120),
  s_member_code VARCHAR2(6),
  s_member_name VARCHAR2(120),
  trade_date    DATE,
  bargain_code  VARCHAR2(20) not null,
  serial_id     VARCHAR2(15) not null,
  good_code     VARCHAR2(10),
  good_name     VARCHAR2(100),
  good_quantity NUMBER(15),
  flag          VARCHAR2(1),
  bankid        VARCHAR2(32) not null,
  createdate    DATE,
  note          VARCHAR2(120)
)
;
comment on table F_B_TRADELIST
  is '������Ȩ������';
comment on column F_B_TRADELIST.trade_money
  is '������';
comment on column F_B_TRADELIST.trade_type
  is '��������(1 ���ӯ���������ѣ�2 ���������ѣ�3 ���������ѣ�4 ������5 ����������)';
comment on column F_B_TRADELIST.b_member_code
  is '�򷽻�Ա��';
comment on column F_B_TRADELIST.b_member_name
  is '�򷽻�Ա����';
comment on column F_B_TRADELIST.s_member_code
  is '������Ա��';
comment on column F_B_TRADELIST.s_member_name
  is '�򷽻�Ա����';
comment on column F_B_TRADELIST.trade_date
  is '��������';
comment on column F_B_TRADELIST.bargain_code
  is '�ɽ���ͬ��';
comment on column F_B_TRADELIST.serial_id
  is '������ˮ��';
comment on column F_B_TRADELIST.good_code
  is '������';
comment on column F_B_TRADELIST.good_name
  is '��������';
comment on column F_B_TRADELIST.good_quantity
  is '��������';
comment on column F_B_TRADELIST.flag
  is '����״̬ (N δ���ͣ�F ���д���ʧ�ܣ�Y ���д���ɹ�)';
comment on column F_B_TRADELIST.bankid
  is '���б��';
comment on column F_B_TRADELIST.createdate
  is '����ʱ��';
comment on column F_B_TRADELIST.note
  is '������Ȩ������ע�ֶ�';
alter table F_B_TRADELIST
  add constraint PK_F_B_TRADELIST primary key (BARGAIN_CODE, SERIAL_ID, BANKID);

prompt
prompt Creating table F_B_TRANSMONEYOBJ
prompt ================================
prompt
create table F_B_TRANSMONEYOBJ
(
  id        NUMBER(5) not null,
  classname VARCHAR2(32) not null,
  note      VARCHAR2(256) not null
)
;
comment on table F_B_TRANSMONEYOBJ
  is '�ʽ�ת�����';
comment on column F_B_TRANSMONEYOBJ.id
  is '���';
comment on column F_B_TRANSMONEYOBJ.classname
  is 'ҵ��ʵ����';
comment on column F_B_TRANSMONEYOBJ.note
  is '��ע';

prompt
prompt Creating table F_B_ZFPH
prompt =======================
prompt
create table F_B_ZFPH
(
  bankid             VARCHAR2(32) not null,
  tradedate          DATE default sysdate not null,
  currency           VARCHAR2(10) default '001' not null,
  type               NUMBER(2) default 0 not null,
  lastaccountbalance NUMBER(15,2) default 0 not null,
  accountbalance     NUMBER(15,2) default 0 not null,
  result             NUMBER(2) default 0 not null,
  createdate         DATE default sysdate not null
)
;
comment on table F_B_ZFPH
  is '�ܷ�ƽ���';
comment on column F_B_ZFPH.bankid
  is '���б��';
comment on column F_B_ZFPH.tradedate
  is '��������';
comment on column F_B_ZFPH.currency
  is '�ұ� (001������� 013���۱� 014����Ԫ)';
comment on column F_B_ZFPH.type
  is ' �����ʶ��0���� 1���㣩';
comment on column F_B_ZFPH.lastaccountbalance
  is '�ʽ�����ϸ�˻�������';
comment on column F_B_ZFPH.accountbalance
  is '�ʽ�����˺Ž��';
comment on column F_B_ZFPH.result
  is '�ֶܷ��˽��(0��ƽ 1����ƽ)';
comment on column F_B_ZFPH.createdate
  is '����ʱ��';
alter table F_B_ZFPH
  add constraint PK_F_B_ZFPH primary key (BANKID, TRADEDATE);

prompt
prompt Creating table F_CLEARSTATUS
prompt ============================
prompt
create table F_CLEARSTATUS
(
  actionid   NUMBER(3) not null,
  actionnote VARCHAR2(32) not null,
  status     CHAR(1) not null,
  finishtime DATE
)
;
comment on column F_CLEARSTATUS.status
  is 'Y:���
N:δִ��';
alter table F_CLEARSTATUS
  add constraint PK_F_CLEARSTATUS primary key (ACTIONID);

prompt
prompt Creating table F_CLIENTLEDGER
prompt =============================
prompt
create table F_CLIENTLEDGER
(
  b_date DATE not null,
  firmid VARCHAR2(32) not null,
  code   VARCHAR2(16) not null,
  value  NUMBER(15,2) not null
)
;
alter table F_CLIENTLEDGER
  add constraint PK_F_CLIENTLEDGER primary key (B_DATE, FIRMID, CODE);

prompt
prompt Creating table F_DAILYBALANCE
prompt =============================
prompt
create table F_DAILYBALANCE
(
  b_date         DATE not null,
  accountcode    VARCHAR2(38) not null,
  lastdaybalance NUMBER(15,2),
  debitamount    NUMBER(15,2),
  creditamount   NUMBER(15,2),
  todaybalance   NUMBER(15,2)
)
;
alter table F_DAILYBALANCE
  add constraint PK_F_DAILYBALANCE primary key (B_DATE, ACCOUNTCODE);

prompt
prompt Creating table F_FIRMBALANCE
prompt ============================
prompt
create table F_FIRMBALANCE
(
  b_date           DATE not null,
  firmid           VARCHAR2(32) not null,
  lastbalance      NUMBER(15,2) default 0 not null,
  todaybalance     NUMBER(15,2) default 0 not null,
  lastwarranty     NUMBER(15,2) not null,
  todaywarranty    NUMBER(15,2) not null,
  lastsettlemargin NUMBER(15,2) default 0 not null,
  settlemargin     NUMBER(15,2) default 0 not null
)
;
alter table F_FIRMBALANCE
  add constraint PK_F_H_FIRMBALANCE primary key (B_DATE, FIRMID);

prompt
prompt Creating table F_FIRMCLEARFUNDS
prompt ===============================
prompt
create table F_FIRMCLEARFUNDS
(
  b_date            DATE not null,
  firmid            VARCHAR2(32) not null,
  balance           NUMBER(15,2) default 0 not null,
  rightsfrozenfunds NUMBER(15,2) default 0 not null,
  rights            NUMBER(15,2) default 0 not null,
  firmfee           NUMBER(15,2) default 0 not null,
  marketfee         NUMBER(15,2) default 0 not null
)
;
alter table F_FIRMCLEARFUNDS
  add constraint PK_F_FIRMCLEARFUNDS primary key (B_DATE, FIRMID);

prompt
prompt Creating table F_FIRMFUNDS
prompt ==========================
prompt
create table F_FIRMFUNDS
(
  firmid           VARCHAR2(32) not null,
  balance          NUMBER(15,2) default 0 not null,
  frozenfunds      NUMBER(15,2) default 0 not null,
  lastbalance      NUMBER(15,2) default 0 not null,
  lastwarranty     NUMBER(15,2) default 0 not null,
  settlemargin     NUMBER(15,2) default 0 not null,
  lastsettlemargin NUMBER(15,2) default 0 not null
)
;
alter table F_FIRMFUNDS
  add constraint PK_F_FIRMFUNDS primary key (FIRMID);

prompt
prompt Creating table F_FIRMRIGHTSCOMPUTEFUNDS
prompt =======================================
prompt
create table F_FIRMRIGHTSCOMPUTEFUNDS
(
  b_date      DATE not null,
  firmid      VARCHAR2(32) not null,
  code        VARCHAR2(16) not null,
  lastbalance NUMBER(15,2) default 0 not null,
  balance     NUMBER(15,2) default 0 not null
)
;
alter table F_FIRMRIGHTSCOMPUTEFUNDS
  add constraint PK_F_FIRMRIGHTSCOMPUTEFUNDS primary key (B_DATE, FIRMID, CODE);

prompt
prompt Creating table F_FROZENFUNDFLOW
prompt ===============================
prompt
create table F_FROZENFUNDFLOW
(
  fundflowid NUMBER(10) not null,
  firmid     VARCHAR2(32) not null,
  amount     NUMBER(15,2) default 0 not null,
  moduleid   CHAR(2) not null,
  createtime DATE not null
)
;
comment on column F_FROZENFUNDFLOW.moduleid
  is '10�ۺϹ���ƽ̨
11����ϵͳ
13�ֵ�����ϵͳ
14����ϵͳ
15��������
18Ͷ���������Ʒ����ϵͳ
20�����̽���ϵͳ
21����ϵͳ
22���н��뼰����ϵͳ
23E�ֻ�';
comment on column F_FROZENFUNDFLOW.createtime
  is '����ʱ��';
alter table F_FROZENFUNDFLOW
  add constraint PK_FROZENFUNDFLOW primary key (FUNDFLOWID);

prompt
prompt Creating table F_FROZENFUNDS
prompt ============================
prompt
create table F_FROZENFUNDS
(
  moduleid    CHAR(2) not null,
  firmid      VARCHAR2(32) not null,
  frozenfunds NUMBER(15,2) not null
)
;
comment on column F_FROZENFUNDS.moduleid
  is '10�ۺϹ���ƽ̨
11����ϵͳ
13�ֵ�����ϵͳ
14����ϵͳ
15��������
18Ͷ���������Ʒ����ϵͳ
20�����̽���ϵͳ
21����ϵͳ
22���н��뼰����ϵͳ
23E�ֻ�';
alter table F_FROZENFUNDS
  add constraint PK_F_FROZENFUNDS primary key (MODULEID, FIRMID);

prompt
prompt Creating table F_FUNDFLOW
prompt =========================
prompt
create table F_FUNDFLOW
(
  fundflowid   NUMBER(10) not null,
  firmid       VARCHAR2(32) not null,
  oprcode      CHAR(5) not null,
  contractno   VARCHAR2(16),
  commodityid  VARCHAR2(16),
  amount       NUMBER(15,2) default 0 not null,
  balance      NUMBER(15,2) default 0 not null,
  appendamount NUMBER(15,2),
  voucherno    NUMBER(10),
  createtime   DATE not null,
  b_date       DATE
)
;
comment on column F_FUNDFLOW.createtime
  is '����ʱ��';
alter table F_FUNDFLOW
  add constraint PK_F_FUNDFLOW primary key (FUNDFLOWID);

prompt
prompt Creating table F_H_FROZENFUNDFLOW
prompt =================================
prompt
create table F_H_FROZENFUNDFLOW
(
  fundflowid NUMBER(10) not null,
  firmid     VARCHAR2(32) not null,
  amount     NUMBER(15,2) default 0 not null,
  moduleid   CHAR(2) not null,
  createtime DATE not null
)
;
comment on column F_H_FROZENFUNDFLOW.moduleid
  is '10�ۺϹ���ƽ̨
11����ϵͳ
13�ֵ�����ϵͳ
14����ϵͳ
15��������
18Ͷ���������Ʒ����ϵͳ
20�����̽���ϵͳ
21����ϵͳ
22���н��뼰����ϵͳ
23E�ֻ�';
comment on column F_H_FROZENFUNDFLOW.createtime
  is '����ʱ��';
alter table F_H_FROZENFUNDFLOW
  add constraint PK_H_FROZENFUNDFLOW primary key (FUNDFLOWID);

prompt
prompt Creating table F_H_FUNDFLOW
prompt ===========================
prompt
create table F_H_FUNDFLOW
(
  fundflowid   NUMBER(10) not null,
  firmid       VARCHAR2(32) not null,
  oprcode      CHAR(5) not null,
  contractno   VARCHAR2(16),
  commodityid  VARCHAR2(16),
  amount       NUMBER(15,2) default 0 not null,
  balance      NUMBER(15,2) default 0 not null,
  appendamount NUMBER(15,2),
  voucherno    NUMBER(10) not null,
  createtime   DATE not null,
  b_date       DATE not null
)
;
comment on column F_H_FUNDFLOW.balance
  is '��ǰ�ʻ��ʽ��������Ǹ�����';
comment on column F_H_FUNDFLOW.createtime
  is '����ʱ��';
alter table F_H_FUNDFLOW
  add constraint PK_F_H_FUNDFLOW primary key (FUNDFLOWID);

prompt
prompt Creating table F_LEDGERFIELD
prompt ============================
prompt
create table F_LEDGERFIELD
(
  code      VARCHAR2(16) not null,
  name      VARCHAR2(32) not null,
  fieldsign NUMBER(1) not null,
  moduleid  CHAR(2) not null,
  ordernum  NUMBER(5) not null,
  isinit    CHAR(1) default 'Y' not null
)
;
comment on column F_LEDGERFIELD.fieldsign
  is '1������ -1������';
comment on column F_LEDGERFIELD.moduleid
  is '10�ۺϹ���ƽ̨
11����ϵͳ
13�ֵ�����ϵͳ
14����ϵͳ
15��������
18Ͷ���������Ʒ����ϵͳ
20�����̽���ϵͳ
21����ϵͳ
22���н��뼰����ϵͳ
23E�ֻ�';
comment on column F_LEDGERFIELD.ordernum
  is 'ǰ��λģ��ź���λ�����
';
comment on column F_LEDGERFIELD.isinit
  is 'Y:�ǳ�ʼ������,ҳ�治����ɾ�����޸�
N:���ǳ�ʼ������';
alter table F_LEDGERFIELD
  add constraint PK_F_LEDGERFIELD primary key (CODE);

prompt
prompt Creating table F_LOG
prompt ====================
prompt
create table F_LOG
(
  occurtime   DATE not null,
  type        VARCHAR2(8) not null,
  userid      VARCHAR2(16) not null,
  description VARCHAR2(128) not null
)
;
comment on table F_LOG
  is '������־��';
comment on column F_LOG.type
  is 'info����Ϣ
alert������
error������
sysinfo��ϵͳ��Ϣ';

prompt
prompt Creating table F_SUMMARY
prompt ========================
prompt
create table F_SUMMARY
(
  summaryno      CHAR(5) not null,
  summary        VARCHAR2(32) not null,
  ledgeritem     VARCHAR2(16),
  funddcflag     CHAR(1) default 'N' not null,
  accountcodeopp VARCHAR2(16),
  appendaccount  CHAR(1) default 'N' not null,
  isinit         CHAR(1) default 'Y' not null
)
;
comment on column F_SUMMARY.funddcflag
  is '��ƾ֤����漰�������ʽ������ʽ�Ǵ��� C�������ʽ�ǽ跽 D��
���漰�������ʽ�N';
comment on column F_SUMMARY.accountcodeopp
  is '���ڵ���ƾ֤';
comment on column F_SUMMARY.appendaccount
  is '�����ʽ����䶯�⣬���и��ӵĲ����˻��䶯��
T����ֵ˰ Tax
W�������� Warranty
S�����ձ�֤�� SettleMargin
N���޸���';
comment on column F_SUMMARY.isinit
  is 'Y:�ǳ�ʼ������,ҳ�治����ɾ�����޸�
N:���ǳ�ʼ������';
alter table F_SUMMARY
  add constraint PK_F_SUMMARY primary key (SUMMARYNO);

prompt
prompt Creating table F_SYSTEMSTATUS
prompt =============================
prompt
create table F_SYSTEMSTATUS
(
  b_date    DATE not null,
  status    NUMBER(2) not null,
  note      VARCHAR2(256),
  cleartime DATE,
  isclear   NUMBER(2) default 0 not null
)
;
comment on column F_SYSTEMSTATUS.status
  is '0:δ����״̬
1:������
2:�������';
alter table F_SYSTEMSTATUS
  add constraint PK_F_SYSTEMSTATUS primary key (B_DATE);

prompt
prompt Creating table F_VOUCHER
prompt ========================
prompt
create table F_VOUCHER
(
  voucherno  NUMBER(10) not null,
  b_date     DATE,
  summaryno  CHAR(5) not null,
  summary    VARCHAR2(32),
  note       VARCHAR2(128),
  inputuser  VARCHAR2(16) not null,
  inputtime  TIMESTAMP(6),
  auditor    VARCHAR2(16),
  audittime  TIMESTAMP(6),
  auditnote  VARCHAR2(128),
  status     VARCHAR2(16),
  contractno VARCHAR2(16),
  fundflowid NUMBER(10)
)
;
comment on column F_VOUCHER.status
  is 'editing   �༭״̬
auditing  �����
audited   �����
accounted �Ѽ���';
create index IX_F_VOUCHER_CONTRACTNO on F_VOUCHER (CONTRACTNO);
create index IX_F_VOUCHER_STATUS on F_VOUCHER (STATUS);
create unique index UK_F_VOUCHER on F_VOUCHER (FUNDFLOWID);
alter table F_VOUCHER
  add constraint PK_F_VOUCHER primary key (VOUCHERNO);

prompt
prompt Creating table F_VOUCHERENTRY
prompt =============================
prompt
create table F_VOUCHERENTRY
(
  entryid      NUMBER(10) not null,
  entrysummary VARCHAR2(32),
  voucherno    NUMBER(10) not null,
  accountcode  VARCHAR2(38) not null,
  debitamount  NUMBER(15,2) not null,
  creditamount NUMBER(15,2) not null
)
;
create index IX_F_VOUCHERENTRY on F_VOUCHERENTRY (VOUCHERNO);
alter table F_VOUCHERENTRY
  add constraint PK_F_VOUCHERENTRY primary key (ENTRYID);

prompt
prompt Creating table F_VOUCHERMODEL
prompt =============================
prompt
create table F_VOUCHERMODEL
(
  code           VARCHAR2(16) not null,
  name           VARCHAR2(64),
  summaryno      CHAR(5) not null,
  debitcode      VARCHAR2(38) not null,
  creditcode     VARCHAR2(38) not null,
  needcontractno CHAR(1) not null,
  note           VARCHAR2(128)
)
;
comment on table F_VOUCHERMODEL
  is '���ڿ�ݴ����ֹ�ƾ֤��ģ��';
alter table F_VOUCHERMODEL
  add constraint PK_F_VOUCHERMODEL primary key (CODE);

prompt
prompt Creating sequence SEQ_F_B_ACTION
prompt ================================
prompt
create sequence SEQ_F_B_ACTION
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence SEQ_F_B_BANKCOMPAREINFO
prompt =========================================
prompt
create sequence SEQ_F_B_BANKCOMPAREINFO
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence SEQ_F_B_CAPITALINFO
prompt =====================================
prompt
create sequence SEQ_F_B_CAPITALINFO
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence SEQ_F_B_DICTIONARY
prompt ====================================
prompt
create sequence SEQ_F_B_DICTIONARY
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence SEQ_F_B_FEEINFO
prompt =================================
prompt
create sequence SEQ_F_B_FEEINFO
minvalue 1
maxvalue 999999999999999999999999999
start with 2
increment by 1
nocache;

prompt
prompt Creating sequence SEQ_F_B_INTERFACELOG
prompt ======================================
prompt
create sequence SEQ_F_B_INTERFACELOG
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence SEQ_F_B_LOG
prompt =============================
prompt
create sequence SEQ_F_B_LOG
minvalue 1
maxvalue 999999999999999999999999999
start with 18
increment by 1
nocache;

prompt
prompt Creating sequence SEQ_F_B_MAKETMONEY
prompt ====================================
prompt
create sequence SEQ_F_B_MAKETMONEY
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence SEQ_F_B_MARGINS
prompt =================================
prompt
create sequence SEQ_F_B_MARGINS
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence SEQ_F_B_QSRESULT
prompt ==================================
prompt
create sequence SEQ_F_B_QSRESULT
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence SEQ_F_B_RGSTCAPITALVALUE
prompt ==========================================
prompt
create sequence SEQ_F_B_RGSTCAPITALVALUE
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence SEQ_F_B_TRADEDATA
prompt ===================================
prompt
create sequence SEQ_F_B_TRADEDATA
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence SEQ_F_B_TRADELIST
prompt ===================================
prompt
create sequence SEQ_F_B_TRADELIST
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence SEQ_F_B_TRANSMONEYOBJ
prompt =======================================
prompt
create sequence SEQ_F_B_TRANSMONEYOBJ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence SEQ_F_FROZENFUNDFLOW
prompt ======================================
prompt
create sequence SEQ_F_FROZENFUNDFLOW
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence SEQ_F_FUNDFLOW
prompt ================================
prompt
create sequence SEQ_F_FUNDFLOW
minvalue 1
maxvalue 9999999999999999999999999999
start with 50488
increment by 1
nocache;

prompt
prompt Creating sequence SEQ_F_VOUCHER
prompt ===============================
prompt
create sequence SEQ_F_VOUCHER
minvalue 1
maxvalue 9999999999999999999999999999
start with 63373
increment by 1
nocache;

prompt
prompt Creating sequence SEQ_F_VOUCHERENTRY
prompt ====================================
prompt
create sequence SEQ_F_VOUCHERENTRY
minvalue 1
maxvalue 9999999999999999999999999999
start with 126745
increment by 1
nocache;

prompt
prompt Creating view V_F_FIRMCURFUNDS
prompt ==============================
prompt
create or replace force view v_f_firmcurfunds as
select firmId,          --�����̴���
       name,            --����������
       f_balance,       --����ϵͳ��ǰ���
       l_balance,       --����������
       y_balance,       --����δ������
       balanceSubtract, --���
       lastwarranty,    --������
       frozenFunds,     --��ʱ�ʽ�
       user_balance     --�����ʽ�
  from (select z.*,
               f_balance - l_balance - y_balance balanceSubtract,
               f_balance + FrozenFunds user_balance
          from (select f.firmid,
                       (select name from m_firm where firmId = f.firmId) name,
                       f.balance f_balance,
                       nvl(h.todaybalance, 0) l_balance,
                       nvl(e.y_balance, 0) y_balance,
                       nvl(f.lastwarranty, 0) lastwarranty,
                       nvl(-1 * FrozenFunds, 0) FrozenFunds
                  from F_FirmFunds f,
                       (select h1.firmid, h1.todaybalance
                          from f_firmbalance h1
                         where h1.b_date =
                               (select nvl(max(b_date),
                                           to_date('2009-01-01', 'yyyy-MM-dd'))
                                  from f_firmbalance)) h,
                       (select d.firmid,
                               0 + nvl(b.c_balance, 0) - nvl(c.d_balance, 0) y_balance
                          from F_FirmFunds d,
                               (select a.firmid, sum(a.amount) c_balance
                                  from f_fundflow a
                                 where a.oprcode in
                                       (select t.summaryno
                                          from f_summary t
                                         where t.funddcflag = 'C')
                                 group by firmid) b,
                               (select a.firmid, sum(a.amount) d_balance
                                  from f_fundflow a
                                 where a.oprcode in
                                       (select t.summaryno
                                          from f_summary t
                                         where t.funddcflag = 'D')
                                 group by firmid) c
                         where d.firmid = b.firmid(+)
                           and d.firmid = c.firmid(+)) e
                 where f.firmid = h.firmid(+)
                   and f.firmid = e.firmid(+)) z)
;

prompt
prompt Creating function FN_F_UPDATEFUNDSFULL
prompt ======================================
prompt
create or replace function FN_F_UpdateFundsFull
(
  p_firmID varchar2,      --�����̴���
  p_oprcode char,         --ҵ�����
  p_amount number,        --������
  p_contractNo varchar2,  --�ɽ���ͬ��
  p_extraCode varchar2,   --��Զ����Ʒ���룬����Ϊ��Ŀ����
  p_appendAmount number,  --��Զ��(��ֵ˰,������)
  p_voucherNo number      --ƾ֤��(�ֹ�ƾ֤ʹ��)
) return number
/***
 * �����ʽ�
 * version 1.0.0.1 �˷�������
 *
 * ����ֵ���ʽ����
 ****/
is
  v_fundsign number(1); -- 1 ���� -1 ����
  v_balance number(15,2);
  v_amount number(15,2):= p_amount;
begin
  begin
    select decode(funddcflag,'C',1,'D',-1,0) into v_fundsign from f_summary where summaryno=p_oprcode;
    if(v_fundsign=0) then
      Raise_application_error(-21003, 'Fund DCflag not defined in F_Summary!'); --δ����ҵ����루ժҪ���ʽ�������
    end if;
  exception when NO_DATA_FOUND then
    Raise_application_error(-21002, 'Undefined operation code(summaryNo)!'); --�����ڵ�ҵ����루ժҪ��
  end;

  update f_firmfunds set balance=balance + v_fundsign*v_amount where firmid=p_firmid
  returning balance into v_balance;
  if(SQL%ROWCOUNT = 0) then
    Raise_application_error(-21001, 'FirmID not existed !'); --�����ڵĽ����̴���
  end if;

  --�����ʽ���ˮ
  insert into f_fundflow
    (fundflowid, firmid, oprcode, contractno, commodityid, amount, balance,appendamount, voucherno, createtime)
  values
    (seq_f_fundflow.nextval, p_firmid, p_oprcode, p_contractno, p_extraCode, v_amount, v_balance,p_appendAmount,p_voucherNo, sysdate);

  return v_balance;
end;
/

prompt
prompt Creating function FN_F_AUDITVOUCHERPASS
prompt =======================================
prompt
create or replace function FN_F_AuditVoucherPass(p_voucherNo number)
return number
/***
 * ���ƾ֤ͨ��
 *
 * version 1.0.0.3
 *
 * ���� 1 �ɹ� -1 δ�ҵ��ñʴ����ƾ֤
 ***/
as
  v_cnt number(10);

  v_contractno varchar2(16);
  v_summaryNo f_summary.summaryno%type;
  v_fundDCflag char(1);

  v_firmID varchar2(32);

  v_accountcode varchar2(38);
  v_debitamount number(15,2);
  v_creditamount number(15,2);

  v_amount number(15,2); --������
  v_balance number(15,2); --���

  v_negCount number;

  cursor c_entry is
    select accountcode, debitamount, creditamount from f_voucherentry where voucherno=p_voucherNo and accountcode like '200100%';

begin
  begin
    select contractno,summaryno into v_contractno,v_summaryNo from f_voucher where voucherNo=p_voucherNo and status='auditing' for update;
  exception when NO_DATA_FOUND then
    return -1;
  end;
  select count(*) into v_cnt from f_voucherentry where voucherno=p_voucherNo and accountcode like '200100%';
  if(v_cnt>0) then
    select fundDCflag into v_fundDCflag from f_summary where summaryno=v_summaryNo;
    if(v_fundDCflag<>'D' and v_fundDCflag<>'C') then  --�뽻�����ʽ��޹�ƾ֤
      Raise_application_error(-21003, 'Fund DCflag not defined in F_Summary!'); --δ����ҵ����루ժҪ���ʽ�������
    else  --�н������ʽ�䶯
      open c_entry;
      loop
        fetch c_entry into v_accountcode,v_debitamount,v_creditamount;
        exit when c_entry%NOTFOUND;
        v_firmid:=substr(v_accountcode,7);

        if(v_fundDCflag='C') then
          v_amount:=v_creditamount-v_debitamount;
        else
          v_amount:=v_debitamount-v_creditamount;
        end if;

        v_balance:=fn_f_updatefundsFull(v_firmid,v_summaryNo,v_amount,v_contractno,null,null,p_voucherNo);

        select count(*) into v_negCount
        from f_firmfunds a,
            (
              select substr(accountCode,7) firmid,sum(creditAmount)-sum(debitAmount) amount
              from f_voucherentry
              where voucherNo=p_voucherNo and accountCode like '2001%' group by accountCode
            ) b
        where  a.firmid = b.firmid and (a.balance - a.frozenfunds)<0 and b.amount<0;
        if(v_negCount>0) then
            rollback;
            return -2;            --��ɸ�ֵ
        end if;
      end loop;
    end if;
  end if;

  --����ƾ֤״̬Ϊ�����
  update f_voucher set status = 'audited',audittime=sysdate where voucherNo = p_voucherNo;

  return 1;
end;
/

prompt
prompt Creating function FN_F_CREATEVOUCHER
prompt ====================================
prompt
create or replace function FN_F_CreateVoucher(
  p_summaryNo varchar2,
  p_summary varchar2,
  p_debitCode varchar2,
  p_creditCode varchar2,
  p_amount number,
  p_contractno varchar2,
  p_inputUser varchar2
) return number  --ƾ֤��
/**
 * ����ƾ֤��ƾ֤Ϊ�༭״̬
 * version 1.0.0.3
 *
 **/
as
  v_level number;
  v_cnt number;
   v_voucherno number;
   v_summary varchar2(32);
begin
  --�жϿ�Ŀ�Ƿ�Ϸ�
  select accountlevel into v_level from f_account where code=p_debitCode;

  select count(*) into v_cnt from f_account where code like p_debitCode||'%' and accountlevel>v_level;
  if(v_cnt>0) then
   Raise_application_error(-21004, 'Fund accountcode not a leaf node!'||p_debitCode); --�Է���Ŀ��Ҷ�ӿ�Ŀ
  end if;

  select accountlevel into v_level from f_account where code=p_creditCode;

  select count(*) into v_cnt from f_account where code like p_creditCode||'%' and accountlevel>v_level;
  if(v_cnt>0) then
   Raise_application_error(-21004, 'Fund accountcode not a leaf node!'||p_creditCode); --�Է���Ŀ��Ҷ�ӿ�Ŀ
  end if;

  --���û��ָ��ժҪ���ݣ���ѯ������
  if(p_summary is null) then
    select summary into v_summary from F_Summary where summaryno=p_summaryNo;
  end if;
  select seq_f_voucher.nextval into v_voucherno from dual;

  --����ƾ֤
  insert into f_voucher
   (voucherno, summaryno, summary, inputuser, inputtime, status, contractno)
  values
   (v_voucherno, p_summaryNo, p_summary, p_inputUser, sysdate, 'editing', p_contractno);

  insert into f_voucherentry
   (entryid, voucherno, accountcode, debitamount, creditamount)
  values
   (seq_f_voucherentry.nextval, v_voucherno, p_debitCode, p_amount, 0);
  insert into f_voucherentry
   (entryid, voucherno, accountcode, debitamount, creditamount)
  values
   (seq_f_voucherentry.nextval, v_voucherno, p_creditCode, 0, p_amount);

  return v_voucherno;
end;
/

prompt
prompt Creating function FN_F_CREATEVOUCHERCOMP
prompt ========================================
prompt
create or replace function FN_F_CreateVoucherComp(
  p_summaryNo varchar2,
  p_summary varchar2,
  p_debitCode varchar2,
  p_creditCode varchar2,
  p_amount number,
  p_contractno varchar2,
  p_fundflowid number,
  p_createtime date,
  p_b_date date
) return number  --ƾ֤��
/**
 * ��������ƾ֤��ƾ֤Ϊ�����״̬
 * version 1.0.0.1
 *
 **/
as
  v_voucherno number;
  v_summary varchar2(32);
begin
  v_summary:=p_summary;
  if(v_summary is null) then
    select summary into v_summary from f_summary where summaryno=p_summaryNo;
  end if;
  v_voucherNo:=fn_f_createvoucher(p_summaryNo,v_summary,p_debitCode,p_creditCode,p_amount,p_contractno,'system');
  update F_Voucher
  set inputtime=p_createtime,auditor='system',audittime=p_createtime,status='audited',fundflowid=p_fundflowid,b_date=p_b_date
  where voucherno=v_voucherNo;

  return v_voucherno;
end;
/

prompt
prompt Creating function FN_F_EXTRACTVOUCHER
prompt =====================================
prompt
create or replace function FN_F_ExtractVoucher
return number
as
/***
 * ��ȡ����ƾ֤
 * version 1.0.0.1
 *
 * ��������ƾ֤��
 ****/
  v_voucherNo number(10);
  v_b_date date;

  v_fundflowid number(10);
  v_firmId varchar2(32);
  v_oprcode F_FundFlow.Oprcode%type;
  v_contractNo varchar2(16);
  v_commodityID varchar2(16);
  v_amount number(15,2);
  v_appendAmount number(15,2);
  v_createtime date;

  v_fundDCflag char(1);
  v_summary varchar2(32);
  v_accountcodeopp varchar2(38);
  v_appendAccount char(1);

  v_debitCode varchar2(38);
  v_creditCode varchar2(38);

  v_cnt number(10):=0;

  cursor c_FundFlow is
      select fundflowid, firmid, oprcode,contractNo,commodityID, amount, appendamount, createtime, b_date
      from f_fundflow
      where voucherno is null
      order by fundflowid;

begin
  delete from f_fundflow where amount=0 and appendamount=0;
  --ͨ�������ʽ���ˮ�ͳɽ���ͬ����ƾ֤
  open c_FundFlow;
  loop
     fetch c_FundFlow into v_fundflowid,v_firmId,v_oprcode,v_contractNo,v_commodityID,v_amount,v_appendAmount,v_createtime,v_b_date;
     exit when c_FundFlow%NOTFOUND;
     --����Ʒ��Ŀ��Ӧ
     select funddcflag, replace(accountcodeopp,'*',v_commodityID),summary,appendAccount
     into v_funddcflag, v_accountcodeopp,v_summary,v_appendAccount
     from f_summary
     where summaryno = v_oprcode;

   --���������ڳ��ű�֤�� 2012-5-10
   v_accountcodeopp := replace(v_accountcodeopp, '#', v_firmId);

     if(v_accountcodeopp = 'spec') then
       v_accountcodeopp := v_commodityID;
     end if;

     if(v_funddcflag='D') then
         v_debitCode:='200100'||v_firmId;
         v_creditCode:=v_accountcodeopp;
     elsif(v_funddcflag='C') then
         v_debitCode:=v_accountcodeopp;
         v_creditCode:='200100'||v_firmId;
     end if;

     if(v_contractNo is not null) then --��ͬ�Ÿ�����ϵͳ��
       v_contractno:=substr(v_oprcode,1,1)||'-'||v_contractNo;
     end if;

     v_voucherNo:=fn_f_createvoucherComp(v_oprcode,v_summary,v_debitCode,v_creditCode,v_amount,v_contractno,v_fundflowid,v_createtime,v_b_date);
     v_cnt:=v_cnt + 1;

     update F_FundFlow set voucherno=v_voucherNo where fundflowid=v_fundflowid;

     if(v_appendAmount is not null and v_appendAmount!=0 and v_appendAccount!='N') then --�и�����Ŀ
         v_fundflowid:=null;
         if(v_appendAccount='T') then
           if(v_funddcflag='D') then  --����һ�������Է�����ֵ˰
             v_oprcode:='15098';
             v_debitCode:='1005' || substr(v_oprcode,0,2) || v_commodityID;
             v_creditCode:=v_accountcodeopp;
           elsif(v_funddcflag='C') then --ӯ����һ���ָ���ֵ˰
             v_oprcode:='15099';
             v_debitCode:=v_accountcodeopp;
             v_creditCode:='1005' || substr(v_oprcode,0,2) || v_commodityID;
           end if;
           v_voucherNo:=fn_f_createvoucherComp(v_oprcode,null,v_debitCode,v_creditCode,v_appendAmount,v_contractno,v_fundflowid,v_createtime,v_b_date);
           v_cnt:=v_cnt + 1;
         elsif(v_appendAccount='W') then --������
           if(v_funddcflag='D') then --�ձ�֤�𣬼ӵ�����
             v_oprcode:='15097';  --�뵣����
             v_debitCode:='1006';
             v_creditCode:='200101'||v_firmId;
             v_voucherNo:=fn_f_createvoucherComp(v_oprcode,null,v_debitCode,v_creditCode,v_appendAmount,v_contractno,v_fundflowid,v_createtime,v_b_date);
             v_cnt:=v_cnt + 1;

             v_oprcode:='15095';  --�ս����̵�����
             v_debitCode:='200101'||v_firmId;
             v_creditCode:='2099'|| substr(v_oprcode,0,2) ||v_commodityID;
             v_voucherNo:=fn_f_createvoucherComp(v_oprcode,null,v_debitCode,v_creditCode,v_appendAmount,v_contractno,v_fundflowid,v_createtime,v_b_date);
             v_cnt:=v_cnt + 1;
           elsif(v_funddcflag='C') then --�˱�֤��
             v_oprcode:='15094';  --�˽����̵�����
             v_debitCode:='2099'|| substr(v_oprcode,0,2) ||v_commodityID;
             v_creditCode:='200101'||v_firmId;
             v_voucherNo:=fn_f_createvoucherComp(v_oprcode,null,v_debitCode,v_creditCode,v_appendAmount,v_contractno,v_fundflowid,v_createtime,v_b_date);
             v_cnt:=v_cnt + 1;

             v_oprcode:='15096';  --��������
             v_debitCode:='200101'||v_firmId;
             v_creditCode:='1006';
             v_voucherNo:=fn_f_createvoucherComp(v_oprcode,v_summary,v_debitCode,v_creditCode,v_appendAmount,v_contractno,v_fundflowid,v_createtime,v_b_date);
             v_cnt:=v_cnt + 1;
           end if;
         end if;
     end if;
  end loop;
  close c_FundFlow;

  return v_cnt;
end;
/

prompt
prompt Creating procedure SP_F_BALANCEACCOUNT
prompt ======================================
prompt
create or replace procedure SP_F_BalanceAccount(p_beginDate date) as
     v_lastDate date;
     v_curDate date;

     v_lvl number(2);
     v_cnt number(10);
begin
     --�����ʼ�����Ժ�Ľ���
     delete from F_DailyBalance where b_Date >= p_beginDate;
     delete from F_FirmBalance where b_Date >= p_beginDate;
     --ȡ����������
     select max(b_Date) into v_lastDate from F_DailyBalance;
     if(v_lastDate is null) then
          v_lastDate := to_date('2000-01-01','yyyy-MM-dd');
     end if;

     for curDate in (select distinct b_date from f_Accountbook where b_date > v_lastDate order by b_date)
     loop
         v_curDate:=curDate.b_Date;

         --�����п�Ŀ��ʼ�����ս����¼
         insert into F_DailyBalance(b_date,accountcode,lastdaybalance,debitamount,creditamount,todaybalance)
         select v_curDate,a.Code,nvl(b.todaybalance,0),0,0,nvl(b.todaybalance,0)
         from f_account a,(select * from F_DailyBalance where b_date = v_lastDate) b
         where a.Code = b.accountCode(+) and a.code not like '%\_' escape '\';

         --����Ҷ�ӽڵ㵱�ս����������
         for debit in (select debitCode,sum(amount) amount from f_accountBook where b_date = v_curDate group by debitCode)
         loop
             update F_DailyBalance set DebitAmount=debit.amount where b_date = v_curDate and accountCode = debit.debitcode;
         end loop;
         for credit in (select creditCode,sum(amount) amount from f_accountBook where b_date = v_curDate group by creditCode)
         loop
             update F_DailyBalance set creditAmount=credit.amount where b_date = v_curDate and accountCode = credit.creditCode;
         end loop;

         select max(accountlevel) into v_lvl from F_Account;
         --���µ��ս跽������������
         for account in (select code,accountlevel,dcFlag from f_account where accountlevel<v_lvl order by accountlevel desc)
         loop
             select count(1) into v_cnt from f_account
             where code like account.code||'%' and accountlevel=account.accountlevel+1;
             if(v_cnt>0) then
                 update F_DailyBalance a
                 set (DebitAmount,CreditAmount)=
                 (
                    select nvl(sum(DebitAmount),0),nvl(sum(CreditAmount),0)
                    from F_DailyBalance fd,f_account fa
                    where fd.b_date=v_curDate and fd.accountcode=fa.code and fd.accountcode like account.code||'%'
                      and fa.accountlevel=account.accountlevel+1
                 ) where accountcode=account.code and a.b_date=v_curDate;
             end if;
         end loop;

         --���µ��ս������
         update (select a.*,b.dcflag from F_DailyBalance a,F_Account b
                 where b_date = v_curDate and a.accountCode=b.code) c
         set TodayBalance=c.LastdayBalance+(case dcflag when 'D' then DebitAmount-CreditAmount else CreditAmount-DebitAmount end);


         --------------------------------���½����̽����������
         insert into F_FirmBalance
            (b_date, firmid, lastbalance, todaybalance, lastwarranty, todaywarranty)
         select b_date, substr(accountcode,7) firmid, lastdaybalance, todaybalance, 0, 0
         from f_dailybalance
         where b_Date=v_curDate
         and accountCode like '200100%' and substr(accountCode,7) is not null;

         --�������յ�����
         update F_FirmBalance f
         set lastwarranty=nvl((select todaywarranty from F_FirmBalance where b_date=v_lastDate and firmid=f.firmid),0)
         where b_Date=v_curDate;

         --���µ��յ�����
         update F_FirmBalance f set todaywarranty=lastwarranty where b_Date=v_curDate;
         for wfirm in (select distinct debitcode firmCode from f_accountbook
                       where b_Date=v_curDate and summaryno in ('15097','15096') and debitcode like '200101%'
                 union select distinct creditcode firmCode from f_accountbook
                       where b_Date=v_curDate and summaryno in ('15097','15096') and creditcode like '200101%')
         loop
             update F_FirmBalance f set todaywarranty=todaywarranty+
               nvl(
                 (
                   select sum(decode(summaryno,'15097',amount,-amount)) inAmount
                   from f_accountbook
                   where b_Date=v_curDate and (debitcode=wfirm.firmcode or creditcode=wfirm.firmcode) and summaryno in ('15097','15096')
                 )
               ,0)
             where b_Date=v_curDate and firmid=substr(wfirm.firmcode,7);
         end loop;

         --���½������ʽ��
         update F_Firmfunds f set (lastbalance,lastwarranty)=
           (select nvl(todaybalance,0),nvl(todaywarranty,0) from F_FirmBalance b where b_Date=v_curDate and b.firmid=f.firmid);
         --------------------------------end warranty
         --������������
         v_lastDate := v_curDate;
     end loop;

end;
/

prompt
prompt Creating procedure SP_F_CLEARACTION_DONE
prompt ========================================
prompt
create or replace procedure SP_F_ClearAction_Done
(
    p_ActionID   F_ClearStatus.ActionID%type
)
is
    PRAGMA AUTONOMOUS_TRANSACTION;
begin
    update F_ClearStatus
       set status = 'Y',
           FinishTime = sysdate
     where ActionID = p_ActionID;
    commit;
end;
/

prompt
prompt Creating procedure SP_F_CLIENTLEDGER
prompt ====================================
prompt
create or replace procedure SP_F_ClientLedger(p_beginDate date) as
begin
    --�����ʼ�����Ժ�Ľ���
    delete from F_ClientLedger where b_Date >= p_beginDate;

    insert into f_clientledger
      (b_date, firmid, code, value)
    select b_date,substr(accountcode,7),ledgeritem,d.fieldsign*amount from
    (
      select b_date,accountcode,ledgeritem,sum(amount) amount from
      (
        select b_date,debitcode accountcode,ledgeritem, -amount amount
        from f_accountbook a,f_summary b
        where a.summaryno=b.summaryno and a.b_date>=p_beginDate and a.debitcode like '200100%'
        union all
        select b_date,creditcode accountcode,ledgeritem, amount
        from f_accountbook a,f_summary b
        where a.summaryno=b.summaryno and a.b_date>=p_beginDate and a.creditcode like '200100%'
      ) group by b_date,accountcode,ledgeritem
    ) c,f_ledgerfield d
    where c.ledgeritem=d.code;

end;
/

prompt
prompt Creating procedure SP_F_COMPUTEFIRMRIGHTS
prompt =========================================
prompt
create or replace procedure SP_F_ComputeFirmRights(
  p_beginDate date
)
/****
 * ���㽻����Ȩ��
****/
as
	v_lastDate     date;           -- ��һ��������
  v_cnt          number(4);      --���ֱ���
  v_sumFirmFee   number(15, 2);  -- �����������Ѻϼ�
  v_sumFL        number(15, 2);  -- �����̶���ӯ���ϼ�
  v_sumBalance   number(15, 2);  -- ������Ȩ�������úϼ�
begin

   -- ������������Ȩ��������

        -- ɾ����������Ȩ�������ñ�ĵ�������
        delete from F_FirmRightsComputeFunds where b_date = p_beginDate;

        -- ȡ����������Ȩ�������ñ����һ��������
        select max(b_Date) into v_lastDate from F_FirmRightsComputeFunds;

        if(v_lastDate is null) then
          v_lastDate := to_date('2000-01-01','yyyy-MM-dd');
        end if;

       -- �������̵�ǰ�ʽ��Ľ����̺������������˷������ñ��з���������Ȩ�������õ����˴�������
       -- ������������Ȩ�������ñ���Ϊ���յĳ�ʼ����
       insert into F_FirmRightsComputeFunds(B_date, Firmid, Code)
         select p_beginDate,f.firmid, bc.ledgercode
         from f_firmfunds f,F_BankClearLedgerConfig bc
         where bc.feetype = 1;

        for firmRights in (select b_date, firmId, code from F_FirmRightsComputeFunds where b_date = p_beginDate)
        loop
            -- ������������Ȩ�������ñ���������
            update F_FirmRightsComputeFunds f
            set lastBalance = nvl((select balance
                 from F_FirmRightsComputeFunds where b_date = v_lastDate and firmId = firmRights.firmId and code = firmRights.code ), 0)
            where b_date = firmRights.b_date and firmId = firmRights.firmId and code = firmRights.code;

            -- ������������Ȩ�������ñ�ĵ������
            update F_FirmRightsComputeFunds f
            set balance = nvl((select bc.fieldsign*c.value as amount
                               from f_clientledger c, f_bankclearledgerconfig bc
                               where c.b_date = firmRights.b_date and c.firmId = firmRights.firmId and c.code = firmRights.code and c.code = bc.ledgercode ), 0)
            where b_date = firmRights.b_date and firmId = firmRights.firmId and code = firmRights.code;

            -- ������������Ȩ�������ñ�ĵ������Ϊ��������� + �������
            --�������Ϳ��Բ��õ�����ϵͳ��ȥȡ��Щ�ʽ��
            update F_FirmRightsComputeFunds f
            set balance = balance + lastBalance
            where b_date = firmRights.b_date and firmId = firmRights.firmId and code = firmRights.code;

        end loop;


   -- ���½����������ʽ�

     -- ɾ�������������ʽ��ĵ�������
     delete from F_FirmClearFunds where b_date = p_beginDate;

     -- �������̵�ǰ�ʽ��������뽻���������ʽ��
     insert into F_FirmClearFunds(B_date, Firmid, Balance)
     select p_beginDate, f.firmid, f.balance from f_firmfunds f;

     for firmClearFunds in (select b_date, firmId from F_FirmClearFunds where b_date = p_beginDate)
     loop
         -- ���㽻����������
         select nvl(sum(value), 0) sumFirmFee into v_sumFirmFee
         from F_ClientLedger c
         where b_date = firmClearFunds.b_date and firmId = firmClearFunds.firmId
         and c.code in (select LedgerCode from F_BankClearLedgerConfig where FeeType = 0);

           -- ���½����������ʽ��Ľ�����������
           update F_FirmClearFunds
           set firmFee = v_sumFirmFee
           where b_date = firmClearFunds.b_date and firmId = firmClearFunds.firmId;

         -- �����г�������

         -- ���㽻����Ȩ�涳���ʽ�

            -- ͳ����������Ȩ�������õĵ������
            select nvl(sum(Balance), 0) sumBalance into v_sumBalance from F_FirmRightsComputeFunds where b_date = firmClearFunds.b_date and firmId = firmClearFunds.firmId;

            -- �ж��Ƿ����ö���ϵͳ
            select count(*) into v_cnt from c_trademodule where moduleId = 15 and isbalancecheck = 'Y';
            if(v_cnt > 0) then

               -- ͳ�ƶ����ֲ�ӯ��
               select nvl(sum(FloatingLoss), 0) sumFL into v_sumFL from T_H_FirmHoldSum t where t.cleardate = firmClearFunds.b_date and t.firmid = firmClearFunds.firmId;

               update F_FirmClearFunds
               set RightsFrozenFunds = v_sumBalance + v_sumFL
               where b_date = firmClearFunds.b_date and firmId = firmClearFunds.firmId;

            else
               update F_FirmClearFunds
               set RightsFrozenFunds = v_sumBalance
               where b_date = firmClearFunds.b_date and firmId = firmClearFunds.firmId;

            end if;

         -- ���㽻����Ȩ��
         update F_FirmClearFunds
         set Rights = Balance + RightsFrozenFunds
         where b_date = firmClearFunds.b_date and firmId = firmClearFunds.firmId;

     end loop;

end;
/

prompt
prompt Creating procedure SP_F_PUTVOUCHERTOBOOK
prompt ========================================
prompt
create or replace procedure SP_F_PutVoucherToBook(p_beginDate date) as
begin
     --�����ʼ�����Ժ���ʲ�
     delete from f_accountbook where b_Date>=p_beginDate;
     --��ƾ֤�������˲�
     insert into f_accountbook
     (b_date,summaryno,summary,voucherno,debitcode,creditcode,amount,contractno)
      select a.b_date,a.summaryNo,a.summary,a.voucherno,a.accountcode,b.accountcode,
          case
            when (m.debitcount=n.creditcount) then a.debitamount
            when (m.debitcount<n.creditcount) then b.creditamount
            else a.debitamount
          end amount,a.contractno
      from (  select v.b_date,v.summaryNo,v.summary,v.voucherno,v.contractno,v.audittime,ve.accountcode,ve.debitamount
              from f_voucher v,f_voucherentry ve
              where v.b_date>=p_beginDate and v.voucherno=ve.voucherNo and ve.debitamount<>0
            ) a,
           (  select v.voucherno,ve.accountcode,ve.creditamount
              from f_voucher v,f_voucherentry ve
              where v.b_date>=p_beginDate and v.voucherno=ve.voucherNo and ve.creditamount<>0
            ) b,
           (  select ve.voucherno,count(1) debitcount
              from f_voucherentry ve,f_voucher v
              where ve.voucherno=v.voucherno
                and v.b_date>=p_beginDate and debitamount<>0
              group by ve.voucherno
            ) m,
           (  select ve.voucherno,count(1) creditcount
              from f_voucherentry ve,f_voucher v
              where ve.voucherno=v.voucherno
                and v.b_date>=p_beginDate and creditamount<>0
              group by ve.voucherno
            ) n
      where a.voucherno = b.voucherno and a.voucherno=m.voucherno and a.voucherno=n.voucherno;

     update f_voucher set status='accounted' where status='audited' and b_date>=p_beginDate;
end;
/

prompt
prompt Creating function FN_F_BALANCE
prompt ==============================
prompt
create or replace function FN_F_Balance
(
    p_beginDate date:=null --����һ�쿪ʼ����
) return number
/**
 ���ӷ���ֵ-101����������Ϊ��
**/
is
  v_lastDate date;
  v_beginDate date;
  v_b_date f_systemstatus.b_date%type;
  v_status f_systemstatus.status%type;
  v_cnt number(10);
  v_rtn number(10);
  v_errorcode      number;
    v_errormsg       varchar2(200);
begin
/*  if(p_beginDate is null) then
   p_beginDate := trunc(sysdate);
  end if;*/
   update F_systemstatus
           set status = 1,
               note = '������';
  commit; --�˴��ύ��Ϊ�˽�����״̬��Χ�ܿ�����

   --�Բ���ϵͳ״̬���������ֹ������㲢��
   select b_date,status into v_b_date,v_status from F_systemstatus for update;

  --���㿪ʼ
  SP_F_ClearAction_Done(p_actionid => 0);

  --��ȡ����ƾ֤
  v_rtn := FN_F_ExtractVoucher();
  SP_F_ClearAction_Done(p_actionid => 1);

  if p_beginDate is not null then
   v_beginDate:=trunc(p_beginDate);
  else
    v_beginDate:= trunc(sysdate);
  end if;
 /* --���������
  select nvl(max(b_date),to_date('2000-01-01','yyyy-MM-dd')) into v_lastDate from f_dailybalance;
  --������¼�����������յ�ƾ֤�������������ǰһ�졣
  select count(*) into v_cnt from f_voucher where b_date=v_lastDate and status='audited';
  if(v_cnt>0) then
    v_lastDate:=v_lastDate-1;
  end if;

  if(v_beginDate is null) then
    v_beginDate := v_lastDate + 1;
  else
    --�ж�ָ���������ں��������ռ��Ƿ���ƾ֤������д���������պ�һ�쿪ʼ
    select count(*) into v_cnt from f_voucher where b_date>v_lastDate and b_date<p_beginDate;
    if(v_cnt>0) then
      v_beginDate := v_lastDate + 1;
    end if;
  end if;*/

  --������ˮ��ƾ֤����
  update f_fundflow set b_date=v_beginDate;
  update f_voucher set b_date=v_beginDate where status='audited';
  SP_F_ClearAction_Done(p_actionid => 2);



  insert into f_log
    (occurtime, type, userid, description)
  values
    (sysdate, 'sysinfo', 'system', 'Balance specify date:'||nvl(to_char(p_beginDate,'yyyy-MM-dd'),'No')||' ->exec date:'||to_char(v_beginDate,'yyyy-MM-dd'));

  --��ƾ֤�������˲�
  SP_F_PutVoucherToBook(v_beginDate);
  SP_F_ClearAction_Done(p_actionid => 3);
  --�����˻�
  SP_F_BalanceAccount(v_beginDate);
  SP_F_ClearAction_Done(p_actionid => 4);
  --���ɿͻ�����
  SP_F_ClientLedger(v_beginDate);
  SP_F_ClearAction_Done(p_actionid => 5);


  --������ʷ��ˮ��
  insert into f_h_fundflow
  select * from f_fundflow where b_date is not null;
  --ɾ����ǰ��ˮ���¼
  delete from F_Fundflow where b_date is not null;

  --���붳���ʽ���ʷ��ˮ��
  insert into f_h_frozenfundflow
  select * from f_frozenfundflow;

  --ɾ����ǰ�Ķ����ʽ���ˮ��
  delete from f_frozenfundflow;
  SP_F_ClearAction_Done(p_actionid => 6);

  -- ���ɽ����������ʽ����� by 2014-04-21 zhaodc
  SP_F_ComputeFirmRights(v_beginDate);
  SP_F_ClearAction_Done(p_actionid => 7);

  update F_systemstatus
           set b_date = v_beginDate,
               status = 2,
               note = '�������',
               cleartime = sysdate;
 SP_F_ClearAction_Done(p_actionid => 8);
  return 1;
 exception
    when others then
        rollback;

        -- �ָ�״̬Ϊδ����
        update f_systemstatus
           set status = 0,
               note = 'δ����';
        commit;

        return -100;
end;
/

prompt
prompt Creating function FN_F_BALANCE_OLD
prompt ==================================
prompt
create or replace function FN_F_Balance_old
(
    p_beginDate date:=null --����һ�쿪ʼ����
) return number
/**
 ���ӷ���ֵ-101����������Ϊ��
**/
is
  v_lastDate date;
  v_beginDate date;
  v_b_date f_systemstatus.b_date%type;
  v_status f_systemstatus.status%type;
  v_cnt number(10);
  v_rtn number(10);
  v_errorcode      number;
    v_errormsg       varchar2(200);
begin
/*  if(p_beginDate is null) then
   p_beginDate := trunc(sysdate);
  end if;*/
   update F_systemstatus
           set status = 1,
               note = '������';
  commit; --�˴��ύ��Ϊ�˽�����״̬��Χ�ܿ�����

   --�Բ���ϵͳ״̬���������ֹ������㲢��
   select b_date,status into v_b_date,v_status from F_systemstatus for update;

  --���㿪ʼ
  SP_F_ClearAction_Done(p_actionid => 0);

  --��ȡ����ƾ֤
  v_rtn := FN_F_ExtractVoucher();
  SP_F_ClearAction_Done(p_actionid => 1);

  if p_beginDate is not null then
   v_beginDate:=trunc(p_beginDate);
  else
    v_beginDate:= trunc(sysdate);
  end if;
 /* --���������
  select nvl(max(b_date),to_date('2000-01-01','yyyy-MM-dd')) into v_lastDate from f_dailybalance;
  --������¼�����������յ�ƾ֤�������������ǰһ�졣
  select count(*) into v_cnt from f_voucher where b_date=v_lastDate and status='audited';
  if(v_cnt>0) then
    v_lastDate:=v_lastDate-1;
  end if;

  if(v_beginDate is null) then
    v_beginDate := v_lastDate + 1;
  else
    --�ж�ָ���������ں��������ռ��Ƿ���ƾ֤������д���������պ�һ�쿪ʼ
    select count(*) into v_cnt from f_voucher where b_date>v_lastDate and b_date<p_beginDate;
    if(v_cnt>0) then
      v_beginDate := v_lastDate + 1;
    end if;
  end if;*/

  --������ˮ��ƾ֤����
  update f_fundflow set b_date=v_beginDate;
  update f_voucher set b_date=v_beginDate where status='audited';
  SP_F_ClearAction_Done(p_actionid => 2);



  insert into f_log
    (occurtime, type, userid, description)
  values
    (sysdate, 'sysinfo', 'system', 'Balance specify date:'||nvl(to_char(p_beginDate,'yyyy-MM-dd'),'No')||' ->exec date:'||to_char(v_beginDate,'yyyy-MM-dd'));

  --��ƾ֤�������˲�
  SP_F_PutVoucherToBook(v_beginDate);
  SP_F_ClearAction_Done(p_actionid => 3);
  --�����˻�
  SP_F_BalanceAccount(v_beginDate);
  SP_F_ClearAction_Done(p_actionid => 4);
  --���ɿͻ�����
  SP_F_ClientLedger(v_beginDate);
  SP_F_ClearAction_Done(p_actionid => 5);


  --������ʷ��ˮ��
  insert into f_h_fundflow
  select * from f_fundflow where b_date is not null;
  --ɾ����ǰ��ˮ���¼
  delete from F_Fundflow where b_date is not null;

  --���붳���ʽ���ʷ��ˮ��
  insert into f_h_frozenfundflow
  select * from f_frozenfundflow;

  --ɾ����ǰ�Ķ����ʽ���ˮ��
  delete from f_frozenfundflow;
  SP_F_ClearAction_Done(p_actionid => 6);


  update F_systemstatus
           set b_date = v_beginDate,
               status = 2,
               note = '�������',
               cleartime = sysdate;
 SP_F_ClearAction_Done(p_actionid => 7);
  return 1;
 exception
    when others then
        rollback;

        -- �ָ�״̬Ϊδ����
        update f_systemstatus
           set status = 0,
               note = 'δ����';
        commit;

        return -100;
end;
/

prompt
prompt Creating function FN_F_B_FIRMADD
prompt ================================
prompt
create or replace function FN_F_B_firmADD
(
    p_FirmID m_firm.firmid%type --�����̴���
)
return integer is
  /**
  * ����ϵͳ��ӽ�����
  * ����ֵ�� 1 �ɹ�
  **/
  v_cnt                number(4); --���ֱ���
  v_name               m_firm.name%type;
begin
  select count(*) into v_cnt from F_B_FIRMUSER where firmid = p_FirmID;
  if (v_cnt <= 0) then
	select name into v_name from m_firm where firmid = p_FirmID;
    insert into F_B_FIRMUSER (firmID,name,maxPersgltransMoney,maxPertransMoney,maxPertranscount,status,registerDate,maxAuditMoney) values (p_FirmID,v_name,0,0,0,1,sysdate,0);
  end if;
  return 1;
end;
/

prompt
prompt Creating function FN_F_B_FIRMDEL
prompt ================================
prompt
create or replace function FN_F_B_FirmDEL
(
    p_FirmID   m_firm.firmid%type --�����̴���
)
return integer is
  /**
  * ɾ��������
  * ����ֵ�� 1 �ɹ�
  **/
  v_cnt                number(4); --���ֱ���
  v_firmstatus         F_B_FIRMUSER.status%type; --������״̬
  RET_TradeModuleError integer := -901;--��errorInfo���ʹ��
begin
  --��齻�����Ƿ����ǩԼ��Ϣ
  select count(*) into v_cnt from F_B_FIRMIDANDACCOUNT where isOpen=1 and firmid=p_FirmID;
  if (v_cnt > 0) then
    return -1;
  end if;

  --��齻�����Ƿ����
  select count(*) into v_cnt from F_B_FIRMUSER where firmid=p_FirmID;
  if (v_cnt = 0) then
    return 1;
  end if;

  --��齻����״̬
  select status into v_firmstatus from F_B_FIRMUSER where firmid=p_FirmID;
  if (v_firmstatus = 1) then
	return 1;
  end if;

  --ע��������
  update F_B_FIRMUSER set status=1 where firmid=p_FirmID;

  return 1;
end;
/

prompt
prompt Creating function FN_F_EXTRACTVOUCHERPRE
prompt ========================================
prompt
create or replace function FN_F_ExtractVoucherPre
return number
/***
 * Զ�ڽ���
 * ���أ�-1:Զ�ڽ��㲻�ɹ�
 *       -2������С�ڵ���Զ�ڵ�ǰ�����յ���ˮ��δ�������
 ***/
as
  v_lastDate date;
  v_beginDate date;
  v_b_date date;
  v_cnt number(10);
  v_rtn varchar2(10);
  v_enabled char(1);
begin
  return 1;
end;
/

prompt
prompt Creating function FN_F_FIRMADD
prompt ==============================
prompt
create or replace function FN_F_firmADD
(
    p_FirmID m_firm.firmid%type --�����̴���
)
return integer is
  /**
  * �ֻ�ϵͳ��ӽ�����
  * ����ֵ�� 1 �ɹ�
  **/
  v_cnt                number(4); --���ֱ���
  v_enabled char(1);
begin
  select count(*) into v_cnt from f_account where Code='200100'||p_FirmID;
  if(v_cnt=0)then
    insert into f_account(Code,Name,accountLevel,dCFlag)
    select '200100'||p_FirmID,name||p_FirmID,3,'C' from f_account
    where code='200100';
  end if;
  select count(*) into v_cnt from f_account where Code='200101'||p_FirmID;
  if(v_cnt=0)then
    insert into f_account(Code,Name,accountLevel,dCFlag)
    select '200101'||p_FirmID,name||p_FirmID,3,'C' from f_account
    where code='200101';
  end if;
  select count(*) into v_cnt from f_firmfunds where firmid=p_FirmID;
  if(v_cnt=0)then
    insert into f_firmfunds
      (firmid, balance, frozenfunds)
    values
      (p_FirmID, 0, 0);
  end if;

  return 1;
end;
/

prompt
prompt Creating function FN_F_FIRMDEL
prompt ==============================
prompt
create or replace function FN_F_FirmDel
(
    p_FirmID   m_firm.firmid%type--�����̴���
)
return integer is
  /**
  * ɾ��������
  * ����ֵ�� 1 �ɹ�
  *          -900 �ʽ�Ϊ0
  **/
 -- v_cnt                number(4); --���ֱ���
  v_balance      f_firmfunds.balance%type;
  RET_FundNotZero integer := -901;

begin

   select balance - frozenfunds into v_balance from f_firmfunds where firmid = p_FirmID;
   if(v_balance <>0) then
            return RET_FundNotZero;
   end if;

  /*---mengyu 2013.8.29 ע�������̱����ݲ���Ҳ��ɾ��--start-*/
  /*select count(*) into v_cnt from f_voucherentry f where f.accountcode='20100'||p_FirmID;
  if(v_cnt>0) then
    select count(*) into v_cnt from f_account f where code='200100'||p_FirmID||'_';
     if(v_cnt=0) then
        update f_account set code='200100'||p_FirmID||'_' where code='200100'||p_FirmID;
     else
        delete from f_account where Code='200100'||p_FirmID;
     end if;
  else
    delete from f_account where Code='200100'||p_FirmID;
  end if;
  */
   /*---mengyu 2013.8.29 ע�������̱����ݲ���Ҳ��ɾ��--end-*/
  /*select count(*) into v_cnt from f_voucherentry f where f.accountcode='200101'||p_FirmID;
  if(v_cnt>0) then
    select count(*) into v_cnt from f_account f where code='200101'||p_FirmID||'_';
     if(v_cnt=0) then
        update f_account set code='200101'||p_FirmID||'_' where code='200101'||p_FirmID;
     else
        delete from f_account where Code='200101'||p_FirmID;
     end if;
  else
  delete from f_account where Code='200101'||p_FirmID;
  end if;*/
 /*---mengyu 2013.8.29 ע�������̱����ݲ���Ҳ��ɾ��--start-*/
 -- delete from f_firmfunds where firmid=p_FirmID;

 -- update f_accountbook set debitcode=debitcode||'_' where debitcode in ('200100'||p_FirmID/*, '20101'||p_FirmID*/);
 -- update f_accountbook set creditcode=creditcode||'_' where creditcode in ('200100'||p_FirmID/*, '20101'||p_FirmID*/);
 -- update f_clientledger set firmid=firmid||'_' where firmid=p_FirmID;
 -- update f_dailybalance set accountcode=accountcode||'_' where accountcode in ('200100'||p_FirmID/*, '20101'||p_FirmID*/);
 -- update f_firmbalance set firmid=firmid||'_' where firmid=p_FirmID;
 -- update f_h_fundflow set firmid=firmid||'_' where firmid=p_FirmID;
 -- update f_voucherentry set accountcode=accountcode||'_' where accountcode in ('200100'||p_FirmID/*, '20101'||p_FirmID*/);
 /*---mengyu 2013.8.29 ע�������̱����ݲ���Ҳ��ɾ��--end-*/
  return 1;
end;
/

prompt
prompt Creating function FN_F_FIRMTOSTATUS
prompt ===================================
prompt
create or replace function FN_F_FirmToStatus
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
prompt Creating function FN_F_GETREALFUNDS
prompt ===================================
prompt
create or replace function FN_F_GetRealFunds
(
  p_firmid varchar2,   --�����̴���
  p_lock number      --�Ƿ����� 1:���� 0��������
) return number
/***
 * ��ȡ�����ʽ�
 * version 1.0.0.1 ���÷���
 * ����ֵ���������
 ****/
is
  v_realfunds number(15,2);
begin
  if(p_lock=1) then
    select balance-frozenfunds into v_realfunds from f_firmfunds where firmid=p_firmid for update;
  else
    select balance-frozenfunds into v_realfunds from f_firmfunds where firmid=p_firmid;
  end if;
  return v_realfunds;
end;
/

prompt
prompt Creating function FN_F_SETVOUCHERBDATE
prompt ======================================
prompt
create or replace function FN_F_SetVoucherBDate(
  p_endAuditTime date, --���ʱ���ֹʱ��
  p_b_date date --����������
)
return number
as
/***
 * ƾ֤���ֽ�����
 * version 1.0.0.1
 *
 *
 ****/

  v_cnt number(8):=0;
  v_endAuditTime date;
  v_b_date date;

begin
  v_endAuditTime:=p_endAuditTime;
  if(p_endAuditTime is null) then
    v_endAuditTime:= sysdate;
  end if;
  v_b_date:=p_b_date;
  if(p_b_date is null) then
    v_b_date:= trunc(sysdate);
  end if;

  update f_voucher set b_date=v_b_date where b_date is null and audittime<=v_endAuditTime and status='audited';

  v_cnt:=SQL%ROWCOUNT;

  update f_fundflow set b_date=v_b_date where b_date is null and createtime<=v_endAuditTime;

  return v_cnt;

end;
/

prompt
prompt Creating function FN_F_UPDATEFROZENFUNDS
prompt ========================================
prompt
create or replace function FN_F_UpdateFrozenFunds
(
  p_firmid varchar2,   --�����̴���
  p_amount number,     --�������ֵ���ӣ���ֵ���٣�
  p_moduleID char   --����ģ��ID 15��Զ�� 23���ֻ� 21������
)  return number
/***
 * ���¶����ʽ�
 * version 1.0.0.1 �˷�������
 *
 * ����ֵ�������ʽ����
 ****/
is
  v_frozenfunds number(15,2);
  v_moduleFrozenfunds number(15,2);
begin
  update f_firmfunds set frozenfunds=frozenfunds + p_amount where firmid=p_firmid
  returning frozenfunds into v_frozenfunds;
  if(SQL%ROWCOUNT = 0) then
    Raise_application_error(-21001, 'FirmID not existed !'); --�����ڵĽ����̴���
  end if;

  update f_frozenfunds set frozenfunds=frozenfunds + p_amount where moduleid=p_moduleID and firmid=p_firmid;
  if(SQL%ROWCOUNT = 0) then
    insert into f_frozenfunds
      (moduleid, firmid, frozenfunds)
    values
      (p_moduleID, p_FirmID, p_amount);
  end if;

  --���������нӿڽ������ʽ��Ϊ��ֵ
  if(p_moduleID = '28') then
    select frozenfunds into v_moduleFrozenfunds from f_frozenfunds where moduleid=p_moduleID and firmid=p_firmid;
    if(v_moduleFrozenfunds<0)then
      Raise_application_error(-21011, 'Module 28:frozen funds<0!');
    end if;
  end if;

  return v_frozenfunds;
end;
/

prompt
prompt Creating function FN_F_UPDATEFUNDS
prompt ==================================
prompt
create or replace function FN_F_UpdateFunds
(
  p_firmID varchar2,     --�����̴���
  p_oprcode char,         --ҵ�����
  p_amount number,       --������
  p_contractNo varchar2  --�ɽ���ͬ��
) return number
/***
 * �����ʽ�
 * version 1.0.0.1 �˷�������
 *
 * ����ֵ���ʽ����
 ****/
is
begin
  return fn_f_updatefundsFull(p_firmid,p_oprcode,p_amount,p_contractNo,null,null,null);
end;
/

prompt
prompt Creating procedure SP_F_COMPUTEFIRMRIGHTS_OLD
prompt =============================================
prompt
create or replace procedure SP_F_ComputeFirmRights_old(
  p_beginDate date
)
/****
 * ���㽻����Ȩ��
****/
as
  v_lastDate     date;           -- ��һ��������
  v_cnt          number(4);      --���ֱ���
  v_sumFirmFee   number(15, 2);  -- �����������Ѻϼ�
  v_sumFL        number(15, 2);  -- �����̶���ӯ���ϼ�
  v_sumBalance   number(15, 2);  -- ������Ȩ�������úϼ�
begin

   -- ������������Ȩ��������

        -- ɾ����������Ȩ�������ñ�ĵ�������
        delete from F_FirmRightsComputeFunds where b_date = p_beginDate;

        -- ȡ����������Ȩ�������ñ����һ��������
        select max(b_Date) into v_lastDate from F_FirmRightsComputeFunds;

        if(v_lastDate is null) then
          v_lastDate := to_date('2000-01-01','yyyy-MM-dd');
        end if;

       -- �������̵�ǰ�ʽ��Ľ����̺������������˷������ñ��з���������Ȩ�������õ����˴�������
       -- ������������Ȩ�������ñ���Ϊ���յĳ�ʼ����
       insert into F_FirmRightsComputeFunds(B_date, Firmid, Code)
         select p_beginDate,f.firmid, bc.ledgercode
         from f_firmfunds f,F_BankClearLedgerConfig bc
         where bc.feetype = 1;

        for firmRights in (select b_date, firmId, code from F_FirmRightsComputeFunds where b_date = p_beginDate)
        loop
            -- ������������Ȩ�������ñ���������
            update F_FirmRightsComputeFunds f
            set lastBalance = nvl((select balance
                 from F_FirmRightsComputeFunds where b_date = v_lastDate and firmId = firmRights.firmId and code = firmRights.code ), 0)
            where b_date = firmRights.b_date and firmId = firmRights.firmId and code = firmRights.code;

            -- ������������Ȩ�������ñ�ĵ������
            update F_FirmRightsComputeFunds f
            set balance = nvl((select bc.fieldsign*c.value as amount
                               from f_clientledger c, f_bankclearledgerconfig bc
                               where c.b_date = firmRights.b_date and c.firmId = firmRights.firmId and c.code = firmRights.code and c.code = bc.ledgercode ), 0)
            where b_date = firmRights.b_date and firmId = firmRights.firmId and code = firmRights.code;

            -- ������������Ȩ�������ñ�ĵ������Ϊ��������� + �������
            --�������Ϳ��Բ��õ�����ϵͳ��ȥȡ��Щ�ʽ��
            update F_FirmRightsComputeFunds f
            set balance = balance + lastBalance
            where b_date = firmRights.b_date and firmId = firmRights.firmId and code = firmRights.code;

        end loop;


   -- ���½����������ʽ�

     -- ɾ�������������ʽ��ĵ�������
     delete from F_FirmClearFunds where b_date = p_beginDate;

     -- �������̵�ǰ�ʽ��������뽻���������ʽ��
     insert into F_FirmClearFunds(B_date, Firmid, Balance)
     select p_beginDate, f.firmid, f.balance from f_firmfunds f;

     for firmClearFunds in (select b_date, firmId from F_FirmClearFunds where b_date = p_beginDate)
     loop
         -- ���㽻����������
         select nvl(sum(value), 0) sumFirmFee into v_sumFirmFee
         from F_ClientLedger c
         where b_date = firmClearFunds.b_date and firmId = firmClearFunds.firmId
         and c.code in (select LedgerCode from F_BankClearLedgerConfig where FeeType = 0);

           -- ���½����������ʽ��Ľ�����������
           update F_FirmClearFunds
           set firmFee = v_sumFirmFee
           where b_date = firmClearFunds.b_date and firmId = firmClearFunds.firmId;

         -- �����г�������

         -- ���㽻����Ȩ�涳���ʽ�

            -- ͳ����������Ȩ�������õĵ������
            select nvl(sum(Balance), 0) sumBalance into v_sumBalance from F_FirmRightsComputeFunds where b_date = firmClearFunds.b_date and firmId = firmClearFunds.firmId;

            -- �ж��Ƿ����ö���ϵͳ
            select count(*) into v_cnt from c_trademodule where moduleId = 15 and isbalancecheck = 'Y';
            if(v_cnt > 0) then

               -- ͳ�ƶ����ֲ�ӯ��
               select nvl(sum(FloatingLoss), 0) sumFL into v_sumFL from T_H_FirmHoldSum t where t.cleardate = firmClearFunds.b_date and t.firmid = firmClearFunds.firmId;

               update F_FirmClearFunds
               set RightsFrozenFunds = v_sumBalance + v_sumFL
               where b_date = firmClearFunds.b_date and firmId = firmClearFunds.firmId;

            else
               update F_FirmClearFunds
               set RightsFrozenFunds = v_sumBalance
               where b_date = firmClearFunds.b_date and firmId = firmClearFunds.firmId;

            end if;

         -- ���㽻����Ȩ��
         update F_FirmClearFunds
         set Rights = Balance + RightsFrozenFunds
         where b_date = firmClearFunds.b_date and firmId = firmClearFunds.firmId;

     end loop;

end;
/

prompt
prompt Creating procedure SP_F_EXTRACTVOUCHERREDO
prompt ==========================================
prompt
create or replace procedure SP_F_ExtractVoucherRedo(p_beginDate date)
as
  v_num number(10);
begin
  insert into f_fundflow
    (fundflowid, firmid, oprcode, contractno, commodityid, amount, balance, appendamount, voucherno, createtime, b_date)
  select fundflowid, firmid, oprcode, contractno, commodityid, amount, balance, appendamount, voucherno, createtime, b_date
  from f_h_fundflow where b_date>=p_beginDate;

  delete from f_h_fundflow where b_date>=p_beginDate;

  update (select f.* from f_fundflow f,f_voucher v where f.voucherno=v.voucherno and v.inputuser='system') a
  set a.voucherno=null;

  delete from f_voucher where inputuser='system' and b_date>=p_beginDate;

  v_num:=FN_F_ExtractVoucher();

  if(v_num>0) then
    v_num:= fn_f_balance(p_beginDate);
  end if;
end;
/

prompt
prompt Creating procedure SP_F_STATUSINIT
prompt ==================================
prompt
create or replace procedure SP_F_StatusInit
as
/*********************
 ���������״̬�洢
 �洢˵�������ǽ��г�ʼ����ϵͳ
 ���ȵ��ñ��洢���Բ���ϵͳ���г�ʼ��

**********************/
v_status F_systemstatus.Status%type;
begin
  --1.������ϵͳ����״̬
  begin
     select status into v_status  from F_systemstatus t where rownum < 2;
  exception
     when NO_DATA_FOUND then
       return;
  end;
  --2.���״̬��Ϊ�������״̬��������
  if(v_status <> 2) then
    return;
  end if;

  --3.���״̬Ϊ������ɣ����޸�״̬Ϊδ����
  update F_systemstatus set status = 0,note = 'δ����';
  update F_CLEARSTATUS set status = 'N',finishtime = null;
end;
/

prompt
prompt Creating procedure SP_F_SYNCHCOMMODITY
prompt ======================================
prompt
create or replace procedure SP_F_SynchCommodity(p_CommodityID varchar2) as
  v_cnt number;
begin
  select count(*) into v_cnt from f_account where code='200215'||p_CommodityID;
  if(v_cnt=0) then
    insert into f_account(Code,Name,accountLevel,dCFlag)
    select '200215'||p_CommodityID,name||p_CommodityID,3,'C' from f_account where code='200215';
  end if;

  select count(*) into v_cnt from f_account where code='209915'||p_CommodityID;
  if(v_cnt=0) then
    insert into f_account(Code,Name,accountLevel,dCFlag)
    select '209915'||p_CommodityID,name||p_CommodityID,3,'C' from f_account where code='209915';
  end if;

   select count(*) into v_cnt from f_account where code='100515'||p_CommodityID;
   if(v_cnt=0) then
    insert into f_account(Code,Name,accountLevel,dCFlag)
    select '100515'||p_CommodityID,name||p_CommodityID,3,'C' from f_account where code='100515';
  end if;

  select count(*) into v_cnt from f_account where code = '200515'||p_CommodityID;
  if(v_cnt=0) then
    insert into f_account(Code,Name,accountLevel,dCFlag)
    select '200515'||p_CommodityID,name||p_CommodityID,3,'C' from f_account where code='200515';
  end if;

  select count(*) into v_cnt from f_account where code = '200415'||p_CommodityID;
  if(v_cnt=0) then
    insert into f_account(Code,Name,accountLevel,dCFlag)
    select '200415'||p_CommodityID,name||p_CommodityID,3,'C' from f_account where code='200415';
  end if;

end;
/

prompt
prompt Creating procedure SP_F_UNFROZENALLFUNDS
prompt ========================================
prompt
create or replace procedure SP_F_UnFrozenAllFunds
(
  p_moduleID char   --����ģ��ID 2��Զ�� 3���ֻ� 4������
)
/***
 * ���¶����ʽ�
 * version 1.0.0.1 �˷�������
 *
 * ����ֵ�������ʽ����
 ****/
is
begin
  update f_firmfunds f set frozenfunds=frozenfunds -
    nvl((select frozenfunds from f_frozenfunds where moduleid=p_moduleID and firmid=f.firmid and frozenfunds<>0),0)
  ;

  update f_frozenfunds set frozenfunds=0 where moduleid=p_moduleID and frozenfunds<>0;

  insert into f_log
    (occurtime, type, userid, description)
  values
    (sysdate, 'sysinfo', 'system', 'UnFrozen specifid module funds:'||p_moduleID);

end;
/


spool off
