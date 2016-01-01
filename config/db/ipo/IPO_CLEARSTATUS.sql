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

Date: 2015-12-03 23:21:37
*/


-- ----------------------------
-- Table structure for IPO_CLEARSTATUS
-- ----------------------------
DROP TABLE "TRADE_GNNT"."IPO_CLEARSTATUS";
CREATE TABLE "TRADE_GNNT"."IPO_CLEARSTATUS" (
"ACTIONID" NUMBER(3) NOT NULL ,
"ACTIONNOTE" VARCHAR2(32 BYTE) NOT NULL ,
"STATUS" CHAR(1 BYTE) NOT NULL ,
"FINISHTIME" DATE NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;

-- ----------------------------
-- Records of IPO_CLEARSTATUS
-- ----------------------------
INSERT INTO "TRADE_GNNT"."IPO_CLEARSTATUS" VALUES ('0', '结算开始', 'N', null);
INSERT INTO "TRADE_GNNT"."IPO_CLEARSTATUS" VALUES ('1', '收付当日货款、手续费', 'N', null);
INSERT INTO "TRADE_GNNT"."IPO_CLEARSTATUS" VALUES ('2', '更新交易商资金', 'N', null);
INSERT INTO "TRADE_GNNT"."IPO_CLEARSTATUS" VALUES ('3', '导入历史数据', 'N', null);
INSERT INTO "TRADE_GNNT"."IPO_CLEARSTATUS" VALUES ('4', '释放冻结数据', 'N', null);
INSERT INTO "TRADE_GNNT"."IPO_CLEARSTATUS" VALUES ('5', '结算完成', 'N', null);

-- ----------------------------
-- Indexes structure for table IPO_CLEARSTATUS
-- ----------------------------

-- ----------------------------
-- Checks structure for table IPO_CLEARSTATUS
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."IPO_CLEARSTATUS" ADD CHECK ("ACTIONID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."IPO_CLEARSTATUS" ADD CHECK ("ACTIONNOTE" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."IPO_CLEARSTATUS" ADD CHECK ("STATUS" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table IPO_CLEARSTATUS
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."IPO_CLEARSTATUS" ADD PRIMARY KEY ("ACTIONID");
