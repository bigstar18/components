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

Date: 2015-11-17 14:40:59
*/


-- ----------------------------
-- Table structure for BR_REWARDPARAMETERPROPS
-- ----------------------------
DROP TABLE "TRADE_GNNT"."BR_REWARDPARAMETERPROPS";
CREATE TABLE "TRADE_GNNT"."BR_REWARDPARAMETERPROPS" (
"AUTOPAY" CHAR(1 BYTE) NULL ,
"PAYPERIOD" NUMBER(1) NULL ,
"PAYPERIODDATE" NUMBER(3) NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;

-- ----------------------------
-- Records of BR_REWARDPARAMETERPROPS
-- ----------------------------
INSERT INTO "TRADE_GNNT"."BR_REWARDPARAMETERPROPS" VALUES ('Y', '2', '3');
