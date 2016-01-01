/*
Navicat Oracle Data Transfer
Oracle Client Version : 12.1.0.2.0

Source Server         : 172.17.14.12.tianji
Source Server Version : 110200
Source Host           : 172.17.14.12:1521
Source Schema         : TRADE_GNNT

Target Server Type    : ORACLE
Target Server Version : 110200
File Encoding         : 65001

Date: 2015-11-09 01:10:41
*/


-- ----------------------------
-- Table structure for T_RMICONF
-- ----------------------------
DROP TABLE "TRADE_GNNT"."T_RMICONF";
CREATE TABLE "TRADE_GNNT"."T_RMICONF" (
"SERVICEID" NUMBER(2) NOT NULL ,
"CNNAME" VARCHAR2(64 BYTE) NULL ,
"ENAME" VARCHAR2(64 BYTE) NULL ,
"HOSTIP" VARCHAR2(16 BYTE) NOT NULL ,
"PORT" NUMBER(6) NOT NULL ,
"RMIDATAPORT" NUMBER(6) NOT NULL ,
"ENABLED" CHAR(1 BYTE) NOT NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;

-- ----------------------------
-- Records of T_RMICONF
-- ----------------------------
INSERT INTO "TRADE_GNNT"."T_RMICONF" VALUES ('1', '条件下单服务', 'ConditionOrder', '172.17.12.22', '21011', '21012', 'Y');

-- ----------------------------
-- Indexes structure for table T_RMICONF
-- ----------------------------

-- ----------------------------
-- Checks structure for table T_RMICONF
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."T_RMICONF" ADD CHECK ("SERVICEID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."T_RMICONF" ADD CHECK ("HOSTIP" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."T_RMICONF" ADD CHECK ("PORT" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."T_RMICONF" ADD CHECK ("RMIDATAPORT" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."T_RMICONF" ADD CHECK ("ENABLED" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table T_RMICONF
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."T_RMICONF" ADD PRIMARY KEY ("SERVICEID");
