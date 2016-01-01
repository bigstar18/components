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

Date: 2015-11-16 19:01:43
*/


-- ----------------------------
-- Table structure for BI_OUTSTOCK
-- ----------------------------
DROP TABLE "TRADE_GNNT"."BI_OUTSTOCK";
CREATE TABLE "TRADE_GNNT"."BI_OUTSTOCK" (
"OUTSTOCKID" NUMBER(15) NOT NULL ,
"STOCKID" VARCHAR2(16 BYTE) NOT NULL ,
"KEY" VARCHAR2(32 BYTE) NOT NULL ,
"DELIVERYPERSON" VARCHAR2(64 BYTE) NULL ,
"IDNUMBER" VARCHAR2(36 BYTE) NULL ,
"STATUS" NUMBER(2) DEFAULT 0  NOT NULL ,
"CREATETIME" DATE NOT NULL ,
"PROCESSTIME" DATE NULL ,
"ADDRESS" VARCHAR2(32 BYTE) NULL ,
"PHONE" VARCHAR2(36 BYTE) NULL ,
"DELIVERYSTATUS" NUMBER(2) NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON COLUMN "TRADE_GNNT"."BI_OUTSTOCK"."STATUS" IS '0 出库申请 1 撤销出库申请 2 出库完成';

-- ----------------------------
-- Indexes structure for table BI_OUTSTOCK
-- ----------------------------

-- ----------------------------
-- Checks structure for table BI_OUTSTOCK
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."BI_OUTSTOCK" ADD CHECK ("OUTSTOCKID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."BI_OUTSTOCK" ADD CHECK ("STOCKID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."BI_OUTSTOCK" ADD CHECK ("KEY" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."BI_OUTSTOCK" ADD CHECK ("STATUS" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."BI_OUTSTOCK" ADD CHECK ("CREATETIME" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."BI_OUTSTOCK" ADD CHECK ("DELIVERYSTATUS" IS NOT NULL) ENABLE NOVALIDATE;

-- ----------------------------
-- Primary Key structure for table BI_OUTSTOCK
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."BI_OUTSTOCK" ADD PRIMARY KEY ("OUTSTOCKID");

-- ----------------------------
-- Foreign Key structure for table "TRADE_GNNT"."BI_OUTSTOCK"
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."BI_OUTSTOCK" ADD FOREIGN KEY ("STOCKID") REFERENCES "TRADE_GNNT"."BI_STOCK" ("STOCKID") DISABLE;
