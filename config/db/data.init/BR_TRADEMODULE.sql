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

Date: 2015-11-11 22:49:22
*/


-- ----------------------------
-- Table structure for BR_TRADEMODULE
-- ----------------------------
DROP TABLE "TRADE_GNNT"."BR_TRADEMODULE";
CREATE TABLE "TRADE_GNNT"."BR_TRADEMODULE" (
"MODULEID" NUMBER(2) NOT NULL ,
"CNNAME" VARCHAR2(64 BYTE) NOT NULL ,
"ENNAME" VARCHAR2(64 BYTE) NULL ,
"SHORTNAME" VARCHAR2(16 BYTE) NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;

-- ----------------------------
-- Records of BR_TRADEMODULE
-- ----------------------------
INSERT INTO "TRADE_GNNT"."BR_TRADEMODULE" VALUES ('15', '订单大宗商品交易系统', null, '订单系统');

-- ----------------------------
-- Indexes structure for table BR_TRADEMODULE
-- ----------------------------

-- ----------------------------
-- Checks structure for table BR_TRADEMODULE
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."BR_TRADEMODULE" ADD CHECK ("MODULEID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."BR_TRADEMODULE" ADD CHECK ("CNNAME" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table BR_TRADEMODULE
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."BR_TRADEMODULE" ADD PRIMARY KEY ("MODULEID");
