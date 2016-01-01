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
  is '�ֵ�id';
comment on column BI_BUSINESSRELATIONSHIP.buyer
  is '���';
comment on column BI_BUSINESSRELATIONSHIP.seller
  is '����';
comment on column BI_BUSINESSRELATIONSHIP.received
  is '�ջ�״̬0��1��';
comment on column BI_BUSINESSRELATIONSHIP.receiveddate
  is '�ջ�ʱ��';
comment on column BI_BUSINESSRELATIONSHIP.selltime
  is '����ʱ��';

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
  is '���һ���޸�ʱ��';
comment on column BI_STOCK.stockstatus
  is '0:δע��ֵ�  1��ע��ֵ�  2���ѳ���ֵ�  3���Ѳ� 4����ֵ������� 5������������';
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
  is '0:������ 1���𵥳ɹ� 2����ʧ��';
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
  is '''Y'' ��Ч  ''N'' ��Ч';
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
  is '10�ۺϹ���ƽ̨
11����ϵͳ
12��ֿܲ����ϵͳ
13�ֵ�����ϵͳ
14����ϵͳ
15��������
18Ͷ���������Ʒ����ϵͳ
19���˻�Ա����ϵͳ
20�����̽���ϵͳ
21����ϵͳ
22���н��뼰����ϵͳ
23E�ֻ�
24�����¼ϵͳ
25ʵʱ�������ϵͳ
26���׿ͻ���
98demoϵͳ
99����ϵͳ';
comment on column BI_FROZENSTOCK.status
  is '0:�ֵ�ʹ���� 1���ֵ��ͷ�״̬';
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
  is '�ֵ�id';
comment on column BI_INVOICEINFORM.invoicetype
  is '��Ʊ����,0/1���ˣ���˾��';
comment on column BI_INVOICEINFORM.companyname
  is '��˾����/��λ����';
comment on column BI_INVOICEINFORM.address
  is '��ַ';
comment on column BI_INVOICEINFORM.dutyparagraph
  is '˰��';
comment on column BI_INVOICEINFORM.bank
  is '��������';
comment on column BI_INVOICEINFORM.bankaccount
  is '�����˺�';
comment on column BI_INVOICEINFORM.name
  is '��Ʊ������';
comment on column BI_INVOICEINFORM.phone
  is '�绰';

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
  is '�ֵ�id';
comment on column BI_LOGISTICS.logisticsorder
  is '��������';
comment on column BI_LOGISTICS.company
  is '������˾';

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
  is '0 �������� 1 ������������ 2 �������';
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
  is '10�ۺϹ���ƽ̨
11����ϵͳ
12��ֿܲ����ϵͳ
13�ֵ�����ϵͳ
14����ϵͳ
15��������
18Ͷ���������Ʒ����ϵͳ
19���˻�Ա����ϵͳ
20�����̽���ϵͳ
21����ϵͳ
22���н��뼰����ϵͳ
23E�ֻ�
24�����¼ϵͳ
25ʵʱ�������ϵͳ
26���׿ͻ���
98demoϵͳ
99����ϵͳ';
comment on column BI_PLEDGESTOCK.status
  is '0:�ֵ�ʹ���� 1�����׳ɹ��ֵ��ͷ�״̬';
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
  is '0���� 1������2�����ֵ� 3������ 4������ֵ�';
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
  is '�����ѡ���֤��Ȳ�������';
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
  is '10�ۺϹ���ƽ̨
11����ϵͳ
12��ֿܲ����ϵͳ
13�ֵ�����ϵͳ
14����ϵͳ
15��������
18Ͷ���������Ʒ����ϵͳ
19���˻�Ա����ϵͳ
20�����̽���ϵͳ
21����ϵͳ
22���н��뼰����ϵͳ
23E�ֻ�
24�����¼ϵͳ
25ʵʱ�������ϵͳ
26���׿ͻ���
98demoϵͳ
99����ϵͳ';
comment on column BI_TRADESTOCK.status
  is '0:�ֵ�ʹ���� 1�����׳ɹ��ֵ��ͷ�״̬';
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
  is '0 ���� 1 ������';
comment on column BI_WAREHOUSE.rank
  is '1 һ�Ǽ� 2 ���Ǽ� 3 ���Ǽ� 4 ���Ǽ� 5 ���Ǽ�';
comment on column BI_WAREHOUSE.hasdock
  is '0 ����ͷ 1 û����ͷ';
comment on column BI_WAREHOUSE.shiptype
  is '0 ���� 1 ���� 2 ȫ�� 3 ��֧��';
comment on column BI_WAREHOUSE.hasrailway
  is '0 ����·ר�� 1 û����·ר��';
comment on column BI_WAREHOUSE.hastanker
  is '0 ֧�� 1 ��֧��';
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
    p_FirmID m_firm.firmid%type --�����̴���
)
return integer is
  /**
  * �ֻ�ϵͳ��ӽ�����
  * ����ֵ�� 1 �ɹ�
  **/
  v_cnt                number(4); --���ֱ���
begin
  select count(*) into v_cnt from BI_firm where firmid = p_FirmID;
   if (v_cnt > 0) then
    --����������Ѿ��������������ý�������Ϣ
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
    p_FirmID   m_firm.firmid%type--�����̴���
)
return integer is
  /**
  * ɾ��������
  * ����ֵ�� 1 �ɹ�
  **/
  v_cnt                number(4); --���ֱ���
  RET_RESULT integer:=-130;--�ֵ����ֱ���
begin
    --�鿴�ֵ�����״̬�Ƿ���0:δע��1:ע��ֵ�4:���� ������ע���ֵ�
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
    p_moduleID   BI_FrozenStock.moduleid%type, --ģ����
	p_stockID    BI_FrozenStock.stockid%type --�ֵ����
)
return integer is
  /**
  * �ⶳ������
  * ����ֵ�� 1 �ɹ���-2 �Ѿ��ⶳ����
  **/
  v_cnt number(4); --���ֱ���

  RET_RESULT integer:=-2;--�ֵ����ֱ���
begin
    --�鿴�ֵ�����״̬�Ƿ���0:δע��1:ע��ֵ�4:���� ������ע���ֵ�
    select count(*) into v_cnt from BI_FrozenStock where moduleid=p_moduleID and stockID=p_stockID and status=0;
    if(v_cnt<=0)then
		return RET_RESULT;
    end if;
	--ɾ���ֵ�ҵ��
	delete from BI_StockOperation where stockID=p_stockID and operationID=4;
	--�ͷŶ���ֵ�
	update BI_FrozenStock set status=1,releaseTime=sysdate where stockID=p_stockID;
	--���سɹ�
    return 1;
end;
/


spool off
