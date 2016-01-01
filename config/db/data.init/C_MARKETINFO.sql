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

Date: 2015-11-11 22:50:54
*/


-- ----------------------------
-- Table structure for C_MARKETINFO
-- ----------------------------
DROP TABLE "TRADE_GNNT"."C_MARKETINFO";
CREATE TABLE "TRADE_GNNT"."C_MARKETINFO" (
"INFONAME" VARCHAR2(128 BYTE) NOT NULL ,
"INFOVALUE" VARCHAR2(128 BYTE) NOT NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;

-- ----------------------------
-- Records of C_MARKETINFO
-- ----------------------------
INSERT INTO "TRADE_GNNT"."C_MARKETINFO" VALUES ('JMSBrokerURL', 'tcp://10.0.100.181:20071');
INSERT INTO "TRADE_GNNT"."C_MARKETINFO" VALUES ('abbreviation', 'yrdce');
INSERT INTO "TRADE_GNNT"."C_MARKETINFO" VALUES ('copyrightof', '长三角商品交易所信息技术中心');
INSERT INTO "TRADE_GNNT"."C_MARKETINFO" VALUES ('frontIsNeedKey', 'N');
INSERT INTO "TRADE_GNNT"."C_MARKETINFO" VALUES ('marketEmail', 'service@yrdce.com');
INSERT INTO "TRADE_GNNT"."C_MARKETINFO" VALUES ('marketNO', '0');
INSERT INTO "TRADE_GNNT"."C_MARKETINFO" VALUES ('marketName', '长三角商品交易所');
INSERT INTO "TRADE_GNNT"."C_MARKETINFO" VALUES ('marketPhone', '13888888888');
INSERT INTO "TRADE_GNNT"."C_MARKETINFO" VALUES ('mgrIsNeedKey', 'N');
INSERT INTO "TRADE_GNNT"."C_MARKETINFO" VALUES ('warehouseIsNeedKey', 'N');

-- ----------------------------
-- Indexes structure for table C_MARKETINFO
-- ----------------------------

-- ----------------------------
-- Checks structure for table C_MARKETINFO
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."C_MARKETINFO" ADD CHECK ("INFONAME" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."C_MARKETINFO" ADD CHECK ("INFOVALUE" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table C_MARKETINFO
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."C_MARKETINFO" ADD PRIMARY KEY ("INFONAME", "INFOVALUE");
