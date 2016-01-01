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

Date: 2015-11-17 15:09:07
*/


-- ----------------------------
-- Table structure for V_TRADEMODEPARAMS
-- ----------------------------
DROP TABLE "TRADE_GNNT"."V_TRADEMODEPARAMS";
CREATE TABLE "TRADE_GNNT"."V_TRADEMODEPARAMS" (
"ID" NUMBER(10) NOT NULL ,
"NAME" VARCHAR2(32 BYTE) NOT NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;

-- ----------------------------
-- Records of V_TRADEMODEPARAMS
-- ----------------------------
INSERT INTO "TRADE_GNNT"."V_TRADEMODEPARAMS" VALUES ('1', '竞买');
INSERT INTO "TRADE_GNNT"."V_TRADEMODEPARAMS" VALUES ('2', '竞卖');
INSERT INTO "TRADE_GNNT"."V_TRADEMODEPARAMS" VALUES ('3', '招标');

-- ----------------------------
-- Indexes structure for table V_TRADEMODEPARAMS
-- ----------------------------

-- ----------------------------
-- Checks structure for table V_TRADEMODEPARAMS
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."V_TRADEMODEPARAMS" ADD CHECK ("ID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."V_TRADEMODEPARAMS" ADD CHECK ("NAME" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."V_TRADEMODEPARAMS" ADD CHECK ("ID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."V_TRADEMODEPARAMS" ADD CHECK ("NAME" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table V_TRADEMODEPARAMS
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."V_TRADEMODEPARAMS" ADD PRIMARY KEY ("ID");
