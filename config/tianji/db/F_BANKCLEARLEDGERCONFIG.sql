/*
Navicat Oracle Data Transfer
Oracle Client Version : 12.1.0.2.0

Source Server         : 172.18.11.27.demo
Source Server Version : 110200
Source Host           : 172.18.11.27:1521
Source Schema         : TRADE_GNNT

Target Server Type    : ORACLE
Target Server Version : 110200
File Encoding         : 65001

Date: 2015-11-11 21:51:55
*/


-- ----------------------------
-- Table structure for F_BANKCLEARLEDGERCONFIG
-- ----------------------------
DROP TABLE "TRADE_GNNT"."F_BANKCLEARLEDGERCONFIG";
CREATE TABLE "TRADE_GNNT"."F_BANKCLEARLEDGERCONFIG" (
"LEDGERCODE" VARCHAR2(16 BYTE) NOT NULL ,
"FEETYPE" NUMBER(2) NOT NULL ,
"FIELDSIGN" NUMBER(1) NOT NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;

-- ----------------------------
-- Records of F_BANKCLEARLEDGERCONFIG
-- ----------------------------
INSERT INTO "TRADE_GNNT"."F_BANKCLEARLEDGERCONFIG" VALUES ('BankFee', '0', '1');
INSERT INTO "TRADE_GNNT"."F_BANKCLEARLEDGERCONFIG" VALUES ('Margin_T', '1', '-1');
INSERT INTO "TRADE_GNNT"."F_BANKCLEARLEDGERCONFIG" VALUES ('SettleMargin_T', '1', '-1');
INSERT INTO "TRADE_GNNT"."F_BANKCLEARLEDGERCONFIG" VALUES ('FL_T', '1', '-1');
INSERT INTO "TRADE_GNNT"."F_BANKCLEARLEDGERCONFIG" VALUES ('TradeFee_T', '0', '1');
INSERT INTO "TRADE_GNNT"."F_BANKCLEARLEDGERCONFIG" VALUES ('SettleFee_T', '0', '1');
INSERT INTO "TRADE_GNNT"."F_BANKCLEARLEDGERCONFIG" VALUES ('Margin_E', '1', '1');
INSERT INTO "TRADE_GNNT"."F_BANKCLEARLEDGERCONFIG" VALUES ('MarginBack_E', '1', '-1');
INSERT INTO "TRADE_GNNT"."F_BANKCLEARLEDGERCONFIG" VALUES ('TradeFee_E', '0', '1');
INSERT INTO "TRADE_GNNT"."F_BANKCLEARLEDGERCONFIG" VALUES ('SettleFee_E', '0', '1');
INSERT INTO "TRADE_GNNT"."F_BANKCLEARLEDGERCONFIG" VALUES ('Subscirption_E', '1', '1');
INSERT INTO "TRADE_GNNT"."F_BANKCLEARLEDGERCONFIG" VALUES ('Margin_V', '1', '1');
INSERT INTO "TRADE_GNNT"."F_BANKCLEARLEDGERCONFIG" VALUES ('TradeFee_V', '0', '1');

-- ----------------------------
-- Indexes structure for table F_BANKCLEARLEDGERCONFIG
-- ----------------------------

-- ----------------------------
-- Checks structure for table F_BANKCLEARLEDGERCONFIG
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."F_BANKCLEARLEDGERCONFIG" ADD CHECK ("LEDGERCODE" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."F_BANKCLEARLEDGERCONFIG" ADD CHECK ("FEETYPE" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."F_BANKCLEARLEDGERCONFIG" ADD CHECK ("FIELDSIGN" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table F_BANKCLEARLEDGERCONFIG
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."F_BANKCLEARLEDGERCONFIG" ADD PRIMARY KEY ("LEDGERCODE");
