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

Date: 2015-11-11 22:53:45
*/


-- ----------------------------
-- Table structure for L_AUCONFIG
-- ----------------------------
DROP TABLE "TRADE_GNNT"."L_AUCONFIG";
CREATE TABLE "TRADE_GNNT"."L_AUCONFIG" (
"CONFIGID" NUMBER(6) NOT NULL ,
"HOSTIP" VARCHAR2(20 BYTE) NULL ,
"PORT" NUMBER(6) NOT NULL ,
"DATAPORT" NUMBER(6) NULL ,
"SERVICENAME" VARCHAR2(32 BYTE) NOT NULL ,
"LOGONMODE" NUMBER(2) DEFAULT 1  NOT NULL ,
"SYSNAME" VARCHAR2(32 BYTE) NOT NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON COLUMN "TRADE_GNNT"."L_AUCONFIG"."LOGONMODE" IS '1 互踢;2 不互踢';
COMMENT ON COLUMN "TRADE_GNNT"."L_AUCONFIG"."SYSNAME" IS '前台：front
后台：mgr
仓库端：warehouse
会员端：broker';

-- ----------------------------
-- Records of L_AUCONFIG
-- ----------------------------
INSERT INTO "TRADE_GNNT"."L_AUCONFIG" VALUES ('199001', '10.0.100.181', '30171', '30172', 'CommonMgr', '1', 'mgr');
INSERT INTO "TRADE_GNNT"."L_AUCONFIG" VALUES ('399001', '10.0.100.181', '30371', '30372', 'Broker', '1', 'broker');
INSERT INTO "TRADE_GNNT"."L_AUCONFIG" VALUES ('499001', '10.0.100.181', '30271', '30272', 'Warehouse', '1', 'warehouse');
INSERT INTO "TRADE_GNNT"."L_AUCONFIG" VALUES ('210001', '10.0.100.181', '30771', '30772', 'IntegratedFront', '1', 'front');
INSERT INTO "TRADE_GNNT"."L_AUCONFIG" VALUES ('211001', '10.0.100.181', '30871', '30872', 'FinanceFront', '1', 'front');
INSERT INTO "TRADE_GNNT"."L_AUCONFIG" VALUES ('213001', '10.0.100.181', '30971', '30972', 'BillFront', '1', 'front');
INSERT INTO "TRADE_GNNT"."L_AUCONFIG" VALUES ('214001', null, '31071', '31072', 'FinancingFront', '1', 'front');
INSERT INTO "TRADE_GNNT"."L_AUCONFIG" VALUES ('215001', '10.0.100.181', '30471', '30412', 'TimebargainFront', '1', 'front');
INSERT INTO "TRADE_GNNT"."L_AUCONFIG" VALUES ('218001', null, '30571', '30572', 'IssueFront', '1', 'front');
INSERT INTO "TRADE_GNNT"."L_AUCONFIG" VALUES ('221001', '10.0.100.181', '30671', '30672', 'VendueFront', '1', 'front');
INSERT INTO "TRADE_GNNT"."L_AUCONFIG" VALUES ('223001', '10.0.100.181', '31171', '31172', 'EspotFront', '1', 'front');
INSERT INTO "TRADE_GNNT"."L_AUCONFIG" VALUES ('228001', '10.0.100.181', '31271', '31272', 'BankFront', '1', 'front');
INSERT INTO "TRADE_GNNT"."L_AUCONFIG" VALUES ('230001', null, '31411', '31412', 'LoanFront', '1', 'front');
INSERT INTO "TRADE_GNNT"."L_AUCONFIG" VALUES ('298001', null, '12981', '12982', 'DemoFront', '1', 'front');
INSERT INTO "TRADE_GNNT"."L_AUCONFIG" VALUES ('299001', '10.0.100.181', '31371', '31372', 'CommonFront', '1', 'front');

-- ----------------------------
-- Indexes structure for table L_AUCONFIG
-- ----------------------------

-- ----------------------------
-- Checks structure for table L_AUCONFIG
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."L_AUCONFIG" ADD CHECK ("CONFIGID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."L_AUCONFIG" ADD CHECK ("PORT" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."L_AUCONFIG" ADD CHECK ("SERVICENAME" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."L_AUCONFIG" ADD CHECK ("LOGONMODE" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."L_AUCONFIG" ADD CHECK ("SYSNAME" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table L_AUCONFIG
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."L_AUCONFIG" ADD PRIMARY KEY ("CONFIGID");
