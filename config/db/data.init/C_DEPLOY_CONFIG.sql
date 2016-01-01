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

Date: 2015-11-11 22:50:00
*/


-- ----------------------------
-- Table structure for C_DEPLOY_CONFIG
-- ----------------------------
DROP TABLE "TRADE_GNNT"."C_DEPLOY_CONFIG";
CREATE TABLE "TRADE_GNNT"."C_DEPLOY_CONFIG" (
"MODULEID" NUMBER(2) NOT NULL ,
"CONTEXTNAME" VARCHAR2(64 BYTE) NOT NULL ,
"SERVERPIC" VARCHAR2(64 BYTE) NOT NULL ,
"SERVERPATH" VARCHAR2(128 BYTE) NULL ,
"RELATIVEPATH" VARCHAR2(128 BYTE) NOT NULL ,
"HOMEPAGEACTION" VARCHAR2(128 BYTE) NULL ,
"WELCOMEPAGE" VARCHAR2(128 BYTE) NULL ,
"WELCOMEPIC" VARCHAR2(64 BYTE) NULL ,
"SYSTYPE" VARCHAR2(32 BYTE) NOT NULL ,
"SORTNO" NUMBER(2) DEFAULT 1  NOT NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON COLUMN "TRADE_GNNT"."C_DEPLOY_CONFIG"."MODULEID" IS '角色Id';
COMMENT ON COLUMN "TRADE_GNNT"."C_DEPLOY_CONFIG"."CONTEXTNAME" IS '系统名称';
COMMENT ON COLUMN "TRADE_GNNT"."C_DEPLOY_CONFIG"."SERVERPIC" IS '首页点击进入各个系统管理平台的点击图片';
COMMENT ON COLUMN "TRADE_GNNT"."C_DEPLOY_CONFIG"."SERVERPATH" IS '服务地址：eg  http://127.0.0.1:8080';
COMMENT ON COLUMN "TRADE_GNNT"."C_DEPLOY_CONFIG"."RELATIVEPATH" IS '公用系统点击进入各个系统管理平台的地相对址';
COMMENT ON COLUMN "TRADE_GNNT"."C_DEPLOY_CONFIG"."HOMEPAGEACTION" IS '各个系统平台主页的Action';
COMMENT ON COLUMN "TRADE_GNNT"."C_DEPLOY_CONFIG"."WELCOMEPAGE" IS '跳转到各个系统首页的相对地址(只有前台才有主页)';
COMMENT ON COLUMN "TRADE_GNNT"."C_DEPLOY_CONFIG"."WELCOMEPIC" IS '公用系统头部点击进入各个系统首页的图标展示(只有前台才有首页图标)';
COMMENT ON COLUMN "TRADE_GNNT"."C_DEPLOY_CONFIG"."SYSTYPE" IS '系统类型，mgr：后台  front：前台';

-- ----------------------------
-- Records of C_DEPLOY_CONFIG
-- ----------------------------
INSERT INTO "TRADE_GNNT"."C_DEPLOY_CONFIG" VALUES ('40', 'ipo_mgr', 'ipo_mgr.png', null, '/mgr/frame/mainframe_nohead.jsp', null, null, null, 'mgr', '40');
INSERT INTO "TRADE_GNNT"."C_DEPLOY_CONFIG" VALUES ('10', 'integrated_front', 'ico_syn.png', null, '/front/frame/mainframe.jsp', null, null, null, 'front', '10');
INSERT INTO "TRADE_GNNT"."C_DEPLOY_CONFIG" VALUES ('10', 'integrated_mgr', 'integrated_mgr.png', null, '/mgr/frame/mainframe_nohead.jsp', null, null, null, 'mgr', '10');
INSERT INTO "TRADE_GNNT"."C_DEPLOY_CONFIG" VALUES ('11', 'finance_front', 'ico_finance.png', null, '/front/frame/mainframe.jsp', null, null, null, 'front', '11');
INSERT INTO "TRADE_GNNT"."C_DEPLOY_CONFIG" VALUES ('11', 'finance_mgr', 'finance_mgr.png', null, '/mgr/frame/mainframe_nohead.jsp', null, null, null, 'mgr', '11');
INSERT INTO "TRADE_GNNT"."C_DEPLOY_CONFIG" VALUES ('13', 'bill_front', 'ico_cdsys.png', null, '/front/frame/mainframe.jsp', null, null, null, 'front', '13');
INSERT INTO "TRADE_GNNT"."C_DEPLOY_CONFIG" VALUES ('13', 'bill_mgr', 'bill_mgr.png', null, '/mgr/frame/mainframe_nohead.jsp', null, null, null, 'mgr', '13');
INSERT INTO "TRADE_GNNT"."C_DEPLOY_CONFIG" VALUES ('28', 'bank_mgr', 'bank_mgr.png', null, '/mgr/frame/mainframe_nohead.jsp', null, null, null, 'mgr', '28');
INSERT INTO "TRADE_GNNT"."C_DEPLOY_CONFIG" VALUES ('28', 'bank_front', 'ico_bank.png', null, '/front/frame/mainframe.jsp', null, null, null, 'front', '28');
INSERT INTO "TRADE_GNNT"."C_DEPLOY_CONFIG" VALUES ('29', 'tradeMonitor', 'monitor.gif', null, '/mgr/frame/mainframe_nohead.jsp', null, null, null, 'mgr', '29');
INSERT INTO "TRADE_GNNT"."C_DEPLOY_CONFIG" VALUES ('99', 'common_warehouse', 'common_mgr.gif', null, '/mgr/frame/mainframe_nohead.jsp', null, null, null, 'warehouse', '99');
INSERT INTO "TRADE_GNNT"."C_DEPLOY_CONFIG" VALUES ('12', 'integrated_warehouse', 'integrated_mgr.png', null, '/mgr/frame/mainframe_nohead.jsp', null, null, null, 'warehouse', '12');
INSERT INTO "TRADE_GNNT"."C_DEPLOY_CONFIG" VALUES ('19', 'broker_mgr', 'broker_mgr.png', null, '/mgr/frame/mainframe_nohead.jsp', null, null, null, 'mgr', '19');
INSERT INTO "TRADE_GNNT"."C_DEPLOY_CONFIG" VALUES ('10', 'integrated_broker', 'integrated_broker.png', null, '/broker/frame/mainframe_nohead.jsp', null, null, null, 'broker', '10');
INSERT INTO "TRADE_GNNT"."C_DEPLOY_CONFIG" VALUES ('15', 'timebargain_broker', 'timebargain_broker.png', null, '/broker/frame/mainframe_nohead.jsp', null, null, null, 'broker', '15');
INSERT INTO "TRADE_GNNT"."C_DEPLOY_CONFIG" VALUES ('99', 'common_broker', 'common_broker.png', null, '/broker/frame/mainframe_nohead.jsp', null, null, null, 'broker', '99');
INSERT INTO "TRADE_GNNT"."C_DEPLOY_CONFIG" VALUES ('15', 'timebargain_front', 'ico_timebargain.png', null, '/front/frame/mainframe.jsp', null, null, null, 'front', '15');
INSERT INTO "TRADE_GNNT"."C_DEPLOY_CONFIG" VALUES ('15', 'timebargain_mgr', 'timebargain_mgr.png', null, '/mgr/frame/mainframe_nohead.jsp', null, null, null, 'mgr', '15');
INSERT INTO "TRADE_GNNT"."C_DEPLOY_CONFIG" VALUES ('99', 'common_mgr', 'common_mgr.gif', null, '/mgr/frame/mainframe_nohead.jsp', null, null, null, 'mgr', '99');
INSERT INTO "TRADE_GNNT"."C_DEPLOY_CONFIG" VALUES ('99', 'common_front', 'common.gif', null, '/front/frame/mainframe.jsp', null, null, null, 'front', '99');
INSERT INTO "TRADE_GNNT"."C_DEPLOY_CONFIG" VALUES ('21', 'vendue_mgr', 'vendue_mgr.png', null, '/mgr/frame/mainframe_nohead.jsp', null, null, null, 'mgr', '21');
INSERT INTO "TRADE_GNNT"."C_DEPLOY_CONFIG" VALUES ('21', 'vendue_front', 'vendue_front.png', null, '/front/app/vendue/vendue1_nkst/submit/main.jsp', null, null, null, 'front', '21');
INSERT INTO "TRADE_GNNT"."C_DEPLOY_CONFIG" VALUES ('40', 'ipo_front', 'ico_ipo.png', null, '/front/frame/mainframe.jsp', null, null, null, 'front', '40');

-- ----------------------------
-- Indexes structure for table C_DEPLOY_CONFIG
-- ----------------------------

-- ----------------------------
-- Checks structure for table C_DEPLOY_CONFIG
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."C_DEPLOY_CONFIG" ADD CHECK ("MODULEID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."C_DEPLOY_CONFIG" ADD CHECK ("CONTEXTNAME" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."C_DEPLOY_CONFIG" ADD CHECK ("SERVERPIC" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."C_DEPLOY_CONFIG" ADD CHECK ("RELATIVEPATH" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."C_DEPLOY_CONFIG" ADD CHECK ("SYSTYPE" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."C_DEPLOY_CONFIG" ADD CHECK ("SORTNO" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table C_DEPLOY_CONFIG
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."C_DEPLOY_CONFIG" ADD PRIMARY KEY ("MODULEID", "CONTEXTNAME");
