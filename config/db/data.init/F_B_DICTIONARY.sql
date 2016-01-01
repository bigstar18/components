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

Date: 2015-11-11 22:51:40
*/


-- ----------------------------
-- Table structure for F_B_DICTIONARY
-- ----------------------------
DROP TABLE "TRADE_GNNT"."F_B_DICTIONARY";
CREATE TABLE "TRADE_GNNT"."F_B_DICTIONARY" (
"ID" NUMBER(5) NOT NULL ,
"TYPE" NUMBER(5) NOT NULL ,
"BANKID" VARCHAR2(32 BYTE) NULL ,
"NAME" VARCHAR2(128 BYTE) NOT NULL ,
"VALUE" VARCHAR2(128 BYTE) NULL ,
"NOTE" VARCHAR2(256 BYTE) NOT NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON TABLE "TRADE_GNNT"."F_B_DICTIONARY" IS '字典表';
COMMENT ON COLUMN "TRADE_GNNT"."F_B_DICTIONARY"."ID" IS '字典ID';
COMMENT ON COLUMN "TRADE_GNNT"."F_B_DICTIONARY"."TYPE" IS '类型';
COMMENT ON COLUMN "TRADE_GNNT"."F_B_DICTIONARY"."BANKID" IS '银行编号';
COMMENT ON COLUMN "TRADE_GNNT"."F_B_DICTIONARY"."NAME" IS '字典名';
COMMENT ON COLUMN "TRADE_GNNT"."F_B_DICTIONARY"."VALUE" IS '字典值';
COMMENT ON COLUMN "TRADE_GNNT"."F_B_DICTIONARY"."NOTE" IS '备注';

-- ----------------------------
-- Records of F_B_DICTIONARY
-- ----------------------------
INSERT INTO "TRADE_GNNT"."F_B_DICTIONARY" VALUES ('1', '0', null, 'insummary', '11003', '入金摘要');
INSERT INTO "TRADE_GNNT"."F_B_DICTIONARY" VALUES ('2', '0', null, 'outsummary', '11004', '出金摘要');
INSERT INTO "TRADE_GNNT"."F_B_DICTIONARY" VALUES ('3', '0', null, 'feesummary', '11005', '手续费摘要');
INSERT INTO "TRADE_GNNT"."F_B_DICTIONARY" VALUES ('4', '3', null, 'inRateFee', '007', '交易商入金手续费');
INSERT INTO "TRADE_GNNT"."F_B_DICTIONARY" VALUES ('5', '3', null, 'outRateFee', '008', '交易商出金手续费');

-- ----------------------------
-- Indexes structure for table F_B_DICTIONARY
-- ----------------------------

-- ----------------------------
-- Checks structure for table F_B_DICTIONARY
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."F_B_DICTIONARY" ADD CHECK ("ID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."F_B_DICTIONARY" ADD CHECK ("TYPE" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."F_B_DICTIONARY" ADD CHECK ("NAME" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."F_B_DICTIONARY" ADD CHECK ("NOTE" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table F_B_DICTIONARY
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."F_B_DICTIONARY" ADD PRIMARY KEY ("ID");
