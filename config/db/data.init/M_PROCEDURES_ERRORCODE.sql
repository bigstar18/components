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

Date: 2015-11-13 21:13:44
*/


-- ----------------------------
-- Table structure for M_PROCEDURES_ERRORCODE
-- ----------------------------
DROP TABLE "TRADE_GNNT"."M_PROCEDURES_ERRORCODE";
CREATE TABLE "TRADE_GNNT"."M_PROCEDURES_ERRORCODE" (
"MODULEID" NUMBER(2) NOT NULL ,
"ERRORCODE" NUMBER(12) NOT NULL ,
"ERRORINFO" VARCHAR2(1024 BYTE) NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON TABLE "TRADE_GNNT"."M_PROCEDURES_ERRORCODE" IS '交易商添加修改删除存储的错误码记录';
COMMENT ON COLUMN "TRADE_GNNT"."M_PROCEDURES_ERRORCODE"."MODULEID" IS '10综合管理平台
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

-- ----------------------------
-- Records of M_PROCEDURES_ERRORCODE
-- ----------------------------
INSERT INTO "TRADE_GNNT"."M_PROCEDURES_ERRORCODE" VALUES ('10', '-900', '交易商不存在');
INSERT INTO "TRADE_GNNT"."M_PROCEDURES_ERRORCODE" VALUES ('11', '-901', '交易商资金不为0');
INSERT INTO "TRADE_GNNT"."M_PROCEDURES_ERRORCODE" VALUES ('13', '-130', '交易商有可用的仓单');
INSERT INTO "TRADE_GNNT"."M_PROCEDURES_ERRORCODE" VALUES ('28', '-1', '交易商有与银行签约信息');
INSERT INTO "TRADE_GNNT"."M_PROCEDURES_ERRORCODE" VALUES ('23', '-230', '交易商有未结束的委托');
INSERT INTO "TRADE_GNNT"."M_PROCEDURES_ERRORCODE" VALUES ('23', '-231', '交易商有未结束的合同');
INSERT INTO "TRADE_GNNT"."M_PROCEDURES_ERRORCODE" VALUES ('23', '-232', '交易商有未答复的议价');
INSERT INTO "TRADE_GNNT"."M_PROCEDURES_ERRORCODE" VALUES ('23', '-233', '交易商保证金不为0');
INSERT INTO "TRADE_GNNT"."M_PROCEDURES_ERRORCODE" VALUES ('23', '-234', '交易商货款不为0');
INSERT INTO "TRADE_GNNT"."M_PROCEDURES_ERRORCODE" VALUES ('23', '-235', '交易商转出金额不为0');
INSERT INTO "TRADE_GNNT"."M_PROCEDURES_ERRORCODE" VALUES ('23', '-236', '交易商诚信金不为0');

-- ----------------------------
-- Indexes structure for table M_PROCEDURES_ERRORCODE
-- ----------------------------

-- ----------------------------
-- Checks structure for table M_PROCEDURES_ERRORCODE
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."M_PROCEDURES_ERRORCODE" ADD CHECK ("MODULEID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_PROCEDURES_ERRORCODE" ADD CHECK ("ERRORCODE" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table M_PROCEDURES_ERRORCODE
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."M_PROCEDURES_ERRORCODE" ADD PRIMARY KEY ("MODULEID", "ERRORCODE");
