/*
Navicat Oracle Data Transfer
Oracle Client Version : 12.1.0.2.0

Source Server         : 172.18.11.27.demo
Source Server Version : 110200
Source Host           : 172.18.11.27:1521
Source Schema         : TRADE_GNNT

Target Server Type    : ORACLE
Target Server Version : 110200
File Encoding         : 65001

Date: 2015-11-17 20:44:56
*/


-- ----------------------------
-- Table structure for E_MARKET
-- ----------------------------
DROP TABLE "TRADE_GNNT"."E_MARKET";
CREATE TABLE "TRADE_GNNT"."E_MARKET" (
"MARKETNAME" VARCHAR2(32 BYTE) NOT NULL ,
"TRADEDATE" DATE NOT NULL ,
"RUNMODE" CHAR(1 BYTE) DEFAULT 'A'  NOT NULL ,
"STATUS" NUMBER(2) DEFAULT 3  NOT NULL ,
"RECOVERTIME" VARCHAR2(10 BYTE) NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON COLUMN "TRADE_GNNT"."E_MARKET"."RUNMODE" IS '开市模式：
A：自动开市
M：手动开市';
COMMENT ON COLUMN "TRADE_GNNT"."E_MARKET"."STATUS" IS '状态：
1 交易状态
2 交易暂停状态
3 闭市状态
';
COMMENT ON COLUMN "TRADE_GNNT"."E_MARKET"."RECOVERTIME" IS '暂停指定恢复时间';

-- ----------------------------
-- Records of E_MARKET
-- ----------------------------
INSERT INTO "TRADE_GNNT"."E_MARKET" VALUES ('天骥云商', TO_DATE('2015-11-17 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'A', '3', null);

-- ----------------------------
-- Indexes structure for table E_MARKET
-- ----------------------------

-- ----------------------------
-- Checks structure for table E_MARKET
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."E_MARKET" ADD CHECK ("MARKETNAME" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."E_MARKET" ADD CHECK ("TRADEDATE" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."E_MARKET" ADD CHECK ("RUNMODE" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."E_MARKET" ADD CHECK ("STATUS" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table E_MARKET
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."E_MARKET" ADD PRIMARY KEY ("MARKETNAME");
