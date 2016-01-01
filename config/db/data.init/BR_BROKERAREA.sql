/*
Navicat Oracle Data Transfer
Oracle Client Version : 12.1.0.2.0

Source Server         : 172.18.14.9ol
Source Server Version : 110200
Source Host           : 172.18.14.9:1521
Source Schema         : TRADE_GNNT

Target Server Type    : ORACLE
Target Server Version : 110200
File Encoding         : 65001

Date: 2015-11-17 21:26:39
*/


-- ----------------------------
-- Table structure for BR_BROKERAREA
-- ----------------------------
DROP TABLE "TRADE_GNNT"."BR_BROKERAREA";
CREATE TABLE "TRADE_GNNT"."BR_BROKERAREA" (
"AREAID" NUMBER(3) NOT NULL ,
"NAME" VARCHAR2(64 BYTE) NOT NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;

-- ----------------------------
-- Records of BR_BROKERAREA
-- ----------------------------
INSERT INTO "TRADE_GNNT"."BR_BROKERAREA" VALUES ('1', '浙江省');
INSERT INTO "TRADE_GNNT"."BR_BROKERAREA" VALUES ('2', '四川省');
INSERT INTO "TRADE_GNNT"."BR_BROKERAREA" VALUES ('3', '安徽省');
INSERT INTO "TRADE_GNNT"."BR_BROKERAREA" VALUES ('8', '重庆市');
INSERT INTO "TRADE_GNNT"."BR_BROKERAREA" VALUES ('21', '陕西省');
INSERT INTO "TRADE_GNNT"."BR_BROKERAREA" VALUES ('41', '上海市');
INSERT INTO "TRADE_GNNT"."BR_BROKERAREA" VALUES ('4', '江苏省');
INSERT INTO "TRADE_GNNT"."BR_BROKERAREA" VALUES ('5', '山东省');
INSERT INTO "TRADE_GNNT"."BR_BROKERAREA" VALUES ('6', '广东省');
INSERT INTO "TRADE_GNNT"."BR_BROKERAREA" VALUES ('7', '河南省');
INSERT INTO "TRADE_GNNT"."BR_BROKERAREA" VALUES ('9', '北京市');
INSERT INTO "TRADE_GNNT"."BR_BROKERAREA" VALUES ('10', '黑龙江');

-- ----------------------------
-- Indexes structure for table BR_BROKERAREA
-- ----------------------------

-- ----------------------------
-- Checks structure for table BR_BROKERAREA
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."BR_BROKERAREA" ADD CHECK ("AREAID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."BR_BROKERAREA" ADD CHECK ("NAME" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table BR_BROKERAREA
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."BR_BROKERAREA" ADD PRIMARY KEY ("AREAID");
