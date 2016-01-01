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

Date: 2015-11-26 20:30:41
*/


-- ----------------------------
-- Table structure for BR_BROKERTYPE
-- ----------------------------
DROP TABLE "TRADE_GNNT"."BR_BROKERTYPE";
CREATE TABLE "TRADE_GNNT"."BR_BROKERTYPE" (
"BORKERTYPE" NUMBER(2) NOT NULL ,
"BROKERNAME" VARCHAR2(64 BYTE) NOT NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;

-- ----------------------------
-- Records of BR_BROKERTYPE
-- ----------------------------
INSERT INTO "TRADE_GNNT"."BR_BROKERTYPE" VALUES ('0', '经纪会员');
INSERT INTO "TRADE_GNNT"."BR_BROKERTYPE" VALUES ('1', '发行会员');
INSERT INTO "TRADE_GNNT"."BR_BROKERTYPE" VALUES ('2', '承销会员');

-- ----------------------------
-- Indexes structure for table BR_BROKERTYPE
-- ----------------------------

-- ----------------------------
-- Checks structure for table BR_BROKERTYPE
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."BR_BROKERTYPE" ADD CHECK ("BORKERTYPE" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."BR_BROKERTYPE" ADD CHECK ("BROKERNAME" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table BR_BROKERTYPE
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."BR_BROKERTYPE" ADD PRIMARY KEY ("BORKERTYPE");
