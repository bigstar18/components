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

Date: 2015-11-13 21:17:38
*/


-- ----------------------------
-- Table structure for W_LOGCATALOG
-- ----------------------------
DROP TABLE "TRADE_GNNT"."W_LOGCATALOG";
CREATE TABLE "TRADE_GNNT"."W_LOGCATALOG" (
"CATALOGID" NUMBER(4) NOT NULL ,
"MODULEID" NUMBER(2) NOT NULL ,
"CATALOGNAME" VARCHAR2(32 BYTE) NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON TABLE "TRADE_GNNT"."W_LOGCATALOG" IS '日志分类，4位数字的编码，以日志模块ID开头。';
COMMENT ON COLUMN "TRADE_GNNT"."W_LOGCATALOG"."CATALOGID" IS '日志分类ID：4位数字的编码，详见备注Notes。';
COMMENT ON COLUMN "TRADE_GNNT"."W_LOGCATALOG"."CATALOGNAME" IS '日志分类名';

-- ----------------------------
-- Records of W_LOGCATALOG
-- ----------------------------
INSERT INTO "TRADE_GNNT"."W_LOGCATALOG" VALUES ('9901', '99', '个人维护');
INSERT INTO "TRADE_GNNT"."W_LOGCATALOG" VALUES ('3203', '32', '登录退出');
INSERT INTO "TRADE_GNNT"."W_LOGCATALOG" VALUES ('3204', '32', '修改密码');
INSERT INTO "TRADE_GNNT"."W_LOGCATALOG" VALUES ('1201', '12', '角色管理');
INSERT INTO "TRADE_GNNT"."W_LOGCATALOG" VALUES ('1202', '12', '管理员管理');
INSERT INTO "TRADE_GNNT"."W_LOGCATALOG" VALUES ('1211', '12', '仓单录入');
INSERT INTO "TRADE_GNNT"."W_LOGCATALOG" VALUES ('1212', '12', '拆仓单管理');
INSERT INTO "TRADE_GNNT"."W_LOGCATALOG" VALUES ('1213', '12', '仓单出库');

-- ----------------------------
-- Indexes structure for table W_LOGCATALOG
-- ----------------------------

-- ----------------------------
-- Checks structure for table W_LOGCATALOG
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."W_LOGCATALOG" ADD CHECK ("CATALOGID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."W_LOGCATALOG" ADD CHECK ("MODULEID" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table W_LOGCATALOG
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."W_LOGCATALOG" ADD PRIMARY KEY ("CATALOGID");
