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

Date: 2015-11-16 21:20:28
*/


-- ----------------------------
-- Table structure for T_CLEARSTATUS
-- ----------------------------
DROP TABLE "TRADE_GNNT"."T_CLEARSTATUS";
CREATE TABLE "TRADE_GNNT"."T_CLEARSTATUS" (
"ACTIONID" NUMBER(3) NOT NULL ,
"ACTIONNOTE" VARCHAR2(32 BYTE) NOT NULL ,
"STATUS" CHAR(1 BYTE) NOT NULL ,
"FINISHTIME" DATE NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;

-- ----------------------------
-- Records of T_CLEARSTATUS
-- ----------------------------
INSERT INTO "TRADE_GNNT"."T_CLEARSTATUS" VALUES ('0', '结算开始', 'Y', TO_DATE('2015-11-13 21:33:21', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO "TRADE_GNNT"."T_CLEARSTATUS" VALUES ('1', '交收处理', 'Y', TO_DATE('2015-11-13 21:33:21', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO "TRADE_GNNT"."T_CLEARSTATUS" VALUES ('2', '重算交易资金', 'Y', TO_DATE('2015-11-13 21:33:22', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO "TRADE_GNNT"."T_CLEARSTATUS" VALUES ('3', '重算浮亏', 'Y', TO_DATE('2015-11-13 21:33:23', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO "TRADE_GNNT"."T_CLEARSTATUS" VALUES ('4', '延期交易结算', 'Y', TO_DATE('2015-11-13 21:33:23', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO "TRADE_GNNT"."T_CLEARSTATUS" VALUES ('5', '退上日结算保证金', 'Y', TO_DATE('2015-11-13 21:33:23', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO "TRADE_GNNT"."T_CLEARSTATUS" VALUES ('6', '扣当日结算保证金', 'Y', TO_DATE('2015-11-13 21:33:23', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO "TRADE_GNNT"."T_CLEARSTATUS" VALUES ('7', '退上日浮亏', 'Y', TO_DATE('2015-11-13 21:33:23', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO "TRADE_GNNT"."T_CLEARSTATUS" VALUES ('8', '扣当日浮亏', 'Y', TO_DATE('2015-11-13 21:33:23', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO "TRADE_GNNT"."T_CLEARSTATUS" VALUES ('9', '更新交易商资金', 'Y', TO_DATE('2015-11-13 21:33:23', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO "TRADE_GNNT"."T_CLEARSTATUS" VALUES ('10', '导入历史数据', 'Y', TO_DATE('2015-11-13 21:33:24', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO "TRADE_GNNT"."T_CLEARSTATUS" VALUES ('11', '释放冻结数据', 'Y', TO_DATE('2015-11-13 21:33:24', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO "TRADE_GNNT"."T_CLEARSTATUS" VALUES ('12', '返佣操作', 'Y', TO_DATE('2015-11-13 21:33:25', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO "TRADE_GNNT"."T_CLEARSTATUS" VALUES ('13', '结算完成', 'Y', TO_DATE('2015-11-13 21:33:25', 'YYYY-MM-DD HH24:MI:SS'));

-- ----------------------------
-- Indexes structure for table T_CLEARSTATUS
-- ----------------------------

-- ----------------------------
-- Checks structure for table T_CLEARSTATUS
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."T_CLEARSTATUS" ADD CHECK ("ACTIONID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."T_CLEARSTATUS" ADD CHECK ("ACTIONNOTE" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."T_CLEARSTATUS" ADD CHECK ("STATUS" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table T_CLEARSTATUS
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."T_CLEARSTATUS" ADD PRIMARY KEY ("ACTIONID");
