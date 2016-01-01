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

Date: 2015-11-13 21:13:29
*/


-- ----------------------------
-- Table structure for M_SYSTEMPROPS
-- ----------------------------
DROP TABLE "TRADE_GNNT"."M_SYSTEMPROPS";
CREATE TABLE "TRADE_GNNT"."M_SYSTEMPROPS" (
"KEY" VARCHAR2(32 BYTE) NOT NULL ,
"VALUE" VARCHAR2(64 BYTE) NOT NULL ,
"RUNTIMEVALUE" VARCHAR2(64 BYTE) NULL ,
"NOTE" VARCHAR2(128 BYTE) NULL ,
"FIRMIDLENGTH" VARCHAR2(32 BYTE) DEFAULT '15'  NOT NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON COLUMN "TRADE_GNNT"."M_SYSTEMPROPS"."VALUE" IS '手续费、保证金等参数设置';

-- ----------------------------
-- Records of M_SYSTEMPROPS
-- ----------------------------
INSERT INTO "TRADE_GNNT"."M_SYSTEMPROPS" VALUES ('Offset', '1.0000', '1.0000', '损益比例上限', '15');

-- ----------------------------
-- Indexes structure for table M_SYSTEMPROPS
-- ----------------------------

-- ----------------------------
-- Checks structure for table M_SYSTEMPROPS
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."M_SYSTEMPROPS" ADD CHECK ("KEY" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_SYSTEMPROPS" ADD CHECK ("VALUE" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_SYSTEMPROPS" ADD CHECK ("FIRMIDLENGTH" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table M_SYSTEMPROPS
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."M_SYSTEMPROPS" ADD PRIMARY KEY ("KEY");
