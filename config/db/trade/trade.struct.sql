--------------------------------------------------
-- Export file for user TRADE_GNNT@SPOT.DEV.183 --
-- Created by hxx on 2015/11/16, 23:01:04 --------
--------------------------------------------------

set define off
spool trade.struct.log

prompt
prompt Creating table T_APPLY
prompt ======================
prompt
create table T_APPLY
(
  id          NUMBER(10) not null,
  applytype   NUMBER(4) not null,
  status      NUMBER(4) not null,
  proposer    VARCHAR2(64) not null,
  applytime   DATE default sysdate not null,
  approver    VARCHAR2(64),
  approvetime DATE,
  content     SYS.XMLTYPE not null,
  note        VARCHAR2(1024)
)
;
alter table T_APPLY
  add constraint T_APPLY_PK primary key (ID);

prompt
prompt Creating table T_A_BREED
prompt ========================
prompt
create table T_A_BREED
(
  breedid               NUMBER(10) not null,
  breedname             VARCHAR2(32) not null,
  sortid                NUMBER(10) not null,
  contractfactor        NUMBER(12,2),
  minpricemove          NUMBER(10,2) not null,
  spreadalgr            NUMBER(1) not null,
  spreaduplmt           NUMBER(10,2) not null,
  spreaddownlmt         NUMBER(10,2) not null,
  feealgr               NUMBER(1) not null,
  feerate_b             NUMBER(15,9) not null,
  feerate_s             NUMBER(15,9) not null,
  marginalgr            NUMBER(1) not null,
  marginrate_b          NUMBER(10,4) default 0 not null,
  marginrate_s          NUMBER(10,4) default 0 not null,
  marginassure_b        NUMBER(10,4) default 0 not null,
  marginassure_s        NUMBER(10,4) default 0 not null,
  todayclosefeerate_b   NUMBER(15,9) default 0 not null,
  todayclosefeerate_s   NUMBER(15,9) default 0 not null,
  historyclosefeerate_b NUMBER(15,9) default 0 not null,
  historyclosefeerate_s NUMBER(15,9) default 0 not null,
  limitcmdtyqty         NUMBER(10) default -1 not null,
  settlefeealgr         NUMBER(1) not null,
  settlefeerate_b       NUMBER(15,9) default 0 not null,
  settlefeerate_s       NUMBER(15,9) default 0 not null,
  forceclosefeealgr     NUMBER(1) not null,
  forceclosefeerate_b   NUMBER(15,9) default 0 not null,
  forceclosefeerate_s   NUMBER(15,9) default 0 not null,
  settlemarginalgr_b    NUMBER(1) not null,
  settlemarginrate_b    NUMBER(10,4) default 0 not null,
  settlemarginalgr_s    NUMBER(1) not null,
  settlemarginrate_s    NUMBER(10,4) default 0 not null,
  addedtax              NUMBER(10,4) default 0 not null,
  marginpricetype       NUMBER(1) default 0 not null,
  lowestsettlefee       NUMBER(15,2) default 0 not null,
  limitbreedqty         NUMBER(10) default -1 not null,
  firmcleanqty          NUMBER(10) default -1 not null,
  firmmaxholdqty        NUMBER(10) default -1 not null,
  marginitem1           NUMBER(15,2),
  marginitem2           NUMBER(15,2),
  marginitem3           NUMBER(15,2),
  marginitem4           NUMBER(15,2),
  marginitem1_s         NUMBER(15,2),
  marginitem2_s         NUMBER(15,2),
  marginitem3_s         NUMBER(15,2),
  marginitem4_s         NUMBER(15,2),
  marginitemassure1     NUMBER(15,2),
  marginitemassure2     NUMBER(15,2),
  marginitemassure3     NUMBER(15,2),
  marginitemassure4     NUMBER(15,2),
  marginitemassure1_s   NUMBER(15,2),
  marginitemassure2_s   NUMBER(15,2),
  marginitemassure3_s   NUMBER(15,2),
  marginitemassure4_s   NUMBER(15,2),
  orderprivilege        NUMBER(6) default 101 not null,
  payoutalgr            NUMBER(1) not null,
  payoutrate            NUMBER(10,4) default 0 not null,
  addedtaxfactor        NUMBER(13,10) default 0 not null,
  marginitem5           NUMBER(15,2),
  marginitem5_s         NUMBER(15,2),
  marginitemassure5     NUMBER(15,2),
  marginitemassure5_s   NUMBER(15,2),
  settlepricetype       NUMBER(2) default 0 not null,
  beforedays            NUMBER(4),
  specsettleprice       NUMBER(10,2),
  firmmaxholdqtyalgr    NUMBER(1) default 2 not null,
  startpercentqty       NUMBER(10) default 0 not null,
  maxpercentlimit       NUMBER(7,4) default 0 not null,
  onemaxholdqty         NUMBER(10) default -1 not null,
  minquantitymove       NUMBER(3) default 1 not null,
  contractfactorname    VARCHAR2(10),
  delayrecouprate       NUMBER(7,5) default 0 not null,
  settleway             NUMBER(2) default 0 not null,
  delayfeeway           NUMBER(2) default 1 not null,
  maxfeerate            NUMBER(15,9),
  minsettlemoveqty      NUMBER(5) default 1 not null,
  breedtrademode        NUMBER(2) default 0 not null,
  storerecouprate       NUMBER(7,5) default 0 not null,
  minsettleqty          NUMBER(10) default 1 not null,
  delayrecouprate_s     NUMBER(7,5) default 0 not null,
  delaysettlepricetype  NUMBER(2) default 0,
  aheadsettlepricetype  NUMBER(2) default 0,
  settlemargintype      NUMBER(2) default 0,
  beforedays_m          NUMBER(2) default 0,
  sideholdlimitqty      NUMBER(10) default -1,
  holddayslimit         NUMBER(1) default 0 not null,
  maxholdpositionday    NUMBER(10)
)
;
alter table T_A_BREED
  add constraint PK_T_A_BREED primary key (BREEDID);

prompt
prompt Creating table T_A_BREEDTRADEPROP
prompt =================================
prompt
create table T_A_BREEDTRADEPROP
(
  breedid    NUMBER(10) not null,
  sectionid  NUMBER(4) not null,
  modifytime DATE not null
)
;
alter table T_A_BREEDTRADEPROP
  add constraint PK_T_A_BREEDTRADEPROP primary key (BREEDID, SECTIONID);

prompt
prompt Creating table T_A_CMDTYSORT
prompt ============================
prompt
create table T_A_CMDTYSORT
(
  sortid   NUMBER(10) not null,
  sortname VARCHAR2(30) not null
)
;
alter table T_A_CMDTYSORT
  add constraint PK_T_A_CMDTYSORT primary key (SORTID);

prompt
prompt Creating table T_A_COMMODITYSETTLEPROP
prompt ======================================
prompt
create table T_A_COMMODITYSETTLEPROP
(
  commodityid VARCHAR2(16) not null,
  sectionid   NUMBER(4) not null,
  modifytime  DATE not null
)
;
alter table T_A_COMMODITYSETTLEPROP
  add constraint PK_T_A_COMMODITYSETTLEPROP primary key (COMMODITYID, SECTIONID);

prompt
prompt Creating table T_A_COMMODITYTRADEPROP
prompt =====================================
prompt
create table T_A_COMMODITYTRADEPROP
(
  commodityid VARCHAR2(16) not null,
  sectionid   NUMBER(4) not null,
  modifytime  DATE not null
)
;
alter table T_A_COMMODITYTRADEPROP
  add constraint PK_T_A_COMMODITYTRADEPROP primary key (COMMODITYID, SECTIONID);

prompt
prompt Creating table T_A_DAYSECTION
prompt =============================
prompt
create table T_A_DAYSECTION
(
  weekday    NUMBER(2) not null,
  sectionid  NUMBER(4) not null,
  status     NUMBER(2) default 0 not null,
  modifytime DATE not null
)
;
alter table T_A_DAYSECTION
  add constraint PK_T_A_DAYSECTION primary key (WEEKDAY, SECTIONID);

prompt
prompt Creating table T_A_DELAYTRADETIME
prompt =================================
prompt
create table T_A_DELAYTRADETIME
(
  sectionid  NUMBER(4) not null,
  name       VARCHAR2(20),
  starttime  VARCHAR2(10) not null,
  endtime    VARCHAR2(10) not null,
  type       NUMBER(2) default 0 not null,
  status     NUMBER(2) not null,
  modifytime DATE not null
)
;
alter table T_A_DELAYTRADETIME
  add constraint PK_T_A_DELAYTRADETIME primary key (SECTIONID);

prompt
prompt Creating table T_A_FIRMBREEDFEE
prompt ===============================
prompt
create table T_A_FIRMBREEDFEE
(
  firmid                VARCHAR2(32) not null,
  breedid               NUMBER(10) not null,
  feealgr               NUMBER(1) not null,
  feerate_b             NUMBER(15,9) not null,
  feerate_s             NUMBER(15,9) not null,
  todayclosefeerate_b   NUMBER(15,9) default 0 not null,
  todayclosefeerate_s   NUMBER(15,9) default 0 not null,
  historyclosefeerate_b NUMBER(15,9) default 0 not null,
  historyclosefeerate_s NUMBER(15,9) default 0 not null,
  forceclosefeealgr     NUMBER(1) not null,
  forceclosefeerate_b   NUMBER(15,9) default 0 not null,
  forceclosefeerate_s   NUMBER(15,9) default 0 not null,
  modifytime            DATE not null
)
;
alter table T_A_FIRMBREEDFEE
  add constraint PK_T_A_FIRMBREEDFEE primary key (FIRMID, BREEDID);

prompt
prompt Creating table T_A_FIRMBREEDMARGIN
prompt ==================================
prompt
create table T_A_FIRMBREEDMARGIN
(
  firmid              VARCHAR2(32) not null,
  breedid             NUMBER(10) not null,
  marginalgr          NUMBER(1) not null,
  marginrate_b        NUMBER(10,4) default 0 not null,
  marginrate_s        NUMBER(10,4) default 0 not null,
  marginitem1         NUMBER(15,2),
  marginitem2         NUMBER(15,2),
  marginitem3         NUMBER(15,2),
  marginitem4         NUMBER(15,2),
  marginitem1_s       NUMBER(15,2),
  marginitem2_s       NUMBER(15,2),
  marginitem3_s       NUMBER(15,2),
  marginitem4_s       NUMBER(15,2),
  marginassure_b      NUMBER(10,4) default 0 not null,
  marginassure_s      NUMBER(10,4) default 0 not null,
  marginitemassure1   NUMBER(15,2),
  marginitemassure2   NUMBER(15,2),
  marginitemassure3   NUMBER(15,2),
  marginitemassure4   NUMBER(15,2),
  marginitemassure1_s NUMBER(15,2),
  marginitemassure2_s NUMBER(15,2),
  marginitemassure3_s NUMBER(15,2),
  marginitemassure4_s NUMBER(15,2),
  modifytime          DATE not null,
  marginitem5         NUMBER(15,2),
  marginitem5_s       NUMBER(15,2),
  marginitemassure5   NUMBER(15,2),
  marginitemassure5_s NUMBER(15,2)
)
;
alter table T_A_FIRMBREEDMARGIN
  add constraint PK_T_A_FIRMBREEDMARGIN primary key (FIRMID, BREEDID);

prompt
prompt Creating table T_A_FIRMBREEDMAXHOLDQTY
prompt ======================================
prompt
create table T_A_FIRMBREEDMAXHOLDQTY
(
  firmid          VARCHAR2(32) not null,
  breedid         NUMBER(10) not null,
  maxholdqty      NUMBER(10) default -1 not null,
  cleanmaxholdqty NUMBER(10) default -1 not null,
  modifytime      DATE not null
)
;
alter table T_A_FIRMBREEDMAXHOLDQTY
  add constraint PK_T_A_FIRMBREEDMAXHOLDQTY primary key (FIRMID, BREEDID);

prompt
prompt Creating table T_A_FIRMBREEDSETTLEFEE
prompt =====================================
prompt
create table T_A_FIRMBREEDSETTLEFEE
(
  firmid          VARCHAR2(32) not null,
  breedid         NUMBER(10) not null,
  settlefeealgr   NUMBER(1) not null,
  settlefeerate_b NUMBER(15,9) default 0 not null,
  settlefeerate_s NUMBER(15,9) default 0 not null,
  modifytime      DATE not null
)
;
alter table T_A_FIRMBREEDSETTLEFEE
  add constraint PK_T_A_FIRMBREEDSETTLEFEE primary key (FIRMID, BREEDID);

prompt
prompt Creating table T_A_FIRMBREEDSETTLEMARGIN
prompt ========================================
prompt
create table T_A_FIRMBREEDSETTLEMARGIN
(
  firmid             VARCHAR2(32) not null,
  breedid            NUMBER(10) not null,
  settlemarginalgr_b NUMBER(1) not null,
  settlemarginrate_b NUMBER(10,4) default 0 not null,
  settlemarginalgr_s NUMBER(1) not null,
  settlemarginrate_s NUMBER(10,4) default 0 not null,
  payoutalgr         NUMBER(1) not null,
  payoutrate         NUMBER(10,4) default 0 not null,
  modifytime         DATE not null
)
;
alter table T_A_FIRMBREEDSETTLEMARGIN
  add constraint PK_T_A_FIRMBREEDSETTLEMARGIN primary key (FIRMID, BREEDID);

prompt
prompt Creating table T_A_FIRMFEE
prompt ==========================
prompt
create table T_A_FIRMFEE
(
  firmid                VARCHAR2(32) not null,
  commodityid           VARCHAR2(16) not null,
  feealgr               NUMBER(1) not null,
  feerate_b             NUMBER(15,9) not null,
  feerate_s             NUMBER(15,9) not null,
  todayclosefeerate_b   NUMBER(15,9) default 0 not null,
  todayclosefeerate_s   NUMBER(15,9) default 0 not null,
  historyclosefeerate_b NUMBER(15,9) default 0 not null,
  historyclosefeerate_s NUMBER(15,9) default 0 not null,
  forceclosefeealgr     NUMBER(1) not null,
  forceclosefeerate_b   NUMBER(15,9) default 0 not null,
  forceclosefeerate_s   NUMBER(15,9) default 0 not null,
  modifytime            DATE not null
)
;
alter table T_A_FIRMFEE
  add constraint PK_T_A_FIRMFEE primary key (FIRMID, COMMODITYID);

prompt
prompt Creating table T_A_FIRMMARGIN
prompt =============================
prompt
create table T_A_FIRMMARGIN
(
  firmid              VARCHAR2(32) not null,
  commodityid         VARCHAR2(16) not null,
  marginalgr          NUMBER(1) not null,
  marginrate_b        NUMBER(10,4) default 0 not null,
  marginrate_s        NUMBER(10,4) default 0 not null,
  marginitem1         NUMBER(15,2),
  marginitem2         NUMBER(15,2),
  marginitem3         NUMBER(15,2),
  marginitem4         NUMBER(15,2),
  marginitem1_s       NUMBER(15,2),
  marginitem2_s       NUMBER(15,2),
  marginitem3_s       NUMBER(15,2),
  marginitem4_s       NUMBER(15,2),
  marginassure_b      NUMBER(10,4) default 0 not null,
  marginassure_s      NUMBER(10,4) default 0 not null,
  marginitemassure1   NUMBER(15,2),
  marginitemassure2   NUMBER(15,2),
  marginitemassure3   NUMBER(15,2),
  marginitemassure4   NUMBER(15,2),
  marginitemassure1_s NUMBER(15,2),
  marginitemassure2_s NUMBER(15,2),
  marginitemassure3_s NUMBER(15,2),
  marginitemassure4_s NUMBER(15,2),
  modifytime          DATE not null,
  marginitem5         NUMBER(15,2),
  marginitem5_s       NUMBER(15,2),
  marginitemassure5   NUMBER(15,2),
  marginitemassure5_s NUMBER(15,2)
)
;
alter table T_A_FIRMMARGIN
  add constraint PK_T_A_FIRMMARGIN primary key (FIRMID, COMMODITYID);

prompt
prompt Creating table T_A_FIRMMAXHOLDQTY
prompt =================================
prompt
create table T_A_FIRMMAXHOLDQTY
(
  firmid          VARCHAR2(32) not null,
  commodityid     VARCHAR2(16) not null,
  maxholdqty      NUMBER(10) default -1 not null,
  cleanmaxholdqty NUMBER(10) default -1 not null,
  modifytime      DATE not null
)
;
alter table T_A_FIRMMAXHOLDQTY
  add constraint PK_T_A_FIRMMAXHOLDQTY primary key (FIRMID, COMMODITYID);

prompt
prompt Creating table T_A_FIRMSETTLEFEE
prompt ================================
prompt
create table T_A_FIRMSETTLEFEE
(
  firmid          VARCHAR2(32) not null,
  commodityid     VARCHAR2(16) not null,
  settlefeealgr   NUMBER(1) not null,
  settlefeerate_b NUMBER(15,9) default 0 not null,
  settlefeerate_s NUMBER(15,9) default 0 not null,
  modifytime      DATE not null
)
;
alter table T_A_FIRMSETTLEFEE
  add constraint PK_T_A_FIRMSETTLEFEE primary key (FIRMID, COMMODITYID);

prompt
prompt Creating table T_A_FIRMSETTLEMARGIN
prompt ===================================
prompt
create table T_A_FIRMSETTLEMARGIN
(
  firmid             VARCHAR2(32) not null,
  commodityid        VARCHAR2(16) not null,
  settlemarginalgr_b NUMBER(1) not null,
  settlemarginrate_b NUMBER(10,4) default 0 not null,
  settlemarginalgr_s NUMBER(1) not null,
  settlemarginrate_s NUMBER(10,4) default 0 not null,
  payoutalgr         NUMBER(1) not null,
  payoutrate         NUMBER(10,4) default 0 not null,
  modifytime         DATE not null
)
;
alter table T_A_FIRMSETTLEMARGIN
  add constraint PK_T_A_FIRMSETTLEMARGIN primary key (FIRMID, COMMODITYID);

prompt
prompt Creating table T_A_MARKET
prompt =========================
prompt
create table T_A_MARKET
(
  marketcode              CHAR(2) not null,
  marketname              VARCHAR2(64),
  status                  NUMBER(2) default 1 not null,
  shortname               VARCHAR2(20),
  runmode                 NUMBER(2) default 1 not null,
  settlemode              NUMBER(2) default 0 not null,
  marginfbflag            NUMBER(1) default 0 not null,
  floatinglosscomputetype NUMBER(1) default 0 not null,
  closealgr               NUMBER(2) default 0 not null,
  tradepricealgr          NUMBER(2) default 0 not null,
  tradeflowtype           NUMBER(2) default 0 not null,
  floatingprofitsubtax    NUMBER(1) default 0 not null,
  gagemode                NUMBER(2) default 0 not null,
  tradetimetype           NUMBER(2) default 0 not null,
  delayquoshowtype        NUMBER(2) default 1 not null,
  neutralfeeway           NUMBER(2) default 0 not null,
  delayneedbill           NUMBER(2) default 0 not null,
  neutralflag             NUMBER(2) default 0 not null,
  neutralmatchpriority    NUMBER(2) default 0 not null,
  quotationtwoside        NUMBER(2) default 2 not null,
  asmargintype            NUMBER(2) default 0,
  delayorderispure        NUMBER(1) default 0 not null,
  chargedelayfeetype      NUMBER(2) default 0 not null
)
;
alter table T_A_MARKET
  add constraint PK_T_A_MARKET primary key (MARKETCODE);

prompt
prompt Creating table T_A_NOTTRADEDAY
prompt ==============================
prompt
create table T_A_NOTTRADEDAY
(
  id         NUMBER(10) not null,
  week       VARCHAR2(30),
  day        VARCHAR2(1024),
  modifytime DATE not null
)
;
alter table T_A_NOTTRADEDAY
  add constraint PK_T_A_NOTTRADEDAY primary key (ID);

prompt
prompt Creating table T_A_SETTLEPRIVILEGE
prompt ==================================
prompt
create table T_A_SETTLEPRIVILEGE
(
  id              NUMBER(15) not null,
  type            NUMBER(2) not null,
  typeid          VARCHAR2(16) not null,
  kind            NUMBER(2),
  kindid          VARCHAR2(24),
  privilegecode_b NUMBER(6) not null,
  privilegecode_s NUMBER(6) not null
)
;
alter table T_A_SETTLEPRIVILEGE
  add constraint PK_T_A_SETTLEPRIVILEGE primary key (ID);

prompt
prompt Creating table T_A_TARIFF
prompt =========================
prompt
create table T_A_TARIFF
(
  tariffid              VARCHAR2(6) not null,
  commodityid           VARCHAR2(16) not null,
  tariffname            VARCHAR2(32) not null,
  tariffrate            NUMBER(10,2) not null,
  feealgr               NUMBER(1) not null,
  feerate_b             NUMBER(15,9) not null,
  feerate_s             NUMBER(15,9) not null,
  todayclosefeerate_b   NUMBER(15,9) not null,
  todayclosefeerate_s   NUMBER(15,9) not null,
  historyclosefeerate_b NUMBER(15,9) not null,
  historyclosefeerate_s NUMBER(15,9) not null,
  forceclosefeealgr     NUMBER(1) not null,
  forceclosefeerate_b   NUMBER(15,9) not null,
  forceclosefeerate_s   NUMBER(15,9) not null,
  createtime            DATE default sysdate not null,
  createuser            VARCHAR2(32),
  modifytime            DATE default sysdate not null
)
;
alter table T_A_TARIFF
  add constraint PK_T_A_TARIFF primary key (TARIFFID, COMMODITYID);

prompt
prompt Creating table T_A_TRADEPRIVILEGE
prompt =================================
prompt
create table T_A_TRADEPRIVILEGE
(
  id              NUMBER(15) not null,
  type            NUMBER(2) not null,
  typeid          VARCHAR2(40) not null,
  kind            NUMBER(2),
  kindid          VARCHAR2(24),
  privilegecode_b NUMBER(6) not null,
  privilegecode_s NUMBER(6)
)
;
alter table T_A_TRADEPRIVILEGE
  add constraint PK_T_A_TRADEPRIVILEGE primary key (ID);

prompt
prompt Creating table T_A_TRADETIME
prompt ============================
prompt
create table T_A_TRADETIME
(
  sectionid    NUMBER(4) not null,
  name         VARCHAR2(20),
  starttime    VARCHAR2(10) not null,
  endtime      VARCHAR2(10) not null,
  status       NUMBER(2) not null,
  gatherbid    NUMBER(1) default 0 not null,
  bidstarttime VARCHAR2(10),
  bidendtime   VARCHAR2(10),
  modifytime   DATE not null,
  startdate    VARCHAR2(16),
  enddate      VARCHAR2(16),
  bidstartdate VARCHAR2(16),
  bidenddate   VARCHAR2(16)
)
;
alter table T_A_TRADETIME
  add constraint PK_T_A_TRADETIME primary key (SECTIONID);

prompt
prompt Creating table T_BALANCESTATUS
prompt ==============================
prompt
create table T_BALANCESTATUS
(
  b_date    DATE not null,
  status    NUMBER(2) not null,
  note      VARCHAR2(256),
  cleartime DATE
)
;
alter table T_BALANCESTATUS
  add constraint PK_B_DATE primary key (B_DATE);

prompt
prompt Creating table T_BILLFROZEN
prompt ===========================
prompt
create table T_BILLFROZEN
(
  id            NUMBER(15) not null,
  operation     VARCHAR2(20),
  billid        VARCHAR2(32) not null,
  operationtype NUMBER(2),
  modifytime    DATE not null
)
;
alter table T_BILLFROZEN
  add constraint PK_T_BILLFROZEN primary key (ID);

prompt
prompt Creating table T_BR_FIRMREWARDDEAIL
prompt ===================================
prompt
create table T_BR_FIRMREWARDDEAIL
(
  firmid           VARCHAR2(32) not null,
  commodityid      VARCHAR2(16) not null,
  cleardate        DATE not null,
  rewardtype       NUMBER(2) not null,
  brokerid         VARCHAR2(16) not null,
  brokername       VARCHAR2(128),
  firstpay         NUMBER(15,2) not null,
  secondpay        NUMBER(15,2) not null,
  reward           NUMBER(15,2) not null,
  marketreward     NUMBER(15,2) not null,
  brokereachdivide NUMBER(15,2) not null,
  quantity         NUMBER(10) not null,
  trademoney       NUMBER(15,2) not null,
  brokerageid      VARCHAR2(32),
  brokeragename    VARCHAR2(64)
)
;
alter table T_BR_FIRMREWARDDEAIL
  add constraint PK_T_BR_FIRMREWARDDEAIL primary key (FIRMID, COMMODITYID, CLEARDATE, REWARDTYPE);

prompt
prompt Creating table T_CLEARSTATUS
prompt ============================
prompt
create table T_CLEARSTATUS
(
  actionid   NUMBER(3) not null,
  actionnote VARCHAR2(32) not null,
  status     CHAR(1) not null,
  finishtime DATE
)
;
alter table T_CLEARSTATUS
  add constraint PK_ACTIONID primary key (ACTIONID);

prompt
prompt Creating table T_COMMODITY
prompt ==========================
prompt
create table T_COMMODITY
(
  commodityid           VARCHAR2(16) not null,
  name                  VARCHAR2(32) not null,
  sortid                NUMBER(10) not null,
  status                NUMBER(2) not null,
  contractfactor        NUMBER(12,2) not null,
  minpricemove          NUMBER(10,2) not null,
  breedid               NUMBER(10) not null,
  spreadalgr            NUMBER(1) not null,
  spreaduplmt           NUMBER(10,2) not null,
  spreaddownlmt         NUMBER(10,2) not null,
  feealgr               NUMBER(1) not null,
  feerate_b             NUMBER(15,9) not null,
  feerate_s             NUMBER(15,9) not null,
  marginalgr            NUMBER(1) not null,
  marginrate_b          NUMBER(10,4) default 0 not null,
  marginrate_s          NUMBER(10,4) default 0 not null,
  marketdate            DATE,
  settledate            DATE not null,
  settledate1           DATE,
  marginitem1           NUMBER(15,2),
  settledate2           DATE,
  marginitem2           NUMBER(15,2),
  settledate3           DATE,
  marginitem3           NUMBER(15,2),
  settledate4           DATE,
  marginitem4           NUMBER(15,2),
  lastprice             NUMBER(10,2) not null,
  marginitem1_s         NUMBER(15,2),
  marginitem2_s         NUMBER(15,2),
  marginitem3_s         NUMBER(15,2),
  marginitem4_s         NUMBER(15,2),
  marginassure_b        NUMBER(10,4) default 0 not null,
  marginassure_s        NUMBER(10,4) default 0 not null,
  marginitemassure1     NUMBER(15,2),
  marginitemassure2     NUMBER(15,2),
  marginitemassure3     NUMBER(15,2),
  marginitemassure4     NUMBER(15,2),
  marginitemassure1_s   NUMBER(15,2),
  marginitemassure2_s   NUMBER(15,2),
  marginitemassure3_s   NUMBER(15,2),
  marginitemassure4_s   NUMBER(15,2),
  todayclosefeerate_b   NUMBER(15,9) default 0 not null,
  todayclosefeerate_s   NUMBER(15,9) default 0 not null,
  historyclosefeerate_b NUMBER(15,9) default 0 not null,
  historyclosefeerate_s NUMBER(15,9) default 0 not null,
  limitcmdtyqty         NUMBER(10) default -1 not null,
  settlefeealgr         NUMBER(1) not null,
  settlefeerate_b       NUMBER(15,9) default 0 not null,
  settlefeerate_s       NUMBER(15,9) default 0 not null,
  forceclosefeealgr     NUMBER(1) not null,
  forceclosefeerate_b   NUMBER(15,9) default 0 not null,
  forceclosefeerate_s   NUMBER(15,9) default 0 not null,
  settlemarginalgr_b    NUMBER(1) not null,
  settlemarginrate_b    NUMBER(10,4) default 0 not null,
  settlemarginalgr_s    NUMBER(1) not null,
  settlemarginrate_s    NUMBER(10,4) default 0 not null,
  reservecount          NUMBER(10) default 0 not null,
  addedtax              NUMBER(10,4) default 0 not null,
  marginpricetype       NUMBER(1) default 0 not null,
  lowestsettlefee       NUMBER(15,2) default 0 not null,
  firmcleanqty          NUMBER(10) default -1 not null,
  firmmaxholdqty        NUMBER(10) default -1 not null,
  payoutalgr            NUMBER(1) not null,
  payoutrate            NUMBER(10,4) default 0 not null,
  addedtaxfactor        NUMBER(13,10) default 0 not null,
  settledate5           DATE,
  marginitem5           NUMBER(15,2),
  marginitem5_s         NUMBER(15,2),
  marginitemassure5     NUMBER(15,2),
  marginitemassure5_s   NUMBER(15,2),
  settlepricetype       NUMBER(2) default 0 not null,
  beforedays            NUMBER(4),
  specsettleprice       NUMBER(10,2),
  orderprivilege_b      NUMBER(6) default 101 not null,
  orderprivilege_s      NUMBER(6) default 101 not null,
  firmmaxholdqtyalgr    NUMBER(1) default 2 not null,
  startpercentqty       NUMBER(10) default 0 not null,
  maxpercentlimit       NUMBER(7,4) default 0 not null,
  onemaxholdqty         NUMBER(10) default -1 not null,
  minquantitymove       NUMBER(3) default 1 not null,
  delayrecouprate       NUMBER(7,5) default 0 not null,
  settleway             NUMBER(2) default 0 not null,
  delayfeeway           NUMBER(2) default 1 not null,
  maxfeerate            NUMBER(15,9),
  minsettlemoveqty      NUMBER(5) default 1 not null,
  storerecouprate       NUMBER(7,5) default 0 not null,
  minsettleqty          NUMBER(10) default 1 not null,
  delayrecouprate_s     NUMBER(7,5) default 0 not null,
  aheadsettlepricetype  NUMBER(2) default 0,
  delaysettlepricetype  NUMBER(2) default 0,
  settlemargintype      NUMBER(2) default 0,
  beforedays_m          NUMBER(2) default 0,
  sideholdlimitqty      NUMBER(10) default -1,
  holddayslimit         NUMBER(1) default 0 not null,
  maxholdpositionday    NUMBER(10),
  taxinclusive          NUMBER(1) default 1
)
;
alter table T_COMMODITY
  add constraint PK_T_COMMODITY primary key (COMMODITYID);

prompt
prompt Creating table T_CONDITIONORDER
prompt ===============================
prompt
create table T_CONDITIONORDER
(
  a_orderno            NUMBER(15) not null,
  commodityid          VARCHAR2(16) not null,
  customerid           VARCHAR2(40) not null,
  traderid             VARCHAR2(40) not null,
  bs_flag              NUMBER(2) not null,
  ordertype            NUMBER(2) not null,
  price                NUMBER(10,2) not null,
  quantity             NUMBER(10) not null,
  conditiontype        NUMBER(2),
  conditionoperation   NUMBER(2),
  conditionprice       NUMBER(10,2) not null,
  conditioncommodityid VARCHAR2(16) not null,
  firmid               VARCHAR2(32) not null,
  retcode              NUMBER(4),
  updatetime           TIMESTAMP(6),
  validdate            DATE,
  sendstatus           NUMBER(2) default 0 not null,
  successtime          TIMESTAMP(6)
)
;
alter table T_CONDITIONORDER
  add constraint PK_T_CONDITIONORDER primary key (A_ORDERNO);

prompt
prompt Creating table T_CURMINNO
prompt =========================
prompt
create table T_CURMINNO
(
  tradedate NUMBER(10) not null,
  a_orderno NUMBER(15) default 0 not null,
  a_tradeno NUMBER(15) default 0 not null,
  a_holdno  NUMBER(15) default 0 not null
)
;
alter table T_CURMINNO
  add constraint PK_T_CURMINNO primary key (TRADEDATE);

prompt
prompt Creating table T_CUSTOMER
prompt =========================
prompt
create table T_CUSTOMER
(
  customerid VARCHAR2(40) not null,
  firmid     VARCHAR2(32) not null,
  code       VARCHAR2(6) not null,
  name       VARCHAR2(16),
  status     NUMBER(2) default 0 not null,
  createtime DATE not null,
  modifytime DATE
)
;
create unique index UK_T_CUSTOMER on T_CUSTOMER (FIRMID, CODE);
alter table T_CUSTOMER
  add constraint PK_T_CUSTOMER primary key (CUSTOMERID);

prompt
prompt Creating table T_CUSTOMERHOLDSUM
prompt ================================
prompt
create table T_CUSTOMERHOLDSUM
(
  customerid    VARCHAR2(40) not null,
  commodityid   VARCHAR2(16) not null,
  bs_flag       NUMBER(2) not null,
  holdqty       NUMBER(10) not null,
  holdfunds     NUMBER(15,2) not null,
  floatingloss  NUMBER(15,2) not null,
  evenprice     NUMBER(16,6) not null,
  frozenqty     NUMBER(10) not null,
  holdmargin    NUMBER(15,2) default 0 not null,
  gageqty       NUMBER(10) default 0 not null,
  holdassure    NUMBER(15,2) default 0 not null,
  firmid        VARCHAR2(32) not null,
  gagefrozenqty NUMBER(10) default 0 not null
)
;
create index IX_T_CUSTOMERHOLDSUM on T_CUSTOMERHOLDSUM (FIRMID, COMMODITYID, BS_FLAG);
alter table T_CUSTOMERHOLDSUM
  add constraint PK_T_CUSTOMERHOLDSUM primary key (CUSTOMERID, COMMODITYID, BS_FLAG);

prompt
prompt Creating table T_DBLOG
prompt ======================
prompt
create table T_DBLOG
(
  err_date  DATE not null,
  name_proc VARCHAR2(30),
  err_code  NUMBER(10),
  err_msg   VARCHAR2(200)
)
;

prompt
prompt Creating table T_DELAYORDERS
prompt ============================
prompt
create table T_DELAYORDERS
(
  a_orderno      NUMBER(15) not null,
  commodityid    VARCHAR2(16) not null,
  customerid     VARCHAR2(40) not null,
  traderid       VARCHAR2(40),
  bs_flag        NUMBER(2) not null,
  delayordertype NUMBER(2) not null,
  status         NUMBER(2) not null,
  withdrawtype   NUMBER(2),
  quantity       NUMBER(10) not null,
  price          NUMBER(10,2),
  tradeqty       NUMBER(10) default 0,
  frozenfunds    NUMBER(15,2) default 0,
  unfrozenfunds  NUMBER(15,2) default 0,
  ordertime      DATE not null,
  withdrawtime   DATE,
  ordererip      VARCHAR2(64),
  signature      VARCHAR2(256),
  firmid         VARCHAR2(32) not null,
  consignerid    VARCHAR2(10),
  withdrawerid   VARCHAR2(40)
)
;
alter table T_DELAYORDERS
  add constraint PK_T_DELAYORDERS primary key (A_ORDERNO);

prompt
prompt Creating table T_DELAYQUOTATION
prompt ===============================
prompt
create table T_DELAYQUOTATION
(
  commodityid       VARCHAR2(16) not null,
  buysettleqty      NUMBER(10) not null,
  sellsettleqty     NUMBER(10) not null,
  buyneutralqty     NUMBER(10) not null,
  sellneutralqty    NUMBER(10) not null,
  createtime        DATE,
  neutralside       NUMBER(2) default 0 not null,
  delaycleanholdqty NUMBER(10) default 0 not null
)
;
alter table T_DELAYQUOTATION
  add constraint PK_T_DELAYQUOTATION primary key (COMMODITYID);

prompt
prompt Creating table T_DELAYSTATUS
prompt ============================
prompt
create table T_DELAYSTATUS
(
  tradedate   DATE not null,
  status      NUMBER(2) default 3 not null,
  sectionid   NUMBER(4),
  note        VARCHAR2(256),
  recovertime VARCHAR2(10)
)
;
alter table T_DELAYSTATUS
  add constraint PK_T_DELAYSTATUS primary key (TRADEDATE);

prompt
prompt Creating table T_DELAYTRADE
prompt ===========================
prompt
create table T_DELAYTRADE
(
  a_tradeno      NUMBER(15) not null,
  a_orderno      NUMBER(15) not null,
  tradetime      DATE not null,
  customerid     VARCHAR2(40) not null,
  commodityid    VARCHAR2(16) not null,
  bs_flag        NUMBER(2) not null,
  delayordertype NUMBER(2) not null,
  quantity       NUMBER(10) not null,
  tradetype      NUMBER(2) not null,
  firmid         VARCHAR2(32) not null
)
;
alter table T_DELAYTRADE
  add constraint PK_T_DELAYTRADE primary key (A_TRADENO);

prompt
prompt Creating table T_D_DELAYORDERLOG
prompt ================================
prompt
create table T_D_DELAYORDERLOG
(
  id           NUMBER(15) not null,
  firmid       VARCHAR2(32) not null,
  ordertype    NUMBER(2) not null,
  commodityid  VARCHAR2(16) not null,
  a_holdno     NUMBER(15) not null,
  settleprice  NUMBER(15) not null,
  quantity     NUMBER(15,2) not null,
  settlemargin NUMBER(15,2) default 0 not null,
  trademargin  NUMBER(15,2) not null,
  payout       NUMBER(15) not null,
  actiontime   DATE not null,
  expandxml    VARCHAR2(65)
)
;
alter table T_D_DELAYORDERLOG
  add constraint PK_T_D_DELAYORDERLOG primary key (ID);

prompt
prompt Creating table T_D_DELAYORDERSUMLOG
prompt ===================================
prompt
create table T_D_DELAYORDERSUMLOG
(
  id           NUMBER(15) not null,
  firmid       VARCHAR2(32) not null,
  ordertype    NUMBER(2) not null,
  commodityid  VARCHAR2(16) not null,
  settleprice  NUMBER(15,2) not null,
  quantity     NUMBER(15,2) not null,
  settlemargin NUMBER(15,2) default 0 not null,
  trademargin  NUMBER(15,2) not null,
  payout       NUMBER(15) not null,
  a_funds      NUMBER(15,2) not null,
  f_funds      NUMBER(15,2) not null,
  actiontime   DATE not null,
  expandxml    VARCHAR2(64)
)
;
alter table T_D_DELAYORDERSUMLOG
  add constraint PK_T_D_DELAYORDERSUMLOG primary key (ID);

prompt
prompt Creating table T_E_APPLYAHEADSETTLE
prompt ===================================
prompt
create table T_E_APPLYAHEADSETTLE
(
  applyid      VARCHAR2(15) not null,
  commodityid  VARCHAR2(16) not null,
  customerid_s VARCHAR2(40),
  customerid_b VARCHAR2(40),
  price        NUMBER(10,2),
  quantity     NUMBER(10) not null,
  status       NUMBER(2) not null,
  createtime   DATE not null,
  creator      VARCHAR2(20) not null,
  remark1      VARCHAR2(256),
  modifytime   DATE,
  modifier     VARCHAR2(20),
  remark2      VARCHAR2(256)
)
;
alter table T_E_APPLYAHEADSETTLE
  add constraint PK_T_E_APPLYAHEADSETTLE_1 primary key (APPLYID);

prompt
prompt Creating table T_E_APPLYGAGE
prompt ============================
prompt
create table T_E_APPLYGAGE
(
  applyid     NUMBER(15) not null,
  commodityid VARCHAR2(16) not null,
  firmid      VARCHAR2(32) not null,
  customerid  VARCHAR2(40) not null,
  quantity    NUMBER(10) not null,
  applytype   NUMBER(2) not null,
  status      NUMBER(2) not null,
  createtime  DATE not null,
  creator     VARCHAR2(20) not null,
  remark1     VARCHAR2(256),
  modifytime  DATE,
  modifier    VARCHAR2(20),
  remark2     VARCHAR2(256)
)
;
alter table T_E_APPLYGAGE
  add constraint PK_T_E_APPLYGAGE primary key (APPLYID);

prompt
prompt Creating table T_E_APPLYTREATYSETTLE
prompt ====================================
prompt
create table T_E_APPLYTREATYSETTLE
(
  applyid      NUMBER(15) not null,
  commodityid  VARCHAR2(16) not null,
  customerid_s VARCHAR2(40),
  customerid_b VARCHAR2(40),
  price        NUMBER(10,2),
  quantity     NUMBER(10) not null,
  status       NUMBER(2) not null,
  createtime   DATE not null,
  creator      VARCHAR2(20) not null,
  remark1      VARCHAR2(256),
  modifytime   DATE,
  modifier     VARCHAR2(20),
  remark2      VARCHAR2(256)
)
;
alter table T_E_APPLYTREATYSETTLE
  add constraint PK_T_E_APPLYTREATYSETTLE primary key (APPLYID);

prompt
prompt Creating table T_E_DEDUCTDETAIL
prompt ===============================
prompt
create table T_E_DEDUCTDETAIL
(
  deductid        NUMBER(10) not null,
  customerid      VARCHAR2(40) not null,
  wl              CHAR(1),
  buyqty          NUMBER(10),
  sellqty         NUMBER(10),
  buykeepqty      NUMBER(10),
  sellkeepqty     NUMBER(10),
  pureholdqty     NUMBER(10),
  pl              NUMBER(15,2),
  pl_ratio        NUMBER(10,3),
  counteractqty   NUMBER(10),
  orderqty        NUMBER(10),
  deductableqty   NUMBER(10),
  estimateqty     NUMBER(10,2),
  deductqty       NUMBER(10),
  deductedqty     NUMBER(10),
  counteractedqty NUMBER(10)
)
;
alter table T_E_DEDUCTDETAIL
  add constraint PK_T_E_DEDUCTDETAIL primary key (DEDUCTID, CUSTOMERID);

prompt
prompt Creating table T_E_DEDUCTKEEP
prompt =============================
prompt
create table T_E_DEDUCTKEEP
(
  deductid   NUMBER(10) not null,
  bs_flag    NUMBER(2) not null,
  customerid VARCHAR2(40) not null,
  keepqty    NUMBER(10) not null
)
;
alter table T_E_DEDUCTKEEP
  add constraint PK_T_E_DEDUCTKEEP primary key (DEDUCTID, BS_FLAG, CUSTOMERID);

prompt
prompt Creating table T_E_DEDUCTPOSITION
prompt =================================
prompt
create table T_E_DEDUCTPOSITION
(
  deductid       NUMBER(10) not null,
  deductdate     DATE not null,
  commodityid    VARCHAR2(16) not null,
  deductstatus   CHAR(1) default 'N' not null,
  deductprice    NUMBER(10,2) not null,
  loserbsflag    NUMBER(1) not null,
  losermode      NUMBER(1) not null,
  lossrate       NUMBER(5,2) not null,
  selfcounteract NUMBER(1) not null,
  profitlvl1     NUMBER(5,3) default 0 not null,
  profitlvl2     NUMBER(5,3) default 0 not null,
  profitlvl3     NUMBER(5,3) default 0 not null,
  profitlvl4     NUMBER(5,3) default 0 not null,
  profitlvl5     NUMBER(5,3) default 0 not null,
  exectime       DATE,
  alert          VARCHAR2(1024)
)
;
alter table T_E_DEDUCTPOSITION
  add constraint PK_T_E_DEDUCTPOSITION primary key (DEDUCTID);

prompt
prompt Creating table T_E_DIRECTFIRMBREED
prompt ==================================
prompt
create table T_E_DIRECTFIRMBREED
(
  firmid  VARCHAR2(32) not null,
  breedid NUMBER(10) not null
)
;
alter table T_E_DIRECTFIRMBREED
  add constraint PK_T_E_DIRECTFIRMBREED primary key (FIRMID, BREEDID);

prompt
prompt Creating table T_E_GAGEBILL
prompt ===========================
prompt
create table T_E_GAGEBILL
(
  id          NUMBER(20) not null,
  firmid      VARCHAR2(32) not null,
  commodityid VARCHAR2(16) not null,
  quantity    NUMBER(10) not null,
  remark      VARCHAR2(256),
  createtime  DATE not null,
  modifytime  DATE not null
)
;
alter table T_E_GAGEBILL
  add constraint PK_T_E_GAGEBILL primary key (ID);

prompt
prompt Creating table T_E_HISGAGEBILL
prompt ==============================
prompt
create table T_E_HISGAGEBILL
(
  cleardate   DATE not null,
  id          NUMBER(20) not null,
  firmid      VARCHAR2(32) not null,
  commodityid VARCHAR2(16) not null,
  quantity    NUMBER(10) not null,
  remark      VARCHAR2(256),
  createtime  DATE not null,
  modifytime  DATE not null
)
;
alter table T_E_HISGAGEBILL
  add constraint PK_T_E_HISGAGEBILL primary key (CLEARDATE, ID);

prompt
prompt Creating table T_E_PLEDGE
prompt =========================
prompt
create table T_E_PLEDGE
(
  id         NUMBER(15) not null,
  billid     VARCHAR2(32) not null,
  billfund   NUMBER(15,2) default 0 not null,
  firmid     VARCHAR2(32) not null,
  breedname  VARCHAR2(32) not null,
  quantity   NUMBER(10) not null,
  createtime DATE not null,
  creator    VARCHAR2(20) not null,
  modifytime DATE,
  modifier   VARCHAR2(20),
  status     NUMBER(2) default 0 not null,
  type       NUMBER(2) not null
)
;
alter table T_E_PLEDGE
  add constraint PK_T_E_PLEDGE primary key (ID);

prompt
prompt Creating table T_FIRM
prompt =====================
prompt
create table T_FIRM
(
  firmid              VARCHAR2(32) not null,
  status              NUMBER(2) not null,
  maxholdqty          NUMBER(10) default -1 not null,
  mincleardeposit     NUMBER(15,2) default 0 not null,
  maxoverdraft        NUMBER(15,2) default 0 not null,
  virtualfunds        NUMBER(15,2) default 0 not null,
  runtimefl           NUMBER(15,2) default 0 not null,
  clearfl             NUMBER(15,2) default 0 not null,
  runtimemargin       NUMBER(15,2) default 0 not null,
  clearmargin         NUMBER(15,2) default 0 not null,
  runtimeassure       NUMBER(15,2) default 0 not null,
  clearassure         NUMBER(15,2) default 0 not null,
  runtimesettlemargin NUMBER(15,2) default 0 not null,
  clearsettlemargin   NUMBER(15,2) default 0 not null,
  tariffid            VARCHAR2(6) default 'none' not null,
  modifytime          DATE not null
)
;
alter table T_FIRM
  add constraint PK_T_FIRM primary key (FIRMID);

prompt
prompt Creating table T_FIRMHOLDSUM
prompt ============================
prompt
create table T_FIRMHOLDSUM
(
  firmid       VARCHAR2(32) not null,
  commodityid  VARCHAR2(16) not null,
  bs_flag      NUMBER(2) not null,
  holdqty      NUMBER(10) not null,
  holdfunds    NUMBER(15,2) not null,
  floatingloss NUMBER(15,2) not null,
  evenprice    NUMBER(16,6) not null,
  holdmargin   NUMBER(15,2) default 0 not null,
  gageqty      NUMBER(10) default 0 not null,
  holdassure   NUMBER(15,2) default 0 not null
)
;
alter table T_FIRMHOLDSUM
  add constraint PK_T_FIRMHOLDSUM primary key (FIRMID, COMMODITYID, BS_FLAG);

prompt
prompt Creating table T_HOLDFROZEN
prompt ===========================
prompt
create table T_HOLDFROZEN
(
  id          NUMBER(20) not null,
  operation   VARCHAR2(20),
  firmid      VARCHAR2(32) not null,
  customerid  VARCHAR2(40) not null,
  commodityid VARCHAR2(16) not null,
  bs_flag     NUMBER(2) not null,
  frozentype  NUMBER(2),
  frozenqty   NUMBER(15) default 0 not null,
  frozentime  TIMESTAMP(6)
)
;
alter table T_HOLDFROZEN
  add constraint PK_T_HOLDFROZEN primary key (ID);

prompt
prompt Creating table T_HOLDPOSITION
prompt =============================
prompt
create table T_HOLDPOSITION
(
  a_holdno     NUMBER(15) not null,
  a_tradeno    NUMBER(15) not null,
  customerid   VARCHAR2(40) not null,
  commodityid  VARCHAR2(16) not null,
  bs_flag      NUMBER(2) not null,
  price        NUMBER(10,2) not null,
  holdqty      NUMBER(10) not null,
  openqty      NUMBER(10) not null,
  holdtime     DATE not null,
  holdmargin   NUMBER(15,2) default 0 not null,
  firmid       VARCHAR2(32) not null,
  gageqty      NUMBER(10) default 0 not null,
  holdassure   NUMBER(15,2) default 0 not null,
  floatingloss NUMBER(15,2) default 0 not null,
  holdtype     NUMBER(2) default 1 not null,
  atcleardate  DATE default trunc(sysdate) not null,
  deadline     DATE,
  remainday    NUMBER(10)
)
;
create index IX_T_HOLDPOSITION on T_HOLDPOSITION (CUSTOMERID, COMMODITYID, BS_FLAG);
create index IX_T_HOLDPOSITION_F_C_B on T_HOLDPOSITION (FIRMID, COMMODITYID, BS_FLAG);
alter table T_HOLDPOSITION
  add constraint PK_T_HOLDPOSITION primary key (A_HOLDNO);

prompt
prompt Creating table T_H_COMMODITY
prompt ============================
prompt
create table T_H_COMMODITY
(
  cleardate             DATE not null,
  commodityid           VARCHAR2(16) not null,
  name                  VARCHAR2(32) not null,
  sortid                NUMBER(10) not null,
  status                NUMBER(2) not null,
  contractfactor        NUMBER(12,2) not null,
  minpricemove          NUMBER(10,2) not null,
  breedid               NUMBER(10) not null,
  spreadalgr            NUMBER(1) not null,
  spreaduplmt           NUMBER(10,2) not null,
  spreaddownlmt         NUMBER(10,2) not null,
  feealgr               NUMBER(1) not null,
  feerate_b             NUMBER(15,9) not null,
  feerate_s             NUMBER(15,9) not null,
  marginalgr            NUMBER(1) not null,
  marginrate_b          NUMBER(10,4) default 0 not null,
  marginrate_s          NUMBER(10,4) default 0 not null,
  marketdate            DATE,
  settledate            DATE not null,
  settledate1           DATE,
  marginitem1           NUMBER(15,2),
  settledate2           DATE,
  marginitem2           NUMBER(15,2),
  settledate3           DATE,
  marginitem3           NUMBER(15,2),
  settledate4           DATE,
  marginitem4           NUMBER(15,2),
  lastprice             NUMBER(10,2) not null,
  marginitem1_s         NUMBER(15,2),
  marginitem2_s         NUMBER(15,2),
  marginitem3_s         NUMBER(15,2),
  marginitem4_s         NUMBER(15,2),
  marginassure_b        NUMBER(10,4) default 0 not null,
  marginassure_s        NUMBER(10,4) default 0 not null,
  marginitemassure1     NUMBER(15,2),
  marginitemassure2     NUMBER(15,2),
  marginitemassure3     NUMBER(15,2),
  marginitemassure4     NUMBER(15,2),
  marginitemassure1_s   NUMBER(15,2),
  marginitemassure2_s   NUMBER(15,2),
  marginitemassure3_s   NUMBER(15,2),
  marginitemassure4_s   NUMBER(15,2),
  todayclosefeerate_b   NUMBER(15,9) default 0 not null,
  todayclosefeerate_s   NUMBER(15,9) default 0 not null,
  historyclosefeerate_b NUMBER(15,9) default 0 not null,
  historyclosefeerate_s NUMBER(15,9) default 0 not null,
  limitcmdtyqty         NUMBER(10) default -1 not null,
  settlefeealgr         NUMBER(1) not null,
  settlefeerate_b       NUMBER(15,9) default 0 not null,
  settlefeerate_s       NUMBER(15,9) default 0 not null,
  forceclosefeealgr     NUMBER(1) not null,
  forceclosefeerate_b   NUMBER(15,9) default 0 not null,
  forceclosefeerate_s   NUMBER(15,9) default 0 not null,
  settlemarginalgr_b    NUMBER(1) not null,
  settlemarginrate_b    NUMBER(10,4) default 0 not null,
  settlemarginalgr_s    NUMBER(1) not null,
  settlemarginrate_s    NUMBER(10,4) default 0 not null,
  reservecount          NUMBER(10) default 0 not null,
  addedtax              NUMBER(10,4) default 0 not null,
  marginpricetype       NUMBER(1) default 0 not null,
  lowestsettlefee       NUMBER(15,2) default 0 not null,
  firmcleanqty          NUMBER(10) default -1 not null,
  firmmaxholdqty        NUMBER(10) default -1 not null,
  payoutalgr            NUMBER(1) not null,
  payoutrate            NUMBER(10,4) default 0 not null,
  addedtaxfactor        NUMBER(13,10) default 0 not null,
  settledate5           DATE,
  marginitem5           NUMBER(15,2),
  marginitem5_s         NUMBER(15,2),
  marginitemassure5     NUMBER(15,2),
  marginitemassure5_s   NUMBER(15,2),
  settlepricetype       NUMBER(2) default 0 not null,
  beforedays            NUMBER(4),
  specsettleprice       NUMBER(10,2),
  orderprivilege_b      NUMBER(6) default 101 not null,
  orderprivilege_s      NUMBER(6) default 101 not null,
  firmmaxholdqtyalgr    NUMBER(1) default 2 not null,
  startpercentqty       NUMBER(10) default 0 not null,
  maxpercentlimit       NUMBER(7,4) default 0 not null,
  onemaxholdqty         NUMBER(10) default -1 not null,
  minquantitymove       NUMBER(3) default 1 not null,
  delayrecouprate       NUMBER(7,5) default 0 not null,
  settleway             NUMBER(2) default 0 not null,
  delayfeeway           NUMBER(2) default 1 not null,
  maxfeerate            NUMBER(15,9),
  minsettlemoveqty      NUMBER(5) default 1 not null,
  storerecouprate       NUMBER(7,5) default 0 not null,
  minsettleqty          NUMBER(10) default 1 not null,
  delayrecouprate_s     NUMBER(7,5) default 0 not null,
  aheadsettlepricetype  NUMBER(2) default 0,
  delaysettlepricetype  NUMBER(2) default 0,
  settlemargintype      NUMBER(2) default 0,
  beforedays_m          NUMBER(2) default 0,
  sideholdlimitqty      NUMBER(10) default -1,
  holddayslimit         NUMBER(1) default 0 not null,
  maxholdpositionday    NUMBER(10),
  taxinclusive          NUMBER(1)
)
;
alter table T_H_COMMODITY
  add constraint PK_T_H_COMMODITY primary key (CLEARDATE, COMMODITYID);

prompt
prompt Creating table T_H_CONDITIONORDER
prompt =================================
prompt
create table T_H_CONDITIONORDER
(
  cleardate            DATE not null,
  a_orderno            NUMBER(15) not null,
  commodityid          VARCHAR2(16) not null,
  customerid           VARCHAR2(40) not null,
  traderid             VARCHAR2(40) not null,
  bs_flag              NUMBER(2) not null,
  ordertype            NUMBER(2) not null,
  price                NUMBER(10,2) not null,
  quantity             NUMBER(10) not null,
  conditiontype        NUMBER(2),
  conditionoperation   NUMBER(2),
  conditionprice       NUMBER(10,2) not null,
  conditioncommodityid VARCHAR2(16) not null,
  firmid               VARCHAR2(32) not null,
  retcode              NUMBER(4),
  updatetime           TIMESTAMP(6),
  validdate            DATE,
  sendstatus           NUMBER(2) default 0 not null,
  successtime          TIMESTAMP(6)
)
;
alter table T_H_CONDITIONORDER
  add constraint PK_T_H_CONDITIONORDER primary key (CLEARDATE, A_ORDERNO);

prompt
prompt Creating table T_H_CUSTOMERHOLDSUM
prompt ==================================
prompt
create table T_H_CUSTOMERHOLDSUM
(
  cleardate     DATE not null,
  customerid    VARCHAR2(40) not null,
  commodityid   VARCHAR2(16) not null,
  bs_flag       NUMBER(2) not null,
  holdqty       NUMBER(10) not null,
  holdfunds     NUMBER(15,2) not null,
  floatingloss  NUMBER(15,2) not null,
  evenprice     NUMBER(16,6) not null,
  frozenqty     NUMBER(10) not null,
  holdmargin    NUMBER(15,2) default 0 not null,
  gageqty       NUMBER(10) default 0 not null,
  holdassure    NUMBER(15,2) default 0 not null,
  firmid        VARCHAR2(32) not null,
  gagefrozenqty NUMBER(10) default 0 not null
)
;
alter table T_H_CUSTOMERHOLDSUM
  add constraint PK_T_H_CUSTOMERHOLDSUM primary key (CLEARDATE, CUSTOMERID, COMMODITYID, BS_FLAG);

prompt
prompt Creating table T_H_DELAYORDERS
prompt ==============================
prompt
create table T_H_DELAYORDERS
(
  cleardate      DATE not null,
  a_orderno      NUMBER(15) not null,
  commodityid    VARCHAR2(16) not null,
  customerid     VARCHAR2(40) not null,
  traderid       VARCHAR2(40),
  bs_flag        NUMBER(2) not null,
  delayordertype NUMBER(2) not null,
  status         NUMBER(2) not null,
  withdrawtype   NUMBER(2),
  quantity       NUMBER(10) not null,
  price          NUMBER(10,2),
  tradeqty       NUMBER(10) default 0,
  frozenfunds    NUMBER(15,2) default 0,
  unfrozenfunds  NUMBER(15,2) default 0,
  ordertime      DATE not null,
  withdrawtime   DATE,
  ordererip      VARCHAR2(64),
  signature      VARCHAR2(256),
  firmid         VARCHAR2(32) not null,
  consignerid    VARCHAR2(10),
  withdrawerid   VARCHAR2(40)
)
;
alter table T_H_DELAYORDERS
  add constraint PK_T_H_DELAYORDERS primary key (CLEARDATE, A_ORDERNO);

prompt
prompt Creating table T_H_DELAYQUOTATION
prompt =================================
prompt
create table T_H_DELAYQUOTATION
(
  cleardate         DATE not null,
  commodityid       VARCHAR2(16) not null,
  buysettleqty      NUMBER(10) not null,
  sellsettleqty     NUMBER(10) not null,
  buyneutralqty     NUMBER(10) not null,
  sellneutralqty    NUMBER(10) not null,
  createtime        DATE,
  neutralside       NUMBER(2) default 0 not null,
  delaycleanholdqty NUMBER(10) default 0 not null
)
;
alter table T_H_DELAYQUOTATION
  add constraint PK_T_H_DELAYQUOTATION primary key (CLEARDATE, COMMODITYID);

prompt
prompt Creating table T_H_DELAYTRADE
prompt =============================
prompt
create table T_H_DELAYTRADE
(
  cleardate      DATE not null,
  a_tradeno      NUMBER(15) not null,
  a_orderno      NUMBER(15) not null,
  tradetime      DATE not null,
  customerid     VARCHAR2(40) not null,
  commodityid    VARCHAR2(16) not null,
  bs_flag        NUMBER(2) not null,
  delayordertype NUMBER(2) not null,
  quantity       NUMBER(10) not null,
  tradetype      NUMBER(2) not null,
  firmid         VARCHAR2(32) not null
)
;
alter table T_H_DELAYTRADE
  add constraint PK_T_H_DELAYTRADE primary key (CLEARDATE, A_TRADENO);

prompt
prompt Creating table T_H_DIRECTFIRMBREED
prompt ==================================
prompt
create table T_H_DIRECTFIRMBREED
(
  deletedate DATE not null,
  firmid     VARCHAR2(32) not null,
  breedid    NUMBER(10) not null
)
;
alter table T_H_DIRECTFIRMBREED
  add constraint PK_T_H_DIRECTFIRMBREED primary key (DELETEDATE, FIRMID, BREEDID);

prompt
prompt Creating table T_H_FIRM
prompt =======================
prompt
create table T_H_FIRM
(
  cleardate           DATE not null,
  firmid              VARCHAR2(32) not null,
  status              NUMBER(2) not null,
  maxholdqty          NUMBER(10) default -1 not null,
  mincleardeposit     NUMBER(15,2) default 0 not null,
  maxoverdraft        NUMBER(15,2) default 0 not null,
  virtualfunds        NUMBER(15,2) default 0 not null,
  runtimefl           NUMBER(15,2) default 0 not null,
  clearfl             NUMBER(15,2) default 0 not null,
  runtimemargin       NUMBER(15,2) default 0 not null,
  clearmargin         NUMBER(15,2) default 0 not null,
  runtimeassure       NUMBER(15,2) default 0 not null,
  clearassure         NUMBER(15,2) default 0 not null,
  runtimesettlemargin NUMBER(15,2) default 0 not null,
  clearsettlemargin   NUMBER(15,2) default 0 not null,
  tariffid            VARCHAR2(6) default 'none' not null,
  modifytime          DATE not null
)
;
alter table T_H_FIRM
  add constraint PK_T_H_FIRM primary key (CLEARDATE, FIRMID);

prompt
prompt Creating table T_H_FIRMFEE
prompt ==========================
prompt
create table T_H_FIRMFEE
(
  cleardate             DATE not null,
  firmid                VARCHAR2(32) not null,
  commodityid           VARCHAR2(16) not null,
  feealgr               NUMBER(1) not null,
  feerate_b             NUMBER(15,9) not null,
  feerate_s             NUMBER(15,9) not null,
  todayclosefeerate_b   NUMBER(15,9) default 0 not null,
  todayclosefeerate_s   NUMBER(15,9) default 0 not null,
  historyclosefeerate_b NUMBER(15,9) default 0 not null,
  historyclosefeerate_s NUMBER(15,9) default 0 not null,
  forceclosefeealgr     NUMBER(1) not null,
  forceclosefeerate_b   NUMBER(15,9) default 0 not null,
  forceclosefeerate_s   NUMBER(15,9) default 0 not null,
  modifytime            DATE not null
)
;
alter table T_H_FIRMFEE
  add constraint PK_T_H_FIRMFEE primary key (CLEARDATE, FIRMID, COMMODITYID);

prompt
prompt Creating table T_H_FIRMHOLDSUM
prompt ==============================
prompt
create table T_H_FIRMHOLDSUM
(
  cleardate    DATE not null,
  firmid       VARCHAR2(32) not null,
  commodityid  VARCHAR2(16) not null,
  bs_flag      NUMBER(2) not null,
  holdqty      NUMBER(10) not null,
  holdfunds    NUMBER(15,2) not null,
  floatingloss NUMBER(15,2) not null,
  evenprice    NUMBER(16,6) not null,
  holdmargin   NUMBER(15,2) default 0 not null,
  gageqty      NUMBER(10) default 0 not null,
  holdassure   NUMBER(15,2) default 0 not null
)
;
alter table T_H_FIRMHOLDSUM
  add constraint PK_T_H_FIRMHOLDSUM primary key (CLEARDATE, FIRMID, COMMODITYID, BS_FLAG);

prompt
prompt Creating table T_H_FIRMMARGIN
prompt =============================
prompt
create table T_H_FIRMMARGIN
(
  cleardate           DATE not null,
  firmid              VARCHAR2(32) not null,
  commodityid         VARCHAR2(16) not null,
  marginalgr          NUMBER(1) not null,
  marginrate_b        NUMBER(10,4) default 0 not null,
  marginrate_s        NUMBER(10,4) default 0 not null,
  marginitem1         NUMBER(15,2),
  marginitem2         NUMBER(15,2),
  marginitem3         NUMBER(15,2),
  marginitem4         NUMBER(15,2),
  marginitem1_s       NUMBER(15,2),
  marginitem2_s       NUMBER(15,2),
  marginitem3_s       NUMBER(15,2),
  marginitem4_s       NUMBER(15,2),
  marginassure_b      NUMBER(10,4) default 0 not null,
  marginassure_s      NUMBER(10,4) default 0 not null,
  marginitemassure1   NUMBER(15,2),
  marginitemassure2   NUMBER(15,2),
  marginitemassure3   NUMBER(15,2),
  marginitemassure4   NUMBER(15,2),
  marginitemassure1_s NUMBER(15,2),
  marginitemassure2_s NUMBER(15,2),
  marginitemassure3_s NUMBER(15,2),
  marginitemassure4_s NUMBER(15,2),
  modifytime          DATE not null,
  marginitem5         NUMBER(15,2),
  marginitem5_s       NUMBER(15,2),
  marginitemassure5   NUMBER(15,2),
  marginitemassure5_s NUMBER(15,2)
)
;
alter table T_H_FIRMMARGIN
  add constraint PK_T_H_FIRMMARGIN primary key (CLEARDATE, FIRMID, COMMODITYID);

prompt
prompt Creating table T_H_FIRMSETTLEFEE
prompt ================================
prompt
create table T_H_FIRMSETTLEFEE
(
  cleardate       DATE not null,
  firmid          VARCHAR2(32) not null,
  commodityid     VARCHAR2(16) not null,
  settlefeealgr   NUMBER(1) not null,
  settlefeerate_b NUMBER(15,9) default 0 not null,
  settlefeerate_s NUMBER(15,9) default 0 not null,
  modifytime      DATE not null
)
;
alter table T_H_FIRMSETTLEFEE
  add constraint PK_T_H_FIRMSETTLEFEE primary key (CLEARDATE, FIRMID, COMMODITYID);

prompt
prompt Creating table T_H_FIRMSETTLEMARGIN
prompt ===================================
prompt
create table T_H_FIRMSETTLEMARGIN
(
  cleardate          DATE not null,
  firmid             VARCHAR2(32) not null,
  commodityid        VARCHAR2(16) not null,
  settlemarginalgr_b NUMBER(1) not null,
  settlemarginrate_b NUMBER(10,4) default 0 not null,
  settlemarginalgr_s NUMBER(1) not null,
  settlemarginrate_s NUMBER(10,4) default 0 not null,
  payoutalgr         NUMBER(1) not null,
  payoutrate         NUMBER(10,4) default 0 not null,
  modifytime         DATE not null
)
;
alter table T_H_FIRMSETTLEMARGIN
  add constraint PK_T_H_FIRMSETTLEMARGIN primary key (CLEARDATE, FIRMID, COMMODITYID);

prompt
prompt Creating table T_H_HOLDPOSITION
prompt ===============================
prompt
create table T_H_HOLDPOSITION
(
  cleardate    DATE not null,
  a_holdno     NUMBER(15) not null,
  a_tradeno    NUMBER(15) not null,
  customerid   VARCHAR2(40) not null,
  commodityid  VARCHAR2(16) not null,
  bs_flag      NUMBER(2) not null,
  price        NUMBER(10,2) not null,
  holdqty      NUMBER(10) not null,
  openqty      NUMBER(10) not null,
  holdtime     DATE not null,
  holdmargin   NUMBER(15,2) default 0 not null,
  firmid       VARCHAR2(32) not null,
  gageqty      NUMBER(10) default 0 not null,
  holdassure   NUMBER(15,2) default 0 not null,
  floatingloss NUMBER(15,2) default 0 not null,
  holdtype     NUMBER(2) default 1 not null,
  atcleardate  DATE default trunc(sysdate) not null,
  deadline     DATE,
  remainday    NUMBER(10)
)
;
alter table T_H_HOLDPOSITION
  add constraint PK_T_H_HOLDPOSITION primary key (CLEARDATE, A_HOLDNO);

prompt
prompt Creating table T_H_MARKET
prompt =========================
prompt
create table T_H_MARKET
(
  cleardate               DATE not null,
  marketcode              CHAR(2) not null,
  marketname              VARCHAR2(64),
  status                  NUMBER(2) default 1 not null,
  shortname               VARCHAR2(20),
  runmode                 NUMBER(2) default 1 not null,
  settlemode              NUMBER(2) default 0 not null,
  marginfbflag            NUMBER(1) default 0 not null,
  floatinglosscomputetype NUMBER(1) default 0 not null,
  closealgr               NUMBER(2) default 0 not null,
  tradepricealgr          NUMBER(2) default 0 not null,
  tradeflowtype           NUMBER(2) default 0 not null,
  floatingprofitsubtax    NUMBER(1) default 0 not null,
  gagemode                NUMBER(2) default 0 not null,
  tradetimetype           NUMBER(2) default 0 not null,
  delayquoshowtype        NUMBER(2) default 1 not null,
  neutralfeeway           NUMBER(2) default 0 not null,
  delayneedbill           NUMBER(2) default 0 not null,
  neutralflag             NUMBER(2) default 0 not null,
  neutralmatchpriority    NUMBER(2) default 0 not null,
  quotationtwoside        NUMBER(2) default 2 not null,
  asmargintype            NUMBER(2) default 0,
  delayorderispure        NUMBER(1) default 0 not null,
  chargedelayfeetype      NUMBER(2) default 0 not null
)
;
alter table T_H_MARKET
  add constraint PK_T_H_MARKET primary key (CLEARDATE, MARKETCODE);

prompt
prompt Creating table T_H_ORDERS
prompt =========================
prompt
create table T_H_ORDERS
(
  cleardate        DATE not null,
  a_orderno        NUMBER(15) not null,
  a_orderno_w      NUMBER(15),
  commodityid      VARCHAR2(16) not null,
  customerid       VARCHAR2(40) not null,
  traderid         VARCHAR2(40),
  bs_flag          NUMBER(2),
  ordertype        NUMBER(2) not null,
  status           NUMBER(2) not null,
  withdrawtype     NUMBER(2),
  failcode         NUMBER(3),
  quantity         NUMBER(10),
  price            NUMBER(10,2),
  closemode        NUMBER(2),
  specprice        NUMBER(10,2),
  timeflag         NUMBER(1),
  tradeqty         NUMBER(10),
  frozenfunds      NUMBER(15,2),
  unfrozenfunds    NUMBER(15,2),
  ordertime        DATE,
  withdrawtime     DATE,
  ordererip        VARCHAR2(64),
  signature        VARCHAR2(256),
  closeflag        NUMBER(1),
  firmid           VARCHAR2(32) not null,
  consignerid      VARCHAR2(10),
  withdrawerid     VARCHAR2(40),
  updatetime       TIMESTAMP(6) default systimestamp,
  billtradetype    NUMBER(2) default 0 not null,
  specialorderflag NUMBER(2) default 0
)
;
alter table T_H_ORDERS
  add constraint PK_T_H_ORDERS primary key (CLEARDATE, A_ORDERNO);

prompt
prompt Creating table T_H_QUOTATION
prompt ============================
prompt
create table T_H_QUOTATION
(
  cleardate          DATE not null,
  commodityid        VARCHAR2(16) not null,
  yesterbalanceprice NUMBER(12,4) default 0 not null,
  closeprice         NUMBER(12,4) default 0 not null,
  openprice          NUMBER(12,4) default 0 not null,
  highprice          NUMBER(12,4) default 0 not null,
  lowprice           NUMBER(12,4) default 0 not null,
  curprice           NUMBER(12,4) default 0 not null,
  curamount          NUMBER(10) default 0 not null,
  openamount         NUMBER(10) default 0 not null,
  buyopenamount      NUMBER(10) default 0 not null,
  sellopenamount     NUMBER(10) default 0 not null,
  closeamount        NUMBER(10) default 0 not null,
  buycloseamount     NUMBER(10) default 0 not null,
  sellcloseamount    NUMBER(10) default 0 not null,
  reservecount       NUMBER(10) default 0 not null,
  reservechange      NUMBER(10) default 0 not null,
  price              NUMBER(12,4) default 0 not null,
  totalmoney         NUMBER(15,2) default 0 not null,
  totalamount        NUMBER(10) default 0 not null,
  spread             NUMBER(12,4) default 0 not null,
  buyprice1          NUMBER(12,4) default 0 not null,
  sellprice1         NUMBER(12,4) default 0 not null,
  buyamount1         NUMBER(10) default 0 not null,
  sellamount1        NUMBER(10) default 0 not null,
  buyprice2          NUMBER(12,4) default 0,
  sellprice2         NUMBER(12,4) default 0,
  buyamount2         NUMBER(10) default 0,
  sellamount2        NUMBER(10) default 0,
  buyprice3          NUMBER(12,4) default 0,
  sellprice3         NUMBER(12,4) default 0,
  buyamount3         NUMBER(10) default 0,
  sellamount3        NUMBER(10) default 0,
  buyprice4          NUMBER(12,4) default 0,
  sellprice4         NUMBER(12,4) default 0,
  buyamount4         NUMBER(10) default 0,
  sellamount4        NUMBER(10) default 0,
  buyprice5          NUMBER(12,4) default 0,
  sellprice5         NUMBER(12,4) default 0,
  buyamount5         NUMBER(10) default 0,
  sellamount5        NUMBER(10) default 0,
  buyprice6          NUMBER(12,4) default 0,
  sellprice6         NUMBER(12,4) default 0,
  buyamount6         NUMBER(10) default 0,
  sellamount6        NUMBER(10) default 0,
  buyprice7          NUMBER(12,4) default 0,
  sellprice7         NUMBER(12,4) default 0,
  buyamount7         NUMBER(10) default 0,
  sellamount7        NUMBER(10) default 0,
  buyprice8          NUMBER(12,4) default 0,
  sellprice8         NUMBER(12,4) default 0,
  buyamount8         NUMBER(10) default 0,
  sellamount8        NUMBER(10) default 0,
  buyprice9          NUMBER(12,4) default 0,
  sellprice9         NUMBER(12,4) default 0,
  buyamount9         NUMBER(10) default 0,
  sellamount9        NUMBER(10) default 0,
  buyprice10         NUMBER(12,4) default 0,
  sellprice10        NUMBER(12,4) default 0,
  buyamount10        NUMBER(10) default 0,
  sellamount         NUMBER(10) default 0,
  outamount          NUMBER(10) default 0,
  inamount           NUMBER(10) default 0,
  tradecue           NUMBER(10) default 0,
  no                 NUMBER(10) default 0,
  createtime         TIMESTAMP(6)
)
;
alter table T_H_QUOTATION
  add constraint PK_T_H_QUOTATION primary key (CLEARDATE, COMMODITYID);

prompt
prompt Creating table T_H_TRADE
prompt ========================
prompt
create table T_H_TRADE
(
  cleardate        DATE not null,
  a_tradeno        NUMBER(15) not null,
  m_tradeno        NUMBER(15) not null,
  a_orderno        NUMBER(15),
  a_tradeno_closed NUMBER(15),
  tradetime        DATE,
  customerid       VARCHAR2(32) not null,
  commodityid      VARCHAR2(16) not null,
  bs_flag          NUMBER(2) not null,
  ordertype        NUMBER(2) not null,
  price            NUMBER(10,2) not null,
  quantity         NUMBER(10),
  close_pl         NUMBER(15,2),
  tradefee         NUMBER(15,2),
  tradetype        NUMBER(2) not null,
  holdprice        NUMBER(10,2),
  holdtime         DATE,
  firmid           VARCHAR2(32) not null,
  closeaddedtax    NUMBER(15,2) default 0,
  m_tradeno_opp    NUMBER(15) not null,
  atcleardate      DATE default trunc(sysdate) not null,
  tradeatcleardate DATE default trunc(sysdate) not null,
  oppfirmid        VARCHAR2(32) not null
)
;
alter table T_H_TRADE
  add constraint PK_T_H_TRADE primary key (CLEARDATE, A_TRADENO);

prompt
prompt Creating table T_MATCHSETTLEHOLDRELEVANCE
prompt =========================================
prompt
create table T_MATCHSETTLEHOLDRELEVANCE
(
  matchid      VARCHAR2(12) not null,
  settleid     NUMBER(15) not null,
  quantity     NUMBER(10) default 0 not null,
  price        NUMBER(15,2) default 0 not null,
  settlepayout NUMBER(15,2) not null,
  settlemargin NUMBER(15,2) not null
)
;
alter table T_MATCHSETTLEHOLDRELEVANCE
  add constraint PK_T_MATCHSETTLEHOLDRELEVANCE primary key (MATCHID, SETTLEID);

prompt
prompt Creating table T_ORDERS
prompt =======================
prompt
create table T_ORDERS
(
  a_orderno        NUMBER(15) not null,
  a_orderno_w      NUMBER(15),
  commodityid      VARCHAR2(16) not null,
  customerid       VARCHAR2(40) not null,
  traderid         VARCHAR2(40),
  bs_flag          NUMBER(2),
  ordertype        NUMBER(2) not null,
  status           NUMBER(2) not null,
  withdrawtype     NUMBER(2),
  failcode         NUMBER(3),
  quantity         NUMBER(10),
  price            NUMBER(10,2),
  closemode        NUMBER(2),
  specprice        NUMBER(10,2),
  timeflag         NUMBER(1),
  tradeqty         NUMBER(10),
  frozenfunds      NUMBER(15,2),
  unfrozenfunds    NUMBER(15,2),
  ordertime        DATE,
  withdrawtime     DATE,
  ordererip        VARCHAR2(64),
  signature        VARCHAR2(256),
  closeflag        NUMBER(1),
  firmid           VARCHAR2(32) not null,
  consignerid      VARCHAR2(10),
  withdrawerid     VARCHAR2(40),
  updatetime       TIMESTAMP(6) default systimestamp,
  billtradetype    NUMBER(2) default 0 not null,
  specialorderflag NUMBER(2) default 0
)
;
create index IX_T_ORDERS on T_ORDERS (FIRMID);
alter table T_ORDERS
  add constraint PK_T_ORDERS primary key (A_ORDERNO);

prompt
prompt Creating table T_QUOTATION
prompt ==========================
prompt
create table T_QUOTATION
(
  commodityid        VARCHAR2(16) not null,
  yesterbalanceprice NUMBER(12,4) default 0 not null,
  closeprice         NUMBER(12,4) default 0 not null,
  openprice          NUMBER(12,4) default 0 not null,
  highprice          NUMBER(12,4) default 0 not null,
  lowprice           NUMBER(12,4) default 0 not null,
  curprice           NUMBER(12,4) default 0 not null,
  curamount          NUMBER(10) default 0 not null,
  openamount         NUMBER(10) default 0 not null,
  buyopenamount      NUMBER(10) default 0 not null,
  sellopenamount     NUMBER(10) default 0 not null,
  closeamount        NUMBER(10) default 0 not null,
  buycloseamount     NUMBER(10) default 0 not null,
  sellcloseamount    NUMBER(10) default 0 not null,
  reservecount       NUMBER(10) default 0 not null,
  reservechange      NUMBER(10) default 0 not null,
  price              NUMBER(12,4) default 0 not null,
  totalmoney         NUMBER(15,2) default 0 not null,
  totalamount        NUMBER(10) default 0 not null,
  spread             NUMBER(12,4) default 0 not null,
  buyprice1          NUMBER(12,4) default 0 not null,
  sellprice1         NUMBER(12,4) default 0 not null,
  buyamount1         NUMBER(10) default 0 not null,
  sellamount1        NUMBER(10) default 0 not null,
  buyprice2          NUMBER(12,4) default 0,
  sellprice2         NUMBER(12,4) default 0,
  buyamount2         NUMBER(10) default 0,
  sellamount2        NUMBER(10) default 0,
  buyprice3          NUMBER(12,4) default 0,
  sellprice3         NUMBER(12,4) default 0,
  buyamount3         NUMBER(10) default 0,
  sellamount3        NUMBER(10) default 0,
  buyprice4          NUMBER(12,4) default 0,
  sellprice4         NUMBER(12,4) default 0,
  buyamount4         NUMBER(10) default 0,
  sellamount4        NUMBER(10) default 0,
  buyprice5          NUMBER(12,4) default 0,
  sellprice5         NUMBER(12,4) default 0,
  buyamount5         NUMBER(10) default 0,
  sellamount5        NUMBER(10) default 0,
  buyprice6          NUMBER(12,4) default 0,
  sellprice6         NUMBER(12,4) default 0,
  buyamount6         NUMBER(10) default 0,
  sellamount6        NUMBER(10) default 0,
  buyprice7          NUMBER(12,4) default 0,
  sellprice7         NUMBER(12,4) default 0,
  buyamount7         NUMBER(10) default 0,
  sellamount7        NUMBER(10) default 0,
  buyprice8          NUMBER(12,4) default 0,
  sellprice8         NUMBER(12,4) default 0,
  buyamount8         NUMBER(10) default 0,
  sellamount8        NUMBER(10) default 0,
  buyprice9          NUMBER(12,4) default 0,
  sellprice9         NUMBER(12,4) default 0,
  buyamount9         NUMBER(10) default 0,
  sellamount9        NUMBER(10) default 0,
  buyprice10         NUMBER(12,4) default 0,
  sellprice10        NUMBER(12,4) default 9,
  buyamount10        NUMBER(10) default 0,
  sellamount10       NUMBER(10) default 0,
  outamount          NUMBER(10) default 0,
  inamount           NUMBER(10) default 0,
  tradecue           NUMBER(10) default 0,
  no                 NUMBER(10) default 0,
  createtime         TIMESTAMP(6)
)
;
alter table T_QUOTATION
  add constraint PK_T_QUOTATION primary key (COMMODITYID);

prompt
prompt Creating table T_RMICONF
prompt ========================
prompt
create table T_RMICONF
(
  serviceid   NUMBER(2) not null,
  cnname      VARCHAR2(64),
  ename       VARCHAR2(64),
  hostip      VARCHAR2(16) not null,
  port        NUMBER(6) not null,
  rmidataport NUMBER(6) not null,
  enabled     CHAR(1) not null
)
;
alter table T_RMICONF
  add constraint PK_T_RMICONF primary key (SERVICEID);

prompt
prompt Creating table T_SETTLEANDHOLD
prompt ==============================
prompt
create table T_SETTLEANDHOLD
(
  settleholdpositionid NUMBER(15),
  matchid              VARCHAR2(12),
  tax                  NUMBER(15,2),
  bs_flag              NUMBER(2)
)
;
comment on column T_SETTLEANDHOLD.settleholdpositionid
  is '���ս��׿ͻ��ֲ���ϸ��id';
comment on column T_SETTLEANDHOLD.matchid
  is '������Ա��';
comment on column T_SETTLEANDHOLD.tax
  is '˰��';
comment on column T_SETTLEANDHOLD.bs_flag
  is '�������1��2��';

prompt
prompt Creating table T_SETTLECOMMODITY
prompt ================================
prompt
create table T_SETTLECOMMODITY
(
  settleprocessdate     DATE not null,
  commodityid           VARCHAR2(16) not null,
  name                  VARCHAR2(32) not null,
  sortid                NUMBER(10) not null,
  status                NUMBER(2) not null,
  contractfactor        NUMBER(12,2) not null,
  minpricemove          NUMBER(10,2) not null,
  breedid               NUMBER(10) not null,
  spreadalgr            NUMBER(1) not null,
  spreaduplmt           NUMBER(10,2) not null,
  spreaddownlmt         NUMBER(10,2) not null,
  feealgr               NUMBER(1) not null,
  feerate_b             NUMBER(15,9) not null,
  feerate_s             NUMBER(15,9) not null,
  marginalgr            NUMBER(1) not null,
  marginrate_b          NUMBER(10,4) default 0 not null,
  marginrate_s          NUMBER(10,4) default 0 not null,
  marketdate            DATE,
  settledate            DATE not null,
  settledate1           DATE,
  marginitem1           NUMBER(15,2),
  settledate2           DATE,
  marginitem2           NUMBER(15,2),
  settledate3           DATE,
  marginitem3           NUMBER(15,2),
  settledate4           DATE,
  marginitem4           NUMBER(15,2),
  lastprice             NUMBER(10,2) not null,
  marginitem1_s         NUMBER(15,2),
  marginitem2_s         NUMBER(15,2),
  marginitem3_s         NUMBER(15,2),
  marginitem4_s         NUMBER(15,2),
  marginassure_b        NUMBER(10,4) default 0 not null,
  marginassure_s        NUMBER(10,4) default 0 not null,
  marginitemassure1     NUMBER(15,2),
  marginitemassure2     NUMBER(15,2),
  marginitemassure3     NUMBER(15,2),
  marginitemassure4     NUMBER(15,2),
  marginitemassure1_s   NUMBER(15,2),
  marginitemassure2_s   NUMBER(15,2),
  marginitemassure3_s   NUMBER(15,2),
  marginitemassure4_s   NUMBER(15,2),
  todayclosefeerate_b   NUMBER(15,9) default 0 not null,
  todayclosefeerate_s   NUMBER(15,9) default 0 not null,
  historyclosefeerate_b NUMBER(15,9) default 0 not null,
  historyclosefeerate_s NUMBER(15,9) default 0 not null,
  limitcmdtyqty         NUMBER(10) default -1 not null,
  settlefeealgr         NUMBER(1) not null,
  settlefeerate_b       NUMBER(15,9) default 0 not null,
  settlefeerate_s       NUMBER(15,9) default 0 not null,
  forceclosefeealgr     NUMBER(1) not null,
  forceclosefeerate_b   NUMBER(15,9) default 0 not null,
  forceclosefeerate_s   NUMBER(15,9) default 0 not null,
  settlemarginalgr_b    NUMBER(1) not null,
  settlemarginrate_b    NUMBER(10,4) default 0 not null,
  settlemarginalgr_s    NUMBER(1) not null,
  settlemarginrate_s    NUMBER(10,4) default 0 not null,
  reservecount          NUMBER(10) default 0 not null,
  addedtax              NUMBER(10,4) default 0 not null,
  marginpricetype       NUMBER(1) default 0 not null,
  lowestsettlefee       NUMBER(15,2) default 0 not null,
  firmcleanqty          NUMBER(10) default -1 not null,
  firmmaxholdqty        NUMBER(10) default -1 not null,
  payoutalgr            NUMBER(1) not null,
  payoutrate            NUMBER(10,4) default 0 not null,
  addedtaxfactor        NUMBER(13,10) default 0 not null,
  settledate5           DATE,
  marginitem5           NUMBER(15,2),
  marginitem5_s         NUMBER(15,2),
  marginitemassure5     NUMBER(15,2),
  marginitemassure5_s   NUMBER(15,2),
  settlepricetype       NUMBER(2) default 0 not null,
  beforedays            NUMBER(4),
  specsettleprice       NUMBER(10,2),
  orderprivilege_b      NUMBER(6) default 101 not null,
  orderprivilege_s      NUMBER(6) default 101 not null,
  firmmaxholdqtyalgr    NUMBER(1) default 2 not null,
  startpercentqty       NUMBER(10) default 0 not null,
  maxpercentlimit       NUMBER(7,4) default 0 not null,
  onemaxholdqty         NUMBER(10) default -1 not null,
  minquantitymove       NUMBER(3) default 1 not null,
  delayrecouprate       NUMBER(7,5) default 0 not null,
  settleway             NUMBER(2) default 0 not null,
  delayfeeway           NUMBER(2) default 1 not null,
  maxfeerate            NUMBER(15,9),
  minsettlemoveqty      NUMBER(5) default 1 not null,
  storerecouprate       NUMBER(7,5) default 0 not null,
  minsettleqty          NUMBER(10) default 1 not null,
  delayrecouprate_s     NUMBER(7,5) default 0 not null,
  aheadsettlepricetype  NUMBER(2) default 0,
  delaysettlepricetype  NUMBER(2) default 0,
  settlemargintype      NUMBER(2) default 0,
  beforedays_m          NUMBER(2) default 0,
  sideholdlimitqty      NUMBER(10) default -1,
  holddayslimit         NUMBER(1) default 0 not null,
  maxholdpositionday    NUMBER(10),
  taxinclusive          NUMBER(1)
)
;
alter table T_SETTLECOMMODITY
  add constraint PK_T_SETTLECOMMODITY primary key (SETTLEPROCESSDATE, COMMODITYID);

prompt
prompt Creating table T_SETTLEHOLDPOSITION
prompt ===================================
prompt
create table T_SETTLEHOLDPOSITION
(
  id                      NUMBER(15) not null,
  settleprocessdate       DATE not null,
  a_holdno                NUMBER(15) not null,
  a_tradeno               NUMBER(15) not null,
  customerid              VARCHAR2(40) not null,
  commodityid             VARCHAR2(16) not null,
  bs_flag                 NUMBER(2) not null,
  price                   NUMBER(10,2) not null,
  holdqty                 NUMBER(10) not null,
  openqty                 NUMBER(10) not null,
  holdtime                DATE not null,
  holdmargin              NUMBER(15,2) default 0 not null,
  firmid                  VARCHAR2(32) not null,
  gageqty                 NUMBER(10) default 0 not null,
  holdassure              NUMBER(15,2) default 0 not null,
  floatingloss            NUMBER(15,2) default 0 not null,
  settlemargin            NUMBER(15,2) default 0 not null,
  payout                  NUMBER(15,2) default 0 not null,
  settlefee               NUMBER(15,2) default 0 not null,
  settle_pl               NUMBER(15,2) default 0 not null,
  settleaddedtax          NUMBER(15,2) default 0 not null,
  settleprice             NUMBER(16,6) not null,
  settletype              NUMBER(2) not null,
  holdtype                NUMBER(2) default 1 not null,
  atcleardate             DATE default trunc(sysdate) not null,
  matchquantity           NUMBER(10) default 0,
  matchstatus             NUMBER(2) default 0 not null,
  happenmatchqty          NUMBER(10) default 0 not null,
  happenmatchpayout       NUMBER(15,2) default 0 not null,
  happenmatchsettlemargin NUMBER(15,2) default 0 not null
)
;
create index IX_T_SETTLEHOLDPOSITION on T_SETTLEHOLDPOSITION (SETTLEPROCESSDATE, COMMODITYID);
alter table T_SETTLEHOLDPOSITION
  add constraint PK_T_SETTLEHOLDPOSITION primary key (ID);

prompt
prompt Creating table T_SETTLEMATCH
prompt ============================
prompt
create table T_SETTLEMATCH
(
  matchid        VARCHAR2(12) not null,
  commodityid    VARCHAR2(16) not null,
  contractfactor NUMBER(12,2) not null,
  quantity       NUMBER(10) not null,
  hl_amount      NUMBER(15,2) default 0 not null,
  status         NUMBER(2) default 0 not null,
  result         NUMBER(1) not null,
  settletype     NUMBER(2) not null,
  firmid_b       VARCHAR2(32) not null,
  buyprice       NUMBER(15,6) not null,
  buypayout_ref  NUMBER(15,2) default 0 not null,
  buypayout      NUMBER(15,2) default 0 not null,
  buymargin      NUMBER(15,2) default 0 not null,
  takepenalty_b  NUMBER(15,2) default 0 not null,
  paypenalty_b   NUMBER(15,2) default 0 not null,
  settlepl_b     NUMBER(15,2) default 0 not null,
  firmid_s       VARCHAR2(32) not null,
  sellprice      NUMBER(15,6) not null,
  sellincome_ref NUMBER(15,2) default 0 not null,
  sellincome     NUMBER(15,2) default 0 not null,
  sellmargin     NUMBER(15,2) default 0 not null,
  takepenalty_s  NUMBER(15,2) default 0 not null,
  paypenalty_s   NUMBER(15,2) default 0 not null,
  settlepl_s     NUMBER(15,2) default 0 not null,
  createtime     DATE not null,
  modifytime     DATE not null,
  settledate     DATE not null,
  modifier       VARCHAR2(64),
  istransfer     NUMBER(2) default 0 not null,
  buytax         NUMBER(15,2) default 0,
  taxincluesive  NUMBER(1) default 0
)
;
comment on column T_SETTLEMATCH.buytax
  is '����˰��';
comment on column T_SETTLEMATCH.taxincluesive
  is '��Ʒ�Ƿ�˰,0Ĭ�Ϻ�˰��1Ϊ����˰';
alter table T_SETTLEMATCH
  add constraint PK_T_SETTLEMATCH primary key (MATCHID);

prompt
prompt Creating table T_SETTLEMATCHFUNDMANAGE
prompt ======================================
prompt
create table T_SETTLEMATCHFUNDMANAGE
(
  id          NUMBER(15) not null,
  matchid     VARCHAR2(12) not null,
  firmid      VARCHAR2(32) not null,
  summaryno   VARCHAR2(5) not null,
  amount      NUMBER(15,2) not null,
  operatedate DATE not null,
  commodityid VARCHAR2(16)
)
;

prompt
prompt Creating table T_SETTLEMATCHLOG
prompt ===============================
prompt
create table T_SETTLEMATCHLOG
(
  id         NUMBER(20) not null,
  matchid    VARCHAR2(12) not null,
  operator   VARCHAR2(32) not null,
  operatelog VARCHAR2(2048) not null,
  updatetime TIMESTAMP(6)
)
;
alter table T_SETTLEMATCHLOG
  add constraint PK_T_SETTLEMATCHLOG primary key (ID);

prompt
prompt Creating table T_SETTLEPROPS
prompt ============================
prompt
create table T_SETTLEPROPS
(
  id            NUMBER(15) not null,
  commodityid   VARCHAR2(16) not null,
  propertyname  VARCHAR2(64) not null,
  propertyvalue VARCHAR2(1000),
  note          VARCHAR2(2000)
)
;
alter table T_SETTLEPROPS
  add constraint PK_T_SETTLEPROPS primary key (ID);

prompt
prompt Creating table T_SPECFROZENHOLD
prompt ===============================
prompt
create table T_SPECFROZENHOLD
(
  id        NUMBER(15) not null,
  a_holdno  NUMBER(15) not null,
  a_orderno NUMBER(15),
  frozenqty NUMBER(10) not null
)
;
alter table T_SPECFROZENHOLD
  add constraint PK_T_SPECFROZENHOLD primary key (ID);

prompt
prompt Creating table T_SUBSYSTEM
prompt ==========================
prompt
create table T_SUBSYSTEM
(
  moduleid NUMBER(2) not null,
  enabled  CHAR(1) not null
)
;
alter table T_SUBSYSTEM
  add constraint PK_T_SUBSYSTEM primary key (MODULEID);

prompt
prompt Creating table T_SYSTEMSTATUS
prompt =============================
prompt
create table T_SYSTEMSTATUS
(
  tradedate   DATE not null,
  status      NUMBER(2) default 3 not null,
  sectionid   NUMBER(4),
  note        VARCHAR2(256),
  recovertime VARCHAR2(10)
)
;
alter table T_SYSTEMSTATUS
  add constraint PK_T_SYSTEMSTATUS primary key (TRADEDATE);

prompt
prompt Creating table T_TRADE
prompt ======================
prompt
create table T_TRADE
(
  a_tradeno        NUMBER(15) not null,
  m_tradeno        NUMBER(15) not null,
  a_orderno        NUMBER(15),
  a_tradeno_closed NUMBER(15),
  tradetime        DATE,
  customerid       VARCHAR2(40) not null,
  commodityid      VARCHAR2(16) not null,
  bs_flag          NUMBER(2) not null,
  ordertype        NUMBER(2) not null,
  price            NUMBER(10,2) not null,
  quantity         NUMBER(10),
  close_pl         NUMBER(15,2),
  tradefee         NUMBER(15,2),
  tradetype        NUMBER(2) not null,
  holdprice        NUMBER(10,2),
  holdtime         DATE,
  firmid           VARCHAR2(32) not null,
  closeaddedtax    NUMBER(15,2) default 0,
  m_tradeno_opp    NUMBER(15) not null,
  atcleardate      DATE default trunc(sysdate) not null,
  tradeatcleardate DATE default trunc(sysdate) not null,
  oppfirmid        VARCHAR2(32) not null
)
;
create index IX_T_TRADE on T_TRADE (M_TRADENO);
alter table T_TRADE
  add constraint PK_T_TRADE primary key (A_TRADENO);

prompt
prompt Creating table T_TRADEDAYS
prompt ==========================
prompt
create table T_TRADEDAYS
(
  day DATE not null
)
;
alter table T_TRADEDAYS
  add constraint PK_T_TRADEDAYS primary key (DAY);

prompt
prompt Creating table T_TRADER
prompt =======================
prompt
create table T_TRADER
(
  traderid    VARCHAR2(40) not null,
  operatecode VARCHAR2(2048),
  modifytime  DATE not null
)
;
alter table T_TRADER
  add constraint PK_T_TRADER primary key (TRADERID);

prompt
prompt Creating table T_UNTRADETRANSFER
prompt ================================
prompt
create table T_UNTRADETRANSFER
(
  transferid   NUMBER(10) not null,
  customerid_s VARCHAR2(40) not null,
  customerid_b VARCHAR2(40) not null,
  commodityid  VARCHAR2(16) not null,
  bs_flag      NUMBER(2) not null,
  type         NUMBER(2) not null,
  quantity     NUMBER(10) default 0 not null,
  status       NUMBER(2) default 0 not null,
  createtime   DATE default sysdate not null,
  modifytime   DATE default sysdate not null
)
;
alter table T_UNTRADETRANSFER
  add constraint PK_T_UNTRADETRANSFER primary key (TRANSFERID);

prompt
prompt Creating table T_VALIDGAGEBILL
prompt ==============================
prompt
create table T_VALIDGAGEBILL
(
  firmid      VARCHAR2(32) not null,
  commodityid VARCHAR2(16) not null,
  quantity    NUMBER(10) not null,
  frozenqty   NUMBER(10) not null
)
;
alter table T_VALIDGAGEBILL
  add constraint PK_T_VALIDGAGEBILL primary key (FIRMID, COMMODITYID);

prompt
prompt Creating sequence SEQ_T_A_BREED
prompt ===============================
prompt
create sequence SEQ_T_A_BREED
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_T_A_CMDTYSORT
prompt ===================================
prompt
create sequence SEQ_T_A_CMDTYSORT
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_T_A_SETTLEPRIVILEGE
prompt =========================================
prompt
create sequence SEQ_T_A_SETTLEPRIVILEGE
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_T_A_TRADEPRIVILEGE
prompt ========================================
prompt
create sequence SEQ_T_A_TRADEPRIVILEGE
minvalue 1
maxvalue 9999999999999999999999999999
start with 181
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_T_BILLFROZEN
prompt ==================================
prompt
create sequence SEQ_T_BILLFROZEN
minvalue 1
maxvalue 9999999999999999999999999999
start with 644
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_T_BROADCAST
prompt =================================
prompt
create sequence SEQ_T_BROADCAST
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_T_CONDITIONORDER
prompt ======================================
prompt
create sequence SEQ_T_CONDITIONORDER
minvalue 1
maxvalue 10000000000000000
start with 41
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_T_DELAYORDERS
prompt ===================================
prompt
create sequence SEQ_T_DELAYORDERS
minvalue 1
maxvalue 9999999999999999999999999999
start with 761
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_T_DELAYTRADE
prompt ==================================
prompt
create sequence SEQ_T_DELAYTRADE
minvalue 1
maxvalue 9999999999999999999999999999
start with 221
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_T_D_ORDERLOG
prompt ==================================
prompt
create sequence SEQ_T_D_ORDERLOG
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_T_D_ORDERSUMLOG
prompt =====================================
prompt
create sequence SEQ_T_D_ORDERSUMLOG
minvalue 1
maxvalue 9999999999999999999999999999
start with 781
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_T_E_APPLYAHEADSETTLE
prompt ==========================================
prompt
create sequence SEQ_T_E_APPLYAHEADSETTLE
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_T_E_APPLYBILL
prompt ===================================
prompt
create sequence SEQ_T_E_APPLYBILL
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_T_E_APPLYGAGE
prompt ===================================
prompt
create sequence SEQ_T_E_APPLYGAGE
minvalue 1
maxvalue 9999999999999999999999999999
start with 41
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_T_E_APPLYTREATYSETTLE
prompt ===========================================
prompt
create sequence SEQ_T_E_APPLYTREATYSETTLE
minvalue 1
maxvalue 9999999999999999999999999999
start with 41
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_T_E_DEDUCTPOSITION
prompt ========================================
prompt
create sequence SEQ_T_E_DEDUCTPOSITION
minvalue 1
maxvalue 9999999999999999999999999999
start with 6
increment by 1
nocache;

prompt
prompt Creating sequence SEQ_T_E_EMBEDORDERS
prompt =====================================
prompt
create sequence SEQ_T_E_EMBEDORDERS
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_T_E_FUNDTRANSFER
prompt ======================================
prompt
create sequence SEQ_T_E_FUNDTRANSFER
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_T_E_GAGEBILL
prompt ==================================
prompt
create sequence SEQ_T_E_GAGEBILL
minvalue 1
maxvalue 9999999999999999999999999999
start with 61
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_T_E_PLEDGE
prompt ================================
prompt
create sequence SEQ_T_E_PLEDGE
minvalue 1
maxvalue 9999999999999999999999999999
start with 41
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_T_E_SETTLELOG
prompt ===================================
prompt
create sequence SEQ_T_E_SETTLELOG
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_T_E_VIRTUALFUNDSAPPLY
prompt ===========================================
prompt
create sequence SEQ_T_E_VIRTUALFUNDSAPPLY
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_T_HOLDFROZEN
prompt ==================================
prompt
create sequence SEQ_T_HOLDFROZEN
minvalue 1
maxvalue 9999999999999999999999999999
start with 61
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_T_HOLDPOSITION
prompt ====================================
prompt
create sequence SEQ_T_HOLDPOSITION
minvalue 1
maxvalue 9999999999999999999999999999
start with 175082
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_T_NOTSENDBROADCAST
prompt ========================================
prompt
create sequence SEQ_T_NOTSENDBROADCAST
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_T_ORDERS
prompt ==============================
prompt
create sequence SEQ_T_ORDERS
minvalue 1
maxvalue 9999999999999999999999999999
start with 168502
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_T_SETTLEHOLDPOSITION
prompt ==========================================
prompt
create sequence SEQ_T_SETTLEHOLDPOSITION
minvalue 1
maxvalue 9999999999999999999999999999
start with 821
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_T_SETTLEMATCH
prompt ===================================
prompt
create sequence SEQ_T_SETTLEMATCH
minvalue 1
maxvalue 9999999999999999999999999999
start with 644
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_T_SETTLEMATCHFUNDMANAGE
prompt =============================================
prompt
create sequence SEQ_T_SETTLEMATCHFUNDMANAGE
minvalue 1
maxvalue 9999999999999999999999999999
start with 763
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_T_SETTLEMATCHLOG
prompt ======================================
prompt
create sequence SEQ_T_SETTLEMATCHLOG
minvalue 1
maxvalue 9999999999999999999999999999
start with 821
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_T_SETTLEPROPS
prompt ===================================
prompt
create sequence SEQ_T_SETTLEPROPS
minvalue 1
maxvalue 9999999999999999999999999999
start with 341
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_T_SPECFROZENHOLD
prompt ======================================
prompt
create sequence SEQ_T_SPECFROZENHOLD
minvalue 1
maxvalue 9999999999999999999999999999
start with 19701
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_T_SYSLOG
prompt ==============================
prompt
create sequence SEQ_T_SYSLOG
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_T_TRADE
prompt =============================
prompt
create sequence SEQ_T_TRADE
minvalue 1
maxvalue 9999999999999999999999999999
start with 470622
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_T_UNTRADETRANSFER
prompt =======================================
prompt
create sequence SEQ_T_UNTRADETRANSFER
minvalue 1
maxvalue 9999999999999999999999999999
start with 41
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_T_VALIDBILL
prompt =================================
prompt
create sequence SEQ_T_VALIDBILL
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating view V_T_FIRM_INFO
prompt ===========================
prompt
create or replace force view v_t_firm_info as
select firmid, firmName, status, customerCounts, tcounts, createTime
    from (select a.*,
                 cf.name firmName,
                 cf.createtime createtime,
                 b.counts customerCounts,
                 t.tcounts tcounts
            from T_firm a,
                 (select T_customer.firmid,
                         count(T_customer.customerid) counts
                    from T_customer
                   group by T_customer.firmid) b,
                 (select M_trader.firmid, count(M_trader.traderid) tcounts
                    from M_trader
                   group by M_trader.firmid) t,
                 M_firm cf
           where a.firmid = b.firmid(+)
             and a.firmid = t.firmid(+)
             and a.firmid = cf.firmid
           order by a.firmID);

prompt
prompt Creating view V_T_OVERDUEHOLDPOSITION
prompt =====================================
prompt
create or replace force view v_t_overdueholdposition as
select firmid,       -- �����̴���
       customerid,   -- ���׿ͻ�����
       commodityid,  -- ��Ʒ����
       bs_flag,      -- ��������1����2����
       holdqty,      -- �ֲ�����
       openqty,      -- ��������
       gageqty,      -- �ֶ�����
       maycloseQty   -- ��ת������
  from (select ag.*, (s.holdqty - s.FrozenQty) maycloseQty
          from (select a.firmid,
                       a.customerid,
                       a.commodityid,
                       a.bs_flag,
                       sum(a.holdqty) holdqty,
                       sum(a.openqty) openqty,
                       sum(a.gageqty) gageqty
                  from T_HoldPosition a
                 where 1 = 1
                   and remainday = 0
                   and a.deadline is not null
                 group by a.firmid, a.customerid, a.commodityid, a.bs_flag) ag,
               t_customerholdsum s
         where ag.commodityid = s.commodityid
           and ag.customerid = s.customerid
           and ag.bs_flag = s.bs_flag
           and ag.holdqty > 0
           )
;

prompt
prompt Creating view V_T_TRADE
prompt =======================
prompt
create or replace force view v_t_trade as
select A_TRADENO,A_ORDERNO,TRADETIME,CUSTOMERID,COMMODITYID,BS_FLAG,ORDERTYPE,PRICE,QUANTITY,CLOSE_PL,TRADEFEE,TRADETYPE,HOLDPRICE,HOLDTIME,FIRMID,CLOSEADDEDTAX,FIRMNAME,OPPCUSTOMERID
           from (select a.*, m.name FirmName, a.oppFirmId oppCustomerID
                   from T_Trade a,
                        M_firm m
                  where m.firmID = a.firmID
                  order by a.firmID, a_orderno) Q;

prompt
prompt Creating function FN_T_ADDTRADEDAYS
prompt ===================================
prompt
create or replace function FN_T_AddTradeDAYS
/**
  * ��ӽ�����
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
      --������
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

prompt
prompt Creating function FN_T_COMPUTEASSURE
prompt ====================================
prompt
create or replace function FN_T_ComputeAssure(
    p_FirmID varchar2,
    p_CommodityID varchar2,
    p_bs_flag        number,
    p_quantity number,
    p_price number
) return number
/****
 * ���㵣����
 * ����ֵ �ɹ����ص�����;-1 �����������ݲ�ȫ;-100 ��������
****/
as
	v_version varchar2(10):='1.0.0.1';
    v_marginRate_b         number(10,4);
    v_marginRate_s         number(10,4);
    v_marginAlgr         number(2);
    v_contractFactor     number(12,2);
    v_margin             number(15,2) default 0;
begin
    --��ȡ��Ʒ��Ϣ����Լ���ӣ����׵����𣬱�֤���㷨
    select marginAssure_b,marginAssure_s,marginalgr,contractfactor
    into v_marginRate_b,v_marginRate_s,v_marginAlgr,v_contractFactor
    from T_Commodity where CommodityID=p_CommodityID;

    begin
        --��ȡ�ػ��Ľ��׵����𣬱�֤���㷨
        select marginAssure_b,marginAssure_s,marginalgr
    	into v_marginRate_b,v_marginRate_s,v_marginAlgr
        from T_A_FirmMargin
        where FirmID=p_FirmID and CommodityID=p_CommodityID;
    exception
        when NO_DATA_FOUND then
            null;
    end;
    if(v_marginAlgr=1) then  --Ӧ�ձ�֤��=����*��Լ����*�۸�*������
    	if(p_bs_flag = 1) then  --��
        	v_margin:=p_quantity*v_contractFactor*p_price*v_marginRate_b;
        elsif(p_bs_flag = 2) then  --��
        	v_margin:=p_quantity*v_contractFactor*p_price*v_marginRate_s;
        end if;
    elsif(v_marginAlgr=2) then  --Ӧ�ձ�֤��=����*������
    	if(p_bs_flag = 1) then  --��
        	v_margin:=p_quantity*v_marginRate_b;
        elsif(p_bs_flag = 2) then  --��
        	v_margin:=p_quantity*v_marginRate_s;
        end if;
    end if;
    if(v_margin is null) then
    	rollback;
        return -1;
    end if;
    return v_margin;
exception
    when no_data_found then
    	rollback;
        return -1;
    when others then
    	rollback;
    	return -100;
end;
/

prompt
prompt Creating function FN_T_COMPUTEMARGIN
prompt ====================================
prompt
create or replace function FN_T_ComputeMargin(
    p_FirmID varchar2,
    p_CommodityID varchar2,
    p_bs_flag        number,
    p_quantity number,
    p_price number
) return number
/****
 * ���㱣֤��
 * ����ֵ �ɹ����ر�֤��;-1 �����������ݲ�ȫ;-100 ��������
****/
as
	v_version varchar2(10):='1.0.0.1';
    v_marginRate_b         number(10,4);
    v_marginRate_s         number(10,4);
    v_marginAlgr         number(2);
    v_contractFactor     number(12,2);
    v_margin             number(15,2) default 0;
begin
    --��ȡ��Ʒ��Ϣ����Լ���ӣ����ױ�֤�𣬱�֤���㷨
    select marginrate_b,marginrate_s,marginalgr,contractfactor
    into v_marginRate_b,v_marginRate_s,v_marginAlgr,v_contractFactor
    from T_Commodity where CommodityID=p_CommodityID;

    begin
        --��ȡ�ػ��Ľ��ױ�֤�𣬱�֤���㷨
        select marginrate_b,marginrate_s,marginalgr
    	into v_marginRate_b,v_marginRate_s,v_marginAlgr
        from T_A_FirmMargin
        where FirmID=p_FirmID and CommodityID=p_CommodityID;
    exception
        when NO_DATA_FOUND then
            null;
    end;
    if(v_marginAlgr=1) then  --Ӧ�ձ�֤��=����*��Լ����*�۸�*��֤��
    	if(p_bs_flag = 1) then  --��
		    if(v_marginRate_b = -1) then --  -1��ʾ��ȫ��
		    	v_margin:=p_quantity*v_contractFactor*p_price;
		    else
			    v_margin:=p_quantity*v_contractFactor*p_price*v_marginRate_b;
		    end if;
        elsif(p_bs_flag = 2) then  --��
		    if(v_marginRate_s = -1) then --  -1��ʾ��ȫ��
		    	v_margin:=p_quantity*v_contractFactor*p_price;
		    else
			    v_margin:=p_quantity*v_contractFactor*p_price*v_marginRate_s;
		    end if;
        end if;
    elsif(v_marginAlgr=2) then  --Ӧ�ձ�֤��=����*��֤��
    	if(p_bs_flag = 1) then  --��
		    if(v_marginRate_b = -1) then --  -1��ʾ��ȫ��
		    	v_margin:=p_quantity*v_contractFactor*p_price;
		    else
			    v_margin:=p_quantity*v_marginRate_b;
		    end if;
        elsif(p_bs_flag = 2) then  --��
		    if(v_marginRate_s = -1) then --  -1��ʾ��ȫ��
		    	v_margin:=p_quantity*v_contractFactor*p_price;
		    else
			    v_margin:=p_quantity*v_marginRate_s;
		    end if;
        end if;
    end if;

    if(v_margin is null) then
    	rollback;
        return -1;
    end if;
    return v_margin;
exception
    when no_data_found then
    	rollback;
        return -1;
    when others then
	    rollback;
    	return -100;
end;
/

prompt
prompt Creating function FN_T_COMPUTEPAYOUT
prompt ====================================
prompt
create or replace function FN_T_ComputePayout(
    p_FirmID varchar2,
    p_CommodityID varchar2,
    p_bs_flag        number,
    p_quantity number,
    p_price number
) return number
/****
 * ���㽻�ջ���
 * ����ֵ �ɹ����ؽ��ջ���;-1 �����������ݲ�ȫ;-100 ��������
 *
 * ������ڼ����������ʱ�������Ʒ��˰���۳���˰��   by ������  2015/09/11
****/
as
	v_version varchar2(10):='1.0.0.1';
    v_marginRate_b         number(10,4);
    v_marginAlgr_b         number(2);
    v_contractFactor     number(12,2);
    v_margin             number(15,2) default 0;
    v_taxinclusive      number(1);                              --��Ʒ�Ƿ�˰ 1Ϊ����˰ 0Ϊ��˰
    v_addedtax         number(10,4);                          --��Ʒ˰��
    
begin
    --��ȡ��Ʒ��Ϣ����Լ���ӣ����ջ���ϵ�������ջ����㷨 , ��Ʒ�Ƿ�˰����Ʒ˰��
    select PayoutRate,PayoutAlgr,contractfactor,taxinclusive,addedtax
    into v_marginRate_b,v_marginAlgr_b,v_contractFactor,v_taxinclusive,v_addedtax
    from T_Commodity where CommodityID=p_CommodityID;

    begin
        --��ȡ����Ľ��ջ���ϵ�������ջ����㷨
        select PayoutRate,PayoutAlgr
    	into v_marginRate_b,v_marginAlgr_b
        from T_A_FirmSettleMargin
        where FirmID=p_FirmID and CommodityID=p_CommodityID;
    exception
        when NO_DATA_FOUND then
            null;
    end;
  
	if(v_marginAlgr_b = 1) then  
             --�����Ʒ����˰
            if(v_taxinclusive = 1 ) then --Ӧ�ս��ջ��� =���� * ��Լ���� * �۸� * ���ջ���ϵ�� ���հٷֱ���
            v_margin:=p_quantity*v_contractFactor*p_price*v_marginRate_b;
            else -- ��Ʒ��˰ Ӧ�ս��ջ��� =���� * ��Լ���� * �۸� * ���ջ���ϵ�� * ��Ʒ��˰ϵ��  ���հٷֱ���
             v_margin:=p_quantity*v_contractFactor*p_price*v_marginRate_b*(1/(1+v_addedtax));
             end if;
    elsif(v_marginAlgr_b = 2) then  --Ӧ�ս��ջ��� =���� * ���ջ���ϵ�� ������ֵ��
		v_margin:=p_quantity*v_marginRate_b;
    end if;

    if(v_margin is null) then
    	rollback;
        return -1;
    end if;
    return v_margin;
exception
    when no_data_found then
    	rollback;
        return -1;
    when others then
    	rollback;
    	return -100;
end;
/

prompt
prompt Creating function FN_T_COMPUTESETTLEFEE
prompt =======================================
prompt
create or replace function FN_T_ComputeSettleFee(
    p_FirmID     varchar2,
    p_CommodityID varchar2,
    p_bs_flag        number,
    p_quantity       number,
    p_price          number
) return number
/****
 * ���㽻��������
 * ����ֵ �ɹ�����������;-1 ���㽻�׷����������ݲ�ȫ;-100 ��������
****/
as
	v_version varchar2(10):='1.0.0.1';
    v_feeRate_b         number(15,9);
    v_feeRate_s         number(15,9);
    v_feeAlgr       number(2);
    v_contractFactor  number(12,2);
    v_LowestSettleFee             number(15,2) default 0;
    v_fee             number(15,2) default 0;
begin
    --��ȡ��Ʒ��Ϣ����Լ���ӣ�������ϵ�����������㷨��
    select SettleFeeRate_B,SettleFeeRate_S,SettleFeeAlgr,contractfactor,LowestSettleFee
    into v_feeRate_b,v_feeRate_s,v_feeAlgr,v_contractFactor,v_LowestSettleFee
    from T_Commodity where CommodityID=p_CommodityID;

    begin
        --��ȡ�ػ���������ϵ�����������㷨
        select SettleFeeRate_B,SettleFeeRate_S,SettleFeeAlgr
   		into v_feeRate_b,v_feeRate_s,v_feeAlgr
        from T_A_FirmSettleFee
        where FirmID=p_FirmID and CommodityID=p_CommodityID;
    exception
        when NO_DATA_FOUND then
            null;
    end;
    if(v_feeAlgr=1) then  --Ӧ��������=����*��Լ����*�۸�*������
    	if(p_bs_flag = 1) then  --��
        	v_fee:=p_quantity*v_contractFactor*p_price*v_feeRate_b;
        elsif(p_bs_flag = 2) then  --��
        	v_fee:=p_quantity*v_contractFactor*p_price*v_feeRate_s;
        end if;
    elsif(v_feeAlgr=2) then  --Ӧ��������=����*������
    	if(p_bs_flag = 1) then  --��
        	v_fee:=p_quantity*v_feeRate_b;
        elsif(p_bs_flag = 2) then  --��
        	v_fee:=p_quantity*v_feeRate_s;
        end if;
    end if;
    if(v_fee is null) then
    	rollback;
        return -1;
    end if;
    --���������Ѻ���ͽ���������ȡ����ߣ�
    --2009-07-06�ĳɲ��Ƚ��ˣ�ֱ�ӷ��ؼ���������ѣ��ú�����Χȥ�Ƚ�
	/*
    if(v_fee >= v_LowestSettleFee) then
        return v_fee;
	else
	    return v_LowestSettleFee;
    end if;
    */
    return v_fee;
exception
    when no_data_found then
    	rollback;
        return -1;
    when others then
    	rollback;
   		return -100;
end;
/

prompt
prompt Creating function FN_T_SUBHOLDSUM
prompt =================================
prompt
CREATE OR REPLACE FUNCTION FN_T_SubHoldSum
(
  p_HoldQty      number,   --�ֲ�����
  p_GageQty      number,   --������
  p_Margin      number,   --��֤��
  p_Assure      number,   --������
  p_CommodityID varchar2, --��Ʒ����
  p_ContractFactor        number, --��Լ����
  p_BS_Flag        number, --������־
  p_FirmID varchar2,   --�����̴���
  p_HoldFunds      number,   --�����ֲֽ̳��
  p_CustomerID varchar2,   --���׿ͻ�����
  p_CustomerHoldFunds      number,   --���׿ͻ��ֲֽ��
  p_GageMode number,     --�ֶ�ģʽ��0ȫ�ֶ���1��ֶ�
  p_FrozenQty number     --���׿ͻ���������
)  return number
/***
 * ���ٽ��׿ͻ��������̵ĳֲֺϼ���Ϣ
 *
 * ����ֵ��1�ɹ�
 ****/
is
  v_version varchar2(10):='1.0.0.10';
  v_num   number(10);
begin
    --���Ľ��׿ͻ��ֲֺϼƱ��еĳֲּ�¼
    update T_CustomerHoldSum
    set holdqty = holdqty - p_HoldQty,
        GageQty = GageQty - p_GageQty,
        FrozenQty = FrozenQty - p_FrozenQty,
        holdfunds = holdfunds - p_CustomerHoldFunds,
        HoldMargin = HoldMargin - p_Margin,
        HoldAssure = HoldAssure - p_Assure,
        evenprice = decode((holdqty+GageQty - p_HoldQty-p_GageQty),0,0,(holdfunds - p_CustomerHoldFunds)/((holdqty+GageQty - p_HoldQty-p_GageQty)*p_ContractFactor))
    where CustomerID = p_CustomerID
      and CommodityID = p_CommodityID
      and bs_flag = p_BS_Flag;
    --���Ľ����ֲֺ̳ϼƱ��еĳֲּ�¼
    update T_FirmHoldSum
    set holdqty = holdqty - p_HoldQty,
        GageQty = GageQty - p_GageQty,
        holdfunds = holdfunds - p_HoldFunds,
        HoldMargin = HoldMargin - p_Margin,
        HoldAssure = HoldAssure - p_Assure,
        evenprice = decode(p_GageMode,1,decode((holdqty+GageQty - p_HoldQty-p_GageQty),0,0,(holdfunds - p_HoldFunds)/((holdqty+GageQty - p_HoldQty-p_GageQty)*p_ContractFactor)),
        decode((holdqty - p_HoldQty),0,0,(holdfunds - p_HoldFunds)/((holdqty - p_HoldQty)*p_ContractFactor)))
    where Firmid = p_FirmID
      and CommodityID = p_CommodityID
      and bs_flag = p_BS_Flag;

   return 1;
end;
/

prompt
prompt Creating function FN_T_AHEADSETTLEONE
prompt =====================================
prompt
create or replace function FN_T_AheadSettleOne(
    p_CommodityID varchar2,   --��Ʒ����
  p_Price         number,  --���ռ�
  p_BS_Flag     number,  --������־
    p_CustomerID    varchar2,     --���׿ͻ�ID
    p_HoldQty      number,   --���ճֲ����������ǵֶ�����
  p_GageQty      number   --���յֶ�����
) return number
/****
 * ������������ǰ����
 * 1��ע�ⲻҪ�ύcommit����Ϊ��ĺ���Ҫ��������
 * ����ֵ
 * 1 �ɹ�
 * -1  �ɽ��ճֲ���������
 * -2  �ɽ��յֶ���������
 * -3  ���ճֲ��������ڿɽ��ճֲ�����
 * -4  ���յֶ��������ڿɵֶ�����
 * -100 ��������
****/
as
  v_version varchar2(10):='1.0.2.1';
    v_CommodityID varchar2(16);
    v_CustomerID        varchar2(40);
    v_FirmID varchar2(32);
    v_HoldQty  number;
    v_HoldSumQty     number(10);
    v_frozenQty      number(10);
    v_Margin         number(15,2):=0;
    v_Margin_one         number(15,2):=0;
    v_closeFL_one         number(15,2):=0;    --һ����¼�Ľ���ӯ��
    v_CloseFL         number(15,2):=0;        --����ӯ���ۼ�
    v_Fee_one         number(15,2):=0;    --һ����¼�Ľ���������
    v_Fee         number(15,2):=0;        --�����������ۼ�
  v_Assure         number(15,2):=0;
  v_Assure_one         number(15,2):=0;
    v_Payout         number(15,2):=0;
    v_Payout_one         number(15,2):=0;
    v_BS_Flag           number(2);
    v_Price         number(15,2);
    v_ContractFactor    number(12,2);
    v_MarginPriceType           number(1);
    v_MarginPrice    number(15,2);  --����ɽ���֤��ļ۸�
  v_HoldFunds    number(15,2):=0;  --ƽ��ʱӦ�˳ֲֽ��������ֶ���
  v_CustomerHoldFunds    number(15,2):=0;  --ƽ��ʱӦ�˳ֲֽ������ֶ���
    v_TradeDate date;
  v_A_HoldNo number(15);
  v_ID number(15);
  v_AddedTaxFactor T_Commodity.AddedTaxFactor%type;--��ֵ˰��ϵ��=AddedTax/(1+AddedTax)
  v_GageQty     number(10);
  v_CloseAddedTax_one   number(15,2); --����ӯ����ֵ˰
  v_CloseAddedTax         number(15,2):=0;        --����ӯ����ֵ˰�ۼ�
  v_unCloseQty     number(10):=p_HoldQty; --δƽ�����������м����
  v_unCloseQtyGage     number(10):=p_GageQty; --δƽ�����������м����
  v_tradedAmount   number(10):=0;  --�ɽ�����
  v_tradedAmountGage   number(10):=0;  --�ɽ�����
  v_CloseAlgr           number(2);
  v_num            number(10);
  v_Balance    number(15,2);
  v_F_FrozenFunds   number(15,2);
  type cur_T_HoldPosition is ref cursor;
  v_HoldPosition cur_T_HoldPosition;
  v_sql varchar2(500);
  v_orderby  varchar2(100);
  v_closeTodayHis        number(2);    --ƽ��ֻ�����ʷ��(0ƽ��֣�1ƽ��ʷ��)
  v_YesterBalancePrice    number(15,2);
  v_AtClearDate          date;
  v_LowestSettleFee             number(15,2) default 0;
  v_GageMode number(2);--�ֶ�ģʽ����0ȫ�ֶ���1��ֶ�����ֶ�ʱҪ���㸡����2009-10-14
  v_TaxInclusive     number(1);   --��Ʒ�Ƿ�˰ 0��˰  1����˰   duanbaodi 20150730
begin
    v_CustomerID := p_CustomerID;
      v_CommodityID := p_CommodityID;
        v_BS_Flag := p_BS_Flag;
        --��ס���׿ͻ��ֲֺϼƣ��Է�ֹ��������
        select HoldQty,FrozenQty,GageQty
        into v_HoldSumQty, v_frozenQty,v_GageQty
        from T_CustomerHoldSum
        where CustomerID = v_CustomerID
          and CommodityID = v_CommodityID
          and bs_flag = v_BS_Flag for update;
        --�ɽ��ճֲ���������
        if(p_HoldQty > v_HoldSumQty-v_frozenQty) then
            rollback;
            return -1;
        end if;
        --�ɽ��յֶ���������
        if(p_GageQty > v_GageQty) then
            rollback;
            return -2;
        end if;
        --��ȡƽ���㷨,�ֶ�ģʽ����֤��������ͣ���ֵ˰����Լ����, �Ƿ�˰
        select CloseAlgr,GageMode into v_CloseAlgr,v_GageMode from T_A_Market;

       /*select Contractfactor,MarginPriceType,AddedTaxFactor,LastPrice,LowestSettleFee
        into v_ContractFactor,v_MarginPriceType,v_AddedTaxFactor,v_YesterBalancePrice,v_LowestSettleFee
        from T_Commodity where CommodityID=v_CommodityID;            20150730*/

        select Contractfactor,MarginPriceType,AddedTaxFactor,LastPrice,LowestSettleFee,TaxInclusive  /* �����Ƿ�˰�ֶ�  duanbaodi 20150730  */
        into v_ContractFactor,v_MarginPriceType,v_AddedTaxFactor,v_YesterBalancePrice,v_LowestSettleFee,v_TaxInclusive
        from T_Commodity where CommodityID=v_CommodityID;

     select TradeDate into v_TradeDate from T_SystemStatus;


        --����ƽ���㷨(0�ȿ���ƽ��1����ƽ��2�ֲ־���ƽ��(������)ѡ����������
        if(v_CloseAlgr = 0) then
          v_orderby := ' order by a.A_HoldNo ';
      elsif(v_CloseAlgr = 1) then
          v_orderby := ' order by a.A_HoldNo desc ';
      end if;

      v_sql := 'select a.a_holdno,FirmID,price,(a.HoldQty-nvl(b.FrozenQty,0)),GageQty,nvl(b.FrozenQty,0),a.AtClearDate from T_holdposition a,(select A_HoldNo,nvl(sum(FrozenQty),0) FrozenQty from T_SpecFrozenHold group by A_HoldNo) b ' ||
                 ' where (a.HoldQty+a.GageQty) > 0 and a.A_HoldNo=b.A_HoldNo(+) and CustomerID=''' || v_CustomerID ||
                 ''' and CommodityID =''' || v_CommodityID || ''' and bs_flag = ' || v_BS_Flag || v_orderby;

        --�����ֲ���ϸ�����������˵�ָ��ƽ�ֶ��������
            open v_HoldPosition for v_sql;
            loop
                fetch v_HoldPosition into v_a_holdno, v_FirmID, v_price, v_holdqty,v_GageQty,v_frozenQty,v_AtClearDate;
                exit when v_HoldPosition%NOTFOUND;
                --����˱ʳֲ�ȫ����ָ��ƽ�ֶ�����û�еֶ���ָ����һ����¼
              --2011-01-12 by chenxc �޸ĵ��ֲ���ϸ�ĳֲ�����Ϊ0���ֶ�������Ϊ0����ǰ���շǵֶ��Ļ����һ���ֲּ�¼����0�ĵ����ճֲ���ϸ����֮��Ȼ
                if((v_holdqty <> 0 and v_unCloseQty>0) or (v_GageQty <> 0 and v_unCloseQtyGage>0)) then
                  --��0
                  v_tradedAmount:=0;
                  v_tradedAmountGage:=0;
                  v_Payout_one := 0;
                  --1������Ӧ�˿���
                  if(v_holdqty > 0) then
                    if(v_holdqty<=v_unCloseQty) then
                        v_tradedAmount:=v_holdqty;
                    else
                        v_tradedAmount:=v_unCloseQty;
                    end if;
                    --����Ӧ�˱�֤�𣬸�������ѡ�񿪲ּۻ�������������
            if(v_MarginPriceType = 1) then
                  v_MarginPrice := v_YesterBalancePrice;
              elsif(v_MarginPriceType = 2) then
              --�ж���ƽ��ֻ���ƽ��ʷ��
                if(trunc(v_TradeDate) = trunc(v_AtClearDate)) then
                    v_closeTodayHis := 0;
                else
                  v_closeTodayHis := 1;
                end if;
              if(v_closeTodayHis = 0) then  --ƽ���
                v_MarginPrice := v_price;
              else  --ƽ��ʷ��
                    v_MarginPrice := v_YesterBalancePrice;
                end if;
            else  -- default type is 0
              v_MarginPrice := v_price;
            end if;
                    v_Margin_one := FN_T_ComputeMargin(v_FirmID,v_CommodityID,v_BS_Flag,v_tradedAmount,v_MarginPrice);
                    if(v_Margin_one < 0) then
                        Raise_application_error(-20040, 'computeMargin error');
                    end if;
                --���㵣����
                v_Assure_one := FN_T_ComputeAssure(v_FirmID,v_CommodityID,v_BS_Flag,v_tradedAmount,v_MarginPrice);
                if(v_Assure_one < 0) then
                    Raise_application_error(-20041, 'computeAssure error');
                end if;
                --��֤��Ӧ���ϵ�����
                v_Margin_one := v_Margin_one + v_Assure_one;
                    v_Margin:=v_Margin + v_Margin_one;
                    v_Assure:=v_Assure + v_Assure_one;
                  --����Ӧ�˳ֲֽ��������ֶ���
                  v_HoldFunds := v_HoldFunds + v_tradedAmount*v_price*v_ContractFactor;
                  end if;
                  --2������ֲ���ϸ�н��յĵֶ�����
          if(v_GageQty > 0) then
                    if(v_GageQty<=v_unCloseQtyGage) then
                        v_tradedAmountGage:=v_GageQty;
                    else
                        v_tradedAmountGage:=v_unCloseQtyGage;
                    end if;
                  end if;
              --����ǰ�ֶ�ģʽ�����ֲֽ̳��Ҫ�˵ֶ���
              if(v_GageMode=1) then
                v_HoldFunds := v_HoldFunds + v_tradedAmountGage*v_price*v_ContractFactor;
              end if;
                  --�����ͻ��ϼƽ������ֶ���
                  v_CustomerHoldFunds := v_CustomerHoldFunds + (v_tradedAmount+v_tradedAmountGage)*v_price*v_ContractFactor;
                --3�����㽻�տ���
          --�����򷽽��ջ����ǰ���ղ����ս��ձ�֤��
          if(v_BS_Flag = 1) then
                v_Payout_one := FN_T_ComputePayout(v_FirmID,v_CommodityID,v_BS_Flag,v_tradedAmount+v_tradedAmountGage,p_Price);
                  if(v_Payout_one < 0) then
                      Raise_application_error(-20043, 'computePayout error');
                  end if;
                end if;
              --���㽻��������
          v_Fee_one := FN_T_ComputeSettleFee(v_FirmID,v_CommodityID,v_BS_Flag,v_tradedAmount+v_tradedAmountGage,p_Price);
                if(v_Fee_one < 0) then
                  Raise_application_error(-20031, 'computeFee error');
                end if;

                --����˰ǰ����ӯ��
                if(v_BS_Flag = 1) then
                    v_closeFL_one := (v_tradedAmount+v_tradedAmountGage)*(p_Price-v_price)*v_contractFactor; --˰ǰӯ��
                else
                    v_closeFL_one := (v_tradedAmount+v_tradedAmountGage)*(v_price-p_Price)*v_contractFactor; --˰ǰӯ��
                end if;


                --���㽻����ֵ˰,v_AddedTaxFactor��ֵ˰ϵ��=AddedTax/(1+AddedTax)
              --  v_CloseAddedTax_one := round(v_closeFL_one*v_AddedTaxFactor,2);
                  v_CloseAddedTax_one :=0;

                --����˰��Ľ���ӯ�� duanbaodi 20150730   xief 20150811
               /* if(v_TaxInclusive=1) then
                     --����˰ �۳���ֵ˰
                     v_closeFL_one := v_closeFL_one - v_CloseAddedTax_one; --˰��ӯ��
                end if;
                */

                /*--����˰����ӯ��
                v_closeFL_one := v_closeFL_one - v_CloseAddedTax_one; --˰��ӯ��              20150730*/
          --�ۼƽ��
              v_Payout := v_Payout + v_Payout_one;
              v_Fee := v_Fee + v_Fee_one;
          v_CloseFL:=v_CloseFL + v_closeFL_one;  --˰��ӯ���ϼ�
          v_CloseAddedTax:=v_CloseAddedTax + v_CloseAddedTax_one;  --������ֵ˰�ϼ�
              --����ǰ�ֲּ�¼�ͽ��շ��ò��뽻�ճֲ���ϸ�������³ֲ������͵ֶ�����Ϊʵ�ʽ��յ�����
          select SEQ_T_SettleHoldPosition.nextval into v_ID from dual;
          --���ֶ������뽻�ճֲ���ϸ��
              insert into t_settleholdposition
            (id, settleprocessdate, a_holdno, a_tradeno, customerid, commodityid, bs_flag, price, holdqty, openqty, holdtime, holdmargin, firmid, gageqty, holdassure, floatingloss, settlemargin, payout, settlefee, settle_pl, settleaddedtax, settleprice, settletype, holdtype, atcleardate)
              select v_ID,v_TradeDate,a_holdno, a_tradeno, customerid, commodityid, bs_flag, price, holdqty, openqty, holdtime, holdmargin, firmid, gageqty, holdassure, floatingloss,0,v_Payout_one,v_Fee_one,v_closeFL_one,v_CloseAddedTax_one,p_Price,2, holdtype, atcleardate
              from t_holdposition
              where A_HoldNo=v_A_HoldNo;

              update T_SettleHoldPosition set HoldQty=v_tradedAmount,GageQty=v_tradedAmountGage where ID=v_ID;

                  --���³ֲּ�¼
                    update T_holdposition
                    set holdqty = holdqty - v_tradedAmount,HoldMargin=HoldMargin-v_Margin_one,HoldAssure=HoldAssure-v_Assure_one,GageQty = GageQty - v_tradedAmountGage
                    where a_holdno = v_a_holdno;

                  v_unCloseQty:=v_unCloseQty - v_tradedAmount;
                  v_unCloseQtyGage:=v_unCloseQtyGage - v_tradedAmountGage;
                  exit when v_unCloseQty=0 and v_unCloseQtyGage=0;
                end if;
            end loop;
            close v_HoldPosition;
            if(v_unCloseQty>0) then --���ճֲ��������ڿɽ��ճֲ�����
                rollback;
                return -3;
            end if;
            if(v_unCloseQtyGage>0) then --���յֶ��������ڿɵֶ�����
                rollback;
                return -4;
            end if;
    --���ٽ��׿ͻ��������̵ĳֲֺϼ���Ϣ2009-10-15
        v_num := FN_T_SubHoldSum(p_HoldQty,p_GageQty,v_Margin,v_Assure,v_CommodityID,v_ContractFactor,v_BS_Flag,v_FirmID,v_HoldFunds,v_CustomerID,v_CustomerHoldFunds,v_GageMode,0);

    --д�ϼƵ���ˮ
        --�۳����ջ���,ͬʱ�˱�֤��͵�����
        update T_Firm
        set runtimemargin = runtimemargin - v_Margin,
            RuntimeAssure = RuntimeAssure - v_Assure
        where Firmid = v_FirmID;
        --���¶����ʽ��ͷŸ��˲��ֵı�֤��
    v_F_FrozenFunds := FN_F_UpdateFrozenFunds(v_FirmID,-(v_Margin-v_Assure),'15');
        --����۳����ջ����ʽ���ˮ
    v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15008',v_Payout,null,v_CommodityID,null,null);
        --�����ʽ�,ͬʱ���뽻���������ʽ���ˮ
    --��������ѵ�����ͽ��������ѣ�����ͽ�����������ȡ�����ҽ��˽��������һ����ϸ�������Ѹ��³ɼ��ϲ���������
    if(v_ID is not null) then  --��ʾ�������гֲ����˽��գ���Ϊ���жϵ�û�гֲ�ʱҲ����ȡ��ͽ��������ѵ�
        if(v_Fee >= v_LowestSettleFee) then
            v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15010',v_Fee,null,v_CommodityID,null,null);
      else
          v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15010',v_LowestSettleFee,null,v_CommodityID,null,null);
            update T_SettleHoldPosition
            set SettleFee=SettleFee+(v_LowestSettleFee-v_Fee)
            where ID=v_ID;
        end if;
      end if;
    --�����ʽ�����д������ӯ�����ս��տ�����ˮ( ��Ʒ����˰�������ڼ�Ҫ���п�˰ )
    --��Ʒ������˰��������˰
   /* if(v_TaxInclusive=1) then
    if(v_CloseFL >= 0) then
      v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15011',v_CloseFL,null,v_CommodityID,v_CloseAddedTax,null);
    else
      v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15012',-v_CloseFL,null,v_CommodityID,-v_CloseAddedTax,null);
    end if;
    end if;*/

    ---xief 20150811
    if(v_CloseFL >= 0) then
      v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15011',v_CloseFL,null,v_CommodityID,null,null);
    else
      v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15012',-v_CloseFL,null,v_CommodityID,null,null);
    end if;

    return 1;

end;
/

prompt
prompt Creating function FN_T_COMPUTEFPSUBTAX
prompt ======================================
prompt
create or replace function FN_T_ComputeFPSubTax(
    p_EvenPrice         number, --�ֲ־���
    p_Price         number, --�����
    p_HoldQty number, --�ֲ�����
    p_ContractFactor    number, --��Լ����
    p_BS_Flag number, --������־
	p_AddedTax number,--��ֵ˰��
    p_FloatingProfitSubTax number --����ӯ���Ƿ��˰  0����˰��1��˰
) return number
/****
 * ���㸡��ӯ��
 * ����ֵ �ɹ����ظ���ӯ��
****/
as
	v_version varchar2(10):='1.0.0.1';
    v_FL_new number(15,2) default 0;
begin
    --���㸡��ӯ��
    if(p_BS_Flag = 1) then
      v_FL_new := (p_Price-p_EvenPrice)*p_HoldQty*p_ContractFactor;
    else
      v_FL_new := (p_EvenPrice-p_Price)*p_HoldQty*p_ContractFactor;
    end if;
    if(p_FloatingProfitSubTax=1) then
    	v_FL_new := v_FL_new/(1+p_AddedTax);
    end if;
    return v_FL_new;
end;
/

prompt
prompt Creating function FN_T_UPDATEFLOATINGLOSS
prompt =========================================
prompt
create or replace function FN_T_UpdateFloatingLoss(
    p_b_firmid varchar2,  --��ʼ������
    p_e_firmid varchar2,  --��ֹ������
    p_LastTime timestamp  --�ϴθ���ʱ�䣬null��ʾȫ������
) return timestamp
/****
 * ���¸���
 * ���ظ���ʱ��
****/
as
    v_version varchar2(10):='1.0.0.10';
    v_b_firmid varchar2(32);    --��ʼ������
    v_e_firmid varchar2(32);    --��ֹ������
    v_price      number(15,2);  --��������
    v_lasttime timestamp;
    v_FloatingLossComputeType number(2);
    v_FloatingProfitSubTax number(1);
    v_F_FrozenFunds number(15,2);
    v_fl number(15,2);
    v_Status         number(2);
    v_GageMode number(2);--�ֶ�ģʽ����0ȫ�ֶ���1��ֶ�����ֶ�ʱҪ���㸡����2009-10-14
begin
	select FloatingLossComputeType,FloatingProfitSubTax,GageMode into v_FloatingLossComputeType,v_FloatingProfitSubTax,v_GageMode from T_A_Market;
	--2009-09-08 ÿ���޸�ծ��ʽ�����׽����������󰴵��ս������ӯ�������������ۣ�������Ҫ״̬
	--���ÿ���޸�ծ��ʽ�ڽ��׽��������������ֶ�������ҵ�񣬵��ô˸����������ְ������ۼ��������
    if(v_FloatingLossComputeType = 4) then
        select Status into v_Status from T_SystemStatus;
    end if;
    v_b_firmid := p_b_firmid;
    if(v_b_firmid is null) then
        v_b_firmid := '0';
    end if;
    v_e_firmid := p_e_firmid;
    if(v_e_firmid is null) then
        v_e_firmid := 'zzzzzzzzzz';
    end if;
    if(p_lasttime is null) then
        v_lasttime := to_date('2000-01-01','yyyy-MM-dd');
    else
        v_lasttime := p_lasttime;
    end if;

    for commodity in (select c.AddedTax,c.ContractFactor,c.MarginAlgr,c.MarginRate_B,c.MarginRate_S,c.lastprice,q.commodityid,q.price,q.createtime
                      from T_Commodity c,T_Quotation q where c.CommodityID=q.CommodityID and q.createtime>v_lasttime order by q.createtime)
    loop
        if(commodity.createtime>v_lasttime) then
            v_lasttime:=commodity.createtime;
        end if;

        if(v_FloatingLossComputeType = 4) then  --���в���ӯ������ÿ���޸�ծ
        	if(v_Status=3 or v_Status=10) then  --���׽����������󰴵��ս������ӯ��������������
            	v_price := commodity.price;
            else
            	v_price := commodity.lastprice;
            end if;
    	else
      	    v_price := commodity.price;
        end if;

        for holdsum in (select rowid,floatingloss,bs_flag,HoldQty,GageQty,EvenPrice from T_Firmholdsum
                        where CommodityID=commodity.CommodityID and firmid>=v_b_firmid and firmid<=v_e_firmid)
        loop
            if(holdsum.bs_flag=1) then
                if(commodity.MarginRate_B = -1 or (commodity.MarginAlgr=1 and commodity.MarginRate_B >= 1)) then
                    v_fl := 0;
                else
                    --v_fl := (v_Price-holdsum.EvenPrice)*holdsum.HoldQty*commodity.ContractFactor;
                    if(v_GageMode=1) then --��ֶ�
                    	v_fl := FN_T_ComputeFPSubTax(holdsum.EvenPrice,v_Price,holdsum.HoldQty+holdsum.GageQty,commodity.ContractFactor,holdsum.bs_flag,commodity.AddedTax,v_FloatingProfitSubTax);
                    else  --ȫ�ֶ�
                    	v_fl := FN_T_ComputeFPSubTax(holdsum.EvenPrice,v_Price,holdsum.HoldQty,commodity.ContractFactor,holdsum.bs_flag,commodity.AddedTax,v_FloatingProfitSubTax);
                    end if;
                end if;
            end if;
            if(holdsum.bs_flag=2) then
                if(commodity.MarginRate_S = -1 or (commodity.MarginAlgr=1 and commodity.MarginRate_S >= 1)) then
                    v_fl := 0;
                else
                    --v_fl := (holdsum.EvenPrice-v_Price)*holdsum.HoldQty*commodity.ContractFactor;
                    if(v_GageMode=1) then --��ֶ�
                    	v_fl := FN_T_ComputeFPSubTax(holdsum.EvenPrice,v_Price,holdsum.HoldQty+holdsum.GageQty,commodity.ContractFactor,holdsum.bs_flag,commodity.AddedTax,v_FloatingProfitSubTax);
                    else  --ȫ�ֶ�
                    	v_fl := FN_T_ComputeFPSubTax(holdsum.EvenPrice,v_Price,holdsum.HoldQty,commodity.ContractFactor,holdsum.bs_flag,commodity.AddedTax,v_FloatingProfitSubTax);
                    end if;
                end if;
            end if;

            if(holdsum.floatingloss<>v_fl) then
                update T_Firmholdsum set floatingloss = v_fl where rowid=holdsum.rowid;
                commit;
            end if;
        end loop;
        /*
        --�������⽻���̣���ʱע�͵���һ�㲻����ִ����
		--��
        for firmMargin_b in (
        	 select b.firmid,b.commodityid
             from T_A_FirmMargin b,(select commodityid from T_Quotation where createtime>v_lasttime order by createtime) c
             where b.firmid>=v_b_firmid and b.firmid<=v_e_firmid and b.commodityid=c.commodityid
             and (b.marginrate_b=-1 or (b.MarginAlgr=1 and b.MarginRate_B >= 1))
             )
        loop
        	select floatingloss into v_fl from T_Firmholdsum where firmid=firmMargin_b.firmid and commodityid=firmMargin_b.commodityid and bs_flag=1;
            if(v_fl<>0) then
                update T_Firmholdsum set floatingloss = 0 where firmid=firmMargin_b.firmid and commodityid=firmMargin_b.commodityid and bs_flag=1;
                commit;
            end if;
        end loop;
		--����
        for firmMargin_s in (
        	 select b.firmid,b.commodityid
             from T_A_FirmMargin b,(select commodityid from T_Quotation where createtime>v_lasttime order by createtime) c
             where b.firmid>=v_b_firmid and b.firmid<=v_e_firmid and b.commodityid=c.commodityid
             and (b.marginrate_s=-1 or (b.MarginAlgr=1 and b.MarginRate_S >= 1))
             )
        loop
        	select floatingloss into v_fl from T_Firmholdsum where firmid=firmMargin_s.firmid and commodityid=firmMargin_s.commodityid and bs_flag=2;
            if(v_fl<>0) then
                update T_Firmholdsum set floatingloss = 0 where firmid=firmMargin_s.firmid and commodityid=firmMargin_s.commodityid and bs_flag=2;
                commit;
            end if;
        end loop;
		*/
    end loop;

    if(p_lasttime is null or v_lasttime <> p_lasttime) then
        if(v_FloatingLossComputeType = 0) then     --��Ʒ������
            for fz in (select a.firmid,a.FloatingLoss-b.runtimefl diff
                 from (select firmid,sum(case when FloatingLoss>0 then 0 else -FloatingLoss end) FloatingLoss from
                       T_FirmHoldSum where firmid>=v_b_firmid and firmid<=v_e_firmid group by firmid) a,
                       t_firm b where a.firmid=b.firmid)
            loop
                if(fz.diff <> 0) then
                    update T_Firm
                    set RuntimeFL = RuntimeFL + fz.diff
                    where FirmID = fz.firmid;
                    --���¶����ʽ��ͷŻ�۳��仯�ĸ���
      			        v_F_FrozenFunds := FN_F_UpdateFrozenFunds(fz.firmid,fz.diff,'15');
                    commit;
                end if;
            end loop;
        elsif(v_FloatingLossComputeType = 1) then  --��Ʒ��������
            for fz in (select a.firmid,a.FloatingLoss-b.runtimefl diff
                   from (select firmid,sum(case when FloatingLoss>0 then 0 else -FloatingLoss end) FloatingLoss from
                          (select firmid,sum(FloatingLoss) FloatingLoss from T_FirmHoldSum
                           where firmid>=v_b_firmid and firmid<=v_e_firmid group by firmid,commodityID) group by firmid
                        ) a,t_firm b where a.firmid=b.firmid)
            loop
                if(fz.diff <> 0) then
                    update T_Firm
                    set RuntimeFL = RuntimeFL + fz.diff
                    where FirmID = fz.firmid;
                    --���¶����ʽ��ͷŻ�۳��仯�ĸ���
      			        v_F_FrozenFunds := FN_F_UpdateFrozenFunds(fz.firmid,fz.diff,'15');
                    commit;
                end if;
            end loop;
  			elsif(v_FloatingLossComputeType = 2) then  --������Ʒ
            for fz in (select a.firmid,a.FloatingLoss-b.runtimefl diff
                       from ( select firmid,case when sum(FloatingLoss)>0 then 0 else -sum(FloatingLoss) end FloatingLoss
                              from T_FirmHoldSum where firmid>=v_b_firmid and firmid<=v_e_firmid group by firmid) a,
                         t_firm b where a.firmid=b.firmid)
            loop
                if(fz.diff <> 0) then
                    update T_Firm
                    set RuntimeFL = RuntimeFL + fz.diff
                    where FirmID = fz.firmid;
                    --���¶����ʽ��ͷŻ�۳��仯�ĸ���
      			        v_F_FrozenFunds := FN_F_UpdateFrozenFunds(fz.firmid,fz.diff,'15');
                    commit;
                end if;
            end loop;
  			elsif(v_FloatingLossComputeType = 3 or v_FloatingLossComputeType = 4) then  --������ӯ������ӯ��
            for fz in (select a.firmid,a.FloatingLoss-b.runtimefl diff
                       from ( select firmid,-sum(FloatingLoss) FloatingLoss
                              from T_FirmHoldSum where firmid>=v_b_firmid and firmid<=v_e_firmid group by firmid) a,
                         t_firm b where a.firmid=b.firmid)
            loop
                if(fz.diff <> 0) then
                    update T_Firm
                    set RuntimeFL = RuntimeFL + fz.diff
                    where FirmID = fz.firmid;
                    --���¶����ʽ��ͷŻ�۳��仯�ĸ���
      			        v_F_FrozenFunds := FN_F_UpdateFrozenFunds(fz.firmid,fz.diff,'15');
                    commit;
                end if;
            end loop;
  			end if;
    end if;

    return v_lasttime;
end;
/

prompt
prompt Creating function FN_T_AHEADSETTLE
prompt ==================================
prompt
create or replace function FN_T_AheadSettle(
    p_ApplyID       number,     --���뵥��
    p_CommodityID varchar2, --��Ʒ����
    p_BillID         varchar2, --�ֵ���
    p_Quantity      number,   --�ֵ������������������������ֶ���
 	p_Price         number,  --���ռ�
	p_sCustomerID    varchar2,     --�������׿ͻ�ID
	p_sGageQty      number default 0,    --���������յֶ�����
    p_bCustomerID    varchar2,     --�򷽽��׿ͻ�ID
 	p_bGageQty      number default 0,   --�������յֶ�������ҵ���ϲ����ڴ˲�����ʵ���ϱ���
    p_Modifier      varchar2,   --������
	p_ApplyType     number,    --��������:3�����вֵ�ת��ǰ����;6����ǰ����
	p_ValidID       number    --��Ч�ֵ��ţ�ֻ����������Ϊ3�����вֵ�ת��ǰ���ղ���Ҫ
) return number
/****
 * ��ǰ����
 * ����ֵ
 * 1 �ɹ�
 * 2 �Ѵ����
 * -1  �ɽ�����ֲ���������
 * -2  �ɽ�����ֶ���������
 * -3  ������ֲ��������ڿɽ�����ֲ�����
 * -4  ������ֶ��������ڿ���ֶ�����
 * -11  �ɽ������ֲ���������
 * -12  �ɽ������ֶ���������
 * -13  �������ֲ��������ڿɽ������ֲ�����
 * -14  �������ֶ��������ڿ����ֶ�����
 * -100 ��������
****/
as
 	v_version varchar2(10):='1.0.0.9';
 	v_FirmID varchar2(10);      --����������ID
	v_bFirmID varchar2(10);      --�򷽽�����ID
    bRet            number(5);
    sRet            number(5);
    v_FL_ret            timestamp;
    v_num            number(10);
    v_errorcode      number;
    v_errormsg       varchar2(200);
    v_Payout         number(15,2):=0;
    v_ContractFactor T_Commodity.ContractFactor%type;
begin
 	bRet := FN_T_AheadSettleOne(p_CommodityID,p_Price,1,p_bCustomerID,p_Quantity-p_bGageQty,p_bGageQty); --��
 	if(bRet = 1) then
  		sRet := FN_T_AheadSettleOne(p_CommodityID,p_Price,2,p_sCustomerID,p_Quantity-p_sGageQty,p_sGageQty);  --��
  		if(sRet = 1) then
	        --������Ч�ֵ������������вֵ�ת��ǰ���ջ�����ǰ���ն�Ӧ�ò������������Ч�ֵ�
            select FirmID into v_FirmID from T_Customer where CustomerID=p_sCustomerID;--�ҳ�����������ID
   			--2009-09-08������ǰ�������ֱ�Ӳ��뽻����Ա�
   			--1�������򷽽��ջ���
   			select FirmID into v_bFirmID from T_Customer where CustomerID=p_bCustomerID;--�ҳ��򷽽�����ID
	        v_Payout := FN_T_ComputePayout(v_bFirmID,p_CommodityID,1,p_Quantity,p_Price);
            if(v_Payout < 0) then
                Raise_application_error(-20043, 'computePayout error');
            end if;
            --2�����뽻����Ա���ǰ���ղ����㽻�ձ�֤��
            select ContractFactor into v_ContractFactor from T_Commodity where CommodityID=p_CommodityID;
			insert into T_SettleMatch (MatchID,CommodityID,ContractFactor,Quantity,HL_Amount,Status,Result,FirmID_B,BuyPrice,BuyPayout_Ref,BuyPayout,BuyMargin,TakePenalty_B,PayPenalty_B,SettlePL_B,
			   		FirmID_S,SellPrice,SellIncome_Ref,SellIncome,SellMargin,TakePenalty_S,PayPenalty_S,SettlePL_S,CreateTime,ModifyTime)
			   		values ('ATS_'||seq_T_SettleMatch.nextVal,p_CommodityID,v_ContractFactor,p_Quantity,0,0,1,v_bFirmID,p_Price,p_Quantity*p_Price*v_ContractFactor,v_Payout,0,0,0,0,
			   		v_FirmID,p_Price,p_Quantity*p_Price*v_ContractFactor,0,0,0,0,0,sysdate,sysdate);

   			commit;
   			--�ύ���������˫������
   			v_FL_ret := FN_T_UpdateFloatingLoss(null,null,null);

      		return 1;
     	elsif(sRet = -1) then
      		rollback;
   			return -11;
  		elsif(sRet = -2) then
      		rollback;
   			return -12;
  		elsif(sRet = -3) then
      		rollback;
   			return -13;
  		elsif(sRet = -4) then
      		rollback;
   			return -14;
  		else
      		rollback;
   			return -100;
  		end if;
 	else
  		rollback;
  		return bRet;
 	end if;
exception
    when OTHERS then
    v_errorcode:=sqlcode;
    v_errormsg :=sqlerrm;
    rollback;
    insert into T_DBLog(err_date,name_proc,err_code,err_msg)
    values(sysdate,'FN_T_AheadSettle',v_errorcode,v_errormsg);
    commit;
    return -100;
end;
/

prompt
prompt Creating function FN_T_COMPUTESETTLEMARGIN
prompt ==========================================
prompt
create or replace function FN_T_ComputeSettleMargin(
    p_FirmID varchar2,
    p_CommodityID varchar2,
    p_bs_flag        number,
    p_quantity number,
    p_price number
) return number
/****
 * ���㽻�ձ�֤��
 * ����ֵ �ɹ����ؽ��ձ�֤��;-1 �����������ݲ�ȫ;-100 ��������
****/
as
	v_version varchar2(10):='1.0.0.1';
    v_marginRate_b         number(10,4);
    v_marginRate_s         number(10,4);
    v_marginAlgr_b         number(2);
    v_marginAlgr_s         number(2);
    v_contractFactor     number(12,2);
    v_margin             number(15,2) default 0;
    v_settleMarginType number;   --���ձ�֤����㷽ʽ
    v_BeforeDays number;   --��ǰ����
    v_price number;
    tradeFundSum         number(15,2);
    tradeQtySum  number(10);
    v_SettleDate date;
    v_num            number(10);
    v_Quantity  number(10);
    i            number(4);
begin
select settleMargintype into v_settleMarginType from t_commodity where commodityid=p_CommodityID;--��ѯ���ձ�֤����㷽ʽ  add by lizhenli 2011-12-5
if(v_settleMarginType = 0) then  --�������յı��н����
	    --�ҳ������յ���������
	    begin
	    	select nvl(Price,0) into v_price from T_Quotation where CommodityID=p_CommodityID;
	    exception
	        when NO_DATA_FOUND then
	            select nvl(Price,0) into v_price from T_H_Quotation where CommodityID=p_CommodityID and ClearDate in(select max(ClearDate) from T_H_Quotation where CommodityID=p_CommodityID);
	    end;
      elsif(v_settleMarginType = 1) then  --��������ǰ���յı��н���۵ļ�Ȩƽ����
		--�ҳ���ǰ�գ���������
	    select SettleDate,BeforeDays_M into v_SettleDate,v_BeforeDays from T_Commodity where CommodityID=p_CommodityID;
        tradeQtySum := 0;
        tradeFundSum := 0;
        --�ж��Ƿ��ʽ������ɣ�������״̬����Ϊ��������ʱ״̬��仯
        --����ʽ������ɵĻ���ǰ�ɽ���ɾ�����Ӷ����µ���ļ۸�û�в������ 2010-05-24 by chenxc
        select count(*) into v_num from T_H_Quotation where CommodityID=p_CommodityID and ClearDate = v_SettleDate;
        if(v_num = 0) then
		    --�ӵ�ǰ���м��㽻�ս�������
		    begin
		    	select nvl(Price,0) into v_price from T_Quotation where CommodityID=p_CommodityID;
		    	select nvl(sum(Quantity),0) into v_Quantity from T_Trade where CommodityID=p_CommodityID;
		    	tradeFundSum := tradeFundSum + v_price*v_Quantity;
				tradeQtySum := tradeQtySum + v_Quantity;
		    	i := 1;
		    exception
		        when NO_DATA_FOUND then
		           i := 0;
		    end;
        else
			i := 0;
		end if;
	    --ѭ�����㽻����ǰ��v_BeforeDays�Ľ������������������յ����v_BeforeDays�Ľ�������
        while i<v_BeforeDays loop
        	--����������ж��Ǳ�ʾ������õ���ǰ���յļ�Ȩ�۵���������ʵ�ʵĽ�������ʱ�����ѭ�����������ķ�Χ��Ҳ�������õ��������ڽ��������򰴽������������Ȩ�۸�
            if(v_BeforeDays>=999 or i>=999) then
            	exit;
   			end if;
		    --����ʷ���м��㽻�ս�������
		    begin
		    	select nvl(Price,0) into v_price from T_H_Quotation where CommodityID=p_CommodityID and ClearDate = v_SettleDate-i;
		    	select nvl(sum(Quantity),0) into v_Quantity from T_H_Trade where CommodityID=p_CommodityID and ClearDate = v_SettleDate-i;
		    	tradeFundSum := tradeFundSum + v_price*v_Quantity;
		    	tradeQtySum := tradeQtySum + v_Quantity;
		    exception
		        when NO_DATA_FOUND then
		            v_BeforeDays := v_BeforeDays + 1;
		    end;
            i := i+1;
        end loop;
        --�����Ȩƽ���ۣ��������Ϊ0�Ļ������������Ľ��ռ�
		if(tradeQtySum <> 0) then
        	v_price := round(tradeFundSum/tradeQtySum,0);
        end if;

        else   --����������ۡ���ʹ�ô��ݹ����ļ۸�
        v_price:=p_price;
     end if;
    --��ȡ��Ʒ��Ϣ����Լ���ӣ����ձ�֤��ϵ�������ձ�֤���㷨
    select Settlemarginrate_b,Settlemarginrate_s,SettleMarginAlgr_B,SettleMarginAlgr_S,contractfactor
    into v_marginRate_b,v_marginRate_s,v_marginAlgr_b,v_marginAlgr_s,v_contractFactor
    from T_Commodity where CommodityID=p_CommodityID;

    begin
        --��ȡ����Ľ��ձ�֤��ϵ�������ձ�֤���㷨
        select Settlemarginrate_b,Settlemarginrate_s,SettleMarginAlgr_B,SettleMarginAlgr_S
    	into v_marginRate_b,v_marginRate_s,v_marginAlgr_b,v_marginAlgr_s
        from T_A_FirmSettleMargin
        where FirmID=p_FirmID and CommodityID=p_CommodityID;
    exception
        when NO_DATA_FOUND then
            null;
    end;
    --���ձ�֤���㷨������
    if(p_bs_flag = 1) then  --��
		if(v_marginAlgr_b = 1) then  --Ӧ�ս��ձ�֤��=����*��Լ����*�۸�*���ձ�֤��ϵ��
			if(v_marginRate_b = -1) then --  -1��ʾ��ȫ��
				v_margin:=p_quantity*v_contractFactor*v_price;
			else
        		v_margin:=p_quantity*v_contractFactor*v_price*v_marginRate_b;
        	end if;
        elsif(v_marginAlgr_b = 2) then  --Ӧ�ս��ձ�֤��=����*���ձ�֤��ϵ��
			if(v_marginRate_b = -1) then --  -1��ʾ��ȫ��
				v_margin:=p_quantity*v_contractFactor*v_price;
			else
				v_margin:=p_quantity*v_marginRate_b;
			end if;
        end if;
    elsif(p_bs_flag = 2) then  --��
    	if(v_marginAlgr_s = 1) then  --Ӧ�ս��ձ�֤��=����*��Լ����*�۸�*���ձ�֤��ϵ��
			if(v_marginRate_s = -1) then --  -1��ʾ��ȫ��
				v_margin:=p_quantity*v_contractFactor*v_price;
			else
        		v_margin:=p_quantity*v_contractFactor*v_price*v_marginRate_s;
        	end if;
        elsif(v_marginAlgr_s = 2) then  --Ӧ�ս��ձ�֤��=����*���ձ�֤��ϵ��
			if(v_marginRate_s = -1) then --  -1��ʾ��ȫ��
				v_margin:=p_quantity*v_contractFactor*v_price;
			else
				v_margin:=p_quantity*v_marginRate_s;
			end if;
        end if;
    end if;
    if(v_margin is null) then
    	rollback;
        return -1;
    end if;
    return v_margin;
exception
    when no_data_found then
    	rollback;
        return -1;
    when others then
    	rollback;
    	return -100;
end;
/

prompt
prompt Creating function FN_T_AHEADSETTLEONEQTY
prompt ========================================
prompt
create or replace function FN_T_AheadSettleOneQty(
  p_ApplyID   varchar2,    --������Ա��
  p_CommodityID varchar2,   --��Ʒ����
  p_Price         number,  --���ռ�
  p_BS_Flag     number,  --������־
    p_CustomerID    varchar2,     --���׿ͻ�ID
    p_OCustomerID    varchar2,     --�Է����׿ͻ�ID
    p_HoldQty      number,   --���ճֲ����������ǵֶ�����
  p_GageQty      number   --���յֶ�����
) return number
/****
 * ������������ǰ����
 * 1��ע�ⲻҪ�ύcommit����Ϊ��ĺ���Ҫ��������
 * ����ֵ
 * 1 �ɹ�
 * -1  �ɽ��ճֲ���������
 * -2  �ɽ��յֶ���������
 * -3  ���ճֲ��������ڿɽ��ճֲ�����
 * -4  ���յֶ��������ڿɵֶ�����
 * -100 ��������
****/
as
  v_version varchar2(10):='1.0.2.1';
    v_CommodityID varchar2(16);
    v_CustomerID        varchar2(40);
    v_FirmID varchar2(32);
    v_HoldQty  number;
    v_HoldSumQty     number(10);
    v_frozenQty      number(10);
    v_Margin         number(15,2):=0;
    v_Margin_one         number(15,2):=0;
    v_closeFL_one         number(15,2):=0;    --һ����¼�Ľ���ӯ��
    v_CloseFL         number(15,2):=0;        --����ӯ���ۼ�
    v_Fee_one         number(15,2):=0;    --һ����¼�Ľ���������
    v_Fee         number(15,2):=0;        --�����������ۼ�
  v_Assure         number(15,2):=0;
  v_Assure_one         number(15,2):=0;
    v_Payout         number(15,2):=0;
    v_Payout_one         number(15,2):=0;
    v_BS_Flag           number(2);
    v_Price         number(15,2);
    v_ContractFactor    number(12,2);
    v_MarginPriceType           number(1);
    v_MarginPrice    number(15,2);  --����ɽ���֤��ļ۸�
  v_HoldFunds    number(15,2):=0;  --ƽ��ʱӦ�˳ֲֽ��������ֶ���
  v_CustomerHoldFunds    number(15,2):=0;  --ƽ��ʱӦ�˳ֲֽ������ֶ���
    v_TradeDate date;
  v_A_HoldNo number(15);
  v_ID number(15);
  v_AddedTaxFactor T_Commodity.AddedTaxFactor%type;--��ֵ˰��ϵ��=AddedTax/(1+AddedTax)
  v_GageQty     number(10);
  v_CloseAddedTax_one   number(15,2); --����ӯ����ֵ˰
  v_CloseAddedTax         number(15,2):=0;        --����ӯ����ֵ˰�ۼ�
  v_unCloseQty     number(10):=p_HoldQty; --δƽ�����������м����
  v_unCloseQtyGage     number(10):=p_GageQty; --δƽ�����������м����
  v_tradedAmount   number(10):=0;  --�ɽ�����
  v_tradedAmountGage   number(10):=0;  --�ɽ�����
  v_CloseAlgr           number(2);
  v_num            number(10);
  v_Balance    number(15,2);
  v_F_FrozenFunds   number(15,2);
  type cur_T_HoldPosition is ref cursor;
  v_HoldPosition cur_T_HoldPosition;
  v_sql varchar2(500);
  v_orderby  varchar2(100);
  v_closeTodayHis        number(2);    --ƽ��ֻ�����ʷ��(0ƽ��֣�1ƽ��ʷ��)
  v_YesterBalancePrice    number(15,2);
  v_AtClearDate          date;
  v_LowestSettleFee             number(15,2) default 0;
  v_GageMode number(2);--�ֶ�ģʽ����0ȫ�ֶ���1��ֶ�����ֶ�ʱҪ���㸡����2009-10-14

  v_GageFrozenQty number(10);--add by yukx 20100428 �ֶ���������

  v_IsChargeMargin number(2);-- �Ƿ���ȡ���ձ�֤��(0 ����ȡ��1��ȡ)  add by zhangjian- 20110713
  v_SettlementMargin_one     number(15,2):=0;-- ���ձ�֤��
  v_SettlementMargin     number(15,2):=0;-- ���ձ�֤���ۼ�
  v_aheadSettlePriceType number(2);--��ǰ���ռ۸����� 0:�������۽��� 1���������۽���
  v_settlePrice number(15,2);--���ռ۸�
  v_settleMachID number(10):=0;--���ճֲ���ϸ�� ID
  v_totalRef         number(15,2):=0;  --��׼�������ֵ
  v_bFirmID   varchar2(32);  --�򷽽�����ID
  v_SettlementMargin_B      number(15,2):=0; --�򷽽��ձ�֤��
  v_settlePirce_B    number(15,6):=0;--�򷽽��ռ۸�
  v_bPayout         number(15,2):=0; --�򷽻���
   v_TaxInclusive     number(1);   --��Ʒ�Ƿ�˰ 0��˰  1����˰   duanbaodi 20150730
begin
    v_CustomerID := p_CustomerID;
      v_CommodityID := p_CommodityID;
        v_BS_Flag := p_BS_Flag;
        --��ס���׿ͻ��ֲֺϼƣ��Է�ֹ��������
        select HoldQty,FrozenQty,GageQty,GageFrozenQty
        into v_HoldSumQty, v_frozenQty,v_GageQty,v_GageFrozenQty
        from T_CustomerHoldSum
        where CustomerID = v_CustomerID
          and CommodityID = v_CommodityID
          and bs_flag = v_BS_Flag for update;
        /*  �ɽ��ճֲ���������Ϳɽ��յֶ�����������ж��ö��������͵ֶ����������ж�
        --�ɽ��ճֲ���������
        if(p_HoldQty > v_HoldSumQty-v_frozenQty) then
            rollback;
            return -1;
        end if;
        --�ɽ��յֶ���������
        if(p_GageQty > v_GageQty) then
            rollback;
            return -2;
        end if;
        */
        --�ɽ��ճֲ���������
        if(p_HoldQty > v_frozenQty) then
            rollback;
            return -1;
        end if;
        --�ɽ��յֶ���������
        if(p_GageQty > v_GageFrozenQty) then
            rollback;
            return -2;
        end if;
         --select   seq_T_SettleMatch.nextVal into v_settleMachNumber from dual;
         --v_settleMachNumber:=p_settleMachNumber;

        --��ȡƽ���㷨,�ֶ�ģʽ,�Ƿ���ȡ���ձ�֤�� , ��֤��������ͣ���ֵ˰����Լ����,�Ƿ�˰
        select CloseAlgr,GageMode,ASMarginType into v_CloseAlgr,v_GageMode,v_IsChargeMargin from T_A_Market;
       /* select Contractfactor,MarginPriceType,AddedTaxFactor,LastPrice,LowestSettleFee
        into v_ContractFactor,v_MarginPriceType,v_AddedTaxFactor,v_YesterBalancePrice,v_LowestSettleFee
        from T_Commodity where CommodityID=v_CommodityID;   duanbaodi 20150730 */

         select Contractfactor,MarginPriceType,AddedTaxFactor,LastPrice,LowestSettleFee,TaxInclusive
        into v_ContractFactor,v_MarginPriceType,v_AddedTaxFactor,v_YesterBalancePrice,v_LowestSettleFee,v_TaxInclusive
        from T_Commodity where CommodityID=v_CommodityID;  -- ���� �Ƿ�˰�ֶβ�ѯ duanbaodi 20150730

      select TradeDate into v_TradeDate from T_SystemStatus;

        --����ƽ���㷨(0�ȿ���ƽ��1����ƽ��2�ֲ־���ƽ��(������)ѡ����������
        if(v_CloseAlgr = 0) then
         v_orderby := ' order by a.A_HoldNo ';
        elsif(v_CloseAlgr = 1) then
           v_orderby := ' order by a.A_HoldNo desc ';
       end if;

         select  aheadSettlePriceType  into v_aheadSettlePriceType from t_commodity  where commodityid=p_CommodityID;--��ȡ��ǰ���ս��ռ۸�����


      v_sql := 'select  a.a_holdno,FirmID,price,(a.HoldQty-nvl(b.FrozenQty,0)),GageQty,nvl(b.FrozenQty,0),a.AtClearDate from T_holdposition a,(select A_HoldNo,nvl(sum(FrozenQty),0) FrozenQty from T_SpecFrozenHold group by A_HoldNo) b ' ||
                 ' where (a.HoldQty+a.GageQty) > 0 and a.A_HoldNo=b.A_HoldNo(+) and CustomerID=''' || v_CustomerID ||
                 ''' and CommodityID =''' || v_CommodityID || ''' and bs_flag = ' || v_BS_Flag || v_orderby;


         --�����ֲ���ϸ�����������˵�ָ��ƽ�ֶ��������
            open v_HoldPosition for v_sql;
            loop
                fetch v_HoldPosition into v_a_holdno, v_FirmID, v_price, v_holdqty,v_GageQty,v_frozenQty,v_AtClearDate;
                exit when v_HoldPosition%NOTFOUND;

                if(v_aheadSettlePriceType=0)then --����������۽���
                      v_settlePrice:=v_Price;
                      else                   --����������۽���
                       v_settlePrice:=p_Price;
                      end  if;

                --����˱ʳֲ�ȫ����ָ��ƽ�ֶ�����û�еֶ���ָ����һ����¼
              --2011-01-12 by chenxc �޸ĵ��ֲ���ϸ�ĳֲ�����Ϊ0���ֶ�������Ϊ0����ǰ���շǵֶ��Ļ����һ���ֲּ�¼����0�ĵ����ճֲ���ϸ����֮��Ȼ
                if((v_holdqty <> 0 and v_unCloseQty>0) or (v_GageQty <> 0 and v_unCloseQtyGage>0)) then
                  --��0
                  v_tradedAmount:=0;
                  v_tradedAmountGage:=0;
                  v_Payout_one := 0;
                  --1������Ӧ�˿���
                  if(v_holdqty > 0) then
                    if(v_holdqty<=v_unCloseQty) then
                        v_tradedAmount:=v_holdqty;
                    else
                        v_tradedAmount:=v_unCloseQty;
                    end if;
                    --����Ӧ�˱�֤�𣬸�������ѡ�񿪲ּۻ�������������
            if(v_MarginPriceType = 1) then
                  v_MarginPrice := v_YesterBalancePrice;
              elsif(v_MarginPriceType = 2) then
              --�ж���ƽ��ֻ���ƽ��ʷ��
                if(trunc(v_TradeDate) = trunc(v_AtClearDate)) then
                    v_closeTodayHis := 0;
                else
                  v_closeTodayHis := 1;
                end if;
              if(v_closeTodayHis = 0) then  --ƽ���
                v_MarginPrice := v_price;
              else  --ƽ��ʷ��
                    v_MarginPrice := v_YesterBalancePrice;
                end if;
            else  -- default type is 0
              v_MarginPrice := v_price;
            end if;
                    v_Margin_one := FN_T_ComputeMargin(v_FirmID,v_CommodityID,v_BS_Flag,v_tradedAmount,v_MarginPrice);
                    if(v_Margin_one < 0) then
                        Raise_application_error(-20040, 'computeMargin error');
                    end if;
                --���㵣����
                v_Assure_one := FN_T_ComputeAssure(v_FirmID,v_CommodityID,v_BS_Flag,v_tradedAmount,v_MarginPrice);
                if(v_Assure_one < 0) then
                    Raise_application_error(-20041, 'computeAssure error');
                end if;
                --��֤��Ӧ���ϵ�����
                v_Margin_one := v_Margin_one + v_Assure_one;
                    v_Margin:=v_Margin + v_Margin_one;
                    v_Assure:=v_Assure + v_Assure_one;
                  --����Ӧ�˳ֲֽ��������ֶ���
                  v_HoldFunds := v_HoldFunds + v_tradedAmount*v_price*v_ContractFactor;
                  end if;
                  --2������ֲ���ϸ�н��յĵֶ�����
          if(v_GageQty > 0) then
                    if(v_GageQty<=v_unCloseQtyGage) then
                        v_tradedAmountGage:=v_GageQty;
                    else
                        v_tradedAmountGage:=v_unCloseQtyGage;
                    end if;
                  end if;
              --����ǰ�ֶ�ģʽ�����ֲֽ̳��Ҫ�˵ֶ���
              if(v_GageMode=1) then
                v_HoldFunds := v_HoldFunds + v_tradedAmountGage*v_price*v_ContractFactor;
              end if;
                  --�����ͻ��ϼƽ������ֶ���
                  v_CustomerHoldFunds := v_CustomerHoldFunds + (v_tradedAmount+v_tradedAmountGage)*v_price*v_ContractFactor;
                --3�����㽻�տ���

         --�����г����������������Ƿ���ȡ���ձ�֤�� ---add by zhangjian start
         if(v_IsChargeMargin = 1 )then  --�����ȡ��֤��
          --���㽻�ձ�֤��
          v_SettlementMargin_one := FN_T_ComputeSettleMargin(v_FirmID,v_CommodityID,v_BS_Flag,v_tradedAmount+v_tradedAmountGage,v_settlePrice);
            if(v_SettlementMargin_one < 0) then
                Raise_application_error(-20042, 'ComputeSettleMargin error');
            end if;
         end if;   --add by zhangjian end


          --�����򷽽��ջ����ǰ���ղ����ս��ձ�֤��
          if(v_BS_Flag = 1) then
                v_Payout_one := FN_T_ComputePayout(v_FirmID,v_CommodityID,v_BS_Flag,v_tradedAmount+v_tradedAmountGage,v_settlePrice);
                  if(v_Payout_one < 0) then
                      Raise_application_error(-20043, 'computePayout error');
                  end if;
          end if;
          --���㽻��������
          v_Fee_one := FN_T_ComputeSettleFee(v_FirmID,v_CommodityID,v_BS_Flag,v_tradedAmount+v_tradedAmountGage,v_settlePrice);
                if(v_Fee_one < 0) then
                  Raise_application_error(-20031, 'computeFee error');
                end if;
                --����˰ǰ����ӯ��
                if(v_BS_Flag = 1) then
                    v_closeFL_one := (v_tradedAmount+v_tradedAmountGage)*(v_settlePrice-v_price)*v_contractFactor; --˰ǰӯ��
                else
                    v_closeFL_one := (v_tradedAmount+v_tradedAmountGage)*(v_price-v_settlePrice)*v_contractFactor; --˰ǰӯ��
                end if;
                --���㽻����ֵ˰,v_AddedTaxFactor��ֵ˰ϵ��=AddedTax/(1+AddedTax)
              --  v_CloseAddedTax_one := round(v_closeFL_one*v_AddedTaxFactor,2);   xief 20150811
                  v_CloseAddedTax_one := 0;
                --����˰����ӯ��
                --v_closeFL_one := v_closeFL_one - v_CloseAddedTax_one; --˰��ӯ��   duanbaodi 20150730   xief 20150811
               /* if(v_TaxInclusive = 1) then
                     --����˰ �۳���ֵ˰  duanbaodi 20150730
                     v_closeFL_one := v_closeFL_one - v_CloseAddedTax_one;
                end if ;
                */

          --�ۼƽ��
              v_Payout := v_Payout + v_Payout_one;
              v_Fee := v_Fee + v_Fee_one;
          v_CloseFL:=v_CloseFL + v_closeFL_one;  --˰��ӯ���ϼ�
          v_CloseAddedTax:=v_CloseAddedTax + v_CloseAddedTax_one;  --������ֵ˰�ϼ�
          v_SettlementMargin:=v_SettlementMargin + v_SettlementMargin_one; --���ձ�֤��ϼ� add by zhangjian
              --����ǰ�ֲּ�¼�ͽ��շ��ò��뽻�ճֲ���ϸ�������³ֲ������͵ֶ�����Ϊʵ�ʽ��յ�����
          select SEQ_T_SettleHoldPosition.nextval into v_ID from dual;
          --���ֶ������뽻�ճֲ���ϸ��
              insert into t_settleholdposition
            (id, settleprocessdate, a_holdno, a_tradeno, customerid, commodityid, bs_flag, price, holdqty, openqty, holdtime, holdmargin, firmid, gageqty, holdassure, floatingloss, settlemargin, payout, settlefee, settle_pl, settleaddedtax, settleprice, settletype, holdtype, atcleardate, MatchQuantity ,happenMATCHQTY)
              select v_ID,v_TradeDate,a_holdno, a_tradeno, customerid, commodityid, bs_flag, price, holdqty, openqty, holdtime, holdmargin, firmid, gageqty, holdassure, floatingloss,v_SettlementMargin_one,v_Payout_one,v_Fee_one,v_closeFL_one,v_CloseAddedTax_one,v_settlePrice,2, holdtype, atcleardate, holdqty, v_tradedAmount
              from t_holdposition
              where A_HoldNo=v_A_HoldNo;
           --�����Խ��ճֲ���ϸ�������ϵ  add by zhangjian 2011��12��15��13:16:45 start

           insert into T_MatchSettleholdRelevance values (p_ApplyID,v_ID,v_tradedAmount,v_settlePrice,v_Payout_one,v_SettlementMargin_one);

           --end  by zhangjian 2011��12��15��13:16:55

              update T_SettleHoldPosition set HoldQty=v_tradedAmount,GageQty=v_tradedAmountGage where ID=v_ID;

                  --���³ֲּ�¼
                    update T_holdposition
                    set holdqty = holdqty - v_tradedAmount,HoldMargin=HoldMargin-v_Margin_one,HoldAssure=HoldAssure-v_Assure_one,GageQty = GageQty - v_tradedAmountGage
                    where a_holdno = v_a_holdno;

                  v_unCloseQty:=v_unCloseQty - v_tradedAmount;
                  v_unCloseQtyGage:=v_unCloseQtyGage - v_tradedAmountGage;
                  exit when v_unCloseQty=0 and v_unCloseQtyGage=0;
                end if;

       end loop;
       close v_HoldPosition;
      if(v_unCloseQty>0) then --���ճֲ��������ڿɽ��ճֲ�����
          rollback;
          return -3;
      end if;
      if(v_unCloseQtyGage>0) then --���յֶ��������ڿɵֶ�����
          rollback;
          return -4;
      end if;
    --���ٽ��׿ͻ��������̵ĳֲֺϼ���Ϣ2009-10-15
        v_num := FN_T_SubHoldSum(p_HoldQty,p_GageQty,v_Margin,v_Assure,v_CommodityID,v_ContractFactor,v_BS_Flag,v_FirmID,v_HoldFunds,v_CustomerID,v_CustomerHoldFunds,v_GageMode,p_HoldQty);

    --д�ϼƵ���ˮ
        --�۳����ջ���ͽ��ձ�֤��,ͬʱ�˱�֤��͵����� --modify by zhangjian
        update T_Firm
        set runtimemargin = runtimemargin - v_Margin,
            RuntimeAssure = RuntimeAssure - v_Assure,
            RuntimeSettleMargin = RuntimeSettleMargin + v_SettlementMargin
        where Firmid = v_FirmID;
        --���¶����ʽ��ͷŸ��˲��ֵı�֤��
    v_F_FrozenFunds := FN_F_UpdateFrozenFunds(v_FirmID,-(v_Margin-v_Assure),'15');
        --����۳����ջ����ʽ���ˮ
    v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15008',v_Payout,null,v_CommodityID,null,null);
        --д���ձ�֤����ˮ add by zhangjian
        if(v_IsChargeMargin = 1 )then
    v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15013',v_SettlementMargin,null,v_CommodityID,null,null);
        end if;
        --�����ʽ�,ͬʱ���뽻���������ʽ���ˮ
    --��������ѵ�����ͽ��������ѣ�����ͽ�����������ȡ�����ҽ��˽��������һ����ϸ�������Ѹ��³ɼ��ϲ���������
    if(v_ID is not null) then  --��ʾ�������гֲ����˽��գ���Ϊ���жϵ�û�гֲ�ʱҲ����ȡ��ͽ��������ѵ�
        if(v_Fee >= v_LowestSettleFee) then
            v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15010',v_Fee,null,v_CommodityID,null,null);
      else
          v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15010',v_LowestSettleFee,null,v_CommodityID,null,null);
            update T_SettleHoldPosition
            set SettleFee=SettleFee+(v_LowestSettleFee-v_Fee)
            where ID=v_ID;
        end if;
      end if;
    --�����ʽ�����д������ӯ�����ս��տ�����ˮ
    --��Ʒ������˰���ڽ��׹����о�����˰
   /* if(v_CloseFL >= 0) then
      v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15011',v_CloseFL,null,v_CommodityID,v_CloseAddedTax,null);
    else
      v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15012',-v_CloseFL,null,v_CommodityID,-v_CloseAddedTax,null);
    end if;*/
    ------xief  20150811
    if(v_CloseFL >= 0) then
      v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15011',v_CloseFL,null,v_CommodityID,null,null);
    else
      v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15012',-v_CloseFL,null,v_CommodityID,null,null);
    end if;

    --�洢�ϲ���  add  by  zhangjian  ��2011��12��26�� 14:52:34

    if(v_aheadSettlePriceType=0)then  --����������۽������ڴ˴�����������ݵĲ���
       select sum(m.quantity*m.price*v_ContractFactor)
       into v_totalRef
       from T_MatchSettleholdRelevance m, T_SettleHoldPosition s
       where m.settleid = s.id
       and matchid = p_ApplyID
       and bs_flag = p_BS_Flag;
       if(p_BS_Flag=1)then --������� ������µĽ����������

           --2.5 ���뽻����Ա�
         insert into T_SettleMatch (MatchID,CommodityID,ContractFactor,Quantity,HL_Amount,Status,Result,SettleType,FirmID_B,BuyPrice,BuyPayout_Ref,BuyPayout,BuyMargin,TakePenalty_B,PayPenalty_B,SettlePL_B,
               FirmID_S,SellPrice,SellIncome_Ref,SellIncome,SellMargin,TakePenalty_S,PayPenalty_S,SettlePL_S,CreateTime,ModifyTime,SettleDate)
               values (p_ApplyID,p_CommodityID,v_ContractFactor,(p_HoldQty+p_GageQty),0,0,1,2,v_FirmID,v_settlePrice,v_totalRef,v_Payout,v_settlementmargin,0,0,0,
               v_FirmID,v_settlePrice,v_totalRef,0,v_SettlementMargin,0,0,0,sysdate,sysdate,v_TradeDate);
       elsif(p_BS_Flag=2)then  --�������������½���������ݱ�
       update T_SettleMatch set FirmID_S=v_FirmID , SellPrice=v_settlePrice,SellIncome_Ref=v_totalRef,SellMargin=v_settlementmargin where MatchID=p_ApplyID;
       end if;
    elsif(v_aheadSettlePriceType=1) then
       if(p_BS_Flag=2)then --������� ������µĽ����������
           --1�������򷽽��ջ���
           select FirmID into v_bFirmID from T_Customer where CustomerID=p_OCustomerID;--�ҳ��򷽽�����ID
           v_bPayout := FN_T_ComputePayout(v_bFirmID,p_CommodityID,1,(p_HoldQty+p_GageQty),p_Price);
           if(v_bPayout < 0) then
              Raise_application_error(-20043, 'computePayout error');
           end if;
           --2�����뽻����Ա���ǰ���ղ����㽻�ձ�֤��
           --2.��ǰ���ո����г������趨���ж��Ƿ���ȡ��֤�� -- modify by zhangjian
           select ASMarginType into v_IsChargeMargin from t_a_market;
           if(v_IsChargeMargin = 1 )then  --�����ȡ��֤��
              --�����򷽽��ձ�֤��
              v_SettlementMargin_B := FN_T_ComputeSettleMargin(v_bFirmID,p_CommodityID,1,p_HoldQty+p_GageQty,p_Price);
              if(v_SettlementMargin_B < 0) then
                 Raise_application_error(-20042, 'ComputeSettleMargin error');
              end if;
              --�����������ձ�֤��
             /* v_SettlementMargin_S := FN_T_ComputeSettleMargin(v_FirmID,p_CommodityID,2,(p_HoldQty+p_GageQty),p_Price);
              if(v_SettlementMargin_S < 0) then
                  Raise_application_error(-20042, 'ComputeSettleMargin error');
              end if;*/
           end if;   --add by zhangjian end

           --2.5 ���뽻����Ա�
           select ContractFactor into v_ContractFactor from T_Commodity where CommodityID=p_CommodityID;
           insert into T_SettleMatch (MatchID,CommodityID,ContractFactor,Quantity,HL_Amount,Status,Result,SettleType,FirmID_B,BuyPrice,BuyPayout_Ref,BuyPayout,BuyMargin,TakePenalty_B,PayPenalty_B,SettlePL_B,
           FirmID_S,SellPrice,SellIncome_Ref,SellIncome,SellMargin,TakePenalty_S,PayPenalty_S,SettlePL_S,CreateTime,ModifyTime,SettleDate)
           values (p_ApplyID,p_CommodityID,v_ContractFactor,(p_HoldQty+p_GageQty),0,0,1,2,v_bFirmID,p_Price,(p_HoldQty+p_GageQty)*p_Price*v_ContractFactor,v_bPayout,v_SettlementMargin_B,0,0,0,
           v_FirmID,p_Price,(p_HoldQty+p_GageQty)*p_Price*v_ContractFactor,0,v_SettlementMargin,0,0,0,sysdate,sysdate,v_TradeDate);
       end if;
    end if;
    return 1;

end;
/

prompt
prompt Creating function FN_T_AHEADSETTLEQTY
prompt =====================================
prompt
create or replace function FN_T_AheadSettleQty(
    p_ApplyID       varchar2,     --���뵥��
    p_CommodityID varchar2, --��Ʒ����
    --p_BillID         varchar2, --�ֵ���-- mod by yukx 20100428
    p_Quantity      number,   --�ֵ������������������������ֶ���
   p_Price         number,  --���ռ�
  p_sCustomerID    varchar2,     --�������׿ͻ�ID
  p_sGageQty      number default 0,    --���������յֶ�����
    p_bCustomerID    varchar2,     --�򷽽��׿ͻ�ID
   p_bGageQty      number default 0,   --�������յֶ�������ҵ���ϲ����ڴ˲�����ʵ���ϱ���
    p_Modifier      varchar2,   --������
  p_ApplyType     number    --��������: 1:��ǰ����  mod by yukx /*3�����вֵ�ת��ǰ����;6����ǰ����*/
  --p_ValidID       number    --��Ч�ֵ��ţ�ֻ����������Ϊ3�����вֵ�ת��ǰ���ղ���Ҫ
) return number
/****
 * ��ǰ����
 * ����ֵ
 * 1 �ɹ�
 * 2 �Ѵ����
 * -1  �ɽ�����ֲ���������
 * -2  �ɽ�����ֶ���������
 * -3  ������ֲ��������ڿɽ�����ֲ�����
 * -4  ������ֶ��������ڿ���ֶ�����
 * -11  �ɽ������ֲ���������
 * -12  �ɽ������ֶ���������
 * -13  �������ֲ��������ڿɽ������ֲ�����
 * -14  �������ֶ��������ڿ����ֶ�����
 * -100 ��������
****/
as
   v_version varchar2(10):='1.0.0.9';
   v_FirmID varchar2(32);      --����������ID
  v_bFirmID varchar2(32);      --�򷽽�����ID
    bRet            number(5);
    sRet            number(5);
    v_FL_ret            timestamp;
    v_num            number(10);
    v_errorcode      number;
    v_errormsg       varchar2(200);
    v_Payout         number(15,2):=0;
    v_ContractFactor T_Commodity.ContractFactor%type;
  v_IsChargeMargin       number(2):=0;    --�Ƿ���ȡ��֤�� -add by zhangjian
  v_SettlementMargin_S     number(15,2):=0; --�������ձ�֤��
  v_SettlementMargin_B      number(15,2):=0; --�򷽽��ձ�֤��
  v_settlePirce_B    number(15,6):=0;--�򷽽��ռ۸�
  v_settlePirce_S    number(15,6):=0;--�������ռ۸�
  v_alreadyAheadSettleQty number(15):=0;  --�Ѵ��ڵ���ǰ������������
  v_holdPrice  number(15):=0;--ÿһ�ʳֲ���ϸ�еĶ�����
  v_holdQty  number(15):=0;--ÿһ�ʳֲ���ϸ�еĳֲ�����
  v_HoldSum number(15):=0;--�ۻ���ǰ������������
  v_tempQty number(15):=0;--��ʱ��������
  v_holdPirceSum number(15):=0;--������Ҫ����ֲ���ϸ�����۸��ۼ�
  v_priceType number(2);--���ռ�����  0:�������۽���  1:�������۽��� add by zhangjian
  v_sql varchar2(500);
  v_orderby  varchar2(100);
  v_CloseAlgr number;
  type cur_T_HoldPosition is ref cursor;
  v_HoldPosition cur_T_HoldPosition;
  v_settleMachNumber number(15);
  v_aheadSettlePriceType number(2);--��ǰ���ռ۸����� 0:�������۽��� 1���������۽���

begin
    /* -- mod by yukx 20100428
    select count(*) into v_num from T_ValidBill where BillID = p_BillID and Status=1 and BillType=4;
    if(v_num >0) then
        rollback;
        return 2;  --�Ѵ����
    end if;
    */
select aheadSettlePriceType into v_aheadSettlePriceType  from t_commodity where commodityid=p_CommodityID;
  --����Ӧ�õ���FN_T_AheadSettleOneQty����ǰ����FN_T_AheadSettleOne
  --���Ӵ��� ��ǰ�������뵥�š���������ǰ���ռ۸�����Ϊ �������۽��յ�ʱ�������ǰ���ռ۸�
   bRet := FN_T_AheadSettleOneQty(p_ApplyID,p_CommodityID,p_Price,1,p_bCustomerID,p_sCustomerID,p_Quantity-p_bGageQty,p_bGageQty); --��
   if(bRet = 1) then
      sRet := FN_T_AheadSettleOneQty(p_ApplyID,p_CommodityID,p_Price,2,p_sCustomerID,p_bCustomerID,p_Quantity-p_sGageQty,p_sGageQty);  --��

      if(sRet = 1) then
          select FirmID into v_FirmID from T_Customer where CustomerID=p_sCustomerID;--�ҳ�����������ID
          --3�еֶ�������������Ч�ֵ��ֶ��������
          update T_ValidGageBill set Quantity=Quantity+p_sGageQty where FirmID=v_FirmID and commodityId=p_CommodityID;
          commit;
          --�ύ���������˫������
          v_FL_ret := FN_T_UpdateFloatingLoss(null,null,null);

          return 1;
       elsif(sRet = -1) then
         rollback;
         return -11;
      elsif(sRet = -2) then
         rollback;
         return -12;
      elsif(sRet = -3) then
         rollback;
         return -13;
      elsif(sRet = -4) then
         rollback;
         return -14;
      else
         rollback;
         return -100;
      end if;
   else
      rollback;
      return bRet;
   end if;
exception
    when OTHERS then
    v_errorcode:=sqlcode;
    v_errormsg :=sqlerrm;
    rollback;
    insert into T_DBLog(err_date,name_proc,err_code,err_msg)
    values(sysdate,'FN_T_AheadSettleQty',v_errorcode,v_errormsg);
    commit;
    return -100;
end;
/

prompt
prompt Creating function FN_T_D_COMPUTEDELAYDAYS
prompt =========================================
prompt
create or replace function FN_T_D_ComputeDelayDays return number
/****
 * �������ڲ����ѵ�����
 * ���ؼ������ڲ����ѵ�����
****/
as
	v_version varchar2(10):='1.0.2.3';
	v_TradeDate date;
    v_Week        varchar2(30);   --�ǽ��׵����ڼ�
    v_Day    varchar2(1024);   --�ǽ��׵�����
    v_destWeek    varchar2(10);   --�¸����ڶ�Ӧ�����ڼ�
    v_pos      number(15,2):=0;   --λ��
    v_bLoop      boolean;   --�Ƿ���Ҫѭ����־
    v_Days       number(10); --���ڵ�����
begin
	--1����ȡ��������
	select TradeDate into v_TradeDate from T_SystemStatus;
	--2����ѯ�ǽ����գ�δ���÷ǽ�����ʱ����1,2010-03-29  by chenxc
	begin
		select Week,Day
		into v_Week,v_Day
	    from T_A_NotTradeDay;
	exception
	    when NO_DATA_FOUND then
	        return 1;
	end;
    if(v_Week is null and v_Day is null) then
    	return 1;
    end if;
	--3��������������
	v_Days := 1;
	v_bLoop := true;
    while v_bLoop loop
    	<<top>>
    	select ',' || TO_CHAR(v_TradeDate+v_Days,'D') || ',' into v_destWeek  from dual;
    	if(v_Week is not null) then
    		select INSTR(',' || v_Week || ',',v_destWeek,1,1) into v_pos  from dual;
    		if(v_pos > 0) then
    			v_bLoop := true;
    			v_Days := v_Days+1;
    			goto top;
    		else
    			v_bLoop := false;
    		end if;
    	end if;
    	if(v_Day is not null) then
    		select INSTR(',' || v_Day || ',',to_char(v_TradeDate+v_Days,'yyyy-MM-dd'),1,1) into v_pos  from dual;
    		if(v_pos > 0) then
    			v_bLoop := true;
    			v_Days := v_Days+1;
    			goto top;
    		else
    			v_bLoop := false;
    		end if;
    	end if;
    end loop;
	--4��������������
    return v_Days;
end;
/

prompt
prompt Creating function FN_T_D_PAYDELAYFUND
prompt =====================================
prompt
create or replace function FN_T_D_PayDelayFund(
	p_CommodityID    varchar2, --��Ʒ����
    p_DelayFunds     number   --���ڲ�����
) return number
/****
 * �����������ڲ�����
 * ���ظ������̵����ڲ�����
****/
as
	v_version varchar2(10):='1.0.2.2';
    v_OrderQtySum        number(10);   --����
    v_DelayFundOneInit    number(15,4);   --ĳ������Ӧ�����ڷѣ�δ����
    v_DelayFundOne    number(15,2);   --ĳ������Ӧ�����ڷѣ����㾫ȷ����
    v_DelayFunds      number(15,2):=0;   --���ڲ����Ѻϼ�
    v_Balance      number(15,2);   --�����ʽ�
    v_OrderQtyOne       number(10); --��������
begin
	--1������Ӧ�ò����ѵ�������
	select nvl(sum(DiffQty),0)
	into v_OrderQtySum
    from
    (
    	(select nvl(sum(Quantity-TradeQty),0) DiffQty from T_DelayOrders where DelayOrderType=1 and Status in(5,6) and WithdrawType=4 and CommodityID=p_CommodityID) union all
        (select nvl(sum(TradeQty),0) DiffQty from T_DelayOrders where DelayOrderType=2 and CommodityID=p_CommodityID)
    );

	--2���걨��δ�ܽ��յĽ����̺Ͳ��������ֳɽ��Ľ����̰���ƽ�������ܲ�����
    for cur_DelayFund in(
		select FirmID,nvl(sum(DiffQty),0) DiffQty
		from
		(
			(select FirmID,nvl(sum(Quantity-TradeQty),0) DiffQty from T_DelayOrders where DelayOrderType=1 and Status in(5,6) and WithdrawType=4 and CommodityID=p_CommodityID group by FirmID) union all
			(select FirmID,nvl(sum(TradeQty),0) DiffQty from T_DelayOrders where DelayOrderType=2 and CommodityID=p_CommodityID group by FirmID)
		)
		group by FirmID
    )
    loop
    	v_OrderQtyOne := cur_DelayFund.DiffQty;
		if(v_OrderQtyOne > 0) then
			--ĳ������Ӧ���������ܲ����ѡ����������˽�����Ӧ������,����С�������ԭ�򣬾�ȷ����
			v_DelayFundOneInit := p_DelayFunds/v_OrderQtySum*v_OrderQtyOne;
			v_DelayFundOne := trunc(v_DelayFundOneInit,2);
	        --�����������ڷ� ����д��ˮ
    		v_Balance := FN_F_UpdateFundsFull(cur_DelayFund.FirmID,'15021',v_DelayFundOne,null,p_CommodityID,null,null);
    		v_DelayFunds := v_DelayFunds + v_DelayFundOne;
		end if;
    end loop;
	--3�������ܲ������ڷ�
    return v_DelayFunds;
end;
/

prompt
prompt Creating function FN_T_D_CHARGEDELAYFUND
prompt ========================================
prompt
create or replace function FN_T_D_ChargeDelayFund(
	p_CommodityID    varchar2, --��Ʒ����
	p_BS_Flag        number, --��ȡ���ڷѷ���1��2��
    p_DelayFunds     number   --���ڲ�����
) return number
/****
 * ��ȡ���������ڲ�����
 * ������ȡ�Ľ��������ڲ�����
 * �������ã��޸���ȡ�����̲�����ʱ�ǰ������������ǵ��߶������������������ֵ������������� by chenxc 2011-09-21
****/
as
	v_version varchar2(10):='1.0.2.2';
	v_TradeDate date;
    v_NotOrderQtySum        number(10);   --δ�걨��������
    v_DelayFundOneInit    number(15,4);   --ĳ������Ӧ�����ڷѣ�δ��λ
    v_DelayFundOne    number(15,2);   --ĳ������Ӧ�����ڷѣ���λ��ȷ����
    v_DelayFunds      number(15,2):=0;   --���ڲ����Ѻϼ�
    v_Balance      number(15,2);   --�����ʽ�
    v_NotOrderQtyOne       number(10); --������δ�걨������
	v_ChargeDelayFeeType       number(2); --��ȡ���ڲ���������
begin
	--1����ȡ��������
	select TradeDate into v_TradeDate from T_SystemStatus;
	--��ȡ���ڲ����������ֶΣ�0������������ȡ��Ĭ�ϣ���1�����߶���������ȡ
	select ChargeDelayFeeType into v_ChargeDelayFeeType from T_A_Market;
	--2����ѯδ�걨��������
	--�������ã��޸���ȡ�����̲�����ʱ�ǰ������������ǵ��߶������������������ֵ������������� by chenxc 2011-09-21
	select decode(v_ChargeDelayFeeType,1,
		nvl(sum(
			decode(p_BS_Flag,1,BuyCleanQty,SellCleanQty)),0)
		,
		nvl(sum(
			decode(p_BS_Flag,1,
			case when BuyCleanQty-SellCleanQty<=0 then 0 else BuyCleanQty-SellCleanQty end,
			case when SellCleanQty-BuyCleanQty<=0 then 0 else SellCleanQty-BuyCleanQty end
			)
		),0))
	into v_NotOrderQtySum
	from
	(
		select (a.BuyQty-nvl(b.BuyNeutralQty,0)-nvl(c.BuyNotTradeQty,0)) BuyCleanQty,(a.SellQty-nvl(b.SellNeutralQty,0)-nvl(c.SellNotTradeQty,0)) SellCleanQty
		from
			(select FirmID,nvl(sum(decode(BS_Flag,1,HoldQty+GageQty,0)),0) BuyQty,nvl(sum(decode(BS_Flag,2,HoldQty+GageQty,0)),0) SellQty
			from T_FirmHoldSum
			where CommodityID=p_CommodityID
			group by FirmID) a,
			(select FirmID,nvl(sum(decode(BS_Flag,1,HoldQty+GageQty,0)),0) BuyNeutralQty,nvl(sum(decode(BS_Flag,2,HoldQty+GageQty,0)),0) SellNeutralQty
			from T_HoldPosition
			where CommodityID=p_CommodityID and AtClearDate=v_TradeDate and HoldType=2
			group by FirmID) b,
			(select FirmID,nvl(sum(decode(BS_Flag,1,Quantity-TradeQty,0)),0) BuyNotTradeQty,nvl(sum(decode(BS_Flag,2,Quantity-TradeQty,0)),0) SellNotTradeQty
			from T_DelayOrders
			where CommodityID=p_CommodityID and DelayOrderType=1 and Status in(5,6) and WithdrawType=4
			group by FirmID) c
		where a.FirmID=b.FirmID(+) and a.FirmID=c.FirmID(+)
	);
	--2.5��������������ľ�������
	update T_DelayQuotation set DelayCleanHoldQty=v_NotOrderQtySum where CommodityID=p_CommodityID;
	--3������ĳ������Ӧ�ɲ������ܲ����ѡ�δ�걨�����������˽�����δ�걨������������С��������ԭ�򣬾�ȷ����
    for cur_DelayFund in(
		select a.FirmID,(a.BuyQty-nvl(b.BuyNeutralQty,0)-nvl(c.BuyNotTradeQty,0)) BuyCleanQty,(a.SellQty-nvl(b.SellNeutralQty,0)-nvl(c.SellNotTradeQty,0)) SellCleanQty
		from
			(select FirmID,nvl(sum(decode(BS_Flag,1,HoldQty+GageQty,0)),0) BuyQty,nvl(sum(decode(BS_Flag,2,HoldQty+GageQty,0)),0) SellQty
			from T_FirmHoldSum
			where CommodityID=p_CommodityID
			group by FirmID) a,
			(select FirmID,nvl(sum(decode(BS_Flag,1,HoldQty+GageQty,0)),0) BuyNeutralQty,nvl(sum(decode(BS_Flag,2,HoldQty+GageQty,0)),0) SellNeutralQty
			from T_HoldPosition
			where CommodityID=p_CommodityID and AtClearDate=v_TradeDate and HoldType=2
			group by FirmID) b,
			(select FirmID,nvl(sum(decode(BS_Flag,1,Quantity-TradeQty,0)),0) BuyNotTradeQty,nvl(sum(decode(BS_Flag,2,Quantity-TradeQty,0)),0) SellNotTradeQty
			from T_DelayOrders
			where CommodityID=p_CommodityID and DelayOrderType=1 and Status in(5,6) and WithdrawType=4
			group by FirmID) c
		where a.FirmID=b.FirmID(+) and a.FirmID=c.FirmID(+)
    )
    loop
    	--�������ã��޸���ȡ�����̲�����ʱ�ǰ������������ǵ��߶������������������ֵ������������� by chenxc 2011-09-21
		if(v_ChargeDelayFeeType = 1) then
	    	if(p_BS_Flag = 1) then
				v_NotOrderQtyOne := cur_DelayFund.BuyCleanQty;
			else
				v_NotOrderQtyOne := cur_DelayFund.SellCleanQty;
			end if;
		else
	    	if(p_BS_Flag = 1) then
				if(cur_DelayFund.BuyCleanQty-cur_DelayFund.SellCleanQty<=0) then
					v_NotOrderQtyOne := 0;
				else
					v_NotOrderQtyOne := cur_DelayFund.BuyCleanQty-cur_DelayFund.SellCleanQty;
				end if;
			else
				if(cur_DelayFund.SellCleanQty-cur_DelayFund.BuyCleanQty<=0) then
					v_NotOrderQtyOne := 0;
				else
					v_NotOrderQtyOne := cur_DelayFund.SellCleanQty-cur_DelayFund.BuyCleanQty;
				end if;
			end if;
		end if;
		if(v_NotOrderQtyOne > 0) then
			--ĳ������Ӧ�ɲ������ܲ����ѡ�δ�걨�����������˽�����δ�걨������,����С��������ԭ�򣬾�ȷ����
			v_DelayFundOneInit := p_DelayFunds/v_NotOrderQtySum*v_NotOrderQtyOne;
			v_DelayFundOne := trunc(v_DelayFundOneInit,2);
			if(v_DelayFundOneInit > v_DelayFundOne) then
				v_DelayFundOne := v_DelayFundOne + 0.01;
			end if;
	        --�ս��������ڷ� ����д��ˮ
    		v_Balance := FN_F_UpdateFundsFull(cur_DelayFund.FirmID,'15020',v_DelayFundOne,null,p_CommodityID,null,null);
    		v_DelayFunds := v_DelayFunds + v_DelayFundOne;
		end if;
    end loop;
	--4���������յ����ڷ�
    return v_DelayFunds;
end;
/

prompt
prompt Creating function FN_T_D_CLOSEPROCESS
prompt =====================================
prompt
create or replace function FN_T_D_CloseProcess return number
/****
 * ���ڽ��׽��㴦��
 * ����ֵ
 * 1  �ɹ��ύ
 * �޸����ڲ����Ѱ�������ȡ 2011-09-20 by chenxc
****/
as
	v_version varchar2(10):='1.0.2.2';
    v_DelayRecoupRate        number(7,5);   --�����ڲ�������
	v_DelayRecoupRate_S        number(7,5);   --�������ڲ�������,2011-09-05 by chenxc
    v_ContractFactor    number(12,2);   --��Լ����
    v_DelayFeeWay    number(2);   --���ڷ���ȡ��ʽ
    v_DelayFunds      number(20,6):=0;   --���ڲ�����
    v_Price      number(10,2);   --��������
    v_ChargeDelayFund  number(15,2); --�����ڷ�
    v_PayDelayFund       number(15,2); --�����ڷ�
    v_DiffFund      number(15,2); --����׼����
    v_Balance      number(15,2); --�����ʽ�
    v_TradeDate date;
    v_DelayDays    number(5);   --��������
    v_errorcode number;
    v_errormsg  varchar2(200);
    v_StoreFunds number(20,6):=0;   --�ִ�������
    v_StoreRecoupRate number(7,5);   --�ִ���������
begin
	--0��������������
	v_DelayDays := FN_T_D_ComputeDelayDays();
	--1����ѯ��Ʒ�������ڲ����ѣ������걨�����Լ���ӡ����ս���ۡ���������
    for delayOrder in(select CommodityID,max(BS_Flag) BS_Flag,nvl(sum(DiffQty),0) DiffQty
                      from ((select CommodityID,max(decode(BS_Flag,1,2,1)) BS_Flag,nvl(sum(Quantity-TradeQty),0) DiffQty from T_DelayOrders where DelayOrderType=1 and Status in(5,6) and WithdrawType=4 group by CommodityID) union all
                           (select  CommodityID,max(BS_Flag) BS_Flag,nvl(sum(TradeQty),0) DiffQty from T_DelayOrders where DelayOrderType=2  group by CommodityID))
                      group by CommodityID)
    loop
    	select StoreRecoupRate,DelayRecoupRate,DelayRecoupRate_S,ContractFactor,DelayFeeWay into v_StoreRecoupRate, v_DelayRecoupRate,v_DelayRecoupRate_S,v_ContractFactor,v_DelayFeeWay from T_Commodity where CommodityID = delayOrder.CommodityID;
    	select Price into v_Price from T_Quotation where CommodityID = delayOrder.CommodityID;
    	if(v_DelayFeeWay = 1) then  --����Ȼ��������ȡ
			--������򷽵Ĳ����ѣ���������������ʸ����򷽲������ʣ�delayOrder.BS_Flag��ָ�ս����̲����ѵķ��򣬶����Ǹ��������̲����ѷ���,2011-09-05 by chenxc
			if(delayOrder.BS_Flag = 1) then
				v_DelayRecoupRate := v_DelayRecoupRate_S;
			end if;
    		v_DelayFunds := delayOrder.DiffQty * v_ContractFactor * v_Price * v_DelayRecoupRate * v_DelayDays;
    		-- ���Ӳִ������ѹ���,����������������ʱ����ȡ�����ڷѷ�������� 2011-2-23 by feijl
			if (delayOrder.BS_Flag = 1) then
			    v_StoreFunds := delayOrder.DiffQty * v_ContractFactor * v_StoreRecoupRate * v_DelayDays;
			else
			    v_StoreFunds := 0;
			end if;
			--2�������ڷ�
    		v_ChargeDelayFund := FN_T_D_ChargeDelayFund(delayOrder.CommodityID,delayOrder.BS_Flag,v_DelayFunds+v_StoreFunds);
    		--3�������ڷ�
    		v_PayDelayFund := FN_T_D_PayDelayFund(delayOrder.CommodityID,v_DelayFunds+v_StoreFunds);
    		/*
    		if(v_ChargeDelayFund < v_PayDelayFund) then
    			rollback;
    			return -1;--���ڷ���ȡ����
    		end if;
    		--4�����Ǯ�������׼���𣬸��ڲ�������
    		v_DiffFund := v_ChargeDelayFund - v_PayDelayFund;
    		if(v_DiffFund > 0) then
		        --�����ս� ����д��ˮ
	    		v_Balance := FN_F_UpdateFundsFull(null,'15022',v_DiffFund,null,delayOrder.CommodityID,null,null);
    		end if;
    		*/
    	end if;

    end loop;

	--5����ȡ��������
	select TradeDate into v_TradeDate from T_SystemStatus;
    --6��������ʷ����ί�б�ɾ����������
    insert into T_H_DelayOrders select v_TradeDate,a.* from T_DelayOrders a;
    delete from T_DelayOrders;
    --7��������ʷ���ڳɽ���ɾ����������
    insert into T_H_DelayTrade select v_TradeDate,a.* from T_DelayTrade a;
    delete from T_DelayTrade;
    --8��ɾ����ʷ�������ݲ�������ʷ��������
	delete from T_H_DelayQuotation where ClearDate=v_TradeDate;
    insert into T_H_DelayQuotation select v_TradeDate,a.* from T_DelayQuotation a;

    return 1;

end;
/

prompt
prompt Creating function FN_T_RECOMPUTEFLOATLOSS
prompt =========================================
prompt
create or replace function FN_T_ReComputeFloatLoss
return number
/****
 * ������ʱ���������������½����̶����ʽ�
 * ע�ⲻҪ�ύcommit����Ϊ���д�����Ҫ��������
 * ����ֵ
 * 1 �ɹ�
 * -100 ��������
****/
as
	v_version varchar2(10):='1.0.0.10';
	v_FloatingLossComputeType number(2);
	v_FloatingProfitSubTax number(1);
	v_F_FrozenFunds number(15,2);
	v_GageMode number(2);--�ֶ�ģʽ����0ȫ�ֶ���1��ֶ�����ֶ�ʱҪ���㸡����2009-10-14
begin
	    --��ȡ�����������ͣ�ӯ���Ƿ��˰
	    select FloatingLossComputeType,FloatingProfitSubTax,GageMode into v_FloatingLossComputeType,v_FloatingProfitSubTax,v_GageMode from T_A_Market;
		--���³ֲ���ϸ�ϵĸ���ӯ��
        update
        (select /*+ BYPASS_UJVC */a.Price HoldPrice,HoldQty,GageQty,bs_flag,floatingloss,b.AddedTax,b.ContractFactor,b.price from T_HoldPosition a,
            (select c.AddedTax,c.ContractFactor,c.commodityid,q.price from T_Commodity c,T_Quotation q where c.CommodityID=q.CommodityID) b
        where a.commodityid=b.commodityid)
        --set floatingloss = decode(bs_flag,1,(Price-HoldPrice),(HoldPrice-Price))*HoldQty*ContractFactor;
        set floatingloss = FN_T_ComputeFPSubTax(HoldPrice,Price,HoldQty+decode(v_GageMode,1,GageQty,0),ContractFactor,bs_flag,AddedTax,v_FloatingProfitSubTax);

		--����������Ʒ�ֲ���ϸ�ϵĸ���ӯ��
        update
        (
         select /*+ BYPASS_UJVC */floatingloss
         from T_HoldPosition a,T_Commodity b
         where a.bs_flag=1 and a.commodityid=b.commodityid
         and (b.marginrate_b=-1 or (b.MarginAlgr=1 and b.MarginRate_B >= 1))
        )
        set floatingloss = 0;
        update
        (
         select /*+ BYPASS_UJVC */floatingloss
         from T_HoldPosition a,T_Commodity b
         where a.bs_flag=2 and a.commodityid=b.commodityid
         and (b.marginrate_s=-1 or (b.MarginAlgr=1 and b.MarginRate_S >= 1))
        )
        set floatingloss = 0;

		--�������⽻���ֲ̳���ϸ�ϵĸ���ӯ��
        update
        (
         select /*+ BYPASS_UJVC */floatingloss
         from T_HoldPosition a,T_A_FirmMargin b
         where a.bs_flag=1 and a.commodityid=b.commodityid and a.firmid=b.firmid
         and (b.marginrate_b=-1 or (b.MarginAlgr=1 and b.MarginRate_B >= 1))
        )
        set floatingloss = 0;
        update
        (
         select /*+ BYPASS_UJVC */floatingloss
         from T_HoldPosition a,T_A_FirmMargin b
         where a.bs_flag=2 and a.commodityid=b.commodityid and a.firmid=b.firmid
         and (b.marginrate_s=-1 or (b.MarginAlgr=1 and b.MarginRate_S >= 1))
        )
        set floatingloss = 0;

      --���½��׿ͻ��ֲֺϼ��еĸ���ӯ��
	  update T_CustomerHoldSum a
      set FloatingLoss=
      (
          select sum(x.FloatingLoss)
          from T_HoldPosition x
          where x.CustomerID = a.CustomerID and x.CommodityID = a.CommodityID and x.BS_Flag = a.BS_Flag
          group by x.CustomerID,x.CommodityID,x.BS_Flag
      );
      --���½����ֲֺ̳ϼ��еĸ���ӯ��
	  update T_FirmHoldSum a
      set FloatingLoss=
      (
          select sum(x.FloatingLoss)
          from T_CustomerHoldSum x
          where x.FirmID = a.FirmID and x.CommodityID = a.CommodityID and x.BS_Flag = a.BS_Flag
          group by x.FirmID,x.CommodityID,x.BS_Flag
      );

      --���½�������ʱ����
	  if(v_FloatingLossComputeType = 0) then     --����Ʒ������
            for fz in (select a.firmid,a.FloatingLoss-b.runtimefl diff
                 from (select firmid,sum(case when FloatingLoss>0 then 0 else -FloatingLoss end) FloatingLoss from
                       T_FirmHoldSum group by firmid) a,
                       t_firm b where a.firmid=b.firmid)
            loop
                if(fz.diff <> 0) then
                    update T_Firm
                    set RuntimeFL = RuntimeFL + fz.diff
                    where FirmID = fz.firmid;
                    --���¶����ʽ��ͷŻ�۳��仯�ĸ���
      			    v_F_FrozenFunds := FN_F_UpdateFrozenFunds(fz.firmid,fz.diff,'15');
                end if;
            end loop;
	  elsif(v_FloatingLossComputeType = 1) then  --����Ʒ��������
            for fz in (select a.firmid,a.FloatingLoss-b.runtimefl diff
                   from (select firmid,sum(case when FloatingLoss>0 then 0 else -FloatingLoss end) FloatingLoss from
                          (select firmid,sum(FloatingLoss) FloatingLoss from T_FirmHoldSum
                           group by firmid,commodityID) group by firmid
                        ) a,t_firm b where a.firmid=b.firmid)
            loop
                if(fz.diff <> 0) then
                    update T_Firm
                    set RuntimeFL = RuntimeFL + fz.diff
                    where FirmID = fz.firmid;
                    --���¶����ʽ��ͷŻ�۳��仯�ĸ���
      			    v_F_FrozenFunds := FN_F_UpdateFrozenFunds(fz.firmid,fz.diff,'15');
                end if;
            end loop;
	  elsif(v_FloatingLossComputeType = 2) then  --������Ʒ
            for fz in (select a.firmid,a.FloatingLoss-b.runtimefl diff
                       from ( select firmid,case when sum(FloatingLoss)>0 then 0 else -sum(FloatingLoss) end FloatingLoss
                              from T_FirmHoldSum group by firmid) a,
                         t_firm b where a.firmid=b.firmid)
            loop
                if(fz.diff <> 0) then
                    update T_Firm
                    set RuntimeFL = RuntimeFL + fz.diff
                    where FirmID = fz.firmid;
                    --���¶����ʽ��ͷŻ�۳��仯�ĸ���
      			    v_F_FrozenFunds := FN_F_UpdateFrozenFunds(fz.firmid,fz.diff,'15');
                end if;
            end loop;
	  elsif(v_FloatingLossComputeType = 3 or v_FloatingLossComputeType = 4) then  --������ӯ������ӯ��
            for fz in (select a.firmid,a.FloatingLoss-b.runtimefl diff
                       from ( select firmid,-sum(FloatingLoss) FloatingLoss
                              from T_FirmHoldSum group by firmid) a,
                         t_firm b where a.firmid=b.firmid)
            loop
                if(fz.diff <> 0) then
                    update T_Firm
                    set RuntimeFL = RuntimeFL + fz.diff
                    where FirmID = fz.firmid;
                    --���¶����ʽ��ͷŻ�۳��仯�ĸ���
      			    v_F_FrozenFunds := FN_F_UpdateFrozenFunds(fz.firmid,fz.diff,'15');
                end if;
            end loop;
	  end if;

      return 1;

end;
/

prompt
prompt Creating function FN_T_COMPUTEASSUREBYARGS
prompt ==========================================
prompt
create or replace function FN_T_ComputeAssureByArgs(
    p_bs_flag        number,
    p_quantity number,
    p_price number,
    p_contractFactor        number,
    p_marginAlgr number,
    p_marginRate_b number,
    p_marginRate_s number
) return number
/****
 * ���ݲ������㵣����
 * ����ֵ �ɹ����ص�����;-1 �����������ݲ�ȫ;-100 ��������
****/
as
	v_version varchar2(10):='1.0.0.1';
    v_margin             number(15,2) default 0;
begin
    if(p_marginAlgr=1) then  --Ӧ�ձ�֤��=����*��Լ����*�۸�*������
    	if(p_bs_flag = 1) then  --��
        	v_margin:=p_quantity*p_contractFactor*p_price*p_marginRate_b;
        elsif(p_bs_flag = 2) then  --��
        	v_margin:=p_quantity*p_contractFactor*p_price*p_marginRate_s;
        end if;
    elsif(p_marginAlgr=2) then  --Ӧ�ձ�֤��=����*������
    	if(p_bs_flag = 1) then  --��
        	v_margin:=p_quantity*p_marginRate_b;
        elsif(p_bs_flag = 2) then  --��
        	v_margin:=p_quantity*p_marginRate_s;
        end if;
    end if;
    if(v_margin is null) then
    	rollback;
        return -1;
    end if;
    return v_margin;
exception
    when no_data_found then
    	rollback;
        return -1;
    when others then
    	rollback;
    	return -100;
end;
/

prompt
prompt Creating function FN_T_COMPUTEMARGINBYARGS
prompt ==========================================
prompt
create or replace function FN_T_ComputeMarginByArgs(
    p_bs_flag        number,
    p_quantity number,
    p_price number,
    p_contractFactor        number,
    p_marginAlgr number,
    p_marginRate_b number,
    p_marginRate_s number
) return number
/****
 * ���ݲ������㱣֤��
 * ����ֵ �ɹ����ر�֤��;-1 �����������ݲ�ȫ;-100 ��������
****/
as
	v_version varchar2(10):='1.0.0.1';
    v_margin             number(15,2) default 0;
begin
    if(p_marginAlgr=1) then  --Ӧ�ձ�֤��=����*��Լ����*�۸�*��֤��
    	if(p_bs_flag = 1) then  --��
		    if(p_marginRate_b = -1) then --  -1��ʾ��ȫ��
		    	v_margin:=p_quantity*p_contractFactor*p_price;
		    else
			    v_margin:=p_quantity*p_contractFactor*p_price*p_marginRate_b;
		    end if;
        elsif(p_bs_flag = 2) then  --��
		    if(p_marginRate_s = -1) then --  -1��ʾ��ȫ��
		    	v_margin:=p_quantity*p_contractFactor*p_price;
		    else
			    v_margin:=p_quantity*p_contractFactor*p_price*p_marginRate_s;
		    end if;
        end if;
    elsif(p_marginAlgr=2) then  --Ӧ�ձ�֤��=����*��֤��
    	if(p_bs_flag = 1) then  --��
		    if(p_marginRate_b = -1) then --  -1��ʾ��ȫ��
		    	v_margin:=p_quantity*p_contractFactor*p_price;
		    else
			    v_margin:=p_quantity*p_marginRate_b;
		    end if;
        elsif(p_bs_flag = 2) then  --��
		    if(p_marginRate_s = -1) then --  -1��ʾ��ȫ��
		    	v_margin:=p_quantity*p_contractFactor*p_price;
		    else
			    v_margin:=p_quantity*p_marginRate_s;
		    end if;
        end if;
    end if;

    if(v_margin is null) then
    	rollback;
        return -1;
    end if;
    return v_margin;
exception
    when no_data_found then
    	rollback;
        return -1;
    when others then
	    rollback;
    	return -100;
end;
/

prompt
prompt Creating function FN_T_COMPUTEFEE
prompt =================================
prompt
create or replace function FN_T_ComputeFee(
    p_FirmID     varchar2,
    p_CommodityID varchar2,
    p_bs_flag        number,
    p_quantity       number,
    p_price          number
) return number
/****
 * ����������
 * ����ֵ �ɹ�����������;-1 ���㽻�׷����������ݲ�ȫ;-100 ��������
****/
as
	v_version varchar2(10):='1.0.0.1';
    v_feeRate_b         number(15,9);
    v_feeRate_s         number(15,9);
    v_feeAlgr       number(2);
    v_contractFactor  number(12,2);
    v_fee             number(15,2) default 0;
begin
    --��ȡ��Ʒ��Ϣ����Լ���ӣ�������ϵ�����������㷨��
    select feerate_b,feerate_s,feealgr,contractfactor
    into v_feeRate_b,v_feeRate_s,v_feeAlgr,v_contractFactor
    from T_Commodity where CommodityID=p_CommodityID;

    begin
        --��ȡ�����̶�Ӧ�ײ�������ϵ�����������㷨
        select feerate_b,feerate_s,feealgr
   		into v_feeRate_b,v_feeRate_s,v_feeAlgr
        from T_A_Tariff
        where TariffID=(select TariffID from t_firm where FirmID=p_FirmID) and CommodityID=p_CommodityID;
    exception
        when NO_DATA_FOUND then
            null;
    end;

    begin
        --��ȡ�ػ���������ϵ�����������㷨
        select feerate_b,feerate_s,feealgr
   		into v_feeRate_b,v_feeRate_s,v_feeAlgr
        from T_A_FirmFee
        where FirmID=p_FirmID and CommodityID=p_CommodityID;
    exception
        when NO_DATA_FOUND then
            null;
    end;
    if(v_feeAlgr=1) then  --Ӧ��������=����*��Լ����*�۸�*������
    	if(p_bs_flag = 1) then  --��
        	v_fee:=p_quantity*v_contractFactor*p_price*v_feeRate_b;
        elsif(p_bs_flag = 2) then  --��
        	v_fee:=p_quantity*v_contractFactor*p_price*v_feeRate_s;
        end if;
    elsif(v_feeAlgr=2) then  --Ӧ��������=����*������
    	if(p_bs_flag = 1) then  --��
        	v_fee:=p_quantity*v_feeRate_b;
        elsif(p_bs_flag = 2) then  --��
        	v_fee:=p_quantity*v_feeRate_s;
        end if;
    end if;
    if(v_fee is null) then
    	rollback;
        return -1;
    end if;
    return v_fee;
exception
    when no_data_found then
    	rollback;
        return -1;
    when others then
    	rollback;
   		return -100;
end;
/

prompt
prompt Creating function FN_T_RECOMPUTEFUNDS
prompt =====================================
prompt
create or replace function FN_T_ReComputeFunds(
    p_MarginFBFlag number   --0������ʱ������1������ǰ������2�������е��������ǰ����ּ��㱣֤��ʱҪ����0�������ۣ�1��2�������ۣ��������е��������а�������Ҫ�ÿ��ּ����㵱��Ľ��и��ǣ�ͬʱ2Ҫ����ί�ж����ʽ�
)
return number
/****
 * ������ʱ�����ʽ�,�������ױ�֤�𣬵����𣬶����ʽ�
 * 1��ע�ⲻҪ�ύcommit����Ϊ���д�����Ҫ��������
   2����Ҫ��T_SystemStatus��ȡTradeDate����Ϊ����ǰ����ʱ��û���������л�
 * ����ֵ
 * 1 �ɹ�
 * -100 ��������
****/
as
	v_version varchar2(10):='1.0.2.1';
    v_FirmID varchar2(32);
    v_Margin         number(15,2):=0; --���˲��ֱ�֤��
    v_HoldMargin         number(15,2):=0;
    v_HoldAssure         number(15,2):=0;
    v_diff         number(15,2);
	v_FrozenFunds   number(15,2);
	v_F_FrozenFunds   number(15,2);
	v_TradeDate date;
	v_GageMode number(2);--�ֶ�ģʽ����0ȫ�ֶ���1��ֶ�����ֶ�ʱҪ���㸡����2009-10-14
    --ί�����Ѷ����ʽ���α�
    cursor cur_T_Orders is select FirmID,sum(FrozenFunds-UnfrozenFunds) from T_Orders where OrderType=1 and Status in(1,2) group by FirmID;
    --�������α꣬����������ʱ��֤��͵�����
    cursor cur_T_Firm is
    select a.FirmID,(a.RuntimeMargin-a.RuntimeAssure),nvl(b.HoldMargin,0),nvl(b.HoldAssure,0)
    from T_Firm a,(select FirmID,nvl(sum(HoldMargin),0) HoldMargin,nvl(sum(HoldAssure),0) HoldAssure from T_FirmHoldSum group by FirmID) b
    where a.FirmID=b.FirmID(+);
begin
	    --��ȡ�ֶ�ģʽ
	    select GageMode into v_GageMode from T_A_Market;
        --���³ֲ���ϸ��֤�𣬵�����
        update
        (
          select /*+ BYPASS_UJVC */a.HoldQty,a.bs_flag,a.HoldMargin,a.HoldAssure,
          b.marginrate_b,b.marginrate_s,b.marginAssure_b,b.marginAssure_s,b.marginalgr,b.ContractFactor,
          decode(b.MarginPriceType,0,a.Price,decode(p_MarginFBFlag,0,b.price,b.YesterBalancePrice)) Price
          from T_HoldPosition a,
              (select c.MarginPriceType,c.marginrate_b,c.marginrate_s,c.marginAssure_b,c.marginAssure_s,c.marginalgr,c.ContractFactor,c.commodityid,q.price,q.YesterBalancePrice from T_Commodity c,T_Quotation q where c.CommodityID=q.CommodityID) b
          where a.commodityid=b.commodityid
        )
        set HoldMargin = FN_T_ComputeMarginByArgs(bs_flag,HoldQty,Price,contractFactor,marginAlgr,marginRate_b,marginRate_s)+FN_T_ComputeAssureByArgs(bs_flag,HoldQty,Price,contractFactor,marginAlgr,marginAssure_b,marginAssure_s),
            HoldAssure = FN_T_ComputeAssureByArgs(bs_flag,HoldQty,Price,contractFactor,marginAlgr,marginAssure_b,marginAssure_s);

        --�������⽻���̵ĳֲ���ϸ��֤�𣬵�����
        update
        (
          select /*+ BYPASS_UJVC */a.HoldQty,a.bs_flag,a.HoldMargin,a.HoldAssure,
          c.marginrate_b,c.marginrate_s,c.marginAssure_b,c.marginAssure_s,c.marginalgr,
          b.ContractFactor,decode(b.MarginPriceType,0,a.Price,decode(p_MarginFBFlag,0,b.price,b.YesterBalancePrice)) Price
          from T_HoldPosition a,
              (select c.MarginPriceType,c.ContractFactor,c.commodityid,q.price,q.YesterBalancePrice from T_Commodity c,T_Quotation q where c.CommodityID=q.CommodityID) b,
              T_A_FirmMargin c
          where a.commodityid=b.commodityid and a.commodityid=c.commodityid and a.firmid=c.firmid
        )
        set HoldMargin = FN_T_ComputeMarginByArgs(bs_flag,HoldQty,Price,contractFactor,marginAlgr,marginRate_b,marginRate_s)+FN_T_ComputeAssureByArgs(bs_flag,HoldQty,Price,contractFactor,marginAlgr,marginAssure_b,marginAssure_s),
            HoldAssure = FN_T_ComputeAssureByArgs(bs_flag,HoldQty,Price,contractFactor,marginAlgr,marginAssure_b,marginAssure_s);

        --����ǽ����е������ұ�֤�������ʽΪ2�����а������ۣ�����Ҫ���㵱�쿪�ֵı�֤�𣨰������ۣ������ǵ���������ĵ��쿪�ֱ�֤����Ϊͳһ�������ۼ���ģ�
		if(p_MarginFBFlag = 2) then
			select TradeDate into v_TradeDate from T_SystemStatus;
			--���³ֲ���ϸ��֤�𣬵�����
	        update
	        (
	          select /*+ BYPASS_UJVC */a.HoldQty,a.bs_flag,a.HoldMargin,a.HoldAssure,a.Price,
	          b.marginrate_b,b.marginrate_s,b.marginAssure_b,b.marginAssure_s,b.marginalgr,b.ContractFactor
	          from T_HoldPosition a,T_Commodity b
	          where b.MarginPriceType=2 and trunc(a.AtClearDate)=trunc(v_TradeDate) and a.commodityid=b.commodityid
	        )
	        set HoldMargin = FN_T_ComputeMarginByArgs(bs_flag,HoldQty,Price,contractFactor,marginAlgr,marginRate_b,marginRate_s)+FN_T_ComputeAssureByArgs(bs_flag,HoldQty,Price,contractFactor,marginAlgr,marginAssure_b,marginAssure_s),
	            HoldAssure = FN_T_ComputeAssureByArgs(bs_flag,HoldQty,Price,contractFactor,marginAlgr,marginAssure_b,marginAssure_s);
	        --�������⽻���̵ĳֲ���ϸ��֤�𣬵�����
	        update
	        (
	          select /*+ BYPASS_UJVC */a.HoldQty,a.bs_flag,a.HoldMargin,a.HoldAssure,a.Price,
	          c.marginrate_b,c.marginrate_s,c.marginAssure_b,c.marginAssure_s,c.marginalgr,
	          b.ContractFactor
	          from T_HoldPosition a,T_Commodity b,T_A_FirmMargin c
	          where b.MarginPriceType=2 and trunc(a.AtClearDate)=trunc(v_TradeDate) and a.commodityid=b.commodityid and a.commodityid=c.commodityid and a.firmid=c.firmid
	        )
	        set HoldMargin = FN_T_ComputeMarginByArgs(bs_flag,HoldQty,Price,contractFactor,marginAlgr,marginRate_b,marginRate_s)+FN_T_ComputeAssureByArgs(bs_flag,HoldQty,Price,contractFactor,marginAlgr,marginAssure_b,marginAssure_s),
	            HoldAssure = FN_T_ComputeAssureByArgs(bs_flag,HoldQty,Price,contractFactor,marginAlgr,marginAssure_b,marginAssure_s);
        end if;
      --���½��׿ͻ��ֲֺϼ��е����ݣ����о��ۺͳֲֽ���ǰ����ֶ���
	  update T_CustomerHoldSum a
      set (HoldMargin,HoldAssure,EvenPrice,HoldFunds) =
      (
          select sum(x.HoldMargin),sum(x.HoldAssure),decode(a.HoldQty+a.GageQty,0,0,sum(x.Price*(x.HoldQty+x.GageQty))/(a.HoldQty+a.GageQty)),sum(x.Price*(x.HoldQty+x.GageQty)*y.ContractFactor)
          from T_HoldPosition x,T_Commodity y
          where x.CommodityID=y.CommodityID and x.CustomerID = a.CustomerID and x.CommodityID = a.CommodityID and x.BS_Flag = a.BS_Flag
          group by x.CustomerID,x.CommodityID,x.BS_Flag
      ); 
      --���½����ֲֺ̳ϼ��е����ݣ����о��ۺͳֲֽ����������ֶ��ĸ��ݵֶ�ģʽ���жϣ����Դӳֲ���ϸ�кϼ�
	  update T_FirmHoldSum a
      set (HoldMargin,HoldAssure,EvenPrice,HoldFunds) =
      (
          select sum(x.HoldMargin),sum(x.HoldAssure),decode(a.HoldQty+decode(v_GageMode,1,a.GageQty,0),0,0,sum(x.Price*(x.HoldQty+decode(v_GageMode,1,x.GageQty,0)))/(a.HoldQty+decode(v_GageMode,1,a.GageQty,0))),sum(x.Price*(x.HoldQty+decode(v_GageMode,1,x.GageQty,0))*y.ContractFactor)
          from T_HoldPosition x,T_Commodity y
          where x.CommodityID=y.CommodityID and x.FirmID = a.FirmID and x.CommodityID = a.CommodityID and x.BS_Flag = a.BS_Flag
          group by x.FirmID,x.CommodityID,x.BS_Flag
      ); 
      --���½�������ʱ��֤��͵����𣬲����¶����ʽ�
  	  open cur_T_Firm;
      loop
    	  fetch cur_T_Firm into v_FirmID,v_Margin,v_HoldMargin,v_HoldAssure;
    	  exit when cur_T_Firm%notfound;
    	  update T_Firm set RuntimeMargin=v_HoldMargin,RuntimeAssure=v_HoldAssure where FirmID=v_FirmID;
    	  v_diff := v_HoldMargin-v_HoldAssure - v_Margin;
    	  if(v_diff <> 0) then
    	  	  v_F_FrozenFunds := FN_F_UpdateFrozenFunds(v_FirmID,v_diff,'15');
    	  end if;
 	  end loop;
      close cur_T_Firm;
      --�����е���Ҫ���㶳���ʽ�
      if(p_MarginFBFlag = 2) then
          --1�����ͷ�ԭ��������ʽ�
      	  open cur_T_Orders;
          loop
        	  fetch cur_T_Orders into v_FirmID,v_FrozenFunds;
        	  exit when cur_T_Orders%notfound;
			  v_F_FrozenFunds := FN_F_UpdateFrozenFunds(v_FirmID,-v_FrozenFunds,'15');
     	  end loop;
          close cur_T_Orders;
      	  --2������ί�б��еĶ���ͽⶳ�ʽ�
          --  mod by yukx 20100427���Ϊ���ֵ���ֻ�㶳��������
          update
          (
            select /*+ BYPASS_UJVC */a.FirmID,a.CommodityID,a.BS_Flag,a.Quantity,a.TradeQty,a.FrozenFunds,a.UnfrozenFunds,a.BillTradeType,
            decode(b.MarginPriceType,1,b.LastPrice,a.Price) Price
            from T_Orders a,T_Commodity b
            where a.commodityid=b.commodityid and a.OrderType=1 and a.Status in(1,2)
          )
          set FrozenFunds=decode(BillTradeType,1,0,FN_T_ComputeMargin(FirmID,CommodityID,BS_Flag,Quantity,Price)) + FN_T_ComputeFee(FirmID,CommodityID,BS_Flag,Quantity,Price),  --mod by yukx 20100427
		      UnfrozenFunds=decode(BillTradeType,1,0,FN_T_ComputeMargin(FirmID,CommodityID,BS_Flag,TradeQty,Price)) + FN_T_ComputeFee(FirmID,CommodityID,BS_Flag,TradeQty,Price);  --mod by yukx 20100427

		  --3�����¿۳������ʽ�
      	  open cur_T_Orders;
          loop
        	  fetch cur_T_Orders into v_FirmID,v_FrozenFunds;
        	  exit when cur_T_Orders%notfound;
			  v_F_FrozenFunds := FN_F_UpdateFrozenFunds(v_FirmID,v_FrozenFunds,'15');
     	  end loop;
          close cur_T_Orders;
      end if;

      return 1;
end;
/

prompt
prompt Creating function FN_T_UNFROZENBILL
prompt ===================================
prompt
create or replace function FN_T_UnfrozenBill(
    p_CommodityID varchar2
) return number
/****
 * �ⶳ�ֵ�
 * ����ֵ�� 1 �ɹ���-2 �Ѿ��ⶳ
****/
as
    v_BillID varchar2(16);  -- �ֵ���
	  v_num    number(10);

    --�����α��ȡ������Ʒ�Ĳֵ���
    cursor cur_BillId is
        select billId
        from t_billfrozen
        where operation in (select to_char(id) from t_e_gagebill where CommodityID = p_CommodityID);

begin

    open cur_BillId;
      loop
    	  fetch cur_BillId into v_BillID;
    	  exit when cur_BillId%notfound;
          -- �ⶳ�ֵ�
		     v_num := FN_BI_UnfrozenBill(15,v_BillID);
         if(v_num != 1) then

           -- ��Ӷ������ݿ���־
		    	 insert into t_dblog(err_date,name_proc,err_code,err_msg)
           values (sysdate, 'FN_T_UnfrozenBill',-2, '��Ʒ��'||p_CommodityID||',�ֵ���'||v_BillID||',�ⶳ�ֵ�ʧ�ܣ�');
           -- ��Ӷ�����̨������־
           insert into c_globallog_all(ID, operator, operatetime, operatetype, operatecontent, operateresult, logtype )
           values (seq_c_globallog.nextval, 'system', sysdate, 1508, '��Ʒ��'||p_CommodityID||',�ֵ���'||v_BillID||',�ⶳ�ֵ�ʧ�ܣ�', 0, 1);

           commit;

	    	 end if;
 	    end loop;
    close cur_BillId;

    return 1;

end;
/

prompt
prompt Creating function FN_T_COMPUTESETTLEPRICE
prompt =========================================
prompt
create or replace function FN_T_ComputeSettlePrice(
    p_CommodityID varchar2,  --��Ʒ����
    p_SettlePriceType number    --���㽻�ռ�����
) return number
/****
 * ���㽻�ռ۸�
 * ���㽻�ռ�����=2�İ����ּ۲��ü��㣬ֱ�Ӱ��ֲ���ϸ�п��ּ�
 * ����ֵ �ɹ����ؽ��ռ۸�
****/
as
	v_version varchar2(10):='1.0.2.1';
    v_SettlePrice         number(15,2);
    tradeFundSum         number(15,2);
    tradeQtySum  number(10);
    v_BeforeDays  number(4);
    v_SettleDate date;
    v_Quantity  number(10);
    i            number(4);
    v_num            number(10);
begin
	if(p_SettlePriceType = 0) then  --�������յı��н����
	    --�ҳ������յ���������
	    begin
	    	select nvl(Price,0) into v_SettlePrice from T_Quotation where CommodityID=p_CommodityID;
	    exception
	        when NO_DATA_FOUND then
           begin
	            select nvl(Price,0) into v_SettlePrice from T_H_Quotation where CommodityID=p_CommodityID and ClearDate in(select max(ClearDate) from T_H_Quotation where CommodityID=p_CommodityID);
	        exception
	        when NO_DATA_FOUND then
           return 0;
           end;
      end;
	elsif(p_SettlePriceType = 1) then  --��������ǰ���յı��н���۵ļ�Ȩƽ����
		--�ҳ���ǰ�գ���������
	    select SettleDate,BeforeDays into v_SettleDate,v_BeforeDays from T_Commodity where CommodityID=p_CommodityID;
        tradeQtySum := 0;
        tradeFundSum := 0;
        --�ж��Ƿ��ʽ������ɣ�������״̬����Ϊ��������ʱ״̬��仯
        --����ʽ������ɵĻ���ǰ�ɽ���ɾ�����Ӷ����µ���ļ۸�û�в������ 2010-05-24 by chenxc
        select count(*) into v_num from T_H_Quotation where CommodityID=p_CommodityID and ClearDate = v_SettleDate;
        if(v_num = 0) then
		    --�ӵ�ǰ���м��㽻�ս�������
		    begin
		    	select nvl(Price,0) into v_SettlePrice from T_Quotation where CommodityID=p_CommodityID;
		    	select nvl(sum(Quantity),0) into v_Quantity from T_Trade where CommodityID=p_CommodityID;
		    	tradeFundSum := tradeFundSum + v_SettlePrice*v_Quantity;
				tradeQtySum := tradeQtySum + v_Quantity;
		    	i := 1;
		    exception
		        when NO_DATA_FOUND then
		           i := 0;
		    end;
		else
			i := 0;
		end if;
	    --ѭ�����㽻����ǰ��v_BeforeDays�Ľ������������������յ����v_BeforeDays�Ľ�������
        while i<v_BeforeDays loop
        	--����������ж��Ǳ�ʾ������õ���ǰ���յļ�Ȩ�۵���������ʵ�ʵĽ�������ʱ�����ѭ�����������ķ�Χ��Ҳ�������õ��������ڽ��������򰴽������������Ȩ�۸�
            if(v_BeforeDays>=999 or i>=999) then
            	exit;
   			end if;
		    --����ʷ���м��㽻�ս�������
		    begin
		    	select nvl(Price,0) into v_SettlePrice from T_H_Quotation where CommodityID=p_CommodityID and ClearDate = v_SettleDate-i;
		    	select nvl(sum(Quantity),0) into v_Quantity from T_H_Trade where CommodityID=p_CommodityID and ClearDate = v_SettleDate-i;
		    	tradeFundSum := tradeFundSum + v_SettlePrice*v_Quantity;
		    	tradeQtySum := tradeQtySum + v_Quantity;
		    exception
		        when NO_DATA_FOUND then
		            v_BeforeDays := v_BeforeDays + 1;
		    end;
            i := i+1;
        end loop;
        --�����Ȩƽ���ۣ��������Ϊ0�Ļ������������Ľ��ռ�
		if(tradeQtySum <> 0) then
        	v_SettlePrice := round(tradeFundSum/tradeQtySum,0);
        end if;
	elsif(p_SettlePriceType = 3) then  --��ָ�����ռ�
		select SpecSettlePrice into v_SettlePrice from T_Commodity where CommodityID=p_CommodityID;
    end if;
    return v_SettlePrice;
end;
/

prompt
prompt Creating function FN_T_SETTLEPROCESS
prompt ====================================
prompt
create or replace function FN_T_SettleProcess(
    p_CommodityID varchar2,
    p_SettleType number   --0���Զ����գ�1���ֶ����գ�
) return number
/****
 * ���մ���
 * 1��ע�ⲻҪ�ύcommit����Ϊ���д�����Ҫ��������
 * 2�����׽���֮ǰ����������
 * 3���˺��������˽�������ʱ��������Ϊ�Զ�����ʱ���н�������㣬�ֹ�������ͨ���ⲿ�������㸡���߳�������
 * ����ֵ
 * 1 �ɹ�
 * -1 ����ʱ�������ݲ�ȫ
 * -100 ��������
****/
as
  v_version varchar2(10):='1.0.2.1';
    v_CommodityID varchar2(16):=p_CommodityID;
    v_BreedID number(10);  --FN_T_SettleProcessƷ��id, add by tangzy 2010-06-21
    v_FirmID varchar2(32);
    v_CustomerID        varchar2(40);
    v_HoldQty  number(10);
    v_Payout         number(15,2):=0;
    v_Payout_one         number(15,2):=0;
    v_Margin         number(15,2):=0;
    v_Margin_one         number(15,2):=0;
    v_Margin_b         number(15,2):=0;
    v_Margin_b_one         number(15,2):=0;
    v_Margin_s         number(15,2):=0;
    v_Margin_s_one         number(15,2):=0;
    v_closeFL_one         number(15,2):=0;    --һ����¼�Ľ���ӯ��
    v_CloseFL         number(15,2):=0;        --����ӯ���ۼ�
    v_Fee_one         number(15,2):=0;    --һ����¼�Ľ���������
    v_Fee         number(15,2):=0;        --�����������ۼ�
    v_BS_Flag           number(2);
    v_Price         number(15,2);
    v_ContractFactor    number(12,2);
    v_LastFirmID varchar2(32) default null;
    v_TradeDate date;--������ʷ��ʱ�Դ���״̬���е����ڲ��룬�����õ�������ڣ���Ϊ���ڽ�����������
  v_SettlePriceType number(2);
  v_A_HoldNo number(15); --��ǰ�ɽ���
  v_Last_A_HoldNo number(15); --��һ�ʳɽ���
  v_AddedTaxFactor T_Commodity.AddedTaxFactor%type;--��ֵ˰��ϵ��=AddedTax/(1+AddedTax)
  v_GageQty     number(10);
  v_SettlePrice         number(15,2);
  v_CloseAddedTax_one   number(15,2); --����ӯ����ֵ˰
  v_CloseAddedTax         number(15,2):=0;        --����ӯ����ֵ˰�ۼ�
  v_num            number(10);
  v_Balance    number(15,2);
  v_F_FrozenFunds   number(15,2);
  v_redoCal           number(2):=0;    --�Ƿ����������㣬0�������������㣻1�����������㣻
  v_sql  varchar2(1000);
  v_str  varchar2(100);
  v_EvenPrice         number(16,6);
    v_LowestSettleFee             number(15,2) default 0;
    v_TaxInclusive     number(1);   --��Ʒ�Ƿ�˰ 0��˰  1����˰   xiefei 20150730
    --���ճֲ���ϸ���м��㽻���ʽ��α�
    type c_T_SettleHoldPosition is ref cursor;
  v_T_SettleHoldPosition c_T_SettleHoldPosition;
    --�����α���¶����ʽ��ͷŸ��˲��ֵı�֤��
    cursor cur_T_FirmHoldSum is
        select FirmID,HoldMargin-HoldAssure
        from T_FirmHoldSum
        where CommodityID=p_CommodityID;
    --���ճֲ���ϸ�����˽������ʽ��αֻ꣬�����ֶ����Զ�����
    cursor cur_BackFunds(c_TradeDate date,c_CommodityID varchar2) is
        select FirmID,sum(SettleMargin),sum(Payout),sum(SettleFee),sum(Settle_PL),sum(SettleAddedTax)
      from T_SettleHoldPosition
      where SettleProcessDate=c_TradeDate and CommodityID=c_CommodityID and SettleType in(0,1)
      group by FirmID;
    --���ճֲ���ϸ���и��³ֲ־����αֻ꣬�����ֶ����Զ�����
    cursor cur_EvenPrice(c_TradeDate date,c_CommodityID varchar2) is
        select FirmID,BS_Flag,decode(nvl(sum(HoldQty+GageQty),0),0,0,nvl(sum(Price*(HoldQty+GageQty)),0)/sum(HoldQty+GageQty)) EvenPrice
        from T_SettleHoldPosition
        where SettleProcessDate=c_TradeDate and CommodityID=c_CommodityID and SettleType in(0,1)
        group by FirmID,BS_Flag;

    v_SettleType  number(10):= 1; --�������ڲ����ֶ����Զ����գ����ڽ������������ݿ���Ϊ1,���������͵���1��
    v_billNum            number(10);
begin
    --1����ȡ��������
    select TradeDate into v_TradeDate from T_SystemStatus;
      --�ж��Ƿ���������
      select count(*) into v_num from T_SettleHoldPosition where SettleProcessDate = v_TradeDate and CommodityID=v_CommodityID and SettleType in(0,1);
      if(v_num > 0) then
          v_redoCal := 1;
      end if;

/*
    select AddedTaxFactor,ContractFactor,SettlePriceType,LowestSettleFee
    into   v_AddedTaxFactor,v_ContractFactor,v_SettlePriceType,v_LowestSettleFee    20150730  xief */

    -----�����Ƿ�˰�ֶ� xief  20150730
    select AddedTaxFactor,ContractFactor,SettlePriceType,LowestSettleFee,TaxInclusive
    into   v_AddedTaxFactor,v_ContractFactor,v_SettlePriceType,v_LowestSettleFee,v_TaxInclusive
      from T_Commodity
      where CommodityID=v_CommodityID;
      --2���˴���Ʒ��ȫ��ʵʱ�ı�֤��͵����𣬲���ȥ���㱣֤��͵�����ֱ��ȡ
    update T_Firm a
      set RuntimeMargin = RuntimeMargin-
      nvl((
          select sum(HoldMargin)
          from T_FirmHoldSum
          where CommodityID=v_CommodityID and FirmID=a.FirmID
          group by FirmID
      ),0), RuntimeAssure = RuntimeAssure-
      nvl((
          select sum(HoldAssure)
          from T_FirmHoldSum
          where CommodityID=v_CommodityID and FirmID=a.FirmID
          group by FirmID
      ),0)
      where a.FirmID in (select distinct FirmID from T_FirmHoldSum where CommodityID=v_CommodityID);
      -- 2.5�������α���¶����ʽ��ͷŸ��˲��ֵı�֤��
      open cur_T_FirmHoldSum;
      loop
        fetch cur_T_FirmHoldSum into v_FirmID,v_Margin;
        exit when cur_T_FirmHoldSum%notfound;
          --���¶����ʽ��ͷŸ��˲��ֵı�֤��
      v_F_FrozenFunds := FN_F_UpdateFrozenFunds(v_FirmID,-v_Margin,'15');
    end loop;
      close cur_T_FirmHoldSum;

    --���ֶ������뽻�ճֲ���ϸ��
    insert into t_settleholdposition
      (id, settleprocessdate, a_holdno, a_tradeno, customerid, commodityid, bs_flag, price, holdqty, openqty, holdtime, holdmargin, firmid, gageqty, holdassure, floatingloss, settlemargin, payout, settlefee, settle_pl, settleaddedtax, settleprice, settletype, holdtype, atcleardate,MATCHStatus)
      select SEQ_T_SettleHoldPosition.nextval,v_TradeDate,a_holdno, a_tradeno, customerid, commodityid, bs_flag, price, holdqty, openqty, holdtime, holdmargin, firmid, gageqty, holdassure, floatingloss,0,0,0,0,0,0,v_SettleType , holdtype, atcleardate , 0
      from t_holdposition
      where CommodityID=v_CommodityID and (HoldQty+GageQty) > 0;

    --���պ�����Ч�ֵ��ֶ�������������  add by tangzy 2010-06-18
    select BREEDID into v_BreedID from T_Commodity where COMMODITYID=v_CommodityID;
    update t_validgagebill t
      set quantity = quantity +
                     nvl((select gageqty from t_firmholdsum a
                                  where a.commodityid = v_CommodityID
                                    and a.firmid = t.firmid
                                    and a.bs_flag = 2),
                         0)
      where t.commodityId=v_CommodityID;

      --7��ɾ������Ʒ�Ľ��׿ͻ��ֲ���ϸ,���׿ͻ��ֲֺϼƱ������ֲֺ̳ϼƱ�
    delete from T_HoldPosition where CommodityID=v_CommodityID;
      delete from T_CustomerHoldSum where CommodityID=v_CommodityID;
      delete from T_FirmHoldSum where CommodityID=v_CommodityID;

      --�������������Ļ���Ҫ���˽����ʽ�д��ˮ���൱�ں��,�����ֶ����Զ�����
    if(v_redoCal = 1) then
        open cur_BackFunds(v_TradeDate,v_CommodityID);
        loop
          fetch cur_BackFunds into v_FirmID,v_Margin,v_Payout,v_Fee,v_CloseFL,v_CloseAddedTax;
          exit when cur_BackFunds%notfound;
          --�˽��ջ�����������ѣ�������ӯ�����ս��տ��� ����д��ˮ
          v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15008',-v_Payout,null,v_CommodityID,null,null);
          v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15010',-v_Fee,null,v_CommodityID,null,null);
          --��ӯ��Ҳ�÷�����
          if(v_CloseFL >= 0) then
            v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15011',-v_CloseFL,null,v_CommodityID,-v_CloseAddedTax,null);
          else
            v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15012',v_CloseFL,null,v_CommodityID,v_CloseAddedTax,null);
          end if;
            --�˽��ձ�֤�𣬲�д��ˮ
        update T_Firm set RuntimeSettleMargin=RuntimeSettleMargin-v_Margin where FirmID=v_FirmID;
          v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15013',-v_Margin,null,v_CommodityID,null,null);
      end loop;
        close cur_BackFunds;
          --������0
          v_Margin := 0;
          v_Payout := 0;
        v_Fee := 0;
        v_CloseFL := 0;
        v_CloseAddedTax := 0;

        v_str := ' and SettleType in(0,1) ';
    else
        v_str := ' and SettleType =' || v_SettleType;
      end if;

      --4��������ǰ����ּ�������㷨���㽻�ռ�
    if(v_SettlePriceType <> 2) then
        v_SettlePrice := FN_T_ComputeSettlePrice(v_CommodityID,v_SettlePriceType);
      end if;
    v_sql := 'select A_HoldNo,FirmID,BS_Flag,HoldQty,Price,GageQty,CustomerID ' ||
               'from T_SettleHoldPosition ' ||
               'where to_char(SettleProcessDate,''yyyy-MM-dd'')=''' || to_char(v_TradeDate,'yyyy-MM-dd') || ''' and CommodityID=''' || v_CommodityID || '''' ||
               v_str ||
               'order by FirmID ';
      --5�������α���ݽ��ռ����۳����ջ�����������ѣ�����ӯ������д�ʽ���ˮ�������ֶ���
      --6��ͬʱ���ֲ���ϸ��ת�뽻�ճֲ���ϸ����ɾ���ֲ���ϸ������Ӧ��¼
      open v_T_SettleHoldPosition for v_sql;
      loop
          fetch v_T_SettleHoldPosition into v_A_HoldNo,v_FirmID,v_BS_Flag,v_HoldQty,v_Price,v_GageQty,v_CustomerID;
          exit when v_T_SettleHoldPosition%notfound;
            --�ж��Ƿ���ͬһ������
            if(v_LastFirmID is not null and v_LastFirmID <> v_FirmID) then
            --�۳����ջ�����������ѣ�������ӯ�����ս��տ��� ����д��ˮ
          v_Balance := FN_F_UpdateFundsFull(v_LastFirmID,'15008',v_Payout,null,v_CommodityID,null,null);
          --��������ѵ�����ͽ��������ѣ�����ͽ�����������ȡ�����ҽ��˽��������һ����ϸ�������Ѹ��³ɼ��ϲ���������
          if(v_Fee >= v_LowestSettleFee) then
              v_Balance := FN_F_UpdateFundsFull(v_LastFirmID,'15010',v_Fee,null,v_CommodityID,null,null);
        else
            v_Balance := FN_F_UpdateFundsFull(v_LastFirmID,'15010',v_LowestSettleFee,null,v_CommodityID,null,null);
              update T_SettleHoldPosition
              set SettleFee=SettleFee+(v_LowestSettleFee-v_Fee)
              where SettleProcessDate=v_TradeDate and A_HoldNo=v_Last_A_HoldNo and SettleType in(0,1); -- 2010-07-30 ����SettleType in(0,1)
          end if;

          if(v_CloseFL >= 0) then
            v_Balance := FN_F_UpdateFundsFull(v_LastFirmID,'15011',v_CloseFL,null,v_CommodityID,v_CloseAddedTax,null);
          else
            v_Balance := FN_F_UpdateFundsFull(v_LastFirmID,'15012',-v_CloseFL,null,v_CommodityID,-v_CloseAddedTax,null);
          end if;

            --�۳����ձ�֤�𣬲�д��ˮ
        update T_Firm set RuntimeSettleMargin=RuntimeSettleMargin+v_Margin_b+v_Margin_s where FirmID=v_LastFirmID;
          v_Balance := FN_F_UpdateFundsFull(v_LastFirmID,'15013',v_Margin_b+v_Margin_s,null,v_CommodityID,null,null);

            --��һ��ͬ��������������0
                v_Margin_b := 0;
                v_Margin_s := 0;
                v_Payout := 0;
            v_Fee := 0;
            v_CloseFL := 0;
            v_CloseAddedTax := 0;
            end if;
            --��������ּۼ��㽻�ռ�����ǿ��ּ�
            if(v_SettlePriceType = 2) then
              v_SettlePrice := v_Price;
            end if;
      --���㽻�ձ�֤��
          v_Margin_one := FN_T_ComputeSettleMargin(v_FirmID,v_CommodityID,v_BS_Flag,v_HoldQty+v_GageQty,v_SettlePrice);
            if(v_Margin_one < 0) then
                Raise_application_error(-20042, 'ComputeSettleMargin error');
            end if;
          if(v_BS_Flag = 1) then
            v_Margin_b_one := v_Margin_one;
            --������ҽ��ջ���
            v_Payout_one := FN_T_ComputePayout(v_FirmID,v_CommodityID,v_BS_Flag,v_HoldQty+v_GageQty,v_SettlePrice);
            if(v_Payout_one < 0) then
                  Raise_application_error(-20043, 'computePayout error');
              end if;
          else
            v_Margin_s_one := v_Margin_one;
            end if;
          --���㽻��������
      v_Fee_one := FN_T_ComputeSettleFee(v_FirmID,v_CommodityID,v_bs_flag,v_HoldQty+v_GageQty,v_SettlePrice);
            if(v_Fee_one < 0) then
              Raise_application_error(-20031, 'computeFee error');
            end if;
       --����˰ǰ����ӯ��
            if(v_BS_Flag = 1) then
                v_closeFL_one := (v_HoldQty+v_GageQty)*(v_SettlePrice-v_price)*v_contractFactor; --˰ǰӯ��
            else
                v_closeFL_one := (v_HoldQty+v_GageQty)*(v_price-v_SettlePrice)*v_contractFactor; --˰ǰӯ��
            end if;
            --���㽻����ֵ˰,v_AddedTaxFactor��ֵ˰ϵ��=AddedTax/(1+AddedTax) xief 20150811
          --  v_CloseAddedTax_one := round(v_closeFL_one*v_AddedTaxFactor,2);
             v_CloseAddedTax_one := 0;
             --����˰��Ľ���ӯ�� xief 20150730  xief 20150811
           /*   if(v_TaxInclusive=1) then
                     --����˰ �۳���ֵ˰
                     v_closeFL_one := v_closeFL_one - v_CloseAddedTax_one; --˰��ӯ��
              end if;
              */
               /*
            --����˰����ӯ��
            v_closeFL_one := v_closeFL_one - v_CloseAddedTax_one; --˰��ӯ��   xief 20150730*/

          --����ǰ�ֲּ�¼�ͽ��շ��ò��뽻�ճֲ���ϸ��
          update T_SettleHoldPosition
          set SettleMargin=v_Margin_one,Payout=v_Payout_one,SettleFee=v_Fee_one,Settle_PL=v_closeFL_one,SettleAddedTax=v_CloseAddedTax_one,SettlePrice=v_SettlePrice
          where SettleProcessDate=v_TradeDate and A_HoldNo=v_A_HoldNo and SettleType in(0,1); -- 2010-07-30 ����SettleType in(0,1)


      --�ۼƽ��
          v_Margin_b := v_Margin_b + v_Margin_b_one;
          v_Margin_s := v_Margin_s + v_Margin_s_one;
          v_Payout := v_Payout + v_Payout_one;
          v_Fee := v_Fee + v_Fee_one;
          v_CloseFL := v_CloseFL + v_closeFL_one;  --˰��ӯ���ϼ�
      v_CloseAddedTax:=v_CloseAddedTax + v_CloseAddedTax_one;  --������ֵ˰�ϼ�
      --������0
          v_Margin_b_one := 0;
          v_Margin_s_one := 0;
      v_Payout_one := 0;
      --���˽�����ID�����ϸ�������ID�������жϴ˽������Ƿ�������
            v_LastFirmID := v_FirmID;
            v_Last_A_HoldNo := v_A_HoldNo; --���ڸ�����������ѵĲ��
      end loop;
      close v_T_SettleHoldPosition;
      --�۳����һ�������̵Ľ��ջ�����������ѣ�������ӯ�����ս��տ��� ����д��ˮ
    if(v_LastFirmID is not null) then
    v_Balance := FN_F_UpdateFundsFull(v_LastFirmID,'15008',v_Payout,null,v_CommodityID,null,null);
    --��������ѵ�����ͽ��������ѣ�����ͽ�����������ȡ�����ҽ��˽��������һ����ϸ�������Ѹ��³ɼ��ϲ���������
      if(v_Fee >= v_LowestSettleFee) then
          v_Balance := FN_F_UpdateFundsFull(v_LastFirmID,'15010',v_Fee,null,v_CommodityID,null,null);
    else
        v_Balance := FN_F_UpdateFundsFull(v_LastFirmID,'15010',v_LowestSettleFee,null,v_CommodityID,null,null);
          update T_SettleHoldPosition
          set SettleFee=SettleFee+(v_LowestSettleFee-v_Fee)
          where SettleProcessDate=v_TradeDate and A_HoldNo=v_Last_A_HoldNo and SettleType in(0,1); -- 2010-07-30 ����SettleType in(0,1)
      end if;
      --��Ʒ������˰�������۳�����ӯ���ͽ��տ���
    /*if(v_CloseFL >= 0) then
      v_Balance := FN_F_UpdateFundsFull(v_LastFirmID,'15011',v_CloseFL,null,v_CommodityID,v_CloseAddedTax,null);
    else
      v_Balance := FN_F_UpdateFundsFull(v_LastFirmID,'15012',-v_CloseFL,null,v_CommodityID,-v_CloseAddedTax,null);
    end if;*/
    ---xief  20150811
    if(v_CloseFL >= 0) then
      v_Balance := FN_F_UpdateFundsFull(v_LastFirmID,'15011',v_CloseFL,null,v_CommodityID,null,null);
    else
      v_Balance := FN_F_UpdateFundsFull(v_LastFirmID,'15012',-v_CloseFL,null,v_CommodityID,null,null);
    end if;


        --�۳����һ�������̽��ձ�֤�𣬲�д��ˮ
    update T_Firm set RuntimeSettleMargin=RuntimeSettleMargin+v_Margin_b+v_Margin_s where FirmID=v_LastFirmID;
    v_Balance := FN_F_UpdateFundsFull(v_LastFirmID,'15013',v_Margin_b+v_Margin_s,null,v_CommodityID,null,null);
    end if;
        --����ǰ����ּ��������Ʒ�ϵĽ��ս����Ϊ-1��ͬʱ���½��ճֲ���ϸ���еĽ��ռ�Ϊ����Ʒ�������̣������ĳֲ־��ۣ���Ϊ���շ������ʱҪ��
      if(v_SettlePriceType = 2) then
            v_SettlePrice := -1;

          open cur_EvenPrice(v_TradeDate,v_CommodityID);
          loop
            fetch cur_EvenPrice into v_FirmID,v_BS_Flag,v_EvenPrice;
            exit when cur_EvenPrice%notfound;
          --  update T_SettleHoldPosition--ȥ�����½��ճֲ���ϸ�Ľ��ռ۸�
           -- set SettlePrice=v_EvenPrice
          --  where SettleProcessDate=v_TradeDate and CommodityID=v_CommodityID and SettleType in(0,1)
             --     and FirmID=v_FirmID and BS_Flag=v_BS_Flag;
        end loop;
          close cur_EvenPrice;
        end if;
    --���½��ռ۵���Ʒ���еĽ��ս�����У������뽻����Ʒ��
    update T_Commodity set SpecSettlePrice=v_SettlePrice where CommodityID=v_CommodityID;
    -- ɾ��������Ʒʱȥ�����մ����������������������Ʒ��������ʱ����ͬ����Ʒ��������Ʒ�У���Ϊ֮ǰ�����걨�ɽ�ʱ�����  by 2013-11-18 zdaodc
    -- delete from T_SettleCommodity where SettleProcessDate=v_TradeDate and CommodityID=v_CommodityID;
    delete from T_SettleCommodity where  CommodityID=v_CommodityID;
        insert into T_SettleCommodity select v_TradeDate,a.* from T_Commodity a where a.CommodityID=v_CommodityID;

      --�ͷŸ����Ķ����ʽ�����ֻ�ͷ�û�гֲֶ�����ʱ������Ϊ0�ģ��������ͨ��JAVA���ø�������洢���ͷţ��������ɾ���ֲִ���ĺ�����
        for fz in (select FirmID,RuntimeFL from T_Firm where FirmID not in(select distinct FirmID from T_FirmHoldSum) and RuntimeFL <> 0)
        loop
            update T_Firm set RuntimeFL = 0 where FirmID = fz.FirmID;
            --���¶����ʽ��ͷŻ�۳��仯�ĸ���0
        v_F_FrozenFunds := FN_F_UpdateFrozenFunds(fz.FirmID,-fz.RuntimeFL,'15');
        end loop;

      -- �ⶳ�ֵ�
      v_billNum := FN_T_UnfrozenBill(v_CommodityID);

      --ɾ���ֵ�������С��ֵ��ֶ������Ч�ֵ��ֶ����е�����
      delete from t_billfrozen where operation in (select to_char(id) from t_e_gagebill where commodityid = v_CommodityID);
      insert into t_e_hisgagebill
       select v_TradeDate,t.* from t_e_gagebill t where commodityid = v_CommodityID;
      delete from t_e_gagebill where commodityid = v_CommodityID;
      delete from t_validgagebill  where commodityid = v_CommodityID;

    return 1;

end;
/

prompt
prompt Creating function FN_T_TRADEFLOW
prompt ================================
prompt
create or replace function FN_T_TradeFlow(
    p_TradeFlowType number   --0��д������ˮ��1��д��ϸ��ˮ��
)
return number
/****
 * д�ɽ��ʽ���ˮ���������ڱ����������Ҫ����
 * ע�ⲻҪ�ύcommit
 * ����ֵ
 * 1 �ɹ�
****/
as
  v_version varchar2(10):='1.0.0.1';
  v_A_TradeNo      number(15);
    v_CommodityID varchar2(16);
    v_FirmID varchar2(32);
    v_TradeFee         number(15,2);
    v_Close_PL         number(15,2);
    v_CloseAddedTax         number(15,2);
  v_Balance    number(15,2);
    --�ɽ���ϸ�α꣬д�ɽ���ϸ��ˮ
    cursor cur_T_Trade is
        select A_TradeNo,FirmID,CommodityID,TradeFee,nvl(Close_PL,0),nvl(CloseAddedTax,0)
        from T_Trade order by A_TradeNo;
    --�ɽ������������α꣬ÿ��������дһ����ˮ
    cursor cur_fee_sum is
        select FirmID,sum(TradeFee) from T_Trade group by FirmID;
    --�ɽ�����ƽ��ӯ���α꣬ÿ��������ÿ����Ʒдһ����ˮ
    cursor cur_Close_PL_sum is
        select FirmID,CommodityID,sum(nvl(Close_PL,0)),sum(nvl(CloseAddedTax,0))
        from T_Trade group by FirmID,CommodityID;
begin
  if(p_TradeFlowType = 0) then
        --�ɽ������������α�
        open cur_fee_sum;
        loop
          fetch cur_fee_sum into v_FirmID,v_TradeFee;
          exit when cur_fee_sum%notfound;
      --�����ʽ�����д��������ˮ
      if(v_TradeFee <> 0) then
          v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15001',v_TradeFee,null,null,null,null);
        end if;
      end loop;
        close cur_fee_sum;
        --�ɽ�����ƽ��ӯ���α�
        open cur_Close_PL_sum;
        loop
          fetch cur_Close_PL_sum into v_FirmID,v_CommodityID,v_Close_PL,v_CloseAddedTax;
          exit when cur_Close_PL_sum%notfound;
      --�����ʽ�����д������ӯ��,�ս��׿��� ��ˮ

      if(v_Close_PL > 0) then
        v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15006',v_Close_PL,null,v_CommodityID,v_CloseAddedTax,null);
      elsif(v_Close_PL < 0) then
        v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15007',-v_Close_PL,null,v_CommodityID,-v_CloseAddedTax,null);
      end if;


      end loop;
        close cur_Close_PL_sum;
  else
        --�ɽ���ϸ�α�
        open cur_T_Trade;
        loop
          fetch cur_T_Trade into v_A_TradeNo,v_FirmID,v_CommodityID,v_TradeFee,v_Close_PL,v_CloseAddedTax;
          exit when cur_T_Trade%notfound;
      --�����ʽ�����д��������ˮ
      if(v_TradeFee <> 0) then
          v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15001',v_TradeFee,v_A_TradeNo,v_CommodityID,null,null);
        end if;
      --�����ʽ�����д������ӯ��,�ս��׿��� ��ˮ
      if(v_Close_PL > 0) then
        v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15006',v_Close_PL,v_A_TradeNo,v_CommodityID,v_CloseAddedTax,null);
      elsif(v_Close_PL < 0) then
        v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15007',-v_Close_PL,v_A_TradeNo,v_CommodityID,-v_CloseAddedTax,null);
      end if;
      end loop;
        close cur_T_Trade;
  end if;
    return 1;
end;
/

prompt
prompt Creating procedure SP_T_CLEARACTION_DONE
prompt ========================================
prompt
create or replace procedure SP_T_ClearAction_Done
(
    p_ActionID   T_ClearStatus.ActionID%type
)
is
    PRAGMA AUTONOMOUS_TRANSACTION;
begin
    update T_ClearStatus
       set status = 'Y',
           FinishTime = sysdate
     where ActionID = p_ActionID;
    commit;
end;
/

prompt
prompt Creating function FN_T_CLOSEMARKETPROCESS
prompt =========================================
prompt
create or replace function FN_T_CloseMarketProcess
return number
/****
 * ���н��㴦���ɶ�ν���
 * ����ֵ
 * 1 �ɹ�
 * -2 ���մ������
 * -100 ��������
****/
as
  v_version varchar2(10):='1.0.0.1';
  v_b_date f_systemstatus.b_date%type;
  v_status f_systemstatus.status%type;
  v_CommodityID varchar2(16);
  v_TradeDate date;
  v_ret           number(5);
  v_SettleMode           number(2);
  v_errorcode number;
  v_errormsg  varchar2(200);
  --��Ʒ�����α�
  cursor cur_settle(c_TradeDate date) is select CommodityID from T_Commodity where SettleDate<=c_TradeDate;


  v_sql            varchar2(500);
  v_Balance        number(15,2);
  v_num            number(10);
  v_FirmID         varchar2(32);
  v_customerid     varchar2(40);
  v_Margin         number(15,2):=0;
  v_Assure         number(15,2):=0;
  v_FloatingLossComputeType number(2);
  v_TradeFlowType number(2);
  v_LastFloatingLossComputeType number(2);
  v_FloatLoss         number(15,2):=0;        --����ֲ���ϸ�ĸ���ӯ���ϼƣ���ֵΪ��ӯ����Ϊ����
  v_bs_flag number(5);
  v_frozenqty number(10);

  --����Ʒд��ˮ�α�
  type cur_CmdtyDaily is ref cursor;
  v_CmdtyDaily cur_CmdtyDaily;

  type cue_qtyAboutCustonerhold is ref cursor;
  v_qtyAboutCustonerhold cue_qtyAboutCustonerhold;

  type cur_HoldFrozen is ref cursor;
  v_HoldFrozen cur_HoldFrozen;

  v_c_customerid varchar2(40);
  v_c_commodityid varchar2(16);
  v_c_bs_flag number(5);
  v_c_frozenqty number(10);
  v_c_gagefrozenqty number(10);


begin
     --�Զ���ϵͳ״̬���������ֹ���׽��㲢��
   select t.tradedate,t.status into v_b_date,v_status from t_systemstatus t for update;
   update t_systemstatus t
           set t.status = 2,
               t.note = '������';
  commit; --�˴��ύ��Ϊ�˽�����״̬��Χ�ܿ�����



      -- һ����ȡ�������ڡ���ȡ����ģʽ���������㷽ʽ�����㿪ʼ
    select TradeDate into v_TradeDate from T_SystemStatus;
    select SettleMode into v_SettleMode from T_A_Market;
    SP_T_ClearAction_Done(p_actionid => 0);



    -- �������մ���
      --����Զ����յĻ�������н��մ���
    if(v_SettleMode = 0) then
        open cur_settle(v_TradeDate);
        loop
          fetch cur_settle into v_CommodityID;
          exit when cur_settle%notfound;
          v_ret := FN_T_SettleProcess(v_CommodityID,0);
          if(v_ret < 0) then
              rollback;
            return -2;
          end if;
       end loop;
        close cur_settle;
      end if;
      SP_T_ClearAction_Done(p_actionid => 1);



      -- �������㽻���ʽ�
      v_ret := FN_T_ReComputeFunds(0);
      if(v_ret < 0) then
          rollback;
          return -100;
      end if;
      SP_T_ClearAction_Done(p_actionid => 2);



      -- �ġ����㸡��
      v_ret := FN_T_ReComputeFloatLoss();
      if(v_ret < 0) then
          rollback;
          return -100;
      end if;
      SP_T_ClearAction_Done(p_actionid => 3);



      -- �塢���ڽ��׽���
      v_ret := FN_T_D_CloseProcess();
      select FloatingLossComputeType,TradeFlowType into v_FloatingLossComputeType,v_TradeFlowType from T_A_Market;
      v_ret := FN_T_TradeFlow(v_TradeFlowType);
      SP_T_ClearAction_Done(p_actionid => 4);



      --���������ս��㱣֤��
      v_sql := 'select FirmID,CommodityID,sum(HoldMargin)-sum(HoldAssure),sum(HoldAssure) from T_H_FirmHoldSum where ClearDate =(select max(ClearDate) from T_H_Market) group by FirmID,CommodityID';
        open v_CmdtyDaily for v_sql;
        loop
            fetch v_CmdtyDaily into v_FirmID,v_CommodityID,v_Margin,v_Assure;
            exit when v_CmdtyDaily%NOTFOUND;
            --�����ʽ�����д�����ս��㱣֤����ˮ
            if(v_Margin <> 0) then
                v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15003',v_Margin,null,v_CommodityID,v_Assure,null);
            end if;
        end loop;
        close v_CmdtyDaily;
      SP_T_ClearAction_Done(p_actionid => 5);



      -- �ߡ��۵��ս��㱣֤��
      v_sql := 'select FirmID,CommodityID,sum(HoldMargin)-sum(HoldAssure),sum(HoldAssure) from T_FirmHoldSum group by FirmID,CommodityID';
        open v_CmdtyDaily for v_sql;
        loop
            fetch v_CmdtyDaily into v_FirmID,v_CommodityID,v_Margin,v_Assure;
            exit when v_CmdtyDaily%NOTFOUND;
            --�����ʽ�����д�����ս��㱣֤����ˮ
            if(v_Margin <> 0) then
                v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15002',v_Margin,null,v_CommodityID,v_Assure,null);
            end if;
        end loop;
        close v_CmdtyDaily;
      SP_T_ClearAction_Done(p_actionid => 6);




      -- �ˡ�����������ս��׵������������ո���
      select count(*) into v_num from T_H_Market where ClearDate =(select max(ClearDate) from T_H_Market);
      if(v_num >0) then
        --��ȡ��һ�����յĸ������㷽ʽ
        select FloatingLossComputeType into v_LastFloatingLossComputeType from T_H_Market where ClearDate =(select max(ClearDate) from T_H_Market);
        if(v_LastFloatingLossComputeType = 0) then     --��Ʒ������
            v_sql := 'select FirmID,CommodityID,sum(case when FloatingLoss>0 then 0 else -FloatingLoss end) from T_H_FirmHoldSum where ClearDate =(select max(ClearDate) from T_H_Market) group by FirmID,CommodityID';
            open v_CmdtyDaily for v_sql;
            loop
                fetch v_CmdtyDaily into v_FirmID,v_CommodityID,v_FloatLoss;
                exit when v_CmdtyDaily%NOTFOUND;
                --�����ʽ�����д�����ո�����ˮ
                if(v_FloatLoss <> 0) then
                  v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15005',v_FloatLoss,null,v_CommodityID,null,null);
                end if;
            end loop;
            close v_CmdtyDaily;
        elsif(v_LastFloatingLossComputeType = 1) then  --��Ʒ��������
            v_sql := 'select FirmID,CommodityID,sum(FloatingLoss) from T_H_FirmHoldSum where ClearDate =(select max(ClearDate) from T_H_Market) group by FirmID,CommodityID';
            open v_CmdtyDaily for v_sql;
            loop
                fetch v_CmdtyDaily into v_FirmID,v_CommodityID,v_FloatLoss;
                exit when v_CmdtyDaily%NOTFOUND;
                if(v_FloatLoss <= 0) then
                  v_FloatLoss := -v_FloatLoss;
                  --�����ʽ�����д�����ո�����ˮ
                  if(v_FloatLoss <> 0) then
                    v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15005',v_FloatLoss,null,v_CommodityID,null,null);
                  end if;
                end if;
            end loop;
            close v_CmdtyDaily;
        elsif(v_LastFloatingLossComputeType = 2) then  --������Ʒ
            v_sql := 'select FirmID,case when sum(FloatingLoss) >0 then 0 else  -sum(FloatingLoss) end from T_H_FirmHoldSum where ClearDate =(select max(ClearDate) from T_H_Market) group by FirmID ';
            open v_CmdtyDaily for v_sql;
            loop
                fetch v_CmdtyDaily into v_FirmID,v_FloatLoss;
                exit when v_CmdtyDaily%NOTFOUND;
                --�����ʽ�����д�����ո�����ˮ
                if(v_FloatLoss <> 0) then
                    v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15016',v_FloatLoss,null,null,null,null);
                end if;
            end loop;
            close v_CmdtyDaily;
        elsif(v_LastFloatingLossComputeType = 3 or v_LastFloatingLossComputeType = 4) then  --������ӯ������ӯ��
            v_sql := 'select FirmID,-sum(FloatingLoss) from T_H_FirmHoldSum where ClearDate =(select max(ClearDate) from T_H_Market) group by FirmID ';
            open v_CmdtyDaily for v_sql;
            loop
                fetch v_CmdtyDaily into v_FirmID,v_FloatLoss;
                exit when v_CmdtyDaily%NOTFOUND;
                --�����ʽ�����д�����ո�����ˮ
                if(v_FloatLoss <> 0) then
                    v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15016',v_FloatLoss,null,null,null,null);
                end if;
            end loop;
            close v_CmdtyDaily;
        end if;
      end if;
      SP_T_ClearAction_Done(p_actionid => 7);




      -- �š��۳�������㸡��
      if(v_FloatingLossComputeType = 0) then     --��Ʒ������
          v_sql := 'select FirmID,CommodityID,sum(case when FloatingLoss>0 then 0 else -FloatingLoss end) from T_FirmHoldSum group by FirmID,CommodityID';
          open v_CmdtyDaily for v_sql;
          loop
              fetch v_CmdtyDaily into v_FirmID,v_CommodityID,v_FloatLoss;
              exit when v_CmdtyDaily%NOTFOUND;
              --�����ʽ�����д�۳����ո�����ˮ
              if(v_FloatLoss <> 0) then
                 v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15004',v_FloatLoss,null,v_CommodityID,null,null);
              end if;
          end loop;
          close v_CmdtyDaily;
      elsif(v_FloatingLossComputeType = 1) then  --��Ʒ��������
          v_sql := 'select FirmID,CommodityID,sum(FloatingLoss) from T_FirmHoldSum group by FirmID,CommodityID';
          open v_CmdtyDaily for v_sql;
          loop
              fetch v_CmdtyDaily into v_FirmID,v_CommodityID,v_FloatLoss;
              exit when v_CmdtyDaily%NOTFOUND;
              if(v_FloatLoss <= 0) then
                v_FloatLoss := -v_FloatLoss;
                --�����ʽ�����д�۳����ո�����ˮ
                if(v_FloatLoss <> 0) then
                    v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15004',v_FloatLoss,null,v_CommodityID,null,null);
                end if;
              end if;
          end loop;
          close v_CmdtyDaily;
      elsif(v_FloatingLossComputeType = 2) then  --������Ʒ
          v_sql := 'select FirmID,case when sum(FloatingLoss) >0 then 0 else -sum(FloatingLoss) end from T_FirmHoldSum group by FirmID ';
          open v_CmdtyDaily for v_sql;
          loop
              fetch v_CmdtyDaily into v_FirmID,v_FloatLoss;
              exit when v_CmdtyDaily%NOTFOUND;
              --�����ʽ�����д�۳����ո�����ˮ
              if(v_FloatLoss <> 0) then
                  v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15015',v_FloatLoss,null,null,null,null);
              end if;
          end loop;
          close v_CmdtyDaily;
      elsif(v_FloatingLossComputeType = 3 or v_FloatingLossComputeType = 4) then  --������ӯ������ӯ��
          v_sql := 'select FirmID,-sum(FloatingLoss) from T_FirmHoldSum group by FirmID ';
          open v_CmdtyDaily for v_sql;
          loop
              fetch v_CmdtyDaily into v_FirmID,v_FloatLoss;
              exit when v_CmdtyDaily%NOTFOUND;
              --�����ʽ�����д�۳����ո�����ˮ
              if(v_FloatLoss <> 0) then
                  v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15015',v_FloatLoss,null,null,null,null);
              end if;
          end loop;
          close v_CmdtyDaily;
      end if;
      SP_T_ClearAction_Done(p_actionid => 8);



      -- ʮ�����½������ʽ�
        --1�����������ʽ�Ϊ0,���ս����ʽ����Ϊ���ս����ʽ����յĽ��ձ�֤�����Ϊ���յ�
        update T_Firm set VirtualFunds=0,ClearMargin=RuntimeMargin,ClearAssure=RuntimeAssure,ClearFL=RuntimeFL,ClearSettleMargin=RuntimeSettleMargin;
        --2��ɾ����ʷ�������ݲ�������ʷ��������Ϣ��
        delete from T_H_Firm where ClearDate=v_TradeDate;
        insert into T_H_Firm select v_TradeDate,a.* from T_Firm a;
        --3�����µ�����ʷ�����̱��е����յ��ʽ�Ϊ��һ�����յĵ����ʽ�
        --������sum���(һ��������ֻ��һ����¼)���������ʱû�м�¼����
        update T_H_Firm a
          set (ClearFL,ClearMargin,ClearAssure,ClearSettleMargin) =
          (
            select nvl(sum(RuntimeFL),0),nvl(sum(RuntimeMargin),0),nvl(sum(RuntimeAssure),0),nvl(sum(RuntimeSettleMargin),0)
            from T_H_Firm
            where ClearDate =(select max(ClearDate) from T_H_Firm where ClearDate<v_TradeDate) and FirmID=a.FirmID
          )
        where a.ClearDate=v_TradeDate;
      SP_T_ClearAction_Done(p_actionid => 9);



      -- ʮһ��������ʷ����

        --������ʷ���ݲ�ɾ����������
        --1��������ʷί�б�ɾ����������
        insert into T_H_Orders select v_TradeDate,a.* from T_Orders a;
        delete from T_Orders;
        --2��������ʷ�ɽ���ɾ����������
        insert into T_H_Trade select v_TradeDate,a.* from T_Trade a;
        delete from T_Trade;
        --3��������ʷ�㲥��Ϣ��ɾ����������
        --insert into T_H_Broadcast select v_TradeDate,a.* from T_Broadcast a;
        --delete from T_Broadcast;

        --ɾ����ʷ�������ݲ����뵱����ʷ����
        --1��ɾ����ʷ�������ݲ�������ʷ�г�������
        delete from T_H_Market where ClearDate=v_TradeDate;
        insert into T_H_Market select v_TradeDate,a.* from T_A_Market a;
        --2��ɾ����ʷ�������ݲ�������ʷ����
        delete from T_H_Quotation where ClearDate=v_TradeDate;
        insert into T_H_Quotation select v_TradeDate,a.* from T_Quotation a;
        --3��ɾ����ʷ�������ݲ�������ʷ��Ʒ��
        delete from T_H_Commodity where ClearDate=v_TradeDate;
        insert into T_H_Commodity select v_TradeDate,a.* from T_Commodity a;
        --4��ɾ����ʷ�������ݲ�������ʷ�ֲ���ϸ��
        delete from T_H_HoldPosition where ClearDate=v_TradeDate;
        insert into T_H_HoldPosition select v_TradeDate,a.* from T_HoldPosition a;
        --5��ɾ����ʷ�������ݲ�������ʷ���׿ͻ��ֲֺϼƱ�
        delete from T_H_CustomerHoldSum where ClearDate=v_TradeDate;
        insert into T_H_CustomerHoldSum select v_TradeDate,a.* from T_CustomerHoldSum a;
        --6��ɾ����ʷ�������ݲ�������ʷ�����ֲֺ̳ϼƱ�
        delete from T_H_FirmHoldSum where ClearDate=v_TradeDate;
        insert into T_H_FirmHoldSum select v_TradeDate,a.* from T_FirmHoldSum a;
        --7��ɾ����ʷ�������ݲ�������ʷ���������Ᵽ֤���
        delete from T_H_FirmMargin where ClearDate=v_TradeDate;
        insert into T_H_FirmMargin select v_TradeDate,a.* from T_A_FirmMargin a;
        --8��ɾ����ʷ�������ݲ�������ʷ���������������ѱ�
        delete from T_H_FirmFee where ClearDate=v_TradeDate;
        insert into T_H_FirmFee select v_TradeDate,a.* from T_A_FirmFee a;
        SP_T_ClearAction_Done(p_actionid => 10);




      -- ʮ�����ͷŶ�������
      --1�����׿ͻ��ֲֺϼƱ���������0
      -- mod by yukx 201040028 Ϊ֧����ǰ���ն���ֲ�ע���±�sql
      --update T_CustomerHoldSum set FrozenQty=0;
      -- mod by yukx 201040028 ���׿ͻ��ֲֺϼƱ�Ķ��������͵ֶ������������ڲ�Ϊ0�ļ�¼ʱ����ϵͳ��־����Ӽ�¼
      open v_qtyAboutCustonerhold for select customerid,commodityid,bs_flag,frozenqty,gagefrozenqty from t_customerholdsum order by customerid,commodityid,bs_flag;
      loop
        fetch v_qtyAboutCustonerhold into  v_c_customerid,v_c_commodityid,v_c_bs_flag,v_c_frozenqty,v_c_gagefrozenqty;
        exit when v_qtyAboutCustonerhold%NOTFOUND;
        /*if(v_c_frozenqty+v_c_gagefrozenqty>0) then
             insert into T_SysLog(ID,UserID,Action,CreateTime,Note)
             values(SEQ_T_SYSLOG.Nextval,'SYSTEM','03',sysdate,'v_c_customerid='||v_c_customerid||',v_c_commodityid='||v_c_commodityid||',v_c_bs_flag='||v_c_bs_flag||',v_c_frozenqty='||v_c_frozenqty||',v_c_gagefrozenqty='||v_c_gagefrozenqty);
        end if;*/
      end loop;
      ---- add by tangzy 2010-06-21 ���׿ͻ��ֲֺϼƶ��������޸ģ�����0���ٸ�����ǰ��������ļ�¼�����¶�������
      update T_CustomerHoldSum t
        set FrozenQty = 0,
            gagefrozenqty = 0;
      -- �����򷽶�������
      /*update T_CustomerHoldSum t
         set FrozenQty = nvl((select sum(quantity)
                               from t_e_applyaheadsettle
                              where customerid_b = t.customerid
                                and commodityid = t.commodityid
                                and status = 1),0)
       where bs_flag = 1;*/
      -- ����������������
      /*update T_CustomerHoldSum t
         set FrozenQty = nvl((select sum(quantity) - sum(gageqty)
                               from t_e_applyaheadsettle
                              where customerid_s = t.customerid
                                and commodityid = t.commodityid
                                and status = 1),0),
            gagefrozenqty = nvl((select sum(gageqty)
                               from t_e_applyaheadsettle
                              where customerid_s = t.customerid
                                and commodityid = t.commodityid
                                and status = 1),0)
       where bs_flag = 2;*/

       --2����յ���ָ��ƽ�ֶ����
       delete from T_SpecFrozenHold;
       --3���ͷ����ж����ʽ�
       SP_F_UnFrozenAllFunds('15');

       SP_T_ClearAction_Done(p_actionid => 11);


      -- ʮ������Ӷ����(���÷�Ӷ�洢)

      v_ret := FN_BR_BrokerReward();

      SP_T_ClearAction_Done(p_actionid => 12);



      --ʮ�ġ����½��׿ͻ��ֲֺϼƱ�������
      open v_HoldFrozen for select customerid,commodityId,bs_flag,FrozenQTY from
        --��ǰ����
        (select th.customerid,th.commodityId commodityId,th.bs_flag bs_flag,sum(th.FrozenQTY)FrozenQTY from t_holdfrozen th,T_E_ApplyAheadSettle ta where ta.applyid = th.operation and th.frozentype = 0 and  ta.status=1
        group by th.customerid,th.commodityId,th.bs_flag)
        union all
        --Э�齻��
        (select th.customerid,th.commodityId commodityId,th.bs_flag bs_flag,sum(th.FrozenQTY)FrozenQTY from t_holdfrozen th,T_E_ApplyTreatySettle ta where ta.applyid = th.operation and th.frozentype = 1 and  ta.status=1
        group by th.customerid,th.commodityId,th.bs_flag)
        union all
        --�ǽ��׹���
        (select th.customerid,th.commodityId commodityId,th.bs_flag bs_flag,sum(th.FrozenQTY)FrozenQTY from t_holdfrozen th,T_UnTradeTransfer ta where ta.transferID = th.operation and th.frozentype = 2 and  ta.status=0
        group by th.customerid,th.commodityId,th.bs_flag)
        union all
        --�ֶ�
        (select th.customerid,th.commodityId commodityId,th.bs_flag bs_flag,sum(th.FrozenQTY)FrozenQTY from t_holdfrozen th,T_E_ApplyGage ta where ta.ApplyID = th.operation and th.frozentype = 3 and  ta.status=1 and ta.applytype=1
        group by th.customerid,th.commodityId,th.bs_flag);
      loop
          fetch v_HoldFrozen into v_customerid,v_CommodityID,v_bs_flag,v_frozenqty;
          exit when v_HoldFrozen%NOTFOUND;
               update t_customerholdsum  t set FrozenQty = FrozenQty + v_frozenqty where t.customerid = v_customerid and t.commodityid = v_CommodityID and t.bs_flag = v_bs_flag;
       end loop;
       close v_HoldFrozen;

      -- ʮ�塢�޸Ľ���ϵͳ״̬Ϊ���׽������
      update T_SystemStatus set TradeDate=v_TradeDate,Status=10,SectionID=null,Note=null,RecoverTime=null;
      SP_T_ClearAction_Done(p_actionid => 13);
    commit;
    return 1;
exception
    when others then
    v_errorcode:=sqlcode;
    v_errormsg :=sqlerrm;
    rollback;
    insert into T_DBLog(err_date,name_proc,err_code,err_msg)
    values(sysdate,'FN_T_CloseMarketProcess',v_errorcode,v_errormsg);
    -- �ָ�״̬Ϊδ����
        update t_systemstatus t
           set t.status = 7,
               t.note = '���׽���';
        commit;
    commit;
    return -100;
end;
/

prompt
prompt Creating function FN_T_COMPUTEORDERNO
prompt =====================================
prompt
create or replace function FN_T_ComputeOrderNo(
    p_OrderSeq number --ί��seq
) return number
/****
 * ����ί�е���
 * ����ֵ �ɹ�����ί�е���(yyMMdd+��Ź��ɣ���101122000001)
****/
as
	v_version varchar2(10):='1.0.4.3';
    v_TradeDate number(10) ;
    v_A_OrderNo number(15) ;
    v_No number(15) ;
begin
	select TradeDate,A_OrderNo into v_TradeDate,v_A_OrderNo from T_CurMinNo;
	v_No := p_OrderSeq-v_A_OrderNo;
    --return v_TradeDate * power(10,length(v_No)) + v_No;
	if (length(v_No) < 7) then
		return v_TradeDate * power(10,6) + v_No;
	else
		return v_TradeDate * power(10,length(v_No)) + v_No;
	end if;

end;
/

prompt
prompt Creating function FN_T_CLOSEORDER
prompt =================================
prompt
create or replace function FN_T_CloseOrder(
    p_FirmID     varchar2,   --������ID
    p_TraderID       varchar2,  --����ԱID
    p_CommodityID varchar2 default null,
    p_bs_flag        number default null,
    p_price          number default null,
    p_quantity       number default null,
    p_closeMode      number default null,
    p_specPrice      number default null,
    p_timeFlag       number default null,
    p_closeFlag      number default null,   --ƽ�ֱ�־
    p_CloseAlgr        number,    --ƽ���㷨(0�ȿ���ƽ��1����ƽ��2�ֲ־���ƽ��)��ָ��ƽ��ʱ�ᴫ�ݴ�ֵ����Ϊnull
    p_CustomerID     varchar2,  --���׿ͻ�ID
    p_ConsignerID       varchar2,  --ί��ԱID
    p_specialOrderFlag       number  --�Ƿ�����ί��(0������ί�� 1������ί��) ����ί��ֻ�ܺ�����ί�гɽ�
) return number
/****
 * ƽ��ί��
 * ����ֵ
 * >0  �ɹ��ύ��������ί�е���
 * -21  �ֲֲ���
 * -22  ָ���ֲ���
 * -99  �������������
 * -100 ��������
****/
as
    v_version varchar2(10):='1.0.2.2';
    v_HoldSum        number(10);   --�ֲֺϼ�
    v_SpecHoldSum    number(10);   --ָ���ֲֺϼ�
    v_SpecHoldFrozen    number(10);   --���ճֲֶ���
    v_A_OrderNo      number(15);   --ί�к�
    v_OrderType      number(2);    --ί������
    v_errorcode number;
    v_errormsg  varchar2(200);
    v_sql  varchar2(1000);
    v_str1  varchar2(100);
    v_str2  varchar2(500);
    v_orderby  varchar2(50);
    v_A_HoldNo       number(15);
    v_unCloseQty     number(10):=p_quantity; --δƽ�����������м����
    type c_HoldPosition is ref cursor;
    v_HoldPosition c_HoldPosition;
    v_TradeDate date;
begin
    --1���ж�������������ס�ֲֺϼƼ�¼
    begin
        select nvl(holdQty - frozenQty, 0) into v_HoldSum
        from T_CustomerHoldSum
        where CustomerID = p_CustomerID
          and CommodityID = p_CommodityID
          and bs_flag != p_bs_flag for update;
    exception
        when NO_DATA_FOUND then
            rollback;
            return -21;  --�ֲֲ���
    end;
    if(v_HoldSum < p_quantity) then
        rollback;
        return -21;  --�ֲֲ���
    end if;
    --ȡ��������
    select TradeDate into v_TradeDate from T_SystemStatus;
    --2���ж�ָ��ƽ������
    if(p_closeMode != 1) then
        if(p_closeMode = 2) then  --ָ��ʱ��ƽ��
            if(p_timeFlag = 1) then  --ƽ���
                --�ӳֲ���Ϣ���øÿͻ����ո���Ʒ�ֲֺϼ�
                v_str1 := ' and to_char(AtClearDate,''yyyy-MM-dd'')=''' || to_char(v_TradeDate,'yyyy-MM-dd') || ''' ';
            elsif(p_timeFlag = 2) then  --ƽ��ʷ��
                    --�ӳֲ���Ϣ���øÿͻ��ǵ��ո���Ʒ�ֲֺϼ�
                    v_str1 := ' and to_char(AtClearDate,''yyyy-MM-dd'')<>''' || to_char(v_TradeDate,'yyyy-MM-dd') || ''' ';
            else
                    rollback;
                    Raise_application_error(-20010, 'p_timeFlag ' || p_timeFlag || ' not exist!');
            end if;
        elsif(p_closeMode = 3) then  --ָ���۸�ƽ��
                    --�ӳֲ���Ϣ���øÿͻ��ü�λ����Ʒ�ֲֺϼ�
                    v_str1 := ' and Price =' || p_specPrice;
        else   --δ֪ƽ��
                    rollback;
                    Raise_application_error(-20011, 'p_closeMode ' || p_closeMode || ' not exist!');
        end if;
        v_str2 := ' and CustomerID=''' || p_CustomerID || ''' and CommodityID =''' || p_CommodityID || ''' and bs_flag != ' || p_bs_flag || ' ' || v_str1;
        v_sql := 'select nvl(sum(HoldQty),0)  from T_HoldPosition where 1=1 ' || v_str2;
        execute immediate v_sql into v_SpecHoldSum;

        v_sql := 'select nvl(sum(FrozenQty),0) from T_SpecFrozenHold where A_HoldNo in(select A_HoldNo  from T_HoldPosition where 1=1 ' || v_str2 || ')';
        execute immediate v_sql into v_SpecHoldFrozen;
        if(v_SpecHoldSum - v_SpecHoldFrozen < p_quantity) then
            rollback;
            return -22;  --ָ���ֲ���
        end if;
    end if;
    --3�����½��׿ͻ��ֲֺϼƵĶ�������
    update T_CustomerHoldSum set frozenQty = frozenQty + p_quantity
    where CustomerID = p_CustomerID
    and CommodityID = p_CommodityID
    and bs_flag != p_bs_flag;
    --4������ί�е��Ų�����ί�б�
	--���ü��㺯���޸�ί�е��� 2011-2-15 by feijl
    select FN_T_ComputeOrderNo(SEQ_T_Orders.nextval) into v_A_OrderNo from dual;
    insert into T_Orders
      ( a_orderno,  a_orderno_w,   CommodityID,   Firmid,    traderid,   bs_flag,   ordertype, status, quantity, price, closemode, specprice,       timeflag,tradeqty, frozenfunds, unfrozenfunds, ordertime, withdrawtime, ordererip, signature,closeFlag,   CustomerID,ConsignerID,specialOrderFlag)
    values
      (v_A_OrderNo,   null,        p_CommodityID, p_Firmid,  p_traderid, p_bs_flag,     2,        1,  p_quantity, p_price, p_closemode, p_specprice, p_timeflag, 0,        0,              0,         sysdate,      null,       null,     null,  p_closeFlag,p_CustomerID,p_ConsignerID,p_specialOrderFlag);
    --5��ָ��ƽ��ʱ����ֲֵ��ţ�ί�е��ţ�����
    if(p_closeMode != 1) then
        v_sql := 'select a.A_HoldNo,(a.HoldQty-nvl(b.FrozenQty,0)) from T_HoldPosition a,(select A_HoldNo,nvl(sum(FrozenQty),0) FrozenQty from T_SpecFrozenHold group by A_HoldNo) b where (a.HoldQty+a.GageQty) > 0 and a.A_HoldNo=b.A_HoldNo(+) and nvl(b.FrozenQty,0)<a.HoldQty ' || v_str2 || ' ' ;
        --����ƽ���㷨(0�ȿ���ƽ��1����ƽ��2�ֲ־���ƽ��(������)ѡ����������
        if(p_CloseAlgr = 0) then
            v_orderby := ' order by a.A_HoldNo ';
        elsif(p_CloseAlgr = 1) then
            v_orderby := ' order by a.A_HoldNo desc ';
        end if;
        v_sql := v_sql || v_orderby;
        open v_HoldPosition for v_sql;
        loop
            fetch v_HoldPosition into v_A_HoldNo, v_SpecHoldSum;
            exit when v_HoldPosition%NOTFOUND;
            if(v_SpecHoldSum <= v_unCloseQty) then
                v_SpecHoldFrozen := v_SpecHoldSum;
            else
                v_SpecHoldFrozen := v_unCloseQty;
            end if;
            insert into T_SpecFrozenHold(ID,    A_HoldNo,   A_OrderNo,  FrozenQty)
            values(SEQ_T_SpecFrozenHold.nextval,v_A_HoldNo,v_A_OrderNo,v_SpecHoldFrozen);
            v_unCloseQty := v_unCloseQty - v_SpecHoldFrozen;
            exit when v_unCloseQty=0;
        end loop;
        close v_HoldPosition;
    end if;
    commit;
    return v_A_OrderNo;
exception
    when NO_DATA_FOUND then
        rollback;
        return -99;  --�������������
    when others then
    v_errorcode:=sqlcode;
    v_errormsg :=sqlerrm;
    rollback;
    insert into T_DBLog(err_date,name_proc,err_code,err_msg)
    values(sysdate,'FN_T_CloseOrder',v_errorcode,v_errormsg);
    commit;
    return -100;
end;
/

prompt
prompt Creating function FN_T_COMPUTEFEEBYARGS
prompt =======================================
prompt
create or replace function FN_T_ComputeFeeByArgs(
    p_bs_flag        number,
    p_quantity       number,
    p_price          number,
    p_contractFactor        number,
    p_feeAlgr number,
    p_feeRate_b number,
    p_feeRate_s number
) return number
/****
 * ���ݲ�������������
 * ����ֵ �ɹ�����������;-1 ���㽻�׷����������ݲ�ȫ;-100 ��������
****/
as
	v_version varchar2(10):='1.0.0.1';
    v_fee             number(15,2) default 0;
begin
    if(p_feeAlgr=1) then  --Ӧ��������=����*��Լ����*�۸�*������
    	if(p_bs_flag = 1) then  --��
        	v_fee:=p_quantity*p_contractFactor*p_price*p_feeRate_b;
        elsif(p_bs_flag = 2) then  --��
        	v_fee:=p_quantity*p_contractFactor*p_price*p_feeRate_s;
        end if;
    elsif(p_feeAlgr=2) then  --Ӧ��������=����*������
    	if(p_bs_flag = 1) then  --��
        	v_fee:=p_quantity*p_feeRate_b;
        elsif(p_bs_flag = 2) then  --��
        	v_fee:=p_quantity*p_feeRate_s;
        end if;
    end if;
    if(v_fee is null) then
    	rollback;
        return -1;
    end if;
    return v_fee;
exception
    when no_data_found then
    	rollback;
        return -1;
    when others then
    	rollback;
   		return -100;
end;
/

prompt
prompt Creating function FN_T_COMPUTETRADENO
prompt =====================================
prompt
create or replace function FN_T_ComputeTradeNo(
    p_TradeSeq number --�ɽ�seq
) return number
/****
 * ����ɽ�����
 * ����ֵ �ɹ����سɽ�����(yyMMdd+��Ź��ɣ���101122000001)
****/
as
	v_version varchar2(10):='1.0.4.3';
    v_TradeDate number(10) ;
    v_A_TradeNo number(15) ;
    v_No number(15) ;
begin
	select TradeDate,A_TradeNo into v_TradeDate,v_A_TradeNo from T_CurMinNo;
	v_No := p_TradeSeq-v_A_TradeNo;
    --return v_TradeDate * power(10,length(v_No)) + v_No;
	if (length(v_No) < 7) then
		return v_TradeDate * power(10,6) + v_No;
	else
		return v_TradeDate * power(10,length(v_No)) + v_No;
	end if;

end;
/

prompt
prompt Creating function FN_T_CLOSETRADE
prompt =================================
prompt
create or replace function FN_T_CloseTrade(
    p_A_OrderNo     number,  --ί�е���
    p_M_TradeNo     number,  --��ϳɽ���
    p_Price         number,  --�ɽ���
    p_Quantity      number,   --�ɽ�����
    p_M_TradeNo_Opp     number,  --�Է���ϳɽ���
    p_CommodityID varchar2,
    p_FirmID     varchar2,
    p_TraderID       varchar2,
    p_bs_flag        number,
    p_status         number,
    p_orderQty       number,--ί������
    p_orderTradeQty       number,--ί���ѳɽ�����
    p_CustomerID        varchar2,
    p_OrderType      number,
    p_closeMode      number,
    p_specPrice      number,
    p_timeFlag       number,
    p_CloseFlag      number,
    p_contractFactor number,
    p_MarginPriceType         number,     --����ɽ���֤���������� 0:ʵʱ�ͱ���ʱ�������ּۣ�1:ʵʱ�������ۣ����а����ս����;2:���а������ۣ����н���ʱ�����ս����;
    p_marginAlgr         number,
    p_marginRate_b         number,
    p_marginRate_s         number,
    p_marginAssure_b         number,
    p_marginAssure_s         number,
    p_feeAlgr       number,
    p_feeRate_b         number,
    p_feeRate_s         number,
    p_TodayCloseFeeRate_B         number,
    p_TodayCloseFeeRate_S         number,
    p_HistoryCloseFeeRate_B         number,
    p_HistoryCloseFeeRate_S         number,
    p_ForceCloseFeeAlgr       number,
    p_ForceCloseFeeRate_B         number,
    p_ForceCloseFeeRate_S         number,
    p_YesterBalancePrice    number,
    p_AddedTaxFactor          number,  --��ֵ˰��ϵ��=AddedTax/(1+AddedTax)
    p_GageMode    number,
    p_CloseAlgr    number,
    p_TradeDate date,
    p_FirmID_opp     varchar2   --���ֽ�����ID
) return number
/****
 * ƽ�ֳɽ��ر�
 * 1��ע�ⲻҪ�ύcommit����Ϊ��ĺ���Ҫ��������
 * ����ֵ
 * 1 �ɹ�
 * -1 �ɽ���������δ�ɽ�����
 * -2 �ɽ��������ڶ�������
 * -3 ƽ�ֳɽ��������ڳֲ�����
 * -100 ��������
****/
as
    v_version varchar2(10):='1.0.2.2';
    v_price          number(15,2);
    v_frozenQty      number(10);
    v_holdQty        number(10);
    v_a_tradeno_closed number(15);
    v_Margin         number(15,2):=0;   --Ӧ�ձ�֤��
    v_Assure         number(15,2):=0;   --Ӧ�յ�����
    v_Fee            number(15,2):=0;   --Ӧ�շ���
    v_Fee_one            number(15,2);   --Ӧ�շ���
    v_A_TradeNo      number(15);
    v_A_HoldNo       number(15);
    v_id             number(15);
    v_tmp_bs_flag    number(2);
    v_TradeType      number(1);
    v_AtClearDate          date;
    v_HoldTime          date;
    v_MarginPrice    number(15,2);  --����ɽ���֤��ļ۸�
    v_HoldFunds    number(15,2):=0;  --ƽ��ʱӦ�˳ֲֽ��
    v_unCloseQty     number(10):=p_quantity; --δƽ�����������м����
    v_closeFL    number(15,2):=0;
    v_closeFL_one    number(15,2);   --����ƽ��ӯ���������м����
    v_CloseAddedTax_one    number(15,2);   --����ƽ����ֵ˰
    v_margin_one     number(15,2);   --�����м����
    v_Assure_one     number(15,2);   --�����м����
    v_tradedAmount   number(10):=0;  --�ɽ�����
    v_GageQty       number(10);
    v_GageQty_fsum       number(10);
    v_F_FrozenFunds   number(15,2);
    type c_T_HoldPosition is ref cursor;
    v_T_HoldPosition c_T_HoldPosition;
    v_sql varchar2(500);
    v_str  varchar2(200);
    v_orderby  varchar2(100);
    v_closeTodayHis        number(2);    --ƽ��ֻ�����ʷ��(0ƽ��֣�1ƽ��ʷ��)
    v_num            number(10);
    v_holddaysLimit number(1):=0;
begin
      if(p_TraderID is not null) then
          v_TradeType := 1;  --�н���ԱΪ�������ף�����ƽ�֣�
      else
        if(p_CloseFlag = 2) then
          v_TradeType := 3;  --����ԱΪ����ƽ�ֱ�־Ϊ2��ʾ�г�ǿƽ
        else
          v_TradeType := 4;  --�����н���Ա�ı�ʾί�н��ף�����ƽ�֣�
        end if;
      end if;

        if(p_bs_flag=1) then  --ί��ƽ�ֵ�������־
            v_tmp_bs_flag:=2; --�൱�ڱ�ƽ�ֵ�������־
        else
            v_tmp_bs_flag:=1;
        end if;
        select frozenqty
        into v_frozenQty
        from T_CustomerHoldSum
        where CustomerID = p_CustomerID
          and CommodityID = p_CommodityID
          and bs_flag = v_tmp_bs_flag for update;
        if(v_frozenqty <p_quantity) then
            rollback;
            return -2;
        end if;

    --ָ��ƽ�ֲ�ѯ����
        if(p_closeMode = 2) then  --ָ��ʱ��ƽ��
            if(p_timeFlag = 1) then  --ƽ���
                --�ӳֲ���ϸ���øý��׿ͻ����ո���Ʒ�ֲֺϼ�
                v_str := ' and to_char(AtClearDate,''yyyy-MM-dd'')=''' || to_char(p_TradeDate,'yyyy-MM-dd') || ''' ';
          elsif(p_timeFlag = 2) then  --ƽ��ʷ��
                  --�ӳֲ���ϸ���øý��׿ͻ��ǵ��ո���Ʒ�ֲֺϼ�
                  v_str := ' and to_char(AtClearDate,''yyyy-MM-dd'')<>''' || to_char(p_TradeDate,'yyyy-MM-dd') || ''' ';
          end if;
        elsif(p_closeMode = 3) then  --ָ���۸�ƽ��
            v_str := ' and Price =' || p_specPrice || ' ';
        end if;
        --����ƽ���㷨(0�ȿ���ƽ��1����ƽ��2�ֲ־���ƽ��(������)ѡ����������
    --2009-08-04����ǿƽʱ������ƽ˳��
    if(p_TraderID is null and p_CloseFlag = 2) then
      --v_orderby := ' order by a.A_HoldNo desc ';
             select holddayslimit into v_holddaysLimit from t_commodity where commodityid=p_CommodityID;
             if(v_holddaysLimit=0) then   --�޳ֲ���������
               v_orderby := ' order by a.A_HoldNo desc ';
             else
               v_orderby := ' order by a.A_HoldNo asc ';
             end if;
        else
          if(p_CloseAlgr = 0) then
            v_orderby := ' order by a.A_HoldNo ';
        elsif(p_CloseAlgr = 1) then
            v_orderby := ' order by a.A_HoldNo desc ';
        end if;
      end if;
      v_str := v_str || v_orderby;

          if(p_Quantity = p_orderQty - p_orderTradeQty) then
            --����ί��
            update T_Orders
            set tradeqty=tradeqty + p_Quantity,
                Status=3,UpdateTime=systimestamp(3)
            where A_orderNo = p_A_OrderNo;
          elsif(p_Quantity < p_orderQty - p_orderTradeQty) then
            --����ί��
      if(p_status = 6) then  --״̬Ϊ���ֳɽ��󳷵���������ֳɽ��ر��ڳ����ر�֮�󣬲����ٸ���״̬��
              update T_Orders
              set tradeqty=tradeqty + p_Quantity,UpdateTime=systimestamp(3)
              where A_orderNo = p_A_OrderNo;
      else
              update T_Orders
              set tradeqty=tradeqty + p_Quantity,Status=2,UpdateTime=systimestamp(3)
              where A_orderNo = p_A_OrderNo;
      end if;
          else
            rollback;
            return -1;
          end if;

            --��ָ��ƽ��ƽ�ֲּ�¼ʱ�Գֲ���ϸ��Ϊ������ָ��ƽ��ʱ�Ե���ָ��ƽ�ֶ����Ϊ��
            if(p_closeMode = 1) then --��ָ��ƽ��
              --�����ֲ���ϸ�����������˵�ָ��ƽ�ֶ��������,��ƽ��û�õ�b.ID����Ϊb��û������������0�滻
              v_sql := 'select a.a_holdno,a_tradeno,price,(a.HoldQty-nvl(b.FrozenQty,0)),GageQty,HoldTime,AtClearDate,nvl(b.FrozenQty,0),0 from T_holdposition a,(select A_HoldNo,nvl(sum(FrozenQty),0) FrozenQty from T_SpecFrozenHold group by A_HoldNo) b ' ||
                       ' where (a.HoldQty+a.GageQty) > 0 and a.A_HoldNo=b.A_HoldNo(+) and nvl(b.FrozenQty,0)<a.HoldQty and CustomerID=''' || p_CustomerID ||
                       ''' and CommodityID =''' || p_CommodityID || ''' and bs_flag = ' || v_tmp_bs_flag || v_str;
      else  --ָ��ƽ��
              v_sql := 'select a.a_holdno,a_tradeno,price,HoldQty,GageQty,HoldTime,AtClearDate,nvl(b.FrozenQty,0),b.ID from T_holdposition a,T_SpecFrozenHold b ' ||
                       ' where (a.HoldQty+a.GageQty) > 0 and b.A_HoldNo=a.A_HoldNo(+) and b.A_OrderNo= ' || p_A_OrderNo || v_str;
      end if;
            open v_T_HoldPosition for v_sql;
            loop
                fetch v_T_HoldPosition into v_a_holdno, v_a_tradeno_closed, v_price, v_holdqty,v_GageQty,v_HoldTime,v_AtClearDate,v_frozenQty,v_id;
                exit when v_T_HoldPosition%NOTFOUND;
                if(p_closeMode = 1) then --��ָ��ƽ��
                  if(v_holdqty<=v_unCloseQty) then
                      v_tradedAmount:=v_holdqty;
                  else
                      v_tradedAmount:=v_unCloseQty;
                  end if;
                else  --ָ��ƽ��
                  if(v_frozenQty<=v_unCloseQty) then
                      v_tradedAmount:=v_frozenQty;
                      delete from T_SpecFrozenHold where id=v_id;
                  else
                      v_tradedAmount:=v_unCloseQty;
                      update T_SpecFrozenHold set FrozenQty=FrozenQty-v_tradedAmount where id=v_id;
                  end if;
        end if;
        --�ж���ƽ��ֻ���ƽ��ʷ��
          if(trunc(p_TradeDate) = trunc(v_AtClearDate)) then
              v_closeTodayHis := 0;
          else
            v_closeTodayHis := 1;
          end if;
            --����ɽ���Ӧ�۳���������
        if(v_TradeType = 3) then  --ǿƽ
          v_Fee_one := FN_T_ComputeFeeByArgs(p_bs_flag,v_tradedAmount,p_Price,p_contractFactor,p_ForceCloseFeeAlgr,p_ForceCloseFeeRate_B,p_ForceCloseFeeRate_S);
        else  --���������ƽ���ǽ��쿪�Ĳ��򰴽񿪽�ƽ�����Ѽ���
          if(v_closeTodayHis = 0) then  --ƽ���
            v_Fee_one := FN_T_ComputeFeeByArgs(p_bs_flag,v_tradedAmount,p_Price,p_contractFactor,p_feeAlgr,p_TodayCloseFeeRate_B,p_TodayCloseFeeRate_S);
          else  --ƽ��ʷ��
                v_Fee_one := FN_T_ComputeFeeByArgs(p_bs_flag,v_tradedAmount,p_Price,p_contractFactor,p_feeAlgr,p_HistoryCloseFeeRate_B,p_HistoryCloseFeeRate_S);
            end if;
          end if;
                if(v_Fee_one < 0) then
                  Raise_application_error(-20030, 'computeFee error');
                end if;
                --����Ӧ�˱�֤�𣬸�������ѡ�񿪲ּۻ�������������
        if(p_MarginPriceType = 1) then
              v_MarginPrice := p_YesterBalancePrice;
          elsif(p_MarginPriceType = 2) then
          if(v_closeTodayHis = 0) then  --ƽ���
            v_MarginPrice := v_price;
          else  --ƽ��ʷ��
                v_MarginPrice := p_YesterBalancePrice;
            end if;
        else  -- default type is 0
          v_MarginPrice := v_price;
        end if;
                v_Margin_one := FN_T_ComputeMarginByArgs(v_tmp_bs_flag,v_tradedAmount,v_MarginPrice,p_contractFactor,p_marginAlgr,p_marginRate_b,p_marginRate_s);
                if(v_Margin_one < 0) then
                    Raise_application_error(-20040, 'computeMargin error');
                end if;
            --���㵣����
            v_Assure_one := FN_T_ComputeAssureByArgs(v_tmp_bs_flag,v_tradedAmount,v_MarginPrice,p_contractFactor,p_marginAlgr,p_marginAssure_b,p_marginAssure_s);
            if(v_Assure_one < 0) then
                Raise_application_error(-20040, 'computeAssure error');
            end if;
            --��֤��Ӧ���ϵ�����
            v_Margin_one := v_Margin_one + v_Assure_one;

              --����Ӧ�˳ֲֽ��
              v_HoldFunds := v_HoldFunds + v_tradedAmount*v_price*p_contractFactor;
                --����ƽ��ӯ��
                if(v_tmp_bs_flag=1) then  --v_tmp_bs_flag�ǳֲֵ�������־
                    v_closeFL_one := v_tradedAmount*(p_price-v_price)*p_contractFactor; --˰ǰӯ��
                else
                    v_closeFL_one := v_tradedAmount*(v_price-p_price)*p_contractFactor; --˰ǰӯ��
                end if;
              --����ƽ����ֵ˰,v_AddedTaxFactor��ֵ˰ϵ��=AddedTax/(1+AddedTax) xief 20150811
            --  v_CloseAddedTax_one := round(v_closeFL_one*p_AddedTaxFactor,2);
                v_CloseAddedTax_one := 0;
                v_closeFL_one := v_closeFL_one - v_CloseAddedTax_one; --˰��ӯ��
        --���ü��㺯���޸ĳɽ����� 2011-2-15 by feijl
                select FN_T_ComputeTradeNo(SEQ_T_Trade.nextval) into v_A_TradeNo from dual;
                 insert into T_Trade
                  (a_tradeno, m_tradeno, a_orderno, a_tradeno_closed,tradetime, Firmid, CommodityID, bs_flag, ordertype, price, quantity, close_pl, tradefee,TradeType,HoldPrice,HoldTime,CustomerID,CloseAddedTax,M_TradeNo_Opp,AtClearDate,TradeAtClearDate,oppFirmid)
                values
                  (v_A_TradeNo, p_M_TradeNo, p_A_OrderNo, v_a_tradeno_closed, sysdate, p_Firmid, p_CommodityID,p_bs_flag, p_ordertype, p_price, v_tradedAmount, v_closeFL_one, v_Fee_one,v_TradeType,v_price,v_HoldTime,p_CustomerID,v_CloseAddedTax_one,p_M_TradeNo_Opp,v_AtClearDate,p_TradeDate,p_FirmID_opp);

                --���³ֲּ�¼
                update T_holdposition
                set holdqty = holdqty - v_tradedAmount,HoldMargin=HoldMargin-v_Margin_one,HoldAssure=HoldAssure-v_Assure_one
                where a_holdno = v_a_holdno;
                v_unCloseQty:=v_unCloseQty - v_tradedAmount;

                v_Margin:=v_Margin + v_Margin_one;
                v_Assure:=v_Assure + v_Assure_one;
                v_Fee:=v_Fee + v_Fee_one;
                v_closeFL:=v_closeFL + v_closeFL_one;

                exit when v_unCloseQty=0;
            end loop;
            close v_T_HoldPosition;
            if(v_unCloseQty>0) then --�ɽ��������ڳֲ�����������
                rollback;
                return -3;
            end if;

        --���ٽ��׿ͻ��������̵ĳֲֺϼ���Ϣ2009-10-15
        v_num := FN_T_SubHoldSum(p_quantity,0,v_Margin,v_Assure,p_CommodityID,p_contractFactor,v_tmp_bs_flag,p_FirmID,v_HoldFunds,p_CustomerID,v_HoldFunds,p_GageMode,p_quantity);

        --������ʱ��֤�����ʱ������
        update T_Firm
        set runtimemargin = runtimemargin - v_Margin,
        RuntimeAssure = RuntimeAssure - v_Assure
        where Firmid = p_FirmID;
        --���¶����ʽ��ͷŸ��˲��ֵı�֤��
    v_F_FrozenFunds := FN_F_UpdateFrozenFunds(p_FirmID,-(v_Margin-v_Assure)+v_Fee-v_closeFL,'15');
    return 1;

end;
/

prompt
prompt Creating function FN_T_COMPUTEFLOATINGLOSS
prompt ==========================================
prompt
create or replace function FN_T_ComputeFloatingLoss(
    p_EvenPrice         number, --�ֲ־���
    p_Price         number, --�����
    p_HoldQty number, --�ֲ�����
    p_ContractFactor    number, --��Լ����
    p_BS_Flag number --������־
) return number
/****
 * ���㸡������
 * ����ֵ �ɹ����ظ�������
****/
as
	v_version varchar2(10):='1.0.0.1';
    v_FL_new number(15,2) default 0;
begin
    --���㸡��
    v_FL_new := (p_EvenPrice-p_Price)*p_HoldQty*p_ContractFactor;
    --�������������жϣ������Ӯʱ����Ϊ0
    if(p_BS_Flag = 1) then
        if(v_FL_new < 0) then
          v_FL_new := 0;
        end if;
    else
        if(v_FL_new > 0) then
          v_FL_new := 0;
        end if;
    end if;
    if(v_FL_new < 0) then
      v_FL_new := -v_FL_new;
    end if;
    return v_FL_new;
end;
/

prompt
prompt Creating function FN_T_COMPUTEFLOATINGPROFIT
prompt ============================================
prompt
create or replace function FN_T_ComputeFloatingProfit(
    p_EvenPrice         number, --�ֲ־���
    p_Price         number, --�����
    p_HoldQty number, --�ֲ�����
    p_ContractFactor    number, --��Լ����
    p_BS_Flag number --������־
) return number
/****
 * ���㸡��ӯ��
 * ����ֵ �ɹ����ظ���ӯ��
****/
as
	v_version varchar2(10):='1.0.0.1';
    v_FL_new number(15,2) default 0;
begin
    --���㸡��ӯ��
    if(p_BS_Flag = 1) then
      v_FL_new := (p_Price-p_EvenPrice)*p_HoldQty*p_ContractFactor;
    else
      v_FL_new := (p_EvenPrice-p_Price)*p_HoldQty*p_ContractFactor;
    end if;
    return v_FL_new;
end;
/

prompt
prompt Creating function FN_T_COMPUTEFORCECLOSEFEE
prompt ===========================================
prompt
create or replace function FN_T_ComputeForceCloseFee(
    p_FirmID     varchar2,
    p_CommodityID varchar2,
    p_bs_flag        number,
    p_quantity       number,
    p_price          number
) return number
/****
 * �����Ϊת��(��ǿƽ)������
 * ����ֵ �ɹ�����������;-1 ���㽻�׷����������ݲ�ȫ;-100 ��������
****/
as
	v_version varchar2(10):='1.0.0.1';
    v_feeRate_b         number(15,9);
    v_feeRate_s         number(15,9);
    v_feeAlgr       number(2);
    v_contractFactor  number(12,2);
    v_fee             number(15,2) default 0;
begin
    --��ȡ��Ʒ��Ϣ����Լ���ӣ�������ϵ�����������㷨��
    select ForceCloseFeeRate_B,ForceCloseFeeRate_S,ForceCloseFeeAlgr,contractfactor
    into v_feeRate_b,v_feeRate_s,v_feeAlgr,v_contractFactor
    from T_Commodity where CommodityID=p_CommodityID;

    begin
        --��ȡ�����̶�Ӧ�ײ�������ϵ�����������㷨
        select ForceCloseFeeRate_B,ForceCloseFeeRate_S,ForceCloseFeeAlgr
   		into v_feeRate_b,v_feeRate_s,v_feeAlgr
        from T_A_Tariff
        where TariffID=(select TariffID from t_firm where FirmID=p_FirmID) and CommodityID=p_CommodityID;
    exception
        when NO_DATA_FOUND then
            null;
    end;

    begin
        --��ȡ�ػ���������ϵ�����������㷨
        select ForceCloseFeeRate_B,ForceCloseFeeRate_S,ForceCloseFeeAlgr
   		into v_feeRate_b,v_feeRate_s,v_feeAlgr
        from T_A_FirmFee
        where FirmID=p_FirmID and CommodityID=p_CommodityID;
    exception
        when NO_DATA_FOUND then
            null;
    end;
    if(v_feeAlgr=1) then  --Ӧ��������=����*��Լ����*�۸�*������
    	if(p_bs_flag = 1) then  --��
        	v_fee:=p_quantity*v_contractFactor*p_price*v_feeRate_b;
        elsif(p_bs_flag = 2) then  --��
        	v_fee:=p_quantity*v_contractFactor*p_price*v_feeRate_s;
        end if;
    elsif(v_feeAlgr=2) then  --Ӧ��������=����*������
    	if(p_bs_flag = 1) then  --��
        	v_fee:=p_quantity*v_feeRate_b;
        elsif(p_bs_flag = 2) then  --��
        	v_fee:=p_quantity*v_feeRate_s;
        end if;
    end if;
    if(v_fee is null) then
    	rollback;
        return -1;
    end if;
    return v_fee;
exception
    when no_data_found then
    	rollback;
        return -1;
    when others then
    	rollback;
   		return -100;
end;
/

prompt
prompt Creating function FN_T_COMPUTEFORCECLOSEQTY
prompt ===========================================
prompt
create or replace function FN_T_ComputeForceCloseQty(
       p_firmid varchar2,
       p_commodityid varchar2,
       p_bs_flag number,--�ֲ���������
       p_quantity number,
       p_price number,
       p_forceCloseprice number
) return number
is
	v_version varchar2(10):='1.0.0.6';
  v_lastprice number(15,2) default 0;--�����
  v_contractfactor number(15,2) default 0;
  v_forceCloseprice number(15,2) default 0;--�ο�������Ӧһ�ֽ��
  v_forceClosePL number(15,2) default 0;--ƽ��ӯ��
  v_computemargin number(15,2) default 0;
  v_computefee number(15,2) default 0;
  v_computefloatingprofit number(15,2) default 0;
  v_addedtaxfactor number(15,6);

begin
    begin
       select price into v_lastprice from t_quotation where commodityID = p_commodityid;
    exception
        when NO_DATA_FOUND then
             return 0;
    end;
    begin
       select ContractFactor,addedtaxfactor into v_contractfactor,v_addedtaxfactor from t_commodity where commodityID = p_commodityid;
    exception
        when NO_DATA_FOUND then
             return 0;
    end;


  --ƽ��ӯ��  xief  20150811
  if (p_bs_flag = 1) then
       v_forceClosePL := (p_forceCloseprice - p_price)*v_contractfactor;
   --  v_forceClosePL := (p_forceCloseprice - p_price)*v_contractfactor*(1 - v_addedtaxfactor);
     --��֤��
     v_computemargin := FN_T_COMPUTEMARGIN(p_firmid,p_commodityid,1,p_quantity,v_lastprice);
     --������
     v_computefee := fn_t_computefee(p_firmid,p_commodityid,2,p_quantity,p_forceCloseprice);
     --����ӯ��
     v_computefloatingprofit := fn_t_computefloatingprofit(p_price,v_lastprice,p_quantity,v_contractfactor,1);
     if (v_computefloatingprofit > 0) then
        v_computefloatingprofit := 0;
     end if;
  else
    -- v_forceClosePL := (p_price - p_forceCloseprice)*v_contractfactor*(1 - v_addedtaxfactor);
     v_forceClosePL := (p_price - p_forceCloseprice)*v_contractfactor;
     --��֤��
     v_computemargin := FN_T_COMPUTEMARGIN(p_firmid,p_commodityid,2,p_quantity,v_lastprice);
     --������
     v_computefee := fn_t_computefee(p_firmid,p_commodityid,1,p_quantity,p_forceCloseprice);
     --����ӯ��
     v_computefloatingprofit := fn_t_computefloatingprofit(p_price,v_lastprice,p_quantity,v_contractfactor,2);
     if (v_computefloatingprofit > 0) then
        v_computefloatingprofit := 0;
     end if;
  end if;
  v_forceCloseprice := v_computemargin - v_computefee - v_computefloatingprofit + v_forceClosePL;
  return v_forceCloseprice;
end;
/

prompt
prompt Creating function FN_T_COMPUTEHISTORYCLOSEFEE
prompt =============================================
prompt
create or replace function FN_T_ComputeHistoryCloseFee(
    p_FirmID     varchar2,
    p_CommodityID varchar2,
    p_bs_flag        number,
    p_quantity       number,
    p_price          number
) return number
/****
 * ����ƽ��ʷ��������
 * ����ֵ �ɹ�����������;-1 ���㽻�׷����������ݲ�ȫ;-100 ��������
****/
as
	v_version varchar2(10):='1.0.0.1';
    v_feeRate_b         number(15,9);
    v_feeRate_s         number(15,9);
    v_feeAlgr       number(2);
    v_contractFactor  number(12,2);
    v_fee             number(15,2) default 0;
begin
    --��ȡ��Ʒ��Ϣ����Լ���ӣ�������ϵ�����������㷨��
    select HistoryCloseFeeRate_B,HistoryCloseFeeRate_S,feealgr,contractfactor
    into v_feeRate_b,v_feeRate_s,v_feeAlgr,v_contractFactor
    from T_Commodity where CommodityID=p_CommodityID;

    begin
        --��ȡ�����̶�Ӧ�ײ�������ϵ�����������㷨
        select HistoryCloseFeeRate_B,HistoryCloseFeeRate_S,feealgr
   		into v_feeRate_b,v_feeRate_s,v_feeAlgr
        from T_A_Tariff
        where TariffID=(select TariffID from t_firm where FirmID=p_FirmID) and CommodityID=p_CommodityID;
    exception
        when NO_DATA_FOUND then
            null;
    end;

    begin
        --��ȡ�ػ���������ϵ�����������㷨
        select HistoryCloseFeeRate_B,HistoryCloseFeeRate_S,feealgr
   		into v_feeRate_b,v_feeRate_s,v_feeAlgr
        from T_A_FirmFee
        where FirmID=p_FirmID and CommodityID=p_CommodityID;
    exception
        when NO_DATA_FOUND then
            null;
    end;
    if(v_feeAlgr=1) then  --Ӧ��������=����*��Լ����*�۸�*������
    	if(p_bs_flag = 1) then  --��
        	v_fee:=p_quantity*v_contractFactor*p_price*v_feeRate_b;
        elsif(p_bs_flag = 2) then  --��
        	v_fee:=p_quantity*v_contractFactor*p_price*v_feeRate_s;
        end if;
    elsif(v_feeAlgr=2) then  --Ӧ��������=����*������
    	if(p_bs_flag = 1) then  --��
        	v_fee:=p_quantity*v_feeRate_b;
        elsif(p_bs_flag = 2) then  --��
        	v_fee:=p_quantity*v_feeRate_s;
        end if;
    end if;
    if(v_fee is null) then
    	rollback;
        return -1;
    end if;
    return v_fee;
exception
    when no_data_found then
    	rollback;
        return -1;
    when others then
    	rollback;
   		return -100;
end;
/

prompt
prompt Creating function FN_T_COMPUTEHOLDNO
prompt ====================================
prompt
create or replace function FN_T_ComputeHoldNo(
    p_HoldSeq number --�ֲ�seq
) return number
/****
 * ����ֲֵ���
 * ����ֵ �ɹ����سֲֵ���(yyMMdd+��Ź��ɣ���101122000001)
****/
as
	v_version varchar2(10):='1.0.4.3';
    v_TradeDate number(10) ;
    v_A_HoldNo number(15) ;
    v_No number(15) ;
begin
	select TradeDate,A_HoldNo into v_TradeDate,v_A_HoldNo from T_CurMinNo;
	v_No := p_HoldSeq-v_A_HoldNo;
    --return v_TradeDate * power(10,length(v_No)) + v_No;
    if (length(v_No) < 7) then
		return v_TradeDate * power(10,6) + v_No;
	else
		return v_TradeDate * power(10,length(v_No)) + v_No;
	end if;
end;
/

prompt
prompt Creating function FN_T_COMPUTETODAYCLOSEFEE
prompt ===========================================
prompt
create or replace function FN_T_ComputeTodayCloseFee(
    p_FirmID     varchar2,
    p_CommodityID varchar2,
    p_bs_flag        number,
    p_quantity       number,
    p_price          number
) return number
/****
 * ����ƽ���������
 * ����ֵ �ɹ�����������;-1 ���㽻�׷����������ݲ�ȫ;-100 ��������
****/
as
	v_version varchar2(10):='1.0.0.1';
    v_feeRate_b         number(15,9);
    v_feeRate_s         number(15,9);
    v_feeAlgr       number(2);
    v_contractFactor  number(12,2);
    v_fee             number(15,2) default 0;
begin
    --��ȡ��Ʒ��Ϣ����Լ���ӣ�������ϵ�����������㷨��
    select TodayCloseFeeRate_B,TodayCloseFeeRate_S,feealgr,contractfactor
    into v_feeRate_b,v_feeRate_s,v_feeAlgr,v_contractFactor
    from T_Commodity where CommodityID=p_CommodityID;

    begin
        --��ȡ�����̶�Ӧ�ײ�������ϵ�����������㷨
        select TodayCloseFeeRate_B,TodayCloseFeeRate_S,feealgr
   		into v_feeRate_b,v_feeRate_s,v_feeAlgr
        from T_A_Tariff
        where TariffID=(select TariffID from t_firm where FirmID=p_FirmID) and CommodityID=p_CommodityID;
    exception
        when NO_DATA_FOUND then
            null;
    end;

    begin
        --��ȡ�ػ���������ϵ�����������㷨
        select TodayCloseFeeRate_B,TodayCloseFeeRate_S,feealgr
   		into v_feeRate_b,v_feeRate_s,v_feeAlgr
        from T_A_FirmFee
        where FirmID=p_FirmID and CommodityID=p_CommodityID;
    exception
        when NO_DATA_FOUND then
            null;
    end;
    if(v_feeAlgr=1) then  --Ӧ��������=����*��Լ����*�۸�*������
    	if(p_bs_flag = 1) then  --��
        	v_fee:=p_quantity*v_contractFactor*p_price*v_feeRate_b;
        elsif(p_bs_flag = 2) then  --��
        	v_fee:=p_quantity*v_contractFactor*p_price*v_feeRate_s;
        end if;
    elsif(v_feeAlgr=2) then  --Ӧ��������=����*������
    	if(p_bs_flag = 1) then  --��
        	v_fee:=p_quantity*v_feeRate_b;
        elsif(p_bs_flag = 2) then  --��
        	v_fee:=p_quantity*v_feeRate_s;
        end if;
    end if;
    if(v_fee is null) then
    	rollback;
        return -1;
    end if;
    return v_fee;
exception
    when no_data_found then
    	rollback;
        return -1;
    when others then
    	rollback;
   		return -100;
end;
/

prompt
prompt Creating function FN_T_CONFERCLOSEONE
prompt =====================================
prompt
create or replace function FN_T_ConferCloseOne(
    p_CommodityID    varchar2,   --��Ʒ����
    p_Price          number,     --ƽ�ּ�
    p_BS_Flag        number,     --������־
    p_CustomerID     varchar2,   --���׿ͻ�ID
    p_OppCustomerID  varchar2,   --�Է����׿ͻ�ID
    p_HoldQty        number,     --ƽ�ֲֳ����������ǵֶ�����
    p_GageQty        number default 0,   --ƽ�ֵֶ�������ҵ���ϲ�֧�֣����ҪЭ��ƽ�ֵֶ���Ҫ�����ֶ�ת��ǰ����
    p_M_TradeNo      number,     --��ϳɽ���
    p_M_TradeNo_Opp  number      --�Է���ϳɽ���
) return number
/****
 * ����������Э��ƽ��
 * 1��ע�ⲻҪ�ύcommit����Ϊ��ĺ���Ҫ��������
 * ����ֵ
 * 1 �ɹ�
 * -1  ��ƽ�ֲֳ���������
 * -2  ��ƽ�ֵֶ���������
 * -3  ƽ�ֲֳ��������ڿ�ƽ�ֲֳ�����
 * -4  ƽ�ֵֶ��������ڿɵֶ�����
 * -100 ��������
****/
as
    v_version        varchar2(10):='1.0.2.1';
    v_CommodityID    varchar2(16);
    v_CustomerID     varchar2(40);
    v_FirmID         varchar2(32);
    v_OppFirmid      varchar2(32);     --���ֽ����̴���
    v_HoldQty        number;
    v_HoldSumQty     number(10);
    v_frozenQty      number(10);
    v_Margin         number(15,2):=0;
    v_Margin_one     number(15,2):=0;
    v_closeFL        number(15,2):=0;
    v_closeFL_one    number(15,2):=0;    --һ����¼�Ľ���ӯ��
    v_Fee            number(15,2):=0;   --Ӧ�շ���
    v_Fee_one        number(15,2):=0;    --һ����¼�Ľ���������
    v_Assure         number(15,2):=0;
    v_Assure_one     number(15,2):=0;
    v_BS_Flag        number(2);
    v_Price          number(15,2);
    v_ContractFactor  number(12,2);
    v_MarginPriceType number(1);
    v_MarginPrice     number(15,2);  --����ɽ���֤��ļ۸�
    v_HoldFunds       number(15,2):=0;  --ƽ��ʱӦ�˳ֲֽ��������ֶ���
    v_CustomerHoldFunds    number(15,2):=0;  --ƽ��ʱӦ�˳ֲֽ������ֶ���
    v_TradeDate            date;
    v_A_HoldNo       number(15);
    v_A_TradeNo      number(15);
    v_a_tradeno_closed     number(15);
    v_AddedTaxFactor T_Commodity.AddedTaxFactor%type;--��ֵ˰��ϵ��=AddedTax/(1+AddedTax)
    v_GageQty        number(10);
          v_GageFrozenQty number(10);--add by zhaodc 20140804 �ֶ���������
    v_CloseAddedTax_one    number(15,2); --����ӯ����ֵ˰
    v_unCloseQty     number(10):=p_HoldQty; --δƽ�����������м����
    v_unCloseQtyGage       number(10):=p_GageQty; --δƽ�����������м����
    v_tradedAmount   number(10):=0;  --�ɽ�����
    v_tradedAmountGage     number(10):=0;  --�ɽ�����
    v_CloseAlgr      number(2);
    v_Balance        number(15,2);
    v_F_FrozenFunds  number(15,2);
    v_AtClearDate    date;
    v_HoldTime       date;
    v_tmp_bs_flag    number(2);
    type c_HoldPosition is ref cursor;
      v_HoldPosition c_HoldPosition;
    v_sql varchar2(500);
    v_orderby  varchar2(100);
    v_closeTodayHis         number(2);    --ƽ��ֻ�����ʷ��(0ƽ��֣�1ƽ��ʷ��)
    v_YesterBalancePrice    number(15,2);
    v_GageMode       number(2);--�ֶ�ģʽ����0ȫ�ֶ���1��ֶ�����ֶ�ʱҪ���㸡����2009-10-14
    v_num            number(10);
    v_TaxInclusive     number(1);   --��Ʒ�Ƿ�˰ 0��˰  1����˰   xiefei 20150730
begin
      v_CustomerID := p_CustomerID;
      v_CommodityID := p_CommodityID;
      v_BS_Flag := p_BS_Flag;

      --��ȡ���ֽ�����ID
      select firmid into v_OppFirmid from t_customer where customerid = p_OppCustomerID;

      if(v_BS_Flag=1) then  --�ֲֵ�������־
          v_tmp_bs_flag:=2; --�൱��ί��ƽ�ֵ�������־
      else
          v_tmp_bs_flag:=1;
      end if;
      --��ס���׿ͻ��ֲֺϼƣ��Է�ֹ��������
      begin
        select HoldQty,FrozenQty,GageQty,GageFrozenQty
        into v_HoldSumQty, v_frozenQty,v_GageQty,v_GageFrozenQty
        from T_CustomerHoldSum
        where CustomerID = v_CustomerID
          and CommodityID = v_CommodityID
          and bs_flag = v_BS_Flag for update;
      exception
          when NO_DATA_FOUND then
          return -15;--û���ҵ���Ӧ�ĳֲּ�¼
      end;

      /*--��ƽ�ֲֳ���������
      if(p_HoldQty > v_HoldSumQty-v_frozenQty) then
          rollback;
          return -1;
      end if;

      --��ƽ�ֵֶ���������
      if(p_GageQty > v_GageQty) then
          rollback;
          return -2;
      end if;*/

      --��ƽ�ֲֳ���������
      if(p_HoldQty > v_frozenQty) then
          rollback;
          return -1;
      end if;

      --��ƽ�ֵֶ���������
      if(p_GageQty > v_GageFrozenQty) then
          rollback;
          return -2;
      end if;

      --��ȡƽ���㷨,�ֶ�ģʽ
      select CloseAlgr,GageMode into v_CloseAlgr,v_GageMode from T_A_Market;

/*
   select Contractfactor,MarginPriceType,AddedTaxFactor,LastPrice
        into v_ContractFactor,v_MarginPriceType,v_AddedTaxFactor,v_YesterBalancePrice   xief 20150730*/

        ----�����Ƿ�˰
   select Contractfactor,MarginPriceType,AddedTaxFactor,LastPrice,TaxInclusive
        into v_ContractFactor,v_MarginPriceType,v_AddedTaxFactor,v_YesterBalancePrice,v_TaxInclusive

        from T_Commodity where CommodityID=v_CommodityID;
      select TradeDate into v_TradeDate from T_SystemStatus;

      --����ƽ���㷨(0�ȿ���ƽ��1����ƽ��2�ֲ־���ƽ��(������)ѡ����������
      if(v_CloseAlgr = 0) then
          v_orderby := ' order by a.A_HoldNo ';
      elsif(v_CloseAlgr = 1) then
          v_orderby := ' order by a.A_HoldNo desc ';
      end if;

      v_sql := 'select a.a_holdno,FirmID,price,(a.HoldQty-nvl(b.FrozenQty,0)),GageQty,HoldTime,AtClearDate,a_tradeno,nvl(b.FrozenQty,0) from T_holdposition a,(select A_HoldNo,nvl(sum(FrozenQty),0) FrozenQty from T_SpecFrozenHold group by A_HoldNo) b ' ||
                 ' where (a.HoldQty+a.GageQty) > 0 and a.A_HoldNo=b.A_HoldNo(+) and CustomerID=''' || v_CustomerID ||
                 ''' and CommodityID =''' || v_CommodityID || ''' and bs_flag = ' || v_BS_Flag || v_orderby;
      --�����ֲ���ϸ�����������˵�ָ��ƽ�ֶ��������
      open v_HoldPosition for v_sql;
          loop
              fetch v_HoldPosition into v_a_holdno, v_FirmID, v_price, v_holdqty,v_GageQty,v_HoldTime,v_AtClearDate,v_a_tradeno_closed,v_frozenQty;
                exit when v_HoldPosition%NOTFOUND;
                --����˱ʳֲ�ȫ����ָ��ƽ�ֶ�����û�еֶ���ָ����һ����¼
                if(v_holdqty <> 0 or v_GageQty <> 0) then
                    v_tradedAmount:=0;
                    v_tradedAmountGage:=0;
                    v_Margin_one:=0;
                    v_Assure_one:=0;
                    --�ж���ƽ��ֻ���ƽ��ʷ��
                    if(trunc(v_TradeDate) = trunc(v_AtClearDate)) then
                        v_closeTodayHis := 0;
                    else
                        v_closeTodayHis := 1;
                    end if;

                    --1������Ӧ�˿���
                    if(v_holdqty > 0) then
                        if(v_holdqty<=v_unCloseQty) then
                            v_tradedAmount:=v_holdqty;
                        else
                            v_tradedAmount:=v_unCloseQty;
                        end if;
                        --����Ӧ�˱�֤�𣬸�������ѡ�񿪲ּۻ�������������
                        if(v_MarginPriceType = 1) then
                            v_MarginPrice := v_YesterBalancePrice;
                        elsif(v_MarginPriceType = 2) then
                            --�ж���ƽ��ֻ���ƽ��ʷ��
                            if(v_closeTodayHis = 0) then  --ƽ���
                                v_MarginPrice := v_price;
                            else  --ƽ��ʷ��
                                v_MarginPrice := v_YesterBalancePrice;
                            end if;
                        else  -- default type is 0
                            v_MarginPrice := v_price;
                        end if;

                        v_Margin_one := FN_T_ComputeMargin(v_FirmID,v_CommodityID,v_BS_Flag,v_tradedAmount,v_MarginPrice);
                        if(v_Margin_one < 0) then
                            Raise_application_error(-20040, 'computeMargin error');
                        end if;
                        --���㵣����
                        v_Assure_one := FN_T_ComputeAssure(v_FirmID,v_CommodityID,v_BS_Flag,v_tradedAmount,v_MarginPrice);
                        if(v_Assure_one < 0) then
                            Raise_application_error(-20041, 'computeAssure error');
                        end if;
                        --��֤��Ӧ���ϵ�����
                        v_Margin_one := v_Margin_one + v_Assure_one;
                        v_Margin:=v_Margin + v_Margin_one;
                        v_Assure:=v_Assure + v_Assure_one;
                        --����Ӧ�˳ֲֽ��������ֶ���
                        v_HoldFunds := v_HoldFunds + v_tradedAmount*v_price*v_ContractFactor;
                    end if;

                    --2������ֲ���ϸ��ƽ�ֵĵֶ�����
                    if(v_GageQty > 0) then
                        if(v_GageQty<=v_unCloseQtyGage) then
                            v_tradedAmountGage:=v_GageQty;
                        else
                            v_tradedAmountGage:=v_unCloseQtyGage;
                        end if;
                    end if;
                    --����ǰ�ֶ�ģʽ�����ֲֽ̳��Ҫ�˵ֶ���
                    if(v_GageMode=1) then
                        v_HoldFunds := v_HoldFunds + v_tradedAmountGage*v_price*v_ContractFactor;
                    end if;
                    --�����ͻ��ϼƽ������ֶ���
                    v_CustomerHoldFunds := v_CustomerHoldFunds + (v_tradedAmount+v_tradedAmountGage)*v_price*v_ContractFactor;

                    --3������ƽ�ֿ���
                    --����ƽ��������
                    if(v_closeTodayHis = 0) then  --ƽ���
                        v_Fee_one := FN_T_ComputeTodayCloseFee(v_FirmID,v_CommodityID,v_tmp_bs_flag,v_tradedAmount+v_tradedAmountGage,p_Price);
                    else  --ƽ��ʷ��
                        v_Fee_one := FN_T_ComputeHistoryCloseFee(v_FirmID,v_CommodityID,v_tmp_bs_flag,v_tradedAmount+v_tradedAmountGage,p_Price);
                    end if;
                    if(v_Fee_one < 0) then
                        Raise_application_error(-20030, 'computeFee error');
                    end if;
                    --����˰ǰƽ��ӯ��
                    if(v_BS_Flag = 1) then
                        v_closeFL_one := (v_tradedAmount+v_tradedAmountGage)*(p_Price-v_price)*v_contractFactor; --˰ǰӯ��
                    else
                        v_closeFL_one := (v_tradedAmount+v_tradedAmountGage)*(v_price-p_Price)*v_contractFactor; --˰ǰӯ��
                    end if;

                   --����ƽ����ֵ˰,v_AddedTaxFactor��ֵ˰ϵ��=AddedTax/(1+AddedTax)  xief 20158011
                   -- v_CloseAddedTax_one := round(v_closeFL_one*v_AddedTaxFactor,2);
                      v_CloseAddedTax_one := 0;


                   --����˰���ƽ��ӯ�� xief 20150730   xief 20150811
                 /*   if(v_TaxInclusive=1) then
                           --����˰ �۳���ֵ˰
                           v_closeFL_one := v_closeFL_one - v_CloseAddedTax_one; --˰��ӯ��
                    end if;
                   */
                   /* --����˰��ƽ��ӯ��
                    v_closeFL_one := v_closeFL_one - v_CloseAddedTax_one; --˰��ӯ��  xief   20150730*/

                    --���ü��㺯���޸ĳɽ����� 2011-2-15 by feijl
                    select FN_T_ComputeTradeNo(SEQ_T_Trade.nextval) into v_A_TradeNo from dual;
                    insert into T_Trade
                      (a_tradeno, m_tradeno, a_orderno, a_tradeno_closed,tradetime, Firmid, CommodityID,         bs_flag,       ordertype, price, quantity,                             close_pl,     tradefee,TradeType,HoldPrice,HoldTime,CustomerID,CloseAddedTax,M_TradeNo_Opp,AtClearDate,TradeAtClearDate,OppFirmID)
                    values
                      (v_A_TradeNo,p_M_TradeNo, null, v_a_tradeno_closed, sysdate, v_Firmid, v_CommodityID,v_tmp_bs_flag, 2,    p_Price, v_tradedAmount+v_tradedAmountGage, v_closeFL_one,v_Fee_one,    6,     v_price,v_HoldTime,v_CustomerID,v_CloseAddedTax_one,p_M_TradeNo_Opp,v_AtClearDate,v_TradeDate,v_OppFirmid);

                    --���³ֲּ�¼
                    update T_holdposition
                    set holdqty = holdqty - v_tradedAmount,HoldMargin=HoldMargin-v_Margin_one,HoldAssure=HoldAssure-v_Assure_one,GageQty = GageQty - v_tradedAmountGage
                    where a_holdno = v_a_holdno;

                    v_unCloseQty:=v_unCloseQty - v_tradedAmount;
                    v_unCloseQtyGage:=v_unCloseQtyGage - v_tradedAmountGage;

                    v_Fee:=v_Fee + v_Fee_one;
                     v_closeFL:=v_closeFL + v_closeFL_one;

                  exit when v_unCloseQty=0 and v_unCloseQtyGage=0;
                end if;
            end loop;
            close v_HoldPosition;
            if(v_unCloseQty>0) then --ƽ�ֲֳ��������ڿ�ƽ�ֲֳ�����
                rollback;
                return -3;
            end if;
            if(v_unCloseQtyGage>0) then --ƽ�ֵֶ��������ڿɵֶ�����
                rollback;
                return -4;
            end if;

            --���ٽ��׿ͻ��������̵ĳֲֺϼ���Ϣ2009-10-15
            v_num := FN_T_SubHoldSum(p_HoldQty,p_GageQty,v_Margin,v_Assure,v_CommodityID,v_ContractFactor,v_BS_Flag,v_FirmID,v_HoldFunds,v_CustomerID,v_CustomerHoldFunds,v_GageMode,p_HoldQty);

            --������ʱ��֤�����ʱ������
            update T_Firm
               set runtimemargin = runtimemargin - v_Margin,
                   RuntimeAssure = RuntimeAssure - v_Assure
             where Firmid = v_FirmID;
            --���¶����ʽ��ͷŸ��˲��ֵı�֤��
            v_F_FrozenFunds := FN_F_UpdateFrozenFunds(v_FirmID,-(v_Margin-v_Assure)+v_Fee-v_closeFL,'15');
    return 1;

end;
/

prompt
prompt Creating function FN_T_CONFERCLOSE
prompt ==================================
prompt
create or replace function FN_T_ConferClose(
    p_CommodityID varchar2,   --��Ʒ����
 	  p_Price         number,  --ƽ�ּ�
    p_bCustomerID    varchar2,     --���׿ͻ�ID
    p_bHoldQty      number,   --��ƽ�ֲֳ����������ǵֶ�����
 	  p_bGageQty      number,   --��ƽ�ֵֶ�����
    p_sCustomerID    varchar2,     --�����׿ͻ�ID
    p_sHoldQty      number,   --��ƽ�ֲֳ����������ǵֶ�����
 	  p_sGageQty      number   --��ƽ�ֵֶ�����
) return number
/****
 * Э��ƽ��
 * ����ֵ
 * 1 �ɹ�
 * -1  ��ƽ����ֲ���������
 * -2  ��ƽ����ֶ���������
 * -3  ƽ����ֲ��������ڿ�ƽ����ֲ�����
 * -4  ƽ����ֶ��������ڿ���ֶ�����
 * -11  ��ƽ�����ֲ���������
 * -12  ��ƽ�����ֶ���������
 * -13  ƽ�����ֲ��������ڿ�ƽ�����ֲ�����
 * -14  ƽ�����ֶ��������ڿ����ֶ�����
 * -100 ��������
****/
as
 	  v_version varchar2(10):='1.0.0.1';
    bRet            number(5);
    sRet            number(5);
    v_FL_ret            timestamp;
    v_sFirmID varchar2(32);      --����������ID
	  v_bFirmID varchar2(32);      --�򷽽�����ID
    bM_TradeNo            number(15);
    sM_TradeNo            number(15);
    v_errorcode      number;
    v_errormsg       varchar2(200);
begin
	  select nvl(max(M_TradeNo),0)+1 into bM_TradeNo from T_Trade;
	  sM_TradeNo := bM_TradeNo + 1;
    bRet := FN_T_ConferCloseOne(p_CommodityID,p_Price,1,p_bCustomerID,p_sCustomerID,p_bHoldQty,p_bGageQty,bM_TradeNo,sM_TradeNo);--��
    if(bRet = 1) then
    	  sRet := FN_T_ConferCloseOne(p_CommodityID,p_Price,2,p_sCustomerID,p_bCustomerID,p_sHoldQty,p_sGageQty,sM_TradeNo,bM_TradeNo); --��
  		  if(sRet = 1) then
   			    commit;
   			    --�ύ���������˫������
   			    v_FL_ret := FN_T_UpdateFloatingLoss(null,null,null);
      		  return 1;
     	  elsif(sRet = -1) then
      		  rollback;
   			    return -11;
  		  elsif(sRet = -2) then
      		  rollback;
   			    return -12;
  		  elsif(sRet = -3) then
      		  rollback;
   			    return -13;
  		  elsif(sRet = -4) then
      		  rollback;
   			    return -14;
  		  else
      		  rollback;
   			    return -100;
  		  end if;
 	  else
 	      rollback;
  		  return bRet;
 	  end if;
exception
    when OTHERS then
    v_errorcode:=sqlcode;
    v_errormsg :=sqlerrm;
    rollback;
    insert into T_DBLog(err_date,name_proc,err_code,err_msg)
    values(sysdate,'FN_T_ConferClose',v_errorcode,v_errormsg);
    commit;
    return -100;
end;
/

prompt
prompt Creating function FN_T_CONFERCLOSEAUDIT
prompt =======================================
prompt
create or replace function FN_T_ConferCloseAudit(
    p_ID            varchar2,       --Э�齻��ID
    p_CommodityID   varchar2,       --��Ʒ����
    p_bCustomerID   varchar2,       --�򷽽��׿ͻ�ID
    p_sCustomerID   varchar2,       --�������׿ͻ�ID
    p_price         number,         --�۸�
    p_quantity      number          --����
) return number
/****
 * Э�齻�����
 * ����ֵ
 * 1 �ɹ�
 * -1  ��ƽ����ֲ���������
 * -3  ƽ����ֲ��������ڿ�ƽ����ֲ�����
 * -11  ��ƽ�����ֲ���������
 * -13  ƽ�����ֲ��������ڿ�ƽ�����ֲ�����
 * -21  �ⶳ�ֲ�ʧ��
 * -100 ��������
****/
as
     v_ret          number(5):=0;
begin
     --�ⶳ�ֲֺϼƱ�ֲ�
     --1.�ͻ��ֲֺϼƱ�(��)
     --update t_customerholdsum set frozenQty=frozenQty-p_quantity where commodityid = p_CommodityID and customerid = p_bCustomerID and bs_flag = 1;
     --2.�ͻ��ֲֺϼƱ�(����)
     --update t_customerholdsum set frozenQty=frozenQty-p_quantity where commodityid = p_CommodityID and customerid = p_sCustomerID and bs_flag = 2;
     --�ⶳ�ֲֶ����
     delete T_Holdfrozen where Operation = p_ID and frozentype = 1;
     --�޸����״̬
     update T_E_ApplyTreatySettle set Status = 2,modifytime = sysdate where ApplyID = p_ID;

     v_ret := FN_T_ConferClose(p_CommodityID,p_price,p_bCustomerID,p_quantity,0,p_sCustomerID,p_quantity,0);
     return v_ret;
exception
    when OTHERS then
    rollback;
    return -21;
end;
/

prompt
prompt Creating function FN_T_CREATEAPPLY
prompt ==================================
prompt
create or replace function FN_T_CREATEAPPLY(p_clob varchar2, p_applytype number, p_status number, p_proposer varchar2) return number
as
   v_xml_id NUMBER(12);
   v_apply_id NUMBER(10);
begin
   /* ����xml�ı�id*/
   select nvl(max(id),0)+1 into v_xml_id from c_xmltemplate;
   /* ���������ɵ�id���������*/
   insert into c_xmltemplate values(v_xml_id, to_clob(p_clob));
   /* ���������¼��id*/
   select nvl(max(id),0)+1 into v_apply_id from t_apply;
   /* ���������ɵ�id���������*/
   insert into t_apply (id,applyType,status,proposer,applytime,content) values (v_apply_id,p_applytype,p_status,p_proposer,sysdate,sys.xmlType.createXML((select clob from c_xmltemplate where id=v_xml_id)));
   /* ɾ��xml����*/
   delete from c_xmltemplate where id=v_xml_id;
   return v_apply_id;
end;
/

prompt
prompt Creating function FN_T_DEDUCTDATA
prompt =================================
prompt
create or replace function FN_T_DeductData
 (
    p_deductID number  --ǿ��ID
 )
return number     --���� 1 �ɹ� -1:ֻ�ܱ��в���״̬ǿ���� -2��û�з���������ӯ����
/**
 * ����ǿ������
 *
 **/
as
    v_systemstatus number(2);
    v_deductDate date;  --ǿ������
    v_cmdtyCode varchar2(16);  --ǿ������Ʒ����
    v_factor number;
    v_b_price number(15,2); --�����
    v_deductPrice number;
    v_loserBSflag number(1);
    v_loserSign number(1);

    v_loserMode number;
    v_lossRate number;
    v_selfCounteract char(1);
    v_profitLvl1 number;
    v_profitLvl2 number;
    v_profitLvl3 number;
    v_profitLvl4 number;
    v_profitLvl5 number;
    v_profitQty1 number;
    v_profitQty2 number;
    v_profitQty3 number;
    v_profitQty4 number;
    v_profitQty5 number;
    v_lossqty number(10);
    v_loserPct number;
    v_winerPct number;

    v_diff number(10);

    v_customerId varchar2(40);

    --������Ŀͻ�
    cursor c_deductRound is
    select customerid from T_E_DeductDetail
    where deductID=p_deductID and estimateQty-deductQty>0
    order by (estimateQty-deductQty) desc ,PL_ratio desc;

    v_errorcode      number;
    v_errormsg       varchar2(200);
begin
    select status into v_systemstatus from t_systemstatus;
    if(v_systemstatus<>1) then --ֻ�ܱ��в���״̬ǿ��
        return -1;
    end if;

    --����������
    delete from T_E_DeductDetail where deductID=p_deductID;

    --���ǿ������
    select deductDate,commodityid,deductprice,loserBSflag,decode(loserBSflag,2,-1,1),losermode, -lossrate, selfcounteract, profitlvl1, profitlvl2, profitlvl3, profitlvl4, profitlvl5
    into v_deductDate,v_cmdtyCode,v_deductPrice,v_loserBSflag,v_loserSign,v_losermode, v_lossrate, v_selfcounteract, v_profitlvl1, v_profitlvl2, v_profitlvl3, v_profitlvl4, v_profitlvl5
    from T_E_DeductPosition where deductID=p_deductID;

    select contractfactor into v_factor from t_commodity t where t.commodityid=v_cmdtyCode;
    --�õ�����ۣ����������ӯ����
    select decode(qt.price,0,qt.yesterbalanceprice,qt.price) into v_b_price from t_quotation qt where qt.commodityid=v_cmdtyCode;

    --������׿ͻ�ӯ��
    insert into T_E_DeductDetail(deductID,Customerid,Buyqty,Sellqty,Pureholdqty,Pl,Pl_Ratio,WL,buykeepqty,Sellkeepqty,counteractqty,Orderqty,deductableqty,Estimateqty,deductqty,Deductedqty,Counteractedqty)
    select p_deductID,customerid,buyqty,sellqty,pureholdqty,pl,decode(pureholdqty,0,0,pl/(abs(pureholdqty)*v_factor)/v_b_price) pl_ratio,
        decode(sign(pureholdqty),v_loserSign,'L','W'),0,0,0,0,0,0,0,0,0 from
       (
         select a.customerid,sum(decode(a.bs_flag,2,-1,1)*a.holdqty) pureholdqty,sum(decode(a.bs_flag,1,a.holdqty,0)) buyqty,
           sum(decode(a.bs_flag,2,a.holdqty,0)) sellqty,sum(decode(a.bs_flag,1,(a.holdqty*v_b_price*v_factor-(a.holdfunds-a.GageQty*a.EvenPrice*v_factor)),((a.holdfunds-a.GageQty*a.EvenPrice*v_factor)-a.holdqty*v_b_price*v_factor))) pl
         from T_CustomerHoldSum a
         where commodityid=v_cmdtyCode group by a.customerid
       );

    --��������
    update T_E_DeductDetail t set t.buykeepqty=
        nvl((
          select sum(df.keepqty) from T_E_DeductKeep df
          where deductID=p_deductID and df.bs_flag=1 and df.customerid=t.customerid
        ),0),
        t.sellkeepqty=
        nvl((
          select sum(df.keepqty) from T_E_DeductKeep df
          where deductID=p_deductID and df.bs_flag=2 and df.customerid=t.customerid
        ),0)
    where deductID=p_deductID ;
    ----------��ȫ������ͻ�ǿ��
    if(v_losermode=1) then
        --��������׿ͻ���ǿ������
        if(v_loserBSflag=1) then
          --����-�����������ֲ���   ȡ��С����Ϊ����ǿ����
          update T_E_DeductDetail t set t.deductableqty=least(buyqty-buykeepqty,PureHoldQty)
          where deductID=p_deductID and wl='L' and pl_ratio<=v_lossrate;
          --����-�������������ֲ���   ȡ��С����Ϊ����ǿ����
          update T_E_DeductDetail t set t.deductableqty=least(sellqty-sellkeepqty,-PureHoldQty)
          where deductID=p_deductID and wl='W' and pl_ratio>=v_profitlvl5;
        else
          --����-�������������ֲ���   ȡ��С����Ϊ����ǿ����
          update T_E_DeductDetail t set t.deductableqty=least(sellqty-sellkeepqty,-PureHoldQty)
          where deductID=p_deductID and wl='L' and pl_ratio<=v_lossrate;
          --����-�����������ֲ���   ȡ��С����Ϊ����ǿ����
          update T_E_DeductDetail t set t.deductableqty=least(buyqty-buykeepqty,PureHoldQty)
          where deductID=p_deductID and wl='W' and pl_ratio>=v_profitlvl5;
        end if;
    end if;
    ---------��ƽ��ί��ǿ��
    if(v_losermode=2) then
        --�ó��ͻ���ƽ��ί������
        update T_E_DeductDetail t set t.orderqty=
          nvl((select sum(quantity-tradeqty) from T_orders o
           where trunc(o.ordertime)=v_deductDate
           and o.commodityid=v_cmdtyCode and o.customerid=t.customerid and WithdrawType=4
           and o.bs_flag=decode(v_loserBSflag,1,2,1) and o.ordertype=2 and price=v_deductPrice),0)
         /* add by yukx 20100514 */
           -nvl((
              select sum(d.orderqty) from T_E_DeductDetail d,T_E_DeductPosition p
              where d.deductid=p.deductid and p.deductid<> p_deductID and d.customerid=t.customerid and p.deductstatus='Y'
               and p.commodityid=v_cmdtyCode and p.deductprice=v_deductPrice and p.loserbsflag=v_loserBSflag
               and p.deductdate=(select TradeDate from T_SystemStatus)),0)
        where deductID=p_deductID ;

        --��������׿ͻ���ǿ������
        if(v_loserBSflag=1) then
            --����-��������ί���������ֲ���   ȡ��С����Ϊ����ǿ����
            update T_E_DeductDetail t set t.deductableqty=least(buyqty-buykeepqty,orderqty,PureHoldQty)
            where deductID=p_deductID and wl='L' and pl_ratio<=v_lossrate;
            --����-�������������ֲ���   ȡ��С����Ϊ����ǿ����
            update T_E_DeductDetail t set t.deductableqty=least(sellqty-sellkeepqty,-PureHoldQty)
            where deductID=p_deductID and wl='W' and pl_ratio>=v_profitlvl5;
        else
            --����-����������ί���������ֲ���   ȡ��С����Ϊ����ǿ����
            update T_E_DeductDetail t set t.deductableqty=least(sellqty-sellkeepqty,orderqty,-PureHoldQty)
            where deductID=p_deductID and wl='L' and pl_ratio<=v_lossrate;
            --����-�����������ֲ���   ȡ��С����Ϊ����ǿ����
            update T_E_DeductDetail t set t.deductableqty=least(buyqty-buykeepqty,PureHoldQty)
            where deductID=p_deductID and wl='W' and pl_ratio>=v_profitlvl5;
        end if;
    end if;
    --���𷽿�ǿ��������
    select sum(deductableqty) into v_lossqty from T_E_DeductDetail d
    where deductID=p_deductID and wl='L' and pl_ratio<=v_lossrate;
    --ӯ��������������
    select sum(deductableqty) into v_profitqty1 from T_E_DeductDetail
    where pl_ratio>=v_profitlvl1 and deductID=p_deductID and wl='W';
    select sum(deductableqty) into v_profitqty2 from T_E_DeductDetail
    where pl_ratio>=v_profitlvl2 and pl_ratio<v_profitlvl1 and deductID=p_deductID and wl='W';
    select sum(deductableqty) into v_profitqty3 from T_E_DeductDetail
    where pl_ratio>=v_profitlvl3 and pl_ratio<v_profitlvl2 and deductID=p_deductID and wl='W';
    select sum(deductableqty) into v_profitqty4 from T_E_DeductDetail
    where pl_ratio>=v_profitlvl4 and pl_ratio<v_profitlvl3 and deductID=p_deductID and wl='W';
    select sum(deductableqty) into v_profitqty5 from T_E_DeductDetail
    where pl_ratio>=v_profitlvl5 and pl_ratio<v_profitlvl4 and deductID=p_deductID and wl='W';
    v_profitqty1:=nvl(v_profitqty1,0);
    v_profitqty2:=nvl(v_profitqty2,0);
    v_profitqty3:=nvl(v_profitqty3,0);
    v_profitqty4:=nvl(v_profitqty4,0);
    v_profitqty5:=nvl(v_profitqty5,0);
    if(v_profitqty1+v_profitqty2+v_profitqty3+v_profitqty4+v_profitqty5 = 0)then
        return -2; --û�з���������ӯ����
    end if;

    --�������ǿ������
    if(v_lossqty>v_profitqty1+v_profitqty2+v_profitqty3+v_profitqty4+v_profitqty5) then
        v_loserPct := (v_profitqty1+v_profitqty2+v_profitqty3+v_profitqty4+v_profitqty5)/v_lossqty;
        v_winerPct := 1;
        update T_E_DeductDetail set EstimateQty=deductableqty
        where pl_ratio>=v_profitlvl5 and deductID=p_deductID and wl='W';
    elsif(v_lossqty>v_profitqty1+v_profitqty2+v_profitqty3+v_profitqty4) then
        v_loserPct := 1;
        v_winerPct := (v_lossqty-(v_profitqty1+v_profitqty2+v_profitqty3+v_profitqty4))/v_profitqty5;
        update T_E_DeductDetail set EstimateQty=deductableqty
        where pl_ratio>=v_profitlvl4 and deductID=p_deductID and wl='W';
        update T_E_DeductDetail set EstimateQty=deductableqty*v_winerPct
        where pl_ratio>=v_profitlvl5 and pl_ratio<v_profitlvl4 and deductID=p_deductID and wl='W';
    elsif(v_lossqty>v_profitqty1+v_profitqty2+v_profitqty3) then
        v_loserPct := 1;
        v_winerPct := (v_lossqty-(v_profitqty1+v_profitqty2+v_profitqty3))/v_profitqty4;
        update T_E_DeductDetail set EstimateQty=deductableqty
        where pl_ratio>=v_profitlvl3 and deductID=p_deductID and wl='W';
        update T_E_DeductDetail set EstimateQty=deductableqty*v_winerPct
        where pl_ratio>=v_profitlvl4 and pl_ratio<v_profitlvl3 and deductID=p_deductID and wl='W';
    elsif(v_lossqty>v_profitqty1+v_profitqty2) then
        v_loserPct := 1;
        v_winerPct := (v_lossqty-(v_profitqty1+v_profitqty2))/v_profitqty3;
        update T_E_DeductDetail set EstimateQty=deductableqty
        where pl_ratio>=v_profitlvl2 and deductID=p_deductID and wl='W';
        update T_E_DeductDetail set EstimateQty=deductableqty*v_winerPct
        where pl_ratio>=v_profitlvl3 and pl_ratio<v_profitlvl2 and deductID=p_deductID and wl='W';
    elsif(v_lossqty>v_profitqty1) then
        v_loserPct := 1;
        v_winerPct := (v_lossqty-v_profitqty1)/v_profitqty2;
        update T_E_DeductDetail set EstimateQty=deductableqty
        where pl_ratio>=v_profitlvl1 and deductID=p_deductID and wl='W';
        update T_E_DeductDetail set EstimateQty=deductableqty*v_winerPct
        where pl_ratio>=v_profitlvl2 and pl_ratio<v_profitlvl1 and deductID=p_deductID and wl='W';
    else --(v_lossqty<=v_profitqty1)
        v_loserPct := 1;
        v_winerPct := v_lossqty/v_profitqty1;
        update T_E_DeductDetail set EstimateQty=deductableqty*v_winerPct
        where pl_ratio>=v_profitlvl1 and deductID=p_deductID and wl='W';
    end if;

    update T_E_DeductDetail set EstimateQty=deductableqty*v_loserPct where deductID=p_deductID and wl='L';

    --�Ƚ��������ּ���ǿ������
    update T_E_DeductDetail set deductqty=trunc(EstimateQty) where deductID=p_deductID;
    --�ó������ݿ��𷽺�ӯ�������ֲ��෴�ķ��ţ������������ӯ�����Ĳ�Ҳ����С������û�з����ǿ����
    select abs(sum(sign(pureHoldQty)*deductqty)) into v_diff from T_E_DeductDetail where deductID=p_deductID;
    --�Է������Ŀͻ�����ȡ��
    if(v_diff > 0) then
        open c_deductRound;
        loop
          fetch c_deductRound into v_customerid;
          exit when v_diff=0;
          update T_E_DeductDetail set deductqty=deductqty+1 where deductID=p_deductID and customerid=v_customerid;
          v_diff:=v_diff - 1;
        end loop;
        close c_deductRound;
    end if;

    --����Գ�����
    if(v_losermode=1) then
        if(v_selfcounteract=0) then   --���Գ�
            update T_E_DeductDetail set CounteractQty=0
            where deductID=p_deductID;
        else --ȫ��˫��ֲֶԳ�
            if(v_loserBSflag=1) then
                update T_E_DeductDetail set CounteractQty=least(buyqty-buykeepqty-deductqty,sellqty-sellkeepqty)
                where deductID=p_deductID and wl='L';
                update T_E_DeductDetail set CounteractQty=least(buyqty-buykeepqty,sellqty-sellkeepqty-deductqty)
                where deductID=p_deductID and wl='W';
            else
                update T_E_DeductDetail set CounteractQty=least(buyqty-buykeepqty,sellqty-sellkeepqty-deductqty)
                where deductID=p_deductID and wl='L';
                update T_E_DeductDetail set CounteractQty=least(buyqty-buykeepqty-deductqty,sellqty-sellkeepqty)
                where deductID=p_deductID and wl='W';
            end if;
        end if;
    elsif(v_losermode=2) then
        if(v_selfcounteract=0) then    --���Գ�
            update T_E_DeductDetail set CounteractQty=0
            where deductID=p_deductID;
        elsif(v_selfcounteract=1) then --ȫ��˫��ֲֶԳ�
            if(v_loserBSflag=1) then
                update T_E_DeductDetail set CounteractQty=least(buyqty-buykeepqty-deductqty,sellqty-sellkeepqty)
                where deductID=p_deductID and wl='L';
                update T_E_DeductDetail set CounteractQty=least(buyqty-buykeepqty,sellqty-sellkeepqty-deductqty)
                where deductID=p_deductID and wl='W';
            else
                update T_E_DeductDetail set CounteractQty=least(buyqty-buykeepqty,sellqty-sellkeepqty-deductqty)
                where deductID=p_deductID and wl='L';
                update T_E_DeductDetail set CounteractQty=least(buyqty-buykeepqty-deductqty,sellqty-sellkeepqty)
                where deductID=p_deductID and wl='W';
            end if;
        else --��������ƽ��ί�еģ�ί������-���ֲ�������Գ�
            if(v_loserBSflag=1) then
                update T_E_DeductDetail set CounteractQty=greatest(least(buyqty-deductqty-buykeepqty,sellqty-sellkeepqty,orderqty-pureholdqty),0)
                where deductID=p_deductID and wl='L';
            else
                update T_E_DeductDetail set CounteractQty=greatest(least(buyqty-buykeepqty,sellqty-sellkeepqty-deductqty,orderqty-(-pureholdqty)),0)
                where deductID=p_deductID and wl='L';
            end if;
        end if;
    end if;

    update T_E_deductposition set deductstatus='P' where deductID=p_deductID;

    commit;
    return 1;
end;
/

prompt
prompt Creating function FN_T_DEDUCTGO
prompt ===============================
prompt
create or replace function FN_T_DeductGo
 (
   p_deductID number  --ǿ��ID
 )
return number  --���� 1 �ɹ�  -1:ֻ�ܱ��в���״̬ǿ����-2��ǿ�����ڲ��ǵ���
/***
 * ����ǿ�����ݣ�ǿ����ϸ��ִ��ǿ�Ƽ���
 *
 ***/
as
  v_systemstatus number(2);
  v_deductDate date;
  v_cmdtyCode varchar2(16);  --ǿ������Ʒ����
  v_deductPrice number;
  v_loserBSflag number(1);
  v_selfCounteract char(1);
  v_customerid varchar2(40);

  v_customerid_l varchar2(40);
  v_deductqty number(10);
  v_CounteractQty number(10);

  v_customerid_w varchar2(40);

  v_num number(10);
  v_dnum number(10);

  v_ret number;
  v_TradeDate date;

  cursor c_counteract is --�Գ�
    select customerid,CounteractQty-CounteractedQty from T_E_DeductDetail
    where deductID=p_deductID and CounteractQty-CounteractedQty>0;

  cursor c_deduct is
    select customerid,deductqty-deductedqty from T_E_DeductDetail
    where deductID=p_deductID and wl='L' and deductqty-deductedqty>0
    order by deductqty desc;


begin
  select status,TradeDate into v_systemstatus,v_TradeDate from t_systemstatus;
  if(v_systemstatus<>1) then --ֻ�ܱ��в���״̬ǿ��
    return -1;
  end if;

  --���ǿ������
  select deductdate,commodityid,deductprice,loserBSflag,selfcounteract
  into v_deductDate,v_cmdtyCode,v_deductPrice,v_loserBSflag,v_selfcounteract
  from T_E_DeductPosition where deductID=p_deductID;
  --�ж������Ƿ���
  if(v_deductDate!=trunc(v_TradeDate))then
    return -2;
  end if;
  --���жԳ�
  if(v_selfcounteract>0) then
    open c_counteract;
    loop
      fetch c_counteract into v_customerid,v_counteractQty;
      exit when c_counteract%NOTFOUND;
      v_ret:=FN_T_ConferClose(v_cmdtyCode,v_deductPrice,v_customerid,v_CounteractQty,0,v_customerid,v_CounteractQty,0);
      if(v_ret = 1) then
        update T_E_DeductDetail set CounteractedQty=v_CounteractQty
        where deductID=p_deductID
          and customerid=v_customerid;
      else
        begin
          update T_E_DeductPosition set alert=alert||'Counteract customer:'||v_customerid_l||' err:'||v_ret where deductID=p_deductID;
        exception
          when OTHERS then
            null;
        end;
      end if;
    end loop;
  end if;
  --����Э��ƽ�ֽ���ǿ��
  open c_deduct;
  loop
    fetch c_deduct into v_customerid_l,v_deductqty;
    exit when c_deduct%NOTFOUND;

    loop
      exit when v_deductqty<=0;
      select customerid,deductqty-deductedqty into v_customerid_w,v_num from T_E_DeductDetail
      where deductID=p_deductID and wl='W'
        and (deductqty-deductedqty)>0 and rownum<2;
      if(v_deductqty>v_num) then
        v_dnum := v_num;
      else
        v_dnum := v_deductqty;
      end if;
      if(v_loserBSflag=1) then
        v_ret:=FN_T_ConferClose(v_cmdtyCode,v_deductPrice,v_customerid_l,v_dnum,0,v_customerid_w,v_dnum,0);
      else
        v_ret:=FN_T_ConferClose(v_cmdtyCode,v_deductPrice,v_customerid_w,v_dnum,0,v_customerid_l,v_dnum,0);
      end if;
      if(v_ret=1) then
        v_deductqty:=v_deductqty-v_dnum;
        update T_E_DeductDetail set deductedqty=deductedqty+v_dnum
        where deductID=p_deductID
          and customerid in (v_customerid_l,v_customerid_w);
      end if;
    end loop;

  end loop;
  update T_E_DeductPosition set deductstatus='Y',exectime=sysdate where deductID=p_deductID;
  return 1;
end;
/

prompt
prompt Creating function FN_T_D_BUYNEUTRALORDER
prompt ========================================
prompt
create or replace function FN_T_D_BuyNeutralOrder(
  p_FirmID     varchar2,   --������ID
  p_TraderID       varchar2,  --����ԱID
  p_CommodityID varchar2 ,--��ƷID
  p_Quantity       number ,--����
  p_Price       number ,--ί�м۸���������
  p_CustomerID     varchar2,  --���׿ͻ�ID
  p_ConsignerID    varchar2,  --��Ϊί��ԱID
  p_DelayQuoShowType number --����������ʾ���ͣ�0�������걨�������������걨������ʾ�� 1��ʵʱ��ʾ��
) return number
/****
 * �������걨ί��
 * ����ֵ
 * >0  �ɹ��ύ��������ί�е���
 * -2  �����̿����ʽ���
****/
as
  v_version varchar2(10):='1.0.0.0';
  v_Payout_B    number(15,2);   --�򷽽��ջ���
  v_SettleMargin    number(15,2);   --���ձ�֤��
  v_HoldFunds     number(15,2);   --����ֲֶ����ʽ�
  v_F_Funds      number(15,2):=0;   --Ӧ�����ʽ�
  v_F_FrozenFunds  number(15,2); --���񶳽��ʽ�
  v_A_Funds      number(15,2);   --�����ʽ�
  v_A_OrderNo       number(15); --ί�е���
  v_b_s_unsettleqty number(15);--�����걨������֮��Ĳ�ֵ
  v_NeutralSide number(2); --�����ַ���
  v_ret  number(4);
  v_errorcode number;
  v_errormsg  varchar2(200);
begin
  --1. ��鲢�����ʽ�
  --�򷽶����ʽ��򷽻���򷽽��ձ�֤�𣫷���ֱֲ�֤��
  --�����򷽻���
  v_Payout_B := FN_T_ComputePayout(p_FirmID,p_CommodityID,1,p_Quantity,p_Price);
  --���㽻�ձ�֤��
  v_SettleMargin := FN_T_ComputeSettleMargin(p_FirmID,p_CommodityID,1,p_Quantity,p_Price);
  --���㷴��ֱֲ�֤��
  v_HoldFunds := FN_T_ComputeMargin(p_FirmID,p_CommodityID,2,p_Quantity,p_Price);
  --Ӧ�����ʽ�
  v_F_Funds := v_Payout_B + v_SettleMargin + v_HoldFunds;

  --��������ʽ𣬲���ס�����ʽ�
  v_A_Funds := FN_F_GetRealFunds(p_FirmID,1);
  if (v_F_Funds>v_A_Funds) then
    rollback;
    return -2; --�����ʽ���
  end if;
  --2. ���¶����ʽ�
  v_F_FrozenFunds := FN_F_UpdateFrozenFunds(p_FirmID,v_F_Funds,'15');
  --3. ��������ί�б�������ί�е���
  select SEQ_T_DelayOrders.nextval into v_A_OrderNo from dual;
  insert into T_DelayOrders
    ( a_orderno,    CommodityID,   CustomerID,    traderid,   bs_flag, DelayOrderType, status, quantity, price, tradeqty, frozenfunds, unfrozenfunds, ordertime, withdrawtime, ordererip, signature,  FirmID ,ConsignerID)
  values
    (v_A_OrderNo,  p_CommodityID, p_CustomerID,  p_TraderID,        1,           2,         1,p_Quantity, p_Price,  0,     v_F_Funds,       0,         sysdate,      null,       null,     null,     p_FirmID ,p_ConsignerID);

  --4. ����ʵʱ��ʾ��Ҫ��������
  if(p_DelayQuoShowType = 1) then
    update T_DelayQuotation set BuyNeutralQty=nvl(BuyNeutralQty,0) + p_Quantity,CreateTime=sysdate where CommodityID = p_CommodityID;
  end if;

  commit;
  return v_A_OrderNo;
exception
  when NO_DATA_FOUND then
    rollback;
    return -99;  --�������������
  when others then
  v_errorcode:=sqlcode;
  v_errormsg :=sqlerrm;
  rollback;
  insert into T_DBLog(err_date,name_proc,err_code,err_msg)
  values(sysdate,'FN_T_D_BuyNeutralOrder',v_errorcode,v_errormsg);
  commit;
  return -100;
end;
/

prompt
prompt Creating function FN_T_D_BUYNEUTRALORDER_WD
prompt ===========================================
prompt
create or replace function FN_T_D_BuyNeutralOrder_WD(
  p_FirmID     varchar2,   --������ID
  p_CustomerID     varchar2,  --���׿ͻ�ID
  p_CommodityID varchar2 ,--��ƷID
  p_Quantity       number ,--ί������
  p_TradeQty       number ,--�ѳɽ�����
  p_Price       number ,--ί�м۸���������
  p_A_OrderNo_W     number,  --����ί�е���
  p_quantity_wd       number,  --��������
  p_frozenfunds     number,  --�����ʽ�
  p_unfrozenfunds       number  --�ⶳ�ʽ�
) return number
/****
 * ��������ί�г������ú���������ִ���ύ�ͻع�����
 * ����ֵ
 * 1  �ɹ�
****/
as
  v_version varchar2(10):='1.0.0.0';
  v_Payout_B    number(15,2);   --�򷽽��ջ���
  v_SettleMargin    number(15,2);   --�򷽽��ձ�֤��
  v_to_unfrozenF   number(15,2);
  v_F_FrozenFunds   number(15,2);   --�����̶����ʽ�
  v_HoldFunds   number(15,2);   --�����̷���ֱֲ�֤��
begin
  --1. �ͷ�ʣ��Ķ����ʽ𣬸���δ�ɽ�����
  if(p_Quantity - p_TradeQty = p_quantity_wd) then
    v_to_unfrozenF := p_frozenfunds - p_unfrozenfunds;
  else
    --�����ʽ�
    --�򷽶����ʽ��򷽻���򷽽��ձ�֤�𣫷���ֱֲ�֤��
    v_Payout_B := FN_T_ComputePayout(p_FirmID,p_CommodityID,1,p_quantity_wd,p_Price);
    --���㽻�ձ�֤��
    v_SettleMargin := FN_T_ComputeSettleMargin(p_FirmID,p_CommodityID,1,p_quantity_wd,p_Price);
    --���㷴��ֱֲ�֤��
    v_HoldFunds := FN_T_ComputeMargin(p_FirmID,p_CommodityID,2,p_quantity_wd,p_Price);
    --Ӧ�����ʽ�
    v_to_unfrozenF := v_Payout_B + v_SettleMargin + v_HoldFunds;
  end if;
  update T_DelayOrders set unfrozenfunds = unfrozenfunds + v_to_unfrozenF
  where A_orderNo = p_a_orderno_w;
  --2. ���½����̲��񶳽��ʽ�
  v_F_FrozenFunds := FN_F_UpdateFrozenFunds(p_FirmID,-v_to_unfrozenF,'15');

  return 1;
end;
/

prompt
prompt Creating function FN_T_D_BUYSETTLEORDER
prompt =======================================
prompt
create or replace function FN_T_D_BuySettleOrder(
    p_FirmID     varchar2,   --������ID
    p_TraderID       varchar2,  --����ԱID
    p_CommodityID varchar2 ,--��ƷID
    p_Quantity       number ,--����
    p_Price       number ,--ί�м۸���������
  p_CustomerID     varchar2,  --���׿ͻ�ID
  p_ConsignerID       varchar2,  --��Ϊί��ԱID
  p_TradeMargin_B       number,  --Ӧ���򷽽��ױ�֤��
  p_DelayQuoShowType       number  --����������ʾ���ͣ�0�������걨�������������걨������ʾ�� 1��ʵʱ��ʾ��
) return number
/****
 * �����걨ί��
 * ���������޸��걨�����жϣ��þ����������ǵ����ֲܳ��ж� by chenxc 2011-09-20
 * ����ֵ
 * >0  �ɹ��ύ��������ί�е���
 * -1  �ֲֲ���
 * -2  �ʽ�����
 * -99  �������������
 * -100 ��������
****/
as
  v_version varchar2(10):='1.0.2.2';
    v_HoldSum        number(10);   --�ֲֺϼ�����
    v_Payout_B    number(15,2);   --�򷽽��ջ���
     v_Payout_BSum number(15,2):=0;  --�����ջ������
    v_SettleMargin_B    number(15,2):=0;   --�򷽽��ձ�֤��
    v_SettleMargin_BSum    number(15,2):=0;   --�򷽽��ձ�֤�����
    v_TradeMargin_B    number(15,2);   --�򷽽��ױ�֤��
    v_TradeMargin_BSum    number(15,2):=0;   --�򷽽��ױ�֤�����
    v_F_Funds      number(15,2):=0;   --Ӧ�����ʽ�
    v_A_Funds      number(15,2);   --�����ʽ�
    v_F_FrozenFunds  number(15,2); --���񶳽��ʽ�
    v_A_OrderNo       number(15); --ί�е���
    v_HoldOrderNo  number(15):=0;--�ֲ�ί�е���  ---add by zhangjian 2012��3��2��
    v_errorcode number;
    v_errormsg  varchar2(200);
    v_DelayOrderIsPure        number(1);   --�����걨�Ƿ񰴾��������걨
    v_HoldSum_S        number(10):=0;   --�����ֲֺϼ�����
    v_HoldSum_B        number(10):=0;   --�򷽳ֲֺϼ�����
    v_DelaySettlePriceType         number(10);   --�����걨�������� 0��������۽����걨 �� 1���������۽���  -- add  by zhangjian
    v_sql varchar2(500);
    v_qtySum number(15):=0;  -- ��ί�еĽ����걨��������
    v_price number(15,6);-- �����걨�۸�
    v_theOrderPriceSum number(15,6):=0;-- ���ν����걨�����۸����
    v_holdQty number(15):=0;--ÿ�ʳֲ���ϸ�еĳֲ�����
    v_tempQty number(15):=0;--�м����
    v_aheadSettleQty number(15):=0;--��ǰ������������
    v_alreadyQty number(15):=0;--����ί���Ѷ�������
    type cur_T_HoldPosition is ref cursor;
    v_HoldPosition cur_T_HoldPosition;
  v_orderLogNo number(15):=0;--ί���µ���־ ID��
  v_orderSumLogNo number(15):=0;--ί���µ���־�ϼ����� ID

begin

  --1�����ֲ֣�����ס�ֲֺϼƼ�¼
  begin
      select nvl(holdQty - frozenQty, 0) into v_HoldSum
      from T_CustomerHoldSum
      where CustomerID = p_CustomerID
        and CommodityID = p_CommodityID
        and bs_flag = 1 for update;
  exception
        when NO_DATA_FOUND then
            rollback;
           return -1;  --�ֲֲ���
    end;
    --���������޸��걨�����жϣ��þ����������ǵ����ֲܳ��ж� by chenxc 2011-09-20
    --�����걨�Ƿ񰴾��������걨
  select DelayOrderIsPure into v_DelayOrderIsPure from T_A_Market;
  if(v_DelayOrderIsPure = 1) then --�����������걨
      begin
        select holdQty+GageQty into v_HoldSum_S
        from T_CustomerHoldSum
        where CustomerID = p_CustomerID
          and CommodityID = p_CommodityID
          and bs_flag = 2 ;
    exception
          when NO_DATA_FOUND then
              v_HoldSum_S := 0;
      end;
      if(v_HoldSum-v_HoldSum_S < p_Quantity) then
          rollback;
          return -1;  --������������
      end if;
  else
      if(v_HoldSum < p_Quantity) then
          rollback;
          return -1;  --�ֲֲ���
      end if;
    end if;
    --2����鲢�����ʽ𣺶����򷽽��ջ���+�򷽽��ձ�֤��-��ռ�õĽ��ױ�֤��
      --���ݽ����걨�۸����� �ж���ζ����ʽ�0��������۽��� ��1���������۽���  mod by zhangjian
    select   DelaySettlePriceType into v_DelaySettlePriceType from t_commodity where commodityid=p_CommodityID;

    if(v_DelaySettlePriceType=1) then -- ����ǰ������۽���
    select nvl(sum(Quantity-TradeQty),0) into v_qtySum from T_DelayOrders where  commodityid=p_CommodityID and customerid=p_CustomerID and   status in (1,2) and bs_flag=1;
     -- select sum(quantity) into   v_aheadSettleQty from T_E_ApplyAheadSettle where modifier is null;
      v_qtySum:=v_qtySum+v_aheadSettleQty;--�Ѿ����������

    v_sql:='select price,HoldQty,a.A_HoldNo   from T_holdposition a,(select A_HoldNo from T_SpecFrozenHold group by A_HoldNo) b
                 where (a.HoldQty+a.GageQty) > 0 and a.A_HoldNo=b.A_HoldNo(+) and CustomerID='''||p_CustomerID||'''
                   and CommodityID ='''|| p_CommodityID||''' and bs_flag =  1   '||'  order by a.A_HoldNo';
     open v_HoldPosition for v_sql;
        loop
            fetch v_HoldPosition into v_price,v_holdQty,v_HoldOrderNo;
            exit when v_HoldPosition%NOTFOUND;
           v_HoldSum_S:=v_HoldSum_S+v_holdQty;
            v_tempQty:=0; --ÿ����ձ�������
            if(v_HoldSum_S>v_qtySum)then --���㽻�ջ����Լ����ձ�֤���ۻ��������Ǵ��ڵ�ǰ����ί�б����Ѿ����ڵġ�
            if(p_Quantity>=(v_HoldSum_S-v_qtySum))then
            v_tempQty:=v_HoldSum_S-v_qtySum-v_alreadyQty;--��ǰ���������
            v_alreadyQty:=v_tempQty+v_alreadyQty;
            else  --��������㵱ǰ�������˳�����
            v_tempQty:=p_Quantity-v_alreadyQty;
            v_HoldSum_S:=0;
             end if;
            end if;
            --���㽻�ջ���
            v_Payout_B  := FN_T_ComputePayout(p_FirmID,p_CommodityID,1,v_tempQty,v_price);
            --���㽻�ձ�֤��
            v_SettleMargin_B := FN_T_ComputeSettleMargin(p_FirmID,p_CommodityID,1,v_tempQty,v_price);
            --���㽻�ױ�֤��
            v_TradeMargin_B := FN_T_ComputeMargin(p_FirmID,p_CommodityID,1,v_tempQty,v_price);


            v_Payout_BSum :=v_Payout_BSum+v_Payout_B;--�ۻ����ջ���
            v_SettleMargin_BSum :=v_SettleMargin_BSum+v_SettleMargin_B;  --�ۻ����ձ�֤��
            v_TradeMargin_BSum := v_TradeMargin_BSum+v_TradeMargin_B;  --�ۼӽ��ױ�֤��
            v_theOrderPriceSum :=v_theOrderPriceSum+v_price*v_tempQty;--�ۼӶ����۸�

            --ѭ��ÿ�ʳֲ���ϸ��Ҫ����ί����־  add by zhangjian 2012��3��2��
            select SEQ_T_D_OrderLog.nextval into v_orderLogNo  from dual  ;
            insert into T_D_DelayOrderLog  values (v_orderLogNo,p_firmid,1,p_CommodityID,v_HoldOrderNo,v_price,v_tempQty,v_SettleMargin_B,v_TradeMargin_B,v_Payout_B,Sysdate,null );

            if(v_HoldSum_S=0)then
                   v_price:=v_theOrderPriceSum/p_Quantity;--����˳�ѭ�������ƽ�������۸�
                   exit;
               end if;
        end loop;

   elsif(v_DelaySettlePriceType=0)then --����ǰ�����۽���
   v_price:=p_Price;
  --���㽻�ջ���
  v_Payout_B := FN_T_ComputePayout(p_FirmID,p_CommodityID,1,p_Quantity,v_price);
  --���㽻�ձ�֤��
  v_SettleMargin_B := FN_T_ComputeSettleMargin(p_FirmID,p_CommodityID,1,p_Quantity,v_price);
              v_Payout_BSum :=v_Payout_B;
              v_SettleMargin_BSum :=v_SettleMargin_B;
   --���ױ�֤��
   v_TradeMargin_BSum:=p_TradeMargin_B;
  end if;
    --Ӧ�����ʽ�
    v_F_Funds := v_Payout_BSum + v_SettleMargin_BSum - v_TradeMargin_BSum;
    --��������ʽ𣬲���ס�����ʽ�
    v_A_Funds := FN_F_GetRealFunds(p_FirmID,1);

    --��������ί�кϼƱ���־   --add by zhangjian  2012��3��2��
    select SEQ_T_D_OrderSumLog.nextval  into v_orderSumLogNo from dual;
    insert into  T_D_DelayOrderSumLog values (v_orderSumLogNo,p_firmid,1,p_CommodityID,v_price,p_Quantity,v_SettleMargin_BSum,p_TradeMargin_B,v_Payout_BSum,v_A_Funds,v_F_Funds,Sysdate,null);


    if(v_A_Funds < v_F_Funds) then
        rollback;
        return -2;  --�ʽ�����
    end if;
  --3�����½��׿ͻ��ֲֺϼƵĶ�������
    update T_CustomerHoldSum set frozenQty = frozenQty + p_Quantity
    where CustomerID = p_CustomerID
    and CommodityID = p_CommodityID
    and bs_flag = 1;
    --4�����¶����ʽ�
  v_F_FrozenFunds := FN_F_UpdateFrozenFunds(p_FirmID,v_F_Funds,'15');
    --5����������ί�б�������ί�е���
    select SEQ_T_DelayOrders.nextval into v_A_OrderNo from dual;
    insert into T_DelayOrders
      ( a_orderno,    CommodityID,   CustomerID,    traderid,   bs_flag, DelayOrderType, status, quantity, price, tradeqty, frozenfunds, unfrozenfunds, ordertime, withdrawtime, ordererip, signature,  FirmID ,ConsignerID)
    values
      (v_A_OrderNo,  p_CommodityID, p_CustomerID,  p_TraderID,     1,           1,          1,  p_Quantity, v_price,  0,     v_F_Funds,       0,         sysdate,      null,       null,     null,     p_FirmID ,p_ConsignerID);


    --����ʵʱ��ʾ��Ҫ��������
    if(p_DelayQuoShowType = 1) then
      update T_DelayQuotation set BuySettleQty=BuySettleQty + p_Quantity,CreateTime=sysdate where CommodityID = p_CommodityID;
    end if;

    commit;
    return v_A_OrderNo;
exception
    when NO_DATA_FOUND then
        rollback;
        return -99;  --�������������
    when others then
    v_errorcode:=sqlcode;
    v_errormsg :=sqlerrm;
    rollback;
    insert into T_DBLog(err_date,name_proc,err_code,err_msg)
    values(sysdate,'FN_T_D_BuySettleOrder',v_errorcode,v_errormsg);
    commit;
    return -100;
end;
/

prompt
prompt Creating function FN_T_D_BUYSETTLEORDER_WD
prompt ==========================================
prompt
create or replace function FN_T_D_BuySettleOrder_WD(
    p_FirmID     varchar2,   --������ID
    p_CustomerID     varchar2,  --���׿ͻ�ID
    p_CommodityID varchar2 ,--��ƷID
    p_Quantity       number ,--ί������
    p_TradeQty       number ,--�ѳɽ�����
    p_Price       number ,--ί�м۸���������
	p_A_OrderNo_W     number,  --����ί�е���
	p_quantity_wd       number,  --��������
	p_frozenfunds     number,  --�����ʽ�
	p_unfrozenfunds       number  --�ⶳ�ʽ�
) return number
/****
 * �����걨ί�г���
 * ����ֵ
 * 1 �ɹ�
****/
as
	v_version varchar2(10):='1.0.2.2';
    v_Margin         number(15,2);   --Ӧ�ձ�֤��
    v_Payout_B    number(15,2);   --�򷽽��ջ���
    v_SettleMargin_B    number(15,2);   --�򷽽��ձ�֤��
    v_to_unfrozenF   number(15,2);
    v_F_FrozenFunds   number(15,2);   --�����̶����ʽ�
    v_MarginPriceType         number(1);     --����ɽ���֤���������� 0:ʵʱ�ͱ���ʱ�������ּۣ�1:ʵʱ�������ۣ����а����ս����
    v_LastPrice    number(15,2);   --������
begin
	--1���ͷ�ʣ��Ķ���ֲ�
    update T_CustomerHoldSum set frozenQty = frozenQty - p_quantity_wd
    where CustomerID = p_CustomerID
      and CommodityID = p_CommodityID
      and bs_flag = 1;
	--2���ͷ�ʣ��Ķ����ʽ𣬸���δ�ɽ�����
    if(p_Quantity - p_TradeQty = p_quantity_wd) then
        v_to_unfrozenF := p_frozenfunds - p_unfrozenfunds;
    else
	    --�����ʽ𣺶����򷽽��ջ���+�򷽽��ձ�֤��-��ռ�õĽ��ױ�֤��
		--���㽻�ջ���
		v_Payout_B := FN_T_ComputePayout(p_FirmID,p_CommodityID,1,p_quantity_wd,p_Price);
		--���㽻�ձ�֤��
		v_SettleMargin_B := FN_T_ComputeSettleMargin(p_FirmID,p_CommodityID,1,p_quantity_wd,p_Price);
	    --���㽻�ױ�֤��
	    select MarginPriceType,LastPrice
	    into v_MarginPriceType,v_LastPrice
	    from T_Commodity where CommodityID=p_CommodityID;
    	if(v_MarginPriceType = 1) then
	    	v_Margin := FN_T_ComputeMargin(p_FirmID,p_CommodityID,1,p_quantity_wd,v_LastPrice);
	    else
	    	v_Margin := FN_T_ComputeMargin(p_FirmID,p_CommodityID,1,p_quantity_wd,p_Price);
	    end if;
	    if(v_Margin < 0) then
	        Raise_application_error(-20040, 'computeMargin error');
	    end if;
	    v_to_unfrozenF := v_Payout_B + v_SettleMargin_B - v_Margin;
    end if;
    update T_DelayOrders set unfrozenfunds = unfrozenfunds + v_to_unfrozenF
    where A_orderNo = p_a_orderno_w;
    --���¶����ʽ�
	v_F_FrozenFunds := FN_F_UpdateFrozenFunds(p_FirmID,-v_to_unfrozenF,'15');

    return 1;
end;
/

prompt
prompt Creating function FN_T_D_CHECKANDFROZENBILL
prompt ===========================================
prompt
create or replace function FN_T_D_CheckAndFrozenBill(
    p_FirmID     varchar2,   --������ID
    p_CommodityID varchar2 ,--��ƷID
    p_FrozenDelayQty       number --������������
) return number
/****
 * ��鲢����ֵ�
 * ����ֵ
 * 1  �ɹ�
 * -1  �ֲֲ���
****/
as
	v_version varchar2(10):='1.0.2.2';
    v_HoldSum        number(10);   --�ֲֺϼ�����
    v_WillFrozenQty    number(10);
    v_TempFrozenQty    number(10);
begin
/*
	--1������Ч�ֵ����ȡ����������¼
    select nvl(sum(Quantity-SettleDelayQty-FrozenDelayQty), 0) into v_HoldSum
    from T_ValidBill
    where FirmID_S = p_FirmID
      and CommodityID = p_CommodityID
      and BillType = 5
      and Status = 1;
    if(v_HoldSum < p_FrozenDelayQty) then
        rollback;
        return -1;  --�ֲֲ���
    end if;
    --2������ֵ�
    v_WillFrozenQty := p_FrozenDelayQty;
    for cur_ValidBill in (select rowid,(Quantity-SettleDelayQty-FrozenDelayQty) UsefulQty
                      from T_ValidBill
					  where FirmID_S = p_FirmID
					      and CommodityID = p_CommodityID
					      and BillType = 5
					      and Status = 1 order by CreateTime
					  )
    loop
        if(cur_ValidBill.UsefulQty <= v_WillFrozenQty) then
            v_TempFrozenQty := cur_ValidBill.UsefulQty ;
        else
        	v_TempFrozenQty := v_WillFrozenQty ;
        end if;
        update T_ValidBill
        set FrozenDelayQty=FrozenDelayQty+v_TempFrozenQty
        where rowid=cur_ValidBill.rowid;
        v_WillFrozenQty := v_WillFrozenQty - v_TempFrozenQty;
        exit when v_WillFrozenQty=0;
    end loop;
*/
    return 1;

end;
/

prompt
prompt Creating function FN_T_D_CHGCUSTHOLDBYQTY
prompt =========================================
prompt
CREATE OR REPLACE FUNCTION FN_T_D_ChgCustHoldByQty
(
  p_CustomerID varchar2,   --���׿ͻ�����
  p_CommodityID varchar2, --��Ʒ����
  p_BS_Flag        number, --������־
  p_TradeQty number     --����
)  return number
/***
 * ���½��׿ͻ��ֲֺϼ���Ϣ����������ƽ��������
 *
 * ����ֵ��1�ɹ�
 ****/
is
  v_version varchar2(10):='1.0.2.2';
  v_ContractFactor    number(12,2);
begin
    --���Ľ��׿ͻ��ֲֺϼƱ��еĳֲּ�¼
    update T_CustomerHoldSum
    set holdqty = holdqty - p_TradeQty,
        FrozenQty = FrozenQty - decode(sign(p_TradeQty),-1,0,p_TradeQty), --��p_TradeQty<0ʱ������Ҫ����������mod by lizs
        holdfunds = holdfunds - (holdfunds*p_TradeQty/holdqty),
        HoldMargin = HoldMargin - (HoldMargin*p_TradeQty/holdqty),
        HoldAssure = HoldAssure - (HoldAssure*p_TradeQty/holdqty)
    where CustomerID = p_CustomerID
      and CommodityID = p_CommodityID
      and bs_flag = p_BS_Flag;
    select ContractFactor into v_ContractFactor from T_Commodity where CommodityID = p_CommodityID;
    update T_CustomerHoldSum
    set EvenPrice = decode(HoldQty+GageQty,0,0,HoldFunds/((HoldQty+GageQty)*v_ContractFactor))
    where CustomerID = p_CustomerID
      and CommodityID = p_CommodityID
      and bs_flag = p_BS_Flag;

   return 1;
end;
/

prompt
prompt Creating function FN_T_D_CHGFIRMHOLDBYQTY
prompt =========================================
prompt
CREATE OR REPLACE FUNCTION FN_T_D_ChgFirmHoldByQty
(
  p_FirmID varchar2,   --���׿ͻ�����
  p_CommodityID varchar2, --��Ʒ����
  p_BS_Flag        number, --������־
  p_TradeQty       number,     --����
  p_GageMode       number     --����
)  return number
/***
 * ���½����ֲֺ̳ϼ���Ϣ����������ƽ��������
 *
 * ����ֵ��1�ɹ�
 ****/
is
  v_version varchar2(10):='1.0.2.2';
  v_ContractFactor    number(12,2);
begin
    --���Ľ����ֲֺ̳ϼƱ��еĳֲּ�¼
    update T_FirmHoldSum
    set holdqty = holdqty - p_TradeQty,
        holdfunds = holdfunds - (holdfunds*p_TradeQty/holdqty),
        HoldMargin = HoldMargin - (HoldMargin*p_TradeQty/holdqty),
        HoldAssure = HoldAssure - (HoldAssure*p_TradeQty/holdqty)
    where FirmID = p_FirmID
      and CommodityID = p_CommodityID
      and bs_flag = p_BS_Flag;
    select ContractFactor into v_ContractFactor from T_Commodity where CommodityID = p_CommodityID;
    update T_FirmHoldSum
    set EvenPrice = decode(p_GageMode,1,decode(HoldQty+GageQty,0,0,HoldFunds/((HoldQty+GageQty)*v_ContractFactor)),
        decode(HoldQty,0,0,HoldFunds/((HoldQty)*v_ContractFactor)))
    where FirmID = p_FirmID
      and CommodityID = p_CommodityID
      and bs_flag = p_BS_Flag;

   return 1;
end;
/

prompt
prompt Creating function FN_T_D_CHGFIRMMARGINBYQTY
prompt ===========================================
prompt
CREATE OR REPLACE FUNCTION FN_T_D_ChgFirmMarginByQty
(
  p_FirmID varchar2,   --���׿ͻ�����
  p_CommodityID varchar2, --��Ʒ����
  p_BS_Flag        number, --������־
  p_TradeQty       number     --����
)  return number
/***
 * ������ʱ��֤�����ʱ�����𣬸�������ƽ��������
 *
 * ����ֵ��1�ɹ�
 ****/
is
  v_version varchar2(10):='1.0.2.2';
  v_HoldMargin    number(15,2);
  v_HoldAssure    number(15,2);
begin
    --���Ľ����ֲֺ̳ϼƱ��еĳֲּ�¼
    select HoldMargin*p_TradeQty/holdqty,HoldAssure*p_TradeQty/holdqty into v_HoldMargin,v_HoldAssure from T_FirmHoldSum
    where FirmID = p_FirmID
      and CommodityID = p_CommodityID
      and bs_flag = p_BS_Flag;
    --������ʱ��֤�����ʱ������
    update T_Firm
    set runtimemargin = runtimemargin - v_HoldMargin,
	    RuntimeAssure = RuntimeAssure - v_HoldAssure
    where Firmid = p_FirmID;
    return v_HoldMargin-v_HoldAssure;
end;
/

prompt
prompt Creating function FN_T_D_SETTLEONE
prompt ==================================
prompt
create or replace function FN_T_D_SettleOne(
    p_CommodityID varchar2,   --��Ʒ����
  p_Price         number,  --���ռ�
  p_BS_Flag     number,  --������־
    p_CustomerID    varchar2,     --���׿ͻ�ID
    p_HoldQty      number,   --���ճֲ����������ǵֶ�����
  p_GageQty      number   --���յֶ�������Ŀǰ��֧�ֵֶ�����
) return number
/****
 * �������������ڽ���
 * ����ֵ
 * 1 �ɹ�
 * -3  ���ճֲ��������ڿɽ��ճֲ�����
 * -4  ���յֶ��������ڿɵֶ�����
****/
as
  v_version varchar2(10):='1.0.2.2';
    v_CommodityID varchar2(16);
    v_CustomerID        varchar2(40);
    v_FirmID varchar2(32);
    v_HoldQty  number;
    v_frozenQty      number(10);
    v_Margin_one         number(15,2):=0;
    v_closeFL_one         number(15,2):=0;    --һ����¼�Ľ���ӯ��
    v_Fee_one         number(15,2):=0;    --һ����¼�Ľ���������
  v_Assure_one         number(15,2):=0;
    v_Payout_one         number(15,2):=0;
    v_BS_Flag           number(2);
    v_Price         number(15,2);
    v_ContractFactor    number(12,2);
    v_TradeDate date;
  v_A_HoldNo number(15);
  v_ID number(15);
  v_AddedTaxFactor T_Commodity.AddedTaxFactor%type;--��ֵ˰��ϵ��=AddedTax/(1+AddedTax)
  v_GageQty     number(10);
  v_CloseAddedTax_one   number(15,2); --����ӯ����ֵ˰
  v_CloseAddedTax         number(15,2):=0;        --����ӯ����ֵ˰�ۼ�
  v_unCloseQty     number(10):=p_HoldQty; --δƽ�����������м����
  v_unCloseQtyGage     number(10):=p_GageQty; --δƽ�����������м����
  v_tradedAmount   number(10):=0;  --�ɽ�����
  v_tradedAmountGage   number(10):=0;  --�ɽ�����
  v_CloseAlgr           number(2);
  v_HoldType           number(2);
  v_HoldMargin         number(15,2);
    v_HoldAssure         number(15,2);
    v_NeutralFeeWay           number(2);
    v_SettleMargin_one     number(15,2);
  type cur_T_HoldPosition is ref cursor;
  v_HoldPosition cur_T_HoldPosition;
  v_sql varchar2(500);
  v_orderby  varchar2(100);
  v_AtClearDate          date;
  v_num            number(10);
  v_GageMode     number(2);
  v_SettleMargin     number(15,2):=0;
  v_Fee         number(15,2):=0;
  v_Payout         number(15,2):=0;
  v_Balance    number(15,2);
  v_F_FrozenFunds   number(15,2);
  v_CloseFL         number(15,2):=0;
  v_ret     number(4);
  v_RuntimeMargin       number(15,2);
  v_SettlePrice number(15,2);
  v_settlePriceType  number(2);
  v_TaxInclusive     number(1);   --��Ʒ�Ƿ�˰ 0��˰  1����˰   xiefei 20150730
begin
    v_CustomerID := p_CustomerID;
      v_CommodityID := p_CommodityID;
        v_BS_Flag := p_BS_Flag;

        --��ȡƽ���㷨,�ֶ�ģʽ����֤��������ͣ���ֵ˰����Լ����
        select CloseAlgr,NeutralFeeWay,GageMode into v_CloseAlgr,v_NeutralFeeWay,v_GageMode from T_A_Market;
      /*
        select Contractfactor,AddedTaxFactor
        into v_ContractFactor,v_AddedTaxFactor  xief 20150730*/

       ---����һ���ֶ� xief 20150730
        select Contractfactor,AddedTaxFactor,TaxInclusive
        into v_ContractFactor,v_AddedTaxFactor,v_TaxInclusive
        from T_Commodity where CommodityID=v_CommodityID;
      select TradeDate into v_TradeDate from T_SystemStatus;

          --���ݽ����걨�������������ռ۸� add by  zhangjian 2011��12��13��11:04:51 start
          select DelaySettlePriceType  into v_settlePriceType from t_commodity where commodityid=p_CommodityID;
          --end by zhangjian

        --����ƽ���㷨(0�ȿ���ƽ��1����ƽ��2�ֲ־���ƽ��(������)ѡ���������� --ȥ�������㷨�����н�����Ϣ��ѯ����Ĭ������ mod by zhangjian 2011��12��12��13:47:21 start
         v_orderby := ' order by a.A_HoldNo ';
        --if(v_CloseAlgr = 0) then
        --  v_orderby := ' order by a.A_HoldNo ';
     -- elsif(v_CloseAlgr = 1) then
         -- v_orderby := ' order by a.A_HoldNo desc ';
     -- end if;
     --end by zhangjian 2011��12��12��13:47:36

      v_sql := 'select a.a_holdno,FirmID,price,(a.HoldQty-nvl(b.FrozenQty,0)),GageQty,nvl(b.FrozenQty,0),a.AtClearDate,a.HoldType,a.HoldMargin,a.HoldAssure from T_holdposition a,(select A_HoldNo,nvl(sum(FrozenQty),0) FrozenQty from T_SpecFrozenHold group by A_HoldNo) b ' ||
                 ' where (a.HoldQty+a.GageQty) > 0 and a.A_HoldNo=b.A_HoldNo(+) and CustomerID=''' || v_CustomerID ||
                 ''' and CommodityID =''' || v_CommodityID || ''' and bs_flag = ' || v_BS_Flag || v_orderby;

      --�����ֲ���ϸ�����������˵�ָ��ƽ�ֶ��������
        open v_HoldPosition for v_sql;
        loop
            fetch v_HoldPosition into v_a_holdno, v_FirmID, v_price, v_holdqty,v_GageQty,v_frozenQty,v_AtClearDate,v_HoldType,v_HoldMargin,v_HoldAssure;
            exit when v_HoldPosition%NOTFOUND;

            if(v_settlePriceType=0)then--���������㽻��
                  v_SettlePrice:=p_Price;

            else --����������۽���
                 v_SettlePrice:=v_Price;
            end if;
            --����˱ʳֲ�ȫ����ָ��ƽ�ֶ�����û�еֶ���ָ����һ����¼
            if(v_holdqty <> 0 or v_GageQty <> 0) then
              --��0
                v_tradedAmount:=0;
                v_tradedAmountGage:=0;
                v_Payout_one := 0;
                v_Margin_one := 0;
              v_Assure_one := 0;
              v_SettleMargin_one := 0;
                --1������Ӧ�˿���
                if(v_holdqty > 0) then
                  if(v_holdqty<=v_unCloseQty) then
                      v_tradedAmount:=v_holdqty;
                      v_Margin_one := v_HoldMargin;
                      v_Assure_one := v_HoldAssure;
                  else
                      v_tradedAmount:=v_unCloseQty;
                      v_Margin_one := v_HoldMargin*v_tradedAmount/v_holdqty;
                      v_Assure_one := v_HoldAssure*v_tradedAmount/v_holdqty;
                  end if;
                end if;
                --2������ֲ���ϸ�н��յĵֶ�����
        if(v_GageQty > 0) then
                  if(v_GageQty<=v_unCloseQtyGage) then
                      v_tradedAmountGage:=v_GageQty;
                  else
                      v_tradedAmountGage:=v_unCloseQtyGage;
                  end if;
                end if;
          --���㽻�ձ�֤��
            v_SettleMargin_one := FN_T_ComputeSettleMargin(v_FirmID,v_CommodityID,v_BS_Flag,v_tradedAmount+v_tradedAmountGage,v_SettlePrice);
              if(v_SettleMargin_one < 0) then
                  Raise_application_error(-20042, 'ComputeSettleMargin error');
              end if;
              --3�����㽻�տ���
        --�����򷽽��ջ���
        if(v_BS_Flag = 1) then
              v_Payout_one := FN_T_ComputePayout(v_FirmID,v_CommodityID,v_BS_Flag,v_tradedAmount+v_tradedAmountGage,v_SettlePrice);
                if(v_Payout_one < 0) then
                    Raise_application_error(-20043, 'computePayout error');
                end if;
              end if;
            --���㽻��������
            if(v_HoldType = 2 and v_NeutralFeeWay = 0) then
              v_Fee_one := 0;
            else
          v_Fee_one := FN_T_ComputeSettleFee(v_FirmID,v_CommodityID,v_BS_Flag,v_tradedAmount+v_tradedAmountGage,v_SettlePrice);
        end if;
              if(v_Fee_one < 0) then
                Raise_application_error(-20031, 'computeFee error');
              end if;
              --����˰ǰ����ӯ��
              if(v_BS_Flag = 1) then
                  v_closeFL_one := (v_tradedAmount+v_tradedAmountGage)*(v_SettlePrice-v_price)*v_contractFactor; --˰ǰӯ��
              else
                  v_closeFL_one := (v_tradedAmount+v_tradedAmountGage)*(v_Price-v_SettlePrice)*v_contractFactor; --˰ǰӯ��
              end if;
              --���㽻����ֵ˰,v_AddedTaxFactor��ֵ˰ϵ��=AddedTax/(1+AddedTax)  xief  20150811
             -- v_CloseAddedTax_one := round(v_closeFL_one*v_AddedTaxFactor,2);
                v_CloseAddedTax_one := 0;

             --����˰��Ľ���ӯ�� xief 20150730   xief  20150811
            /*    if(v_TaxInclusive=1) then
                     --����˰ �۳���ֵ˰
                     v_closeFL_one := v_closeFL_one - v_CloseAddedTax_one; --˰��ӯ��
              end if;
              */
              /*--����˰����ӯ��
              v_closeFL_one := v_closeFL_one - v_CloseAddedTax_one; --˰��ӯ��  xief  20150730*/
        --�ۼƽ��
            v_Payout := v_Payout + v_Payout_one;
            v_Fee := v_Fee + v_Fee_one;
        v_CloseFL:=v_CloseFL + v_closeFL_one;  --˰��ӯ���ϼ�
        v_CloseAddedTax:=v_CloseAddedTax + v_CloseAddedTax_one;  --������ֵ˰�ϼ�
        v_SettleMargin := v_SettleMargin + v_SettleMargin_one;
            --����ǰ�ֲּ�¼�ͽ��շ��ò��뽻�ճֲ���ϸ�������³ֲ������͵ֶ�����Ϊʵ�ʽ��յ�����
        select SEQ_T_SettleHoldPosition.nextval into v_ID from dual;
        --���ֶ������뽻�ճֲ���ϸ��
          insert into t_settleholdposition
          (id, settleprocessdate, a_holdno, a_tradeno, customerid, commodityid, bs_flag, price, holdqty, openqty, holdtime, holdmargin, firmid, gageqty, holdassure, floatingloss, settlemargin, payout, settlefee, settle_pl, settleaddedtax, settleprice, settletype, holdtype, atcleardate)
            select v_ID,v_TradeDate,a_holdno, a_tradeno, customerid, commodityid, bs_flag, price, holdqty, openqty, holdtime, holdmargin, firmid, gageqty, holdassure, floatingloss,v_SettleMargin_one,v_Payout_one,v_Fee_one,v_closeFL_one,v_CloseAddedTax_one,v_SettlePrice,3, holdtype, atcleardate
            from t_holdposition
            where A_HoldNo=v_A_HoldNo;

            update T_SettleHoldPosition set HoldQty=v_tradedAmount,GageQty=v_tradedAmountGage where ID=v_ID;

                --���³ֲּ�¼
                update T_holdposition
                set holdqty = holdqty - v_tradedAmount,HoldMargin=HoldMargin-v_Margin_one,HoldAssure=HoldAssure-v_Assure_one,GageQty = GageQty - v_tradedAmountGage
                where a_holdno = v_a_holdno;
                v_unCloseQty:=v_unCloseQty - v_tradedAmount;
                v_unCloseQtyGage:=v_unCloseQtyGage - v_tradedAmountGage;
                exit when v_unCloseQty=0 and v_unCloseQtyGage=0;
            end if;
        end loop;
        close v_HoldPosition;
        if(v_unCloseQty>0) then --���ճֲ��������ڿɽ��ճֲ�����
            rollback;
            return -3;
        end if;
        if(v_unCloseQtyGage>0) then --���յֶ��������ڿɵֶ�����
            rollback;
            return -4;
        end if;
        --�ֲֺϼ������ĸ��£���֧�ֵֶ�����
    --���½��׿ͻ��ֲֺϼ�
        v_ret := FN_T_D_ChgCustHoldByQty(v_CustomerID,v_CommodityID,v_BS_Flag,p_HoldQty);
        --�ͷŽ��ױ�֤��
      v_RuntimeMargin := FN_T_D_ChgFirmMarginByQty(v_FirmID,v_CommodityID,v_BS_Flag,p_HoldQty);
      v_F_FrozenFunds := FN_F_UpdateFrozenFunds(v_FirmID,-v_RuntimeMargin,'15');
      --���½����ֲֺ̳ϼ�
    v_ret := FN_T_D_ChgFirmHoldByQty(v_FirmID,v_CommodityID,v_BS_Flag,p_HoldQty,v_GageMode);
        --�۳����ջ�����������ѣ�������ӯ�����ս��տ���,���ձ�֤�� ����д��ˮ
    v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15008',v_Payout,null,v_CommodityID,null,null);
    --ע�����ﲻ�ܰ���ͽ�����������ȡ����Ϊʵʱ��ϣ�ʵʱ������ϸ�ֲ֣����԰�ʵ����������ȡ
      v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15010',v_Fee,null,v_CommodityID,null,null);

      --��Ʒ������˰�������۳�����ӯ�����տ���
    /*if(v_CloseFL >= 0) then
      v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15011',v_CloseFL,null,v_CommodityID,v_CloseAddedTax,null);
    else
      v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15012',-v_CloseFL,null,v_CommodityID,-v_CloseAddedTax,null);
    end if;*/
    ---xief  20150811
   if(v_CloseFL >= 0) then
      v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15011',v_CloseFL,null,v_CommodityID,null,null);
    else
      v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15012',-v_CloseFL,null,v_CommodityID,null,null);
    end if;

    update T_Firm set RuntimeSettleMargin=RuntimeSettleMargin+v_SettleMargin where FirmID=v_FirmID;
    v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15013',v_SettleMargin,null,v_CommodityID,null,null);
    return 1;

end;
/

prompt
prompt Creating function FN_T_D_TRADEBILL
prompt ==================================
prompt
create or replace function FN_T_D_TradeBill(
    p_FirmID     varchar2,   --������ID
    p_CommodityID varchar2 ,--��ƷID
    p_TradeQty       number --�ɽ�����
) return number
/****
 * �ɽ��ֵ��������������٣��ѳɽ��ֵ��������ӣ��Ҹı�ֵ�״̬
 * ����ֵ
 * 1  �ɹ�
****/
as
	v_version varchar2(10):='1.0.2.2';
    v_WillFrozenQty    number(10);
    v_TempFrozenQty    number(10);
begin
/*
    --1���ⶳ�ֵ�
    v_WillFrozenQty := p_TradeQty;
    for cur_ValidBill in (select rowid,FrozenDelayQty,(Quantity-SettleDelayQty) NotSettleQty
                      from T_ValidBill
					  where FirmID_S = p_FirmID
					      and CommodityID = p_CommodityID
					      and BillType = 5
					      and Status = 1 order by CreateTime
					  )
    loop
        if(cur_ValidBill.FrozenDelayQty <= v_WillFrozenQty) then
            v_TempFrozenQty := cur_ValidBill.FrozenDelayQty ;
        else
        	v_TempFrozenQty := v_WillFrozenQty ;
        end if;
        if(cur_ValidBill.NotSettleQty = v_TempFrozenQty) then
        	update T_ValidBill
	        set BillType=2
	        where rowid=cur_ValidBill.rowid;
        end if;
        update T_ValidBill
        set FrozenDelayQty=FrozenDelayQty-v_TempFrozenQty,SettleDelayQty=SettleDelayQty+v_TempFrozenQty
        where rowid=cur_ValidBill.rowid;
        v_WillFrozenQty := v_WillFrozenQty - v_TempFrozenQty;
        exit when v_WillFrozenQty=0;
    end loop;
	*/
    return 1;

end;
/

prompt
prompt Creating function FN_T_D_NEUTRALMATCHONE
prompt ========================================
prompt
create or replace function FN_T_D_NeutralMatchOne
(
  p_CommodityID varchar2 --��Ʒ����
)  return number
/****
 * ĳ��Ʒ�����걨���
 * ����ֵ
 * 1 �ɹ�
 * -3  ���ճֲ��������ڿɽ��ճֲ�����
 * -4  ���յֶ��������ڿɵֶ�����
****/
as
    v_version varchar2(10):='1.0.2.2';
    b_qty     number(10);
    s_qty      number(10);
    Neutral_bs_flag     number(2); --�����ַ���
    Settle_bs_flag      number(2); --�����걨ʣ�෽��
    Neutral_qty     number(10);
    Settle_qty      number(10):=0;
    v_ret     number(4);
    v_tradeQtySum      number(10):=0;
    v_settleQty     number(10);
    v_exitFlag      boolean:=false;
    v_GageMode     number(2);
    v_TradeDate     date;
    v_Balance    number(15,2):=0;
    v_F_FrozenFunds   number(15,2);
    v_num            number(10);
    v_DelayNeedBill number(2);    --���ڽ����Ƿ���Ҫ�ֵ���0������Ҫ�� 1����Ҫ��
    v_NeutralFeeWay number(2);    --�Ƿ��������ֽ��������ѣ�0�����գ�1����ȡ
    v_ContractFactor    number(12,2);
    v_UnfrozenFunds   number(15,2);
    v_Status          number(2);
    v_A_TradeNo      number(15);
    v_Price    number(15,2);   --���ռ�
    v_Margin   number(15,2);   --����ֲֽ��ױ�֤��
    v_Assure   number(15,2):=0;   --Ӧ�յ�����
    v_A_HoldNo       number(15);
    v_SettleMargin_one     number(15,2);
    v_Payout_one         number(15,2):=0;
    v_Fee_one         number(15,2):=0; --����������
    v_ID number(15);
    v_NeutralMatchPriority   number(2); --�����ַ���ֲ��Ƿ����ȴ��,0:�����ȣ�1������
    v_errorcode number;
    v_errormsg  varchar2(200);
begin
    --1��ȷ�������ַ�����걨����
    select nvl(sum(Quantity-TradeQty),0) into b_qty from T_DelayOrders where DelayOrderType=2 and Status in(1,2) and BS_Flag=1 and CommodityID=p_CommodityID;
    select nvl(sum(Quantity-TradeQty),0) into s_qty from T_DelayOrders where DelayOrderType=2 and Status in(1,2) and BS_Flag=2 and CommodityID=p_CommodityID;
    if(b_qty >= s_qty) then
        Neutral_bs_flag := 1;
        Settle_bs_flag := 2;
        Neutral_qty := b_qty;
    else
        Neutral_bs_flag := 2;
        Settle_bs_flag := 1;
        Neutral_qty := s_qty;
    end if;
    --1.1��ȷ�������걨ʣ��δ�ɽ�����
    select nvl(sum(Quantity-TradeQty),0) into Settle_qty from T_DelayOrders where DelayOrderType=1 and Status in(1,2) and BS_Flag=Settle_bs_flag and CommodityID=p_CommodityID;
    --1.2�����û����Ҫ��Ե����ݣ���ֱ�ӷ��سɹ�
    if(Neutral_qty = 0 or Settle_qty = 0) then
        return 1;
    end if;

    --2����ʱ��˳����ѯ������ί�д�ϣ����ɷ���ֲ����ݡ�������ϸ
    --ȡ�����ա��ֶ�ģʽ�����ڽ����Ƿ���Ҫ�ֵ��������������ѷ�ʽ����Լ����
    select TradeDate into v_TradeDate from T_SystemStatus;
    select GageMode,DelayNeedBill,NeutralFeeWay into v_GageMode,v_DelayNeedBill,v_NeutralFeeWay from T_A_Market;
    select Contractfactor into v_ContractFactor from T_Commodity where CommodityID=p_CommodityID;
    select NEUTRALMATCHPriority into v_NeutralMatchPriority from t_a_market;
    for NeutralOrder in(select A_OrderNo,CommodityID,CustomerID,BS_Flag,(Quantity-TradeQty) NotTradeQty,Price,FirmID from T_DelayOrders where DelayOrderType=2 and Status in(1,2) and BS_Flag=Neutral_bs_flag and CommodityID=p_CommodityID order by A_OrderNo for update)
    loop
        v_exitFlag := false;
        v_tradeQtySum := 0;
        --2.1����ʱ��˳����ѯ���δ�ɽ��Ľ����걨�������ַ���ֲ����ȴ��ʱ�з���ֲֵĻ�Աί���������򣬲�����ʱֻ��ί�к�����
        --for SettleOrder in(select A_OrderNo,CommodityID,CustomerID,BS_Flag,(Quantity-TradeQty) NotTradeQty,Price,FrozenFunds,UnfrozenFunds,Quantity,FirmID from T_DelayOrders where DelayOrderType=1 and Status in(1,2) and BS_Flag=Settle_bs_flag and CommodityID=p_CommodityID order by A_OrderNo for update)
        for SettleOrder in(select A_OrderNo,CommodityID,CustomerID,BS_Flag,(Quantity-TradeQty) NotTradeQty,Price,FrozenFunds,UnfrozenFunds,Quantity,FirmID from T_DelayOrders,(select distinct(t.FirmID) as FID,1 as OrderType from T_HoldPosition t where t.BS_Flag=Settle_bs_flag and t.HoldType=decode(v_NeutralMatchPriority,1,2,0) and t.CommodityID=p_CommodityID) hp where DelayOrderType=1 and Status in(1,2) and BS_Flag=Settle_bs_flag and CommodityID=p_CommodityID and firmid=hp.FID(+) order by nvl(hp.OrderType,0) desc,A_OrderNo for update of A_OrderNo)
        loop
            if(v_tradeQtySum + SettleOrder.NotTradeQty <= NeutralOrder.NotTradeQty) then --ȫ���ɽ�
                v_settleQty := SettleOrder.NotTradeQty;
                v_UnfrozenFunds := SettleOrder.FrozenFunds-SettleOrder.UnfrozenFunds;
                v_Status := 3;
                if(v_tradeQtySum + SettleOrder.NotTradeQty = NeutralOrder.NotTradeQty) then
                    v_exitFlag := true;
                end if;
            else --���ֳɽ�
                v_settleQty := NeutralOrder.NotTradeQty - v_tradeQtySum;
                v_UnfrozenFunds:=SettleOrder.FrozenFunds*v_settleQty/SettleOrder.Quantity;
                v_Status := 2;
                v_exitFlag := true;
            end if;
            v_tradeQtySum := v_tradeQtySum + v_settleQty;
            --�����걨�ֲֽ��գ��漰�ֲ���ϸ���ֲֺϼƣ��ʽ�
            v_ret := FN_T_D_SettleOne(p_CommodityID,SettleOrder.Price,Settle_bs_flag,SettleOrder.CustomerID,v_settleQty,0);
            if(v_ret < 0) then
                rollback;
                return v_ret;
            end if;
            --���½����걨ί��״̬�������ʽ𡢲ֵ�
            update T_DelayOrders set Status=v_Status,TradeQty=TradeQty+v_settleQty,UnfrozenFunds=UnfrozenFunds+v_UnfrozenFunds where A_OrderNo=SettleOrder.A_OrderNo;
            v_F_FrozenFunds := FN_F_UpdateFrozenFunds(SettleOrder.FirmID,-v_UnfrozenFunds,'15');
            if(v_DelayNeedBill = 1) then
                v_ret := FN_T_D_TradeBill(SettleOrder.FirmID,SettleOrder.CommodityID,v_settleQty);
            end if;
            exit when v_exitFlag=true;
        end loop;

        if(v_tradeQtySum > 0) then
            --2.2�����������ַ���ֲ��������(����=Settle_bs_flag,�޽���������)
            --2.2.1���������ڳɽ�����ֲֳɽ���¼
            select SEQ_T_DelayTrade.nextval into v_A_TradeNo from dual;
            insert into T_DelayTrade
              (a_tradeno,       a_orderno,         tradetime,     CustomerID,        CommodityID,            bs_flag,   DelayOrderType,  quantity,   TradeType,    Firmid)
            values
              (v_A_TradeNo,NeutralOrder.A_OrderNo, sysdate,NeutralOrder.CustomerID,  p_CommodityID,     Settle_bs_flag,    2,    v_tradeQtySum, 1,  NeutralOrder.FirmID);
            --2.2.2�����������ַ���ֲ���ϸ��
            --�ֲּ۸�
            v_Price := NeutralOrder.Price;
            --���㱣֤��
            v_Margin := FN_T_ComputeMargin(NeutralOrder.FirmID,p_CommodityID,Settle_bs_flag,v_tradeQtySum,v_Price);
            if(v_Margin < 0) then
                Raise_application_error(-20040, 'computeMargin error');
            end if;
            --���㵣����
            v_Assure := FN_T_ComputeAssure(NeutralOrder.FirmID,p_CommodityID,Settle_bs_flag,v_tradeQtySum,v_Price);
            if(v_Assure < 0) then
                Raise_application_error(-20041, 'computeAssure error');
            end if;
            --��֤��Ӧ���ϵ�����
            v_Margin := v_Margin + v_Assure;
            --����ֲ���ϸ��
			--���ü��㺯���޸ĳֲֵ��� 2011-2-15 by feijl
            select FN_T_ComputeHoldNo(SEQ_T_HoldPosition.nextval) into v_A_HoldNo from dual;
            insert into T_Holdposition
              (a_holdno,    a_tradeno,  CommodityID,    CustomerID , bs_flag,   price,    holdqty,    openqty, holdtime,HoldMargin,HoldAssure,Firmid,FloatingLoss,HoldType,AtClearDate)
            select v_A_HoldNo,a_tradeno,CommodityID,CustomerID,bs_flag,v_Price,v_tradeQtySum,v_tradeQtySum,sysdate,v_Margin,v_Assure,Firmid,0,2,v_TradeDate
            from T_DelayTrade where a_tradeno=v_A_TradeNo;
            --2.2.3�����³ֲֺϼƱ�
            --���½��׿ͻ��ֲֺϼƱ�
            select count(*) into v_num from T_CustomerHoldSum
            where CustomerID = NeutralOrder.CustomerID
              and CommodityID = p_CommodityID
              and bs_flag = Settle_bs_flag;
            if(v_num >0) then
                --2011/5/23ȡ������FN_T_D_ChgCustHoldByQty()���������ֲ�ʱ�޷���ȷ���±�֤�𡢳ֲֽ����۵ȣ��ҿ��ܻ���ֳ���=0
                --v_ret := FN_T_D_ChgCustHoldByQty(NeutralOrder.CustomerID,p_CommodityID,Settle_bs_flag,-v_tradeQtySum);
                update T_CustomerHoldSum
                set holdQty = holdQty + v_tradeQtySum,
                holdFunds = holdFunds + v_Price*v_tradeQtySum*v_contractFactor,
                HoldMargin = HoldMargin + v_Margin,
                HoldAssure = HoldAssure + v_Assure,
                evenprice = (holdFunds + v_Price*v_tradeQtySum*v_contractFactor)/((holdQty + GageQty + v_tradeQtySum)*v_contractFactor)
                where CustomerID = NeutralOrder.CustomerID
                and CommodityID = p_CommodityID
                and bs_flag = Settle_bs_flag;
            else
              insert into T_CustomerHoldSum
                (CustomerID, CommodityID, bs_flag, holdQty, holdFunds,FloatingLoss, evenprice,FrozenQty,HoldMargin,HoldAssure,FirmID)
              values
                (NeutralOrder.CustomerID, p_CommodityID, Settle_bs_flag, v_tradeQtySum, v_Price*v_tradeQtySum*v_contractFactor,0, v_Price,0,v_Margin,v_Assure,NeutralOrder.FirmID);
            end if;
            --���½����ֲֺ̳ϼƱ�
            select count(*) into v_num from T_FirmHoldSum
            where Firmid = NeutralOrder.FirmID
              and CommodityID = p_CommodityID
              and bs_flag = Settle_bs_flag;
            if(v_num >0) then
                --2011/5/23ȡ������FN_T_D_ChgFirmHoldByQty()���������ֲ�ʱ�޷���ȷ���±�֤�𡢳ֲֽ����۵ȣ��ҿ��ܻ���ֳ���=0
                --v_ret := FN_T_D_ChgFirmHoldByQty(NeutralOrder.FirmID,p_CommodityID,Settle_bs_flag,-v_tradeQtySum,v_GageMode);
                update T_FirmHoldSum
                set holdQty = holdQty + v_tradeQtySum,
                holdFunds = holdFunds + v_Price*v_tradeQtySum*v_contractFactor,
                HoldMargin = HoldMargin + v_Margin,
                HoldAssure = HoldAssure + v_Assure,
                evenprice = (holdFunds + v_Price*v_tradeQtySum*v_contractFactor)/((holdQty + v_tradeQtySum + decode(v_GageMode,1,GageQty,0))*v_contractFactor)
                where Firmid = NeutralOrder.FirmID
                and CommodityID = p_CommodityID
                and bs_flag = Settle_bs_flag;
            else
              insert into T_FirmHoldSum
                (FirmID, CommodityID,      bs_flag,  holdQty,        holdFunds,FloatingLoss, evenprice,HoldMargin,HoldAssure)
              values
                (NeutralOrder.FirmID, p_CommodityID, Settle_bs_flag, v_tradeQtySum, v_Price*v_tradeQtySum*v_contractFactor,0,         v_Price, v_Margin,  v_Assure);
            end if;

            --������ʱ��֤�����ʱ������
            update T_Firm
            set runtimemargin = runtimemargin + v_Margin,
                RuntimeAssure = RuntimeAssure + v_Assure
            where Firmid = NeutralOrder.FirmID;
            --���¶����ʽ�
            v_F_FrozenFunds := FN_F_UpdateFrozenFunds(NeutralOrder.FirmID,v_Margin-v_Assure,'15');

            --2.3�����������ֽ��ճֲ���ϸ����
            --2.3.1���������ڳɽ���ɽ���¼
            select SEQ_T_DelayTrade.nextval into v_A_TradeNo from dual;
            insert into T_DelayTrade
              (a_tradeno,       a_orderno,         tradetime,     CustomerID,        CommodityID,            bs_flag,   DelayOrderType,  quantity,   TradeType,    Firmid)
            values
              (v_A_TradeNo,NeutralOrder.A_OrderNo, sysdate,NeutralOrder.CustomerID,  p_CommodityID,     Neutral_bs_flag,    2,    v_tradeQtySum, 1,  NeutralOrder.FirmID);
            --2.3.2�����뽻�ճֲ���ϸ��
            --���㽻�ձ�֤��
            v_SettleMargin_one := FN_T_ComputeSettleMargin(NeutralOrder.FirmID,p_CommodityID,Neutral_bs_flag,v_tradeQtySum,v_Price);
            if(v_SettleMargin_one < 0) then
                Raise_application_error(-20042, 'ComputeSettleMargin error');
            end if;
            --�����򷽽��ջ���
            if(Neutral_bs_flag = 1) then
                v_Payout_one := FN_T_ComputePayout(NeutralOrder.FirmID,p_CommodityID,Neutral_bs_flag,v_tradeQtySum,v_Price);
                if(v_Payout_one < 0) then
                    Raise_application_error(-20043, 'computePayout error');
                end if;
            end if;
            --���㽻��������
            if(v_NeutralFeeWay = 0) then
                v_Fee_one := 0;
            else
                v_Fee_one := FN_T_ComputeSettleFee(NeutralOrder.FirmID,p_CommodityID,Neutral_bs_flag,v_tradeQtySum,v_Price);
            end if;
            if(v_Fee_one < 0) then
              Raise_application_error(-20031, 'computeFee error');
            end if;
            --���ֶ������뽻�ճֲ���ϸ��
            select SEQ_T_SettleHoldPosition.nextval into v_ID from dual;
            --���ü��㺯���޸ĳֲֵ��� 2011-2-15 by feijl
            select FN_T_ComputeHoldNo(SEQ_T_HoldPosition.nextval) into v_A_HoldNo from dual;
            insert into t_settleholdposition
            (id, settleprocessdate, a_holdno, a_tradeno, customerid, commodityid, bs_flag, price, holdqty, openqty, holdtime, holdmargin, firmid, gageqty, holdassure, floatingloss, settlemargin, payout, settlefee, settle_pl, settleaddedtax, settleprice, settletype, holdtype, atcleardate)
            select v_ID,v_TradeDate,v_A_HoldNo, a_tradeno, customerid, commodityid, bs_flag, v_Price, quantity, quantity, sysdate,    0,   firmid,      0,       0,         0,      v_SettleMargin_one,v_Payout_one,v_Fee_one, 0,        0,         v_Price,       3,       2,     v_TradeDate
            from T_DelayTrade
            where a_tradeno=v_A_TradeNo;

            --2.4�����½�������ʱ��֤�𣬽ⶳ�ʽ𣬸��²ֵ�����
            for delayOrder in(select CommodityID,FirmID,BS_Flag,Quantity,TradeQty,FrozenFunds,UnfrozenFunds from T_DelayOrders where A_OrderNo=NeutralOrder.A_OrderNo)
            loop
                --�����ȫ���ɽ����ⶳ���ж����ʽ�����ǲ��ֳɽ��������ⶳ�ʽ�
                if((delayOrder.Quantity-delayOrder.TradeQty)=v_tradeQtySum) then
                    v_F_FrozenFunds := FN_F_UpdateFrozenFunds(delayOrder.FirmID,-(delayOrder.FrozenFunds-delayOrder.UnfrozenFunds),'15');
                else
                    v_F_FrozenFunds := FN_F_UpdateFrozenFunds(delayOrder.FirmID,-(delayOrder.FrozenFunds*v_tradeQtySum/delayOrder.Quantity),'15');
                end if;
                if(v_DelayNeedBill = 1) then
                    v_ret := FN_T_D_TradeBill(delayOrder.FirmID,delayOrder.CommodityID,v_tradeQtySum);
                end if;
            end loop;

            --2.5��д�����ʽ���ˮ
            for SettleHoldPosition in(select a.FirmID,a.CommodityID,sum(a.SettleMargin) SettleMargin,sum(a.Payout) Payout,sum(a.SettleFee) SettleFee,sum(a.Settle_PL) Settle_PL,sum(a.SettleAddedTax) SettleAddedTax  from T_SettleHoldPosition a where a.id=v_ID group by a.FirmID,a.CommodityID)
            loop
                --�۳����ջ�����������ѣ�������ӯ�����ս��տ���,���ձ�֤�� ����д��ˮ
                v_Balance := FN_F_UpdateFundsFull(SettleHoldPosition.FirmID,'15008',SettleHoldPosition.Payout,null,SettleHoldPosition.CommodityID,null,null);
                --ע�⣺֧��ʵʱ��Ϻ��޷�������ͽ��������ѣ���ʵ�ʽ�����������ȡ
                v_Balance := FN_F_UpdateFundsFull(SettleHoldPosition.FirmID,'15010',SettleHoldPosition.SettleFee,null,SettleHoldPosition.CommodityID,null,null);

                if(SettleHoldPosition.Settle_PL >= 0) then
                    v_Balance := FN_F_UpdateFundsFull(SettleHoldPosition.FirmID,'15011',SettleHoldPosition.Settle_PL,null,SettleHoldPosition.CommodityID,SettleHoldPosition.SettleAddedTax,null);
                else
                    v_Balance := FN_F_UpdateFundsFull(SettleHoldPosition.FirmID,'15012',-SettleHoldPosition.Settle_PL,null,SettleHoldPosition.CommodityID,-SettleHoldPosition.SettleAddedTax,null);
                end if;
                update T_Firm set RuntimeSettleMargin=RuntimeSettleMargin+SettleHoldPosition.SettleMargin where FirmID=SettleHoldPosition.FirmID;
                v_Balance := FN_F_UpdateFundsFull(SettleHoldPosition.FirmID,'15013',SettleHoldPosition.SettleMargin,null,SettleHoldPosition.CommodityID,null,null);
            end loop;
            --2.6������ί�м�¼������������һ��������Ҫ�õ�ί�е��������ʽ���Ϣ
            update T_DelayOrders
            set Status=decode(TradeQty+v_tradeQtySum,Quantity,3,2),
                TradeQty=TradeQty+v_tradeQtySum,
                UnfrozenFunds=decode(TradeQty+v_tradeQtySum,Quantity,FrozenFunds,UnfrozenFunds+(FrozenFunds*v_tradeQtySum/Quantity))
            where A_OrderNo=NeutralOrder.A_OrderNo;
        end if;

        exit when NeutralOrder.NotTradeQty > v_tradeQtySum;
    end loop;

    --3�����������Ʒ����û�д���Ʒ�����
    select count(*) into v_num from T_SettleCommodity where CommodityID=p_CommodityID;
    if(v_num = 0) then
        insert into T_SettleCommodity select v_TradeDate,a.* from T_Commodity a where a.CommodityID=p_CommodityID;
    end if;

    return 1;

end;
/

prompt
prompt Creating function FN_T_D_NEUTRALMATCH
prompt =====================================
prompt
create or replace function FN_T_D_NeutralMatch return number
/****
 * �������걨���
 * ����ֵ
 * 1 �ɹ�
 * -3  ���ճֲ��������ڿɽ��ճֲ�����
 * -4  ���յֶ��������ڿɵֶ�����
 * -99  �������������
 * -100 ��������
****/
as
    v_version varchar2(10):='1.0.2.2';
    v_ret     number(4);
    v_FL_ret            timestamp;
    v_errorcode number;
    v_errormsg  varchar2(200);
begin
    for cur_Commodity in(select CommodityID from T_Commodity where SettleWay=1 )
    loop
        v_ret := FN_T_D_NeutralMatchOne(cur_Commodity.CommodityID);
        if(v_ret < 0) then
            rollback;
            return v_ret;
        end if;
    end loop;

    --�ύ�����˽����̸����������ͷŸ���
    commit;
    v_FL_ret := FN_T_UpdateFloatingLoss(null,null,null);

    return 1;
exception
    when NO_DATA_FOUND then
        rollback;
        return -99;  --�������������
    when others then
    v_errorcode:=sqlcode;
    v_errormsg :=sqlerrm;
    rollback;
    insert into T_DBLog(err_date,name_proc,err_code,err_msg)
    values(sysdate,'FN_T_D_NeutralMatch',v_errorcode,v_errormsg);
    commit;
    return -100;
end;
/

prompt
prompt Creating function FN_T_D_UNFROZENBILL
prompt =====================================
prompt
create or replace function FN_T_D_UnFrozenBill(
    p_FirmID     varchar2,   --������ID
    p_CommodityID varchar2 ,--��ƷID
    p_UnFrozenDelayQty       number --�ⶳ��������
) return number
/****
 * �ⶳ�ֵ�����
 * ����ֵ
 * 1  �ɹ�
****/
as
	v_version varchar2(10):='1.0.2.2';
    v_WillFrozenQty    number(10);
    v_TempFrozenQty    number(10);
begin
/*
    --1���ⶳ�ֵ�
    v_WillFrozenQty := p_UnFrozenDelayQty;
    for cur_ValidBill in (select rowid,FrozenDelayQty
                      from T_ValidBill
					  where FirmID_S = p_FirmID
					      and CommodityID = p_CommodityID
					      and BillType = 5
					      and Status = 1 order by CreateTime desc
					  )
    loop
        if(cur_ValidBill.FrozenDelayQty <= v_WillFrozenQty) then
            v_TempFrozenQty := cur_ValidBill.FrozenDelayQty ;
        else
        	v_TempFrozenQty := v_WillFrozenQty ;
        end if;
        update T_ValidBill
        set FrozenDelayQty=FrozenDelayQty-v_TempFrozenQty
        where rowid=cur_ValidBill.rowid;
        v_WillFrozenQty := v_WillFrozenQty - v_TempFrozenQty;
        exit when v_WillFrozenQty=0;
    end loop;
	*/
    return 1;

end;
/

prompt
prompt Creating function FN_T_D_SELLNEUTRALORDER_WD
prompt ============================================
prompt
create or replace function FN_T_D_SellNeutralOrder_WD(
  p_FirmID     varchar2,   --������ID
  p_CustomerID     varchar2,  --���׿ͻ�ID
  p_CommodityID varchar2 ,--��ƷID
  p_Quantity       number ,--ί������
  p_TradeQty       number ,--�ѳɽ�����
  p_Price       number ,--ί�м۸���������
  p_A_OrderNo_W     number,  --����ί�е���
  p_quantity_wd       number,  --��������
  p_frozenfunds     number,  --�����ʽ�
  p_unfrozenfunds       number  --�ⶳ�ʽ�
) return number
/****
 * ��������ί�г������ú���������ִ���ύ�ͻع�����
 * ����ֵ
 * 1  �ɹ�
****/
as
  v_version varchar2(10):='1.0.0.0';
  v_Payout_B    number(15,2);   --�򷽽��ջ���
  v_SettleMargin    number(15,2);   --�򷽽��ձ�֤��
  v_to_unfrozenF   number(15,2);
  v_F_FrozenFunds   number(15,2);   --�����̶����ʽ�
  v_HoldFunds   number(15,2);   --�����̷���ֱֲ�֤��
  v_DelayNeedBill number(2);    --���ڽ����Ƿ���Ҫ�ֵ���0������Ҫ�� 1����Ҫ��
  v_ret  number(4);
begin
  --1. ���ݲ����Ƿ���Ҫ�ͷŶ���ֵ�
  select DelayNeedBill into v_DelayNeedBill from T_A_Market;
  if(v_DelayNeedBill = 1) then
	v_ret := FN_T_D_UnFrozenBill(p_FirmID,p_CommodityID,p_quantity_wd);
  end if;
  --2. �ͷ�ʣ��Ķ����ʽ𣬸���δ�ɽ�����
  if(p_Quantity - p_TradeQty = p_quantity_wd) then
    v_to_unfrozenF := p_frozenfunds - p_unfrozenfunds;
  else
    --�����ʽ�
    --���������ʽ��������ձ�֤�𣫷���ֱֲ�֤��
    --���㽻�ձ�֤��
    v_SettleMargin := FN_T_ComputeSettleMargin(p_FirmID,p_CommodityID,2,p_quantity_wd,p_Price);
    --���㷴��ֱֲ�֤��
    v_HoldFunds := FN_T_ComputeMargin(p_FirmID,p_CommodityID,1,p_quantity_wd,p_Price);
    --Ӧ�����ʽ�
    v_to_unfrozenF := v_SettleMargin + v_HoldFunds;
  end if;
  update T_DelayOrders set unfrozenfunds = unfrozenfunds + v_to_unfrozenF
  where A_orderNo = p_a_orderno_w;
  --3. ���½����̲��񶳽��ʽ�
  v_F_FrozenFunds := FN_F_UpdateFrozenFunds(p_FirmID,-v_to_unfrozenF,'15');

  return 1;
end;
/

prompt
prompt Creating function FN_T_D_SELLSETTLEORDER_WD
prompt ===========================================
prompt
create or replace function FN_T_D_SellSettleOrder_WD(
    p_FirmID     varchar2,   --������ID
    p_CustomerID     varchar2,  --���׿ͻ�ID
    p_CommodityID varchar2 ,--��ƷID
    p_Quantity       number ,--ί������
    p_TradeQty       number ,--�ѳɽ�����
    p_Price       number ,--ί�м۸���������
    p_A_OrderNo_W     number,  --����ί�е���
    p_quantity_wd       number,  --��������
    p_frozenfunds     number,  --�����ʽ�
    p_unfrozenfunds       number  --�ⶳ�ʽ�
) return number
/****
 * �������걨ί�г���
 * ����ֵ
 * 1 �ɹ�
****/
as
    v_version varchar2(10):='1.0.2.3';
	v_DelayNeedBill number(2);    --���ڽ����Ƿ���Ҫ�ֵ���0������Ҫ�� 1����Ҫ��
    v_Margin         number(15,2);   --Ӧ�ձ�֤��
    v_SettleMargin_S    number(15,2);   --�������ձ�֤��
    v_to_unfrozenF   number(15,2);
    v_F_FrozenFunds   number(15,2);   --�����̶����ʽ�
    v_MarginPriceType         number(1);     --����ɽ���֤���������� 0:ʵʱ�ͱ���ʱ�������ּۣ�1:ʵʱ�������ۣ����а����ս����
    v_LastPrice    number(15,2);   --������
    v_ret  number(4);
begin
	--1���ͷ�ʣ��Ķ���ֲ�
    update T_CustomerHoldSum set frozenQty = frozenQty - p_quantity_wd
    where CustomerID = p_CustomerID
      and CommodityID = p_CommodityID
      and bs_flag = 2;
	--2�����ݲ����Ƿ���Ҫ�ͷŶ���ֵ�
	select DelayNeedBill into v_DelayNeedBill from T_A_Market;
	if(v_DelayNeedBill = 1) then
		v_ret := FN_T_D_UnFrozenBill(p_FirmID,p_CommodityID,p_quantity_wd);
	end if;
    --<<Added by Lizs 2010/7/16 �������걨ʱ���ύ�ձ�֤�𣬳���ʱ�ⶳ
    --3���ͷ�ʣ��Ķ����ʽ𣬸���δ�ɽ�����
    if(p_Quantity - p_TradeQty = p_quantity_wd) then
        v_to_unfrozenF := p_frozenfunds - p_unfrozenfunds;
    else
        --�����ʽ��������ձ�֤��-����ռ�õĽ��ױ�֤��
        --���㽻�ձ�֤��
        v_SettleMargin_S := FN_T_ComputeSettleMargin(p_FirmID,p_CommodityID,2,p_quantity_wd,p_Price);
        --���㽻�ױ�֤��
        select MarginPriceType,LastPrice
        into v_MarginPriceType,v_LastPrice
        from T_Commodity where CommodityID=p_CommodityID;
        if(v_MarginPriceType = 1) then
            v_Margin := FN_T_ComputeMargin(p_FirmID,p_CommodityID,2,p_quantity_wd,v_LastPrice);
        else
            v_Margin := FN_T_ComputeMargin(p_FirmID,p_CommodityID,2,p_quantity_wd,p_Price);
        end if;
        if(v_Margin < 0) then
            Raise_application_error(-20040, 'computeMargin error');
        end if;
        v_to_unfrozenF := v_SettleMargin_S - v_Margin;
    end if;
    update T_DelayOrders set unfrozenfunds = unfrozenfunds + v_to_unfrozenF
    where A_orderNo = p_a_orderno_w;
    --���¶����ʽ�
    v_F_FrozenFunds := FN_F_UpdateFrozenFunds(p_FirmID,-v_to_unfrozenF,'15');
    -->>
    return 1;
end;
/

prompt
prompt Creating function FN_T_D_ORDER_WD
prompt =================================
prompt
create or replace function FN_T_D_Order_WD(
	p_WithdrawerID       varchar2,  --����ԱID
    p_A_OrderNo_W   number,             --������ί�е���
    p_WithdrawType  number,  			--�������� 1:ί�г�����4������ʱ�Զ�����
    p_Quantity      number,              --�����ɹ������������-1��ʾ�ֲ�ί�б������㳷������
	p_DelayQuoShowType       number  --����������ʾ���ͣ�0�������걨�������������걨������ʾ�� 1��ʵʱ��ʾ��
) return number
/****
 * ���ڽ���ί�г���
 * 1��������Զ������򳷵�Ա�ͳ�������Ϊnull
 * ����ֵ
 * 1 �ɹ�
 * 2 �Ѵ����
 * -99  �������������
 * -100 ��������
****/
as
    v_version varchar2(10):='1.0.2.3';
    v_a_orderno_w    number(15);
    v_status         number(2);
    v_CommodityID varchar2(16);
    v_FirmID     varchar2(32);
    v_CustomerID     varchar2(40);
    v_bs_flag        number(2);
    v_ordertype      number(2);
    v_quantity       number(10);
    v_price          number(15,2);
    v_tradeqty       number(10);
    v_frozenfunds    number(15,2);
    v_unfrozenfunds  number(15,2);
    v_quantity_wd    number(10);
    v_ret  number(4);
    v_errorcode number;
    v_errormsg  varchar2(200);
begin
    v_a_orderno_w := p_A_OrderNo_W;
    --��ȡ��������Ϣ
    select CommodityID, Firmid, bs_flag, DelayOrderType, status, quantity, price, tradeqty, frozenfunds, unfrozenfunds,CustomerID
    into v_CommodityID, v_FirmID, v_bs_flag, v_ordertype, v_status, v_quantity, v_price, v_tradeqty, v_frozenfunds, v_unfrozenfunds,v_CustomerID
    from T_DelayOrders
    where a_orderno = v_a_orderno_w for update;

    if(v_status in (3,5,6)) then
        rollback;
        return 2;  --�Ѵ����
    end if;

    if(p_WithdrawType = 4) then --�Զ�����
    	v_quantity_wd := v_quantity - v_tradeqty;
    else
    	if(p_Quantity = -1) then  ---1��ʾ�ֲ�ί�б������㳷������
    		v_quantity_wd := v_quantity - v_tradeqty;
    	else
        	v_quantity_wd := p_Quantity;
        end if;
    end if;
    if(v_ordertype=1) then    --�����걨
    	if(v_bs_flag = 1) then  --��
    		v_ret := FN_T_D_BuySettleOrder_WD(v_FirmID,v_CustomerID,v_CommodityID,v_Quantity,v_TradeQty,v_Price,v_A_OrderNo_W,v_quantity_wd,v_frozenfunds,v_unfrozenfunds);
    	else  --��
            v_ret := FN_T_D_SellSettleOrder_WD(v_FirmID,v_CustomerID,v_CommodityID,v_Quantity,v_TradeQty,v_Price,v_A_OrderNo_W,v_quantity_wd,v_frozenfunds,v_unfrozenfunds);
    	end if;
    elsif(v_ordertype=2) then    --�������걨
    	-- add by tangzy 2010-08-07
		if(v_bs_flag = 1) then
            v_ret := FN_T_D_BuyNeutralOrder_WD(v_FirmID,v_CustomerID,v_CommodityID,v_Quantity,v_TradeQty,v_Price,v_A_OrderNo_W,v_quantity_wd,v_frozenfunds,v_unfrozenfunds);
		else
		    v_ret := FN_T_D_SellNeutralOrder_WD(v_FirmID,v_CustomerID,v_CommodityID,v_Quantity,v_TradeQty,v_Price,v_A_OrderNo_W,v_quantity_wd,v_frozenfunds,v_unfrozenfunds);
		end if;
    end if;

    --����ί�У�1������ί�г�����Ҫ���±���ί�е�״̬��5��6���ͳ������ͣ�1��2��
    --        2�������Զ�������Ҫ���±���ί�е�״̬��5��6���ͳ������ͣ�3��4��
    if(p_WithdrawType = 4) then --�Զ�����
          --����ί��״̬
          if(v_tradeqty = 0) then
            v_status := 5; --ȫ������
          else
            v_status := 6; --���ֳɽ��󳷵�
          end if;
	else
        --����ί��״̬
        if(v_quantity = v_quantity_wd) then
            v_status := 5; --ȫ������
        elsif(v_quantity > v_quantity_wd) then
            v_status := 6; --���ֳɽ��󳷵�
        else
            Raise_application_error(-20020, 'Parameter p_quantity > the order ''s available num');
        end if;

    end if;
	update T_DelayOrders set status=v_status,WithdrawType=p_WithdrawType,WithdrawTime=sysdate,WithdrawerID=p_WithdrawerID where A_orderNo = v_a_orderno_w;
    --����ʵʱ��ʾ��Ҫ��������
    --2010-01-21 ����Զ�����ʱ��Ӱ����������
    if(p_WithdrawType=1 and p_DelayQuoShowType = 1) then
	    if(v_ordertype=1) then    --�����걨
	    	if(v_bs_flag = 1) then  --��
	    		update T_DelayQuotation set BuySettleQty=BuySettleQty - v_quantity_wd,CreateTime=sysdate where CommodityID = v_CommodityID;
	    	else  --��
	    		update T_DelayQuotation set SellSettleQty=SellSettleQty - v_quantity_wd,CreateTime=sysdate where CommodityID = v_CommodityID;
	    	end if;
	    elsif(v_ordertype=2) then    --�������걨
	    	-- add by tangzy 2010-08-07
			if(v_bs_flag = 1) then  --��
	    		update T_DelayQuotation set BuyNeutralQty=BuyNeutralQty - v_quantity_wd,CreateTime=sysdate where CommodityID = v_CommodityID;
	    	else  --��
	    		update T_DelayQuotation set SellNeutralQty=SellNeutralQty - v_quantity_wd,CreateTime=sysdate where CommodityID = v_CommodityID;
	    	end if;
	    end if;
    end if;

    commit;
    return 1;

exception
    when NO_DATA_FOUND then
        rollback;
        return -99;  --�������������
    when others then
    v_errorcode:=sqlcode;
    v_errormsg :=sqlerrm;
    rollback;
    insert into T_DBLog(err_date,name_proc,err_code,err_msg)
    values(sysdate,'FN_T_D_Order_WD',v_errorcode,v_errormsg);
    commit;
    return -100;
end;
/

prompt
prompt Creating function FN_T_D_SELLNEUTRALORDER
prompt =========================================
prompt
create or replace function FN_T_D_SellNeutralOrder(
  p_FirmID     varchar2,   --������ID
  p_TraderID       varchar2,  --����ԱID
  p_CommodityID varchar2 ,--��ƷID
  p_Quantity       number ,--����
  p_Price       number ,--ί�м۸���������
  p_CustomerID     varchar2,  --���׿ͻ�ID
  p_ConsignerID    varchar2,  --��Ϊί��ԱID
  p_DelayQuoShowType number, --����������ʾ���ͣ�0�������걨�������������걨������ʾ�� 1��ʵʱ��ʾ��
  p_DelayNeedBill    number  --���ڽ����Ƿ���Ҫ�ֵ���0������Ҫ�� 1����Ҫ��
) return number
/****
 * �������걨ί��
 * ����ֵ
 * >0  �ɹ��ύ��������ί�е���
 * -2  �����̿����ʽ���
 * -32 �ֵ���������
****/
as
  v_version varchar2(10):='1.0.0.0';
  v_Payout_B    number(15,2);   --�򷽽��ջ���
  v_SettleMargin    number(15,2);   --���ձ�֤��
  v_HoldFunds     number(15,2);   --����ֲֶ����ʽ�
  v_F_Funds      number(15,2):=0;   --Ӧ�����ʽ�
  v_F_FrozenFunds  number(15,2); --���񶳽��ʽ�
  v_A_Funds      number(15,2);   --�����ʽ�
  v_A_OrderNo       number(15); --ί�е���
  v_b_s_unsettleqty number(15);--�����걨������֮��Ĳ�ֵ
  v_NeutralSide number(2); --�����ַ���
  v_ret  number(4);
  v_errorcode number;
  v_errormsg  varchar2(200);
begin
  --1. ���ݲ����Ƿ���Ҫ��鲢����ֵ�
  if(p_DelayNeedBill = 1) then
	v_ret := FN_T_D_CheckAndFrozenBill(p_FirmID,p_CommodityID,p_Quantity);
	if(v_ret = -1) then
		rollback;
		return -32;  --�ֵ���������
	end if;
  end if;
  --2. ��鲢�����ʽ�
  --���������ʽ��������ձ�֤�𣫷���ֱֲ�֤��
  --���㽻�ձ�֤��
  v_SettleMargin := FN_T_ComputeSettleMargin(p_FirmID,p_CommodityID,2,p_Quantity,p_Price);
  --���㷴��ֱֲ�֤��
  v_HoldFunds := FN_T_ComputeMargin(p_FirmID,p_CommodityID,1,p_Quantity,p_Price);
  --Ӧ�����ʽ�
  v_F_Funds := v_SettleMargin + v_HoldFunds;
  --��������ʽ𣬲���ס�����ʽ�
  v_A_Funds := FN_F_GetRealFunds(p_FirmID,1);
  if (v_F_Funds>v_A_Funds) then
    rollback;
    return -2; --�����ʽ���
  end if;
  --3. ���¶����ʽ�
  v_F_FrozenFunds := FN_F_UpdateFrozenFunds(p_FirmID,v_F_Funds,'15');
  --4. ��������ί�б�������ί�е���
  select SEQ_T_DelayOrders.nextval into v_A_OrderNo from dual;
  insert into T_DelayOrders
    ( a_orderno,    CommodityID,   CustomerID,    traderid,   bs_flag, DelayOrderType, status, quantity, price, tradeqty, frozenfunds, unfrozenfunds, ordertime, withdrawtime, ordererip, signature,  FirmID ,ConsignerID)
  values
    (v_A_OrderNo,  p_CommodityID, p_CustomerID,  p_TraderID,         2,           2,         1,p_Quantity, p_Price,  0,     v_F_Funds,       0,         sysdate,      null,       null,     null,     p_FirmID ,p_ConsignerID);

  --5. ����ʵʱ��ʾ��Ҫ��������
  if(p_DelayQuoShowType = 1) then
    update T_DelayQuotation set SellNeutralQty=nvl(SellNeutralQty,0) + p_Quantity,CreateTime=sysdate where CommodityID = p_CommodityID;
  end if;

  commit;
  return v_A_OrderNo;
exception
  when NO_DATA_FOUND then
    rollback;
    return -99;  --�������������
  when others then
  v_errorcode:=sqlcode;
  v_errormsg :=sqlerrm;
  rollback;
  insert into T_DBLog(err_date,name_proc,err_code,err_msg)
  values(sysdate,'FN_T_D_SellNeutralOrder',v_errorcode,v_errormsg);
  commit;
  return -100;
end;
/

prompt
prompt Creating function FN_T_D_SELLSETTLEORDER
prompt ========================================
prompt
create or replace function FN_T_D_SellSettleOrder(
    p_FirmID     varchar2,   --������ID
    p_TraderID       varchar2,  --����ԱID
    p_CommodityID varchar2 ,--��ƷID
    p_Quantity       number ,--����
    p_Price       number ,--ί�м۸���������
  p_CustomerID     varchar2,  --���׿ͻ�ID
  p_ConsignerID       varchar2,  --��Ϊί��ԱID
  p_DelayQuoShowType       number,  --����������ʾ���ͣ�0�������걨�������������걨������ʾ�� 1��ʵʱ��ʾ��
  p_DelayNeedBill       number  --���ڽ����Ƿ���Ҫ�ֵ���0������Ҫ�� 1����Ҫ��
) return number
/****
 * �������걨ί��
 * ���������޸��걨�����жϣ��þ����������ǵ����ֲܳ��ж� by chenxc 2011-09-20
 * ����ֵ
 * >0  �ɹ��ύ��������ί�е���
 * -2  �ʽ�����
 * -31  �ֲֲ���
 * -32  �ֵ���������
 * -99  �������������
 * -100 ��������
****/
as
    v_version varchar2(10):='1.0.2.3';
    v_HoldSum        number(10):=0;   --�����ֲֺϼ�����
    v_SettleMargin_S    number(15,2);   --�������ձ�֤��
    v_SettleMargin_SSum    number(15,2):=0;   --�������ձ�֤�����
    v_TradeMargin_S    number(15,2);   --�������ױ�֤��
    v_TradeMargin_SSum    number(15,2):=0;   --�������ױ�֤�����
    v_F_Funds      number(15,2):=0;   --Ӧ�����ʽ�
    v_A_Funds      number(15,2);   --�����ʽ�
    v_F_FrozenFunds  number(15,2); --���񶳽��ʽ�
    v_ret  number(4);
    v_A_OrderNo       number(15); --ί�е���
    v_HoldOrderNo  number(15):=0;--�ֲ�ί�е���
    v_errorcode number;
    v_errormsg  varchar2(200);
    v_DelayOrderIsPure        number(1);   --�����걨�Ƿ񰴾��������걨
  v_HoldSum_S        number(10):=0;   --�����ֲֺϼ�����
  v_DelaySettlePriceType         number(10);   --�����걨�������� 0��������۽����걨 �� 1���������۽���  -- add  by zhangjian
   v_sql varchar2(500);
   v_qtySum number(15):=0;  --��ί�еĽ����걨��������
   v_price number(15,6);-- �����걨�۸�
   v_theOrderPriceSum number(15,6):=0;-- ���ν����걨�����۸����
   v_holdQty number(15):=0;--ÿ�ʳֲ���ϸ�еĳֲ�����
   v_tempQty number(15):=0;--�м����
    v_alreadyQty number(15):=0;--����ί���Ѷ�������
  type cur_T_HoldPosition is ref cursor;
  v_HoldPosition cur_T_HoldPosition;
  v_orderLogNo number(15):=0;--ί���µ���־ ID��
  v_orderSumLogNo number(15):=0;--ί���µ���־�ϼ����� ID��
  v_HoldSum_B number;
begin
  --1�����ֲֲ�����ֲ�
  begin
      select nvl(holdQty - frozenQty, 0) into v_HoldSum
      from T_CustomerHoldSum
      where CustomerID = p_CustomerID
        and CommodityID = p_CommodityID
        and bs_flag = 2 for update;
  exception
        when NO_DATA_FOUND then
            rollback;
           return -31;  --�ֲֲ���
    end;
    --���������޸��걨�����жϣ��þ����������ǵ����ֲܳ��ж� by chenxc 2011-09-20
    --�����걨�Ƿ񰴾��������걨
  select DelayOrderIsPure into v_DelayOrderIsPure from T_A_Market;
  if(v_DelayOrderIsPure = 1) then --�����������걨
      begin
        select holdQty+GageQty into v_HoldSum_B
        from T_CustomerHoldSum
        where CustomerID = p_CustomerID
          and CommodityID = p_CommodityID
          and bs_flag = 1 ;
    exception
          when NO_DATA_FOUND then
              v_HoldSum_S := 0;
      end;
      if(v_HoldSum-v_HoldSum_B < p_Quantity) then
          rollback;
          return -31;  --������������
      end if;
  else
      if(v_HoldSum < p_Quantity) then
          rollback;
          return -31;  --�ֲֲ���
      end if;
    end if;
    --<<Added by Lizs 2010/7/15 �������걨ʱ���Ӷ��ύ�ձ�֤��
    --2����鲢�����ʽ𣺶����������ձ�֤��-����ռ�õĽ��ױ�֤��
     --���ݽ����걨�۸����� �ж���ζ����ʽ�0��������۽��� ��1���������۽���  mod by zhangjian
    select   DelaySettlePriceType into v_DelaySettlePriceType from t_commodity where commodityid=p_CommodityID;
    if(v_DelaySettlePriceType=1) then -- ����ǰ������۽���

      select nvl(sum(Quantity-TradeQty),0) into v_qtySum from T_DelayOrders where  commodityid=p_CommodityID and customerid=p_CustomerID   and status in (1,2) and bs_flag=2;
     -- select sum(quantity) into   v_aheadSettleQty from T_E_ApplyAheadSettle;
     -- v_qtySum:=v_qtySum+v_aheadSettleQty;--�Ѿ����������

    v_sql:='select price,HoldQty,a.A_HoldNo   from T_holdposition a,(select A_HoldNo from T_SpecFrozenHold group by A_HoldNo) b
                 where (a.HoldQty+a.GageQty) > 0 and a.A_HoldNo=b.A_HoldNo(+) and CustomerID='''||  p_CustomerID||'''
                   and CommodityID ='''|| p_CommodityID||''' and bs_flag =  2   '||' order by a.A_HoldNo';
     open v_HoldPosition for v_sql;
        loop
            fetch v_HoldPosition into v_price,v_holdQty,v_HoldOrderNo;
            exit when v_HoldPosition%NOTFOUND;
            v_HoldSum_S:=v_HoldSum_S+v_holdQty;
            v_tempQty:=0; --ÿ����ձ�������
            if(v_HoldSum_S>v_qtySum)then --���㽻�ջ����Լ����ձ�֤���ۻ��������Ǵ��ڵ�ǰ����ί�б����Ѿ����ڵġ�
            if(p_Quantity>=(v_HoldSum_S-v_qtySum))then
            v_tempQty:=v_HoldSum_S-v_qtySum-v_alreadyQty;--��ǰ���������
            v_alreadyQty:=v_tempQty+v_alreadyQty;
            else  --��������㵱ǰ�������˳�����
            v_tempQty:=p_Quantity-v_alreadyQty;
            v_HoldSum_S:=0;
             end if;
            end if;

           --���㽻�ױ�֤��
              v_TradeMargin_S := FN_T_ComputeMargin(p_FirmID,p_CommodityID,2,v_tempQty,v_price);
            --���㽻�ձ�֤��
              v_SettleMargin_S := FN_T_ComputeSettleMargin(p_FirmID,p_CommodityID,2,v_tempQty,v_price);

               v_TradeMargin_SSum :=v_TradeMargin_SSum+v_TradeMargin_S;--�ۼӽ��ױ�֤��
              v_SettleMargin_SSum :=v_SettleMargin_SSum+v_SettleMargin_S;--�ۼӽ��ձ�֤��
              v_theOrderPriceSum :=v_theOrderPriceSum+v_price*v_tempQty;--�ۼӶ����۸�


                --ѭ��ÿ�ʳֲ���ϸ��Ҫ����ί����־  add by zhangjian 2012��3��2��
                   select SEQ_T_D_OrderLog.nextval into v_orderLogNo  from dual  ;
             insert into T_D_DelayOrderLog  values (v_orderLogNo,p_firmid,2,p_CommodityID,v_HoldOrderNo,v_price,v_tempQty,v_SettleMargin_S,v_TradeMargin_S,0,Sysdate,null );

               if(v_HoldSum_S=0)then
                   v_price:=v_theOrderPriceSum/p_Quantity;--����˳�ѭ�������ƽ�������۸�
                   exit;
               end if;

            end loop;

   elsif(v_DelaySettlePriceType=0)then --����ǰ�����۽���
    v_price:=p_Price;
    --���㽻�ױ�֤��
    v_TradeMargin_S := FN_T_ComputeMargin(p_FirmID,p_CommodityID,2,p_Quantity,v_price);
    --���㽻�ձ�֤��
    v_SettleMargin_S := FN_T_ComputeSettleMargin(p_FirmID,p_CommodityID,2,p_Quantity,v_price);
              v_TradeMargin_SSum :=v_TradeMargin_S;
              v_SettleMargin_SSum :=v_SettleMargin_S;
  end if;
    --���㽻�ձ�֤��
    --v_SettleMargin_S := FN_T_ComputeSettleMargin(p_FirmID,p_CommodityID,2,p_Quantity,p_Price);
    --���㽻�ױ�֤��
    --v_TradeMargin_S := FN_T_ComputeMargin(p_FirmID,p_CommodityID,2,p_Quantity,p_Price);
    --Ӧ�����ʽ�

    v_F_Funds := v_SettleMargin_SSum - v_TradeMargin_SSum;
    --��������ʽ𣬲���ס�����ʽ�
    v_A_Funds := FN_F_GetRealFunds(p_FirmID,1);

       --��������ί�кϼƱ���־   --add by zhangjian  2012��3��2��
    select SEQ_T_D_OrderSumLog.nextval  into v_orderSumLogNo from dual;
    insert into  T_D_DelayOrderSumLog values (v_orderSumLogNo,p_firmid,2,p_CommodityID,v_price,p_Quantity,v_SettleMargin_SSum,v_TradeMargin_SSum,0,v_A_Funds,v_F_Funds,Sysdate,null);


    if(v_A_Funds < v_F_Funds) then
        rollback;
        return -2;  --�ʽ�����
    end if;
    --3�����½��׿ͻ��ֲֺϼƵĶ�������
    update T_CustomerHoldSum set frozenQty = frozenQty + p_Quantity
    where CustomerID = p_CustomerID
    and CommodityID = p_CommodityID
    and bs_flag = 2;
    --4�����ݲ����Ƿ���Ҫ��鲢����ֵ�
    if(p_DelayNeedBill = 1) then
    v_ret := FN_T_D_CheckAndFrozenBill(p_FirmID,p_CommodityID,p_Quantity);
    if(v_ret = -1) then
          rollback;
          return -32;  --�ֵ���������
      end if;
  end if;
    --5�����¶����ʽ�
    v_F_FrozenFunds := FN_F_UpdateFrozenFunds(p_FirmID,v_F_Funds,'15');
    -->>======================================================================
    --6����������ί�б�������ί�е���
    select SEQ_T_DelayOrders.nextval into v_A_OrderNo from dual;
    insert into T_DelayOrders
      ( a_orderno,    CommodityID,   CustomerID,    traderid,   bs_flag, DelayOrderType, status, quantity, price, tradeqty, frozenfunds, unfrozenfunds, ordertime, withdrawtime, ordererip, signature,  FirmID ,ConsignerID)
    values
      (v_A_OrderNo,  p_CommodityID, p_CustomerID,  p_TraderID,     2,           1,          1,  p_Quantity, v_price,  0,      v_F_Funds,         0,         sysdate,      null,       null,     null,     p_FirmID ,p_ConsignerID);

    --����ʵʱ��ʾ��Ҫ��������
    if(p_DelayQuoShowType = 1) then
      update T_DelayQuotation set SellSettleQty=SellSettleQty + p_Quantity,CreateTime=sysdate where CommodityID = p_CommodityID;
    end if;

    commit;
    return v_A_OrderNo;
exception
    when NO_DATA_FOUND then
        rollback;
        return -99;  --�������������
    when others then
    v_errorcode:=sqlcode;
    v_errormsg :=sqlerrm;
    rollback;
    insert into T_DBLog(err_date,name_proc,err_code,err_msg)
    values(sysdate,'FN_T_D_SellSettleOrder',v_errorcode,v_errormsg);
    commit;
    return -100;
end;
/

prompt
prompt Creating function FN_T_D_SETTLEMATCHONE
prompt =======================================
prompt
create or replace function FN_T_D_SettleMatchOne
(
  p_CommodityID varchar2 --��Ʒ����
)  return number
/****
 * ĳ��Ʒ�����걨���
 * ����ֵ
 * 1 �ɹ�
 * -1  �򷽳ɽ���������
 * -3  ���ճֲ��������ڿɽ��ճֲ�����
 * -4  ���յֶ��������ڿɵֶ�����
****/
as
	v_version varchar2(10):='1.0.2.2';
    v_ret     number(4);
    v_OrderTradeQty      number(10):=0;
    v_TradeDate     date;
    v_Balance    number(15,2):=0;
    v_UnfrozenFunds   number(15,2);
    v_F_FrozenFunds   number(15,2);
    v_Status            number(2);
    v_num            number(10);
    v_DelayNeedBill number(2);    --���ڽ����Ƿ���Ҫ�ֵ���0������Ҫ�� 1����Ҫ��
    v_tradedAmount   number(10):=0;  --�ɽ�����
    v_unCloseQty     number(10); --δƽ�����������м����
    v_NeutralMatchPriority   number(2); --�����ַ���ֲ��Ƿ����ȴ��,0:�����ȣ�1������
begin
	--1�����������Ʒ����û�д���Ʒ�����
    select count(*) into v_num from T_SettleCommodity where CommodityID=p_CommodityID;
	if(v_num = 0) then
		select TradeDate into v_TradeDate from T_SystemStatus;
		insert into T_SettleCommodity select v_TradeDate,a.* from T_Commodity a where a.CommodityID=p_CommodityID;
	end if;
    select DelayNeedBill into v_DelayNeedBill from T_A_Market;
    select NEUTRALMATCHPriority into v_NeutralMatchPriority from t_a_market;
    --2����ѯ��ί�м�¼�������ַ���ֲ����ȴ��ʱ�з���ֲֵĻ�Աί���������򣬲�����ʱֻ��ί�к�����
    --for delayOrder_B in(select A_OrderNo,CommodityID,CustomerID,BS_Flag,(Quantity-TradeQty) NotTradeQty,Price,FrozenFunds,UnfrozenFunds,Quantity,FirmID from T_DelayOrders where DelayOrderType=1 and Status in(1,2) and BS_Flag=1 and CommodityID=p_CommodityID order by A_OrderNo for update)
    for delayOrder_B in(select A_OrderNo,CommodityID,CustomerID,BS_Flag,(Quantity-TradeQty) NotTradeQty,Price,FrozenFunds,UnfrozenFunds,Quantity,FirmID from T_DelayOrders,(select distinct(t.FirmID) as FID,1 as OrderType from T_HoldPosition t where t.BS_Flag=1 and t.HoldType=decode(v_NeutralMatchPriority,1,2,0) and t.CommodityID=p_CommodityID) hp where DelayOrderType=1 and Status in(1,2) and BS_Flag=1 and CommodityID=p_CommodityID and firmid=hp.FID(+) order by nvl(hp.OrderType,0) desc,A_OrderNo for update of A_OrderNo)
    loop
    	v_unCloseQty := delayOrder_B.NotTradeQty;
    	--��ѯ��ί�м�¼���ɽ�����ί�е�����
      --for delayOrder_S in(select A_OrderNo,CommodityID,CustomerID,BS_Flag,(Quantity-TradeQty) NotTradeQty,Price,FrozenFunds,UnfrozenFunds,Quantity,FirmID from T_DelayOrders where DelayOrderType=1 and Status in(1,2) and BS_Flag=2 and CommodityID=p_CommodityID order by A_OrderNo for update)
      for delayOrder_S in(select A_OrderNo,CommodityID,CustomerID,BS_Flag,(Quantity-TradeQty) NotTradeQty,Price,FrozenFunds,UnfrozenFunds,Quantity,FirmID from T_DelayOrders,(select distinct(t.FirmID) as FID,1 as OrderType from T_HoldPosition t where t.BS_Flag=2 and t.HoldType=decode(v_NeutralMatchPriority,1,2,0) and t.CommodityID=p_CommodityID) hp where DelayOrderType=1 and Status in(1,2) and BS_Flag=2 and CommodityID=p_CommodityID and firmid=hp.FID(+) order by nvl(hp.OrderType,0) desc,A_OrderNo for update of A_OrderNo)
    	loop
    		if(delayOrder_S.NotTradeQty <= v_unCloseQty) then  --ȫ���ɽ�
    			v_tradedAmount:=delayOrder_S.NotTradeQty;
    			v_Status := 3;
    			v_UnfrozenFunds:=delayOrder_S.FrozenFunds-delayOrder_S.UnfrozenFunds;
            else  --���ֳɽ�
                v_tradedAmount:=v_unCloseQty;
                v_Status := 2;
    			v_UnfrozenFunds:=delayOrder_S.FrozenFunds*v_tradedAmount/delayOrder_S.Quantity;
    		end if;
	    	update T_DelayOrders set Status=v_Status,TradeQty=TradeQty+v_tradedAmount,UnfrozenFunds=UnfrozenFunds+v_UnfrozenFunds where A_OrderNo=delayOrder_S.A_OrderNo;
	        --���¶����ʽ�
			v_F_FrozenFunds := FN_F_UpdateFrozenFunds(delayOrder_S.FirmID,-v_UnfrozenFunds,'15');
    		if(v_DelayNeedBill = 1) then
    			v_ret := FN_T_D_TradeBill(delayOrder_S.FirmID,delayOrder_S.CommodityID,v_tradedAmount);
    		end if;
    		--�����ֲֽ��գ��漰�ֲ���ϸ���ֲֺϼƣ��ʽ�
	    	v_ret := FN_T_D_SettleOne(delayOrder_S.CommodityID,delayOrder_S.Price,delayOrder_S.BS_Flag,delayOrder_S.CustomerID,v_tradedAmount,0);
	    	if(v_ret < 0) then
	    		rollback;
	        	return v_ret;
	    	end if;
    		v_unCloseQty:=v_unCloseQty - v_tradedAmount;
    		exit when v_unCloseQty=0;
    	end loop;
    	v_OrderTradeQty := delayOrder_B.NotTradeQty-v_unCloseQty;
    	if(v_unCloseQty = 0) then  --ȫ���ɽ�
    		v_Status := 3;
    		v_UnfrozenFunds:=delayOrder_B.FrozenFunds-delayOrder_B.UnfrozenFunds;
    	elsif(v_unCloseQty > 0 and v_unCloseQty < delayOrder_B.NotTradeQty) then  --���ֳɽ�
    		v_Status := 2;
    		v_UnfrozenFunds:=delayOrder_B.FrozenFunds*v_OrderTradeQty/delayOrder_B.Quantity;
    	elsif(v_unCloseQty = delayOrder_B.NotTradeQty) then  --��������Լ�¼���ɹ�����
    		return 1;
    	else  --����ع���Ҫ��������Ϊ������
    		rollback;
	        return -1;
    	end if;
    	update T_DelayOrders set Status=v_Status,TradeQty=TradeQty+v_OrderTradeQty,UnfrozenFunds=UnfrozenFunds+v_UnfrozenFunds where A_OrderNo=delayOrder_B.A_OrderNo;
        --���¶����ʽ�
		v_F_FrozenFunds := FN_F_UpdateFrozenFunds(delayOrder_B.FirmID,-v_UnfrozenFunds,'15');
		--�򷽳ֲֽ��գ��漰�ֲ���ϸ���ֲֺϼƣ��ʽ�
    	v_ret := FN_T_D_SettleOne(delayOrder_B.CommodityID,delayOrder_B.Price,delayOrder_B.BS_Flag,delayOrder_B.CustomerID,v_OrderTradeQty,0);
    	if(v_ret < 0) then
    		rollback;
        	return v_ret;
    	end if;
    end loop;

    return 1;

end;
/

prompt
prompt Creating function FN_T_D_SETTLEMATCH
prompt ====================================
prompt
create or replace function FN_T_D_SettleMatch return number
/****
 * �����걨���
 * ����ֵ
 * 1 �ɹ�
 * -1  �򷽳ɽ���������
 * -3  ���ճֲ��������ڿɽ��ճֲ�����
 * -4  ���յֶ��������ڿɵֶ�����
 * -99  �������������
 * -100 ��������
****/
as
	v_version varchar2(10):='1.0.2.2';
    v_ret     number(4);
    v_FL_ret            timestamp;
    v_errorcode number;
    v_errormsg  varchar2(200);
begin
    for cur_Commodity in(select CommodityID from T_Commodity where SettleWay=1 )
    loop
    	v_ret := FN_T_D_SettleMatchOne(cur_Commodity.CommodityID);
    	if(v_ret < 0) then
    		rollback;
        	return v_ret;
    	end if;
    end loop;

    --�ύ�����˽����̸����������ͷŸ���
    commit;
    v_FL_ret := FN_T_UpdateFloatingLoss(null,null,null);

    return 1;
exception
    when NO_DATA_FOUND then
        rollback;
        return -99;  --�������������
    when others then
    v_errorcode:=sqlcode;
    v_errormsg :=sqlerrm;
    rollback;
    insert into T_DBLog(err_date,name_proc,err_code,err_msg)
    values(sysdate,'FN_T_D_SettleMatch',v_errorcode,v_errormsg);
    commit;
    return -100;
end;
/

prompt
prompt Creating function FN_T_FIRMADD
prompt ==============================
prompt
create or replace function FN_T_FirmAdd
(
    p_FirmID m_firm.firmid%type --�����̴���
)return integer is
  /**
  * ����ϵͳ��ӽ�����
  * ����ֵ�� 1 �ɹ�
  ע�ⲻҪ�ύcommit����Ϊ��ĺ���Ҫ��������
  **/
  v_cnt                number(5); --���ֱ���
begin
  --1�����뽻���̱�Ĭ������״̬
    select count(*) into v_cnt from T_Firm where firmid=p_firmid;
    if(v_cnt=0) then
        insert into T_Firm(FirmID,Status,ModifyTime) values(p_FirmID,0,sysdate);
    end if;
    --2������һ��Ĭ�Ͻ�����ID+00С�ŵĿͻ����ͻ���
    select count(*) into v_cnt from T_Customer where CustomerID=p_firmid||'00';
    if(v_cnt=0) then
        insert into T_Customer(CustomerID, FirmID,  Code,Status,CreateTime,ModifyTime)
        values( p_FirmID||'00', p_FirmID ,'00', 0, sysdate, sysdate);
    end if;

    return 1;
end;
/

prompt
prompt Creating function FN_T_FIRMDEL
prompt ==============================
prompt
create or replace function FN_T_FirmDel
(
    p_FirmID m_firm.firmid%type --�����̴���
)return integer is
  /**
  * ����ϵͳɾ��������
  * ����ֵ�� 1 �ɹ�
  ע�ⲻҪ�ύcommit����Ϊ��ĺ���Ҫ��������
  **/
  v_cnt                number(5); --���ֱ���
begin
  /*---mengyu 2013.08.29  ע�����ײ���ɾ���������ݱ�������*/
  /*  --2��ɾ�����������Ᵽ֤���˽����̼�¼����ʷ��¼���½�����ID����_
  update T_H_FirmMargin set FirmID=FirmID || '_' where FirmID=p_FirmID;
    delete from T_A_FirmMargin where FirmID=p_FirmID;
    --3��ɾ�����������������ѱ�˽����̼�¼����ʷ��¼���½�����ID����_
    update T_H_FirmFee set FirmID=FirmID || '_' where FirmID=p_FirmID;
    delete from T_A_FirmFee where FirmID=p_FirmID;
    --4��ɾ������ֲ�����˽����̼�¼
    delete from T_A_FirmMaxHoldQty where FirmID=p_FirmID;
    --5��ɾ��ί�б�˽����̼�¼����ʷ��¼���½�����ID����_
    update T_H_Orders set FirmID=FirmID || '_' where FirmID=p_FirmID;
    delete from T_Orders where FirmID=p_FirmID;
    --6��ɾ���ɽ���˽����̼�¼����ʷ��¼���½�����ID����_
    update T_H_Trade set FirmID=FirmID || '_' where FirmID=p_FirmID;
    delete from T_Trade where FirmID=p_FirmID;
    --7��ɾ���ֲ���ϸ���д˽����̼�¼����ʷ��¼���½�����ID����_
    update T_H_HoldPosition set FirmID=FirmID || '_' where FirmID=p_FirmID;
    delete from T_HoldPosition where FirmID=p_FirmID;
    --8��ɾ�����׿ͻ��ֲֺϼƱ�˽����̼�¼����ʷ��¼���½�����ID����_
    update T_H_CustomerHoldSum set FirmID=FirmID || '_' where FirmID=p_FirmID;
    delete from T_CustomerHoldSum where FirmID=p_FirmID;
    --9��ɾ�������ֲֺ̳ϼƱ�˽����̼�¼����ʷ��¼���½�����ID����_
    update T_H_FirmHoldSum set FirmID=FirmID || '_' where FirmID=p_FirmID;
    delete from T_FirmHoldSum where FirmID=p_FirmID;
    --11�����½��ս��׿ͻ��ֲֺϼƱ�˽����̼�¼��������ID����_
    update T_SettleHoldPosition set FirmID=FirmID || '_' where FirmID=p_FirmID;
    --14��ɾ������Ա��˽����̼�¼
    delete from T_Trader where TraderID in(select TraderID from M_Trader where FirmID=p_FirmID);
    --15��ɾ�����׿ͻ���˽����̼�¼
    delete from T_Customer where FirmID=p_FirmID;
    --16��ɾ�������̱�˽����̣���ʷ��¼���½�����ID����_
    update T_H_Firm set FirmID=FirmID || '_' where FirmID=p_FirmID;
    delete from T_Firm where FirmID=p_FirmID;
    */
    return 1;

end;
/

prompt
prompt Creating function FN_T_FIRMEXITCHECK
prompt ====================================
prompt
CREATE OR REPLACE FUNCTION FN_T_FirmExitCheck
(
    p_FirmID in varchar2       --������ID
) RETURN NUMBER
/****
 * ���������м��
 * 1��ע�ⲻҪ�ύcommit����Ϊ��ĺ���Ҫ��������
 * ����ֵ
 * 1 �ɹ�
 * -1���˽����̴��ڳֲ֣��������У�
****/
as
	v_version varchar2(10):='1.0.0.1';
    v_num   number(10);
begin
    --1����齻�����Ƿ���ڳֲ�
    select nvl(sum(HoldQty+GageQty),0) into v_num from T_FirmHoldSum where FirmID=p_FirmID;
    if(v_num > 0) then
        return -1;
    end if;

    return 1;
end;
/

prompt
prompt Creating function FN_T_GAGECLOSEORDER
prompt =====================================
prompt
create or replace function FN_T_GageCloseOrder(
    p_FirmID         varchar2,   --������ID
    p_TraderID       varchar2,  --����ԱID
    p_CommodityID    varchar2 default null,
    p_bs_flag        number default null,
    p_price          number default null,
    p_quantity       number default null,
    p_closeMode      number default null,
    p_specPrice      number default null,
    p_timeFlag       number default null,
    p_closeFlag      number default null,   --ƽ�ֱ�־
	  p_CustomerID     varchar2,  --���׿ͻ�ID
	  p_ConsignerID    varchar2  --ί��ԱID
) return number
/****
 * �ֶ�ת��ί�� add by yukx 20100424
 * ����ֵ
 * >0  �ɹ��ύ��������ί�е���
 * -21  �ֲֲ���
 * -22  ָ���ֲ���
 * -99  �������������
 * -100 ��������
****/
as
	v_version varchar2(10):='1.0.3.x';
  v_HoldSum        number(10);
    v_A_OrderNo      number(15);   --ί�к�
    v_errorcode number;
    v_errormsg  varchar2(200);
begin
	--1��֤����
	begin
	    select nvl(GageQty - GageFrozenQty, 0) into v_HoldSum
	    from T_CustomerHoldSum
	    where CustomerID = p_CustomerID
	      and CommodityID = p_CommodityID
	      and bs_flag != p_bs_flag for update;
    exception
        when NO_DATA_FOUND then
	        rollback;
	        return -21;  --�ֲֲ���
    end;
    if(v_HoldSum < p_quantity) then
        rollback;
        return -21;  --�ֲֲ���
    end if;

    --2�ͻ��ֲֺϼƵֶ�������������
    update T_CustomerHoldSum set GageFrozenQty = GageFrozenQty+p_quantity
           where CustomerID = p_CustomerID and CommodityID = p_CommodityID and BS_Flag != p_bs_flag;

    commit;

     --3������ί�е��Ų�����ί�б�
	--���ü��㺯���޸�ί�е��� 2011-2-15 by feijl
    select FN_T_ComputeOrderNo(SEQ_T_Orders.nextval) into v_A_OrderNo from dual;
    insert into T_Orders
      ( a_orderno,  a_orderno_w,   CommodityID,   Firmid,    traderid,   bs_flag,   ordertype, status, quantity, price, closemode, specprice,       timeflag,tradeqty, frozenfunds, unfrozenfunds, ordertime, withdrawtime, ordererip, signature,closeFlag,   CustomerID,ConsignerID,BillTradeType)
    values
      (v_A_OrderNo,   null,        p_CommodityID, p_Firmid,  p_traderid, p_bs_flag,     2,        1,  p_quantity, p_price, p_closemode, p_specprice, p_timeflag, 0,        0,              0,         sysdate,      null,       null,     null,  p_closeFlag,p_CustomerID,p_ConsignerID,2);

    return v_A_OrderNo;

exception
    when NO_DATA_FOUND then
        rollback;
        return -99;  --�������������
    when others then
    v_errorcode:=sqlcode;
    v_errormsg :=sqlerrm;
    rollback;
    insert into T_DBLog(err_date,name_proc,err_code,err_msg)
    values(sysdate,'FN_T_GageCloseOrder',v_errorcode,v_errormsg);
    commit;
    return -100;
end;
/

prompt
prompt Creating function FN_T_GAGECLOSETRADE
prompt =====================================
prompt
create or replace function FN_T_GageCloseTrade(
    p_A_OrderNo     number,  --ί�е���
    p_M_TradeNo     number,  --��ϳɽ���
    p_Price         number,  --�ɽ���
    p_Quantity      number,   --�ɽ�����
  p_M_TradeNo_Opp     number,  --�Է���ϳɽ���
    p_CommodityID varchar2,
    p_FirmID     varchar2,
    p_TraderID       varchar2,
    p_bs_flag        number,
    p_status         number,
    p_orderQty       number,--ί������
    p_orderTradeQty       number,--ί���ѳɽ�����
    p_CustomerID        varchar2,
    p_OrderType      number,
    p_closeMode      number,
    p_specPrice      number,
    p_timeFlag       number,
    p_CloseFlag      number,
    p_contractFactor number,
  p_MarginPriceType         number,     --����ɽ���֤���������� 0:ʵʱ�ͱ���ʱ�������ּۣ�1:ʵʱ�������ۣ����а����ս����;2:���а������ۣ����н���ʱ�����ս����;
    p_marginAlgr         number,
    p_marginRate_b         number,
    p_marginRate_s         number,
    p_marginAssure_b         number,
    p_marginAssure_s         number,
    p_feeAlgr       number,
    p_feeRate_b         number,
    p_feeRate_s         number,
    p_TodayCloseFeeRate_B         number,
    p_TodayCloseFeeRate_S         number,
    p_HistoryCloseFeeRate_B         number,
    p_HistoryCloseFeeRate_S         number,
    p_ForceCloseFeeAlgr       number,
    p_ForceCloseFeeRate_B         number,
    p_ForceCloseFeeRate_S         number,
    p_YesterBalancePrice    number,
  p_AddedTaxFactor          number,  --��ֵ˰��ϵ��=AddedTax/(1+AddedTax)
  p_GageMode    number,
  p_CloseAlgr    number,
  p_TradeDate date,
  p_FirmID_opp     varchar2
) return number
/****
 * �ֶ�ת�óɽ��ر� ��ƽ�ֳɽ� ָ��ƽ����ؾ���ȥ��  mod by yukx 20100427
 * 1��ע�ⲻҪ�ύcommit����Ϊ��ĺ���Ҫ��������
 * ����ֵ
 * 1 �ɹ�
 * -1 �ɽ���������δ�ɽ�����
 * -2 �ɽ��������ڶ�������
 * -3 ƽ�ֳɽ��������ڳֲ�����
 * -100 ��������
****/
as
  v_version varchar2(10):='1.0.3.x';
    v_price          number(15,2);
    v_frozenQty      number(10);
    v_holdQty        number(10);
    v_a_tradeno_closed number(15);
    v_Margin         number(15,2):=0;   --Ӧ�ձ�֤��
  v_Assure         number(15,2):=0;   --Ӧ�յ�����
  v_Fee            number(15,2):=0;   --Ӧ�շ���
    v_Fee_one            number(15,2);   --Ӧ�շ���
    v_A_TradeNo      number(15);
    v_A_HoldNo       number(15);
    v_id             number(15);
    v_tmp_bs_flag    number(2);
    v_TradeType      number(1);
    v_AtClearDate          date;
    v_HoldTime          date;
    v_MarginPrice    number(15,2);  --����ɽ���֤��ļ۸�
  v_HoldFunds    number(15,2):=0;  --ƽ��ʱӦ�˳ֲֽ��
    v_unCloseQty     number(10):=p_quantity; --δƽ�����������м����
  v_closeFL    number(15,2):=0;
    v_closeFL_one    number(15,2);   --����ƽ��ӯ���������м����
  v_CloseAddedTax_one    number(15,2);   --����ƽ����ֵ˰
    v_margin_one     number(15,2);   --�����м����
  v_Assure_one     number(15,2);   --�����м����
    v_tradedAmount   number(10):=0;  --�ɽ�����
  v_GageQty       number(10);
  v_GageQty_fsum       number(10);
  v_F_FrozenFunds   number(15,2);
  type c_T_HoldPosition is ref cursor;
  v_T_HoldPosition c_T_HoldPosition;
  v_sql varchar2(500);
  v_str  varchar2(200);
  v_orderby  varchar2(100);
  v_firmHoldfunds number(15,2);--add by yukx 20100428 �����ֲֽ̳��
  v_closeTodayHis        number(2);    --ƽ��ֻ�����ʷ��(0ƽ��֣�1ƽ��ʷ��)
  v_num            number(10);
        v_holddaysLimit number(1):=0;
begin
      --�ɽ����ͣ��ֶ�ת��  mod by yukx 20100427
      v_TradeType := 8;
      /*-- mod by yukx 20100427
      if(p_TraderID is not null) then
          v_TradeType := 1;  --�н���ԱΪ�������ף�����ƽ�֣�
      else
        if(p_CloseFlag = 2) then
          v_TradeType := 3;  --����ԱΪ����ƽ�ֱ�־Ϊ2��ʾ�г�ǿƽ
        else
          v_TradeType := 4;  --�����н���Ա�ı�ʾί�н��ף�����ƽ�֣�
        end if;
      end if;
      */

        if(p_bs_flag=1) then  --ί��ƽ�ֵ�������־
            v_tmp_bs_flag:=2; --�൱�ڱ�ƽ�ֵ�������־
        else
            v_tmp_bs_flag:=1;
        end if;
        select GageQty into v_frozenQty --  mod by yukx 20100427
        from T_CustomerHoldSum
        where CustomerID = p_CustomerID
          and CommodityID = p_CommodityID
          and bs_flag = v_tmp_bs_flag for update;
        if(v_frozenqty <p_quantity) then
            rollback;
            return -2;
        end if;

        /*-- mod by yukx 20100427
        --ָ��ƽ�ֲ�ѯ����
        if(p_closeMode = 2) then  --ָ��ʱ��ƽ��
            if(p_timeFlag = 1) then  --ƽ���
                --�ӳֲ���ϸ���øý��׿ͻ����ո���Ʒ�ֲֺϼ�
                v_str := ' and to_char(AtClearDate,''yyyy-MM-dd'')=''' || to_char(p_TradeDate,'yyyy-MM-dd') || ''' ';
          elsif(p_timeFlag = 2) then  --ƽ��ʷ��
                  --�ӳֲ���ϸ���øý��׿ͻ��ǵ��ո���Ʒ�ֲֺϼ�
                  v_str := ' and to_char(AtClearDate,''yyyy-MM-dd'')<>''' || to_char(p_TradeDate,'yyyy-MM-dd') || ''' ';
          end if;
        elsif(p_closeMode = 3) then  --ָ���۸�ƽ��
            v_str := ' and Price =' || p_specPrice || ' ';
        end if;
        */

    --����ƽ���㷨(0�ȿ���ƽ��1����ƽ��2�ֲ־���ƽ��(������)ѡ����������
    --2009-08-04����ǿƽʱ������ƽ˳��
    if(p_TraderID is null and p_CloseFlag = 2) then
      --v_orderby := ' order by A_HoldNo desc ';
              select holddayslimit into v_holddaysLimit from t_commodity where commodityid=p_CommodityID;
              if(v_holddaysLimit=0) then   --�޳ֲ���������
                v_orderby := ' order by a.A_HoldNo desc ';
              else
                v_orderby := ' order by a.A_HoldNo asc ';
              end if;
        else
          if(p_CloseAlgr = 0) then
            v_orderby := ' order by A_HoldNo ';
        elsif(p_CloseAlgr = 1) then
            v_orderby := ' order by A_HoldNo desc ';
        end if;
      end if;
      v_str := v_str || v_orderby;

          if(p_Quantity = p_orderQty - p_orderTradeQty) then
            --����ί��
            update T_Orders
            set tradeqty=tradeqty + p_Quantity,
                Status=3,UpdateTime=systimestamp(3)
            where A_orderNo = p_A_OrderNo;
          elsif(p_Quantity < p_orderQty - p_orderTradeQty) then
            --����ί��
      if(p_status = 6) then  --״̬Ϊ���ֳɽ��󳷵���������ֳɽ��ر��ڳ����ر�֮�󣬲����ٸ���״̬��
              update T_Orders
              set tradeqty=tradeqty + p_Quantity,UpdateTime=systimestamp(3)
              where A_orderNo = p_A_OrderNo;
      else
              update T_Orders
              set tradeqty=tradeqty + p_Quantity,Status=2,UpdateTime=systimestamp(3)
              where A_orderNo = p_A_OrderNo;
      end if;
          else
            rollback;
            return -1;
          end if;


        --��ָ��ƽ��ƽ�ֲּ�¼ʱ�Գֲ���ϸ��Ϊ������ָ��ƽ��ʱ�Ե���ָ��ƽ�ֶ����Ϊ��
        if(p_closeMode = 1) then --��ָ��ƽ�� -- mod by yukx 20100427
         --�����ֲ���ϸ�����������˵�ָ��ƽ�ֶ��������,��ƽ��û�õ�b.ID����Ϊb��û������������0�滻
         v_sql := 'select a_holdno,a_tradeno,price,GageQty,HoldTime,AtClearDate,0 from T_holdposition a ' ||
                  ' where GageQty > 0 and CustomerID=''' || p_CustomerID ||
                  ''' and CommodityID =''' || p_CommodityID || ''' and bs_flag = ' || v_tmp_bs_flag || v_str;
     /*else  --ָ��ƽ�� -- mod by yukx 20100427
              v_sql := 'select a.a_holdno,a_tradeno,price,HoldQty,GageQty,HoldTime,AtClearDate,nvl(b.FrozenQty,0),b.ID from T_holdposition a,T_SpecFrozenHold b ' ||
                       ' where (a.HoldQty+a.GageQty) > 0 and b.A_HoldNo=a.A_HoldNo(+) and b.A_OrderNo= ' || p_A_OrderNo || v_str;
        */
      end if;
            open v_T_HoldPosition for v_sql;
            loop
                fetch v_T_HoldPosition into v_a_holdno, v_a_tradeno_closed, v_price,v_GageQty,v_HoldTime,v_AtClearDate,v_id;
                exit when v_T_HoldPosition%NOTFOUND;
                if(p_closeMode = 1) then --��ָ��ƽ��
                  if(v_GageQty<=v_unCloseQty) then
                      v_tradedAmount:=v_GageQty;
                  else
                      v_tradedAmount:=v_unCloseQty;
                  end if;
        /*-- mod by yukx 20100427
        else  --ָ��ƽ��
                  if(v_frozenQty<=v_unCloseQty) then
                      v_tradedAmount:=v_frozenQty;
                      delete from T_SpecFrozenHold where id=v_id;
                  else
                      v_tradedAmount:=v_unCloseQty;
                      update T_SpecFrozenHold set FrozenQty=FrozenQty-v_tradedAmount where id=v_id;
                  end if;
         */
        end if;

        --�ж���ƽ��ֻ���ƽ��ʷ��
          if(trunc(p_TradeDate) = trunc(v_AtClearDate)) then
              v_closeTodayHis := 0;
          else
            v_closeTodayHis := 1;
          end if;


        -- ����ֶ�ת�óɽ���Ӧ�۳���������
        -- ���ƽ���ǽ��쿪�Ĳ��򰴽񿪽�ƽ�����Ѽ���
        if(v_TradeType = 3) then  --ǿƽ
          v_Fee_one := FN_T_ComputeFeeByArgs(p_bs_flag,v_tradedAmount,p_Price,p_contractFactor,p_ForceCloseFeeAlgr,p_ForceCloseFeeRate_B,p_ForceCloseFeeRate_S);
        else  --���������ƽ���ǽ��쿪�Ĳ��򰴽񿪽�ƽ�����Ѽ���
          if(v_closeTodayHis = 0) then  --ƽ���
            v_Fee_one := FN_T_ComputeFeeByArgs(p_bs_flag,v_tradedAmount,p_Price,p_contractFactor,p_feeAlgr,p_TodayCloseFeeRate_B,p_TodayCloseFeeRate_S);
          else  --ƽ��ʷ��
                v_Fee_one := FN_T_ComputeFeeByArgs(p_bs_flag,v_tradedAmount,p_Price,p_contractFactor,p_feeAlgr,p_HistoryCloseFeeRate_B,p_HistoryCloseFeeRate_S);
            end if;
        end if;
        if(v_Fee_one < 0) then
          Raise_application_error(-20030, 'computeFee error');
        end if;


        --����Ӧ�˱�֤�𣬸�������ѡ�񿪲ּۻ�������������
        if(p_MarginPriceType = 1) then
              v_MarginPrice := p_YesterBalancePrice;
          elsif(p_MarginPriceType = 2) then
          if(v_closeTodayHis = 0) then  --ƽ���
            v_MarginPrice := v_price;
          else  --ƽ��ʷ��
                v_MarginPrice := p_YesterBalancePrice;
            end if;
        else  -- default type is 0
          v_MarginPrice := v_price;
        end if;
        /*-- mod by yukx 20100427
        v_Margin_one := FN_T_ComputeMarginByArgs(v_tmp_bs_flag,v_tradedAmount,v_MarginPrice,p_contractFactor,p_marginAlgr,p_marginRate_b,p_marginRate_s);
                if(v_Margin_one < 0) then
                    Raise_application_error(-20040, 'computeMargin error');
                end if;
            --���㵣����
            v_Assure_one := FN_T_ComputeAssureByArgs(v_tmp_bs_flag,v_tradedAmount,v_MarginPrice,p_contractFactor,p_marginAlgr,p_marginAssure_b,p_marginAssure_s);
            if(v_Assure_one < 0) then
                Raise_application_error(-20040, 'computeAssure error');
            end if;
            --��֤��Ӧ���ϵ�����
            v_Margin_one := v_Margin_one + v_Assure_one;

        */
              --����Ӧ�˳ֲֽ��
              v_HoldFunds := v_HoldFunds + v_tradedAmount*v_price*p_contractFactor;
                --����ƽ��ӯ��
                if(v_tmp_bs_flag=1) then  --v_tmp_bs_flag�ǳֲֵ�������־
                    v_closeFL_one := v_tradedAmount*(p_price-v_price)*p_contractFactor; --˰ǰӯ��
                else
                    v_closeFL_one := v_tradedAmount*(v_price-p_price)*p_contractFactor; --˰ǰӯ��
                end if;
              --����ƽ����ֵ˰,v_AddedTaxFactor��ֵ˰ϵ��=AddedTax/(1+AddedTax) xief 20150811
              -- v_CloseAddedTax_one := round(v_closeFL_one*p_AddedTaxFactor,2);
                v_CloseAddedTax_one := 0;
                v_closeFL_one := v_closeFL_one - v_CloseAddedTax_one; --˰��ӯ��

        --���ü��㺯���޸ĳɽ����� 2011-2-15 by feijl
                select FN_T_ComputeTradeNo(SEQ_T_Trade.nextval) into v_A_TradeNo from dual;
                 insert into T_Trade
                  (a_tradeno, m_tradeno, a_orderno, a_tradeno_closed,tradetime, Firmid, CommodityID, bs_flag, ordertype, price, quantity, close_pl, tradefee,TradeType,HoldPrice,HoldTime,CustomerID,CloseAddedTax,M_TradeNo_Opp,AtClearDate,TradeAtClearDate,oppFirmid)
                values
                  (v_A_TradeNo, p_M_TradeNo, p_A_OrderNo, v_a_tradeno_closed, sysdate, p_Firmid, p_CommodityID,p_bs_flag, p_ordertype, p_price, v_tradedAmount, v_closeFL_one, v_Fee_one,v_TradeType,v_price,v_HoldTime,p_CustomerID,v_CloseAddedTax_one,p_M_TradeNo_Opp,v_AtClearDate,p_TradeDate,p_FirmID_opp);

                --���³ֲּ�¼\�ֲ���ϸ�ֶ���������
                --ȥ���˱�֤�𡢵�������   mod by yukx 20100427
                -- fixed by tangzy �޸��ֶ�ת�õ�bug
                -- ( "GageQty=GageQty-v_GageQty" -> "GageQty=GageQty-v_tradedAmount" )
                update T_holdposition
                set GageQty=GageQty-v_tradedAmount
                where a_holdno = v_a_holdno;
                v_unCloseQty:=v_unCloseQty - v_tradedAmount;

               /*-- mod by yukx 20100427
                v_Margin:=v_Margin + v_Margin_one;
                v_Assure:=v_Assure + v_Assure_one;
                */
                v_Fee:=v_Fee + v_Fee_one;
                v_closeFL:=v_closeFL + v_closeFL_one;

                exit when v_unCloseQty=0;
            end loop;
            close v_T_HoldPosition;
            if(v_unCloseQty>0) then --�ɽ��������ڳֲ�����������
                rollback;
                return -3;
            end if;

    --������Ч�ֵ��ֶ���������� -- mod by yukx 20100427
    update T_ValidGageBill set Quantity=Quantity+p_Quantity where FirmID=p_FirmID and CommodityID = p_CommodityID; --(select breedid from t_commodity where CommodityID = p_CommodityID);
    --���ٽ��׿ͻ��ֲֺϼƱ�ĵֶ���������  mod by yukx 20100427
    update T_CustomerHoldSum set GageFrozenQty=GageFrozenQty-p_Quantity where CustomerID=p_CustomerID and CommodityID=p_CommodityID and BS_Flag=v_tmp_bs_flag;
    --���׿ͻ��ֲֺϼơ������ֲֺ̳ϼƵֶ���������  mod by yukx 20100427
    if(p_GageMode=1) then
        v_firmHoldfunds := v_HoldFunds;
    else
        v_firmHoldfunds := 0;
    end if;
    v_num := FN_T_SubHoldSum(0,p_quantity,0,0,p_CommodityID,p_contractFactor,v_tmp_bs_flag,p_FirmID,v_firmHoldfunds,p_CustomerID,v_HoldFunds,p_GageMode,0);

    --ȥ���˱�֤�𡢵������� -- mod by yukx 20100427
    --������ʱ��֤�����ʱ������
    /*update T_Firm
    set runtimemargin = runtimemargin - v_Margin,
    RuntimeAssure = RuntimeAssure - v_Assure
    where Firmid = p_FirmID;*/

    --���¶����ʽ��ͷŸ��˲��ֵı�֤��  mod by yukx 20100427
    --v_F_FrozenFunds := FN_F_UpdateFrozenFunds(p_FirmID,-(v_Margin-v_Assure)+v_Fee-v_closeFL,'15');
    v_F_FrozenFunds := FN_F_UpdateFrozenFunds(p_FirmID,v_Fee-v_closeFL,'15');
    return 1;

end;
/

prompt
prompt Creating function FN_T_GAGEQTY
prompt ==============================
prompt
create or replace function FN_T_GageQty(
    --p_ApplyID        number,     --���뵥�� modify by yukx 20100421
    p_CommodityID varchar2, --��Ʒ����
    p_BS_Flag        number,    --������־��Ŀǰֻ������
    p_CustomerID     varchar2,     --�ͻ�ID
    --p_BillID         varchar2, --�ֵ��� modify by yukx 20100421
    --p_Modifier       varchar2,   --������ modify by yukx 20100421
    p_Quantity       number   --�ֵ�����
) return number
/****
 * �ֶ�
 * ����ֵ
 * 1 �ɹ�
 * 2 �Ѵ����
 * -1  �ֶ�ʱ�����ɵֶ�����
 * -2  �ֶ��������ڳֲ�����
 * -3  �ֶ��������ڿ�������
 * -4  û�ж�Ӧ����Ч�ֵ��ֶ���¼
 * -100 ��������
****/
as
	v_version varchar2(10):='1.0.3.1';
    v_CommodityID varchar2(16);
    v_FirmID     varchar2(32);
    v_BS_Flag        number(2);
    v_price          number(15,2);
    v_frozenQty      number(10);
    v_holdQty        number(10);
    v_Margin         number(15,2):=0;   --Ӧ�ձ�֤��
	v_Assure         number(15,2):=0;   --Ӧ�յ�����
    v_A_HoldNo       number(15);
    v_HoldSumQty     number(10);
    v_MarginPriceType       number(1);
    v_ContractFactor T_Commodity.ContractFactor%type;
    v_errorcode      number;
    v_errormsg       varchar2(200);
    v_MarginPrice    number(15,2);  --����ɽ���֤��ļ۸�
	v_HoldFunds    number(15,2):=0;  --ƽ��ʱӦ�˳ֲֽ��
    v_unCloseQty     number(10):=p_quantity; --δƽ�����������м����
    v_margin_one     number(15,2);   --�����м����
	v_Assure_one     number(15,2);   --�����м����
    v_tradedAmount   number(10):=0;  --�ɽ�����
	v_CustomerID        varchar2(40);
	v_CloseAlgr           number(2);
	v_orderby  varchar2(100);
	v_F_FrozenFunds   number(15,2);
	type c_HoldPosition is ref cursor;
	v_HoldPosition c_HoldPosition;
	v_sql varchar2(1000);
	v_num            number(10);
	v_FL_ret            timestamp;
	v_AtClearDate          date;
	v_closeTodayHis        number(2);    --ƽ��ֻ�����ʷ��(0ƽ��֣�1ƽ��ʷ��)
	v_YesterBalancePrice    number(15,2);
	v_TradeDate date;
	v_GageMode number(2);--�ֶ�ģʽ����0ȫ�ֶ���1��ֶ�����ֶ�ʱҪ���㸡����2009-10-14
  v_AvailableQuantity number(10);--�������� add by yukx 20100507
begin
     -- modify by yukx 20100421
	    --select count(*) into v_num from T_ValidBill where BillID = p_BillID and Status=1;
	    --if(v_num >0) then
	    --   rollback;
	    --    return 2;  --�Ѵ����
	    --end if;

      --��֤�ֶ�������������� add by yukx 20100507
      --����ʱ�����Ѷ��ᣬ��ʱֻ����֤���������Ƿ����㣬ԭ��v_AvailableQuantity=Quantity-FrozenQty  20131211 by jwh
      begin
        select FrozenQty into v_AvailableQuantity from T_ValidGageBill
        where FirmID=(select FirmID from T_Customer where CustomerID=p_CustomerID)
          and commodityID=p_CommodityID;
        exception
          when NO_DATA_FOUND then
  	      return -4;--û�ж�Ӧ����Ч�ֵ��ֶ���¼
      end;

      if(v_AvailableQuantity<p_Quantity) then
        return -3;--�ֶ��������ڿ�������
      end if;

		v_CustomerID := p_CustomerID;
	    v_CommodityID := p_CommodityID;
        v_BS_Flag := p_BS_Flag;
        --��ȡƽ���㷨����֤���������,��Լ����
        select CloseAlgr,GageMode into v_CloseAlgr,v_GageMode from T_A_Market;
        select MarginPriceType,ContractFactor,LastPrice into v_MarginPriceType,v_ContractFactor,v_YesterBalancePrice from T_Commodity where CommodityID=v_CommodityID;
		select TradeDate into v_TradeDate from T_SystemStatus;

     begin
      select holdqty, frozenqty  into v_HoldSumQty, v_frozenQty from T_CustomerHoldSum
        where CustomerID = v_CustomerID
          and CommodityID = v_CommodityID
          and bs_flag = v_BS_Flag for update;
        exception
        when NO_DATA_FOUND then
  	     return -13;--δ��ѯ����Ӧ�ֲ�����
      end;

      --����ʱ�����Ѷ��ᣬ��ʱֻ����֤���������Ƿ����㣬ԭ��֤�� p_quantity > v_HoldSumQty-v_frozenqty 20131211 by jwh
        if(p_quantity > v_frozenqty) then
            rollback;
            return -1;
        end if;
    	--�����ֲ���ϸ�����������˵�ָ��ƽ�ֶ��������
        --����ƽ���㷨(0�ȿ���ƽ��1����ƽ��2�ֲ־���ƽ��(������)ѡ����������
        if(v_CloseAlgr = 0) then
	        v_orderby := ' order by a.A_HoldNo ';
	    elsif(v_CloseAlgr = 1) then
	        v_orderby := ' order by a.A_HoldNo desc ';
	    end if;


    	v_sql := 'select a.a_holdno,FirmID,price,(a.HoldQty-nvl(b.FrozenQty,0)),a.AtClearDate from T_holdposition a,(select A_HoldNo,nvl(sum(FrozenQty),0) FrozenQty from T_SpecFrozenHold group by A_HoldNo) b ' ||
                 ' where (a.HoldQty+a.GageQty) > 0 and a.A_HoldNo=b.A_HoldNo(+) and nvl(b.FrozenQty,0)<a.HoldQty and CustomerID=''' || v_CustomerID ||
                 ''' and CommodityID =''' || v_CommodityID || ''' and bs_flag = ' || v_BS_Flag || v_orderby;

            open v_HoldPosition for v_sql;
            loop
                fetch v_HoldPosition into v_a_holdno, v_FirmID, v_price, v_holdqty,v_AtClearDate;
                exit when v_HoldPosition%NOTFOUND;
                if(v_holdqty<=v_unCloseQty) then
                    v_tradedAmount:=v_holdqty;
                else
                    v_tradedAmount:=v_unCloseQty;
                end if;

                --����Ӧ�˱�֤�𣬸�������ѡ�񿪲ּۻ�������������
				if(v_MarginPriceType = 1) then
			        v_MarginPrice := v_YesterBalancePrice;
			    elsif(v_MarginPriceType = 2) then
					--�ж���ƽ��ֻ���ƽ��ʷ��
				    if(trunc(v_TradeDate) = trunc(v_AtClearDate)) then
				        v_closeTodayHis := 0;
				    else
				    	v_closeTodayHis := 1;
				    end if;
					if(v_closeTodayHis = 0) then  --ƽ���
						v_MarginPrice := v_price;
					else  --ƽ��ʷ��
				        v_MarginPrice := v_YesterBalancePrice;
				    end if;
				else  -- default type is 0
					v_MarginPrice := v_price;
				end if;

                v_Margin_one := FN_T_ComputeMargin(v_FirmID,v_CommodityID,v_BS_Flag,v_tradedAmount,v_MarginPrice);
                if(v_Margin_one < 0) then
                    Raise_application_error(-20040, 'computeMargin error');
                end if;
		        --���㵣����
		        v_Assure_one := FN_T_ComputeAssure(v_FirmID,v_CommodityID,v_BS_Flag,v_tradedAmount,v_MarginPrice);
		        if(v_Assure_one < 0) then
		            Raise_application_error(-20041, 'computeAssure error');
		        end if;
		        --��֤��Ӧ���ϵ�����
		        v_Margin_one := v_Margin_one + v_Assure_one;

                v_Margin:=v_Margin + v_Margin_one;
                v_Assure:=v_Assure + v_Assure_one;
	            --����Ӧ�˳ֲֽ��
	            v_HoldFunds := v_HoldFunds + v_tradedAmount*v_price*v_ContractFactor;

                --���³ֲּ�¼
		        update T_holdposition
                set holdqty = holdqty - v_tradedAmount,HoldMargin=HoldMargin-v_Margin_one,HoldAssure=HoldAssure-v_Assure_one,GageQty=GageQty+v_tradedAmount
                where a_holdno = v_a_holdno;
                v_unCloseQty:=v_unCloseQty - v_tradedAmount;
                exit when v_unCloseQty=0;
            end loop;
            close v_HoldPosition;
            if(v_unCloseQty>0) then --�ֶ��������ڳֲ�����������
                rollback;
                return -2;
            end if;

        --���ü��ٽ��׿ͻ��������̵ĳֲֺϼ���Ϣ�洢��ע�����ֵ����ٳֲֲ�һ��   2009-10-15
        if(v_GageMode=1) then
        	v_num := FN_T_SubHoldSum(p_quantity,-p_quantity,v_Margin,v_Assure,v_CommodityID,v_ContractFactor,v_BS_Flag,v_FirmID,0,v_CustomerID,0,v_GageMode,p_quantity);
		else
			v_num := FN_T_SubHoldSum(p_quantity,-p_quantity,v_Margin,v_Assure,v_CommodityID,v_ContractFactor,v_BS_Flag,v_FirmID,v_HoldFunds,v_CustomerID,0,v_GageMode,p_quantity);
		end if;

        --���±�֤��͵�����
        update T_Firm
        set runtimemargin = runtimemargin - v_Margin,
            RuntimeAssure = RuntimeAssure - v_Assure
        where Firmid = v_FirmID;
        --���¶����ʽ��ͷŸ��˲��ֵı�֤��
		v_F_FrozenFunds := FN_F_UpdateFrozenFunds(v_FirmID,-(v_Margin-v_Assure),'15');

        --modify by yukx 20100421
        --������Ч�ֵ���
        --insert into T_ValidBill
        --    (ValidID,               ApplyID, CommodityID,   FirmID_S, CustomerID_S,BillID,  Quantity,  BillType,  Status,CreateTime,Creator)
        --values
        --    (SEQ_T_ValidBill.nextval,p_ApplyID,v_CommodityID, v_FirmID, v_CustomerID,p_BillID,p_Quantity,    1,        1  ,  sysdate,  p_Modifier);
        update T_ValidGageBill set Quantity=Quantity-p_Quantity,FrozenQty=FrozenQty-p_Quantity where FirmID=v_FirmID
               and commodityID=p_CommodityID;

    commit;
    --�ύ�����˽����̸���
    v_FL_ret := FN_T_UpdateFloatingLoss(null,null,null);

    return 1;
exception
    when OTHERS then
    v_errorcode:=sqlcode;
    v_errormsg :=sqlerrm;
    rollback;
    insert into T_DBLog(err_date,name_proc,err_code,err_msg)
    values(sysdate,'FN_T_GageQty',v_errorcode,v_errormsg);
    commit;
    return -100;
end;
/

prompt
prompt Creating function FN_T_GAGEQTYCANCEL
prompt ====================================
prompt
create or replace function FN_T_GageQtyCancel(
    --p_ValidID       number,     --��Ч�ֵ��� modify by yukx 20100422
    --p_Modifier      varchar2,   --����޸��� modify by yukx 20100422
    p_customerId      varchar2,   --���׿ͻ�����
    p_commodityId     varchar2,   --��Ʒ����
    p_Quantity        number,     --�����ֶ�����
	  p_ApplyType     number    --��������:2�������������еֶ�;3��ǿ�Ƴ������еֶ�
) return number
/****
 * ȡ���ֶ�
 * ����ֵ
 * 1 �ɹ�
 * 2 �Ѵ����
 * -11  ȡ���ֶ�ʱ�����ֶ�����
 * -12  ȡ���ֶ��������ڵֶ�����
 * -13  �ʽ�����
 * -100 ��������
****/
as
	v_version varchar2(10):='1.0.2.1';
    --v_CommodityID varchar2(16);  modify by yukx 20100422
    v_FirmID     varchar2(32);
    v_BS_Flag        number(2);
    v_price          number(15,2);
    v_GageQty       number(10);
    v_frozenGageQty number(10);
    v_holdQty        number(10);
    v_Margin         number(15,2):=0;   --Ӧ�ձ�֤��
	v_Assure         number(15,2):=0;   --Ӧ�յ�����
    v_A_HoldNo       number(15);
    v_MarginPriceType       number(1);
    v_errorcode      number;
    v_errormsg       varchar2(200);
    v_MarginPrice    number(15,2);  --����ɽ���֤��ļ۸�
	v_HoldFunds    number(15,2):=0;  --ƽ��ʱӦ�˳ֲֽ��
    v_unCloseQty     number(10); --δƽ�����������м����
    v_margin_one     number(15,2);   --�����м����
	v_Assure_one     number(15,2);   --�����м����
    v_tradedAmount   number(10):=0;  --�ɽ�����
	--v_CustomerID        varchar2(16);  modify by yukx 20100422
	v_calFLPrice number(15,2) default 0;        --���㸡���ļ۸�
	v_ContractFactor T_Commodity.ContractFactor%type;
	v_FloatLoss_one         number(15,2):=0;    --��ֵ��ʾ�ĸ���
	v_FloatLoss         number(15,2):=0;        --��ֵ��ʾ�ĸ����ϼ�
	v_A_Funds        number(15,2);   --�����ʽ�
	--v_Quantity     number(10); --δƽ�����������м����  modify by yukx 20100422
	v_CloseAlgr           number(2);
	v_FloatingLossComputeType number(2);
	v_orderby  varchar2(100);
	v_VirtualFunds   number(15,2);   --�����ʽ�
	v_F_FrozenFunds   number(15,2);
	v_MaxOverdraft   number(15,2);   --���͸֧���
	type c_HoldPosition is ref cursor;
	v_HoldPosition c_HoldPosition;
	v_sql varchar2(1000);
	v_num            number(10);
	v_FL_ret            timestamp;
	v_AtClearDate          date;
	v_closeTodayHis        number(2);    --ƽ��ֻ�����ʷ��(0ƽ��֣�1ƽ��ʷ��)
	v_YesterBalancePrice    number(15,2);
	v_TradeDate date;
	v_FloatingProfitSubTax number(1);
	v_AddedTax number(10,4);
	v_GageMode number(2);--�ֶ�ģʽ����0ȫ�ֶ���1��ֶ�����ֶ�ʱҪ���㸡����2009-10-14
begin
     -- modify by yukx 20100422
	   -- select count(*) into v_num from T_ValidBill where ValidID = p_ValidID and Status=0;
	   -- if(v_num >0) then
	   --     rollback;
	   --     return 2;  --�Ѵ����
	   -- end if;

    --  modify by yukx 20100422
		--������Ч�ֵ��Ų�ѯ���������ͻ�ID����Ʒͳһ���룬�ֵ�����
		--select CustomerID_S,CommodityID,Quantity into v_CustomerID,v_CommodityID,v_Quantity from T_ValidBill where ValidID=p_ValidID;
    --v_CustomerID   := p_customerId;
    --v_CommodityID  := p_commodityId;
    --v_Quantity     := p_Quantity;
        --��ȡƽ���㷨����֤���������,��Լ����
        select CloseAlgr,FloatingLossComputeType,FloatingProfitSubTax,GageMode into v_CloseAlgr,v_FloatingLossComputeType,v_FloatingProfitSubTax,v_GageMode from T_A_Market;
        select MarginPriceType,ContractFactor,LastPrice,AddedTax into v_MarginPriceType,v_ContractFactor,v_YesterBalancePrice,v_AddedTax from T_Commodity where CommodityID=p_commodityId;
		select TradeDate into v_TradeDate from T_SystemStatus;

        v_BS_Flag := 2; --���ֶ�
		v_unCloseQty := p_Quantity;
		--ע����ס�ֲ�
        select GageQty,GageFrozenQty into v_GageQty,v_frozenGageQty
        from T_CustomerHoldSum
        where CustomerID = p_customerId
          and CommodityID = p_commodityId
          and bs_flag = v_BS_Flag for update;

        -- modify by yukx 20100422
        if(p_Quantity > v_GageQty-v_frozenGageQty) then
            rollback;
            return -11;
        end if;
    	--������㱣֤��۲��ǰ����ּۣ����ڵ�ǰ��������������ۣ�δ�ҵ�������ʷ�����һ��Ľ����
        begin
        	select nvl(Price,0) into v_calFLPrice from T_Quotation where CommodityID=p_commodityId;
        exception
            when NO_DATA_FOUND then
                select nvl(Price,0) into v_calFLPrice from T_H_Quotation where CommodityID=p_commodityId and ClearDate =(select max(ClearDate) from T_H_Quotation where CommodityID=p_commodityId);
        end;
        --�ҳ��ֶ���������0�ĳֲ�
        --ȡ���ֶ�ʱ��ֶ�ʱ˳���෴
        --����ƽ���㷨(0�ȿ���ƽ��1����ƽ��2�ֲ־���ƽ��(������)ѡ����������
        if(v_CloseAlgr = 0) then
	        v_orderby := ' order by A_HoldNo desc ';
	    elsif(v_CloseAlgr = 1) then
	        v_orderby := ' order by A_HoldNo ';
	    end if;
    	v_sql := 'select a_holdno,FirmID,price,GageQty,AtClearDate from T_holdposition ' ||
                 ' where GageQty>0 and CustomerID=''' || p_customerId ||
                 ''' and CommodityID =''' || p_commodityId || ''' and bs_flag = ' || v_BS_Flag || v_orderby;

            open v_HoldPosition for v_sql;
            loop
                fetch v_HoldPosition into v_a_holdno, v_FirmID, v_price, v_holdqty,v_AtClearDate;
                exit when v_HoldPosition%NOTFOUND;
                if(v_holdqty<=v_unCloseQty) then
                    v_tradedAmount:=v_holdqty;
                else
                    v_tradedAmount:=v_unCloseQty;
                end if;

                --����Ӧ�ձ�֤�𣬸�������ѡ�񿪲ּۻ�������������
				if(v_MarginPriceType = 1) then
			        v_MarginPrice := v_YesterBalancePrice;
			    elsif(v_MarginPriceType = 2) then
					--�ж���ƽ��ֻ���ƽ��ʷ��
				    if(trunc(v_TradeDate) = trunc(v_AtClearDate)) then
				        v_closeTodayHis := 0;
				    else
				    	v_closeTodayHis := 1;
				    end if;
					if(v_closeTodayHis = 0) then  --ƽ���
						v_MarginPrice := v_price;
					else  --ƽ��ʷ��
				        v_MarginPrice := v_YesterBalancePrice;
				    end if;
				else  -- default type is 0
					v_MarginPrice := v_price;
				end if;
                v_Margin_one := FN_T_ComputeMargin(v_FirmID,p_commodityId,v_BS_Flag,v_tradedAmount,v_MarginPrice);
                if(v_Margin_one < 0) then
                    Raise_application_error(-20040, 'computeMargin error');
                end if;
		        --���㵣����
		        v_Assure_one := FN_T_ComputeAssure(v_FirmID,p_commodityId,v_BS_Flag,v_tradedAmount,v_MarginPrice);
		        if(v_Assure_one < 0) then
		            Raise_application_error(-20041, 'computeAssure error');
		        end if;
		        --��֤��Ӧ���ϵ�����
		        v_Margin_one := v_Margin_one + v_Assure_one;
		        --���㸡�������ݲ����Ƿ��˰
				v_FloatLoss_one := FN_T_ComputeFPSubTax(v_Price,v_calFLPrice,v_tradedAmount,v_ContractFactor,v_BS_Flag,v_AddedTax,v_FloatingProfitSubTax);
				if(v_FloatingLossComputeType = 3 or v_FloatingLossComputeType = 4) then  --������ӯ������ӯ��
					--v_FloatLoss_one := -FN_T_ComputeFloatingProfit(v_Price,v_calFLPrice,v_tradedAmount,v_ContractFactor,v_BS_Flag); --ӯ����ȡ��
					v_FloatLoss_one := -v_FloatLoss_one;
				else
		        	--v_FloatLoss_one := FN_T_ComputeFloatingLoss(v_Price,v_calFLPrice,v_tradedAmount,v_ContractFactor,v_BS_Flag); --����
					if(v_FloatLoss_one > 0) then
						v_FloatLoss_one := 0;
					else
						v_FloatLoss_one := -v_FloatLoss_one;
					end if;
		        end if;
                v_Margin:=v_Margin + v_Margin_one;
                v_Assure:=v_Assure + v_Assure_one;
                v_FloatLoss := v_FloatLoss + v_FloatLoss_one;
	            --����Ӧ�˳ֲֽ��
	            v_HoldFunds := v_HoldFunds + v_tradedAmount*v_price*v_ContractFactor;

                --���³ֲּ�¼
		        update T_holdposition
                set holdqty = holdqty + v_tradedAmount,HoldMargin=HoldMargin+v_Margin_one,HoldAssure=HoldAssure+v_Assure_one,GageQty=GageQty-v_tradedAmount
                where a_holdno = v_a_holdno;

                v_unCloseQty:=v_unCloseQty - v_tradedAmount;
                exit when v_unCloseQty=0;
            end loop;
            close v_HoldPosition;
            if(v_unCloseQty>0) then --ȡ���ֶ��������ڵֶ�����������
                rollback;
                return -12;
            end if;
            --������������:2�������������еֶ�;3��ǿ�Ƴ������еֶ������жϽ���Ƿ��㹻�ͷŴ˵ֶ��������3����Ҫ���ж�
			if(p_ApplyType = 2) then
				select VirtualFunds,MaxOverdraft into v_VirtualFunds,v_MaxOverdraft from T_Firm where FirmID = v_FirmID;
		        --��������ʽ�
		        v_A_Funds := FN_F_GetRealFunds(v_FirmID,0) + v_VirtualFunds + v_MaxOverdraft;
		        --����ǰ�ֶ����ͷŸ���2009-10-15
		        if(v_GageMode=1) then
		        	v_FloatLoss := 0;
				end if;
		        if(v_A_Funds < v_Margin-v_Assure + v_FloatLoss) then
		            rollback;
		            return -13;  --�ʽ�����
		        end if;
	        end if;

        --���ü��ٽ��׿ͻ��������̵ĳֲֺϼ���Ϣ�洢��ע�����ֵ����ٳֲֲ�һ��   2009-10-15
        if(v_GageMode=1) then
        	v_num := FN_T_SubHoldSum(-p_Quantity,p_Quantity,-v_Margin,-v_Assure,p_commodityId,v_ContractFactor,v_BS_Flag,v_FirmID,0,p_customerId,0,v_GageMode,0);
		else
			v_num := FN_T_SubHoldSum(-p_Quantity,p_Quantity,-v_Margin,-v_Assure,p_commodityId,v_ContractFactor,v_BS_Flag,v_FirmID,-v_HoldFunds,p_customerId,0,v_GageMode,0);
		end if;

        --���±�֤��͵�����
        update T_Firm
        set runtimemargin = runtimemargin + v_Margin,
            RuntimeAssure = RuntimeAssure + v_Assure
        where Firmid = v_FirmID;
        --���¶����ʽ𣬿۳����˲��ֵı�֤��
        v_F_FrozenFunds := FN_F_UpdateFrozenFunds(v_FirmID,v_Margin-v_Assure,'15');

        --modify by tangzy 20100729 ����where����
        --modify by yukx 20100422 �����ֶ�ת�ú󲿸�����Ч�ֵ��� ֱ��������Ч�ֶ��ֵ��������
        --������Ч�ֵ����״̬Ϊ�ѳ���
        --update T_ValidBill set Status=0,ModifyTime=sysdate,Modifier=p_Modifier where ValidID=p_ValidID;
        update T_ValidGageBill set Quantity = Quantity+p_Quantity
        where FirmID=v_FirmID and commodityID= p_CommodityID;
    commit;
    --�ύ�����˽����̸���
    v_FL_ret := FN_T_UpdateFloatingLoss(null,null,null);

    return 1;
exception
    when OTHERS then
    v_errorcode:=sqlcode;
    v_errormsg :=sqlerrm;
    rollback;
    insert into T_DBLog(err_date,name_proc,err_code,err_msg)
    values(sysdate,'FN_T_GageQtyCancel',v_errorcode,v_errormsg);
    commit;
    return -100;
end;
/

prompt
prompt Creating function FN_T_GETHOLDDEADLINE
prompt ======================================
prompt
create or replace function FN_T_GETHOLDDEADLINE(p_begindate   date,
                                                p_commodityid varchar2)
/**
  * ��ȡ�ֲֵĵ�������
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
  if (v_maxHoldDays = 0) then   --����ֲ���������Ϊ0����ֱ�ӷ��سֲ�����
    return p_begindate;
  end if;

  select count(cleardate)
    into v_cnt1
    from t_h_market
   where cleardate >= p_begindate;

  if (v_maxHoldDays - v_cnt1 > 0) then    --δ���ڳֲ�
    select max(day)
      into v_date
      from (select *
              from (select day from t_tradedays order by day)
             where rownum <= v_maxHoldDays - v_cnt1);
  elsif (v_maxHoldDays - v_cnt1 <= 0) then   --���ڳֲ�
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

prompt
prompt Creating function FN_T_UPDATEHOLDDAYS
prompt =====================================
prompt
create or replace function FN_T_UPDATEHOLDDAYS(p_commodityid varchar2)
/**
  * ����ָ����Ʒ�����гֲֵĵ������ڡ���������
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
    --���㵽������
    v_deadline := FN_T_GETHOLDDEADLINE(days.atcleardate, p_commodityid);
    --���㵽������
    select count(*)
      into v_remaindays
      from t_tradedays
     where day <= v_deadline;
    --�������з��ϸ������ĳֲ�
    update t_holdposition t
       set t.deadline = v_deadline, t.remainday = v_remaindays
     where t.atcleardate = days.atcleardate
       and commodityid = p_commodityid;

  end loop;
  return(0);
end;
/

prompt
prompt Creating function FN_T_INITTRADE
prompt ================================
prompt
CREATE OR REPLACE FUNCTION FN_T_InitTrade
(
    p_ClearDate Date  --��������
)
RETURN NUMBER
/****
 * ��ʼ������ϵͳ
 * ����ֵ 1 �ɹ�;-100 ��������
****/
as
	v_version varchar2(10):='1.0.2.2';
	v_CommodityID varchar2(16);
	v_Price         number(15,2);
	v_ReserveCount   number(10);
	v_num            number(10);
        v_ret            number(10);
	v_quotationTwoSide  number(10);
    v_errorcode number;
    v_errormsg  varchar2(200);
    --���������α�,����������Ʒ��������
    cursor cur_T_Quotation is select CommodityID,Price from T_Quotation;
    --��Ʒ�����α�
    cursor cur_T_Commodity is
        select CommodityID
        from T_Commodity
        where SettleDate<trunc(p_ClearDate);
begin
    --1�������α���½�����Ʒ��ֻ�н�������С�ڵ������ڲ��ҳֱֲ���û�д���Ʒ�ĳֲ֣�����Դ���Ʒ����ɾ������Ʒ
  	open cur_T_Commodity;
    loop
    	fetch cur_T_Commodity into v_CommodityID;
    	exit when cur_T_Commodity%notfound;
        select count(*) into v_num from T_FirmHoldSum where CommodityID = v_CommodityID and (HoldQty+GageQty)>0;
        if(v_num <= 0) then
		    delete from T_Commodity where CommodityID=v_CommodityID;
		    --2009-11-27 ����ɾ���������õı�
		    delete from T_A_FirmMargin where CommodityID=v_CommodityID;
		    delete from T_A_FirmFee where CommodityID=v_CommodityID;
		    delete from T_A_FirmMaxHoldQty where CommodityID=v_CommodityID;
        else
           update T_Commodity set status=1 where CommodityID=v_CommodityID;
        end if;
 	end loop;
    close cur_T_Commodity;
    --2��ɾ�����׿ͻ��ֲ���ϸ��ĳֲ������͵ֶ�����������0�ļ�¼
    delete from T_HoldPosition where HoldQty=0 and GageQty=0;
    --3��ɾ�����׿ͻ��ֲֺϼƱ�ĳֲ������͵ֶ�����������0�ļ�¼
    delete from T_CustomerHoldSum where HoldQty=0 and GageQty=0;
    --4��ɾ�������ֲֺ̳ϼƱ�ĳֲ������͵ֶ�����������0�ļ�¼
    delete from T_FirmHoldSum where HoldQty=0 and GageQty=0;
    --5�������α������Ʒ�����ۺͶ�������by cxc 2009-08-17���������ڴӳֲ����ϻ��ܣ�����ֻ����������
  	open cur_T_Quotation;
    loop
    	fetch cur_T_Quotation into v_CommodityID,v_Price;
    	exit when cur_T_Quotation%notfound;
    	update T_Commodity set LastPrice=v_Price where CommodityID=v_CommodityID;
 	end loop;
    close cur_T_Quotation;
    --6��������Ʒ�ϵĶ�����������˫�ߵģ� ���ºͳֲ��ϵĶ�һ�Σ���֤ÿ�춼��ȷ����ΪЭ��ƽ�֣���ǰ������û�и��������ϵĶ�����
    --add 2010-09-07 �������鵥˫���ж�
	select quotationTwoSide into v_quotationTwoSide from T_A_MARKET;
	update T_Commodity a
    set ReserveCount =
    nvl((
          select decode(v_quotationTwoSide,2,sum(HoldQty+GageQty),sum(HoldQty+GageQty)/2)
      	  from T_FirmHoldSum
      	  where CommodityID=a.CommodityID
          group by CommodityID
    ),0);
    --7����յ��������
    delete from T_Quotation;
    --8��������Ʒ�����ʼ����
    insert into T_Quotation(CommodityID,Price,YesterBalancePrice,ReserveCount,CreateTime)
                 select     CommodityID,LastPrice,LastPrice,      ReserveCount,sysdate
                 from T_Commodity where Status<>1;
    --8.5 ��������������̼�
    update T_Quotation a
    set (ClosePrice) =nvl(
    (
      select nvl(CurPrice,0)
      from T_H_Quotation
      where ClearDate =(select max(ClearDate) from T_H_Quotation) and CommodityID=a.CommodityID
    ),0);

    --9����յ������������
    delete from T_DelayQuotation;
    --10��������Ʒ�����ʼ��������
    insert into T_DelayQuotation(CommodityID,BuySettleQty,SellSettleQty,BuyNeutralQty,SellNeutralQty,CreateTime,NeutralSide)
                 select          CommodityID,       0,           0,            0,             0,       sysdate ,     0
                 from T_Commodity where Status<>1 and SettleWay=1;

    --11����ʼ��������С��ű�  2011-2-15 by feijl
    select count(*) into v_num from T_CurMinNo where TradeDate = TO_NUMBER(TO_CHAR(p_ClearDate,'yyMMdd'));
    if(v_num <= 0) then
		update T_CurMinNo set TradeDate = TO_NUMBER(TO_CHAR(p_ClearDate,'yyMMdd')),A_OrderNo=SEQ_T_Orders.nextval,A_TradeNo=SEQ_T_Trade.nextval,A_HoldNo=SEQ_T_HoldPosition.nextval;
    end if;
    --���ò���ϵͳ��ʼ���洢 liuchao 20130411
    SP_F_StatusInit();

    --���³ֲֵĵ������� add by zhaodc 2013-12-25
    select count(*) into v_ret from  t_commodity c where c.maxholdpositionday is not null;
    if ( v_ret > 0) then
      v_ret := fn_t_addTradeDays();
      for cmd in (select commodityid from t_commodity c where c.maxholdpositionday is not null)
      loop
        v_ret := fn_t_updateholddays(cmd.commodityid);
      end loop;
    end if;
    --��û���������ֲ�������Ҳ�������������ڣ��Ķ�����ϸ�ĵ������ں͵����������
    update t_holdposition
       set deadline = null,remainday=null
     where commodityid in ( select commodityid from t_commodity where maxholdpositionday is null );

    commit;
    return 1;
exception
    when OTHERS then
    v_errorcode:=sqlcode;
    v_errormsg :=sqlerrm;
    rollback;
    insert into T_DBLog(err_date,name_proc,err_code,err_msg)
    values(sysdate,'FN_T_InitTrade',v_errorcode,v_errormsg);
    commit;
    return -100;
end;
/

prompt
prompt Creating function FN_T_OPENORDER
prompt ================================
prompt
create or replace function FN_T_OpenOrder(
    p_FirmID     varchar2,  --������ID
    p_TraderID       varchar2,  --����ԱID
    p_CommodityID varchar2,
    p_bs_flag        number,
    p_price          number,
    p_quantity       number,
    p_Margin     number,     --ί��Ӧ�ձ�֤��
    p_Fee   number,   --ί��Ӧ��������
    p_CustomerID     varchar2,  --���׿ͻ�ID
    p_ConsignerID       varchar2,  --ί��ԱID
    p_specialOrderFlag       number  --�Ƿ�����ί��(0������ί�� 1������ί��) ����ί��ֻ�ܺ�����ί�гɽ�
) return number
/****
 * ����ί��
 * ����ֵ
 * >0  �ɹ��ύ��������ί�е���
 * -1  �ʽ�����
 * -2  ���������̶Դ���Ʒ����󶩻���
 * -3  �����������ܵ���󶩻���
 * -4  ����Ʒ����󶩻���
 * -5  ������Ʒ��󶩻���
 * -6  ���������̶Դ���Ʒ����󾻶�����
 * -7  �����������ί����������java���жϣ�2009-09-18
 * -99  �������������
 * -100 ��������
****/
as
    v_version varchar2(10):='1.0.0.9';
    v_F_Funds        number(15,2):=0;   --Ӧ�����ʽ�
    v_VirtualFunds   number(15,2);   --�����ʽ�
    v_A_Funds        number(15,2);   --�����ʽ�
    v_HoldSum        number(15,0);   --�ֲֺϼ�
    v_HoldSum_b        number(15,0);   --�ֲֺϼ�b
    v_HoldSum_s        number(15,0);   --�ֲֺϼ�s
    v_A_OrderNo      number(15,0);   --ί�к�
    v_NotTradeSum    number(15,0);   --����δ�ɽ��ϼ�
    v_NotTradeSum_b    number(15,0);   --����δ�ɽ��ϼ�b
    v_NotTradeSum_s    number(15,0);   --����δ�ɽ��ϼ�s
    v_BreedID      number(10,0);
    v_LimitBreedQty      number(10,0);
    v_LimitCmdtyQty      number(10,0);
    v_FirmCleanQty      number(10,0);
    v_FirmMaxHoldQty      number(10,0);
    v_MaxHoldQty      number(10,0); --��������󶩻���
    v_MaxOverdraft        number(15,2):=0;   --���͸֧���
    v_F_FrozenFunds   number(15,2);   --�����ʽ�
    v_errorcode number;
    v_errormsg  varchar2(200);
begin
        --Ӧ�����ʽ�
        v_F_Funds := p_Margin + p_Fee;
        --��������ʽ�
        select VirtualFunds,MaxHoldQty,MaxOverdraft into v_VirtualFunds,v_MaxHoldQty,v_MaxOverdraft from T_Firm where FirmID = p_FirmID;
        --��������ʽ𣬲���ס�����ʽ�
        v_A_Funds := FN_F_GetRealFunds(p_FirmID,1) + v_VirtualFunds + v_MaxOverdraft;
        if(v_A_Funds < v_F_Funds) then
            rollback;
            return -1;  --�ʽ�����
        else
            --1����֤�Ƿ񳬹��������ܵ����ֲ���
            if(v_MaxHoldQty <> -1) then
                select nvl(sum(Quantity-TradeQty),0) into v_NotTradeSum
                from T_Orders
                where FirmID = p_FirmID
                and OrderType=1 and Status in(1,2);

                select nvl(sum(holdqty+GageQty),0) into v_HoldSum
                from T_FirmHoldSum
                where FirmID = p_FirmID;

                if(v_HoldSum + v_NotTradeSum + p_quantity > v_MaxHoldQty) then
                    rollback;
                    return -3;  --�����ܵ����ֲ���
                end if;
            end if;
            --��Ʒ�ֺ���Ʒ�����л�ȡƷ����󶩻�������Ʒ��󶩻�������������󾻶���������������󶩻���
            select a.BreedID,a.LimitBreedQty,b.LimitCmdtyQty,b.FirmCleanQty,b.FirmMaxHoldQty into v_BreedID,v_LimitBreedQty,v_LimitCmdtyQty,v_FirmCleanQty,v_FirmMaxHoldQty
            from T_A_Breed a,T_Commodity b
            where a.BreedID=b.BreedID and b.CommodityID=p_CommodityID;
            --��ȡ���������ⶩ����
            begin
                select CleanMaxHoldQty,MaxHoldQty
                into v_FirmCleanQty,v_FirmMaxHoldQty
                from T_A_FirmMaxHoldQty
                where FirmID=p_FirmID and CommodityID=p_CommodityID;
            exception
                when NO_DATA_FOUND then
                    null;
            end;
            --2����֤�Ƿ񳬹�Ʒ����󶩻���
            if(v_LimitBreedQty <> -1) then
                select nvl(sum(a.Quantity-a.TradeQty),0) into v_NotTradeSum
                from T_Orders a,T_Commodity b
                where a.CommodityID=b.CommodityID and b.BreedID=v_BreedID
                and a.OrderType=1 and a.BS_Flag=p_bs_flag and a.Status in(1,2);

                select nvl(sum(a.holdqty+a.GageQty),0) into v_HoldSum
                from T_FirmHoldSum a,T_Commodity b
                where a.CommodityID=b.CommodityID and b.BreedID=v_BreedID and a.BS_Flag=p_bs_flag;
                if(v_HoldSum + v_NotTradeSum + p_quantity > v_LimitBreedQty) then
                    rollback;
                    return -4;  --����Ʒ����󶩻���
                end if;
            end if;
            --3����֤�Ƿ񳬹���Ʒ��󶩻���
            if(v_LimitCmdtyQty <> -1) then
                select nvl(sum(Quantity-TradeQty),0) into v_NotTradeSum
                from T_Orders
                where CommodityID=p_CommodityID
                and OrderType=1 and BS_Flag=p_bs_flag and Status in(1,2);

                select nvl(sum(holdqty+GageQty),0) into v_HoldSum
                from T_FirmHoldSum
                where CommodityID=p_CommodityID and BS_Flag=p_bs_flag;
                if(v_HoldSum + v_NotTradeSum + p_quantity > v_LimitCmdtyQty) then
                    rollback;
                    return -5;  --������Ʒ��󶩻���
                end if;
            end if;
            --4����֤�Ƿ񳬹������̶Դ���Ʒ����󶩻���
            if(v_FirmMaxHoldQty <> -1) then
                select nvl(sum(Quantity-TradeQty),0) into v_NotTradeSum
                from T_Orders
                where FirmID = p_FirmID and CommodityID=p_CommodityID
                and OrderType=1 and Status in(1,2);

                select nvl(sum(holdqty+GageQty),0) into v_HoldSum
                from T_FirmHoldSum
                where FirmID = p_FirmID and CommodityID=p_CommodityID;

                if(v_HoldSum + v_NotTradeSum + p_quantity > v_FirmMaxHoldQty) then
                    rollback;
                    return -2;  --���������̶Դ���Ʒ����󶩻���
                end if;
            end if;
            --5����֤�Ƿ񳬹������̶Դ���Ʒ����󾻶�����
            if(v_FirmCleanQty <> -1) then
                select nvl(sum(holdqty+GageQty),0) into v_HoldSum_b
                from T_FirmHoldSum
                where FirmID = p_FirmID and CommodityID=p_CommodityID and BS_Flag=1;
                select nvl(sum(holdqty+GageQty),0) into v_HoldSum_s
                from T_FirmHoldSum
                where FirmID = p_FirmID and CommodityID=p_CommodityID and BS_Flag=2;
                if(p_bs_flag = 1) then
                    select nvl(sum(Quantity-TradeQty),0) into v_NotTradeSum_b
                    from T_Orders
                    where FirmID = p_FirmID and CommodityID=p_CommodityID and BS_Flag=1
                    and OrderType=1 and Status in(1,2);
                    if(v_HoldSum_b + v_NotTradeSum_b + p_quantity - v_HoldSum_s > v_FirmCleanQty) then
                        rollback;
                        return -6;  --���������̶Դ���Ʒ����󾻶�����
                    end if;
                else
                    select nvl(sum(Quantity-TradeQty),0) into v_NotTradeSum_s
                    from T_Orders
                    where FirmID = p_FirmID and CommodityID=p_CommodityID and BS_Flag=2
                    and OrderType=1 and Status in(1,2);
                    if(v_HoldSum_s + v_NotTradeSum_s + p_quantity - v_HoldSum_b > v_FirmCleanQty) then
                        rollback;
                        return -6;  --���������̶Դ���Ʒ����󾻶�����
                    end if;
                end if;
            end if;

        end if;

        --���¶����ʽ�
        v_F_FrozenFunds := FN_F_UpdateFrozenFunds(p_FirmID,v_F_Funds,'15');
        --����ί�б�������ί�е���
		--���ü��㺯���޸�ί�е��� 2011-2-15 by feijl
        select FN_T_ComputeOrderNo(SEQ_T_Orders.nextval) into v_A_OrderNo from dual;
        insert into T_Orders
          (a_orderno,a_orderno_w, CommodityID, Firmid, traderid,    bs_flag, ordertype, status, quantity, price, closemode, specprice, timeflag, tradeqty, frozenfunds, unfrozenfunds, ordertime, withdrawtime, ordererip, signature, CustomerID,ConsignerID,specialOrderFlag)
        values
          (v_A_OrderNo,  null, p_CommodityID, p_Firmid, p_traderid, p_bs_flag,    1 ,      1, p_quantity, p_price, null,     null,      null,    0,         v_F_Funds,     0,           sysdate,      null,        null,     null,p_CustomerID,p_ConsignerID,p_specialOrderFlag);
        commit;
        return v_A_OrderNo;
exception
    when NO_DATA_FOUND then
        rollback;
        return -99;  --�������������
    when others then
    v_errorcode:=sqlcode;
    v_errormsg :=sqlerrm;
    rollback;
    insert into T_DBLog(err_date,name_proc,err_code,err_msg)
    values(sysdate,'FN_T_OpenOrder',v_errorcode,v_errormsg);
    commit;
    return -100;
end;
/

prompt
prompt Creating function FN_T_OPENTRADE
prompt ================================
prompt
create or replace function FN_T_OpenTrade(
    p_A_OrderNo     number,  --ί�е���
    p_M_TradeNo     number,  --��ϳɽ���
    p_Price         number,  --�ɽ���
    p_Quantity      number,   --�ɽ�����
    p_M_TradeNo_Opp     number,  --�Է���ϳɽ���
    p_CommodityID varchar2,
    p_FirmID     varchar2,
    p_TraderID       varchar2,
    p_bs_flag        number,
    p_status         number,
    p_orderQty       number,--ί������
    p_orderPrice          number,--ί�м۸�
    p_orderTradeQty       number,--ί���ѳɽ�����
    p_frozenfunds    number,
    p_unfrozenfunds  number,
    p_CustomerID        varchar2,
    p_OrderType      number,
    p_contractFactor number,
    p_MarginPriceType         number,     --����ɽ���֤���������� 0:ʵʱ�ͱ���ʱ�������ּۣ�1:ʵʱ�������ۣ����а����ս���ۣ�2:���а������ۣ����н���ʱ�����ս���ۣ�
    p_marginAlgr         number,
    p_marginRate_b         number,
    p_marginRate_s         number,
    p_marginAssure_b         number,
    p_marginAssure_s         number,
    p_feeAlgr       number,
    p_feeRate_b         number,
    p_feeRate_s         number,
    p_YesterBalancePrice    number,
    p_GageMode    number,
    p_TradeDate date,
    p_FirmID_opp     varchar2
) return number
/****
 * ���ֳɽ��ر�
 * 1��ע�ⲻҪ�ύcommit����Ϊ��ĺ���Ҫ��������
 * ����ֵ
 * 1 �ɹ�
 * -1 �ɽ���������δ�ɽ�����
 * -100 ��������
****/
as
    v_version varchar2(10):='1.0.2.2';
    v_num            number(10);
    v_to_unfrozenF   number(15,2):=0;
    v_Margin         number(15,2):=0;   --Ӧ�ձ�֤��
    v_Assure         number(15,2):=0;   --Ӧ�յ�����
    v_Fee            number(15,2):=0;   --Ӧ�շ���
    v_frozenMargin   number(15,2);   --Ӧ�ձ�֤��
    v_frozenFee      number(15,2);   --Ӧ�շ���
    v_A_TradeNo      number(15);
    v_A_HoldNo       number(15);
    v_MarginPrice    number(15,2);  --����ɽ���֤��ļ۸�
    v_unfrozenPrice    number(15,2);  --�����ͷŶ��ᱣ֤�������ѵļ۸�
    v_TradeType      number(1);
    v_F_FrozenFunds   number(15,2);
begin
      --���㱣֤��۸�
	  if(p_MarginPriceType = 1) then
	      v_MarginPrice := p_YesterBalancePrice;
	  else  -- default type is 0
		  v_MarginPrice := p_Price;
	  end if;
      if(p_TraderID is not null) then
          v_TradeType := 1;  --�н���Ա�ı�ʾ�������ף�����ƽ�֣�
      else
          v_TradeType := 4;  --����ԱΪ��Ϊί�н��ף�����ƽ�֣�
      end if;

        if(p_Quantity = p_orderQty - p_orderTradeQty) then
            v_to_unfrozenF := p_frozenfunds - p_unfrozenfunds;
            --����ί��
            update T_Orders
            set unfrozenfunds=unfrozenfunds + v_to_unfrozenF,
                tradeqty=tradeqty + p_Quantity,
                Status=3,UpdateTime=systimestamp(3)
            where A_orderNo = p_A_OrderNo;
        elsif(p_Quantity < p_orderQty - p_orderTradeQty) then
		    if(p_MarginPriceType = 1) then
		        v_unfrozenPrice := p_YesterBalancePrice;
		    else  -- default type is 0
			    v_unfrozenPrice := p_orderPrice;
		    end if;
            v_frozenMargin := FN_T_ComputeMarginByArgs(p_bs_flag,p_Quantity,v_unfrozenPrice,p_contractFactor,p_marginAlgr,p_marginRate_b,p_marginRate_s);
            if(v_frozenMargin < 0) then
                Raise_application_error(-20040, 'computeMargin error');
            end if;
            v_frozenFee := FN_T_ComputeFeeByArgs(p_bs_flag,p_Quantity,p_orderPrice,p_contractFactor,p_feeAlgr,p_feeRate_b,p_feeRate_s);
            if(v_frozenFee < 0) then
                Raise_application_error(-20030, 'computeFee error');
            end if;
            v_to_unfrozenF := v_frozenMargin + v_frozenFee;
            --����ί��
			if(p_status = 6) then  --״̬Ϊ���ֳɽ��󳷵���������ֳɽ��ر��ڳ����ر�֮�󣬲����ٸ���״̬��
	            update T_Orders
	            set unfrozenfunds=unfrozenfunds + v_to_unfrozenF,
	                tradeqty=tradeqty + p_Quantity,UpdateTime=systimestamp(3)
	            where A_orderNo = p_A_OrderNo;
			else
	            update T_Orders
	            set unfrozenfunds=unfrozenfunds + v_to_unfrozenF,
	                tradeqty=tradeqty + p_Quantity,Status=2,UpdateTime=systimestamp(3)
	            where A_orderNo = p_A_OrderNo;
			end if;
        else
            rollback;
            return -1;
        end if;
        --����ɽ���Ӧ�۳���������
        v_Fee := FN_T_ComputeFeeByArgs(p_bs_flag,p_Quantity,p_Price,p_contractFactor,p_feeAlgr,p_feeRate_b,p_feeRate_s);
        if(v_Fee < 0) then
          Raise_application_error(-20030, 'computeFee error');
        end if;
        --����ɽ���¼
		--���ü��㺯���޸ĳɽ����� 2011-2-15 by feijl
        select FN_T_ComputeTradeNo(SEQ_T_Trade.nextval) into v_A_TradeNo from dual;
        insert into T_Trade
          (a_tradeno,    m_tradeno, a_orderno,   tradetime, Firmid, CommodityID,   bs_flag,    ordertype,     price, quantity, close_pl, tradefee,TradeType,CustomerID,M_TradeNo_Opp,TradeAtClearDate,oppFirmID)
        values
          (v_A_TradeNo, p_M_TradeNo, p_A_OrderNo, sysdate, p_FirmID, p_CommodityID,p_bs_flag, p_OrderType,   p_price, p_quantity, 0,       v_Fee,v_TradeType,p_CustomerID,p_M_TradeNo_Opp,p_TradeDate,p_FirmID_opp);


		--���㱣֤��
        v_Margin := FN_T_ComputeMarginByArgs(p_bs_flag,p_Quantity,v_MarginPrice,p_contractFactor,p_marginAlgr,p_marginRate_b,p_marginRate_s);
        if(v_Margin < 0) then
            Raise_application_error(-20040, 'computeMargin error');
        end if;
        --���㵣����
        v_Assure := FN_T_ComputeAssureByArgs(p_bs_flag,p_Quantity,v_MarginPrice,p_contractFactor,p_marginAlgr,p_marginAssure_b,p_marginAssure_s);
        if(v_Assure < 0) then
            Raise_application_error(-20041, 'computeAssure error');
        end if;
        --��֤��Ӧ���ϵ�����
        v_Margin := v_Margin + v_Assure;

        --����ֲ���ϸ��
		--���ü��㺯���޸ĳֲֵ��� 2011-2-15 by feijl
        select FN_T_ComputeHoldNo(SEQ_T_HoldPosition.nextval) into v_A_HoldNo from dual;
        insert into T_Holdposition
          (a_holdno,    a_tradeno,  CommodityID,    CustomerID , bs_flag,   price,    holdqty,    openqty, holdtime,HoldMargin,HoldAssure,Firmid,FloatingLoss,AtClearDate)
        values
          (v_A_HoldNo, v_A_TradeNo, p_CommodityID, p_CustomerID, p_bs_flag, p_price, p_quantity,p_quantity, sysdate,v_Margin,v_Assure,    p_FirmID,   0,      p_TradeDate);

        --���½��׿ͻ��ֲֺϼƱ�
        select count(*) into v_num from T_CustomerHoldSum
        where CustomerID = p_CustomerID
          and CommodityID = p_CommodityID
          and bs_flag = p_bs_flag;
        if(v_num >0) then
            update T_CustomerHoldSum
            set holdQty = holdQty + p_Quantity,
            holdFunds = holdFunds + p_Price*p_Quantity*p_contractFactor,
            HoldMargin = HoldMargin + v_Margin,
            HoldAssure = HoldAssure + v_Assure,
            evenprice = (holdFunds + p_Price*p_Quantity*p_contractFactor)/((holdQty + GageQty + p_Quantity)*p_contractFactor)
            where CustomerID = p_CustomerID
            and CommodityID = p_CommodityID
            and bs_flag = p_bs_flag;
        else
          insert into T_CustomerHoldSum
            (CustomerID, CommodityID, bs_flag, holdQty, holdFunds,FloatingLoss, evenprice,FrozenQty,HoldMargin,HoldAssure,FirmID)
          values
            (p_CustomerID, p_CommodityID, p_bs_flag, p_Quantity, p_Price*p_Quantity*p_contractFactor,0, p_Price,0,v_Margin,v_Assure,p_FirmID);
        end if;

        --���½����ֲֺ̳ϼƱ�
        select count(*) into v_num from T_FirmHoldSum
        where Firmid = p_FirmID
          and CommodityID = p_CommodityID
          and bs_flag = p_bs_flag;
        if(v_num >0) then
            update T_FirmHoldSum
            set holdQty = holdQty + p_Quantity,
            holdFunds = holdFunds + p_Price*p_Quantity*p_contractFactor,
            HoldMargin = HoldMargin + v_Margin,
            HoldAssure = HoldAssure + v_Assure,
            evenprice = (holdFunds + p_Price*p_Quantity*p_contractFactor)/((holdQty + p_Quantity + decode(p_GageMode,1,GageQty,0))*p_contractFactor)
            where Firmid = p_FirmID
            and CommodityID = p_CommodityID
            and bs_flag = p_bs_flag;
        else
          insert into T_FirmHoldSum
            (FirmID, CommodityID,      bs_flag,  holdQty,        holdFunds,FloatingLoss, evenprice,HoldMargin,HoldAssure)
          values
            (p_FirmID, p_CommodityID, p_bs_flag, p_Quantity, p_Price*p_Quantity*p_contractFactor,0,         p_Price, v_Margin,  v_Assure);
        end if;

        --������ʱ��֤�����ʱ������
        update T_Firm
        set runtimemargin = runtimemargin + v_Margin,
            RuntimeAssure = RuntimeAssure + v_Assure
        where Firmid = p_FirmID;
        --���¶����ʽ𣬰������˲��ֵı�֤��
		v_F_FrozenFunds := FN_F_UpdateFrozenFunds(p_FirmID,-v_to_unfrozenF+v_Margin-v_Assure+v_Fee,'15');

        return 1;

end;
/

prompt
prompt Creating function FN_T_OUTSTOCKCONFIRM
prompt ======================================
prompt
create or replace function FN_T_OUTSTOCKCONFIRM(
p_stockId  varchar2, --ȷ���ջ��Ĳֵ�ID
p_operator varchar2 --����Ա
)
return number
/**
   *  ����Ĳֵ�����ȷ���ջ�������ж�������ֵ��������ֵ�ռ���й����ֵ������ٷֱȽ��и�β�
   *  ����ֵ
   *  1 ȷ���ջ��ɹ�
   *  0 �ֵ�����ʹ����
   * -1 δ�ҵ��˲ֵ����������Ϣ�޷�ȷ���ջ�
   * by ������ 2015-08-14
  ****/
 as
  v_tradeNo t_Settlematch.Matchid%type; --������Ա��
  v_buyTax number(15,2);--�������˰��
  v_hl_Amout number(15,2);--����ˮ
  v_sellIncome number(15,2);--�����ջ���
  v_sellIncome_Ref number(15,2);--������׼����
  v_payMent number(15,2);--ȫ��β��
  v_realpayMent number(15,2);--���ֵ�β��
  v_amount number(15,2);--���
  v_firmId_S t_Settlematch.Firmid_s%type;--���� ID
  v_firmId_B t_Settlematch.Firmid_b%type;--�� ID
  v_commodityId t_Settlematch.Commodityid%type;--��Ʒ����
  v_everyAmount number(15,2):=0;--���������Ĳֵ�����
  v_confirmAmount number(15,2);--ȷ���ջ�����Ʒ����
  v_stockTotal number(15,2):=0; --��Ʒ����
  v_received number(1); --�Ƿ��ջ�
  v_stockAmont number(15):=0;--�����ֵ�����
begin
  --�ҵ�ʱ������Ĺ��ڴ˲ֵ��Ľ�����Ժ�
  begin
    select tradeNo into v_tradeNo from (select tradeNo from Bi_tradeStock where stockid = p_stockId and status = 1 order by releasetime desc) where Rownum = 1;
  exception
    when NO_DATA_FOUND then
      return 0;
  end;

  --���Ҷ�Ӧ�Ľ��������Ϣ
  begin
    select sellincome,hl_Amount,sellincome_ref,Buytax,Firmid_s,Commodityid,Firmid_b  into
           v_sellIncome,v_hl_Amout,v_sellIncome_Ref,v_buyTax,v_firmId_S,v_commodityId,v_firmId_B from T_SETTLEMATCH where matchid = v_tradeNo for update;
  exception
    when NO_DATA_FOUND then
      return - 1;
  end;
  --��ѯ���й����ֵ�,������������вֵ�����
  for stock in (select * from BI_TRADESTOCK where tradeNo=v_tradeNo)
    loop
      --��ȷ�Ϲ����Ĳֵ��Ƿ�ȷ���ջ�
     select RECEIVED into v_received from (select RECEIVED from BI_BUSINESSRELATIONSHIP where  stockid=stock.stockId and BUYER=v_firmId_B
                 and seller=v_firmId_S order by selltime desc) where rowNum=1;
      --���û���ջ�
      if(v_received=0) then
      select quantity into v_everyAmount from BI_STOCK where stockId = stock.stockid ;
       v_stockTotal:=v_stockTotal+v_everyAmount;
       v_stockAmont:=v_stockAmont+1;
       end if;
      end loop;

      select quantity into v_confirmAmount from Bi_Stock where stockId = p_stockId;
      --����ֵ���Ϊ0
      if(v_stockTotal=0) then
      return -1;
      end if;

      --����β�� ( ������׼���� +����ˮ +˰�� - �����յ���Ǯ +˰�� )
      v_payMent:=(v_sellIncome_Ref+v_hl_Amout+v_buyTax)-(v_sellIncome+v_buyTax);
  --���ֻʣ��һ���ֵ�ûȷ���ջ����м�����Ǯ
  if(v_stockAmont=1) then
  v_realpayMent:=v_payMent;
  else
    v_realpayMent:=(v_payMent/v_stockTotal)*v_confirmAmount;
  end if;

  --��β��
  if(v_realpayMent!=0) then
    update t_Settlematch t set  t.Sellincome=t.Sellincome+v_realpayMent where t.matchId=v_tradeNo;
    --д��ˮ
    v_amount:=FN_F_UpdateFundsFull(v_firmId_S,'15009',v_realpayMent,v_tradeNo,v_commodityId,null,null);
    --д�뽻����Խ����־
    insert into t_Settlematchfundmanage(Id, Matchid, Firmid, Summaryno, Amount, Operatedate, Commodityid)
           values(seq_t_settlematchfundmanage.nextval,v_tradeNo,v_firmId_S,'15009',v_realpayMent,sysdate,v_commodityId);
    --д�뽻�������־
    insert into t_Settlematchlog(Id, Matchid, Operator, Operatelog, Updatetime)
           values(seq_t_settlematchlog.nextval,v_tradeNo,p_operator,'����ȷ���ջ�,�ֵ���:'||p_stockId||',�ջ���,���ID:'||v_tradeNo||'���:'||v_realpayMent,sysdate);
    end if;
    --���½������ʱ����䶯��
    update t_Settlematch t set t.modifier=p_operator,t.modifytime=sysdate where t.matchid=v_tradeNo;

    --���������ϵ����Ϊ���״̬
    update BI_BUSINESSRELATIONSHIP B set received=1,receiveddate=sysdate where b.selltime =
                 (select selltime from ( select selltime from BI_BUSINESSRELATIONSHIP where  stockid=p_stockId and BUYER=v_firmId_B
                 and seller=v_firmId_S order by selltime desc) where rowNum=1) and BUYER=v_firmId_B and seller=v_firmId_S and stockid=p_stockId;
      return 1;
end;
/

prompt
prompt Creating function FN_T_SELLBILLORDER
prompt ====================================
prompt
create or replace function FN_T_SellBillOrder(
    p_FirmID     varchar2,  --������ID
    p_TraderID       varchar2,  --����ԱID
    p_CommodityID varchar2,
    p_bs_flag        number,
    p_price          number,
    p_quantity       number,
  --p_Margin     number,     --ί��Ӧ�ձ�֤��
    p_Fee   number,   --ί��Ӧ��������
	p_CustomerID     varchar2,  --���׿ͻ�ID
	p_ConsignerID       varchar2 --ί��ԱID

) return number
/****
 * ���ֵ�ί��
 * ����ֵ
 * >0  �ɹ��ύ��������ί�е���
 * -1  �ʽ�����
 * -2  ���������̶Դ���Ʒ����󶩻���
 * -3  �����������ܵ���󶩻���
 * -4  ����Ʒ����󶩻���
 * -5  ������Ʒ��󶩻���
 * -6  ���������̶Դ���Ʒ����󾻶�����
 * -7  �����������ί����������java���жϣ�2009-09-18
 * -8  �ֶ��������ڿ�������
 * -9  û�ж�Ӧ����Ч�ֵ��ֶ���¼
 * -99  �������������
 * -100 ��������
****/
as
	--v_version varchar2(10):='1.0.0.9';
    v_F_Funds        number(15,2):=0;   --Ӧ�����ʽ�
    v_VirtualFunds   number(15,2);   --�����ʽ�
    v_A_Funds        number(15,2);   --�����ʽ�
    v_HoldSum        number(15,0);   --�ֲֺϼ�
	v_HoldSum_b        number(15,0);   --�ֲֺϼ�b
	v_HoldSum_s        number(15,0);   --�ֲֺϼ�s
    v_A_OrderNo      number(15,0);   --ί�к�
    v_NotTradeSum    number(15,0);   --����δ�ɽ��ϼ�
	v_NotTradeSum_b    number(15,0);   --����δ�ɽ��ϼ�b
	v_NotTradeSum_s    number(15,0);   --����δ�ɽ��ϼ�s
	v_BreedID      number(10,0);
	v_LimitBreedQty      number(10,0);
	v_LimitCmdtyQty      number(10,0);
	v_FirmCleanQty      number(10,0);
	v_FirmMaxHoldQty      number(10,0);
	v_MaxHoldQty      number(10,0); --��������󶩻���
	v_MaxOverdraft        number(15,2):=0;   --���͸֧���
	v_F_FrozenFunds   number(15,2);   --�����ʽ�
    v_errorcode number;
    v_errormsg  varchar2(200);
  v_AvailableQuantity number(10);--�������� add by yukx 20100507
begin

      begin
        select Quantity-FrozenQty into v_AvailableQuantity from T_ValidGageBill
        where FirmID=p_FirmID
          and CommodityID = p_CommodityID;
          --and BreedID=(select BreedID from t_commodity where CommodityID=p_CommodityID);
        exception
          when NO_DATA_FOUND then
  	      return -9;--û�ж�Ӧ����Ч�ֵ��ֶ���¼
      end;

      if(v_AvailableQuantity<p_Quantity) then
        return -8;--�ֶ��������ڿ�������
      end if;

        --Ӧ�����ʽ�
        --zhengxuan ��ΪӦ���������Ѳ����ᱣ֤��
        --v_F_Funds := p_Margin + p_Fee;
        v_F_Funds :=  p_Fee;

        --��������ʽ�
        select VirtualFunds,MaxHoldQty,MaxOverdraft into v_VirtualFunds,v_MaxHoldQty,v_MaxOverdraft from T_Firm where FirmID = p_FirmID;
        --��������ʽ𣬲���ס�����ʽ�
        v_A_Funds := FN_F_GetRealFunds(p_FirmID,1) + v_VirtualFunds + v_MaxOverdraft;
        if(v_A_Funds < v_F_Funds) then
            rollback;
            return -1;  --�ʽ�����
        else
            --1����֤�Ƿ񳬹��������ܵ����ֲ���
			if(v_MaxHoldQty <> -1) then
				select nvl(sum(Quantity-TradeQty),0) into v_NotTradeSum
	            from T_Orders
	            where FirmID = p_FirmID
				and OrderType=1 and Status in(1,2);

	            select nvl(sum(holdqty+GageQty),0) into v_HoldSum
	            from T_FirmHoldSum
	            where FirmID = p_FirmID;

	            if(v_HoldSum + v_NotTradeSum + p_quantity > v_MaxHoldQty) then
	                rollback;
	                return -3;  --�����ܵ����ֲ���
	            end if;
			end if;
			--��Ʒ�ֺ���Ʒ�����л�ȡƷ����󶩻�������Ʒ��󶩻�������������󾻶���������������󶩻���
			select a.BreedID,a.LimitBreedQty,b.LimitCmdtyQty,b.FirmCleanQty,b.FirmMaxHoldQty into v_BreedID,v_LimitBreedQty,v_LimitCmdtyQty,v_FirmCleanQty,v_FirmMaxHoldQty
			from T_A_Breed a,T_Commodity b
			where a.BreedID=b.BreedID and b.CommodityID=p_CommodityID;
			--��ȡ���������ⶩ����
		    begin
		        select CleanMaxHoldQty,MaxHoldQty
		    	into v_FirmCleanQty,v_FirmMaxHoldQty
		        from T_A_FirmMaxHoldQty
		        where FirmID=p_FirmID and CommodityID=p_CommodityID;
		    exception
		        when NO_DATA_FOUND then
		            null;
		    end;
			--2����֤�Ƿ񳬹�Ʒ����󶩻���
			if(v_LimitBreedQty <> -1) then
	            select nvl(sum(a.Quantity-a.TradeQty),0) into v_NotTradeSum
	            from T_Orders a,T_Commodity b
	            where a.CommodityID=b.CommodityID and b.BreedID=v_BreedID
				and a.OrderType=1 and a.BS_Flag=p_bs_flag and a.Status in(1,2);

	            select nvl(sum(a.holdqty+a.GageQty),0) into v_HoldSum
	            from T_FirmHoldSum a,T_Commodity b
	            where a.CommodityID=b.CommodityID and b.BreedID=v_BreedID and a.BS_Flag=p_bs_flag;
	            if(v_HoldSum + v_NotTradeSum + p_quantity > v_LimitBreedQty) then
	                rollback;
	                return -4;  --����Ʒ����󶩻���
	            end if;
			end if;
            --3����֤�Ƿ񳬹���Ʒ��󶩻���
			if(v_LimitCmdtyQty <> -1) then
	            select nvl(sum(Quantity-TradeQty),0) into v_NotTradeSum
	            from T_Orders
	            where CommodityID=p_CommodityID
				and OrderType=1 and BS_Flag=p_bs_flag and Status in(1,2);

	            select nvl(sum(holdqty+GageQty),0) into v_HoldSum
	            from T_FirmHoldSum
	            where CommodityID=p_CommodityID and BS_Flag=p_bs_flag;
	            if(v_HoldSum + v_NotTradeSum + p_quantity > v_LimitCmdtyQty) then
	                rollback;
	                return -5;  --������Ʒ��󶩻���
	            end if;
			end if;
            --4����֤�Ƿ񳬹������̶Դ���Ʒ����󶩻���
			if(v_FirmMaxHoldQty <> -1) then
	            select nvl(sum(Quantity-TradeQty),0) into v_NotTradeSum
	            from T_Orders
	            where FirmID = p_FirmID and CommodityID=p_CommodityID
				and OrderType=1 and Status in(1,2);

	            select nvl(sum(holdqty+GageQty),0) into v_HoldSum
	            from T_FirmHoldSum
	            where FirmID = p_FirmID and CommodityID=p_CommodityID;

	            if(v_HoldSum + v_NotTradeSum + p_quantity > v_FirmMaxHoldQty) then
	                rollback;
	                return -2;  --���������̶Դ���Ʒ����󶩻���
	            end if;
			end if;
            --5����֤�Ƿ񳬹������̶Դ���Ʒ����󾻶�����
			if(v_FirmCleanQty <> -1) then
	            select nvl(sum(holdqty+GageQty),0) into v_HoldSum_b
	            from T_FirmHoldSum
	            where FirmID = p_FirmID and CommodityID=p_CommodityID and BS_Flag=1;
	            select nvl(sum(holdqty+GageQty),0) into v_HoldSum_s
	            from T_FirmHoldSum
	            where FirmID = p_FirmID and CommodityID=p_CommodityID and BS_Flag=2;
	            if(p_bs_flag = 1) then
		            select nvl(sum(Quantity-TradeQty),0) into v_NotTradeSum_b
		            from T_Orders
		            where FirmID = p_FirmID and CommodityID=p_CommodityID and BS_Flag=1
					and OrderType=1 and Status in(1,2);
		            if(v_HoldSum_b + v_NotTradeSum_b + p_quantity - v_HoldSum_s > v_FirmCleanQty) then
		                rollback;
		                return -6;  --���������̶Դ���Ʒ����󾻶�����
		            end if;
		        else
		            select nvl(sum(Quantity-TradeQty),0) into v_NotTradeSum_s
		            from T_Orders
		            where FirmID = p_FirmID and CommodityID=p_CommodityID and BS_Flag=2
					and OrderType=1 and Status in(1,2);
		            if(v_HoldSum_s + v_NotTradeSum_s + p_quantity - v_HoldSum_b > v_FirmCleanQty) then
		                rollback;
		                return -6;  --���������̶Դ���Ʒ����󾻶�����
		            end if;
	            end if;
			end if;

       -- zhengxuan ������Ч�ֵ��ֶ���������
       update T_ValidGageBill set Frozenqty=Frozenqty+p_quantity where FirmID=p_FirmID
               and CommodityID=p_CommodityID; --BreedID=(select BreedID from t_commodity where CommodityID=p_CommodityID);

        end if;

        --���¶����ʽ�
		v_F_FrozenFunds := FN_F_UpdateFrozenFunds(p_FirmID,v_F_Funds,'15');
		--����ί�б�������ί�е���
		--���ü��㺯���޸�ί�е��� 2011-2-15 by feijl
	    select FN_T_ComputeOrderNo(SEQ_T_Orders.nextval) into v_A_OrderNo from dual;
	    --zhengxuan ���Ӳֵ���������
      insert into T_Orders
	      (a_orderno,a_orderno_w, CommodityID, Firmid, traderid,    bs_flag, ordertype, status, quantity, price, closemode, specprice, timeflag, tradeqty, frozenfunds, unfrozenfunds, ordertime, withdrawtime, ordererip, signature, CustomerID,ConsignerID,BillTradeType)
	    values
	      (v_A_OrderNo,  null, p_CommodityID, p_Firmid, p_traderid, p_bs_flag,    1 ,      1, p_quantity, p_price, null,     null,      null,    0,         v_F_Funds,     0,           sysdate,      null,        null,     null,p_CustomerID,p_ConsignerID,  1    );
	    commit;
	    return v_A_OrderNo;
exception
    when NO_DATA_FOUND then
        rollback;
        return -99;  --�������������
    when others then
    v_errorcode:=sqlcode;
    v_errormsg :=sqlerrm;
    rollback;
    insert into T_DBLog(err_date,name_proc,err_code,err_msg)
    values(sysdate,'FN_T_SellBillOrder',v_errorcode,v_errormsg);
    commit;
    return -100;
end;
/

prompt
prompt Creating function FN_T_SELLBILLTRADE
prompt ====================================
prompt
create or replace function FN_T_SellBillTrade (
    p_A_OrderNo     number,  --ί�е���
    p_M_TradeNo     number,  --��ϳɽ���
    p_Price         number,  --�ɽ���
    p_Quantity      number,   --�ɽ�����
	  p_M_TradeNo_Opp     number,  --�Է���ϳɽ���
    p_CommodityID varchar2,
    p_FirmID     varchar2,
    p_TraderID       varchar2,
    p_bs_flag        number,
    p_status         number,
    p_orderQty       number,--ί������
    p_orderPrice          number,--ί�м۸�
    p_orderTradeQty       number,--ί���ѳɽ�����
    p_frozenfunds    number,
    p_unfrozenfunds  number,
    p_CustomerID        varchar2,
    p_OrderType      number,
    p_contractFactor number,
	  p_MarginPriceType         number,     --����ɽ���֤���������� 0:ʵʱ�ͱ���ʱ�������ּۣ�1:ʵʱ�������ۣ����а����ս���ۣ�2:���а������ۣ����н���ʱ�����ս���ۣ�
    p_marginAlgr         number,
    p_marginRate_b         number,
    p_marginRate_s         number,
    p_marginAssure_b         number,
    p_marginAssure_s         number,
    p_feeAlgr       number,
    p_feeRate_b         number,
    p_feeRate_s         number,
    p_YesterBalancePrice    number,
    p_GageMode    number,
    p_TradeDate date,
    p_FirmID_opp     varchar2
) return number
/****
 * ���ֵ��ɽ��ر�
 * 1��ע�ⲻҪ�ύcommit����Ϊ��ĺ���Ҫ��������
 * ����ֵ
 * 1 �ɹ�
 * -1 �ɽ���������δ�ɽ�����
 * -100 ��������
****/
as
	v_version varchar2(10):='1.0.2.2';
    v_num            number(10);
    v_to_unfrozenF   number(15,2):=0;
    v_Margin         number(15,2):=0;   --Ӧ�ձ�֤��
	v_Assure         number(15,2):=0;   --Ӧ�յ�����
    v_Fee            number(15,2):=0;   --Ӧ�շ���
    v_frozenMargin   number(15,2);   --Ӧ�ձ�֤��
    v_frozenFee      number(15,2);   --Ӧ�շ���
    v_A_TradeNo      number(15);
    v_A_HoldNo       number(15);
    v_MarginPrice    number(15,2);  --����ɽ���֤��ļ۸�
	v_unfrozenPrice    number(15,2);  --�����ͷŶ��ᱣ֤�������ѵļ۸�
    v_TradeType      number(1);
	v_F_FrozenFunds   number(15,2);
begin
      --���㱣֤��۸�
	  if(p_MarginPriceType = 1) then
	      v_MarginPrice := p_YesterBalancePrice;
	  else  -- default type is 0
		  v_MarginPrice := p_Price;
	  end if;
    --zhengxuan ���ӵĳɽ���¼�ɽ�����Ϊ���ֵ���
    v_TradeType := 7;  --����Ϊ���ֵ�

    if(p_Quantity = p_orderQty - p_orderTradeQty) then
        v_to_unfrozenF := p_frozenfunds - p_unfrozenfunds;
        --����ί��
        update T_Orders
        set unfrozenfunds=unfrozenfunds + v_to_unfrozenF,
            tradeqty=tradeqty + p_Quantity,
            Status=3,UpdateTime=systimestamp(3)
        where A_orderNo = p_A_OrderNo;
    elsif(p_Quantity < p_orderQty - p_orderTradeQty) then
        if(p_MarginPriceType = 1) then
            v_unfrozenPrice := p_YesterBalancePrice;
        else  -- default type is 0
         v_unfrozenPrice := p_orderPrice;
        end if;
        --zhengxuan �ͷ����ֵ�ί�ж���������
        v_frozenMargin := 0 ;
        --FN_T_ComputeMarginByArgs(p_bs_flag,p_Quantity,v_unfrozenPrice,p_contractFactor,p_marginAlgr,p_marginRate_b,p_marginRate_s);
        if(v_frozenMargin < 0) then
            Raise_application_error(-20040, 'computeMargin error');
        end if;
        v_frozenFee := FN_T_ComputeFeeByArgs(p_bs_flag,p_Quantity,v_unfrozenPrice,p_contractFactor,p_feeAlgr,p_feeRate_b,p_feeRate_s);
        if(v_frozenFee < 0) then
            Raise_application_error(-20030, 'computeFee error');
        end if;
        v_to_unfrozenF := v_frozenMargin + v_frozenFee;
        --����ί��
        if(p_status = 6) then  --״̬Ϊ���ֳɽ��󳷵���������ֳɽ��ر��ڳ����ر�֮�󣬲����ٸ���״̬��
           update T_Orders
           set unfrozenfunds=unfrozenfunds + v_to_unfrozenF,
               tradeqty=tradeqty + p_Quantity,UpdateTime=systimestamp(3)
           where A_orderNo = p_A_OrderNo;
        else
           update T_Orders
           set unfrozenfunds=unfrozenfunds + v_to_unfrozenF,
               tradeqty=tradeqty + p_Quantity,Status=2,UpdateTime=systimestamp(3)
           where A_orderNo = p_A_OrderNo;
        end if;
    else
        rollback;
        return -1;
    end if;
    --����ɽ���Ӧ�۳���������
    v_Fee := FN_T_ComputeFeeByArgs(p_bs_flag,p_Quantity,p_Price,p_contractFactor,p_feeAlgr,p_feeRate_b,p_feeRate_s);
    if(v_Fee < 0) then
      Raise_application_error(-20030, 'computeFee error');
    end if;
    --����ɽ���¼
	--���ü��㺯���޸ĳɽ����� 2011-2-15 by feijl
    select FN_T_ComputeTradeNo(SEQ_T_Trade.nextval) into v_A_TradeNo from dual;
    insert into T_Trade
      (a_tradeno,    m_tradeno, a_orderno,   tradetime, Firmid, CommodityID,   bs_flag,    ordertype,     price, quantity, close_pl, tradefee,TradeType,CustomerID,M_TradeNo_Opp,TradeAtClearDate,oppFirmid)
    values
      (v_A_TradeNo, p_M_TradeNo, p_A_OrderNo, sysdate, p_FirmID, p_CommodityID,p_bs_flag, p_OrderType,   p_price, p_quantity, 0,       v_Fee,v_TradeType,p_CustomerID,p_M_TradeNo_Opp,p_TradeDate,p_FirmID_opp);

		-- zhengxuan ���㱣֤�� ���㱣֤��  ��֤��Ϊ0
    v_Margin := 0;
    --FN_T_ComputeMarginByArgs(p_bs_flag,p_Quantity,v_MarginPrice,p_contractFactor,p_marginAlgr,p_marginRate_b,p_marginRate_s);
    if(v_Margin < 0) then
        Raise_application_error(-20040, 'computeMargin error');
    end if;
    --zhengxuan ���㵣���� ���㵣����  ������Ϊ0
    v_Assure := 0;
    --FN_T_ComputeAssureByArgs(p_bs_flag,p_Quantity,v_MarginPrice,p_contractFactor,p_marginAlgr,p_marginAssure_b,p_marginAssure_s);
    if(v_Assure < 0) then
        Raise_application_error(-20041, 'computeAssure error');
    end if;
    --��֤��Ӧ���ϵ�����
    v_Margin := v_Margin + v_Assure;

    --����ֲ���ϸ��
    --zhengxuan  �ֱֲ�֤�𣬵�������0��
	--���ü��㺯���޸ĳֲֵ��� 2011-2-15 by feijl
    select FN_T_ComputeHoldNo(SEQ_T_HoldPosition.nextval) into v_A_HoldNo from dual;
    insert into T_Holdposition
      (a_holdno,    a_tradeno,  CommodityID,    CustomerID , bs_flag,   price,    holdqty,    openqty, holdtime,HoldMargin,HoldAssure,Firmid,FloatingLoss,AtClearDate,gageQty)
    values
      (v_A_HoldNo, v_A_TradeNo, p_CommodityID, p_CustomerID, p_bs_flag, p_price, 0       ,p_quantity, sysdate,      0   ,   0      ,    p_FirmID,   0,     p_TradeDate,p_quantity);

    --���½��׿ͻ��ֲֺϼƱ�
    --zhengxuan  �ֱֲ�֤�𣬵�������0��
    select count(*) into v_num from T_CustomerHoldSum
    where CustomerID = p_CustomerID
      and CommodityID = p_CommodityID
      and bs_flag = p_bs_flag;
    if(v_num >0) then
        update T_CustomerHoldSum
        set holdQty = holdQty + 0,
        holdFunds = holdFunds + p_Price*p_Quantity*p_contractFactor,
        HoldMargin = HoldMargin + 0,
        HoldAssure = HoldAssure + 0,
        evenprice = (holdFunds + p_Price*p_Quantity*p_contractFactor)/((holdQty + GageQty + p_Quantity)*p_contractFactor),
         gageQty = gageQty+p_Quantity
        where CustomerID = p_CustomerID
        and CommodityID = p_CommodityID
        and bs_flag = p_bs_flag;
    else
        insert into T_CustomerHoldSum
              (CustomerID  , CommodityID  , bs_flag  , holdQty,         holdFunds                  ,FloatingLoss, evenprice,FrozenQty,HoldMargin,HoldAssure,FirmID  ,gageQty)
        values
              (p_CustomerID, p_CommodityID, p_bs_flag,    0   , p_Price*p_Quantity*p_contractFactor,    0       , p_Price  ,     0   ,     0    ,    0     ,p_FirmID,p_Quantity);
    end if;

    --���½����ֲֺ̳ϼƱ�
    --zhengxuan �ֱֲ�֤�𣬵�������0 ��
    select count(*) into v_num from T_FirmHoldSum
    where Firmid = p_FirmID
    and CommodityID = p_CommodityID
    and bs_flag = p_bs_flag;

    if(v_num >0) then
        update T_FirmHoldSum
        set holdQty = holdQty + 0,
        holdFunds = holdFunds + decode(p_GageMode,1,p_Price*p_Quantity*p_contractFactor,0),--�ֲֽ��
        HoldMargin = HoldMargin + 0,
        HoldAssure = HoldAssure + 0,
        evenprice = decode(holdQty + decode(p_GageMode,1,p_Quantity,0) + decode(p_GageMode,1,GageQty,0), 0,
                  0,
                  (holdFunds +decode(p_GageMode,1,p_Price*p_Quantity*p_contractFactor,0))/((holdQty + decode(p_GageMode,1,p_Quantity,0) + decode(p_GageMode,1,GageQty,0))*p_contractFactor) ), --����
        gageQty = gageQty+p_Quantity
        where Firmid = p_FirmID
        and CommodityID = p_CommodityID
        and bs_flag = p_bs_flag;
    else
      insert into T_FirmHoldSum
        (FirmID  , CommodityID  ,   bs_flag, holdQty,                       holdFunds                           ,FloatingLoss,        evenprice                ,HoldMargin,HoldAssure,gageQty)
      values
        (p_FirmID, p_CommodityID, p_bs_flag,   0   , decode(p_GageMode,1,p_Price*p_Quantity*p_contractFactor,0) ,     0      ,   decode(p_GageMode,1,p_Price,0),  0       ,  0       ,p_Quantity);
    end if;

    --������ʱ��֤�����ʱ������
    update T_Firm
    set runtimemargin = runtimemargin + v_Margin,
        RuntimeAssure = RuntimeAssure + v_Assure
    where Firmid = p_FirmID;
    --���¶����ʽ𣬰������˲��ֵı�֤��
    v_F_FrozenFunds := FN_F_UpdateFrozenFunds(p_FirmID,-v_to_unfrozenF+v_Margin-v_Assure+v_Fee,'15');

    --zhengxuan ��Ч�ֵ��ֶ����ͷŶ���������������������
    update T_ValidGageBill set Quantity=Quantity-p_Quantity,Frozenqty=Frozenqty-p_Quantity where FirmID=p_FirmID
           and CommodityID=p_CommodityID; --BreedID=(select BreedID from t_commodity where CommodityID=p_CommodityID);
    return 1;
end;
/

prompt
prompt Creating function FN_T_SETTLECANCEL
prompt ===================================
prompt
create or replace function Fn_T_SettleCancel
(
    p_matchId varchar2, --��Ա��
    p_operator varchar2 --������
) return number
/****
 * ������Ե��ô˴洢
 * ����ֵ
 *  1 �ɹ�  ����ʧ��
 *  2 �������
 *  3 ����
 *  4 �ѻ�Ȩת��
****/
as
 v_status number;  --���״̬  0 δ���� 1 ������ 2 ������� 3 ����
 v_isTransfer number;--�Ƿ��Ȩת�� 0��δ��Ȩת�� 1���ѻ�Ȩת��
 v_Balance number(15,2):=0;
begin
     select status,isTransfer into v_status,v_isTransfer from t_settlematch where matchId=p_matchId for update;
     if(v_status=2 or v_status=3)then
        return v_status;
     elsif(v_status=1 and v_isTransfer=1)then
        return 4;
     else
         --��ѯ��Թ�������ԭ���ճֲ���ϸ����
         for rel in (select * from T_MatchSettleholdRelevance t where t.matchid=p_matchId)
         loop
           update t_settleholdposition set happenmatchqty=happenmatchqty-rel.quantity,happenMatchSettleMargin=happenMatchSettleMargin-rel.settlemargin,
           happenMatchPayout=happenMatchPayout-rel.settlePayOut,matchstatus=decode(happenmatchqty-rel.quantity,0,0,1) where id=rel.settleId;
         end loop;
          --��ѯ������Խ������ԭ��Դ���Ľ��
         for man in (select * from T_SettleMatchFundManage t where t.matchid=p_matchId)
         loop
           v_Balance := FN_F_UpdateFundsFull(man.firmId,man.summaryNo,-man.amount,p_matchId,man.commodityId,null,null);
           if(man.summaryNo='15013')then
              update T_Firm set RuntimeSettleMargin=RuntimeSettleMargin-man.amount where firmid = man.firmid;
           elsif(man.summaryNo='15014')then
              update T_Firm set RuntimeSettleMargin=RuntimeSettleMargin+man.amount where firmid = man.firmid;
           end if;
           insert into T_SettleMatchFundManage(id,MatchID,Firmid,Summaryno,Amount,Operatedate,Commodityid)
           values (SEQ_T_SettleMatchFundManage.Nextval,man.matchId,man.firmId,man.summaryNo,-man.amount,sysdate,man.commodityId);
         end loop;
         --����ʱ����Ӧ�ĳֲֵ����ϵ�˰�ѽ��д��� by ������ 2015/08/14
         for woman in (select * from t_Settleandhold t where t.matchid=p_matchId)
           loop
             if(woman.bs_flag='1')then
             update t_Settleholdposition  set SETTLEADDEDTAX=SETTLEADDEDTAX-woman.tax where ID = woman.settleholdpositionid;
             end if;
          end loop;

         --�޸����״̬Ϊ����
            update t_settlematch set status=3,modifier=p_operator,modifyTime=sysdate where matchId=p_matchId;
         --���뽻�������־
            insert into t_settlematchlog (id,matchid,operator,operatelog,updatetime)
            values (SEQ_t_settlematchlog.Nextval,p_matchId,p_operator,'���������ID:'||p_matchId,sysdate);
          --ɾ����Թ�����
          delete from T_MatchSettleholdRelevance where matchid=p_matchId;
          --ɾ���ֵ������
          --2014-01-21����ʱ��ɾ���ֵ���������㳷���󿴲ֵ���Ϣ
          --delete from T_billFrozen where Operation=p_matchId;
         return 1;
     end if;
end;
/

prompt
prompt Creating function FN_T_SETTLEMATCH
prompt ==================================
prompt
create or replace function FN_T_SettleMatch
(
    p_commodityId varchar2, --��Ʒ����
    p_quantity number,  --��������
    p_status number, --״̬
    p_result number, --��Լ״̬
    p_firmID_B varchar2,  --�򷽽����̴���
    p_firmID_S varchar2,  --���������̴���
    p_settleDate varchar2, --��������
    p_matchId varchar2 ,--��Ա��
    p_operator varchar2 --������
) return number
/****
 *
 *  ��ѯ�ֲ�ʱ���˽������Ͳ�Ϊ��ǰ���ռ��ɣ���������Ʒ�����걨���������⣬���ճֲֲ������ͬʱ�������ں͵��ڽ��յ�����������������⣬��ʱ�ų��������
 *  ������ʱ��������ֻ����Ʒ���õĽ���������ֲֵĽ��������޹�
 * ����ֵ
 *  1 �ɹ�
 * -1 �򷽳ֲֲ���
 * -2 �����ֲֲ���
****/
as
 v_contractFactor number;  --��Լ����
 v_buypayout_ref number(15,2):=0;--�򷽲ο�����
 v_buyPayout number(15,2):=0;--�����򷽻���
 v_sellincom_ref number(15,2):=0;--�����ο�����
 v_buyMargin number(15,2):=0;--�򷽽��ձ�֤��
 v_sellMargin number(15,2):=0;--�������ձ�֤��
 v_everybuyPayout number(15,2):=0;--��ÿ�ʳֲ����ջ���
 v_everybuyMargin number(15,2):=0;--��ÿ�ʳֲֽ��ձ�֤��
 v_everysellMargin number(15,2):=0;--����ÿ�ʳֲֽ��ձ�֤��
 v_price number;
 v_settleprice_b number:=0;
 v_settleprice_s number:=0;
 v_weight number(15,4);
 v_amountQty_s number(10);
 v_amountQty_b number(10);
 v_quantity number(10);
 v_settlePriceType number(2); --���ڽ��ռ۸���� 0,1,3 ͳһ�� 2������
 v_delaySettlePriceType number(2);--���ڽ����걨���ռ۸����� 0ͳһ�� 1������
 v_settleType number(2);--��Ա�Ľ��շ�ʽ 1���� 3����
 v_settleDate varchar2(20);--�������� �����ڽ���ȡ�ֲ���ϸ�Ľ��մ������ڣ�����Ϊp_settleDate��
 v_settleWay number(2);--��Ʒ���շ�ʽ0��Զ�ڣ����ڣ� 1�����ֻ������ڣ� 2ר������ �����ڣ�
 v_count number;
 v_taxIncluesive number(1);--��Ʒ�۸����Ƿ�˰  1 ����˰ 0 ��˰
 v_addedtax number(10,4):=0;--��Ʒ��ֵ˰��
 v_buytax number(15,2):=0;--����˰
 v_everytax number(15,2):=0;--ÿ��˰��
 v_fundsflow number;--û�õ���ˮ����ֵ
begin
    --����ʷ��Ʒ���ѯ��Ʒ���� �����ʷ�鲻���鵱ǰ��Ʒ����Ϊ���׽���ʱ��Ʒ����ʷ�������ڽ��׽���ǰ������������걨���ʱֻ�ܲ鵱ǰ��Ʒ��
    select count(*) into v_count from t_h_commodity where commodityid=p_commodityId and trunc(cleardate)=to_date(p_settleDate,'yyyy-MM-dd');
    if v_count=0 then
       select settlepricetype,delaySettlePriceType,contractFactor,settleWay,TAXINCLUSIVE,addedtax into v_settlePriceType,v_delaySettlePriceType,v_contractFactor,v_settleWay,v_taxIncluesive,v_addedtax from t_commodity where commodityid=p_commodityId;
    else
       select settlepricetype,delaySettlePriceType,contractFactor,settleWay,TAXINCLUSIVE,addedtax into v_settlePriceType,v_delaySettlePriceType,v_contractFactor,v_settleWay,v_taxIncluesive,v_addedtax from t_h_commodity where commodityid=p_commodityId and trunc(cleardate)=to_date(p_settleDate,'yyyy-MM-dd');
    end if;
--���ڽ��ջ��ǵ��ڽ��գ�settleType =1Ϊ���ڶ����۽������Ϊ���ڽ���
    if v_settleWay=1 then
       v_settleType:=3;
       if v_delaySettlePriceType=1 then
          v_settlePriceType:=2;
       end if;
    else
        v_settleType:=1;
    end if;
    --��ѯ����˫���Ŀ��������
    select  nvl(sum(HoldQty+GageQty-happenMATCHQTY),0)  into v_amountQty_b from t_settleholdposition t where CommodityID=p_commodityId and BS_Flag=1 and FirmID=p_firmID_B and settletype<>2 and trunc(SettleProcessDate)=to_date(p_settleDate,'yyyy-MM-dd') ;
    select  nvl(sum(HoldQty+GageQty-happenMATCHQTY),0) into v_amountQty_s from t_settleholdposition t where CommodityID=p_commodityId and BS_Flag=2 and FirmID=p_firmID_S and settletype<>2 and trunc(SettleProcessDate)=to_date(p_settleDate,'yyyy-MM-dd') ;
    if(v_amountQty_b<p_quantity)then
        return -1;--�򷽳ֲֲ���
    end if;
    if(v_amountQty_s<p_quantity)then
        return -2;--�����ֲֲ���
    end if;

   --��
   v_weight:=p_quantity;--�������
   for debit in (select * from t_settleholdposition t where CommodityID=p_commodityId and BS_Flag=1 and FirmID=p_firmID_B and settletype<>2 and trunc(SettleProcessDate)=to_date(p_settleDate,'yyyy-MM-dd') order by a_holdno asc)
    loop
       v_settleDate:=p_settleDate;
       v_quantity:=debit.HoldQty+debit.GageQty-debit.happenmatchqty;
       if(v_settlePriceType=2)then
          v_price:=debit.price;
       else
          v_price:=debit.settlePrice;
       end if;
      v_settleprice_b:=debit.settlePrice;
      --�������
      if v_quantity > v_weight  then
        --�����Ʒ�����к�˰
         if(v_taxIncluesive=0) then
         --˰��
         v_everytax:=(v_price*v_weight*v_contractFactor)*(v_addedtax/(1+v_addedtax));
        --��׼���� = ���� - ˰��
          v_buypayout_ref:=v_buypayout_ref+(v_price*v_weight*v_contractFactor-v_everytax);
          --�����Ʒ�����в���˰
         else
           --˰��
           v_everytax:=(v_price*v_weight*v_contractFactor)*v_addedtax;
          --��׼�����
          v_buypayout_ref:=v_buypayout_ref+v_price*v_weight*v_contractFactor;
         end if;
         --ÿ�ʽ��ջ���
          v_everybuyPayout:=debit.Payout/(debit.HoldQty+debit.GageQty)*v_weight;
          --��֤��
          v_everybuyMargin:=debit.SettleMargin/(debit.HoldQty+debit.GageQty)*v_weight;
          v_buyPayout:=v_buyPayout+v_everybuyPayout;
          v_buyMargin:=v_buyMargin+v_everybuyMargin;
          --˰��
          v_buytax:=v_buytax + v_everytax;
          --�޸Ľ��ճֲ���ϸ���״̬=������ԣ����������������Ի������Ա�֤��
          update T_SettleHoldPosition set MATCHStatus=1,happenmatchqty = happenmatchqty + v_weight,happenMatchPayout=happenMatchPayout+v_everybuyPayout ,
                 happenMatchSettleMargin=happenMatchSettleMargin+v_everybuyMargin,SETTLEADDEDTAX=debit.SETTLEADDEDTAX+v_everytax where id=debit.id;
          --���뽻����Թ�����
          insert into T_MatchSettleholdRelevance (MatchID, SettleID, Quantity, Price, SettlePayOut, Settlemargin) values (p_matchId, debit.id, v_weight, v_price, v_everybuyPayout, v_everybuyMargin);
          v_weight:=0;
      else
        --ȫ����Ե����
         if v_quantity > 0 then
         --�����Ʒ�����к�˰
         if(v_taxIncluesive=0) then
         --˰��
         v_everytax:=(v_price*v_quantity*v_contractFactor)*(v_addedtax/(1+v_addedtax));
        --��׼���� = ���� - ˰��
          v_buypayout_ref:=v_buypayout_ref+(v_price*v_quantity*v_contractFactor-v_everytax);
          --�����Ʒ�����в���˰
         else
           --˰��
           v_everytax:=(v_price*v_quantity*v_contractFactor)*v_addedtax;
          --��׼�����
          v_buypayout_ref:=v_buypayout_ref+v_price*v_quantity*v_contractFactor;
         end if;
          v_weight:=v_weight - v_quantity;
          --���һ�ʳֲ��ü�����������Ի���ͱ�֤��
          v_everybuyPayout:=debit.Payout-debit.happenMatchPayout;
          v_everybuyMargin:=debit.SettleMargin-debit.happenMatchSettleMargin;
          v_buyPayout:=v_buyPayout+v_everybuyPayout;
          v_buyMargin:=v_buyMargin+v_everybuyMargin;
           --˰��
          v_buytax:=v_buytax + v_everytax;
          --�޸Ľ��ճֲ���ϸ���״̬=ȫ����ԣ����������������Ի������Ա�֤��
          update T_SettleHoldPosition set MATCHStatus=2,happenmatchqty = debit.HoldQty+debit.GageQty ,happenMatchPayout=happenMatchPayout+v_everybuyPayout ,
                 happenMatchSettleMargin=happenMatchSettleMargin+v_everybuyMargin,SETTLEADDEDTAX=debit.SETTLEADDEDTAX+v_everytax  where id=debit.id;
          --���뽻����Թ�����
          insert into T_MatchSettleholdRelevance (MatchID, SettleID, Quantity, Price, SettlePayOut, Settlemargin) values (p_matchId, debit.id, v_quantity, v_price, v_everybuyPayout, v_everybuyMargin);
        end if;
      end if;
      exit when v_weight=0;
    end loop;

    --����
    v_weight:=p_quantity;--�������
    for debit in (select * from t_settleholdposition t where CommodityID=p_commodityId and BS_Flag=2 and FirmID=p_firmID_S and settletype<>2 and trunc(SettleProcessDate)=to_date(p_settleDate,'yyyy-MM-dd') order by a_holdno asc)
     loop
      v_settleDate:=p_settleDate;
      v_quantity:=debit.HoldQty+debit.GageQty-debit.happenmatchqty;
      if(v_settlePriceType=2)then
          v_price:=debit.price;
      else
          v_price:=debit.settlePrice;
      end if;
      v_settleprice_s:=debit.settlePrice;
      if v_quantity > v_weight  then
         --�����Ʒ�����к�˰
         if(v_taxIncluesive=0) then
         --˰��
          v_everytax:=(v_price*v_weight*v_contractFactor)*(v_addedtax /(1+v_addedtax));
        --��׼���� = ���� - ˰��
           v_sellincom_ref:=v_sellincom_ref+(v_price*v_weight*v_contractFactor-v_everytax);
          --�����Ʒ�����в���˰
         else
          --��׼�����
            v_sellincom_ref:=v_sellincom_ref+v_price*v_weight*v_contractFactor;
         end if;
          v_everysellMargin:=debit.SettleMargin/(debit.HoldQty+debit.GageQty)*v_weight;
          v_sellMargin:=v_sellMargin+v_everysellMargin;
          --�޸Ľ��ճֲ���ϸ���״̬=������ԣ����������������Ա�֤��
          update T_SettleHoldPosition set MATCHStatus=1,happenmatchqty = happenmatchqty + v_weight,
                 happenMatchSettleMargin=happenMatchSettleMargin+v_everysellMargin where id=debit.id;
          --���뽻����Թ�����
          insert into T_MatchSettleholdRelevance (MatchID, SettleID, Quantity, Price, SettlePayOut, Settlemargin) values (p_matchId, debit.id, v_weight, v_price, 0, v_everysellMargin);
          v_weight:=0;
      else
         if v_quantity > 0 then
            --�����Ʒ�����к�˰
         if(v_taxIncluesive=0) then
          v_everytax:=(v_price*v_quantity*v_contractFactor)*(v_addedtax/(1+v_addedtax));
        --��׼���� = ���� - ˰��
          v_sellincom_ref:=v_sellincom_ref+(v_price*v_quantity*v_contractFactor-v_everytax);
          --�����Ʒ�����в���˰
         else
           --˰��
           --v_everytax:=(v_price*v_quantity*v_contractFactor)*v_addedtax;
          --��׼�����
          v_sellincom_ref:=v_sellincom_ref+v_price*v_quantity*v_contractFactor;
         end if;
          v_everysellMargin:=debit.SettleMargin-debit.happenMatchSettleMargin;
          v_sellMargin:=v_sellMargin+v_everysellMargin;
          v_weight:=v_weight - v_quantity;
          --�޸Ľ��ճֲ���ϸ���״̬=ȫ����ԣ����������������Ա�֤��
          update T_SettleHoldPosition set MATCHStatus=2,happenmatchqty = debit.HoldQty+debit.GageQty ,
                 happenMatchSettleMargin=happenMatchSettleMargin+v_everysellMargin where id=debit.id;
          --���뽻����Թ�����
          insert into T_MatchSettleholdRelevance (MatchID, SettleID, Quantity, Price, SettlePayOut, Settlemargin) values (p_matchId, debit.id, v_quantity, v_price, 0, v_everysellMargin);
        end if;
      end if;
      exit when v_weight=0;
    end loop;
    --���뽻����Ա�
    insert into T_SettleMatch (MatchID,  CommodityID,  ContractFactor,  Quantity,Status,Result,SettleType, FirmID_B,  BuyPrice,  BuyPayout_Ref,  BuyPayout,  BuyMargin,
                               FirmID_S,SellPrice,SellIncome_Ref,SellIncome,SellMargin,CreateTime,ModifyTime,SettleDate, Modifier,buytax,taxIncluesive)
                         values(p_matchId,p_commodityId,v_contractFactor,p_quantity,p_status,p_result,v_settleType,p_firmID_B,v_settleprice_b,v_buypayout_ref,v_buyPayout,v_buyMargin,
                               p_firmID_S,v_settleprice_s,v_sellincom_ref,0,v_sellMargin,sysdate, sysdate,to_date(v_settleDate,'yyyy-MM-dd'),p_operator,v_buytax,v_taxIncluesive);
    --���뽻�������־��
    insert into T_SettleMatchLog(id,Matchid,operator,Operatelog,Updatetime) values(seq_t_settlematchlog.nextval,p_matchId,p_operator,'��ӽ�����ԣ��������'||p_quantity||',�򷽣�'||p_firmID_B||',�۸�'||v_settleprice_b||',����:'||p_firmID_S||'�۸�'||v_settleprice_s,sysdate);
     --��Գɹ������Ƚ�˰�ո��� ,������Ʒ�Ƿ�˰�����շ� ,����˰��,���������Լ��������˰����ȡ
     if(p_result =1) then
       v_fundsflow:=fn_f_updatefundsfull(p_firmID_B,'15100',v_buytax,p_matchId,p_commodityId,null,null);
      insert into T_SettleMatchFundManage(Id,Matchid,Firmid,Summaryno,Amount,Operatedate,Commodityid) values(seq_t_settlematchfundmanage.nextval,p_matchId,p_firmID_B,'15100',v_buytax,sysdate,p_commodityId);
      --д�����־
      insert into t_Settlematchlog(id,Matchid,Operator,Operatelog,Updatetime) values(seq_t_settlematchlog.nextval,p_matchId,'ϵͳ','������ֵ˰,���ID:'||p_matchId||' ���:'||v_buytax,sysdate);
      --������˰����ˮ
       v_fundsflow:=fn_f_updatefundsfull(p_firmID_S,'15101',v_buytax,p_matchId,p_commodityId,null,null);
      insert into T_SettleMatchFundManage(Id,Matchid,Firmid,Summaryno,Amount,Operatedate,Commodityid) values(seq_t_settlematchfundmanage.nextval,p_matchId,p_firmID_S,'15101',v_buytax,sysdate,p_commodityId);
      insert into t_Settlematchlog(id,Matchid,Operator,Operatelog,Updatetime) values(seq_t_settlematchlog.nextval,p_matchId,'ϵͳ','��������ֵ˰,���ID:'||p_matchId||' ���:'||v_buytax,sysdate);
      end if;
return 1;
end;
/

prompt
prompt Creating function FN_T_TRADEDAYEND
prompt ==================================
prompt
create or replace function FN_T_TradeDayEnd
return varchar2
/****
 * �������ڱ���������ɶ����
 * ����ֵ �ַ���
 * �ɹ� ���ؽ��������ַ���������'2009-08-01'
 * '-1' ����ϵͳ״̬���ǽ��׽�����ɻ����������
****/
as
	v_version varchar2(10):='1.0.2.2';
    v_CommodityID varchar2(16);
    v_FirmID varchar2(32);
    v_Margin         number(15,2):=0;
    v_Assure         number(15,2):=0;
    v_FloatLoss         number(15,2):=0;        --����ֲ���ϸ�ĸ���ӯ���ϼƣ���ֵΪ��ӯ����Ϊ����
    v_TradeDate date;
    v_Status number(2);
	v_FloatingLossComputeType number(2);
	v_LastFloatingLossComputeType number(2);
	v_TradeFlowType number(2);
	v_Balance    number(15,2);
	v_num            number(10);
	v_ret           number(5);

    --����Ʒд��ˮ�α�
    type cur_CmdtyDaily is ref cursor;
	v_CmdtyDaily cur_CmdtyDaily;
	v_sql varchar2(500);

  -- add by yukx 20100428 ���ڼ�¼���׿ͻ��ֲֺϼƱ�Ķ��������͵ֶ���������
  v_c_customerid varchar2(40);
  v_c_commodityid varchar2(16);
  v_c_bs_flag number(5);
  v_c_frozenqty number(10);
  v_c_gagefrozenqty number(10);
  type cue_qtyAboutCustonerhold is ref cursor;
  v_qtyAboutCustonerhold cue_qtyAboutCustonerhold;

begin
      -- һ����ȡ�������ڡ��������㷽ʽ
	  select TradeDate,Status into v_TradeDate,v_Status from T_SystemStatus;
	  --�ж��ܷ������ڱ��
	  if(v_Status <> 10 and v_Status <> 3) then
	  	  rollback;
	  	  return '-1';
	  end if;

	  --�������ڽ��׽���
	  v_ret := FN_T_D_CloseProcess();

      select FloatingLossComputeType,TradeFlowType into v_FloatingLossComputeType,v_TradeFlowType from T_A_Market;
      v_ret := FN_T_TradeFlow(v_TradeFlowType);
      -- �����ˡ����ʽ�д��ˮ
        --1�����ս��㱣֤��
        v_sql := 'select FirmID,CommodityID,sum(HoldMargin)-sum(HoldAssure),sum(HoldAssure) from T_H_FirmHoldSum where ClearDate =(select max(ClearDate) from T_H_Market) group by FirmID,CommodityID';
        open v_CmdtyDaily for v_sql;
        loop
            fetch v_CmdtyDaily into v_FirmID,v_CommodityID,v_Margin,v_Assure;
            exit when v_CmdtyDaily%NOTFOUND;
			--�����ʽ�����д�����ս��㱣֤����ˮ
			if(v_Margin <> 0) then
	    		v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15003',v_Margin,null,v_CommodityID,v_Assure,null);
	    	end if;
        end loop;
        close v_CmdtyDaily;

        --2�۳�������㱣֤��
        v_sql := 'select FirmID,CommodityID,sum(HoldMargin)-sum(HoldAssure),sum(HoldAssure) from T_FirmHoldSum group by FirmID,CommodityID';
        open v_CmdtyDaily for v_sql;
        loop
            fetch v_CmdtyDaily into v_FirmID,v_CommodityID,v_Margin,v_Assure;
            exit when v_CmdtyDaily%NOTFOUND;
			--�����ʽ�����д�����ս��㱣֤����ˮ
			if(v_Margin <> 0) then
	    		v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15002',v_Margin,null,v_CommodityID,v_Assure,null);
	    	end if;
        end loop;
        close v_CmdtyDaily;

        --3����������ս��׵������������ո���
	    select count(*) into v_num from T_H_Market where ClearDate =(select max(ClearDate) from T_H_Market);
	    if(v_num >0) then
	        --��ȡ��һ�����յĸ������㷽ʽ
	        select FloatingLossComputeType into v_LastFloatingLossComputeType from T_H_Market where ClearDate =(select max(ClearDate) from T_H_Market);
		    if(v_LastFloatingLossComputeType = 0) then     --��Ʒ������
		        v_sql := 'select FirmID,CommodityID,sum(case when FloatingLoss>0 then 0 else -FloatingLoss end) from T_H_FirmHoldSum where ClearDate =(select max(ClearDate) from T_H_Market) group by FirmID,CommodityID';
		        open v_CmdtyDaily for v_sql;
		        loop
		            fetch v_CmdtyDaily into v_FirmID,v_CommodityID,v_FloatLoss;
		            exit when v_CmdtyDaily%NOTFOUND;
					--�����ʽ�����д�����ո�����ˮ
					if(v_FloatLoss <> 0) then
			    		v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15005',v_FloatLoss,null,v_CommodityID,null,null);
			    	end if;
		        end loop;
		        close v_CmdtyDaily;
		    elsif(v_LastFloatingLossComputeType = 1) then  --��Ʒ��������
		        v_sql := 'select FirmID,CommodityID,sum(FloatingLoss) from T_H_FirmHoldSum where ClearDate =(select max(ClearDate) from T_H_Market) group by FirmID,CommodityID';
		        open v_CmdtyDaily for v_sql;
		        loop
		            fetch v_CmdtyDaily into v_FirmID,v_CommodityID,v_FloatLoss;
		            exit when v_CmdtyDaily%NOTFOUND;
		            if(v_FloatLoss <= 0) then
		            	v_FloatLoss := -v_FloatLoss;
						--�����ʽ�����д�����ո�����ˮ
						if(v_FloatLoss <> 0) then
				    		v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15005',v_FloatLoss,null,v_CommodityID,null,null);
				    	end if;
			        end if;
		        end loop;
		        close v_CmdtyDaily;
		    elsif(v_LastFloatingLossComputeType = 2) then  --������Ʒ
		        v_sql := 'select FirmID,case when sum(FloatingLoss) >0 then 0 else  -sum(FloatingLoss) end from T_H_FirmHoldSum where ClearDate =(select max(ClearDate) from T_H_Market) group by FirmID ';
		        open v_CmdtyDaily for v_sql;
		        loop
		            fetch v_CmdtyDaily into v_FirmID,v_FloatLoss;
		            exit when v_CmdtyDaily%NOTFOUND;
					--�����ʽ�����д�����ո�����ˮ
					if(v_FloatLoss <> 0) then
			    		v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15016',v_FloatLoss,null,null,null,null);
			    	end if;
		        end loop;
		        close v_CmdtyDaily;
		    elsif(v_LastFloatingLossComputeType = 3 or v_LastFloatingLossComputeType = 4) then  --������ӯ������ӯ��
		        v_sql := 'select FirmID,-sum(FloatingLoss) from T_H_FirmHoldSum where ClearDate =(select max(ClearDate) from T_H_Market) group by FirmID ';
		        open v_CmdtyDaily for v_sql;
		        loop
		            fetch v_CmdtyDaily into v_FirmID,v_FloatLoss;
		            exit when v_CmdtyDaily%NOTFOUND;
					--�����ʽ�����д�����ո�����ˮ
					if(v_FloatLoss <> 0) then
			    		v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15016',v_FloatLoss,null,null,null,null);
			    	end if;
		        end loop;
		        close v_CmdtyDaily;
		    end if;
	    end if;

        --4�۳�������㸡��
	    if(v_FloatingLossComputeType = 0) then     --��Ʒ������
	        v_sql := 'select FirmID,CommodityID,sum(case when FloatingLoss>0 then 0 else -FloatingLoss end) from T_FirmHoldSum group by FirmID,CommodityID';
	        open v_CmdtyDaily for v_sql;
	        loop
	            fetch v_CmdtyDaily into v_FirmID,v_CommodityID,v_FloatLoss;
	            exit when v_CmdtyDaily%NOTFOUND;
				--�����ʽ�����д�۳����ո�����ˮ
				if(v_FloatLoss <> 0) then
		    		v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15004',v_FloatLoss,null,v_CommodityID,null,null);
		    	end if;
	        end loop;
	        close v_CmdtyDaily;
	    elsif(v_FloatingLossComputeType = 1) then  --��Ʒ��������
	        v_sql := 'select FirmID,CommodityID,sum(FloatingLoss) from T_FirmHoldSum group by FirmID,CommodityID';
	        open v_CmdtyDaily for v_sql;
	        loop
	            fetch v_CmdtyDaily into v_FirmID,v_CommodityID,v_FloatLoss;
	            exit when v_CmdtyDaily%NOTFOUND;
	            if(v_FloatLoss <= 0) then
	            	v_FloatLoss := -v_FloatLoss;
					--�����ʽ�����д�۳����ո�����ˮ
					if(v_FloatLoss <> 0) then
			    		v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15004',v_FloatLoss,null,v_CommodityID,null,null);
			    	end if;
		        end if;
	        end loop;
	        close v_CmdtyDaily;
	    elsif(v_FloatingLossComputeType = 2) then  --������Ʒ
	        v_sql := 'select FirmID,case when sum(FloatingLoss) >0 then 0 else -sum(FloatingLoss) end from T_FirmHoldSum group by FirmID ';
	        open v_CmdtyDaily for v_sql;
	        loop
	            fetch v_CmdtyDaily into v_FirmID,v_FloatLoss;
	            exit when v_CmdtyDaily%NOTFOUND;
				--�����ʽ�����д�۳����ո�����ˮ
				if(v_FloatLoss <> 0) then
		    		v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15015',v_FloatLoss,null,null,null,null);
		    	end if;
	        end loop;
	        close v_CmdtyDaily;
	    elsif(v_FloatingLossComputeType = 3 or v_FloatingLossComputeType = 4) then  --������ӯ������ӯ��
	        v_sql := 'select FirmID,-sum(FloatingLoss) from T_FirmHoldSum group by FirmID ';
	        open v_CmdtyDaily for v_sql;
	        loop
	            fetch v_CmdtyDaily into v_FirmID,v_FloatLoss;
	            exit when v_CmdtyDaily%NOTFOUND;
				--�����ʽ�����д�۳����ո�����ˮ
				if(v_FloatLoss <> 0) then
		    		v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15015',v_FloatLoss,null,null,null,null);
		    	end if;
	        end loop;
	        close v_CmdtyDaily;
	    end if;

        -- �������½������ʽ�
        --1�����������ʽ�Ϊ0,���ս����ʽ����Ϊ���ս����ʽ����յĽ��ձ�֤�����Ϊ���յ�
        update T_Firm set VirtualFunds=0,ClearMargin=RuntimeMargin,ClearAssure=RuntimeAssure,ClearFL=RuntimeFL,ClearSettleMargin=RuntimeSettleMargin;
        --2��ɾ����ʷ�������ݲ�������ʷ��������Ϣ��
		delete from T_H_Firm where ClearDate=v_TradeDate;
        insert into T_H_Firm select v_TradeDate,a.* from T_Firm a;
        --3�����µ�����ʷ�����̱��е����յ��ʽ�Ϊ��һ�����յĵ����ʽ�
        --������sum���(һ��������ֻ��һ����¼)���������ʱû�м�¼����
	    update T_H_Firm a
        set (ClearFL,ClearMargin,ClearAssure,ClearSettleMargin) =
        (
          select nvl(sum(RuntimeFL),0),nvl(sum(RuntimeMargin),0),nvl(sum(RuntimeAssure),0),nvl(sum(RuntimeSettleMargin),0)
          from T_H_Firm
          where ClearDate =(select max(ClearDate) from T_H_Firm where ClearDate<v_TradeDate) and FirmID=a.FirmID
        )
        where a.ClearDate=v_TradeDate;

		-- �ġ�������ʷ���ݲ�ɾ����������
        --1��������ʷί�б�ɾ����������
        insert into T_H_Orders select v_TradeDate,a.* from T_Orders a;
        delete from T_Orders;
        --2��������ʷ�ɽ���ɾ����������
        insert into T_H_Trade select v_TradeDate,a.* from T_Trade a;
        delete from T_Trade;

		-- �塢ɾ����ʷ�������ݲ����뵱����ʷ����
        --1��ɾ����ʷ�������ݲ�������ʷ�г�������
		delete from T_H_Market where ClearDate=v_TradeDate;
        insert into T_H_Market select v_TradeDate,a.* from T_A_Market a;
	    --2��ɾ����ʷ�������ݲ�������ʷ����
		delete from T_H_Quotation where ClearDate=v_TradeDate;
	    insert into T_H_Quotation select v_TradeDate,a.* from T_Quotation a;
        --3��ɾ����ʷ�������ݲ�������ʷ��Ʒ��
		delete from T_H_Commodity where ClearDate=v_TradeDate;
        insert into T_H_Commodity select v_TradeDate,a.* from T_Commodity a;
        --4��ɾ����ʷ�������ݲ�������ʷ�ֲ���ϸ��
		delete from T_H_HoldPosition where ClearDate=v_TradeDate;
        insert into T_H_HoldPosition select v_TradeDate,a.* from T_HoldPosition a;
        --5��ɾ����ʷ�������ݲ�������ʷ���׿ͻ��ֲֺϼƱ�
		delete from T_H_CustomerHoldSum where ClearDate=v_TradeDate;
        insert into T_H_CustomerHoldSum select v_TradeDate,a.* from T_CustomerHoldSum a;
        --6��ɾ����ʷ�������ݲ�������ʷ�����ֲֺ̳ϼƱ�
		delete from T_H_FirmHoldSum where ClearDate=v_TradeDate;
        insert into T_H_FirmHoldSum select v_TradeDate,a.* from T_FirmHoldSum a;
        --7��ɾ����ʷ�������ݲ�������ʷ���������Ᵽ֤���
		delete from T_H_FirmMargin where ClearDate=v_TradeDate;
        insert into T_H_FirmMargin select v_TradeDate,a.* from T_A_FirmMargin a;
        --8��ɾ����ʷ�������ݲ�������ʷ���������������ѱ�
		delete from T_H_FirmFee where ClearDate=v_TradeDate;
        insert into T_H_FirmFee select v_TradeDate,a.* from T_A_FirmFee a;

		-- �����ͷŶ�������
	    --1�����׿ͻ��ֲֺϼƱ���������0
      -- mod by yukx 201040028 Ϊ֧����ǰ���ն���ֲ�ע���±�sql
	    --update T_CustomerHoldSum set FrozenQty=0;
      -- mod by yukx 201040028 ���׿ͻ��ֲֺϼƱ�Ķ��������͵ֶ������������ڲ�Ϊ0�ļ�¼ʱ����ϵͳ��־����Ӽ�¼
      /**open v_qtyAboutCustonerhold for select customerid,commodityid,bs_flag,frozenqty,gagefrozenqty from t_customerholdsum order by customerid,commodityid,bs_flag;
      loop
        fetch v_qtyAboutCustonerhold into  v_c_customerid,v_c_commodityid,v_c_bs_flag,v_c_frozenqty,v_c_gagefrozenqty;
        exit when v_qtyAboutCustonerhold%NOTFOUND;
        if(v_c_frozenqty+v_c_gagefrozenqty>0) then
             insert into c_globallog_all(id,operator,operatetime,operatetype,operatecontent,operateresult,logtype)
              values(SEQ_C_GLOBALLOG.Nextval,'SYSTEM', sysdate,1502,'v_c_customerid='||v_c_customerid||',v_c_commodityid='||v_c_commodityid||',v_c_bs_flag='||v_c_bs_flag||',v_c_frozenqty='||v_c_frozenqty||',v_c_gagefrozenqty='||v_c_gagefrozenqty,2,3);
        end if;
      end loop;*/
      ---- add by tangzy 2010-06-21 ���׿ͻ��ֲֺϼƶ��������޸ģ�����0���ٸ�����ǰ��������ļ�¼�����¶�������
      update T_CustomerHoldSum t
        set FrozenQty = 0,
            gagefrozenqty = 0;
      -- �����򷽶�������
      update T_CustomerHoldSum t
         set FrozenQty = nvl((select sum(quantity)
                               from t_e_applyaheadsettle
                              where customerid_b = t.customerid
                                and commodityid = t.commodityid
                                and status = 1),0)
       where bs_flag = 1;
      -- ����������������
      update T_CustomerHoldSum t
         set FrozenQty = nvl((select sum(quantity) - sum(gageqty)
                               from t_e_applyaheadsettle
                              where customerid_s = t.customerid
                                and commodityid = t.commodityid
                                and status = 1),0),
            gagefrozenqty = nvl((select sum(gageqty)
                               from t_e_applyaheadsettle
                              where customerid_s = t.customerid
                                and commodityid = t.commodityid
                                and status = 1),0)
       where bs_flag = 2;
      ---- add by tangzy 2010-06-21 end

        --2����յ���ָ��ƽ�ֶ����
        delete from T_SpecFrozenHold;
        --3���ͷ����ж����ʽ�
		SP_F_UnFrozenAllFunds('15');

        -- �ߡ��޸Ľ���ϵͳ״̬Ϊ����������
        update T_SystemStatus set TradeDate=v_TradeDate,Status=3,SectionID=null,Note=null,RecoverTime=null;
    --�ɹ����ؽ��������ַ���
    return to_char(v_TradeDate,'yyyy-MM-dd');
end;
/

prompt
prompt Creating function FN_T_UNTRADETRANSFER
prompt ======================================
prompt
create or replace function FN_T_UnTradeTransfer(
    p_ID            number,         --�ǽ��׹�����ID
    p_CommodityID   varchar2,       --��Ʒ����
    p_BS_Flag       number,         --������־
    p_bCustomerID   varchar2,       --���շ����׿ͻ�ID
    p_sCustomerID   varchar2,       --���������׿ͻ�ID
    p_quantity      number          --��������

) return number
/****
 * �ǽ��׹���
 * ����ֵ
 * 1 �ɹ�
 * -1  ��ƽ�ֲֳ���������
 * -5  ����״̬��Ϊ����
 * -15 û���ҵ���Ӧ�ĳֲּ�¼
****/
as
	   v_version               varchar2(10):='1.0.2.1';
     v_status                number(2);
     v_CommodityID           varchar2(16);
     v_CustomerID            varchar2(40);
     v_FirmID                varchar2(32);
     v_FirmID_b              varchar2(32);
     v_HoldQty               number;
     v_HoldSumQty            number(10);
     v_frozenQty             number(10);
     v_Margin                number(15,2):=0;
     v_Margin_one            number(15,2):=0;
	   v_Assure                number(15,2):=0;
	   v_Assure_one            number(15,2):=0;
     v_BS_Flag               number(2);
     v_Price                 number(15,2);
     v_ContractFactor        number(12,2);
     v_MarginPriceType       number(1);
     v_MarginPrice           number(15,2);  --����ɽ���֤��ļ۸�
	   v_HoldFunds             number(15,2):=0;  --ƽ��ʱӦ�˳ֲֽ��������ֶ���
	   v_CustomerHoldFunds     number(15,2):=0;  --ƽ��ʱӦ�˳ֲֽ������ֶ���
     v_TradeDate             date;
	   v_A_HoldNo              number(15);
	   v_GageQty               number(10);
	   v_unCloseQty            number(10):=p_quantity; --δƽ�����������м����
	   --v_unCloseQtyGage        number(10):=p_GageQty; --δƽ�����������м����
	   v_tradedAmount          number(10):=0;  --�ɽ�����
	   v_tradedAmountGage      number(10):=0;  --�ɽ�����
	   v_F_FrozenFunds         number(15,2);
	   v_AtClearDate           date;
	   v_HoldTime              date;
	   --v_tmp_bs_flag           number(2);
  	 type c_HoldPosition is ref cursor;
  	 v_HoldPosition c_HoldPosition;
  	 v_sql                   varchar2(500);
  	 v_closeTodayHis         number(2);    --ƽ��ֻ�����ʷ��(0ƽ��֣�1ƽ��ʷ��)
  	 v_YesterBalancePrice    number(15,2);
  	 v_num                   number(10);
begin

     select status into v_status from t_systemstatus;
     if(v_status != 1) then --�����ڱ���״̬
         rollback;
         return -5;--ֻ�б���״̬�²Ž������ǽ��׹���
     end if;

		 v_CustomerID := p_sCustomerID;  --���������׿ͻ�ID
	   v_CommodityID := p_CommodityID;
     v_BS_Flag := p_BS_Flag;
     /*if(v_BS_Flag=1) then  --�ֲֵ�������־
         v_tmp_bs_flag:=2; --���ֵ�������־
     else
         v_tmp_bs_flag:=1;
     end if;*/
     --��ס���׿ͻ��ֲֺϼƣ��Է�ֹ��������
     begin
       select HoldQty,FrozenQty,GageQty
         into v_HoldSumQty, v_frozenQty, v_GageQty
         from T_CustomerHoldSum
        where CustomerID = v_CustomerID
          and CommodityID = v_CommodityID
          and bs_flag = v_BS_Flag for update;
     exception
         when NO_DATA_FOUND then
  	     return -15;--û���ҵ���Ӧ�ĳֲּ�¼
     end;

     if(p_quantity > v_frozenQty) then--���������Ѷ���
         rollback;
         return -1;--�ɹ����ֲ���������
     end if;

     select Contractfactor,MarginPriceType,LastPrice
       into v_ContractFactor,v_MarginPriceType,v_YesterBalancePrice
       from T_Commodity where CommodityID=v_CommodityID;

     select TradeDate into v_TradeDate from T_SystemStatus;

     v_sql := 'select a.a_holdno,FirmID,price,(a.HoldQty-nvl(b.FrozenQty,0)),GageQty,HoldTime,AtClearDate,nvl(b.FrozenQty,0)' ||
              '  from T_holdposition a,(select A_HoldNo,nvl(sum(FrozenQty),0) FrozenQty from T_SpecFrozenHold group by A_HoldNo) b ' ||
              ' where (a.HoldQty+a.GageQty) > 0 and a.A_HoldNo=b.A_HoldNo(+) and CustomerID=''' || v_CustomerID || ''' and CommodityID =''' || v_CommodityID || ''' and bs_flag = ' || v_BS_Flag || ' order by a.A_HoldNo ';

	   --�����ֲ���ϸ�����������˵�ָ��ƽ�ֶ��������
     open v_HoldPosition for v_sql;
         loop
             fetch v_HoldPosition into v_a_holdno, v_FirmID, v_price, v_holdqty,v_GageQty,v_HoldTime,v_AtClearDate,v_frozenQty;
                exit when v_HoldPosition%NOTFOUND;
                --����˱ʳֲ�ȫ����ָ��ƽ�ֶ�����û�еֶ���ָ����һ����¼
                if(v_holdqty <> 0) then
	                  v_tradedAmount:=0;
	                  v_tradedAmountGage:=0;
	                  v_Margin_one:=0;
	                  v_Assure_one:=0;

                    --�ж���ƽ��ֻ���ƽ��ʷ��
        				    if(trunc(v_TradeDate) = trunc(v_AtClearDate)) then
        				        v_closeTodayHis := 0;
        				    else
        				    	  v_closeTodayHis := 1;
        				    end if;

        	          --1������Ӧ�˿���
        	          if(v_holdqty > 0) then
        		            if(v_holdqty<=v_unCloseQty) then
        		                v_tradedAmount:=v_holdqty;
        		            else
        		                v_tradedAmount:=v_unCloseQty;
        		            end if;

                        --����Ӧ�˱�֤��۸񣬸�������ѡ�񿪲ּۻ�������������
        						    if(v_MarginPriceType = 1) then
        					          v_MarginPrice := v_YesterBalancePrice;
        					      elsif(v_MarginPriceType = 2) then
        							      --�ж���ƽ��ֻ���ƽ��ʷ��
        							      if(v_closeTodayHis = 0) then  --ƽ���
        								        v_MarginPrice := v_price;
        							      else  --ƽ��ʷ��
        						            v_MarginPrice := v_YesterBalancePrice;
        						        end if;
        						    else  -- default type is 0
        							      v_MarginPrice := v_price;
        						    end if;

                        --����Ӧ�˱�֤��
        		            v_Margin_one := FN_T_ComputeMargin(v_FirmID,v_CommodityID,v_BS_Flag,v_tradedAmount,v_MarginPrice);
        		            if(v_Margin_one < 0) then
        		                Raise_application_error(-20040, 'computeMargin error');
        		            end if;
        				        --���㵣����
        				        v_Assure_one := FN_T_ComputeAssure(v_FirmID,v_CommodityID,v_BS_Flag,v_tradedAmount,v_MarginPrice);
        				        if(v_Assure_one < 0) then
        				            Raise_application_error(-20041, 'computeAssure error');
        				        end if;
        				        --��֤��Ӧ���ϵ�����
        				        v_Margin_one := v_Margin_one + v_Assure_one;
        		            v_Margin:=v_Margin + v_Margin_one;
        		            v_Assure:=v_Assure + v_Assure_one;
        			          --����Ӧ�˳ֲֽ��������ֶ���
        			          v_HoldFunds := v_HoldFunds + v_tradedAmount*v_price*v_ContractFactor;
                    end if;

  	                --�����ͻ��ϼƽ��
  	                v_CustomerHoldFunds := v_CustomerHoldFunds + v_tradedAmount*v_price*v_ContractFactor;

	                  --���³ֲּ�¼(������)
                    update T_holdposition
                       set holdqty = holdqty - v_tradedAmount,
                           HoldMargin=HoldMargin-v_Margin_one,
                           HoldAssure=HoldAssure-v_Assure_one
                     where a_holdno = v_a_holdno;

                     --��ȡ������������
                     select FirmID into v_FirmID_b from T_Customer where CustomerID = p_bCustomerID;
                     --���³ֲּ�¼�����շ���
                     --select FN_T_ComputeHoldNo(SEQ_T_HoldPosition.nextval) into v_A_HoldNo_s from dual;
                     insert into T_Holdposition
                         (a_holdno,                   a_tradeno, CommodityID,   CustomerID,    bs_flag,       price,         holdqty,        openqty,        holdtime, HoldMargin,   HoldAssure,   Firmid,     FloatingLoss, AtClearDate)
                     values
                         (SEQ_T_HoldPosition.nextval, -1,        p_CommodityID, p_bCustomerID, v_BS_Flag, v_MarginPrice, v_tradedAmount, v_tradedAmount, sysdate,  v_Margin_one, v_Assure_one, v_FirmID_b, 0,            v_TradeDate);

                     --���½��׿ͻ��ֲֺϼƱ����շ���
                     select count(*) into v_num from T_CustomerHoldSum
                      where CustomerID = p_bCustomerID
                        and CommodityID = p_CommodityID
                        and bs_flag = v_BS_Flag;
                     if(v_num >0) then
                         update T_CustomerHoldSum
                            set holdQty = holdQty + v_tradedAmount,
                                holdFunds = holdFunds + v_Margin_one,
                                HoldMargin = HoldMargin + v_Margin_one,
                                HoldAssure = HoldAssure + v_Assure_one,
                                evenprice = (holdFunds + v_Margin_one)/((holdQty + GageQty + v_tradedAmount)*v_ContractFactor)
                          where CustomerID = p_bCustomerID
                            and CommodityID = p_CommodityID
                            and bs_flag = v_BS_Flag;
                     else
                         insert into T_CustomerHoldSum
                             (CustomerID,    CommodityID,   bs_flag,       holdQty,        holdFunds,    FloatingLoss, evenprice,     FrozenQty, HoldMargin,   HoldAssure,   FirmID)
                         values
                             (p_bCustomerID, p_CommodityID, v_BS_Flag, v_tradedAmount, v_Margin_one, 0,            v_MarginPrice, 0,         v_Margin_one, v_Assure_one, v_FirmID_b);
                     end if;

                    --�����򷽽����ֲֺ̳ϼƱ����շ���
                    select count(*) into v_num from T_FirmHoldSum
                    where Firmid = v_FirmID_b
                      and CommodityID = p_CommodityID
                      and bs_flag = v_BS_Flag;
                    if(v_num >0) then
                        update T_FirmHoldSum
                           set holdQty = holdQty + v_tradedAmount,
                               holdFunds = holdFunds + v_Margin_one,
                               HoldMargin = HoldMargin + v_Margin_one,
                               HoldAssure = HoldAssure + v_Assure_one,
                               evenprice = (holdFunds + v_Margin_one)/((holdQty + v_tradedAmount + GageQty)*v_ContractFactor)
                         where Firmid = v_FirmID_b
                           and CommodityID = p_CommodityID
                           and bs_flag = v_BS_Flag;
                    else
                      insert into T_FirmHoldSum
                        (FirmID,     CommodityID,   bs_flag,       holdQty,        holdFunds,    FloatingLoss, evenprice,     HoldMargin,   HoldAssure)
                      values
                        (v_FirmID_b, p_CommodityID, v_BS_Flag, v_tradedAmount, v_Margin_one, 0,            v_MarginPrice, v_Margin_one, v_Assure_one);
                    end if;

                    --������ʱ��֤�����ʱ�����𣨽��շ���
                    update T_Firm
                       set runtimemargin = runtimemargin + v_Margin_one,
            		           RuntimeAssure = RuntimeAssure + v_Assure_one
                     where Firmid = v_FirmID_b;

                    --���¶����ʽ��ͷŸ��˲��ֵı�֤�𣨽��շ���
		                v_F_FrozenFunds := FN_F_UpdateFrozenFunds(v_FirmID_b,v_Margin_one-v_Assure_one,'15');

	                   --ÿ�μ��ٹ�������
                     v_unCloseQty:=v_unCloseQty - v_tradedAmount;

                end if;
                exit when v_unCloseQty=0;
            end loop;
        close v_HoldPosition;

        if(v_unCloseQty>0) then --ƽ�ֲֳ��������ڿ�ƽ�ֲֳ�����
            rollback;
            return -1;
        end if;

        --���ٽ��׿ͻ��������̵ĳֲֺϼ���Ϣ(������)
        v_num := FN_T_SubHoldSum(p_quantity,0,v_Margin,v_Assure,v_CommodityID,v_ContractFactor,v_BS_Flag,v_FirmID,v_HoldFunds,v_CustomerID,v_CustomerHoldFunds,0,p_quantity);

        --������ʱ��֤�����ʱ�����𣨹�������
        update T_Firm
           set runtimemargin = runtimemargin - v_Margin,
		           RuntimeAssure = RuntimeAssure - v_Assure
         where Firmid = v_FirmID;

        --���¶����ʽ��ͷŸ��˲��ֵı�֤�𣨹�������
		    v_F_FrozenFunds := FN_F_UpdateFrozenFunds(v_FirmID,-(v_Margin-v_Assure),'15');

        --���³ֲֶ����
        delete T_Holdfrozen where Operation = to_char(p_ID) and frozentype = 2;

        --���·ǽ��׹��������״̬
        update T_UnTradeTransfer set Status=1,modifytime=sysdate where Transferid = p_ID;

    return 1;

end;
/

prompt
prompt Creating function FN_T_UPDATELASTPRICE
prompt ======================================
prompt
CREATE OR REPLACE FUNCTION FN_T_UpdateLastPrice
(
  p_CommodityID varchar2,   --��Ʒ����
  p_Price number     --�۸�
)  return number
/***
 * �޸Ŀ���ָ����
 *
 * ����ֵ���ɹ�����1��
 ****/
as
  v_version varchar2(10):='1.0.4.4';
begin
	update T_Commodity set LastPrice=p_Price where CommodityID=p_CommodityID;
	update T_Quotation set Price=p_Price,YesterBalancePrice=p_Price,CreateTime=sysdate where CommodityID=p_CommodityID;
    return 1;
end;
/

prompt
prompt Creating function FN_T_UPDATEQUOTATION
prompt ======================================
prompt
CREATE OR REPLACE FUNCTION FN_T_UpdateQuotation
(
    p_CommodityID varchar2,   --��Ʒ����
    p_YesterBalancePrice number, --������
    p_ClosePrice number,               --�����̼�
    p_OpenPrice number,               --���м�
    p_HighPrice number,               --��߼�
    p_LowPrice number,               --��ͼ�
    p_CurPrice number,               --���¼�
    p_CurAmount number,               --����(���¼�����Ӧ�ĳɽ���)
    p_OpenAmount number,               --����
	p_BuyOpenAmount number,               --�򿪲�
	p_SellOpenAmount number,               --������
    p_CloseAmount number,               --ƽ��
    p_BuyCloseAmount number,               --��ƽ��
    p_SellCloseAmount number,               --��ƽ��
    p_ReserveCount number,               --������
    p_ReserveChange number,               --�ֲ�
    p_Price number,                --�����
    p_TotalMoney number,                --�ܳɽ���
    p_TotalAmount number,                --�ܳɽ���
    p_Spread number,                --�ǵ�
    p_BuyPrice1 number,                --�����1
    p_SellPrice1 number,                --������1
    p_BuyAmount1 number,                --������1
    p_SellAmount1 number,                --������1
    p_BuyPrice2 number,                --�����2
    p_SellPrice2 number ,               --������2
    p_BuyAmount2 number ,               --������2
    p_SellAmount2 number,                --������2
    p_BuyPrice3 number,                --�����3
    p_SellPrice3 number,                --������3
    p_BuyAmount3 number,                --������3
    p_SellAmount3 number ,               --������3
    p_BuyPrice4 number ,               --�����4
    p_SellPrice4 number,                --������4
    p_BuyAmount4 number,                --������4
    p_SellAmount4 number,                --������4
    p_BuyPrice5 number,                --�����5
    p_SellPrice5 number,                --������5
    p_BuyAmount5 number,                --������5
    p_SellAmount5 number,                --������5
    p_OutAmount number,                --����
    p_InAmount number,                --����
    p_TradeCue number,                --������ʾ
    p_NO number,                --�����ֶ�
    p_CreateTime timestamp      --2009-09-21 ���Ӹ���ʱ�䣬Ϊnull��ȡsystimestamp(3)�������Ͼ�������ʱ����³ɿ���ʱ��
) RETURN NUMBER
/****
 * ��������
 * ����ֵ
 * 1 �ɹ�
 * -100 ʧ��
****/
as
	v_version varchar2(10):='1.0.0.9';
    v_num   number(10);
    v_errorcode number;
    v_errormsg  varchar2(200);
begin
    select count(*) into v_num from T_Quotation where CommodityID = p_CommodityID;
    if(v_num >0) then
        update T_Quotation set YesterBalancePrice=p_YesterBalancePrice,ClosePrice=p_ClosePrice,OpenPrice=p_OpenPrice,HighPrice=p_HighPrice,
        LowPrice=p_LowPrice,CurPrice=p_CurPrice,CurAmount=p_CurAmount,OpenAmount=p_OpenAmount,BuyOpenAmount=p_BuyOpenAmount,SellOpenAmount=p_SellOpenAmount,CloseAmount=p_CloseAmount,BuyCloseAmount=p_BuyCloseAmount,SellCloseAmount=p_SellCloseAmount,
        ReserveCount=p_ReserveCount,ReserveChange=p_ReserveChange,Price=p_Price,TotalMoney=p_TotalMoney,TotalAmount=p_TotalAmount,Spread=p_Spread,BuyPrice1=p_BuyPrice1,SellPrice1=p_SellPrice1
        ,BuyAmount1=p_BuyAmount1,SellAmount1=p_SellAmount1,BuyPrice2=p_BuyPrice2,SellPrice2=p_SellPrice2,BuyAmount2=p_BuyAmount2,SellAmount2=p_SellAmount2,BuyPrice3=p_BuyPrice3,SellPrice3=p_SellPrice3,BuyAmount3=p_BuyAmount3,SellAmount3=p_SellAmount3
        ,BuyPrice4=p_BuyPrice4,SellPrice4=p_SellPrice4,BuyAmount4=p_BuyAmount4,SellAmount4=p_SellAmount4,BuyPrice5=p_BuyPrice5,SellPrice5=p_SellPrice5,BuyAmount5=p_BuyAmount5,SellAmount5=p_SellAmount5,OutAmount=p_OutAmount,InAmount=p_InAmount
        ,TradeCue=p_TradeCue,NO=p_NO,CreateTime=decode(p_CreateTime,null,systimestamp(3),p_CreateTime)
        where CommodityID = p_CommodityID;
    else
        insert into T_Quotation(CommodityID,YesterBalancePrice,ClosePrice,OpenPrice,HighPrice,
        LowPrice,CurPrice,CurAmount,OpenAmount,BuyOpenAmount,SellOpenAmount,CloseAmount,BuyCloseAmount,SellCloseAmount,ReserveCount,ReserveChange,Price,TotalMoney,TotalAmount,Spread,
        BuyPrice1,SellPrice1,BuyAmount1,SellAmount1,BuyPrice2,SellPrice2,BuyAmount2,SellAmount2,BuyPrice3,SellPrice3,
        BuyAmount3,SellAmount3,BuyPrice4,SellPrice4,BuyAmount4,SellAmount4,BuyPrice5,SellPrice5,BuyAmount5,SellAmount5,
        OutAmount,InAmount,TradeCue,NO,CreateTime)
        values(p_CommodityID,p_YesterBalancePrice,p_ClosePrice,p_OpenPrice,p_HighPrice,p_LowPrice,p_CurPrice,p_CurAmount,p_OpenAmount,p_BuyOpenAmount,p_SellOpenAmount,p_CloseAmount,p_BuyCloseAmount,p_SellCloseAmount,p_ReserveCount,p_ReserveChange,p_Price,p_TotalMoney,p_TotalAmount,p_Spread,p_BuyPrice1,
        p_SellPrice1,p_BuyAmount1,p_SellAmount1,p_BuyPrice2,p_SellPrice2,p_BuyAmount2,p_SellAmount2,p_BuyPrice3,p_SellPrice3,p_BuyAmount3,
        p_SellAmount3,p_BuyPrice4,p_SellPrice4,p_BuyAmount4,p_SellAmount4,p_BuyPrice5,p_SellPrice5,p_BuyAmount5,p_SellAmount5,
        p_OutAmount,p_InAmount,p_TradeCue,p_NO,decode(p_CreateTime,null,systimestamp(3),p_CreateTime));
    end if;
    commit;
    return 1;
exception
    when OTHERS then
    v_errorcode:=sqlcode;
    v_errormsg :=sqlerrm;
    rollback;
    insert into T_DBLog(err_date,name_proc,err_code,err_msg)
    values(sysdate,'FN_T_UpdateQuotation',v_errorcode,v_errormsg);
    commit;
    return -100;
end;
/

prompt
prompt Creating function FN_T_UPDATERUNTIMESETTLEMARGIN
prompt ================================================
prompt
CREATE OR REPLACE FUNCTION FN_T_UpdateRuntimeSettleMargin
(
  p_FirmID varchar2,   --�����̴���
  p_RuntimeSettleMargin number     --�������ֵ���ӣ���ֵ���٣�
)  return number
/***
 * ���½����̵��ս��ձ�֤��
 * version 1.0.0.6
 *
 * ����ֵ�������̵��ս��ձ�֤��
 ****/
is
  v_RuntimeSettleMargin number(15,2);
begin
  update T_Firm set RuntimeSettleMargin=RuntimeSettleMargin + p_RuntimeSettleMargin where FirmID=p_FirmID
  returning RuntimeSettleMargin into v_RuntimeSettleMargin;
  if(SQL%ROWCOUNT = 0) then
    Raise_application_error(-20099, 'FirmID not existed !'); --�����ڵĽ����̴���
  end if;

  return v_RuntimeSettleMargin;
end;
/

prompt
prompt Creating function FN_T_UPDATETRADE
prompt ==================================
prompt
create or replace function FN_T_UpdateTrade(
    p_A_OrderNo     number,  --ί�е���
    p_M_TradeNo     number,  --��ϳɽ���
    p_Price         number,  --�ɽ���
    p_Quantity      number,   --�ɽ�����
    p_M_TradeNo_Opp     number,  --�Է���ϳɽ���
    p_A_OrderNo_Other     number,  --����һ��ί�е���
    p_M_TradeNo_Other     number,  --����һ����ϳɽ���
    p_Price_Other         number,  --����һ���ɽ���
    p_Quantity_Other      number,   --����һ���ɽ�����
  p_M_TradeNo_Opp_Other     number  --����һ���Է���ϳɽ���
) return number
/****
 * ���³ɽ��ر�,����ί�����ͷֱ���ÿ�ƽ�ִ洢������ɹ�����ü��㸡������
 * ����ֵ
 * 1 �ɹ�
 * 2 �Ѵ����
 * -1 �ɽ���������δ�ɽ�����
 * -2 �ɽ��������ڶ�������
 * -3 ƽ�ֳɽ��������ڳֲ�����
 * -100 ��������
 *����ƽ�֣����Ӷ��ֽ�����ID mod by liuchao 20130603
****/
as
    v_version varchar2(10):='1.0.2.1';
    v_CommodityID varchar2(16);
    v_CommodityID_opp varchar2(16);
    v_FirmID     varchar2(32);
    v_FirmID_Other     varchar2(32);
    v_TraderID       varchar2(40);
    v_TraderID_opp       varchar2(40);
    v_bs_flag        number(2);
    v_bs_flag_opp        number(2);
    v_status         number(2);
    v_status_opp         number(2);
    v_orderQty       number(10);
    v_orderQty_opp       number(10);
    v_orderPrice          number(15,2);
    v_orderPrice_opp          number(15,2);
    v_orderTradeQty       number(10);
    v_orderTradeQty_opp       number(10);
    v_frozenfunds    number(15,2);
    v_frozenfunds_opp    number(15,2);
    v_unfrozenfunds  number(15,2);
    v_unfrozenfunds_opp  number(15,2);
    v_CustomerID        varchar2(40);
    v_CustomerID_opp        varchar2(40);
    v_OrderType      number(2);
    v_OrderType_opp      number(2);
    v_closeMode      number(2);
    v_closeMode_opp      number(2);
    v_specPrice      number(15,2);
    v_specPrice_opp      number(15,2);
    v_timeFlag       number(1);
    v_timeFlag_opp       number(1);
    v_CloseFlag      number(1);
    v_CloseFlag_opp      number(1);
    v_contractFactor T_Commodity.contractfactor%type;
    v_MarginPriceType         number(1);     --����ɽ���֤���������� 0:ʵʱ�ͱ���ʱ�������ּۣ�1:ʵʱ�������ۣ����а����ս����
    v_marginAlgr         number(2);
    v_marginRate_b         number(10,4);
    v_marginRate_s         number(10,4);
    v_marginAssure_b         number(10,4);
    v_marginAssure_s         number(10,4);
    v_feeAlgr       number(2);
    v_feeRate_b         number(15,9);
    v_feeRate_s         number(15,9);
    v_TodayCloseFeeRate_B         number(15,9);
    v_TodayCloseFeeRate_S         number(15,9);
    v_HistoryCloseFeeRate_B         number(15,9);
    v_HistoryCloseFeeRate_S         number(15,9);
    v_ForceCloseFeeAlgr       number(2);
    v_ForceCloseFeeRate_B         number(15,9);
    v_ForceCloseFeeRate_S         number(15,9);
    v_AddedTaxFactor T_Commodity.AddedTaxFactor%type;--��ֵ˰��ϵ��=AddedTax/(1+AddedTax)
    v_YesterBalancePrice    number(15,2);
    v_num            number(10);
    v_ret            number(4);
    v_FL_ret            number(4);
    v_errorcode      number;
    v_errormsg       varchar2(200);
    v_GageMode number(2);--�ֶ�ģʽ����0ȫ�ֶ���1��ֶ�����ֶ�ʱҪ���㸡����2009-10-14
    v_CloseAlgr        number(2);    --ƽ���㷨(0�ȿ���ƽ��1����ƽ��2�ֲ־���ƽ��)
    v_TradeDate date;
    v_BillTradeType_one number(2);   --�ֵ��������� 0������Ĭ�ϣ�  1�����ֵ���    3���ֶ�ת��  mod by yukx 20100428
    v_BillTradeType_two number(2);   --�ֵ��������� 0������Ĭ�ϣ�  1�����ֵ���    3���ֶ�ת��  mod by yukx 20100428
begin
  --�ж��Ƿ��Ѵ����
   -- select count(*) into v_num from T_Trade where m_tradeno in(p_M_TradeNo,p_M_TradeNo_Other);
    if(v_num >0) then
        rollback;
        return 2;  --�Ѵ����
    end if;
    --��ȡƽ���㷨,�ֶ�ģʽ
    select CloseAlgr,GageMode into v_CloseAlgr,v_GageMode from T_A_Market;
    --ȡ��������
  select TradeDate into v_TradeDate from T_SystemStatus;
    --
    select CommodityID,   Firmid,  TraderID, bs_flag, status, quantity, price, tradeqty, frozenfunds, unfrozenfunds,CustomerID,OrderType,closeMode,specPrice,timeFlag,CloseFlag,billTradeType
    into v_CommodityID,v_FirmID,v_TraderID,v_bs_flag,v_status,v_orderQty,v_orderPrice,v_orderTradeQty,v_frozenfunds,v_unfrozenfunds,v_CustomerID,v_OrderType,v_closeMode,v_specPrice,v_timeFlag,v_CloseFlag,v_BillTradeType_one
    from T_Orders
    where A_OrderNo = p_A_OrderNo for update;
    --������һ��ί����Ϣ��ί�е��źͽ����̲�һ��
    --������ѯ������ȫ�����ɲ�ͬ�ı���  liuchao 20130603
      select CommodityID,   Firmid,  TraderID, bs_flag, status, quantity, price, tradeqty, frozenfunds, unfrozenfunds,CustomerID,OrderType,closeMode,specPrice,timeFlag,CloseFlag,billTradeType
      into v_CommodityID_opp,v_FirmID_Other,v_TraderID_opp,v_bs_flag_opp,v_status_opp,v_orderQty_opp,v_orderPrice_opp,v_orderTradeQty_opp,v_frozenfunds_opp,v_unfrozenfunds_opp,v_CustomerID_opp,v_OrderType_opp,v_closeMode_opp,v_specPrice_opp,v_timeFlag_opp,v_CloseFlag_opp,v_BillTradeType_two
      from T_Orders
      where A_OrderNo = p_A_OrderNo_Other for update;
    --����һ���ɽ�
    --��ȡ��Ʒ��Ϣ
    select contractfactor,MarginPriceType,marginalgr,marginrate_b,marginrate_s,marginAssure_b,marginAssure_s,feealgr,feerate_b,feerate_s,TodayCloseFeeRate_B,TodayCloseFeeRate_S,HistoryCloseFeeRate_B,HistoryCloseFeeRate_S,ForceCloseFeeAlgr,ForceCloseFeeRate_B,ForceCloseFeeRate_S,AddedTaxFactor,LastPrice
    into v_contractFactor,v_MarginPriceType,v_marginAlgr,v_marginRate_b,v_marginRate_s,v_marginAssure_b,v_marginAssure_s,v_feeAlgr,v_feeRate_b,v_feeRate_s,v_TodayCloseFeeRate_B,v_TodayCloseFeeRate_S,v_HistoryCloseFeeRate_B,v_HistoryCloseFeeRate_S,v_ForceCloseFeeAlgr,v_ForceCloseFeeRate_B,v_ForceCloseFeeRate_S,v_AddedTaxFactor,v_YesterBalancePrice
    from T_Commodity where CommodityID=v_CommodityID;
    --��ȡ�ػ��Ľ��ױ�֤�𣬱�֤���㷨
    begin
        select marginalgr,marginrate_b,marginrate_s,marginAssure_b,marginAssure_s
      into v_marginAlgr,v_marginRate_b,v_marginRate_s,v_marginAssure_b,v_marginAssure_s
        from T_A_FirmMargin
        where FirmID=v_FirmID and CommodityID=v_CommodityID;
    exception
        when NO_DATA_FOUND then
            null;
    end;

    --��ȡ�����̶�Ӧ�ײ�������ϵ�����������㷨
    begin
        select feealgr,feerate_b,feerate_s,TodayCloseFeeRate_B,TodayCloseFeeRate_S,HistoryCloseFeeRate_B,HistoryCloseFeeRate_S,ForceCloseFeeAlgr,ForceCloseFeeRate_B,ForceCloseFeeRate_S
      into v_feeAlgr,v_feeRate_b,v_feeRate_s,v_TodayCloseFeeRate_B,v_TodayCloseFeeRate_S,v_HistoryCloseFeeRate_B,v_HistoryCloseFeeRate_S,v_ForceCloseFeeAlgr,v_ForceCloseFeeRate_B,v_ForceCloseFeeRate_S
        from T_A_Tariff
        where TariffID=(select TariffID from t_firm where FirmID=v_FirmID) and CommodityID=v_CommodityID;
    exception
        when NO_DATA_FOUND then
            null;
    end;

    --��ȡ�ػ��Ľ��������ѣ��������㷨
    begin
        select feealgr,feerate_b,feerate_s,TodayCloseFeeRate_B,TodayCloseFeeRate_S,HistoryCloseFeeRate_B,HistoryCloseFeeRate_S,ForceCloseFeeAlgr,ForceCloseFeeRate_B,ForceCloseFeeRate_S
      into v_feeAlgr,v_feeRate_b,v_feeRate_s,v_TodayCloseFeeRate_B,v_TodayCloseFeeRate_S,v_HistoryCloseFeeRate_B,v_HistoryCloseFeeRate_S,v_ForceCloseFeeAlgr,v_ForceCloseFeeRate_B,v_ForceCloseFeeRate_S
        from T_A_FirmFee
        where FirmID=v_FirmID and CommodityID=v_CommodityID;
    exception
        when NO_DATA_FOUND then
            null;
    end;

  if(v_OrderType = 1) then --���� --���Ӷ��ֽ�����ID  mod by liuchao 20130603
      if(v_BillTradeType_one=1) then --���ֵ� modify by yukx 20100421
           v_ret := FN_T_SellBillTrade(p_A_OrderNo,p_M_TradeNo,p_Price,p_Quantity,p_M_TradeNo_Opp,v_CommodityID,v_FirmID,v_TraderID,v_bs_flag,v_status,v_orderQty,v_orderPrice,v_orderTradeQty,v_frozenfunds,v_unfrozenfunds,v_CustomerID,v_OrderType,v_contractFactor,v_MarginPriceType,v_marginAlgr,v_marginRate_b,v_marginRate_s,v_marginAssure_b,v_marginAssure_s,v_feeAlgr,v_feeRate_b,v_feeRate_s,v_YesterBalancePrice,v_GageMode,v_TradeDate,v_FirmID_Other);
      else
           v_ret := FN_T_OpenTrade(p_A_OrderNo,p_M_TradeNo,p_Price,p_Quantity,p_M_TradeNo_Opp,v_CommodityID,v_FirmID,v_TraderID,v_bs_flag,v_status,v_orderQty,v_orderPrice,v_orderTradeQty,v_frozenfunds,v_unfrozenfunds,v_CustomerID,v_OrderType,v_contractFactor,v_MarginPriceType,v_marginAlgr,v_marginRate_b,v_marginRate_s,v_marginAssure_b,v_marginAssure_s,v_feeAlgr,v_feeRate_b,v_feeRate_s,v_YesterBalancePrice,v_GageMode,v_TradeDate,v_FirmID_Other);
      end if;
  elsif(v_OrderType = 2) then  --ƽ��
      if(v_BillTradeType_one=2) then --�ֶ�ת�� modify by yukx 20100421
           v_ret := FN_T_GageCloseTrade(p_A_OrderNo,p_M_TradeNo,p_Price,p_Quantity,p_M_TradeNo_Opp,v_CommodityID,v_FirmID,v_TraderID,v_bs_flag,v_status,v_orderQty,v_orderTradeQty,v_CustomerID,v_OrderType,v_closeMode,v_specPrice,v_timeFlag,v_CloseFlag,v_contractFactor,v_MarginPriceType,v_marginAlgr,v_marginRate_b,v_marginRate_s,v_marginAssure_b,v_marginAssure_s,v_feeAlgr,v_feeRate_b,v_feeRate_s,v_TodayCloseFeeRate_B,v_TodayCloseFeeRate_S,v_HistoryCloseFeeRate_B,v_HistoryCloseFeeRate_S,v_ForceCloseFeeAlgr,v_ForceCloseFeeRate_B,v_ForceCloseFeeRate_S,v_YesterBalancePrice,v_AddedTaxFactor,v_GageMode,v_CloseAlgr,v_TradeDate,v_FirmID_Other);
      else
           v_ret := FN_T_CloseTrade(p_A_OrderNo,p_M_TradeNo,p_Price,p_Quantity,p_M_TradeNo_Opp,v_CommodityID,v_FirmID,v_TraderID,v_bs_flag,v_status,v_orderQty,v_orderTradeQty,v_CustomerID,v_OrderType,v_closeMode,v_specPrice,v_timeFlag,v_CloseFlag,v_contractFactor,v_MarginPriceType,v_marginAlgr,v_marginRate_b,v_marginRate_s,v_marginAssure_b,v_marginAssure_s,v_feeAlgr,v_feeRate_b,v_feeRate_s,v_TodayCloseFeeRate_B,v_TodayCloseFeeRate_S,v_HistoryCloseFeeRate_B,v_HistoryCloseFeeRate_S,v_ForceCloseFeeAlgr,v_ForceCloseFeeRate_B,v_ForceCloseFeeRate_S,v_YesterBalancePrice,v_AddedTaxFactor,v_GageMode,v_CloseAlgr,v_TradeDate,v_FirmID_Other);
      end if;
  end if;
  --�ɹ��������һ���ɽ�
  if(v_ret = 1) then
      --��ȡ��Ʒ��Ϣ
      select contractfactor,MarginPriceType,marginalgr,marginrate_b,marginrate_s,marginAssure_b,marginAssure_s,feealgr,feerate_b,feerate_s,TodayCloseFeeRate_B,TodayCloseFeeRate_S,HistoryCloseFeeRate_B,HistoryCloseFeeRate_S,ForceCloseFeeAlgr,ForceCloseFeeRate_B,ForceCloseFeeRate_S,AddedTaxFactor,LastPrice
      into v_contractFactor,v_MarginPriceType,v_marginAlgr,v_marginRate_b,v_marginRate_s,v_marginAssure_b,v_marginAssure_s,v_feeAlgr,v_feeRate_b,v_feeRate_s,v_TodayCloseFeeRate_B,v_TodayCloseFeeRate_S,v_HistoryCloseFeeRate_B,v_HistoryCloseFeeRate_S,v_ForceCloseFeeAlgr,v_ForceCloseFeeRate_B,v_ForceCloseFeeRate_S,v_AddedTaxFactor,v_YesterBalancePrice
      from T_Commodity where CommodityID=v_CommodityID_opp;
      --��ȡ�ػ��Ľ��ױ�֤�𣬱�֤���㷨
      begin
          select marginalgr,marginrate_b,marginrate_s,marginAssure_b,marginAssure_s
        into v_marginAlgr,v_marginRate_b,v_marginRate_s,v_marginAssure_b,v_marginAssure_s
          from T_A_FirmMargin
          where FirmID=v_FirmID_Other and CommodityID=v_CommodityID_opp;
      exception
          when NO_DATA_FOUND then
              null;
      end;

      --��ȡ�����̶�Ӧ�ײ�������ϵ�����������㷨
      begin
    select feealgr,feerate_b,feerate_s,TodayCloseFeeRate_B,TodayCloseFeeRate_S,HistoryCloseFeeRate_B,HistoryCloseFeeRate_S,ForceCloseFeeAlgr,ForceCloseFeeRate_B,ForceCloseFeeRate_S
    into v_feeAlgr,v_feeRate_b,v_feeRate_s,v_TodayCloseFeeRate_B,v_TodayCloseFeeRate_S,v_HistoryCloseFeeRate_B,v_HistoryCloseFeeRate_S,v_ForceCloseFeeAlgr,v_ForceCloseFeeRate_B,v_ForceCloseFeeRate_S
    from T_A_Tariff
    where TariffID=(select TariffID from t_firm where FirmID=v_FirmID_Other) and CommodityID=v_CommodityID_opp;
      exception
    when NO_DATA_FOUND then
        null;
      end;

      --��ȡ�ػ��Ľ��������ѣ��������㷨
      begin
          select feealgr,feerate_b,feerate_s,TodayCloseFeeRate_B,TodayCloseFeeRate_S,HistoryCloseFeeRate_B,HistoryCloseFeeRate_S,ForceCloseFeeAlgr,ForceCloseFeeRate_B,ForceCloseFeeRate_S
        into v_feeAlgr,v_feeRate_b,v_feeRate_s,v_TodayCloseFeeRate_B,v_TodayCloseFeeRate_S,v_HistoryCloseFeeRate_B,v_HistoryCloseFeeRate_S,v_ForceCloseFeeAlgr,v_ForceCloseFeeRate_B,v_ForceCloseFeeRate_S
          from T_A_FirmFee
          where FirmID=v_FirmID_Other and CommodityID=v_CommodityID_opp;
      exception
          when NO_DATA_FOUND then
              null;
      end;
    if(v_OrderType_opp = 1) then --����   --���Ӷ��ֽ�����ID  mod by liuchao 20130603
       if(v_BillTradeType_two=1) then --���ֵ� modify by yukx 20100421
           v_ret := FN_T_SellBillTrade(p_A_OrderNo_Other,p_M_TradeNo_Other,p_Price_Other,p_Quantity_Other,p_M_TradeNo_Opp_Other,v_CommodityID_opp,v_FirmID_Other,v_TraderID_opp,v_bs_flag_opp,v_status_opp,v_orderQty_opp,v_orderPrice_opp,v_orderTradeQty_opp,v_frozenfunds_opp,v_unfrozenfunds_opp,v_CustomerID_opp,v_OrderType_opp,v_contractFactor,v_MarginPriceType,v_marginAlgr,v_marginRate_b,v_marginRate_s,v_marginAssure_b,v_marginAssure_s,v_feeAlgr,v_feeRate_b,v_feeRate_s,v_YesterBalancePrice,v_GageMode,v_TradeDate,v_FirmID);
       else
           v_ret := FN_T_OpenTrade(p_A_OrderNo_Other,p_M_TradeNo_Other,p_Price_Other,p_Quantity_Other,p_M_TradeNo_Opp_Other,v_CommodityID_opp,v_FirmID_Other,v_TraderID_opp,v_bs_flag_opp,v_status_opp,v_orderQty_opp,v_orderPrice_opp,v_orderTradeQty_opp,v_frozenfunds_opp,v_unfrozenfunds_opp,v_CustomerID_opp,v_OrderType_opp,v_contractFactor,v_MarginPriceType,v_marginAlgr,v_marginRate_b,v_marginRate_s,v_marginAssure_b,v_marginAssure_s,v_feeAlgr,v_feeRate_b,v_feeRate_s,v_YesterBalancePrice,v_GageMode,v_TradeDate,v_FirmID);
       end if;
    elsif(v_OrderType_opp = 2) then  --ƽ��
      if(v_BillTradeType_two=2) then --�ֶ�ת�� modify by yukx 20100421
          v_ret := FN_T_GageCloseTrade(p_A_OrderNo_Other,p_M_TradeNo_Other,p_Price_Other,p_Quantity_Other,p_M_TradeNo_Opp_Other,v_CommodityID_opp,v_FirmID_Other,v_TraderID_opp,v_bs_flag_opp,v_status_opp,v_orderQty_opp,v_orderTradeQty_opp,v_CustomerID_opp,v_OrderType_opp,v_closeMode_opp,v_specPrice_opp,v_timeFlag_opp,v_CloseFlag_opp,v_contractFactor,v_MarginPriceType,v_marginAlgr,v_marginRate_b,v_marginRate_s,v_marginAssure_b,v_marginAssure_s,v_feeAlgr,v_feeRate_b,v_feeRate_s,v_TodayCloseFeeRate_B,v_TodayCloseFeeRate_S,v_HistoryCloseFeeRate_B,v_HistoryCloseFeeRate_S,v_ForceCloseFeeAlgr,v_ForceCloseFeeRate_B,v_ForceCloseFeeRate_S,v_YesterBalancePrice,v_AddedTaxFactor,v_GageMode,v_CloseAlgr,v_TradeDate,v_FirmID);
      else
          v_ret := FN_T_CloseTrade(p_A_OrderNo_Other,p_M_TradeNo_Other,p_Price_Other,p_Quantity_Other,p_M_TradeNo_Opp_Other,v_CommodityID_opp,v_FirmID_Other,v_TraderID_opp,v_bs_flag_opp,v_status_opp,v_orderQty_opp,v_orderTradeQty_opp,v_CustomerID_opp,v_OrderType_opp,v_closeMode_opp,v_specPrice_opp,v_timeFlag_opp,v_CloseFlag_opp,v_contractFactor,v_MarginPriceType,v_marginAlgr,v_marginRate_b,v_marginRate_s,v_marginAssure_b,v_marginAssure_s,v_feeAlgr,v_feeRate_b,v_feeRate_s,v_TodayCloseFeeRate_B,v_TodayCloseFeeRate_S,v_HistoryCloseFeeRate_B,v_HistoryCloseFeeRate_S,v_ForceCloseFeeAlgr,v_ForceCloseFeeRate_B,v_ForceCloseFeeRate_S,v_YesterBalancePrice,v_AddedTaxFactor,v_GageMode,v_CloseAlgr,v_TradeDate,v_FirmID);
      end if;
    end if;
    --����˫���ɽ��ɹ���ֱ����˫���ĸ������ɸ��������߳�ȥ��ѯ����
    if(v_ret = 1) then
        commit;
      return v_ret;
    end if;
  end if;
  rollback;--˫��û�гɹ�Ҫ�ع�
    return v_ret;
exception
    when OTHERS then
    v_errorcode:=sqlcode;
    v_errormsg :=sqlerrm;
    rollback;
    insert into T_DBLog(err_date,name_proc,err_code,err_msg)
    values(sysdate,'FN_T_UpdateTrade',v_errorcode,v_errormsg);
    commit;
    return -100;
end;
/

prompt
prompt Creating function FN_T_WITHDRAW
prompt ===============================
prompt
create or replace function FN_T_Withdraw(
    p_WithdrawerID       varchar2,  --����ԱID
    p_A_OrderNo_W   number,             --������ί�е���
    p_WithdrawType  number,              --�������� 1:ί�г�����4������ʱ�Զ�����
    p_Quantity      number              --�����ɹ�����
) return number
/****
 * ����
 * 1��������Զ������򳷵�Ա�ͳ�������Ϊnull
 * ����ֵ
 * 1 �ɹ�
 * 2 �Ѵ����
 * -100 ��������
****/
as
    v_version varchar2(10):='1.0.0.1';
    v_a_orderno_w    number(15);
    v_status         number(2);
    v_CommodityID varchar2(16);
    v_FirmID     varchar2(32);
    v_CustomerID     varchar2(40);
    v_bs_flag        number(2);
    v_ordertype      number(2);
    v_quantity       number(10);
    v_price          number(15,2);
    v_tradeqty       number(10);
    v_frozenfunds    number(15,2);
    v_unfrozenfunds  number(15,2);
    v_closeMode      number(2);
    v_specPrice      number(15,2);
    v_timeFlag       number(1);
    v_to_unfrozenF   number(15,2);
    v_Margin         number(15,2);   --Ӧ�ձ�֤��
    v_Fee            number(15,2);   --Ӧ�շ���
    v_FrozenQty      number(10);
    v_quantity_wd    number(10);
    v_unCloseQty     number(10); --δ���������������м����
    v_tradedAmount   number(10):=0;  --�ɽ�����
    v_id       number(15);
    v_F_FrozenFunds   number(15,2);   --�����̶����ʽ�
    v_contractFactor T_Commodity.contractfactor%type;
    v_MarginPriceType         number(1);     --����ɽ���֤���������� 0:ʵʱ�ͱ���ʱ�������ּۣ�1:ʵʱ�������ۣ����а����ս����
    v_marginAlgr         number(2);
    v_marginRate_b         number(10,4);
    v_marginRate_s         number(10,4);
    v_feeAlgr       number(2);
    v_feeRate_b         number(15,9);
    v_feeRate_s         number(15,9);
    v_YesterBalancePrice    number(15,2);
    v_BillTradeType number(1); --zhengxuan �ֵ���������
    v_errorcode number;
    v_errormsg  varchar2(200);
    --����ָ��ƽ�ֶ�����α�,����ɾ������ĳֲ�
    cursor c_T_SpecFrozenHold(c_A_OrderNo number) is select ID,FrozenQty from T_SpecFrozenHold where A_OrderNo=c_A_OrderNo order by ID;
begin
    v_a_orderno_w := p_A_OrderNo_W;
    --��ȡ��������Ϣ
    select CommodityID, Firmid, bs_flag, ordertype, status, quantity, price, tradeqty, frozenfunds, unfrozenfunds,closeMode,CustomerID,BillTradeType
    into v_CommodityID, v_Firmid, v_bs_flag, v_ordertype, v_status, v_quantity, v_price, v_tradeqty, v_frozenfunds, v_unfrozenfunds,v_closeMode,v_CustomerID,v_BillTradeType
    from T_Orders
    where a_orderno = v_a_orderno_w for update;

    if(v_status in (3,5,6)) then
        rollback;
        return 2;  --�Ѵ����
    end if;

    if(p_WithdrawType = 4) then --�Զ�����
        v_quantity_wd := v_quantity - v_tradeqty;
    else
        v_quantity_wd := p_Quantity;
    end if;
    if(v_ordertype=1) then    --����
        if(v_quantity - v_tradeQty = v_quantity_wd) then
            v_to_unfrozenF := v_frozenfunds - v_unfrozenfunds;
        else
            --��ȡ��Ʒ��Ϣ
            select contractfactor,MarginPriceType,marginalgr,marginrate_b,marginrate_s,feealgr,feerate_b,feerate_s,LastPrice
            into v_contractFactor,v_MarginPriceType,v_marginAlgr,v_marginRate_b,v_marginRate_s,v_feeAlgr,v_feeRate_b,v_feeRate_s,v_YesterBalancePrice
            from T_Commodity where CommodityID=v_CommodityID;
            if(v_MarginPriceType = 1) then
                v_price := v_YesterBalancePrice;
            end if;
            --��ȡ�ػ��Ľ��ױ�֤�𣬱�֤���㷨
            begin
                select marginalgr,marginrate_b,marginrate_s
                into v_marginAlgr,v_marginRate_b,v_marginRate_s
                from T_A_FirmMargin
                where FirmID=v_FirmID and CommodityID=v_CommodityID;
            exception
                when NO_DATA_FOUND then
                    null;
            end;

            --��ȡ�����̶�Ӧ�ײ�������ϵ�����������㷨
            begin
                select feealgr,feerate_b,feerate_s
                into v_feeAlgr,v_feeRate_b,v_feeRate_s
                from T_A_Tariff
                where TariffID=(select TariffID from t_firm where FirmID=v_FirmID) and CommodityID=v_CommodityID;

            exception
                when NO_DATA_FOUND then
                    null;
            end;

            --��ȡ�ػ��Ľ��������ѣ��������㷨
            begin
                select feealgr,feerate_b,feerate_s
                into v_feeAlgr,v_feeRate_b,v_feeRate_s
                from T_A_FirmFee
                where FirmID=v_FirmID and CommodityID=v_CommodityID;
            exception
                when NO_DATA_FOUND then
                    null;
            end;
            -- tangzy 20100612 �������ֵ�ί�У������㱣֤��
            --��ʼ
            if(v_BillTradeType = 1) then
                 v_Margin := 0;
            else
                 v_Margin := FN_T_ComputeMarginByArgs(v_bs_flag,v_quantity_wd,v_price,v_contractFactor,v_marginAlgr,v_marginRate_b,v_marginRate_s);
            end if;
            --����
            if(v_Margin < 0) then
                Raise_application_error(-20040, 'computeMargin error');
            end if;
            v_Fee := FN_T_ComputeFeeByArgs(v_bs_flag,v_quantity_wd,v_price,v_contractFactor,v_feeAlgr,v_feeRate_b,v_feeRate_s);
            if(v_Fee < 0) then
                Raise_application_error(-20030, 'computeFee error');
            end if;
            v_to_unfrozenF := v_Margin + v_Fee;

        end if;
        -- tangzy 20100612 �������ֵ�ί�� ��Ч�ֵ��ֶ����ͷŶ�������;
        --��ʼ
        if(v_BillTradeType = 1) then
             update T_ValidGageBill set Frozenqty=Frozenqty-v_quantity_wd where FirmID=v_FirmID
                    and CommodityID=v_CommodityID;
                    --BreedID=(select BreedID from t_commodity where CommodityID=v_CommodityID);
        end if;
        --����
        update T_Orders set unfrozenfunds = unfrozenfunds + v_to_unfrozenF
        where A_orderNo = v_a_orderno_w;
        --���¶����ʽ�
            v_F_FrozenFunds := FN_F_UpdateFrozenFunds(v_FirmID,-v_to_unfrozenF,'15');
    elsif(v_ordertype=2) then    --ƽ��
        --zhengxuan �ͷŽ��׿ͻ��ֲֺϼƱ�ֶ�����������
        --��ʼ
        if(v_BillTradeType = 2) then
           update T_CustomerHoldSum set GageFrozenQty = GageFrozenQty-v_quantity_wd
               where customerid = v_CustomerID and commodityid = v_CommodityID and bs_flag != v_bs_flag;
        else
           update T_CustomerHoldSum set frozenQty = frozenQty - v_quantity_wd
           where CustomerID = v_CustomerID
           and CommodityID = v_CommodityID
           and bs_flag != v_bs_flag;
        --ָ��ƽ��ʱҪ���µ���ָ��ƽ�ֶ�����ж���ĳֲ֣�����ֱ�ӴӴ˱���ɾ����ί�кŵļ�¼����Ϊ���ڳɽ��ر��ڳ����ر�֮�󣬻���ɳɽ�ʧ��
           if(v_closeMode <> 1) then
                    v_unCloseQty := v_quantity_wd;
                  open c_T_SpecFrozenHold(v_a_orderno_w);
                    loop
                        fetch c_T_SpecFrozenHold into v_id,v_FrozenQty;
                        exit when c_T_SpecFrozenHold%notfound;
                        if(v_FrozenQty <= v_unCloseQty) then
                            v_tradedAmount:=v_FrozenQty;
                            delete from T_SpecFrozenHold where id=v_id;
                    else
                            v_tradedAmount:=v_unCloseQty;
                            update T_SpecFrozenHold set FrozenQty=FrozenQty-v_tradedAmount where id=v_id;
                    end if;
                    v_unCloseQty:=v_unCloseQty - v_tradedAmount;
                    exit when v_unCloseQty=0;
                       end loop;
                close c_T_SpecFrozenHold;
           end if;
        end if;
        --����
    end if;

    --����˵����1������ί�г����ͱ��س�����Ҫ���±���ί�е�״̬��5��6���ͳ������ͣ�1��2��������ί�е�״̬��7���ͳ������ͣ�1��2��
    --        2�������Զ�������Ҫ���±���ί�е�״̬��5��6���ͳ������ͣ�3��4��
    if(p_WithdrawType = 4) then --�Զ�����
          --����ί��״̬
          if(v_tradeqty = 0) then
            v_status := 5; --ȫ������
          else
            v_status := 6; --���ֳɽ��󳷵�
          end if;

    else
        --����ί��״̬
        if(v_quantity = v_quantity_wd) then
            v_status := 5; --ȫ������
        elsif(v_quantity > v_quantity_wd) then
            v_status := 6; --���ֳɽ��󳷵�
        else
            Raise_application_error(-20020, 'Parameter p_quantity > the order ''s available num');
        end if;

    end if;
      update T_Orders set status=v_status,WithdrawType=p_WithdrawType,WithdrawTime=sysdate,WithdrawerID=p_WithdrawerID,UpdateTime=systimestamp(3) where A_orderNo = v_a_orderno_w;
    commit;
    return 1;
exception
    when others then
    v_errorcode:=sqlcode;
    v_errormsg :=sqlerrm;
    rollback;
    insert into T_DBLog(err_date,name_proc,err_code,err_msg)
    values(sysdate,'FN_T_Withdraw',v_errorcode,v_errormsg);
    commit;
    return -100;
end;
/


spool off
