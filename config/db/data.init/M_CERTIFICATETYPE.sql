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

Date: 2015-11-13 21:14:06
*/


-- ----------------------------
-- Table structure for M_CERTIFICATETYPE
-- ----------------------------
DROP TABLE "TRADE_GNNT"."M_CERTIFICATETYPE";
CREATE TABLE "TRADE_GNNT"."M_CERTIFICATETYPE" (
"CODE" NUMBER(2) NOT NULL ,
"NAME" VARCHAR2(32 BYTE) NOT NULL ,
"ISVISIBAL" CHAR(1 BYTE) DEFAULT 'Y'  NOT NULL ,
"SORTNO" NUMBER(2) DEFAULT 0  NOT NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON COLUMN "TRADE_GNNT"."M_CERTIFICATETYPE"."ISVISIBAL" IS 'Y 显示 N 不显示';

-- ----------------------------
-- Records of M_CERTIFICATETYPE
-- ----------------------------
INSERT INTO "TRADE_GNNT"."M_CERTIFICATETYPE" VALUES ('1', '居民身份证', 'Y', '1');
INSERT INTO "TRADE_GNNT"."M_CERTIFICATETYPE" VALUES ('2', '士官证', 'Y', '2');
INSERT INTO "TRADE_GNNT"."M_CERTIFICATETYPE" VALUES ('3', '学生证', 'N', '3');
INSERT INTO "TRADE_GNNT"."M_CERTIFICATETYPE" VALUES ('4', '驾驶证', 'Y', '4');
INSERT INTO "TRADE_GNNT"."M_CERTIFICATETYPE" VALUES ('5', '护照', 'Y', '5');
INSERT INTO "TRADE_GNNT"."M_CERTIFICATETYPE" VALUES ('6', '港澳通行证', 'Y', '6');

-- ----------------------------
-- Indexes structure for table M_CERTIFICATETYPE
-- ----------------------------

-- ----------------------------
-- Checks structure for table M_CERTIFICATETYPE
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."M_CERTIFICATETYPE" ADD CHECK ("CODE" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_CERTIFICATETYPE" ADD CHECK ("NAME" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_CERTIFICATETYPE" ADD CHECK ("ISVISIBAL" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_CERTIFICATETYPE" ADD CHECK ("SORTNO" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table M_CERTIFICATETYPE
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."M_CERTIFICATETYPE" ADD PRIMARY KEY ("CODE");
