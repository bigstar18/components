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

Date: 2015-11-11 22:52:48
*/


-- ----------------------------
-- Table structure for F_CLEARSTATUS
-- ----------------------------
DROP TABLE "TRADE_GNNT"."F_CLEARSTATUS";
CREATE TABLE "TRADE_GNNT"."F_CLEARSTATUS" (
"ACTIONID" NUMBER(3) NOT NULL ,
"ACTIONNOTE" VARCHAR2(32 BYTE) NOT NULL ,
"STATUS" CHAR(1 BYTE) NOT NULL ,
"FINISHTIME" DATE NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON COLUMN "TRADE_GNNT"."F_CLEARSTATUS"."STATUS" IS 'Y:完成
N:未执行';

-- ----------------------------
-- Records of F_CLEARSTATUS
-- ----------------------------
INSERT INTO "TRADE_GNNT"."F_CLEARSTATUS" VALUES ('0', '结算开始', 'Y', TO_DATE('2015-11-11 16:46:43', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO "TRADE_GNNT"."F_CLEARSTATUS" VALUES ('1', '抽取电脑凭证', 'Y', TO_DATE('2015-11-11 16:46:44', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO "TRADE_GNNT"."F_CLEARSTATUS" VALUES ('2', '归属流水及凭证日期', 'Y', TO_DATE('2015-11-11 16:46:44', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO "TRADE_GNNT"."F_CLEARSTATUS" VALUES ('3', '将凭证记入会计账簿', 'Y', TO_DATE('2015-11-11 16:46:44', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO "TRADE_GNNT"."F_CLEARSTATUS" VALUES ('4', '结算账户', 'Y', TO_DATE('2015-11-11 16:46:44', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO "TRADE_GNNT"."F_CLEARSTATUS" VALUES ('5', '生成客户总账', 'Y', TO_DATE('2015-11-11 16:46:44', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO "TRADE_GNNT"."F_CLEARSTATUS" VALUES ('6', '归档历史表', 'Y', TO_DATE('2015-11-11 16:46:44', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO "TRADE_GNNT"."F_CLEARSTATUS" VALUES ('8', '结算完成', 'Y', TO_DATE('2015-11-11 16:46:44', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO "TRADE_GNNT"."F_CLEARSTATUS" VALUES ('7', '生成交易商清算资金数据', 'Y', TO_DATE('2015-11-11 16:46:44', 'YYYY-MM-DD HH24:MI:SS'));

-- ----------------------------
-- Indexes structure for table F_CLEARSTATUS
-- ----------------------------

-- ----------------------------
-- Checks structure for table F_CLEARSTATUS
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."F_CLEARSTATUS" ADD CHECK ("ACTIONID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."F_CLEARSTATUS" ADD CHECK ("ACTIONNOTE" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."F_CLEARSTATUS" ADD CHECK ("STATUS" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table F_CLEARSTATUS
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."F_CLEARSTATUS" ADD PRIMARY KEY ("ACTIONID");
