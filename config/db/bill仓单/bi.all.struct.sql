--------------------------------------------------
-- Export file for user TRADE_GNNT@SPOT.DEV.183 --
-- Created by hxx on 2015/11/10, 20:58:45 --------
--------------------------------------------------

set define off
spool bi.all.struct.log

prompt
prompt Creating table BI_BUSINESSRELATIONSHIP
prompt ======================================
prompt
create table BI_BUSINESSRELATIONSHIP
(
  stockid      VARCHAR2(16) not null,
  buyer        VARCHAR2(32) not null,
  seller       VARCHAR2(32) not null,
  received     CHAR(1),
  receiveddate DATE,
  selltime     DATE
)
;
comment on column BI_BUSINESSRELATIONSHIP.stockid
  is '仓单id';
comment on column BI_BUSINESSRELATIONSHIP.buyer
  is '买家';
comment on column BI_BUSINESSRELATIONSHIP.seller
  is '卖家';
comment on column BI_BUSINESSRELATIONSHIP.received
  is '收货状态0否1是';
comment on column BI_BUSINESSRELATIONSHIP.receiveddate
  is '收货时间';
comment on column BI_BUSINESSRELATIONSHIP.selltime
  is '卖出时间';

prompt
prompt Creating table BI_STOCK
prompt =======================
prompt
create table BI_STOCK
(
  stockid       VARCHAR2(16) not null,
  realstockcode VARCHAR2(30) not null,
  breedid       NUMBER(10) not null,
  warehouseid   VARCHAR2(30) default 0 not null,
  quantity      NUMBER(15,2) default 0 not null,
  unit          VARCHAR2(16) not null,
  ownerfirm     VARCHAR2(32) not null,
  lasttime      DATE,
  createtime    DATE,
  stockstatus   NUMBER(1) default 0 not null
)
;
comment on column BI_STOCK.lasttime
  is '最后一次修改时间';
comment on column BI_STOCK.stockstatus
  is '0:未注册仓单  1：注册仓单  2：已出库仓单  3：已拆单 4：拆仓单处理中 5：出库申请中';
alter table BI_STOCK
  add constraint PK_BI_STOCK primary key (STOCKID);

prompt
prompt Creating table BI_DISMANTLE
prompt ===========================
prompt
create table BI_DISMANTLE
(
  dismantleid   NUMBER(16) not null,
  stockid       VARCHAR2(16) not null,
  newstockid    VARCHAR2(16),
  realstockcode VARCHAR2(30),
  amount        NUMBER(15,2) default 0 not null,
  applytime     DATE not null,
  processtime   DATE,
  status        CHAR(1)
)
;
comment on column BI_DISMANTLE.status
  is '0:申请中 1：拆单成功 2：拆单失败';
alter table BI_DISMANTLE
  add constraint PK_BI_DISMANTLE primary key (DISMANTLEID);
alter table BI_DISMANTLE
  add constraint REFBI_STOCK84 foreign key (STOCKID)
  references BI_STOCK (STOCKID)
  disable
  novalidate;

prompt
prompt Creating table BI_FINANCINGSTOCK
prompt ================================
prompt
create table BI_FINANCINGSTOCK
(
  financingstockid NUMBER(10) not null,
  stockid          VARCHAR2(16),
  status           CHAR(1),
  createtime       DATE not null,
  releasetime      DATE
)
;
comment on column BI_FINANCINGSTOCK.status
  is '''Y'' 有效  ''N'' 无效';
alter table BI_FINANCINGSTOCK
  add constraint PK_BI_FINANNCINGSTOCK primary key (FINANCINGSTOCKID);

prompt
prompt Creating table BI_FIRM
prompt ======================
prompt
create table BI_FIRM
(
  firmid     VARCHAR2(32) not null,
  password   VARCHAR2(32) not null,
  createtime DATE
)
;
alter table BI_FIRM
  add constraint PK_BI_FIRM primary key (FIRMID);

prompt
prompt Creating table BI_FROZENSTOCK
prompt =============================
prompt
create table BI_FROZENSTOCK
(
  frozenstockid NUMBER(10) not null,
  stockid       VARCHAR2(16) not null,
  moduleid      NUMBER(2) not null,
  status        NUMBER(2) default 0 not null,
  createtime    DATE not null,
  releasetime   DATE
)
;
comment on column BI_FROZENSTOCK.moduleid
  is '10综合管理平台
11财务系统
12监管仓库管理系统
13仓单管理系统
14融资系统
15订单交易
18投资类大宗商品交易系统
19加盟会员管理系统
20做市商交易系统
21竞价系统
22银行接入及结算系统
23E现货
24单点登录系统
25实时行情分析系统
26交易客户端
98demo系统
99公用系统';
comment on column BI_FROZENSTOCK.status
  is '0:仓单使用中 1：仓单释放状态';
alter table BI_FROZENSTOCK
  add constraint PK_BI_FROZENSTOCK primary key (FROZENSTOCKID);
alter table BI_FROZENSTOCK
  add constraint REFBI_STOCK141 foreign key (STOCKID)
  references BI_STOCK (STOCKID)
  disable
  novalidate;

prompt
prompt Creating table BI_GOODSPROPERTY
prompt ===============================
prompt
create table BI_GOODSPROPERTY
(
  stockid        VARCHAR2(16) not null,
  propertyname   VARCHAR2(64) not null,
  propertyvalue  VARCHAR2(64),
  propertytypeid NUMBER(15) not null
)
;
alter table BI_GOODSPROPERTY
  add constraint PK_BI_GOODSPROPERTY primary key (STOCKID, PROPERTYNAME);
alter table BI_GOODSPROPERTY
  add constraint REFBI_STOCK82 foreign key (STOCKID)
  references BI_STOCK (STOCKID)
  disable
  novalidate;

prompt
prompt Creating table BI_INVOICEINFORM
prompt ===============================
prompt
create table BI_INVOICEINFORM
(
  stockid       VARCHAR2(16) not null,
  invoicetype   CHAR(1),
  companyname   VARCHAR2(100),
  address       VARCHAR2(200),
  dutyparagraph VARCHAR2(32),
  bank          VARCHAR2(32),
  bankaccount   VARCHAR2(32),
  name          VARCHAR2(32),
  phone         VARCHAR2(16)
)
;
comment on column BI_INVOICEINFORM.stockid
  is '仓单id';
comment on column BI_INVOICEINFORM.invoicetype
  is '发票类型,0/1个人（公司）';
comment on column BI_INVOICEINFORM.companyname
  is '公司名称/单位名称';
comment on column BI_INVOICEINFORM.address
  is '地址';
comment on column BI_INVOICEINFORM.dutyparagraph
  is '税号';
comment on column BI_INVOICEINFORM.bank
  is '开户银行';
comment on column BI_INVOICEINFORM.bankaccount
  is '开户账号';
comment on column BI_INVOICEINFORM.name
  is '收票人姓名';
comment on column BI_INVOICEINFORM.phone
  is '电话';

prompt
prompt Creating table BI_LOGISTICS
prompt ===========================
prompt
create table BI_LOGISTICS
(
  stockid        VARCHAR2(16) not null,
  logisticsorder VARCHAR2(16),
  company        VARCHAR2(32)
)
;
comment on column BI_LOGISTICS.stockid
  is '仓单id';
comment on column BI_LOGISTICS.logisticsorder
  is '物流订单';
comment on column BI_LOGISTICS.company
  is '物流公司';

prompt
prompt Creating table BI_OUTSTOCK
prompt ==========================
prompt
create table BI_OUTSTOCK
(
  outstockid     NUMBER(15) not null,
  stockid        VARCHAR2(16) not null,
  key            VARCHAR2(32) not null,
  deliveryperson VARCHAR2(64),
  idnumber       VARCHAR2(36),
  status         NUMBER(2) default 0 not null,
  createtime     DATE not null,
  processtime    DATE,
  address        VARCHAR2(32),
  phone          VARCHAR2(36),
  deliverystatus NUMBER(2) not null
)
;
comment on column BI_OUTSTOCK.status
  is '0 出库申请 1 撤销出库申请 2 出库完成';
alter table BI_OUTSTOCK
  add constraint PK_BI_OUTSTOCK primary key (OUTSTOCKID);
alter table BI_OUTSTOCK
  add constraint REFBI_STOCK144 foreign key (STOCKID)
  references BI_STOCK (STOCKID)
  disable
  novalidate;

prompt
prompt Creating table BI_PLEDGESTOCK
prompt =============================
prompt
create table BI_PLEDGESTOCK
(
  pledgestock NUMBER(10) not null,
  stockid     VARCHAR2(16) not null,
  orderid     VARCHAR2(20) not null,
  moduleid    NUMBER(2) not null,
  status      NUMBER(2),
  createtime  DATE not null,
  releasetime DATE
)
;
comment on column BI_PLEDGESTOCK.moduleid
  is '10综合管理平台
11财务系统
12监管仓库管理系统
13仓单管理系统
14融资系统
15订单交易
18投资类大宗商品交易系统
19加盟会员管理系统
20做市商交易系统
21竞价系统
22银行接入及结算系统
23E现货
24单点登录系统
25实时行情分析系统
26交易客户端
98demo系统
99公用系统';
comment on column BI_PLEDGESTOCK.status
  is '0:仓单使用中 1：交易成功仓单释放状态';
alter table BI_PLEDGESTOCK
  add constraint PK_BI_PLEDGESTOCK primary key (PLEDGESTOCK);
alter table BI_PLEDGESTOCK
  add constraint REFBI_STOCK135 foreign key (STOCKID)
  references BI_STOCK (STOCKID)
  disable
  novalidate;

prompt
prompt Creating table BI_STOCKCHGLOG
prompt =============================
prompt
create table BI_STOCKCHGLOG
(
  id         NUMBER(10) not null,
  stockid    VARCHAR2(16),
  srcfirm    VARCHAR2(16) not null,
  tarfirm    VARCHAR2(16) not null,
  createtime DATE
)
;
alter table BI_STOCKCHGLOG
  add constraint PK_BI_STOCKCHGLOG primary key (ID);
alter table BI_STOCKCHGLOG
  add constraint REFBI_STOCK137 foreign key (STOCKID)
  references BI_STOCK (STOCKID)
  disable
  novalidate;

prompt
prompt Creating table BI_STOCKOPERATION
prompt ================================
prompt
create table BI_STOCKOPERATION
(
  stockid     VARCHAR2(16) not null,
  operationid NUMBER(2) not null
)
;
comment on column BI_STOCKOPERATION.operationid
  is '0：拆单 1：融资2：卖仓单 3：交收 4：冻结仓单';
alter table BI_STOCKOPERATION
  add constraint PK_BI_STOCKOPERATION primary key (STOCKID, OPERATIONID);
alter table BI_STOCKOPERATION
  add constraint REFBI_STOCK52 foreign key (STOCKID)
  references BI_STOCK (STOCKID)
  disable
  novalidate;

prompt
prompt Creating table BI_SYSTEMPROPS
prompt =============================
prompt
create table BI_SYSTEMPROPS
(
  key          VARCHAR2(32) not null,
  value        VARCHAR2(64) not null,
  runtimevalue VARCHAR2(64),
  note         VARCHAR2(128)
)
;
comment on column BI_SYSTEMPROPS.value
  is '手续费、保证金等参数设置';
alter table BI_SYSTEMPROPS
  add constraint PK_BI_SYSTEMPROPS primary key (KEY);

prompt
prompt Creating table BI_TRADESTOCK
prompt ============================
prompt
create table BI_TRADESTOCK
(
  tradestockid NUMBER(10) not null,
  stockid      VARCHAR2(16) not null,
  tradeno      VARCHAR2(20) not null,
  moduleid     NUMBER(2) not null,
  createtime   DATE not null,
  releasetime  DATE,
  status       NUMBER(2)
)
;
comment on column BI_TRADESTOCK.moduleid
  is '10综合管理平台
11财务系统
12监管仓库管理系统
13仓单管理系统
14融资系统
15订单交易
18投资类大宗商品交易系统
19加盟会员管理系统
20做市商交易系统
21竞价系统
22银行接入及结算系统
23E现货
24单点登录系统
25实时行情分析系统
26交易客户端
98demo系统
99公用系统';
comment on column BI_TRADESTOCK.status
  is '0:仓单使用中 1：交易成功仓单释放状态';
alter table BI_TRADESTOCK
  add constraint PK_BI_TRADESTOCK primary key (TRADESTOCKID);
alter table BI_TRADESTOCK
  add constraint REFBI_STOCK51 foreign key (STOCKID)
  references BI_STOCK (STOCKID)
  disable
  novalidate;

prompt
prompt Creating table BI_WAREHOUSE
prompt ===========================
prompt
create table BI_WAREHOUSE
(
  id                      NUMBER(10) default 0 not null,
  warehouseid             VARCHAR2(30) default 0 not null,
  warehousename           VARCHAR2(128) default 0 not null,
  status                  NUMBER(2) default 0 not null,
  ownershipunits          VARCHAR2(128),
  registeredcapital       NUMBER(15,2) default 0 not null,
  investmentamount        NUMBER(15,2) default 0 not null,
  address                 VARCHAR2(128),
  coordinate              VARCHAR2(128),
  environmental           VARCHAR2(256),
  rank                    NUMBER(2) default 1 not null,
  testconditions          VARCHAR2(256),
  agreementdate           DATE,
  province                VARCHAR2(128),
  city                    VARCHAR2(128),
  postcode                VARCHAR2(10),
  corporaterepresentative VARCHAR2(128),
  representativephone     VARCHAR2(32),
  contactman              VARCHAR2(128),
  phone                   VARCHAR2(32),
  mobile                  VARCHAR2(32),
  fax                     VARCHAR2(32),
  hasdock                 NUMBER(2) default 1 not null,
  docktonnage             NUMBER(15,2) default 0,
  dockdailythroughput     NUMBER(15,2) default 0,
  shiptype                NUMBER(2) default 3,
  hasrailway              NUMBER(2) default 1 not null,
  railwaydailythroughput  NUMBER(15,2) default 0,
  hastanker               NUMBER(2) default 1 not null,
  tankerdailythroughput   NUMBER(15,2) default 0,
  createtime              DATE not null
)
;
comment on column BI_WAREHOUSE.status
  is '0 可用 1 不可用';
comment on column BI_WAREHOUSE.rank
  is '1 一星级 2 二星级 3 三星级 4 四星级 5 五星级';
comment on column BI_WAREHOUSE.hasdock
  is '0 有码头 1 没有码头';
comment on column BI_WAREHOUSE.shiptype
  is '0 海伦 1 江轮 2 全部 3 不支持';
comment on column BI_WAREHOUSE.hasrailway
  is '0 有铁路专线 1 没有铁路专线';
comment on column BI_WAREHOUSE.hastanker
  is '0 支持 1 不支持';
alter table BI_WAREHOUSE
  add constraint PK_BI_WAREHOUSE primary key (ID);

prompt
prompt Creating sequence SEQ_BI_DISMANTLE
prompt ==================================
prompt
create sequence SEQ_BI_DISMANTLE
minvalue 1
maxvalue 9999999999999999999999999999
start with 541
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_BI_FINANCINGSTOCK
prompt =======================================
prompt
create sequence SEQ_BI_FINANCINGSTOCK
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_BI_FROZENSTOCK
prompt ====================================
prompt
create sequence SEQ_BI_FROZENSTOCK
minvalue 1
maxvalue 9999999999999999999999999999
start with 81
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_BI_OUTSTOCK
prompt =================================
prompt
create sequence SEQ_BI_OUTSTOCK
minvalue 1
maxvalue 9999999999999999999999999999
start with 741
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_BI_PLEDGESTOCK
prompt ====================================
prompt
create sequence SEQ_BI_PLEDGESTOCK
minvalue 1
maxvalue 9999999999999999999999999999
start with 41
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_BI_STOCK
prompt ==============================
prompt
create sequence SEQ_BI_STOCK
minvalue 1
maxvalue 9999999999999999999999999999
start with 1021
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_BI_STOCKCHGLOG
prompt ====================================
prompt
create sequence SEQ_BI_STOCKCHGLOG
minvalue 1
maxvalue 9999999999999999999999999999
start with 561
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_BI_TRADESTOCK
prompt ===================================
prompt
create sequence SEQ_BI_TRADESTOCK
minvalue 1
maxvalue 9999999999999999999999999999
start with 584
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_BI_WAREHOUSE
prompt ==================================
prompt
create sequence SEQ_BI_WAREHOUSE
minvalue 1
maxvalue 9999999999999999999999999999
start with 241
increment by 1
cache 20;

prompt
prompt Creating view V_BI_BUSINESSRELATIONSHIP
prompt =======================================
prompt
create or replace force view v_bi_businessrelationship as
select  t."STOCKID",t."BREEDNAME",t."WAREHOUSEID",t."QUANTITY",t."UNIT",t."SELLER",t."BUYER",t."RECEIVED",t."RECEIVEDDATE",t."SELLTIME", nvl(bi.stockid,0)  as invoiceStatus
from (select b.stockid,m.breedname,s.warehouseid,s.quantity,s.unit,b.seller,b.buyer,b.received,b.receiveddate,b.selltime
from  BI_BusinessRelationship b,BI_stock s,m_breed m
where b.stockid=s.stockid and s.breedid=m.breedid)t
left join bi_invoiceinform bi on bi.stockid=t.stockid;

prompt
prompt Creating view V_BI_INVOICEINFORM
prompt ================================
prompt
create or replace force view v_bi_invoiceinform as
select i.stockid,m.breedname,s.warehouseid,s.quantity,s.unit,i.invoicetype,
i.companyname,i.address,i.dutyparagraph,i.bank,i.bankaccount,i.name,i.phone
from  BI_Invoiceinform i,BI_stock s,m_breed m
where i.stockid=s.stockid and s.breedid=m.breedid;

prompt
prompt Creating view V_BI_OUTSTOCK
prompt ===========================
prompt
create or replace force view v_bi_outstock as
select  t3.stockid,t3.realstockcode,t3.breedid,t3.breedname,t3.ownerfirm,t3.warehouseid,t3.quantity,t3.unit,t3.createtime,t3.lasttime,t3.company,t3.logisticsorder,
case when t3.received is null or t3.received='0' then 0
else 1 end isreceived,t3.receiveddate,nvl(i.stockid,0) as invoiceStatus
from (select   t1.stockid,t1.realstockcode,t1.breedid,t1.breedname,t1.ownerfirm,t1.warehouseid,t1.quantity,t1.unit,t1.createtime,t1.lasttime,t1.company,t1.logisticsorder,t2.received,t2.receiveddate from (
              select t.stockid,t.realstockcode,t.breedid,m.breedname,t.ownerfirm,t.warehouseid,t.quantity,t.unit,t.createtime,t.lasttime,b.company,b.logisticsorder from
                     (select stockid,realstockcode,breedid,ownerfirm,warehouseid,quantity,unit,createtime,lasttime from bi_stock o where stockstatus=2) t
                      left  join bi_logistics b on t.stockid=b.stockid
                      inner join  m_breed   m on m.breedid=t.breedid
               ) t1

left  join
(select stockid,received,receiveddate,buyer from bi_businessrelationship  where  selltime in (select selltime from ( select stockid,max(selltime) selltime from bi_businessrelationship group by stockid))) t2
on t1.stockid=t2.stockid and t1.ownerfirm=t2.buyer) t3
LEFT JOIN BI_INVOICEINFORM i ON i.STOCKID=t3.stockid;

prompt
prompt Creating function FN_BI_FIRMADD
prompt ===============================
prompt
create or replace function FN_BI_firmADD
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
  select count(*) into v_cnt from BI_firm where firmid = p_FirmID;
   if (v_cnt > 0) then
    --如果交易商已经存在则重新设置交易商信息
    update BI_firm set password=FN_M_MD5(p_FirmID||'111111'),createtime= sysdate  where firmid=p_FirmID;
  end if;

  insert into BI_firm
      (firmid, password, createtime)
  values
      (p_FirmID, FN_M_MD5(p_FirmID||'111111'), sysdate);

  return 1;
end;
/

prompt
prompt Creating function FN_BI_FIRMDEL
prompt ===============================
prompt
create or replace function FN_BI_FirmDel
(
    p_FirmID   m_firm.firmid%type--交易商代码
)
return integer is
  /**
  * 删除交易商
  * 返回值： 1 成功
  **/
  v_cnt                number(4); --数字变量
  RET_RESULT integer:=-130;--仓单数字变量
begin
    --查看仓单表中状态是否有0:未注册1:注册仓单4:拆弹中 有则不能注销仓单
    select count(*) into v_cnt from bi_stock s where s.ownerfirm=p_FirmID and s.stockstatus in(0,1,4);
    if(v_cnt>0)then
    return RET_RESULT;
    end if;
    return 1;
end;
/

prompt
prompt Creating function FN_BI_UNFROZENBILL
prompt ====================================
prompt
create or replace function FN_BI_UnfrozenBill
(
    p_moduleID   BI_FrozenStock.moduleid%type, --模块编号
	p_stockID    BI_FrozenStock.stockid%type --仓单编号
)
return integer is
  /**
  * 解冻交易商
  * 返回值： 1 成功、-2 已经解冻过了
  **/
  v_cnt number(4); --数字变量

  RET_RESULT integer:=-2;--仓单数字变量
begin
    --查看仓单表中状态是否有0:未注册1:注册仓单4:拆弹中 有则不能注销仓单
    select count(*) into v_cnt from BI_FrozenStock where moduleid=p_moduleID and stockID=p_stockID and status=0;
    if(v_cnt<=0)then
		return RET_RESULT;
    end if;
	--删除仓单业务
	delete from BI_StockOperation where stockID=p_stockID and operationID=4;
	--释放冻结仓单
	update BI_FrozenStock set status=1,releaseTime=sysdate where stockID=p_stockID;
	--返回成功
    return 1;
end;
/


spool off
