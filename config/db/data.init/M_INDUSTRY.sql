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

Date: 2015-11-13 21:26:47
*/


-- ----------------------------
-- Table structure for M_INDUSTRY
-- ----------------------------
DROP TABLE "TRADE_GNNT"."M_INDUSTRY";
CREATE TABLE "TRADE_GNNT"."M_INDUSTRY" (
"CODE" VARCHAR2(16 BYTE) NOT NULL ,
"NAME" VARCHAR2(32 BYTE) NOT NULL ,
"ISVISIBAL" CHAR(1 BYTE) DEFAULT 'Y'  NOT NULL ,
"SORTNO" NUMBER(2) DEFAULT 0  NOT NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON COLUMN "TRADE_GNNT"."M_INDUSTRY"."ISVISIBAL" IS 'Y 显示 N 不显示';

-- ----------------------------
-- Records of M_INDUSTRY
-- ----------------------------
INSERT INTO "TRADE_GNNT"."M_INDUSTRY" VALUES ('JR', '金融', 'Y', '3');
INSERT INTO "TRADE_GNNT"."M_INDUSTRY" VALUES ('CYY', '餐饮业', 'Y', '1');
INSERT INTO "TRADE_GNNT"."M_INDUSTRY" VALUES ('FDC', '房地产', 'Y', '2');

-- ----------------------------
-- Indexes structure for table M_INDUSTRY
-- ----------------------------

-- ----------------------------
-- Checks structure for table M_INDUSTRY
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."M_INDUSTRY" ADD CHECK ("CODE" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_INDUSTRY" ADD CHECK ("NAME" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_INDUSTRY" ADD CHECK ("ISVISIBAL" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_INDUSTRY" ADD CHECK ("SORTNO" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table M_INDUSTRY
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."M_INDUSTRY" ADD PRIMARY KEY ("CODE");
