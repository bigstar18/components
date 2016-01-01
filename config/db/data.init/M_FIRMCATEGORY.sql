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

Date: 2015-11-13 21:26:38
*/


-- ----------------------------
-- Table structure for M_FIRMCATEGORY
-- ----------------------------
DROP TABLE "TRADE_GNNT"."M_FIRMCATEGORY";
CREATE TABLE "TRADE_GNNT"."M_FIRMCATEGORY" (
"ID" NUMBER(10) NOT NULL ,
"NAME" VARCHAR2(128 BYTE) DEFAULT '未分类'  NOT NULL ,
"NOTE" VARCHAR2(128 BYTE) NULL ,
"ISVISIBAL" CHAR(1 BYTE) DEFAULT 'Y'  NOT NULL ,
"SORTNO" NUMBER(2) DEFAULT 0  NOT NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON COLUMN "TRADE_GNNT"."M_FIRMCATEGORY"."ISVISIBAL" IS 'Y 显示 N 不显示';

-- ----------------------------
-- Records of M_FIRMCATEGORY
-- ----------------------------
INSERT INTO "TRADE_GNNT"."M_FIRMCATEGORY" VALUES ('21', '白银贸易商', '白银贸易商', 'Y', '4');
INSERT INTO "TRADE_GNNT"."M_FIRMCATEGORY" VALUES ('1', '个人', '个人交易所', 'Y', '1');
INSERT INTO "TRADE_GNNT"."M_FIRMCATEGORY" VALUES ('2', '普通会员', '普通交易所会员', 'Y', '2');
INSERT INTO "TRADE_GNNT"."M_FIRMCATEGORY" VALUES ('3', '结算会员', '具有结算资格的会员', 'Y', '3');
INSERT INTO "TRADE_GNNT"."M_FIRMCATEGORY" VALUES ('41', '特别会员', null, 'Y', '11');
INSERT INTO "TRADE_GNNT"."M_FIRMCATEGORY" VALUES ('22', '白银供应商', '白银供应商', 'Y', '5');
INSERT INTO "TRADE_GNNT"."M_FIRMCATEGORY" VALUES ('23', '白银采购商', '白银采购商', 'Y', '6');

-- ----------------------------
-- Indexes structure for table M_FIRMCATEGORY
-- ----------------------------

-- ----------------------------
-- Checks structure for table M_FIRMCATEGORY
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."M_FIRMCATEGORY" ADD CHECK ("ID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_FIRMCATEGORY" ADD CHECK ("NAME" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_FIRMCATEGORY" ADD CHECK ("ISVISIBAL" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_FIRMCATEGORY" ADD CHECK ("SORTNO" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table M_FIRMCATEGORY
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."M_FIRMCATEGORY" ADD PRIMARY KEY ("ID");
