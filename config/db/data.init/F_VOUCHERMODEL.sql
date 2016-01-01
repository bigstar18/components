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

Date: 2015-11-17 14:44:46
*/


-- ----------------------------
-- Table structure for F_VOUCHERMODEL
-- ----------------------------
DROP TABLE "TRADE_GNNT"."F_VOUCHERMODEL";
CREATE TABLE "TRADE_GNNT"."F_VOUCHERMODEL" (
"CODE" VARCHAR2(16 BYTE) NOT NULL ,
"NAME" VARCHAR2(64 BYTE) NULL ,
"SUMMARYNO" CHAR(5 BYTE) NOT NULL ,
"DEBITCODE" VARCHAR2(38 BYTE) NOT NULL ,
"CREDITCODE" VARCHAR2(38 BYTE) NOT NULL ,
"NEEDCONTRACTNO" CHAR(1 BYTE) NOT NULL ,
"NOTE" VARCHAR2(128 BYTE) NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON TABLE "TRADE_GNNT"."F_VOUCHERMODEL" IS '用于快捷创建手工凭证的模板';

-- ----------------------------
-- Records of F_VOUCHERMODEL
-- ----------------------------
INSERT INTO "TRADE_GNNT"."F_VOUCHERMODEL" VALUES ('1', '入金-现金', '11001', '1001', '200100-', 'N', null);
INSERT INTO "TRADE_GNNT"."F_VOUCHERMODEL" VALUES ('2', '入金-存款', '11001', '100201', '200100-', 'N', null);
INSERT INTO "TRADE_GNNT"."F_VOUCHERMODEL" VALUES ('3', '出金-现金', '11002', '200100-', '1001', 'N', null);
INSERT INTO "TRADE_GNNT"."F_VOUCHERMODEL" VALUES ('4', '出金-存款', '11002', '200100-', '100201', 'N', null);

-- ----------------------------
-- Indexes structure for table F_VOUCHERMODEL
-- ----------------------------

-- ----------------------------
-- Checks structure for table F_VOUCHERMODEL
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."F_VOUCHERMODEL" ADD CHECK ("CODE" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."F_VOUCHERMODEL" ADD CHECK ("SUMMARYNO" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."F_VOUCHERMODEL" ADD CHECK ("DEBITCODE" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."F_VOUCHERMODEL" ADD CHECK ("CREDITCODE" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."F_VOUCHERMODEL" ADD CHECK ("NEEDCONTRACTNO" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table F_VOUCHERMODEL
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."F_VOUCHERMODEL" ADD PRIMARY KEY ("CODE");
