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

Date: 2015-11-11 22:52:34
*/


-- ----------------------------
-- Table structure for F_B_TRANSMONEYOBJ
-- ----------------------------
DROP TABLE "TRADE_GNNT"."F_B_TRANSMONEYOBJ";
CREATE TABLE "TRADE_GNNT"."F_B_TRANSMONEYOBJ" (
"ID" NUMBER(5) NOT NULL ,
"CLASSNAME" VARCHAR2(32 BYTE) NOT NULL ,
"NOTE" VARCHAR2(256 BYTE) NOT NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON TABLE "TRADE_GNNT"."F_B_TRANSMONEYOBJ" IS '资金划转对象表';
COMMENT ON COLUMN "TRADE_GNNT"."F_B_TRANSMONEYOBJ"."ID" IS '序号';
COMMENT ON COLUMN "TRADE_GNNT"."F_B_TRANSMONEYOBJ"."CLASSNAME" IS '业务实现类';
COMMENT ON COLUMN "TRADE_GNNT"."F_B_TRANSMONEYOBJ"."NOTE" IS '备注';

-- ----------------------------
-- Records of F_B_TRANSMONEYOBJ
-- ----------------------------
INSERT INTO "TRADE_GNNT"."F_B_TRANSMONEYOBJ" VALUES ('0', 'TransMoneyTradeRate', '划转交易手续费');

-- ----------------------------
-- Checks structure for table F_B_TRANSMONEYOBJ
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."F_B_TRANSMONEYOBJ" ADD CHECK ("ID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."F_B_TRANSMONEYOBJ" ADD CHECK ("CLASSNAME" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."F_B_TRANSMONEYOBJ" ADD CHECK ("NOTE" IS NOT NULL);
