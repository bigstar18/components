/*
Navicat Oracle Data Transfer
Oracle Client Version : 12.1.0.2.0

Source Server         : 10.0.100.183-dev
Source Server Version : 110200
Source Host           : 10.0.100.183:1521
Source Schema         : TRADE_GNNT

Target Server Type    : ORACLE
Target Server Version : 110200
File Encoding         : 65001

Date: 2015-11-10 20:52:47
*/


-- ----------------------------
-- Table structure for BI_BUSINESSRELATIONSHIP
-- ----------------------------
DROP TABLE "TRADE_GNNT"."BI_BUSINESSRELATIONSHIP";
CREATE TABLE "TRADE_GNNT"."BI_BUSINESSRELATIONSHIP" (
"STOCKID" VARCHAR2(16 BYTE) NOT NULL ,
"BUYER" VARCHAR2(32 BYTE) NOT NULL ,
"SELLER" VARCHAR2(32 BYTE) NOT NULL ,
"RECEIVED" CHAR(1 BYTE) NULL ,
"RECEIVEDDATE" DATE NULL ,
"SELLTIME" DATE NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON COLUMN "TRADE_GNNT"."BI_BUSINESSRELATIONSHIP"."STOCKID" IS '仓单id';
COMMENT ON COLUMN "TRADE_GNNT"."BI_BUSINESSRELATIONSHIP"."BUYER" IS '买家';
COMMENT ON COLUMN "TRADE_GNNT"."BI_BUSINESSRELATIONSHIP"."SELLER" IS '卖家';
COMMENT ON COLUMN "TRADE_GNNT"."BI_BUSINESSRELATIONSHIP"."RECEIVED" IS '收货状态0否1是';
COMMENT ON COLUMN "TRADE_GNNT"."BI_BUSINESSRELATIONSHIP"."RECEIVEDDATE" IS '收货时间';
COMMENT ON COLUMN "TRADE_GNNT"."BI_BUSINESSRELATIONSHIP"."SELLTIME" IS '卖出时间';

-- ----------------------------
-- Records of BI_BUSINESSRELATIONSHIP
-- ----------------------------

-- ----------------------------
-- Table structure for BI_DISMANTLE
-- ----------------------------
DROP TABLE "TRADE_GNNT"."BI_DISMANTLE";
CREATE TABLE "TRADE_GNNT"."BI_DISMANTLE" (
"DISMANTLEID" NUMBER(16) NOT NULL ,
"STOCKID" VARCHAR2(16 BYTE) NOT NULL ,
"NEWSTOCKID" VARCHAR2(16 BYTE) NULL ,
"REALSTOCKCODE" VARCHAR2(30 BYTE) NULL ,
"AMOUNT" NUMBER(15,2) DEFAULT 0  NOT NULL ,
"APPLYTIME" DATE NOT NULL ,
"PROCESSTIME" DATE NULL ,
"STATUS" CHAR(1 BYTE) NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON COLUMN "TRADE_GNNT"."BI_DISMANTLE"."STATUS" IS '0:申请中 1：拆单成功 2：拆单失败';

-- ----------------------------
-- Records of BI_DISMANTLE
-- ----------------------------

-- ----------------------------
-- Table structure for BI_FINANCINGSTOCK
-- ----------------------------
DROP TABLE "TRADE_GNNT"."BI_FINANCINGSTOCK";
CREATE TABLE "TRADE_GNNT"."BI_FINANCINGSTOCK" (
"FINANCINGSTOCKID" NUMBER(10) NOT NULL ,
"STOCKID" VARCHAR2(16 BYTE) NULL ,
"STATUS" CHAR(1 BYTE) NULL ,
"CREATETIME" DATE NOT NULL ,
"RELEASETIME" DATE NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON COLUMN "TRADE_GNNT"."BI_FINANCINGSTOCK"."STATUS" IS '''Y'' 有效  ''N'' 无效';

-- ----------------------------
-- Records of BI_FINANCINGSTOCK
-- ----------------------------

-- ----------------------------
-- Table structure for BI_FIRM
-- ----------------------------
DROP TABLE "TRADE_GNNT"."BI_FIRM";
CREATE TABLE "TRADE_GNNT"."BI_FIRM" (
"FIRMID" VARCHAR2(32 BYTE) NOT NULL ,
"PASSWORD" VARCHAR2(32 BYTE) NOT NULL ,
"CREATETIME" DATE NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;

-- ----------------------------
-- Records of BI_FIRM
-- ----------------------------

-- ----------------------------
-- Table structure for BI_FROZENSTOCK
-- ----------------------------
DROP TABLE "TRADE_GNNT"."BI_FROZENSTOCK";
CREATE TABLE "TRADE_GNNT"."BI_FROZENSTOCK" (
"FROZENSTOCKID" NUMBER(10) NOT NULL ,
"STOCKID" VARCHAR2(16 BYTE) NOT NULL ,
"MODULEID" NUMBER(2) NOT NULL ,
"STATUS" NUMBER(2) DEFAULT 0  NOT NULL ,
"CREATETIME" DATE NOT NULL ,
"RELEASETIME" DATE NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON COLUMN "TRADE_GNNT"."BI_FROZENSTOCK"."MODULEID" IS '10综合管理平台
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
COMMENT ON COLUMN "TRADE_GNNT"."BI_FROZENSTOCK"."STATUS" IS '0:仓单使用中 1：仓单释放状态';

-- ----------------------------
-- Records of BI_FROZENSTOCK
-- ----------------------------

-- ----------------------------
-- Table structure for BI_GOODSPROPERTY
-- ----------------------------
DROP TABLE "TRADE_GNNT"."BI_GOODSPROPERTY";
CREATE TABLE "TRADE_GNNT"."BI_GOODSPROPERTY" (
"STOCKID" VARCHAR2(16 BYTE) NOT NULL ,
"PROPERTYNAME" VARCHAR2(64 BYTE) NOT NULL ,
"PROPERTYVALUE" VARCHAR2(64 BYTE) NULL ,
"PROPERTYTYPEID" NUMBER(15) NOT NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;

-- ----------------------------
-- Records of BI_GOODSPROPERTY
-- ----------------------------

-- ----------------------------
-- Table structure for BI_INVOICEINFORM
-- ----------------------------
DROP TABLE "TRADE_GNNT"."BI_INVOICEINFORM";
CREATE TABLE "TRADE_GNNT"."BI_INVOICEINFORM" (
"STOCKID" VARCHAR2(16 BYTE) NOT NULL ,
"INVOICETYPE" CHAR(1 BYTE) NULL ,
"COMPANYNAME" VARCHAR2(100 BYTE) NULL ,
"ADDRESS" VARCHAR2(200 BYTE) NULL ,
"DUTYPARAGRAPH" VARCHAR2(32 BYTE) NULL ,
"BANK" VARCHAR2(32 BYTE) NULL ,
"BANKACCOUNT" VARCHAR2(32 BYTE) NULL ,
"NAME" VARCHAR2(32 BYTE) NULL ,
"PHONE" VARCHAR2(16 BYTE) NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON COLUMN "TRADE_GNNT"."BI_INVOICEINFORM"."STOCKID" IS '仓单id';
COMMENT ON COLUMN "TRADE_GNNT"."BI_INVOICEINFORM"."INVOICETYPE" IS '发票类型,0/1个人（公司）';
COMMENT ON COLUMN "TRADE_GNNT"."BI_INVOICEINFORM"."COMPANYNAME" IS '公司名称/单位名称';
COMMENT ON COLUMN "TRADE_GNNT"."BI_INVOICEINFORM"."ADDRESS" IS '地址';
COMMENT ON COLUMN "TRADE_GNNT"."BI_INVOICEINFORM"."DUTYPARAGRAPH" IS '税号';
COMMENT ON COLUMN "TRADE_GNNT"."BI_INVOICEINFORM"."BANK" IS '开户银行';
COMMENT ON COLUMN "TRADE_GNNT"."BI_INVOICEINFORM"."BANKACCOUNT" IS '开户账号';
COMMENT ON COLUMN "TRADE_GNNT"."BI_INVOICEINFORM"."NAME" IS '收票人姓名';
COMMENT ON COLUMN "TRADE_GNNT"."BI_INVOICEINFORM"."PHONE" IS '电话';

-- ----------------------------
-- Records of BI_INVOICEINFORM
-- ----------------------------
INSERT INTO "TRADE_GNNT"."BI_INVOICEINFORM" VALUES ('823', '0', null, '高浪东路999号', null, null, null, '王灏天', '15651500942');
INSERT INTO "TRADE_GNNT"."BI_INVOICEINFORM" VALUES ('869', '1', '长三角', '高浪东路999号', '123456', '建设银行', '6225768718613333', null, '0451-53671512');
INSERT INTO "TRADE_GNNT"."BI_INVOICEINFORM" VALUES ('963', '0', null, '高浪东路999号', null, null, null, 'wanghaotian', '15651500942');
INSERT INTO "TRADE_GNNT"."BI_INVOICEINFORM" VALUES ('964', '1', '长三角商品交易所有限公司', '高浪东路999号', '123456', '建设银行', '6225768718613333', null, '0510-68069027');
INSERT INTO "TRADE_GNNT"."BI_INVOICEINFORM" VALUES ('848', '0', null, '高浪东路999号', null, null, null, '王灏天', '15651500942');
INSERT INTO "TRADE_GNNT"."BI_INVOICEINFORM" VALUES ('824', '1', '长三角商品交易所有限公司', '太湖城管委会', '123456', '建设银行', '6217001240005970777', null, '0510-68069027');
INSERT INTO "TRADE_GNNT"."BI_INVOICEINFORM" VALUES ('822', '0', null, '高浪东路999号', null, null, null, 'wanghaotian', '15651500942');
INSERT INTO "TRADE_GNNT"."BI_INVOICEINFORM" VALUES ('825', '1', '长三角商品交易所有限公司', '高浪东路999号', '123456', '建设银行', '6225768718613333', null, '0510-68069027');
INSERT INTO "TRADE_GNNT"."BI_INVOICEINFORM" VALUES ('724', '0', null, '高浪东路999号', null, null, null, 'wanghaotian', '15651500942');
INSERT INTO "TRADE_GNNT"."BI_INVOICEINFORM" VALUES ('823', '0', null, '高浪东路999号', null, null, null, '王灏天', '15651500942');
INSERT INTO "TRADE_GNNT"."BI_INVOICEINFORM" VALUES ('869', '1', '长三角', '高浪东路999号', '123456', '建设银行', '6225768718613333', null, '0451-53671512');
INSERT INTO "TRADE_GNNT"."BI_INVOICEINFORM" VALUES ('963', '0', null, '高浪东路999号', null, null, null, 'wanghaotian', '15651500942');
INSERT INTO "TRADE_GNNT"."BI_INVOICEINFORM" VALUES ('964', '1', '长三角商品交易所有限公司', '高浪东路999号', '123456', '建设银行', '6225768718613333', null, '0510-68069027');
INSERT INTO "TRADE_GNNT"."BI_INVOICEINFORM" VALUES ('848', '0', null, '高浪东路999号', null, null, null, '王灏天', '15651500942');
INSERT INTO "TRADE_GNNT"."BI_INVOICEINFORM" VALUES ('824', '1', '长三角商品交易所有限公司', '太湖城管委会', '123456', '建设银行', '6217001240005970777', null, '0510-68069027');
INSERT INTO "TRADE_GNNT"."BI_INVOICEINFORM" VALUES ('822', '0', null, '高浪东路999号', null, null, null, 'wanghaotian', '15651500942');
INSERT INTO "TRADE_GNNT"."BI_INVOICEINFORM" VALUES ('825', '1', '长三角商品交易所有限公司', '高浪东路999号', '123456', '建设银行', '6225768718613333', null, '0510-68069027');
INSERT INTO "TRADE_GNNT"."BI_INVOICEINFORM" VALUES ('724', '0', null, '高浪东路999号', null, null, null, 'wanghaotian', '15651500942');

-- ----------------------------
-- Table structure for BI_LOGISTICS
-- ----------------------------
DROP TABLE "TRADE_GNNT"."BI_LOGISTICS";
CREATE TABLE "TRADE_GNNT"."BI_LOGISTICS" (
"STOCKID" VARCHAR2(16 BYTE) NOT NULL ,
"LOGISTICSORDER" VARCHAR2(16 BYTE) NULL ,
"COMPANY" VARCHAR2(32 BYTE) NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON COLUMN "TRADE_GNNT"."BI_LOGISTICS"."STOCKID" IS '仓单id';
COMMENT ON COLUMN "TRADE_GNNT"."BI_LOGISTICS"."LOGISTICSORDER" IS '物流订单';
COMMENT ON COLUMN "TRADE_GNNT"."BI_LOGISTICS"."COMPANY" IS '物流公司';

-- ----------------------------
-- Records of BI_LOGISTICS
-- ----------------------------

-- ----------------------------
-- Table structure for BI_OUTSTOCK
-- ----------------------------
DROP TABLE "TRADE_GNNT"."BI_OUTSTOCK";
CREATE TABLE "TRADE_GNNT"."BI_OUTSTOCK" (
"OUTSTOCKID" NUMBER(15) NOT NULL ,
"STOCKID" VARCHAR2(16 BYTE) NOT NULL ,
"KEY" VARCHAR2(32 BYTE) NOT NULL ,
"DELIVERYPERSON" VARCHAR2(64 BYTE) NULL ,
"IDNUMBER" VARCHAR2(36 BYTE) NULL ,
"STATUS" NUMBER(2) DEFAULT 0  NOT NULL ,
"CREATETIME" DATE NOT NULL ,
"PROCESSTIME" DATE NULL ,
"ADDRESS" VARCHAR2(32 BYTE) NULL ,
"PHONE" VARCHAR2(36 BYTE) NULL ,
"DELIVERYSTATUS" NUMBER(2) NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON COLUMN "TRADE_GNNT"."BI_OUTSTOCK"."STATUS" IS '0 出库申请 1 撤销出库申请 2 出库完成';

-- ----------------------------
-- Records of BI_OUTSTOCK
-- ----------------------------

-- ----------------------------
-- Table structure for BI_PLEDGESTOCK
-- ----------------------------
DROP TABLE "TRADE_GNNT"."BI_PLEDGESTOCK";
CREATE TABLE "TRADE_GNNT"."BI_PLEDGESTOCK" (
"PLEDGESTOCK" NUMBER(10) NOT NULL ,
"STOCKID" VARCHAR2(16 BYTE) NOT NULL ,
"ORDERID" VARCHAR2(20 BYTE) NOT NULL ,
"MODULEID" NUMBER(2) NOT NULL ,
"STATUS" NUMBER(2) NULL ,
"CREATETIME" DATE NOT NULL ,
"RELEASETIME" DATE NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON COLUMN "TRADE_GNNT"."BI_PLEDGESTOCK"."MODULEID" IS '10综合管理平台
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
COMMENT ON COLUMN "TRADE_GNNT"."BI_PLEDGESTOCK"."STATUS" IS '0:仓单使用中 1：交易成功仓单释放状态';

-- ----------------------------
-- Records of BI_PLEDGESTOCK
-- ----------------------------

-- ----------------------------
-- Table structure for BI_STOCK
-- ----------------------------
DROP TABLE "TRADE_GNNT"."BI_STOCK";
CREATE TABLE "TRADE_GNNT"."BI_STOCK" (
"STOCKID" VARCHAR2(16 BYTE) NOT NULL ,
"REALSTOCKCODE" VARCHAR2(30 BYTE) NOT NULL ,
"BREEDID" NUMBER(10) NOT NULL ,
"WAREHOUSEID" VARCHAR2(30 BYTE) DEFAULT 0  NOT NULL ,
"QUANTITY" NUMBER(15,2) DEFAULT 0  NOT NULL ,
"UNIT" VARCHAR2(16 BYTE) NOT NULL ,
"OWNERFIRM" VARCHAR2(32 BYTE) NOT NULL ,
"LASTTIME" DATE NULL ,
"CREATETIME" DATE NULL ,
"STOCKSTATUS" NUMBER(1) DEFAULT 0  NOT NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON COLUMN "TRADE_GNNT"."BI_STOCK"."LASTTIME" IS '最后一次修改时间';
COMMENT ON COLUMN "TRADE_GNNT"."BI_STOCK"."STOCKSTATUS" IS '0:未注册仓单  1：注册仓单  2：已出库仓单  3：已拆单 4：拆仓单处理中 5：出库申请中';

-- ----------------------------
-- Records of BI_STOCK
-- ----------------------------

-- ----------------------------
-- Table structure for BI_STOCKCHGLOG
-- ----------------------------
DROP TABLE "TRADE_GNNT"."BI_STOCKCHGLOG";
CREATE TABLE "TRADE_GNNT"."BI_STOCKCHGLOG" (
"ID" NUMBER(10) NOT NULL ,
"STOCKID" VARCHAR2(16 BYTE) NULL ,
"SRCFIRM" VARCHAR2(16 BYTE) NOT NULL ,
"TARFIRM" VARCHAR2(16 BYTE) NOT NULL ,
"CREATETIME" DATE NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;

-- ----------------------------
-- Records of BI_STOCKCHGLOG
-- ----------------------------

-- ----------------------------
-- Table structure for BI_STOCKOPERATION
-- ----------------------------
DROP TABLE "TRADE_GNNT"."BI_STOCKOPERATION";
CREATE TABLE "TRADE_GNNT"."BI_STOCKOPERATION" (
"STOCKID" VARCHAR2(16 BYTE) NOT NULL ,
"OPERATIONID" NUMBER(2) NOT NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON COLUMN "TRADE_GNNT"."BI_STOCKOPERATION"."OPERATIONID" IS '0：拆单 1：融资2：卖仓单 3：交收 4：冻结仓单';

-- ----------------------------
-- Records of BI_STOCKOPERATION
-- ----------------------------

-- ----------------------------
-- Table structure for BI_SYSTEMPROPS
-- ----------------------------
DROP TABLE "TRADE_GNNT"."BI_SYSTEMPROPS";
CREATE TABLE "TRADE_GNNT"."BI_SYSTEMPROPS" (
"KEY" VARCHAR2(32 BYTE) NOT NULL ,
"VALUE" VARCHAR2(64 BYTE) NOT NULL ,
"RUNTIMEVALUE" VARCHAR2(64 BYTE) NULL ,
"NOTE" VARCHAR2(128 BYTE) NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON COLUMN "TRADE_GNNT"."BI_SYSTEMPROPS"."VALUE" IS '手续费、保证金等参数设置';

-- ----------------------------
-- Records of BI_SYSTEMPROPS
-- ----------------------------

-- ----------------------------
-- Table structure for BI_TRADESTOCK
-- ----------------------------
DROP TABLE "TRADE_GNNT"."BI_TRADESTOCK";
CREATE TABLE "TRADE_GNNT"."BI_TRADESTOCK" (
"TRADESTOCKID" NUMBER(10) NOT NULL ,
"STOCKID" VARCHAR2(16 BYTE) NOT NULL ,
"TRADENO" VARCHAR2(20 BYTE) NOT NULL ,
"MODULEID" NUMBER(2) NOT NULL ,
"CREATETIME" DATE NOT NULL ,
"RELEASETIME" DATE NULL ,
"STATUS" NUMBER(2) NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON COLUMN "TRADE_GNNT"."BI_TRADESTOCK"."MODULEID" IS '10综合管理平台
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
COMMENT ON COLUMN "TRADE_GNNT"."BI_TRADESTOCK"."STATUS" IS '0:仓单使用中 1：交易成功仓单释放状态';

-- ----------------------------
-- Records of BI_TRADESTOCK
-- ----------------------------

-- ----------------------------
-- Table structure for BI_WAREHOUSE
-- ----------------------------
DROP TABLE "TRADE_GNNT"."BI_WAREHOUSE";
CREATE TABLE "TRADE_GNNT"."BI_WAREHOUSE" (
"ID" NUMBER(10) DEFAULT 0  NOT NULL ,
"WAREHOUSEID" VARCHAR2(30 BYTE) DEFAULT 0  NOT NULL ,
"WAREHOUSENAME" VARCHAR2(128 BYTE) DEFAULT 0  NOT NULL ,
"STATUS" NUMBER(2) DEFAULT 0  NOT NULL ,
"OWNERSHIPUNITS" VARCHAR2(128 BYTE) NULL ,
"REGISTEREDCAPITAL" NUMBER(15,2) DEFAULT 0  NOT NULL ,
"INVESTMENTAMOUNT" NUMBER(15,2) DEFAULT 0  NOT NULL ,
"ADDRESS" VARCHAR2(128 BYTE) NULL ,
"COORDINATE" VARCHAR2(128 BYTE) NULL ,
"ENVIRONMENTAL" VARCHAR2(256 BYTE) NULL ,
"RANK" NUMBER(2) DEFAULT 1  NOT NULL ,
"TESTCONDITIONS" VARCHAR2(256 BYTE) NULL ,
"AGREEMENTDATE" DATE NULL ,
"PROVINCE" VARCHAR2(128 BYTE) NULL ,
"CITY" VARCHAR2(128 BYTE) NULL ,
"POSTCODE" VARCHAR2(10 BYTE) NULL ,
"CORPORATEREPRESENTATIVE" VARCHAR2(128 BYTE) NULL ,
"REPRESENTATIVEPHONE" VARCHAR2(32 BYTE) NULL ,
"CONTACTMAN" VARCHAR2(128 BYTE) NULL ,
"PHONE" VARCHAR2(32 BYTE) NULL ,
"MOBILE" VARCHAR2(32 BYTE) NULL ,
"FAX" VARCHAR2(32 BYTE) NULL ,
"HASDOCK" NUMBER(2) DEFAULT 1  NOT NULL ,
"DOCKTONNAGE" NUMBER(15,2) DEFAULT 0  NULL ,
"DOCKDAILYTHROUGHPUT" NUMBER(15,2) DEFAULT 0  NULL ,
"SHIPTYPE" NUMBER(2) DEFAULT 3  NULL ,
"HASRAILWAY" NUMBER(2) DEFAULT 1  NOT NULL ,
"RAILWAYDAILYTHROUGHPUT" NUMBER(15,2) DEFAULT 0  NULL ,
"HASTANKER" NUMBER(2) DEFAULT 1  NOT NULL ,
"TANKERDAILYTHROUGHPUT" NUMBER(15,2) DEFAULT 0  NULL ,
"CREATETIME" DATE NOT NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON COLUMN "TRADE_GNNT"."BI_WAREHOUSE"."STATUS" IS '0 可用 1 不可用';
COMMENT ON COLUMN "TRADE_GNNT"."BI_WAREHOUSE"."RANK" IS '1 一星级 2 二星级 3 三星级 4 四星级 5 五星级';
COMMENT ON COLUMN "TRADE_GNNT"."BI_WAREHOUSE"."HASDOCK" IS '0 有码头 1 没有码头';
COMMENT ON COLUMN "TRADE_GNNT"."BI_WAREHOUSE"."SHIPTYPE" IS '0 海伦 1 江轮 2 全部 3 不支持';
COMMENT ON COLUMN "TRADE_GNNT"."BI_WAREHOUSE"."HASRAILWAY" IS '0 有铁路专线 1 没有铁路专线';
COMMENT ON COLUMN "TRADE_GNNT"."BI_WAREHOUSE"."HASTANKER" IS '0 支持 1 不支持';

-- ----------------------------
-- Records of BI_WAREHOUSE
-- ----------------------------

-- ----------------------------
-- Checks structure for table BI_BUSINESSRELATIONSHIP
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."BI_BUSINESSRELATIONSHIP" ADD CHECK ("STOCKID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."BI_BUSINESSRELATIONSHIP" ADD CHECK ("BUYER" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."BI_BUSINESSRELATIONSHIP" ADD CHECK ("SELLER" IS NOT NULL);

-- ----------------------------
-- Indexes structure for table BI_DISMANTLE
-- ----------------------------

-- ----------------------------
-- Checks structure for table BI_DISMANTLE
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."BI_DISMANTLE" ADD CHECK ("DISMANTLEID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."BI_DISMANTLE" ADD CHECK ("STOCKID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."BI_DISMANTLE" ADD CHECK ("AMOUNT" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."BI_DISMANTLE" ADD CHECK ("APPLYTIME" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table BI_DISMANTLE
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."BI_DISMANTLE" ADD PRIMARY KEY ("DISMANTLEID");

-- ----------------------------
-- Indexes structure for table BI_FINANCINGSTOCK
-- ----------------------------

-- ----------------------------
-- Checks structure for table BI_FINANCINGSTOCK
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."BI_FINANCINGSTOCK" ADD CHECK ("FINANCINGSTOCKID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."BI_FINANCINGSTOCK" ADD CHECK ("CREATETIME" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table BI_FINANCINGSTOCK
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."BI_FINANCINGSTOCK" ADD PRIMARY KEY ("FINANCINGSTOCKID");

-- ----------------------------
-- Indexes structure for table BI_FIRM
-- ----------------------------

-- ----------------------------
-- Checks structure for table BI_FIRM
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."BI_FIRM" ADD CHECK ("FIRMID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."BI_FIRM" ADD CHECK ("PASSWORD" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table BI_FIRM
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."BI_FIRM" ADD PRIMARY KEY ("FIRMID");

-- ----------------------------
-- Indexes structure for table BI_FROZENSTOCK
-- ----------------------------

-- ----------------------------
-- Checks structure for table BI_FROZENSTOCK
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."BI_FROZENSTOCK" ADD CHECK ("FROZENSTOCKID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."BI_FROZENSTOCK" ADD CHECK ("STOCKID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."BI_FROZENSTOCK" ADD CHECK ("MODULEID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."BI_FROZENSTOCK" ADD CHECK ("STATUS" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."BI_FROZENSTOCK" ADD CHECK ("CREATETIME" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table BI_FROZENSTOCK
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."BI_FROZENSTOCK" ADD PRIMARY KEY ("FROZENSTOCKID");

-- ----------------------------
-- Indexes structure for table BI_GOODSPROPERTY
-- ----------------------------

-- ----------------------------
-- Checks structure for table BI_GOODSPROPERTY
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."BI_GOODSPROPERTY" ADD CHECK ("STOCKID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."BI_GOODSPROPERTY" ADD CHECK ("PROPERTYNAME" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."BI_GOODSPROPERTY" ADD CHECK ("PROPERTYTYPEID" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table BI_GOODSPROPERTY
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."BI_GOODSPROPERTY" ADD PRIMARY KEY ("STOCKID", "PROPERTYNAME");

-- ----------------------------
-- Checks structure for table BI_INVOICEINFORM
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."BI_INVOICEINFORM" ADD CHECK ("STOCKID" IS NOT NULL);

-- ----------------------------
-- Checks structure for table BI_LOGISTICS
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."BI_LOGISTICS" ADD CHECK ("STOCKID" IS NOT NULL);

-- ----------------------------
-- Indexes structure for table BI_OUTSTOCK
-- ----------------------------

-- ----------------------------
-- Checks structure for table BI_OUTSTOCK
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."BI_OUTSTOCK" ADD CHECK ("OUTSTOCKID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."BI_OUTSTOCK" ADD CHECK ("STOCKID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."BI_OUTSTOCK" ADD CHECK ("KEY" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."BI_OUTSTOCK" ADD CHECK ("STATUS" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."BI_OUTSTOCK" ADD CHECK ("CREATETIME" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."BI_OUTSTOCK" ADD CHECK ("DELIVERYSTATUS" IS NOT NULL) DISABLE;

-- ----------------------------
-- Primary Key structure for table BI_OUTSTOCK
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."BI_OUTSTOCK" ADD PRIMARY KEY ("OUTSTOCKID");

-- ----------------------------
-- Indexes structure for table BI_PLEDGESTOCK
-- ----------------------------

-- ----------------------------
-- Checks structure for table BI_PLEDGESTOCK
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."BI_PLEDGESTOCK" ADD CHECK ("PLEDGESTOCK" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."BI_PLEDGESTOCK" ADD CHECK ("STOCKID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."BI_PLEDGESTOCK" ADD CHECK ("ORDERID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."BI_PLEDGESTOCK" ADD CHECK ("MODULEID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."BI_PLEDGESTOCK" ADD CHECK ("CREATETIME" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table BI_PLEDGESTOCK
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."BI_PLEDGESTOCK" ADD PRIMARY KEY ("PLEDGESTOCK");

-- ----------------------------
-- Indexes structure for table BI_STOCK
-- ----------------------------

-- ----------------------------
-- Checks structure for table BI_STOCK
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."BI_STOCK" ADD CHECK ("STOCKID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."BI_STOCK" ADD CHECK ("REALSTOCKCODE" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."BI_STOCK" ADD CHECK ("BREEDID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."BI_STOCK" ADD CHECK ("WAREHOUSEID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."BI_STOCK" ADD CHECK ("QUANTITY" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."BI_STOCK" ADD CHECK ("UNIT" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."BI_STOCK" ADD CHECK ("OWNERFIRM" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."BI_STOCK" ADD CHECK ("STOCKSTATUS" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table BI_STOCK
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."BI_STOCK" ADD PRIMARY KEY ("STOCKID");

-- ----------------------------
-- Indexes structure for table BI_STOCKCHGLOG
-- ----------------------------

-- ----------------------------
-- Checks structure for table BI_STOCKCHGLOG
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."BI_STOCKCHGLOG" ADD CHECK ("ID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."BI_STOCKCHGLOG" ADD CHECK ("SRCFIRM" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."BI_STOCKCHGLOG" ADD CHECK ("TARFIRM" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table BI_STOCKCHGLOG
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."BI_STOCKCHGLOG" ADD PRIMARY KEY ("ID");

-- ----------------------------
-- Indexes structure for table BI_STOCKOPERATION
-- ----------------------------

-- ----------------------------
-- Checks structure for table BI_STOCKOPERATION
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."BI_STOCKOPERATION" ADD CHECK ("STOCKID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."BI_STOCKOPERATION" ADD CHECK ("OPERATIONID" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table BI_STOCKOPERATION
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."BI_STOCKOPERATION" ADD PRIMARY KEY ("STOCKID", "OPERATIONID");

-- ----------------------------
-- Indexes structure for table BI_SYSTEMPROPS
-- ----------------------------

-- ----------------------------
-- Checks structure for table BI_SYSTEMPROPS
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."BI_SYSTEMPROPS" ADD CHECK ("KEY" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."BI_SYSTEMPROPS" ADD CHECK ("VALUE" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table BI_SYSTEMPROPS
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."BI_SYSTEMPROPS" ADD PRIMARY KEY ("KEY");

-- ----------------------------
-- Indexes structure for table BI_TRADESTOCK
-- ----------------------------

-- ----------------------------
-- Checks structure for table BI_TRADESTOCK
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."BI_TRADESTOCK" ADD CHECK ("TRADESTOCKID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."BI_TRADESTOCK" ADD CHECK ("STOCKID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."BI_TRADESTOCK" ADD CHECK ("TRADENO" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."BI_TRADESTOCK" ADD CHECK ("MODULEID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."BI_TRADESTOCK" ADD CHECK ("CREATETIME" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table BI_TRADESTOCK
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."BI_TRADESTOCK" ADD PRIMARY KEY ("TRADESTOCKID");

-- ----------------------------
-- Indexes structure for table BI_WAREHOUSE
-- ----------------------------

-- ----------------------------
-- Checks structure for table BI_WAREHOUSE
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."BI_WAREHOUSE" ADD CHECK ("ID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."BI_WAREHOUSE" ADD CHECK ("WAREHOUSEID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."BI_WAREHOUSE" ADD CHECK ("WAREHOUSENAME" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."BI_WAREHOUSE" ADD CHECK ("STATUS" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."BI_WAREHOUSE" ADD CHECK ("REGISTEREDCAPITAL" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."BI_WAREHOUSE" ADD CHECK ("INVESTMENTAMOUNT" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."BI_WAREHOUSE" ADD CHECK ("RANK" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."BI_WAREHOUSE" ADD CHECK ("HASDOCK" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."BI_WAREHOUSE" ADD CHECK ("HASRAILWAY" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."BI_WAREHOUSE" ADD CHECK ("HASTANKER" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."BI_WAREHOUSE" ADD CHECK ("CREATETIME" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table BI_WAREHOUSE
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."BI_WAREHOUSE" ADD PRIMARY KEY ("ID");

-- ----------------------------
-- Foreign Key structure for table "TRADE_GNNT"."BI_DISMANTLE"
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."BI_DISMANTLE" ADD FOREIGN KEY ("STOCKID") REFERENCES "TRADE_GNNT"."BI_STOCK" ("STOCKID") DISABLE;

-- ----------------------------
-- Foreign Key structure for table "TRADE_GNNT"."BI_FROZENSTOCK"
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."BI_FROZENSTOCK" ADD FOREIGN KEY ("STOCKID") REFERENCES "TRADE_GNNT"."BI_STOCK" ("STOCKID") DISABLE;

-- ----------------------------
-- Foreign Key structure for table "TRADE_GNNT"."BI_GOODSPROPERTY"
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."BI_GOODSPROPERTY" ADD FOREIGN KEY ("STOCKID") REFERENCES "TRADE_GNNT"."BI_STOCK" ("STOCKID") DISABLE;

-- ----------------------------
-- Foreign Key structure for table "TRADE_GNNT"."BI_OUTSTOCK"
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."BI_OUTSTOCK" ADD FOREIGN KEY ("STOCKID") REFERENCES "TRADE_GNNT"."BI_STOCK" ("STOCKID") DISABLE;

-- ----------------------------
-- Foreign Key structure for table "TRADE_GNNT"."BI_PLEDGESTOCK"
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."BI_PLEDGESTOCK" ADD FOREIGN KEY ("STOCKID") REFERENCES "TRADE_GNNT"."BI_STOCK" ("STOCKID") DISABLE;

-- ----------------------------
-- Foreign Key structure for table "TRADE_GNNT"."BI_STOCKCHGLOG"
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."BI_STOCKCHGLOG" ADD FOREIGN KEY ("STOCKID") REFERENCES "TRADE_GNNT"."BI_STOCK" ("STOCKID") DISABLE;

-- ----------------------------
-- Foreign Key structure for table "TRADE_GNNT"."BI_STOCKOPERATION"
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."BI_STOCKOPERATION" ADD FOREIGN KEY ("STOCKID") REFERENCES "TRADE_GNNT"."BI_STOCK" ("STOCKID") DISABLE;

-- ----------------------------
-- Foreign Key structure for table "TRADE_GNNT"."BI_TRADESTOCK"
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."BI_TRADESTOCK" ADD FOREIGN KEY ("STOCKID") REFERENCES "TRADE_GNNT"."BI_STOCK" ("STOCKID") DISABLE;
