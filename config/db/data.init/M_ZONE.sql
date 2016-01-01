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

Date: 2015-11-13 21:27:20
*/


-- ----------------------------
-- Table structure for M_ZONE
-- ----------------------------
DROP TABLE "TRADE_GNNT"."M_ZONE";
CREATE TABLE "TRADE_GNNT"."M_ZONE" (
"CODE" VARCHAR2(16 BYTE) NOT NULL ,
"NAME" VARCHAR2(32 BYTE) NOT NULL ,
"ISVISIBAL" CHAR(1 BYTE) DEFAULT 'Y'  NOT NULL ,
"SORTNO" NUMBER(2) DEFAULT 0  NOT NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON COLUMN "TRADE_GNNT"."M_ZONE"."ISVISIBAL" IS 'Y 显示 N 不显示';

-- ----------------------------
-- Records of M_ZONE
-- ----------------------------
INSERT INTO "TRADE_GNNT"."M_ZONE" VALUES ('JSNJ', '南京', 'Y', '3');
INSERT INTO "TRADE_GNNT"."M_ZONE" VALUES ('JS', '江苏', 'Y', '1');
INSERT INTO "TRADE_GNNT"."M_ZONE" VALUES ('WX', '江苏省无锡市', 'Y', '2');

-- ----------------------------
-- Indexes structure for table M_ZONE
-- ----------------------------

-- ----------------------------
-- Checks structure for table M_ZONE
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."M_ZONE" ADD CHECK ("CODE" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_ZONE" ADD CHECK ("NAME" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_ZONE" ADD CHECK ("ISVISIBAL" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_ZONE" ADD CHECK ("SORTNO" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table M_ZONE
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."M_ZONE" ADD PRIMARY KEY ("CODE");
