/*
Navicat Oracle Data Transfer
Oracle Client Version : 12.1.0.2.0

Source Server         : 172.17.14.12.tianji
Source Server Version : 110200
Source Host           : 172.17.14.12:1521
Source Schema         : TRADE_GNNT

Target Server Type    : ORACLE
Target Server Version : 110200
File Encoding         : 65001

Date: 2015-11-09 01:09:43
*/


-- ----------------------------
-- Table structure for L_DICTIONARY
-- ----------------------------
DROP TABLE "TRADE_GNNT"."L_DICTIONARY";
CREATE TABLE "TRADE_GNNT"."L_DICTIONARY" (
"KEY" VARCHAR2(32 BYTE) NOT NULL ,
"NAME" VARCHAR2(128 BYTE) NULL ,
"VALUE" VARCHAR2(64 BYTE) NOT NULL ,
"NOTE" VARCHAR2(1924 BYTE) NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;

-- ----------------------------
-- Records of L_DICTIONARY
-- ----------------------------
INSERT INTO "TRADE_GNNT"."L_DICTIONARY" VALUES ('FrontMaxErrorLogonTimes', '前台登录最大错误次数', '3', '超过本设置的次数后，前台锁定用户');
INSERT INTO "TRADE_GNNT"."L_DICTIONARY" VALUES ('WarehouseMaxErrorLogonTimes', '仓库端登录最大错误次数', '3', '超过本设置的次数后，仓库端锁定用户');
INSERT INTO "TRADE_GNNT"."L_DICTIONARY" VALUES ('getLogonUser_ip', '获取在线用户RMI的ip', '172.17.12.22', '访问在线用户rmi的ip信息');
INSERT INTO "TRADE_GNNT"."L_DICTIONARY" VALUES ('getLogonUser_port', '获取在线用户RMI的port', '21811', '访问在线用户rmi的port信息');
INSERT INTO "TRADE_GNNT"."L_DICTIONARY" VALUES ('getLogonUser_dataPort', '获取在线用户RMI的dataPort', '21812', '访问在线用户rmi的dataPort信息');

-- ----------------------------
-- Indexes structure for table L_DICTIONARY
-- ----------------------------

-- ----------------------------
-- Checks structure for table L_DICTIONARY
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."L_DICTIONARY" ADD CHECK ("KEY" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."L_DICTIONARY" ADD CHECK ("VALUE" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table L_DICTIONARY
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."L_DICTIONARY" ADD PRIMARY KEY ("KEY");
