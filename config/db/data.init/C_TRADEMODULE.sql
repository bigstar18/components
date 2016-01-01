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

Date: 2015-11-11 22:51:11
*/


-- ----------------------------
-- Table structure for C_TRADEMODULE
-- ----------------------------
DROP TABLE "TRADE_GNNT"."C_TRADEMODULE";
CREATE TABLE "TRADE_GNNT"."C_TRADEMODULE" (
"MODULEID" NUMBER(2) NOT NULL ,
"CNNAME" VARCHAR2(64 BYTE) NOT NULL ,
"ENNAME" VARCHAR2(64 BYTE) NULL ,
"SHORTNAME" VARCHAR2(16 BYTE) NULL ,
"ADDFIRMFN" VARCHAR2(36 BYTE) NULL ,
"UPDATEFIRMSTATUSFN" VARCHAR2(36 BYTE) NULL ,
"DELFIRMFN" VARCHAR2(36 BYTE) NULL ,
"ISFIRMSET" CHAR(1 BYTE) DEFAULT 'N'  NOT NULL ,
"HOSTIP" VARCHAR2(16 BYTE) NULL ,
"PORT" NUMBER(6) NULL ,
"RMIDATAPORT" NUMBER(6) NULL ,
"ISBALANCECHECK" CHAR(1 BYTE) DEFAULT 'N'  NOT NULL ,
"ISNEEDBREED" CHAR(1 BYTE) NOT NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON COLUMN "TRADE_GNNT"."C_TRADEMODULE"."MODULEID" IS '10综合管理平台
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
COMMENT ON COLUMN "TRADE_GNNT"."C_TRADEMODULE"."ISFIRMSET" IS '‘Y’ 是 ‘N’ 否 (如果需要在公用前台我的平台中显示本系统，还需要在公用系统的 spring_sys_msg.xml 中配置上本系统的配置信息)';
COMMENT ON COLUMN "TRADE_GNNT"."C_TRADEMODULE"."ISBALANCECHECK" IS 'Y：是 N：否';
COMMENT ON COLUMN "TRADE_GNNT"."C_TRADEMODULE"."ISNEEDBREED" IS '本系统是否需要综合管理平台增加的商品   Y:是   N:否';

-- ----------------------------
-- Records of C_TRADEMODULE
-- ----------------------------
INSERT INTO "TRADE_GNNT"."C_TRADEMODULE" VALUES ('10', '综合管理平台', 'integrated', '综合管理平台', null, null, null, 'Y', null, null, null, 'N', 'N');
INSERT INTO "TRADE_GNNT"."C_TRADEMODULE" VALUES ('11', '财务系统', 'finance', '财务系统', 'FN_F_firmADD', 'FN_F_FirmToStatus', 'FN_F_FirmDel', 'Y', null, null, null, 'N', 'N');
INSERT INTO "TRADE_GNNT"."C_TRADEMODULE" VALUES ('13', '仓单管理系统', 'bill', '仓单管理系统', 'FN_BI_firmADD', null, 'FN_BI_FirmDel', 'Y', '10.0.100.181', '20371', '20372', 'Y', 'N');
INSERT INTO "TRADE_GNNT"."C_TRADEMODULE" VALUES ('32', '单点登录系统', 'activeuser', '单点登录系统', null, null, null, 'N', null, null, null, 'N', 'N');
INSERT INTO "TRADE_GNNT"."C_TRADEMODULE" VALUES ('12', '仓库管理系统', 'warehouse', '仓库管理系统', null, null, null, 'N', null, null, null, 'N', 'N');
INSERT INTO "TRADE_GNNT"."C_TRADEMODULE" VALUES ('19', '加盟会员管理系统', 'broker', '加盟会员管理系统', 'FN_BR_firmADD', null, null, 'N', null, null, null, 'N', 'N');
INSERT INTO "TRADE_GNNT"."C_TRADEMODULE" VALUES ('15', '订单管理系统', 'timebargain', '订单管理系统', 'FN_T_firmADD', null, 'FN_T_FirmDel', 'Y', '10.0.100.181', '20671', '20672', 'Y', 'Y');
INSERT INTO "TRADE_GNNT"."C_TRADEMODULE" VALUES ('99', '公用系统', 'common', '公用系统', null, null, null, 'N', '10.0.100.181', '20171', '20172', 'Y', 'N');
INSERT INTO "TRADE_GNNT"."C_TRADEMODULE" VALUES ('21', '竞价系统', 'vendue', '竞价管理系统', 'FN_V_FirmAdd', null, 'FN_V_FirmDel', 'Y', '10.0.100.181', '20871', '20872', 'Y', 'Y');
INSERT INTO "TRADE_GNNT"."C_TRADEMODULE" VALUES ('40', 'IPO', 'ipo', 'IPO', null, null, null, 'Y', null, null, null, 'N', 'N');
INSERT INTO "TRADE_GNNT"."C_TRADEMODULE" VALUES ('28', '银行接口', 'bank', '银行接口', 'FN_F_B_firmADD', null, 'FN_F_B_FirmDEL', 'Y', null, '20571', '20572', 'N', 'N');

-- ----------------------------
-- Indexes structure for table C_TRADEMODULE
-- ----------------------------

-- ----------------------------
-- Checks structure for table C_TRADEMODULE
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."C_TRADEMODULE" ADD CHECK ("MODULEID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."C_TRADEMODULE" ADD CHECK ("CNNAME" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."C_TRADEMODULE" ADD CHECK ("ISFIRMSET" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."C_TRADEMODULE" ADD CHECK ("ISBALANCECHECK" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."C_TRADEMODULE" ADD CHECK ("ISNEEDBREED" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table C_TRADEMODULE
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."C_TRADEMODULE" ADD PRIMARY KEY ("MODULEID");
