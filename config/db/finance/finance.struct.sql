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
  is 'D:Debit 借
C:Credit 贷
';
comment on column F_ACCOUNT.isinit
  is 'Y:是初始化数据,页面不允许删除和修改
N:不是初始化数据';
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
  is '工行银行帐户表';
comment on column F_B_BANKACCOUNT.bankid
  is '银行编号';
comment on column F_B_BANKACCOUNT.account
  is '银行帐号';
comment on column F_B_BANKACCOUNT.status
  is '状态(0 可用,1 冻结)';
comment on column F_B_BANKACCOUNT.accountname
  is '账户名';
comment on column F_B_BANKACCOUNT.bankname
  is '银行名称';
comment on column F_B_BANKACCOUNT.bankprovince
  is '银行省份';
comment on column F_B_BANKACCOUNT.bankcity
  is '银行所在市';
comment on column F_B_BANKACCOUNT.mobile
  is '电话号码';
comment on column F_B_BANKACCOUNT.email
  is '邮箱';
comment on column F_B_BANKACCOUNT.cardtype
  is '帐户类型(1 身份证,2军官证,3国内护照,4户口本,5学员证,6退休证,7临时身份证,8组织机构代码,9营业执照,A警官证,B解放军士兵证,C回乡证,D外国护照,E港澳台居民身份证,F台湾通行证及其他有效旅行证,G海外客户编号,H解放军文职干部证,I武警文职干部证,J武警士兵证,X其他有效证件,Z重号身份证)(主要用的是 1、8,有用 9 的 其它还没有用的';
comment on column F_B_BANKACCOUNT.card
  is '证件号码';

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
  is '分分核对表';
comment on column F_B_BANKCAPITALRESULT.bankid
  is '银行编号';
comment on column F_B_BANKCAPITALRESULT.firmid
  is '交易商代码';
comment on column F_B_BANKCAPITALRESULT.bankright
  is '银行权益';
comment on column F_B_BANKCAPITALRESULT.maketright
  is '市场权益';
comment on column F_B_BANKCAPITALRESULT.reason
  is '不平原因(0金额不平 1银行端账户未建立 2机构端账户未建立)';
comment on column F_B_BANKCAPITALRESULT.bdate
  is '日期时间';
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
  is '银行对账信息表';
comment on column F_B_BANKCOMPAREINFO.id
  is '银行对账信息ID';
comment on column F_B_BANKCOMPAREINFO.funid
  is '银行流水号';
comment on column F_B_BANKCOMPAREINFO.firmid
  is '交易商代码';
comment on column F_B_BANKCOMPAREINFO.account
  is '交易商账号';
comment on column F_B_BANKCOMPAREINFO.type
  is '操作类型(0 入金,1 出金)';
comment on column F_B_BANKCOMPAREINFO.money
  is '金额';
comment on column F_B_BANKCOMPAREINFO.comparedate
  is '对账日期';
comment on column F_B_BANKCOMPAREINFO.note
  is '备注';
comment on column F_B_BANKCOMPAREINFO.createtime
  is '创建日期';
comment on column F_B_BANKCOMPAREINFO.status
  is '操作状态';
comment on column F_B_BANKCOMPAREINFO.bankid
  is '银行编号';
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
  is '银行清算时间表';
comment on column F_B_BANKQSDATE.bankid
  is '银行编号';
comment on column F_B_BANKQSDATE.tradedate
  is '清算日期';
comment on column F_B_BANKQSDATE.tradetype
  is '清算类型';
comment on column F_B_BANKQSDATE.tradestatus
  is '清算状态(0 成功,1 失败)';
comment on column F_B_BANKQSDATE.note
  is '备注信息';
comment on column F_B_BANKQSDATE.createdate
  is '记录创建时间';

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
  is '银行表';
comment on column F_B_BANKS.bankid
  is '银行编号';
comment on column F_B_BANKS.bankname
  is '银行名称';
comment on column F_B_BANKS.maxpersgltransmoney
  is '单笔最大转账金额';
comment on column F_B_BANKS.maxpertransmoney
  is '每日最大转账金额';
comment on column F_B_BANKS.maxpertranscount
  is '每日最大转账次数';
comment on column F_B_BANKS.adapterclassname
  is '适配器实现类名称';
comment on column F_B_BANKS.validflag
  is '银行状态(0 可用,1 不可用)';
comment on column F_B_BANKS.maxauditmoney
  is '当个银行出金审核额度';
comment on column F_B_BANKS.begintime
  is '银行起始转账时间';
comment on column F_B_BANKS.endtime
  is '银行结束转账时间';
comment on column F_B_BANKS.control
  is '是否受到交易日和交易时间的约束 (0 受双重约束,1 不受约束,2 受交易日约束,3 受交易时间约束)';
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
  is '工行银行转账表';
comment on column F_B_BANKTRANSFER.paybankid
  is '转出银行ID银行编号';
comment on column F_B_BANKTRANSFER.recbankid
  is '转转入银行ID银行编号';
comment on column F_B_BANKTRANSFER.money
  is '冻结资金';
comment on column F_B_BANKTRANSFER.moneytype
  is '0为人民币';
comment on column F_B_BANKTRANSFER.funid
  is '银行流水号';
comment on column F_B_BANKTRANSFER.maerketid
  is '银行流水号';
comment on column F_B_BANKTRANSFER.status
  is '0 成功,1 失败,2 处理中,3 一次审核,4 二次审核,5 银行返回信息为空,6 银行返回市场流水号和市场保存流水号不一致,13 市场假银行出入金待审核状态';

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
  is '对账不平记录';
comment on column F_B_BATCUSTFILE.custacctid
  is '子账号';
comment on column F_B_BATCUSTFILE.custname
  is '名称';
comment on column F_B_BATCUSTFILE.thirdcustid
  is '会员代码';
comment on column F_B_BATCUSTFILE.bankbalance
  is '银行清算后可用余额';
comment on column F_B_BATCUSTFILE.bankfrozen
  is '银行清算后冻结余额';
comment on column F_B_BATCUSTFILE.maketbalance
  is '交易网可用余额';
comment on column F_B_BATCUSTFILE.maketfrozen
  is '交易网冻结余额';
comment on column F_B_BATCUSTFILE.balanceerror
  is '可用余额差额（银行可用余额-交易网可用余额）';
comment on column F_B_BATCUSTFILE.frozenerror
  is '冻结余额差额（银行冻结余额-交易网冻结余额）';
comment on column F_B_BATCUSTFILE.tradedate
  is '交易时间';
comment on column F_B_BATCUSTFILE.bankid
  is '银行编号';
comment on column F_B_BATCUSTFILE.createdate
  is '创建日期';
comment on column F_B_BATCUSTFILE.note
  is '备注信息';
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
  is '市场流水表';
comment on column F_B_CAPITALINFO.id
  is '流水ID';
comment on column F_B_CAPITALINFO.firmid
  is '交易商代码';
comment on column F_B_CAPITALINFO.funid
  is '银行流水号';
comment on column F_B_CAPITALINFO.bankid
  is '银行编号';
comment on column F_B_CAPITALINFO.debitid
  is '贷方代码';
comment on column F_B_CAPITALINFO.creditid
  is '借方代码';
comment on column F_B_CAPITALINFO.type
  is '流水类型(0 入金,1 出金,2出入金手续费';
comment on column F_B_CAPITALINFO.money
  is '流水金额';
comment on column F_B_CAPITALINFO.operator
  is '业务代码';
comment on column F_B_CAPITALINFO.createtime
  is '创建时间';
comment on column F_B_CAPITALINFO.banktime
  is '银行事件';
comment on column F_B_CAPITALINFO.status
  is '状态(0 成功,1 失败,2 处理中,3 一次审核,4 二次审核,5 银行返回信息为空,6 银行返回市场流水号和市场保存流水号不一致,13 市场假银行出入金待审核状态)';
comment on column F_B_CAPITALINFO.note
  is '备注信息';
comment on column F_B_CAPITALINFO.actionid
  is '业务流水';
comment on column F_B_CAPITALINFO.express
  is '是否加急';
comment on column F_B_CAPITALINFO.bankname
  is '特殊加的(银行名称)';
comment on column F_B_CAPITALINFO.account
  is '特殊加的(银行账号)';
comment on column F_B_CAPITALINFO.createdate
  is '创建时间';
comment on column F_B_CAPITALINFO.funid2
  is '流水2';
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
  is '字典表';
comment on column F_B_DICTIONARY.id
  is '字典ID';
comment on column F_B_DICTIONARY.type
  is '类型';
comment on column F_B_DICTIONARY.bankid
  is '银行编号';
comment on column F_B_DICTIONARY.name
  is '字典名';
comment on column F_B_DICTIONARY.value
  is '字典值';
comment on column F_B_DICTIONARY.note
  is '备注';
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
  is '标准费用表';
comment on column F_B_FEEINFO.id
  is '费用列表ID';
comment on column F_B_FEEINFO.uplimit
  is '结束金额';
comment on column F_B_FEEINFO.downlimit
  is '起始金额';
comment on column F_B_FEEINFO.tmode
  is '计算放肆(0 百分比,2 绝对值)';
comment on column F_B_FEEINFO.rate
  is '手续费';
comment on column F_B_FEEINFO.type
  is '收费类型';
comment on column F_B_FEEINFO.createtime
  is '记录时间';
comment on column F_B_FEEINFO.updatetime
  is '修改时间';
comment on column F_B_FEEINFO.userid
  is '用户ID(记录人,交易商,银行)';
comment on column F_B_FEEINFO.maxratevalue
  is '最大金额';
comment on column F_B_FEEINFO.minratevalue
  is '最小金额';
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
  is '分分核对表';
comment on column F_B_FFHD.bankid
  is '银行编号';
comment on column F_B_FFHD.tradedate
  is '交易日期';
comment on column F_B_FFHD.firmid
  is '交易商编号';
comment on column F_B_FFHD.account
  is '交易商银行账号';
comment on column F_B_FFHD.currency
  is '币别 (001：人民币 013：港币 014：美元)';
comment on column F_B_FFHD.type
  is '钞汇标识 (0：钞 1：汇)';
comment on column F_B_FFHD.reasion
  is '不平原因 (0:金额不平 1:银行端资金存管账户未建立 2:市场端交易商代码不存在)';
comment on column F_B_FFHD.balancem
  is '市场总权益';
comment on column F_B_FFHD.cashm
  is '市场现金权益';
comment on column F_B_FFHD.billm
  is '市场票据权益';
comment on column F_B_FFHD.usebalancem
  is '市场可用资金';
comment on column F_B_FFHD.frozencashm
  is '市场占用现金';
comment on column F_B_FFHD.frozenloanm
  is '市场占用贷款金额';
comment on column F_B_FFHD.balanceb
  is '银行总权益';
comment on column F_B_FFHD.cashb
  is '银行现金权益';
comment on column F_B_FFHD.billb
  is '银行票据权益';
comment on column F_B_FFHD.usebalanceb
  is '银行可用资金';
comment on column F_B_FFHD.frozencashb
  is '银行占用现金';
comment on column F_B_FFHD.frozenloanb
  is '银行占用贷款金额';
comment on column F_B_FFHD.createdate
  is '创建时间';
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
  is '会员余额记录';
comment on column F_B_FIRMBALANCE.custacctid
  is '子账号';
comment on column F_B_FIRMBALANCE.custname
  is '账户名';
comment on column F_B_FIRMBALANCE.thirdcustid
  is '会员代码';
comment on column F_B_FIRMBALANCE.status
  is '状态(1：正常  2：退出  3：待确定)';
comment on column F_B_FIRMBALANCE.type
  is '账号属性(1：普通会员子账号  2：挂账子账号  3：手续费子账号  4：利息子账号  6：清算子账号)';
comment on column F_B_FIRMBALANCE.istruecont
  is '是否实子账号(默认为 1：虚子账号)';
comment on column F_B_FIRMBALANCE.balance
  is '总额';
comment on column F_B_FIRMBALANCE.usrbalance
  is '可用余额';
comment on column F_B_FIRMBALANCE.frozenbalance
  is '冻结资金';
comment on column F_B_FIRMBALANCE.interest
  is '利息基数';
comment on column F_B_FIRMBALANCE.bankid
  is '银行代码';
comment on column F_B_FIRMBALANCE.tradedate
  is '交易日期';
comment on column F_B_FIRMBALANCE.createdate
  is '信息创建时间';
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
  is '银行对账失败文件';
comment on column F_B_FIRMBALANCEERROR.trandatetime
  is '交易时间';
comment on column F_B_FIRMBALANCEERROR.counterid
  is '操作员';
comment on column F_B_FIRMBALANCEERROR.supacctid
  is '资金汇总帐号';
comment on column F_B_FIRMBALANCEERROR.funccode
  is '功能代码';
comment on column F_B_FIRMBALANCEERROR.custacctid
  is '子账户账号';
comment on column F_B_FIRMBALANCEERROR.custname
  is '子账户名称';
comment on column F_B_FIRMBALANCEERROR.thirdcustid
  is '交易网会员代码';
comment on column F_B_FIRMBALANCEERROR.thirdlogno
  is '交易网流水号';
comment on column F_B_FIRMBALANCEERROR.ccycode
  is '币种';
comment on column F_B_FIRMBALANCEERROR.freezeamount
  is '当天总冻结资金';
comment on column F_B_FIRMBALANCEERROR.unfreezeamount
  is '当天总解冻资金';
comment on column F_B_FIRMBALANCEERROR.addtranamount
  is '当天成交的总货款(卖方)';
comment on column F_B_FIRMBALANCEERROR.cuttranamount
  is '当天成交的总货款(买方)';
comment on column F_B_FIRMBALANCEERROR.profitamount
  is '盈利总金额';
comment on column F_B_FIRMBALANCEERROR.lossamount
  is '亏损总金额';
comment on column F_B_FIRMBALANCEERROR.tranhandfee
  is '交易商当天应付给交易网的手续费';
comment on column F_B_FIRMBALANCEERROR.trancount
  is '当天交易总比数';
comment on column F_B_FIRMBALANCEERROR.newbalance
  is '交易网端最新的交易商可用金额';
comment on column F_B_FIRMBALANCEERROR.newfreezeamount
  is '交易网端最新的冻结资金';
comment on column F_B_FIRMBALANCEERROR.note
  is '说明';
comment on column F_B_FIRMBALANCEERROR.reserve
  is '保留域';
comment on column F_B_FIRMBALANCEERROR.rspcode
  is '错误码';
comment on column F_B_FIRMBALANCEERROR.rspmsg
  is '应答描述';
comment on column F_B_FIRMBALANCEERROR.bankid
  is '银行代码';
comment on column F_B_FIRMBALANCEERROR.createtime
  is '信息创建时间';
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
  is '交易商银行账号对应表';
comment on column F_B_FIRMIDANDACCOUNT.bankid
  is '银行编号';
comment on column F_B_FIRMIDANDACCOUNT.firmid
  is '交易商代码';
comment on column F_B_FIRMIDANDACCOUNT.account
  is '银行帐号';
comment on column F_B_FIRMIDANDACCOUNT.account1
  is '银行内部账号';
comment on column F_B_FIRMIDANDACCOUNT.status
  is '状态(0 可用,1 冻结)';
comment on column F_B_FIRMIDANDACCOUNT.accountname
  is '账户名';
comment on column F_B_FIRMIDANDACCOUNT.bankname
  is '银行名称';
comment on column F_B_FIRMIDANDACCOUNT.bankprovince
  is '银行省份';
comment on column F_B_FIRMIDANDACCOUNT.bankcity
  is '银行所在市';
comment on column F_B_FIRMIDANDACCOUNT.mobile
  is '电话号码';
comment on column F_B_FIRMIDANDACCOUNT.email
  is '邮箱';
comment on column F_B_FIRMIDANDACCOUNT.isopen
  is '是否已签约(0 未签约,1 已签约)';
comment on column F_B_FIRMIDANDACCOUNT.cardtype
  is '--帐户类型(1 身份证,2军官证,3国内护照,4户口本,5学员证,6退休证,7临时身份证,8组织机构代码,9营业执照,A警官证,B解放军士兵证,C回乡证,D外国护照,E港澳台居民身份证,F台湾通行证及其他有效旅行证,G海外客户编号,H解放军文职干部证,I武警文职干部证,J武警士兵证,X其他有效证件,Z重号身份证)(主要用的是 1、8,有用 9 的 其它还没有用的)';
comment on column F_B_FIRMIDANDACCOUNT.card
  is '证件号码';
comment on column F_B_FIRMIDANDACCOUNT.frozenfuns
  is '冻结资金';
comment on column F_B_FIRMIDANDACCOUNT.accountname1
  is '银行内部账户名称';
comment on column F_B_FIRMIDANDACCOUNT.opentime
  is '开户时间';
comment on column F_B_FIRMIDANDACCOUNT.inmarketcode
  is '交易商入世协议号';
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
  createdate   DATE default sysdate    --记录创建日期
)
;
comment on table F_B_FIRMKXH
  is '当天会员开销户信息表';
comment on column F_B_FIRMKXH.funid
  is '银行前置流水号';
comment on column F_B_FIRMKXH.status
  is '交易状态(1：开户 2：销户 3：待确认)';
comment on column F_B_FIRMKXH.account1
  is '会员子账号';
comment on column F_B_FIRMKXH.type
  is '子账户性质';
comment on column F_B_FIRMKXH.account1name
  is '子账户名称';
comment on column F_B_FIRMKXH.firmid
  is '交易商代码';
comment on column F_B_FIRMKXH.tradedate
  is '交易日期';
comment on column F_B_FIRMKXH.counterid
  is '操作柜员号';
comment on column F_B_FIRMKXH.bankid
  is '银行代码';
comment on column F_B_FIRMKXH.createdate
  is '记录创建日期';
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
  is '客户协议状态（增量）对账表';
comment on column F_B_FIRMTRADESTATUS.bankid
  is '银行id';
comment on column F_B_FIRMTRADESTATUS.dealid
  is '市场组织机构代码';
comment on column F_B_FIRMTRADESTATUS.cobrn
  is '合作方机构号';
comment on column F_B_FIRMTRADESTATUS.txdate
  is '交易日期';
comment on column F_B_FIRMTRADESTATUS.bankacc
  is '银行账号';
comment on column F_B_FIRMTRADESTATUS.fundacc
  is '交易商代码';
comment on column F_B_FIRMTRADESTATUS.custname
  is '交易商姓名';
comment on column F_B_FIRMTRADESTATUS.curcode
  is '币种';
comment on column F_B_FIRMTRADESTATUS.status
  is '状态';
comment on column F_B_FIRMTRADESTATUS.comparedate
  is '对账日期';
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
  is '银行接口部分用户表';
comment on column F_B_FIRMUSER.firmid
  is '交易商代码';
comment on column F_B_FIRMUSER.name
  is '交易商名称';
comment on column F_B_FIRMUSER.maxpersgltransmoney
  is '单笔最大转账金额';
comment on column F_B_FIRMUSER.maxpertransmoney
  is '每天最大转账金额';
comment on column F_B_FIRMUSER.maxpertranscount
  is '每天最大转账次数';
comment on column F_B_FIRMUSER.status
  is '交易商状态(0 已注册,1 禁用或未注册,2注销)';
comment on column F_B_FIRMUSER.registerdate
  is '注册日期';
comment on column F_B_FIRMUSER.logoutdate
  is '注销日期';
comment on column F_B_FIRMUSER.maxauditmoney
  is '审核额度';
comment on column F_B_FIRMUSER.password
  is '密码';
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
  is '添加华夏清算表';
comment on column F_B_HXQS.bankid
  is '银行编号';
comment on column F_B_HXQS.firmid
  is '交易商编号';
comment on column F_B_HXQS.tradedate
  is '清算日期';
comment on column F_B_HXQS.money
  is '金额';
comment on column F_B_HXQS.type
  is '借贷标示 (1:借，资金减少 2:贷，资金增减)';
comment on column F_B_HXQS.tradetype
  is '资金类型';
comment on column F_B_HXQS.note
  is '备注信息';
comment on column F_B_HXQS.createdate
  is '数据写入时间';
comment on column F_B_HXQS.status
  is '当前状态(0:成功 1:失败 2:情况未知)';
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
  is '银行代码
银行代码';
comment on column F_B_INTERFACELOG.launcher
  is '发起方
0 市场
1 银行';
comment on column F_B_INTERFACELOG.type
  is '交易类型
1 签到
2 签退
3 签约
4 解约
5 查询余额
6 出金
7 入金
8 冲正';
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
  is '银行接口部分操作日指标';
comment on column F_B_LOG.logid
  is '日志编号';
comment on column F_B_LOG.logopr
  is '操作员';
comment on column F_B_LOG.logcontent
  is '操作内容';
comment on column F_B_LOG.logdate
  is '日志记录日期';
comment on column F_B_LOG.logip
  is '日志记录登录机器';
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
  createtime DATE default sysdate   --创建时间
)
;
comment on table F_B_MAKETMONEY
  is '添加市场自有资金利息表';
comment on column F_B_MAKETMONEY.id
  is '自有资金编号';
comment on column F_B_MAKETMONEY.bankid
  is '银行编号';
comment on column F_B_MAKETMONEY.banknumber
  is ' 银行转账号';
comment on column F_B_MAKETMONEY.type
  is '资金类型 (1:手续费,2:利息)';
comment on column F_B_MAKETMONEY.adddelt
  is '增加、减少资金(1:增加 2:减少)';
comment on column F_B_MAKETMONEY.money
  is '增加、减少金额额度';
comment on column F_B_MAKETMONEY.note
  is '备注信息';
comment on column F_B_MAKETMONEY.createtime
  is '创建时间';
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
  is '交易商资金冻结解冻表';
comment on column F_B_MARGINS.serial_id
  is '业务流水号';
comment on column F_B_MARGINS.bargain_code
  is '成交合同号';
comment on column F_B_MARGINS.trade_type
  is '交易类型 (1 冻结；2 解冻)';
comment on column F_B_MARGINS.trade_money
  is '交易金额';
comment on column F_B_MARGINS.member_code
  is '交易会员号';
comment on column F_B_MARGINS.member_name
  is '交易会员名称';
comment on column F_B_MARGINS.trade_date
  is '交易日期';
comment on column F_B_MARGINS.good_code
  is '商品编号';
comment on column F_B_MARGINS.good_name
  is '商品名称';
comment on column F_B_MARGINS.good_quantity
  is '商品数量';
comment on column F_B_MARGINS.flag
  is '发送状态 (N 未发送；F 银行处理失败；Y 银行处理成功)';
comment on column F_B_MARGINS.bankid
  is '银行编号';
comment on column F_B_MARGINS.createdate
  is '创建时间';
comment on column F_B_MARGINS.note
  is '资金冻结解冻表备注字段';
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
  is '总分平衡表';
comment on column F_B_PROPERBALANCE.bankid
  is '银行编号';
comment on column F_B_PROPERBALANCE.allmoney
  is '总资金';
comment on column F_B_PROPERBALANCE.gongmoney
  is '工行总资金';
comment on column F_B_PROPERBALANCE.othermoney
  is '其他行资金';
comment on column F_B_PROPERBALANCE.bdate
  is '日期时间';

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
  is '对账不平纪录信息';
comment on column F_B_QSRESULT.resultid
  is '流水编号';
comment on column F_B_QSRESULT.bankid
  is '银行编号';
comment on column F_B_QSRESULT.bankname
  is '银行名称';
comment on column F_B_QSRESULT.firmid
  is '交易商代码';
comment on column F_B_QSRESULT.firmname
  is '交易商名称';
comment on column F_B_QSRESULT.account
  is '银行账号';
comment on column F_B_QSRESULT.account1
  is '子账号';
comment on column F_B_QSRESULT.kymoneym
  is '市场可用余额';
comment on column F_B_QSRESULT.kymoneyb
  is '银行可用余额';
comment on column F_B_QSRESULT.djmoneym
  is '市场冻结资金';
comment on column F_B_QSRESULT.djmoneyb
  is '银行冻结资金';
comment on column F_B_QSRESULT.zckymoney
  is '可用资金扎差';
comment on column F_B_QSRESULT.zcdjmoney
  is '冻结资金扎差';
comment on column F_B_QSRESULT.moneym
  is '市场权益';
comment on column F_B_QSRESULT.moneyb
  is '银行权益';
comment on column F_B_QSRESULT.zcmoney
  is '权益扎差';
comment on column F_B_QSRESULT.createdate
  is '记录创建时间';
comment on column F_B_QSRESULT.tradedate
  is '交易日期';
comment on column F_B_QSRESULT.status
  is '清算状态(0:成功、1:失败、2:可用余额不等、3:冻结余额不等、4:总余额不等、6:账号资金异常)';
comment on column F_B_QSRESULT.note
  is '备注信息';
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
  is '交易权益表';
comment on column F_B_QUANYI.id
  is '表单ID';
comment on column F_B_QUANYI.firmid
  is '交易商代码';
comment on column F_B_QUANYI.venduebalance
  is '竞价部分占用保证金';
comment on column F_B_QUANYI.zcjsbalance
  is '挂牌部分占用保证金';
comment on column F_B_QUANYI.timebargainbalance
  is '中远期部分权益';
comment on column F_B_QUANYI.avilablebalance
  is '财务余额';
comment on column F_B_QUANYI.bankbalance
  is '银行余额';
comment on column F_B_QUANYI.payment
  is '收货款';
comment on column F_B_QUANYI.income
  is '付货款';
comment on column F_B_QUANYI.fee
  is '手续费';
comment on column F_B_QUANYI.jie
  is '接触金额';
comment on column F_B_QUANYI.dai
  is '贷入金额';
comment on column F_B_QUANYI.dealtime
  is '记录日期';
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
  is '记录流水号';
comment on column F_B_RGSTCAPITALVALUE.actionid
  is '市场流水号';
comment on column F_B_RGSTCAPITALVALUE.firmid
  is '交易商代码';
comment on column F_B_RGSTCAPITALVALUE.account
  is '签约协议号';
comment on column F_B_RGSTCAPITALVALUE.bankid
  is '银行代码';
comment on column F_B_RGSTCAPITALVALUE.type
  is '流水类型 1签约  2解约';
comment on column F_B_RGSTCAPITALVALUE.createtime
  is '创建时间';
comment on column F_B_RGSTCAPITALVALUE.banktime
  is '完成时间';
comment on column F_B_RGSTCAPITALVALUE.status
  is '流水状态 0成功 1失败 2处理中';
comment on column F_B_RGSTCAPITALVALUE.accountname
  is '户名';
comment on column F_B_RGSTCAPITALVALUE.cardtype
  is '证件类型';
comment on column F_B_RGSTCAPITALVALUE.card
  is '证件号';
comment on column F_B_RGSTCAPITALVALUE.note
  is '备注';
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
  is '交易数据表';
comment on column F_B_TRADEDATA.firmid
  is '交易商id';
comment on column F_B_TRADEDATA.account1
  is '交易账号 [对应交易商银行帐号对应表的内部帐号]';
comment on column F_B_TRADEDATA.money
  is '变动金额';
comment on column F_B_TRADEDATA.type
  is '类型(0：权益增  1：权益减  2：收货款  3：付货款   4：手续费 5正 资金误差 6负 资金误差)';
comment on column F_B_TRADEDATA.status
  is '发送结果(1：未发送   0：发送成功)';
comment on column F_B_TRADEDATA.transferdate
  is '应发送时间';
comment on column F_B_TRADEDATA.accountname1
  is '交易账号名称';
comment on column F_B_TRADEDATA.actionid
  is '市场流水号';
comment on column F_B_TRADEDATA.funid
  is '银行流水号';
comment on column F_B_TRADEDATA.compareresult
  is '银行转账';
comment on column F_B_TRADEDATA.banktime
  is '对账时间';
comment on column F_B_TRADEDATA.realtransferdate
  is '实际发送时间';
comment on column F_B_TRADEDATA.sendperson
  is '发送人';
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
  is '账户类交易对账明细表';
comment on column F_B_TRADEDETAILACC.batchno
  is '交易序号';
comment on column F_B_TRADEDETAILACC.bankid
  is '银行id';
comment on column F_B_TRADEDETAILACC.dealid
  is '市场组织机构代码';
comment on column F_B_TRADEDETAILACC.cobrn
  is '合作方机构代码';
comment on column F_B_TRADEDETAILACC.txdate
  is '交易日期';
comment on column F_B_TRADEDETAILACC.txtime
  is '交易时间';
comment on column F_B_TRADEDETAILACC.bkserial
  is '银行流水';
comment on column F_B_TRADEDETAILACC.coserial
  is '市场流水';
comment on column F_B_TRADEDETAILACC.bankacc
  is '银行账号';
comment on column F_B_TRADEDETAILACC.fundacc
  is '交易商代码';
comment on column F_B_TRADEDETAILACC.custname
  is '交易商姓名';
comment on column F_B_TRADEDETAILACC.txopt
  is '交易发起方';
comment on column F_B_TRADEDETAILACC.txcode
  is '交易类型';
comment on column F_B_TRADEDETAILACC.curcode
  is '币种';
comment on column F_B_TRADEDETAILACC.comparedate
  is '对账日期';
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
  is '交易商权益变更表';
comment on column F_B_TRADELIST.trade_money
  is '变更金额';
comment on column F_B_TRADELIST.trade_type
  is '交易类型(1 货款、盈亏、补偿费；2 交易手续费；3 交收手续费；4 浮亏；5 其他手续费)';
comment on column F_B_TRADELIST.b_member_code
  is '买方会员号';
comment on column F_B_TRADELIST.b_member_name
  is '买方会员名称';
comment on column F_B_TRADELIST.s_member_code
  is '卖方会员号';
comment on column F_B_TRADELIST.s_member_name
  is '买方会员名称';
comment on column F_B_TRADELIST.trade_date
  is '交易日期';
comment on column F_B_TRADELIST.bargain_code
  is '成交合同号';
comment on column F_B_TRADELIST.serial_id
  is '交易流水号';
comment on column F_B_TRADELIST.good_code
  is '货物编号';
comment on column F_B_TRADELIST.good_name
  is '货物名称';
comment on column F_B_TRADELIST.good_quantity
  is '货物数量';
comment on column F_B_TRADELIST.flag
  is '发送状态 (N 未发送；F 银行处理失败；Y 银行处理成功)';
comment on column F_B_TRADELIST.bankid
  is '银行编号';
comment on column F_B_TRADELIST.createdate
  is '创建时间';
comment on column F_B_TRADELIST.note
  is '交易商权益变更表备注字段';
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
  is '资金划转对象表';
comment on column F_B_TRANSMONEYOBJ.id
  is '序号';
comment on column F_B_TRANSMONEYOBJ.classname
  is '业务实现类';
comment on column F_B_TRANSMONEYOBJ.note
  is '备注';

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
  is '总分平衡表';
comment on column F_B_ZFPH.bankid
  is '银行编号';
comment on column F_B_ZFPH.tradedate
  is '交易日期';
comment on column F_B_ZFPH.currency
  is '币别 (001：人民币 013：港币 014：美元)';
comment on column F_B_ZFPH.type
  is ' 钞汇标识（0：钞 1：汇）';
comment on column F_B_ZFPH.lastaccountbalance
  is '资金存管明细账户余额汇总';
comment on column F_B_ZFPH.accountbalance
  is '资金汇总账号金额';
comment on column F_B_ZFPH.result
  is '总分对账结果(0：平 1：不平)';
comment on column F_B_ZFPH.createdate
  is '创建时间';
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
  is 'Y:完成
N:未执行';
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
  is '10综合管理平台
11财务系统
13仓单管理系统
14融资系统
15订单交易
18投资类大宗商品交易系统
20做市商交易系统
21竞价系统
22银行接入及结算系统
23E现货';
comment on column F_FROZENFUNDFLOW.createtime
  is '创建时间';
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
  is '10综合管理平台
11财务系统
13仓单管理系统
14融资系统
15订单交易
18投资类大宗商品交易系统
20做市商交易系统
21竞价系统
22银行接入及结算系统
23E现货';
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
  is '创建时间';
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
  is '10综合管理平台
11财务系统
13仓单管理系统
14融资系统
15订单交易
18投资类大宗商品交易系统
20做市商交易系统
21竞价系统
22银行接入及结算系统
23E现货';
comment on column F_H_FROZENFUNDFLOW.createtime
  is '创建时间';
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
  is '当前帐户资金余额（不考虑浮亏）';
comment on column F_H_FUNDFLOW.createtime
  is '创建时间';
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
  is '1：增项 -1：减项';
comment on column F_LEDGERFIELD.moduleid
  is '10综合管理平台
11财务系统
13仓单管理系统
14融资系统
15订单交易
18投资类大宗商品交易系统
20做市商交易系统
21竞价系统
22银行接入及结算系统
23E现货';
comment on column F_LEDGERFIELD.ordernum
  is '前两位模块号后三位排序号
';
comment on column F_LEDGERFIELD.isinit
  is 'Y:是初始化数据,页面不允许删除和修改
N:不是初始化数据';
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
  is '财务日志表';
comment on column F_LOG.type
  is 'info：信息
alert：警告
error：错误
sysinfo：系统信息';

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
  is '该凭证如果涉及交易商资金，增加资金记贷方 C，减少资金记借方 D。
不涉及交易商资金：N';
comment on column F_SUMMARY.accountcodeopp
  is '用于电脑凭证';
comment on column F_SUMMARY.appendaccount
  is '除了资金发生变动外，还有附加的财务账户变动。
T：增值税 Tax
W：担保金 Warranty
S：交收保证金 SettleMargin
N：无附加';
comment on column F_SUMMARY.isinit
  is 'Y:是初始化数据,页面不允许删除和修改
N:不是初始化数据';
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
  is '0:未结算状态
1:结算中
2:结算完成';
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
  is 'editing   编辑状态
auditing  待审核
audited   已审核
accounted 已记账';
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
  is '用于快捷创建手工凭证的模板';
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
select firmId,          --交易商代码
       name,            --交易商名称
       f_balance,       --交易系统当前余额
       l_balance,       --财务结算余额
       y_balance,       --财务未结算金额
       balanceSubtract, --差额
       lastwarranty,    --担保金
       frozenFunds,     --临时资金
       user_balance     --可用资金
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
  p_firmID varchar2,      --交易商代码
  p_oprcode char,         --业务代码
  p_amount number,        --发生额
  p_contractNo varchar2,  --成交合同号
  p_extraCode varchar2,   --中远期商品代码，银行为科目代码
  p_appendAmount number,  --中远期(增值税,担保金)
  p_voucherNo number      --凭证号(手工凭证使用)
) return number
/***
 * 更新资金
 * version 1.0.0.1 此方法公用
 *
 * 返回值：资金余额
 ****/
is
  v_fundsign number(1); -- 1 加项 -1 减项
  v_balance number(15,2);
  v_amount number(15,2):= p_amount;
begin
  begin
    select decode(funddcflag,'C',1,'D',-1,0) into v_fundsign from f_summary where summaryno=p_oprcode;
    if(v_fundsign=0) then
      Raise_application_error(-21003, 'Fund DCflag not defined in F_Summary!'); --未设置业务代码（摘要）资金借贷方向
    end if;
  exception when NO_DATA_FOUND then
    Raise_application_error(-21002, 'Undefined operation code(summaryNo)!'); --不存在的业务代码（摘要）
  end;

  update f_firmfunds set balance=balance + v_fundsign*v_amount where firmid=p_firmid
  returning balance into v_balance;
  if(SQL%ROWCOUNT = 0) then
    Raise_application_error(-21001, 'FirmID not existed !'); --不存在的交易商代码
  end if;

  --插入资金流水
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
 * 审核凭证通过
 *
 * version 1.0.0.3
 *
 * 返回 1 成功 -1 未找到该笔待审核凭证
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

  v_amount number(15,2); --发生额
  v_balance number(15,2); --余额

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
    if(v_fundDCflag<>'D' and v_fundDCflag<>'C') then  --与交易商资金无关凭证
      Raise_application_error(-21003, 'Fund DCflag not defined in F_Summary!'); --未设置业务代码（摘要）资金借贷方向
    else  --有交易商资金变动
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
            return -2;            --造成负值
        end if;
      end loop;
    end if;
  end if;

  --更新凭证状态为已审核
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
) return number  --凭证号
/**
 * 创建凭证，凭证为编辑状态
 * version 1.0.0.3
 *
 **/
as
  v_level number;
  v_cnt number;
   v_voucherno number;
   v_summary varchar2(32);
begin
  --判断科目是否合法
  select accountlevel into v_level from f_account where code=p_debitCode;

  select count(*) into v_cnt from f_account where code like p_debitCode||'%' and accountlevel>v_level;
  if(v_cnt>0) then
   Raise_application_error(-21004, 'Fund accountcode not a leaf node!'||p_debitCode); --对方科目非叶子科目
  end if;

  select accountlevel into v_level from f_account where code=p_creditCode;

  select count(*) into v_cnt from f_account where code like p_creditCode||'%' and accountlevel>v_level;
  if(v_cnt>0) then
   Raise_application_error(-21004, 'Fund accountcode not a leaf node!'||p_creditCode); --对方科目非叶子科目
  end if;

  --如果没有指定摘要内容，查询出来。
  if(p_summary is null) then
    select summary into v_summary from F_Summary where summaryno=p_summaryNo;
  end if;
  select seq_f_voucher.nextval into v_voucherno from dual;

  --插入凭证
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
) return number  --凭证号
/**
 * 创建电脑凭证，凭证为已审核状态
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
 * 抽取电脑凭证
 * version 1.0.0.1
 *
 * 返回生成凭证数
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
  --通过交易资金流水和成交合同生成凭证
  open c_FundFlow;
  loop
     fetch c_FundFlow into v_fundflowid,v_firmId,v_oprcode,v_contractNo,v_commodityID,v_amount,v_appendAmount,v_createtime,v_b_date;
     exit when c_FundFlow%NOTFOUND;
     --将商品科目对应
     select funddcflag, replace(accountcodeopp,'*',v_commodityID),summary,appendAccount
     into v_funddcflag, v_accountcodeopp,v_summary,v_appendAccount
     from f_summary
     where summaryno = v_oprcode;

   --新增，用于诚信保证金 2012-5-10
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

     if(v_contractNo is not null) then --合同号跟交易系统号
       v_contractno:=substr(v_oprcode,1,1)||'-'||v_contractNo;
     end if;

     v_voucherNo:=fn_f_createvoucherComp(v_oprcode,v_summary,v_debitCode,v_creditCode,v_amount,v_contractno,v_fundflowid,v_createtime,v_b_date);
     v_cnt:=v_cnt + 1;

     update F_FundFlow set voucherno=v_voucherNo where fundflowid=v_fundflowid;

     if(v_appendAmount is not null and v_appendAmount!=0 and v_appendAccount!='N') then --有附加账目
         v_fundflowid:=null;
         if(v_appendAccount='T') then
           if(v_funddcflag='D') then  --亏损，一部分来自返回增值税
             v_oprcode:='15098';
             v_debitCode:='1005' || substr(v_oprcode,0,2) || v_commodityID;
             v_creditCode:=v_accountcodeopp;
           elsif(v_funddcflag='C') then --盈利，一部分给增值税
             v_oprcode:='15099';
             v_debitCode:=v_accountcodeopp;
             v_creditCode:='1005' || substr(v_oprcode,0,2) || v_commodityID;
           end if;
           v_voucherNo:=fn_f_createvoucherComp(v_oprcode,null,v_debitCode,v_creditCode,v_appendAmount,v_contractno,v_fundflowid,v_createtime,v_b_date);
           v_cnt:=v_cnt + 1;
         elsif(v_appendAccount='W') then --担保金
           if(v_funddcflag='D') then --收保证金，加担保金
             v_oprcode:='15097';  --入担保金
             v_debitCode:='1006';
             v_creditCode:='200101'||v_firmId;
             v_voucherNo:=fn_f_createvoucherComp(v_oprcode,null,v_debitCode,v_creditCode,v_appendAmount,v_contractno,v_fundflowid,v_createtime,v_b_date);
             v_cnt:=v_cnt + 1;

             v_oprcode:='15095';  --收交易商担保金
             v_debitCode:='200101'||v_firmId;
             v_creditCode:='2099'|| substr(v_oprcode,0,2) ||v_commodityID;
             v_voucherNo:=fn_f_createvoucherComp(v_oprcode,null,v_debitCode,v_creditCode,v_appendAmount,v_contractno,v_fundflowid,v_createtime,v_b_date);
             v_cnt:=v_cnt + 1;
           elsif(v_funddcflag='C') then --退保证金
             v_oprcode:='15094';  --退交易商担保金
             v_debitCode:='2099'|| substr(v_oprcode,0,2) ||v_commodityID;
             v_creditCode:='200101'||v_firmId;
             v_voucherNo:=fn_f_createvoucherComp(v_oprcode,null,v_debitCode,v_creditCode,v_appendAmount,v_contractno,v_fundflowid,v_createtime,v_b_date);
             v_cnt:=v_cnt + 1;

             v_oprcode:='15096';  --出担保金
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
     --清除开始日期以后的结算
     delete from F_DailyBalance where b_Date >= p_beginDate;
     delete from F_FirmBalance where b_Date >= p_beginDate;
     --取得上日日期
     select max(b_Date) into v_lastDate from F_DailyBalance;
     if(v_lastDate is null) then
          v_lastDate := to_date('2000-01-01','yyyy-MM-dd');
     end if;

     for curDate in (select distinct b_date from f_Accountbook where b_date > v_lastDate order by b_date)
     loop
         v_curDate:=curDate.b_Date;

         --对所有科目初始化当日结算记录
         insert into F_DailyBalance(b_date,accountcode,lastdaybalance,debitamount,creditamount,todaybalance)
         select v_curDate,a.Code,nvl(b.todaybalance,0),0,0,nvl(b.todaybalance,0)
         from f_account a,(select * from F_DailyBalance where b_date = v_lastDate) b
         where a.Code = b.accountCode(+) and a.code not like '%\_' escape '\';

         --更新叶子节点当日借贷方发生额
         for debit in (select debitCode,sum(amount) amount from f_accountBook where b_date = v_curDate group by debitCode)
         loop
             update F_DailyBalance set DebitAmount=debit.amount where b_date = v_curDate and accountCode = debit.debitcode;
         end loop;
         for credit in (select creditCode,sum(amount) amount from f_accountBook where b_date = v_curDate group by creditCode)
         loop
             update F_DailyBalance set creditAmount=credit.amount where b_date = v_curDate and accountCode = credit.creditCode;
         end loop;

         select max(accountlevel) into v_lvl from F_Account;
         --更新当日借方、贷方发生额
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

         --更新当日结算余额
         update (select a.*,b.dcflag from F_DailyBalance a,F_Account b
                 where b_date = v_curDate and a.accountCode=b.code) c
         set TodayBalance=c.LastdayBalance+(case dcflag when 'D' then DebitAmount-CreditAmount else CreditAmount-DebitAmount end);


         --------------------------------更新交易商结算表及担保金
         insert into F_FirmBalance
            (b_date, firmid, lastbalance, todaybalance, lastwarranty, todaywarranty)
         select b_date, substr(accountcode,7) firmid, lastdaybalance, todaybalance, 0, 0
         from f_dailybalance
         where b_Date=v_curDate
         and accountCode like '200100%' and substr(accountCode,7) is not null;

         --更新上日担保金
         update F_FirmBalance f
         set lastwarranty=nvl((select todaywarranty from F_FirmBalance where b_date=v_lastDate and firmid=f.firmid),0)
         where b_Date=v_curDate;

         --更新当日担保金
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

         --更新交易商资金表
         update F_Firmfunds f set (lastbalance,lastwarranty)=
           (select nvl(todaybalance,0),nvl(todaywarranty,0) from F_FirmBalance b where b_Date=v_curDate and b.firmid=f.firmid);
         --------------------------------end warranty
         --更新上日日期
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
    --清除开始日期以后的结算
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
 * 计算交易商权益
****/
as
	v_lastDate     date;           -- 上一个结算日
  v_cnt          number(4);      --数字变量
  v_sumFirmFee   number(15, 2);  -- 交易商手续费合计
  v_sumFL        number(15, 2);  -- 交易商订货盈亏合计
  v_sumBalance   number(15, 2);  -- 交易商权益计算费用合计
begin

   -- 更新银行清算权益计算费用

        -- 删除银行清算权益计算费用表的当日数据
        delete from F_FirmRightsComputeFunds where b_date = p_beginDate;

        -- 取得银行清算权益计算费用表的上一个结算日
        select max(b_Date) into v_lastDate from F_FirmRightsComputeFunds;

        if(v_lastDate is null) then
          v_lastDate := to_date('2000-01-01','yyyy-MM-dd');
        end if;

       -- 将交易商当前资金表的交易商和银行清算总账费用配置表中费用类型是权益计算费用的总账代码链表
       -- 插入银行清算权益计算费用表作为当日的初始数据
       insert into F_FirmRightsComputeFunds(B_date, Firmid, Code)
         select p_beginDate,f.firmid, bc.ledgercode
         from f_firmfunds f,F_BankClearLedgerConfig bc
         where bc.feetype = 1;

        for firmRights in (select b_date, firmId, code from F_FirmRightsComputeFunds where b_date = p_beginDate)
        loop
            -- 更新银行清算权益计算费用表的上日余额
            update F_FirmRightsComputeFunds f
            set lastBalance = nvl((select balance
                 from F_FirmRightsComputeFunds where b_date = v_lastDate and firmId = firmRights.firmId and code = firmRights.code ), 0)
            where b_date = firmRights.b_date and firmId = firmRights.firmId and code = firmRights.code;

            -- 更新银行清算权益计算费用表的当日余额
            update F_FirmRightsComputeFunds f
            set balance = nvl((select bc.fieldsign*c.value as amount
                               from f_clientledger c, f_bankclearledgerconfig bc
                               where c.b_date = firmRights.b_date and c.firmId = firmRights.firmId and c.code = firmRights.code and c.code = bc.ledgercode ), 0)
            where b_date = firmRights.b_date and firmId = firmRights.firmId and code = firmRights.code;

            -- 更新银行清算权益计算费用表的当日余额为：当日余额 + 上日余额
            --（这样就可以不用到交易系统中去取这些资金项）
            update F_FirmRightsComputeFunds f
            set balance = balance + lastBalance
            where b_date = firmRights.b_date and firmId = firmRights.firmId and code = firmRights.code;

        end loop;


   -- 更新交易商清算资金

     -- 删除交易商清算资金表的当日数据
     delete from F_FirmClearFunds where b_date = p_beginDate;

     -- 将交易商当前资金表的余额插入交易商清算资金表
     insert into F_FirmClearFunds(B_date, Firmid, Balance)
     select p_beginDate, f.firmid, f.balance from f_firmfunds f;

     for firmClearFunds in (select b_date, firmId from F_FirmClearFunds where b_date = p_beginDate)
     loop
         -- 计算交易商手续费
         select nvl(sum(value), 0) sumFirmFee into v_sumFirmFee
         from F_ClientLedger c
         where b_date = firmClearFunds.b_date and firmId = firmClearFunds.firmId
         and c.code in (select LedgerCode from F_BankClearLedgerConfig where FeeType = 0);

           -- 更新交易商清算资金表的交易商手续费
           update F_FirmClearFunds
           set firmFee = v_sumFirmFee
           where b_date = firmClearFunds.b_date and firmId = firmClearFunds.firmId;

         -- 计算市场手续费

         -- 计算交易商权益冻结资金

            -- 统计银行清算权益计算费用的当日余额
            select nvl(sum(Balance), 0) sumBalance into v_sumBalance from F_FirmRightsComputeFunds where b_date = firmClearFunds.b_date and firmId = firmClearFunds.firmId;

            -- 判断是否启用订单系统
            select count(*) into v_cnt from c_trademodule where moduleId = 15 and isbalancecheck = 'Y';
            if(v_cnt > 0) then

               -- 统计订单持仓盈亏
               select nvl(sum(FloatingLoss), 0) sumFL into v_sumFL from T_H_FirmHoldSum t where t.cleardate = firmClearFunds.b_date and t.firmid = firmClearFunds.firmId;

               update F_FirmClearFunds
               set RightsFrozenFunds = v_sumBalance + v_sumFL
               where b_date = firmClearFunds.b_date and firmId = firmClearFunds.firmId;

            else
               update F_FirmClearFunds
               set RightsFrozenFunds = v_sumBalance
               where b_date = firmClearFunds.b_date and firmId = firmClearFunds.firmId;

            end if;

         -- 计算交易商权益
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
     --清除开始日期以后的帐簿
     delete from f_accountbook where b_Date>=p_beginDate;
     --将凭证记入会计账簿
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
    p_beginDate date:=null --从哪一天开始结算
) return number
/**
 增加返回值-101，结算日期为空
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
               note = '结算中';
  commit; --此处提交是为了结算中状态外围能看到。

   --对财务系统状态表加锁，防止财务结算并发
   select b_date,status into v_b_date,v_status from F_systemstatus for update;

  --结算开始
  SP_F_ClearAction_Done(p_actionid => 0);

  --抽取电脑凭证
  v_rtn := FN_F_ExtractVoucher();
  SP_F_ClearAction_Done(p_actionid => 1);

  if p_beginDate is not null then
   v_beginDate:=trunc(p_beginDate);
  else
    v_beginDate:= trunc(sysdate);
  end if;
 /* --最近结算日
  select nvl(max(b_date),to_date('2000-01-01','yyyy-MM-dd')) into v_lastDate from f_dailybalance;
  --如果有新加入最近结算日的凭证，最近结算日提前一天。
  select count(*) into v_cnt from f_voucher where b_date=v_lastDate and status='audited';
  if(v_cnt>0) then
    v_lastDate:=v_lastDate-1;
  end if;

  if(v_beginDate is null) then
    v_beginDate := v_lastDate + 1;
  else
    --判断指定结算日期和最后结算日间是否有凭证，如果有从最近结算日后一天开始
    select count(*) into v_cnt from f_voucher where b_date>v_lastDate and b_date<p_beginDate;
    if(v_cnt>0) then
      v_beginDate := v_lastDate + 1;
    end if;
  end if;*/

  --归属流水及凭证日期
  update f_fundflow set b_date=v_beginDate;
  update f_voucher set b_date=v_beginDate where status='audited';
  SP_F_ClearAction_Done(p_actionid => 2);



  insert into f_log
    (occurtime, type, userid, description)
  values
    (sysdate, 'sysinfo', 'system', 'Balance specify date:'||nvl(to_char(p_beginDate,'yyyy-MM-dd'),'No')||' ->exec date:'||to_char(v_beginDate,'yyyy-MM-dd'));

  --将凭证记入会计账簿
  SP_F_PutVoucherToBook(v_beginDate);
  SP_F_ClearAction_Done(p_actionid => 3);
  --结算账户
  SP_F_BalanceAccount(v_beginDate);
  SP_F_ClearAction_Done(p_actionid => 4);
  --生成客户总账
  SP_F_ClientLedger(v_beginDate);
  SP_F_ClearAction_Done(p_actionid => 5);


  --插入历史流水表
  insert into f_h_fundflow
  select * from f_fundflow where b_date is not null;
  --删除当前流水表记录
  delete from F_Fundflow where b_date is not null;

  --插入冻结资金历史流水表
  insert into f_h_frozenfundflow
  select * from f_frozenfundflow;

  --删除当前的冻结资金流水表
  delete from f_frozenfundflow;
  SP_F_ClearAction_Done(p_actionid => 6);

  -- 生成交易商清算资金数据 by 2014-04-21 zhaodc
  SP_F_ComputeFirmRights(v_beginDate);
  SP_F_ClearAction_Done(p_actionid => 7);

  update F_systemstatus
           set b_date = v_beginDate,
               status = 2,
               note = '结算完成',
               cleartime = sysdate;
 SP_F_ClearAction_Done(p_actionid => 8);
  return 1;
 exception
    when others then
        rollback;

        -- 恢复状态为未结算
        update f_systemstatus
           set status = 0,
               note = '未结算';
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
    p_beginDate date:=null --从哪一天开始结算
) return number
/**
 增加返回值-101，结算日期为空
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
               note = '结算中';
  commit; --此处提交是为了结算中状态外围能看到。

   --对财务系统状态表加锁，防止财务结算并发
   select b_date,status into v_b_date,v_status from F_systemstatus for update;

  --结算开始
  SP_F_ClearAction_Done(p_actionid => 0);

  --抽取电脑凭证
  v_rtn := FN_F_ExtractVoucher();
  SP_F_ClearAction_Done(p_actionid => 1);

  if p_beginDate is not null then
   v_beginDate:=trunc(p_beginDate);
  else
    v_beginDate:= trunc(sysdate);
  end if;
 /* --最近结算日
  select nvl(max(b_date),to_date('2000-01-01','yyyy-MM-dd')) into v_lastDate from f_dailybalance;
  --如果有新加入最近结算日的凭证，最近结算日提前一天。
  select count(*) into v_cnt from f_voucher where b_date=v_lastDate and status='audited';
  if(v_cnt>0) then
    v_lastDate:=v_lastDate-1;
  end if;

  if(v_beginDate is null) then
    v_beginDate := v_lastDate + 1;
  else
    --判断指定结算日期和最后结算日间是否有凭证，如果有从最近结算日后一天开始
    select count(*) into v_cnt from f_voucher where b_date>v_lastDate and b_date<p_beginDate;
    if(v_cnt>0) then
      v_beginDate := v_lastDate + 1;
    end if;
  end if;*/

  --归属流水及凭证日期
  update f_fundflow set b_date=v_beginDate;
  update f_voucher set b_date=v_beginDate where status='audited';
  SP_F_ClearAction_Done(p_actionid => 2);



  insert into f_log
    (occurtime, type, userid, description)
  values
    (sysdate, 'sysinfo', 'system', 'Balance specify date:'||nvl(to_char(p_beginDate,'yyyy-MM-dd'),'No')||' ->exec date:'||to_char(v_beginDate,'yyyy-MM-dd'));

  --将凭证记入会计账簿
  SP_F_PutVoucherToBook(v_beginDate);
  SP_F_ClearAction_Done(p_actionid => 3);
  --结算账户
  SP_F_BalanceAccount(v_beginDate);
  SP_F_ClearAction_Done(p_actionid => 4);
  --生成客户总账
  SP_F_ClientLedger(v_beginDate);
  SP_F_ClearAction_Done(p_actionid => 5);


  --插入历史流水表
  insert into f_h_fundflow
  select * from f_fundflow where b_date is not null;
  --删除当前流水表记录
  delete from F_Fundflow where b_date is not null;

  --插入冻结资金历史流水表
  insert into f_h_frozenfundflow
  select * from f_frozenfundflow;

  --删除当前的冻结资金流水表
  delete from f_frozenfundflow;
  SP_F_ClearAction_Done(p_actionid => 6);


  update F_systemstatus
           set b_date = v_beginDate,
               status = 2,
               note = '结算完成',
               cleartime = sysdate;
 SP_F_ClearAction_Done(p_actionid => 7);
  return 1;
 exception
    when others then
        rollback;

        -- 恢复状态为未结算
        update f_systemstatus
           set status = 0,
               note = '未结算';
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
    p_FirmID m_firm.firmid%type --交易商代码
)
return integer is
  /**
  * 银行系统添加交易商
  * 返回值： 1 成功
  **/
  v_cnt                number(4); --数字变量
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
    p_FirmID   m_firm.firmid%type --交易商代码
)
return integer is
  /**
  * 删除交易商
  * 返回值： 1 成功
  **/
  v_cnt                number(4); --数字变量
  v_firmstatus         F_B_FIRMUSER.status%type; --交易商状态
  RET_TradeModuleError integer := -901;--与errorInfo配合使用
begin
  --检查交易商是否存在签约信息
  select count(*) into v_cnt from F_B_FIRMIDANDACCOUNT where isOpen=1 and firmid=p_FirmID;
  if (v_cnt > 0) then
    return -1;
  end if;

  --检查交易商是否存在
  select count(*) into v_cnt from F_B_FIRMUSER where firmid=p_FirmID;
  if (v_cnt = 0) then
    return 1;
  end if;

  --检查交易商状态
  select status into v_firmstatus from F_B_FIRMUSER where firmid=p_FirmID;
  if (v_firmstatus = 1) then
	return 1;
  end if;

  --注销交易商
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
 * 远期结算
 * 返回：-1:远期结算不成功
 *       -2：存在小于等于远期当前结算日的流水，未设结算日
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
    p_FirmID m_firm.firmid%type --交易商代码
)
return integer is
  /**
  * 现货系统添加交易商
  * 返回值： 1 成功
  **/
  v_cnt                number(4); --数字变量
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
    p_FirmID   m_firm.firmid%type--交易商代码
)
return integer is
  /**
  * 删除交易商
  * 返回值： 1 成功
  *          -900 资金不为0
  **/
 -- v_cnt                number(4); --数字变量
  v_balance      f_firmfunds.balance%type;
  RET_FundNotZero integer := -901;

begin

   select balance - frozenfunds into v_balance from f_firmfunds where firmid = p_FirmID;
   if(v_balance <>0) then
            return RET_FundNotZero;
   end if;

  /*---mengyu 2013.8.29 注销交易商表数据不变也不删除--start-*/
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
   /*---mengyu 2013.8.29 注销交易商表数据不变也不删除--end-*/
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
 /*---mengyu 2013.8.29 注销交易商表数据不变也不删除--start-*/
 -- delete from f_firmfunds where firmid=p_FirmID;

 -- update f_accountbook set debitcode=debitcode||'_' where debitcode in ('200100'||p_FirmID/*, '20101'||p_FirmID*/);
 -- update f_accountbook set creditcode=creditcode||'_' where creditcode in ('200100'||p_FirmID/*, '20101'||p_FirmID*/);
 -- update f_clientledger set firmid=firmid||'_' where firmid=p_FirmID;
 -- update f_dailybalance set accountcode=accountcode||'_' where accountcode in ('200100'||p_FirmID/*, '20101'||p_FirmID*/);
 -- update f_firmbalance set firmid=firmid||'_' where firmid=p_FirmID;
 -- update f_h_fundflow set firmid=firmid||'_' where firmid=p_FirmID;
 -- update f_voucherentry set accountcode=accountcode||'_' where accountcode in ('200100'||p_FirmID/*, '20101'||p_FirmID*/);
 /*---mengyu 2013.8.29 注销交易商表数据不变也不删除--end-*/
  return 1;
end;
/

prompt
prompt Creating function FN_F_FIRMTOSTATUS
prompt ===================================
prompt
create or replace function FN_F_FirmToStatus
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
prompt Creating function FN_F_GETREALFUNDS
prompt ===================================
prompt
create or replace function FN_F_GetRealFunds
(
  p_firmid varchar2,   --交易商代码
  p_lock number      --是否上锁 1:上锁 0：不上锁
) return number
/***
 * 获取可用资金
 * version 1.0.0.1 公用方法
 * 返回值：可用余额
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
  p_endAuditTime date, --审核时间截止时间
  p_b_date date --归属结算日
)
return number
as
/***
 * 凭证划分结算日
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
  p_firmid varchar2,   --交易商代码
  p_amount number,     --发生额（正值增加，负值减少）
  p_moduleID char   --交易模块ID 15：远期 23：现货 21：竞价
)  return number
/***
 * 更新冻结资金
 * version 1.0.0.1 此方法公用
 *
 * 返回值：冻结资金余额
 ****/
is
  v_frozenfunds number(15,2);
  v_moduleFrozenfunds number(15,2);
begin
  update f_firmfunds set frozenfunds=frozenfunds + p_amount where firmid=p_firmid
  returning frozenfunds into v_frozenfunds;
  if(SQL%ROWCOUNT = 0) then
    Raise_application_error(-21001, 'FirmID not existed !'); --不存在的交易商代码
  end if;

  update f_frozenfunds set frozenfunds=frozenfunds + p_amount where moduleid=p_moduleID and firmid=p_firmid;
  if(SQL%ROWCOUNT = 0) then
    insert into f_frozenfunds
      (moduleid, firmid, frozenfunds)
    values
      (p_moduleID, p_FirmID, p_amount);
  end if;

  --不允许银行接口将冻结资金减为负值
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
  p_firmID varchar2,     --交易商代码
  p_oprcode char,         --业务代码
  p_amount number,       --发生额
  p_contractNo varchar2  --成交合同号
) return number
/***
 * 更新资金
 * version 1.0.0.1 此方法公用
 *
 * 返回值：资金余额
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
 * 计算交易商权益
****/
as
  v_lastDate     date;           -- 上一个结算日
  v_cnt          number(4);      --数字变量
  v_sumFirmFee   number(15, 2);  -- 交易商手续费合计
  v_sumFL        number(15, 2);  -- 交易商订货盈亏合计
  v_sumBalance   number(15, 2);  -- 交易商权益计算费用合计
begin

   -- 更新银行清算权益计算费用

        -- 删除银行清算权益计算费用表的当日数据
        delete from F_FirmRightsComputeFunds where b_date = p_beginDate;

        -- 取得银行清算权益计算费用表的上一个结算日
        select max(b_Date) into v_lastDate from F_FirmRightsComputeFunds;

        if(v_lastDate is null) then
          v_lastDate := to_date('2000-01-01','yyyy-MM-dd');
        end if;

       -- 将交易商当前资金表的交易商和银行清算总账费用配置表中费用类型是权益计算费用的总账代码链表
       -- 插入银行清算权益计算费用表作为当日的初始数据
       insert into F_FirmRightsComputeFunds(B_date, Firmid, Code)
         select p_beginDate,f.firmid, bc.ledgercode
         from f_firmfunds f,F_BankClearLedgerConfig bc
         where bc.feetype = 1;

        for firmRights in (select b_date, firmId, code from F_FirmRightsComputeFunds where b_date = p_beginDate)
        loop
            -- 更新银行清算权益计算费用表的上日余额
            update F_FirmRightsComputeFunds f
            set lastBalance = nvl((select balance
                 from F_FirmRightsComputeFunds where b_date = v_lastDate and firmId = firmRights.firmId and code = firmRights.code ), 0)
            where b_date = firmRights.b_date and firmId = firmRights.firmId and code = firmRights.code;

            -- 更新银行清算权益计算费用表的当日余额
            update F_FirmRightsComputeFunds f
            set balance = nvl((select bc.fieldsign*c.value as amount
                               from f_clientledger c, f_bankclearledgerconfig bc
                               where c.b_date = firmRights.b_date and c.firmId = firmRights.firmId and c.code = firmRights.code and c.code = bc.ledgercode ), 0)
            where b_date = firmRights.b_date and firmId = firmRights.firmId and code = firmRights.code;

            -- 更新银行清算权益计算费用表的当日余额为：当日余额 + 上日余额
            --（这样就可以不用到交易系统中去取这些资金项）
            update F_FirmRightsComputeFunds f
            set balance = balance + lastBalance
            where b_date = firmRights.b_date and firmId = firmRights.firmId and code = firmRights.code;

        end loop;


   -- 更新交易商清算资金

     -- 删除交易商清算资金表的当日数据
     delete from F_FirmClearFunds where b_date = p_beginDate;

     -- 将交易商当前资金表的余额插入交易商清算资金表
     insert into F_FirmClearFunds(B_date, Firmid, Balance)
     select p_beginDate, f.firmid, f.balance from f_firmfunds f;

     for firmClearFunds in (select b_date, firmId from F_FirmClearFunds where b_date = p_beginDate)
     loop
         -- 计算交易商手续费
         select nvl(sum(value), 0) sumFirmFee into v_sumFirmFee
         from F_ClientLedger c
         where b_date = firmClearFunds.b_date and firmId = firmClearFunds.firmId
         and c.code in (select LedgerCode from F_BankClearLedgerConfig where FeeType = 0);

           -- 更新交易商清算资金表的交易商手续费
           update F_FirmClearFunds
           set firmFee = v_sumFirmFee
           where b_date = firmClearFunds.b_date and firmId = firmClearFunds.firmId;

         -- 计算市场手续费

         -- 计算交易商权益冻结资金

            -- 统计银行清算权益计算费用的当日余额
            select nvl(sum(Balance), 0) sumBalance into v_sumBalance from F_FirmRightsComputeFunds where b_date = firmClearFunds.b_date and firmId = firmClearFunds.firmId;

            -- 判断是否启用订单系统
            select count(*) into v_cnt from c_trademodule where moduleId = 15 and isbalancecheck = 'Y';
            if(v_cnt > 0) then

               -- 统计订单持仓盈亏
               select nvl(sum(FloatingLoss), 0) sumFL into v_sumFL from T_H_FirmHoldSum t where t.cleardate = firmClearFunds.b_date and t.firmid = firmClearFunds.firmId;

               update F_FirmClearFunds
               set RightsFrozenFunds = v_sumBalance + v_sumFL
               where b_date = firmClearFunds.b_date and firmId = firmClearFunds.firmId;

            else
               update F_FirmClearFunds
               set RightsFrozenFunds = v_sumBalance
               where b_date = firmClearFunds.b_date and firmId = firmClearFunds.firmId;

            end if;

         -- 计算交易商权益
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
 检查财务结算状态存储
 存储说明：凡是进行初始化的系统
 需先调用本存储，对财务系统进行初始化

**********************/
v_status F_systemstatus.Status%type;
begin
  --1.检查财务系统交易状态
  begin
     select status into v_status  from F_systemstatus t where rownum < 2;
  exception
     when NO_DATA_FOUND then
       return;
  end;
  --2.如果状态不为结算完成状态，即返回
  if(v_status <> 2) then
    return;
  end if;

  --3.如果状态为结算完成，即修改状态为未结算
  update F_systemstatus set status = 0,note = '未结算';
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
  p_moduleID char   --交易模块ID 2：远期 3：现货 4：竞价
)
/***
 * 更新冻结资金
 * version 1.0.0.1 此方法公用
 *
 * 返回值：冻结资金余额
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
