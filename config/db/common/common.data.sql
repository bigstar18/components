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

Date: 2015-11-11 19:52:19
*/


-- ----------------------------
-- Table structure for C_APPLY
-- ----------------------------
DROP TABLE "TRADE_GNNT"."C_APPLY";
CREATE TABLE "TRADE_GNNT"."C_APPLY" (
"ID" NUMBER(10) NOT NULL ,
"APPLYTYPE" VARCHAR2(32 BYTE) NOT NULL ,
"STATUS" NUMBER(3) NOT NULL ,
"CONTENT" VARCHAR2(2000 BYTE) NOT NULL ,
"NOTE" VARCHAR2(1024 BYTE) NULL ,
"DISCRIBE" VARCHAR2(512 BYTE) NULL ,
"MODTIME" DATE NULL ,
"CREATETIME" DATE NOT NULL ,
"APPLYUSER" VARCHAR2(32 BYTE) NOT NULL ,
"OPERATETYPE" VARCHAR2(50 BYTE) NOT NULL ,
"ENTITYCLASS" VARCHAR2(1024 BYTE) NOT NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON COLUMN "TRADE_GNNT"."C_APPLY"."ID" IS 'ID';
COMMENT ON COLUMN "TRADE_GNNT"."C_APPLY"."APPLYTYPE" IS '申请类型';
COMMENT ON COLUMN "TRADE_GNNT"."C_APPLY"."STATUS" IS '当前状态 0：待审核 1：审核通过 2：审核驳回 3：撤销申请';
COMMENT ON COLUMN "TRADE_GNNT"."C_APPLY"."CONTENT" IS '内容';
COMMENT ON COLUMN "TRADE_GNNT"."C_APPLY"."NOTE" IS '备注';
COMMENT ON COLUMN "TRADE_GNNT"."C_APPLY"."DISCRIBE" IS '描述';
COMMENT ON COLUMN "TRADE_GNNT"."C_APPLY"."MODTIME" IS '修改时间';
COMMENT ON COLUMN "TRADE_GNNT"."C_APPLY"."CREATETIME" IS '创建时间';
COMMENT ON COLUMN "TRADE_GNNT"."C_APPLY"."APPLYUSER" IS '申请人';
COMMENT ON COLUMN "TRADE_GNNT"."C_APPLY"."OPERATETYPE" IS '操作类型 update;add;delete;deleteCollection';
COMMENT ON COLUMN "TRADE_GNNT"."C_APPLY"."ENTITYCLASS" IS '业务对象类';

-- ----------------------------
-- Records of C_APPLY
-- ----------------------------

-- ----------------------------
-- Table structure for C_AUDIT
-- ----------------------------
DROP TABLE "TRADE_GNNT"."C_AUDIT";
CREATE TABLE "TRADE_GNNT"."C_AUDIT" (
"ID" NUMBER(10) NOT NULL ,
"APPLYID" NUMBER(10) NOT NULL ,
"STATUS" NUMBER(3) NOT NULL ,
"AUDITUSER" VARCHAR2(32 BYTE) NOT NULL ,
"MODTIME" DATE DEFAULT sysdate  NOT NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON COLUMN "TRADE_GNNT"."C_AUDIT"."ID" IS 'ID';
COMMENT ON COLUMN "TRADE_GNNT"."C_AUDIT"."APPLYID" IS '申请单ID';
COMMENT ON COLUMN "TRADE_GNNT"."C_AUDIT"."STATUS" IS '状态 1：审核通过 2：驳回申请';
COMMENT ON COLUMN "TRADE_GNNT"."C_AUDIT"."AUDITUSER" IS '审核人';
COMMENT ON COLUMN "TRADE_GNNT"."C_AUDIT"."MODTIME" IS '修改时间';

-- ----------------------------
-- Records of C_AUDIT
-- ----------------------------

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
-- Table structure for C_FRONT_MYMENU
-- ----------------------------
DROP TABLE "TRADE_GNNT"."C_FRONT_MYMENU";
CREATE TABLE "TRADE_GNNT"."C_FRONT_MYMENU" (
"USERID" VARCHAR2(12 BYTE) NOT NULL ,
"RIGHTID" NUMBER(10) NOT NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON COLUMN "TRADE_GNNT"."C_FRONT_MYMENU"."USERID" IS '管理员Id';

-- ----------------------------
-- Records of C_FRONT_MYMENU
-- ----------------------------

-- ----------------------------
-- Table structure for C_FRONT_RIGHT
-- ----------------------------
DROP TABLE "TRADE_GNNT"."C_FRONT_RIGHT";
CREATE TABLE "TRADE_GNNT"."C_FRONT_RIGHT" (
"ID" NUMBER(10) NOT NULL ,
"PARENTID" NUMBER(10) NULL ,
"NAME" VARCHAR2(128 BYTE) NULL ,
"ICON" VARCHAR2(128 BYTE) NULL ,
"AUTHORITYURL" VARCHAR2(512 BYTE) NULL ,
"VISITURL" VARCHAR2(512 BYTE) NULL ,
"MODULEID" NUMBER(3) NULL ,
"SEQ" NUMBER(3) NULL ,
"VISIBLE" NUMBER(1) NULL ,
"TYPE" NUMBER(1) NOT NULL ,
"CATALOGID" NUMBER(10) NULL ,
"ISWRITELOG" VARCHAR2(1 BYTE) DEFAULT 'N'  NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON COLUMN "TRADE_GNNT"."C_FRONT_RIGHT"."ID" IS ' 规范：
1：开头两位为系统模块号
2: 第三四位为一级菜单
3：第五六位为二级菜单
4：第七八位为三级菜单
5：第九十位为页面中的增删改查
';
COMMENT ON COLUMN "TRADE_GNNT"."C_FRONT_RIGHT"."PARENTID" IS '父关联';
COMMENT ON COLUMN "TRADE_GNNT"."C_FRONT_RIGHT"."NAME" IS '权限名称';
COMMENT ON COLUMN "TRADE_GNNT"."C_FRONT_RIGHT"."ICON" IS '图标';
COMMENT ON COLUMN "TRADE_GNNT"."C_FRONT_RIGHT"."AUTHORITYURL" IS '权限路径';
COMMENT ON COLUMN "TRADE_GNNT"."C_FRONT_RIGHT"."VISITURL" IS '真实路径';
COMMENT ON COLUMN "TRADE_GNNT"."C_FRONT_RIGHT"."MODULEID" IS '模块Id';
COMMENT ON COLUMN "TRADE_GNNT"."C_FRONT_RIGHT"."SEQ" IS '序号';
COMMENT ON COLUMN "TRADE_GNNT"."C_FRONT_RIGHT"."VISIBLE" IS '是否可见-1 不可见0 可见';
COMMENT ON COLUMN "TRADE_GNNT"."C_FRONT_RIGHT"."TYPE" IS '类型-3:只检查session不检查权限的url -2：无需判断权限的URL -1： 父菜单类型 0：子菜单类型 1：页面内增删改查权限';
COMMENT ON COLUMN "TRADE_GNNT"."C_FRONT_RIGHT"."CATALOGID" IS '日志类型 0不写日志 其它对应表c_logcatalog 的CATALOGID字段';
COMMENT ON COLUMN "TRADE_GNNT"."C_FRONT_RIGHT"."ISWRITELOG" IS '''Y''：写日志、''N''：不写日志';

-- ----------------------------
-- Records of C_FRONT_RIGHT
-- ----------------------------
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('9900000002', '-1', '登陆', null, '/front/app/mgr/user/logon.action', '/front/app/mgr/user/logon.action', '99', '2', '0', '-2', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('9900000003', '-1', '登录页面', null, '/front/logon/logon.jsp', '/front/logon/logon.jsp', '99', '3', '0', '-2', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('9900000004', '-1', '登录跳转页面', null, '/front/logon/logonsuccess.jsp', '/front/logon/logonsuccess.jsp', '99', '4', '0', '-2', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('9900000005', '-1', '退出', null, '/front/app/mgr/user/logout.action', '/front/app/mgr/user/logout.action', '99', '5', '0', '-2', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('9900000006', '-1', '注册', null, '/front/app/mgr/user/register.action', '/front/app/mgr/user/register.action', '99', '6', '0', '-2', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('9900000007', '-1', '注册页面', null, '/front/logon/register.jsp', '/front/logon/register.jsp', '99', '7', '0', '-2', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('9900000008', '-1', '注册申请成功', null, '/front/logon/registesuccess.jsp', '/front/logon/registesuccess.jsp', '99', '8', '0', '-2', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('9900000010', '-1', '无模块权限页面', null, '/front/public/jsp/nomoduleright.jsp', '/front/public/jsp/nomoduleright.jsp', '99', '10', '0', '-2', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('9900000011', '-1', '无权限页面', null, '/front/public/jsp/noright.jsp', '/front/public/jsp/noright.jsp', '99', '11', '0', '-2', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('9900000012', '-1', 'session失效', null, '/front/public/jsp/nosession.jsp', '/front/public/jsp/nosession.jsp', '99', '12', '0', '-2', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('9900000013', '-1', '错误页面', null, '/front/public/jsp/error.jsp', '/front/public/jsp/error.jsp', '99', '13', '0', '-2', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('9900000014', '-1', 'au页面', null, '/front/public/jsp/session.jsp', '/front/public/jsp/session.jsp', '99', '14', '0', '-2', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('9900000015', '-1', 'jms访问路径', null, '/amq', '/amq', '99', '15', '0', '-3', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('9900000031', '-1', '我的平台', null, '/front/frame/index.jsp', '/front/frame/index.jsp', '99', '31', '0', '-3', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('9900000032', '-1', '主框架', null, '/front/frame/mainframe.jsp', '/front/frame/mainframe.jsp', '99', '32', '0', '-3', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('9900000033', '-1', '我的平台主页', null, '/menu/homepage.action', '/menu/homepage.action', '99', '33', '0', '-3', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('9900000034', '-1', '快捷菜单修改', null, '/menu/changemymenu.action', '/menu/changemymenu.action', '99', '34', '0', '-3', '9901', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('9900000035', '-1', '密码修改', null, '/front/app/mgr/self/passwordSelf*', '/front/app/mgr/self/passwordSelf*', '99', '35', '0', '-3', '9901', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('9900000036', '-1', '跳转弹出框页面', null, '/front/public/jsp/dialogmessage.jsp', '/front/public/jsp/dialogmessage.jsp', '99', '36', '0', '-2', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('9900000037', '-1', '弹出框关闭引用页面', null, '/front/public/jsp/footinc.jsp', '/front/public/jsp/footinc.jsp', '99', '37', '0', '-2', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('9900000038', '-1', '等待加载页面', null, '/front/frame/loading.jsp', '/front/frame/loading.jsp', '99', '38', '0', '-3', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('9900000042', '-1', '登录跳转页面', null, '/front/app/mgr/logon/logonsuccess.jsp', '/front/app/mgr/logon/logonsuccess.jsp', '99', '42', '0', '-2', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('9900000043', '-1', '注册成功页面', null, '/front/public/jsp/registesuccess.jsp', '/front/public/jsp/registesuccess.jsp', '99', '43', '0', '-2', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('9900000044', '-1', '所有系统退出页面', null, '/front/public/jsp/logoutall.jsp', '/front/public/jsp/logoutall.jsp', '99', '44', '0', '-2', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301007003', '2301007000', '转入保证金操作', null, '/front/app/mgr/trade/tradeAutonomy/paymentReserve.action', '/front/app/mgr/trade/tradeAutonomy/paymentReserve.action', '23', '3', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301007004', '2301007000', '转入仓单跳转', null, '/front/app/mgr/trade/tradeAutonomy/forwardTransferGoods.action', '/front/app/mgr/trade/tradeAutonomy/forwardTransferGoods.action', '23', '4', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301007005', '2301007000', '转入仓单操作', null, '/front/app/mgr/trade/tradeAutonomy/transferGoods.action', '/front/app/mgr/trade/tradeAutonomy/transferGoods.action', '23', '5', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301007006', '2301007000', '关闭交易操作', null, '/front/app/mgr/trade/tradeAutonomy/withdrawTrade.action', '/front/app/mgr/trade/tradeAutonomy/withdrawTrade.action', '23', '6', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301007007', '2301007000', '转入货款跳转', null, '/front/app/mgr/trade/tradeAutonomy/forwardPaymentGoodsMoney.action', '/front/app/mgr/trade/tradeAutonomy/forwardPaymentGoodsMoney.action', '23', '7', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301007008', '2301007000', '转入货款操作', null, '/front/app/mgr/trade/tradeAutonomy/paymentGoodsMoney.action', '/front/app/mgr/trade/tradeAutonomy/paymentGoodsMoney.action', '23', '8', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301007010', '2301007000', '申请结束合同操作', null, '/front/app/mgr/trade/tradeAutonomy/performEndTradeApply.action', '/front/app/mgr/trade/tradeAutonomy/performEndTradeApply.action', '23', '10', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301007011', '2301007000', '撤销结束合同操作', null, '/front/app/mgr/trade/tradeAutonomy/performRevokeEndTradeApply.action', '/front/app/mgr/trade/tradeAutonomy/performRevokeEndTradeApply.action', '23', '11', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301007012', '2301007000', '处理结束合同跳转', null, '/front/app/mgr/trade/tradeAutonomy/forwardPerformEndTradeApply.action', '/front/app/mgr/trade/tradeAutonomy/forwardPerformEndTradeApply.action', '23', '12', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301007013', '2301007000', '处理结束合同操作', null, '/front/app/mgr/trade/tradeAutonomy/performDisposeEndTradeApply.action', '/front/app/mgr/trade/tradeAutonomy/performDisposeEndTradeApply.action', '23', '13', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301007014', '2301007000', '支付货款操作', null, '/front/app/mgr/trade/tradeAutonomy/payGoods.action', '/front/app/mgr/trade/tradeAutonomy/payGoods.action', '23', '14', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301007015', '2301007000', '支付仓单操作', null, '/front/app/mgr/trade/tradeAutonomy/payWarehouse.action', '/front/app/mgr/trade/tradeAutonomy/payWarehouse.action', '23', '15', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301007016', '2301007000', '违约申请操作', null, '/front/app/mgr/trade/tradeAutonomy/performBreachAsk.action', '/front/app/mgr/trade/tradeAutonomy/performBreachAsk.action', '23', '16', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301007017', '2301007000', '撤销违约操作', null, '/front/app/mgr/trade/tradeAutonomy/performWithdrawAsk.action', '/front/app/mgr/trade/tradeAutonomy/performWithdrawAsk.action', '23', '20', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301007018', '2301007000', '处理违约跳转', null, '/front/app/mgr/trade/tradeAutonomy/forwardPerformBreach.action', '/front/app/mgr/trade/tradeAutonomy/forwardPerformBreach.action', '23', '18', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301007019', '2301007000', '处理违约操作', null, '/front/app/mgr/trade/tradeAutonomy/performBreach.action', '/front/app/mgr/trade/tradeAutonomy/performBreach.action', '23', '19', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301007020', '2301007000', '支付货款跳转', null, '/front/app/mgr/trade/tradeAutonomy/forwardPayGoods.action', '/front/app/mgr/trade/tradeAutonomy/forwardPayGoods.action', '23', '20', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301007021', '2301007000', '支付仓单跳转', null, '/front/app/mgr/trade/tradeAutonomy/forwardPayWarehouse.action', '/front/app/mgr/trade/tradeAutonomy/forwardPayWarehouse.action', '23', '21', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301007022', '2301007000', '违约延迟跳转', null, '/front/app/mgr/trade/tradeAutonomy/toBreachDelay.action', '/front/app/mgr/trade/tradeAutonomy/toBreachDelay.action', '23', '22', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301007023', '2301007000', '违约延迟操作', null, '/front/app/mgr/trade/tradeAutonomy/doBreachDelay.action', '/front/app/mgr/trade/tradeAutonomy/doBreachDelay.action', '23', '23', '0', '0', '0', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301008000', '2301000000', '违约申请管理', null, '/front/app/mgr/trade/breachcontract/breachList.action', '/front/app/mgr/trade/breachcontract/breachList.action?sortColumns=order+by+applyTime+desc', '23', '8', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301008001', '2301008000', '撤销操作', null, '/front/app/mgr/trade/breachcontract/revocationBreach.action', '/front/app/mgr/trade/breachcontract/revocationBreach.action', '23', '1', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301008002', '2301008000', '处理操作', null, '/front/app/mgr/trade/breachcontract/agreeBreach.action', '/front/app/mgr/trade/breachcontract/agreeBreach.action', '23', '2', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301008003', '2301008000', '处理跳转操作', null, '/front/app/mgr/trade/breachcontract/forwardAgreeBreach.action', '/front/app/mgr/trade/breachcontract/forwardAgreeBreach.action', '23', '3', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301008004', '2301008000', '延期违约跳转操作', null, '/front/app/mgr/trade/breachcontract/toBreachDelay.action', '/front/app/mgr/trade/breachcontract/toBreachDelay.action', '23', '2', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301008005', '2301008000', '延期违约操作', null, '/front/app/mgr/trade/breachcontract/doBreachDelay.action', '/front/app/mgr/trade/breachcontract/doBreachDelay.action', '23', '3', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301009000', '2301000000', '溢短货款申请管理', null, '/front/app/mgr/trade/offSetcontract/offSetList.action', '/front/app/mgr/trade/offSetcontract/offSetList.action?sortColumns=order+by+applyTime+desc', '23', '9', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2300000001', '-1', '首页列表中摘牌', null, '/front/app/mgr/display/performPickoffList.action', '/front/app/mgr/display/performPickoffList.action', '23', '1', '0', '-3', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2300000002', '-1', '首页委托详情中摘牌', null, '/front/app/mgr/display/performPickoffDetails.action', '/front/app/mgr/display/performPickoffDetails.action', '23', '2', '0', '-3', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2300000003', '-1', '首页议价中摘牌', null, '/front/app/mgr/display/performPickoffAtSubOrder.action', '/front/app/mgr/display/performPickoffAtSubOrder.action', '23', '3', '0', '-3', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2300000004', '-1', '首页执行议价', null, '/front/app/mgr/display/performPickoffSubOrder.action', '/front/app/mgr/display/performPickoffSubOrder.action', '23', '4', '0', '-3', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2300000005', '-1', '从议价申请页面撤销议价', null, '/front/app/mgr/display/revokeSubOrder.action', '/front/app/mgr/display/revokeSubOrder.action', '23', '5', '0', '-3', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2300000006', '-1', '跳转到摘牌页面', null, '/front/app/mgr/display/toPickoffPage.action', '/front/app/mgr/display/toPickoffPage.action', '23', '6', '0', '-3', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2300000007', '-1', '搜索', null, '/front/app/mgr/display/search.action', '/front/app/mgr/display/search.action', '23', '7', '0', '-2', '0', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2300000008', '-1', '商家详情', null, '/front/app/mgr/display/firmDetail.action', '/front/app/mgr/display/firmDetail.action', '23', '8', '0', '-2', '0', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2300000009', '-1', '商家图片', null, '/front/app/mgr/display/showImages.action', '/front/app/mgr/display/showImages.action', '23', '9', '0', '-2', '0', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2300000010', '-1', '商家委托', null, '/front/app/mgr/display/orders.action', '/front/app/mgr/display/orders.action', '23', '10', '0', '-2', '0', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2300000011', '-1', '获取市场状态', null, '/front/app/mgr/ajax/getStatus.action', '/front/app/mgr/ajax/getStatus.action', '23', '11', '0', '-2', '0', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2300000012', '-1', '委托商品图片', null, '/front/app/display/trade/showImage.action', '/front/app/display/trade/showImage.action', '23', '12', '0', '-2', '0', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2300000013', '-1', '现货平台主页', null, '/home/menu/homepage.action', '/home/menu/homepage.action', '23', '13', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301000000', '9900000000', '交易管理', null, null, null, '23', '1', '0', '-1', '0', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301001000', '2301000000', '发布委托', null, '/front/app/mgr/trade/order/getFirstCategory.action', '/front/app/mgr/trade/order/getFirstCategory.action', '23', '1', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301001001', '2301001000', '查询二级分类', null, '/front/app/mgr/trade/order/getChildCategory.action', '/front/app/mgr/trade/order/getChildCategory.action', '23', '1', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301001002', '2301001000', '通过分类信息查询品名', null, '/front/app/mgr/jsonfororder/getBreedByCategoryID.action', '/front/app/mgr/jsonfororder/getBreedByCategoryID.action', '23', '2', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301001003', '2301001000', '通过品名编号获取品名属性信息', null, '/front/app/mgr/jsonfororder/getPropertyValueByBreedID.action', '/front/app/mgr/jsonfororder/getPropertyValueByBreedID.action', '23', '3', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301001004', '2301001000', '发布委托信息', null, '/front/app/mgr/trade/order/performOrder.action', '/front/app/mgr/trade/order/performOrder.action', '23', '4', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301001005', '2301001000', '发布委托预览信息', null, '/front/app/mgr/trade/order/performorderpreview.action', '/front/app/mgr/trade/order/performorderpreview.action', '23', '5', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301001006', '2301001000', '查看未使用的仓单', null, '/front/app/mgr/trade/order/getNotUseStock.action', '/front/app/mgr/trade/order/getNotUseStock.action', '23', '6', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301001007', '2301001000', '通过仓单号查询仓单并封装json', null, '/front/app/mgr/jsonfororder/getStockJson.action', '/front/app/mgr/trade/jsonfororder/getStockJson.action', '23', '7', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301001008', '2301001000', '发布仓单委托信息', null, '/front/app/mgr/trade/order/performOrderStock.action', '/front/app/mgr/trade/order/performOrderStock.action', '23', '8', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301002000', '2301000000', '委托管理', null, '/front/app/mgr/trade/order/orderList.action', '/front/app/mgr/trade/order/orderList.action?sortColumns=order+by+orderID+desc', '23', '2', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301002001', '2301002000', '委托查看', null, '/front/app/mgr/trade/order/orderDetails.action', '/front/app/mgr/trade/order/orderDetails.action', '23', '2', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301002002', '2301002000', '撤委托', null, '/front/app/mgr/trade/order/withdrawOrder.action', '/front/app/mgr/trade/order/withdrawOrder.action', '23', '1', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301002003', '2301002000', '单个委托议价列表中摘牌', null, '/front/app/mgr/trade/order/performPickoffList.action', '/front/app/mgr/trade/order/performPickoffList.action', '23', '2', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301002004', '2301002000', '单个委托详情列表', null, '/front/app/mgr/trade/order/orderSubOrderList.action', '/front/app/mgr/trade/order/orderSubOrderList.action', '23', '3', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301002005', '2301002000', '委托的单个议价详情中摘牌', null, '/front/app/mgr/trade/order/performPickoffDetails.action', '/front/app/mgr/trade/order/performPickoffDetails.action', '23', '4', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301002006', '2301002000', '委托议价详情查看', null, '/front/app/mgr/trade/order/orderSubOrderDetails.action', '/front/app/mgr/trade/order/orderSubOrderDetails.action', '23', '5', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301002007', '2301002000', '委托的议价详情中拒绝议价', null, '/front/app/mgr/trade/order/refuseSubOrder.action', '/front/app/mgr/trade/order/refuseSubOrder.action', '23', '6', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301002008', '2301002000', '委托的议价列表中拒绝议价', null, '/front/app/mgr/trade/order/refuseSubOrderList.action', '/front/app/mgr/trade/order/refuseSubOrderList.action', '23', '7', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301003000', '2301000000', '议价管理', null, '/front/app/mgr/suborder/suborderList.action', '/front/app/mgr/suborder/suborderList.action?sortColumns=order+by+subOrderID+desc', '23', '3', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301003001', '2301003000', '议价查看', null, '/front/app/mgr/suborder/suborderDetails.action', '/front/app/mgr/suborder/suborderDetails.action', '23', '1', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301003002', '2301003000', '从议价列表撤销议价', null, '/front/app/mgr/suborder/revokeSubOrderList.action', '/front/app/mgr/suborder/revokeSubOrderList.action', '23', '2', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301003004', '2301003000', '对委托进行议价', null, '/front/app/mgr/suborder/orderDetails.action', '/front/app/mgr/suborder/orderDetails.action', '23', '4', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301003005', '2301003000', '议价发布', null, '/front/app/mgr/suborder/performSubOrder.action', '/front/app/mgr/suborder/performSubOrder.action', '23', '4', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301003006', '2301003000', '从议价列表中摘牌', null, '/front/app/mgr/suborder/performPickoffList.action', '/front/app/mgr/suborder/performPickoffList.action', '23', '6', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301003007', '2301003000', '从议价明细中摘牌', null, '/front/app/mgr/suborder/performPickoffDetails.action', '/front/app/mgr/suborder/performPickoffDetails.action', '23', '7', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301003008', '2301003000', '从议价详情中撤销议价', null, '/front/app/mgr/suborder/revokeSubOrderDetails.action', '/front/app/mgr/suborder/revokeSubOrderDetails.action', '23', '8', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301003009', '2301003000', '从议价详情中回复议价', null, '/front/app/mgr/suborder/refuseSubOrder.action', '/front/app/mgr/suborder/refuseSubOrder.action', '23', '9', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301003010', '2301003000', '从议价列表中回复议价', null, '/front/app/mgr/suborder/refuseSubOrderList.action', '/front/app/mgr/suborder/refuseSubOrderList.action', '23', '10', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301003012', '2301003000', '首页进入议价页面', null, '/front/app/mgr/trade/order/orderDetailsForSuberOrder.action', '/front/app/mgr/trade/order/orderDetailsForSuberOrder.action', '23', '11', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301003013', '2301003000', '到从议价列表回复页面', null, '/front/app/mgr/suborder/toRefuseSubOrderList.action', '/front/app/mgr/suborder/toRefuseSubOrderList.action', '23', '12', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301004000', '2301000000', '我的订单', null, '/front/app/mgr/trade/reserve/reserveList.action', '/front/app/mgr/trade/reserve/reserveList.action?sortColumns=order+by+reserveID+desc', '23', '4', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301004001', '2301004000', '订单明细', null, '/front/app/mgr/trade/reserve/reserveDetails.action', '/front/app/mgr/trade/reserve/reserveDetails.action', '23', '1', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301004002', '2301004000', '撤销订单', null, '/front/app/mgr/trade/reserve/repealReserve.action', '/front/app/mgr/trade/reserve/repealReserve.action', '23', '2', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301004003', '2301004000', '详情撤销订单', null, '/front/app/mgr/trade/reserve/repealReserveDetail.action', '/front/app/mgr/trade/reserve/repealReserveDetail.action', '23', '3', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301005000', '2301000000', '我的成交', null, '/front/app/mgr/trade/holding/list.action', '/front/app/mgr/trade/holding/list.action?sortColumns=order+by+holdingID+desc', '23', '5', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('9900000046', '-1', 'wx协议书页面', null, '/front/logon/pageXYSwx.jsp', '/front/logon/pageXYSwx.jsp', '99', '46', '0', '-2', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('1001000000', '9900000000', '用户管理', null, '/front/app/integrated/updateusermessage*', null, '10', '1', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('1001001000', '1001000000', '用户信息', null, '/front/app/integrated/userInformation*', '/front/app/integrated/userInformation/userInformation.action', '10', '1', '0', '0', '1021', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('1002000000', '9900000000', '公告消息', null, '/front/app/integrated/noticeandmessage*', '/front/app/integrated/noticeandmessage*', '10', '2', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('1002000100', '1002000000', '公告', null, '/front/app/integrated/noticeandmessage/notice*', '/front/app/integrated/noticeandmessage/noticeList.action?sortColumns=order+by+createTime+desc', '10', '1', '0', '0', '1041', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('1002000101', '1002000100', '公告详情', null, '/front/app/integrated/noticeandmessage/noticeDetails.action', '/front/app/integrated/noticeandmessage/noticeDetails.action', '10', '2', '0', '1', '1041', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('1002000200', '1002000000', '消息', null, '/front/app/integrated/noticeandmessage/message*', '/front/app/integrated/noticeandmessage/messageList.action?sortColumns=order+by+createTime+desc', '10', '2', '0', '0', '1041', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('1002000201', '1002000200', '消息详情', null, 'front/app/integrated/noticeandmessage/messageDetails.action', '/front/app/integrated/noticeandmessage/messageDetails.action', '10', '2', '0', '1', '1041', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('1101000000', '9900000000', '资金系统', null, null, null, '11', '1', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('1101010000', '1101000000', '交易商资金流水', null, '/front/app/finance/fund/firmFundFlow.action', '/front/app/finance/fund/firmFundFlow.action', '11', '1', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('1101020000', '1101000000', '交易商资金明细', null, '/front/app/finance/fundDetail/firmFundDetail.action*', '/front/app/finance/fundDetail/firmFundDetail.action', '11', '2', '-1', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('1101030000', '1101000000', '交易商总账单', null, '/front/app/finance/ledger/clientLedger.action', '/front/app/finance/ledger/clientLedger.action', '11', '3', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('1101040000', '1101000000', '交易商总账单合计', null, '/front/app/finance/ledgerSum/clientLedgerSum.action*', '/front/app/finance/ledgerSum/clientLedgerSum.action', '11', '4', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('1301000000', '9900000000', '仓单管理', null, null, null, '13', '1', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('1301001000', '1301000000', '未注册仓单', null, '/front/bill/unregister/*', '/front/bill/unregister/list.action?sortColumns=order+by+createTime+desc+,+to_number(stockId)+desc', '13', '1', '0', '0', '1310', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('1301001010', '1301001000', '未注册仓单详情权限', null, '/front/bill/unregister/detail.action', '/front/bill/unregister/detail.action', '13', '1', '0', '1', '1310', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('1301001020', '1301001000', '注册仓单权限', null, '/front/bill/unregister/registerStock.action', '/front/bill/unregister/registerStock.action', '13', '2', '0', '1', '1310', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('1301001030', '1301001000', '仓单拆单详情权限', null, '/front/bill/split/detail.action', '/front/bill/split/detail.action', '13', '4', '0', '0', '1310', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('1301001031', '1301001030', '拆分仓单权限', null, '/front/bill/unregister/dismantle*', null, '13', '1', '0', '1', '1310', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('1301001040', '1301001000', '仓库出库跳转权限', null, '/front/bill/unregister/forwardExitStock.action', '/front/bill/unregister/forwardExitStock.action', '13', '4', '0', '1', '1310', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('1301001041', '1301001040', '仓单出库权限', null, '/front/bill/unregister/exitStock.action', '/front/bill/unregister/exitStock.action', '13', '3', '0', '1', '1310', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('1301002000', '1301000000', '注册仓单管理', null, '/front/bill/register/*', '/front/bill/register/list.action?sortColumns=order+by+createTime+desc+,+to_number(stockId)+desc', '13', '2', '0', '0', '1310', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('1301002010', '1301002000', '注册仓单详情权限', null, '/front/bill/register/detail.action', '/front/bill/register/detail.action', '13', '1', '0', '0', '1310', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('1301002020', '1301002000', '注销仓单权限', null, '/front/bill/register/logoutStock.action', null, '13', '1', '0', '1', '1310', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('1301003000', '1301000000', '拆单管理', null, '/front/bill/split/*', '/front/bill/split/list.action?sortColumns=order+by+dismantleId+desc', '13', '3', '0', '0', '1310', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('1301004000', '1301000000', '出库仓单管理', null, '/front/bill/exit/*', '/front/bill/exit/list.action?sortColumns=order+by+stockId+desc', '13', '4', '0', '0', '1310', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('1301004010', '1301004000', '出库仓单详情权限', null, '/front/bill/exit/detail.action', '/front/bill/exit/detail.action', '13', '1', '0', '0', '1310', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('1301004020', '1301004000', '出库申请中仓单权限', null, '/front/bill/exit/stockOutApplyList.action', '/front/bill/exit/stockOutApplyList.action', '13', '2', '0', '0', '1310', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('1301004030', '1301004000', '出库申请撤销权限', null, '/front/bill/exit/stockOutCancel.action', '/front/bill/exit/stockOutCancel.action', '13', '3', '0', '0', '1310', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('1301002060', '1301002000', '融资仓单详情权限', null, '/front/bill/register/financingstockdetail.action', '/front/bill/register/financingstockdetail.action', '13', '2', '0', '0', '1310', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('1301002030', '1301002000', '卖仓单详情权限', null, '/front/bill/register/sellstockdetail.action', '/front/bill/register/sellstockdetail.action', '13', '3', '0', '0', '1310', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('1301002040', '1301002000', '交收仓单详情权限', null, '/front/bill/register/tradestockdetail.action', '/front/bill/register/tradestockdetail.action', '13', '4', '0', '0', '1310', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('1301002050', '1301002000', '冻结仓单详情权限', null, '/front/bill/register/frozenstockdetail.action', '/front/bill/register/frozenstockdetail.action', '13', '5', '0', '0', '1310', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2801000000', '9900000000', '银行接口', null, null, null, '28', '1', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2801001000', '2801000000', '资金划转', null, '/bank/money/gotoMoneyPage.action', '/bank/money/gotoMoneyPage.action', '28', '1', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2801001001', '2801001000', '执行划转', null, '/bank/money/moneyTransfer.action', '/bank/money/moneyTransfer.action', '28', '1', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2801002000', '2801000000', '余额查询', null, '/bank/balance/gotoQueryMoneyPage.action', '/bank/balance/gotoQueryMoneyPage.action', '28', '2', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2801002001', '2801002000', '执行查询', null, '/bank/balance/queryMoney.action', '/bank/balance/queryMoney.action', '28', '1', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2801003000', '2801000000', '流水查询', null, '/bank/capital/getCapitalInfoList.action', '/bank/capital/getCapitalInfoList.action?sortColumns=order+by+id+desc', '28', '3', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2801004000', '2801000000', '密码修改', null, '/bank/user/gotoChangePasswordPage.action', '/bank/user/gotoChangePasswordPage.action', '28', '4', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2801004001', '2801004000', '执行修改', null, '/bank/user/changePassword.action', '/bank/user/changePassword.action', '28', '1', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2801005000', '2801000000', '签约解约', null, '/bank/firmInfo/gotoRgstDelFirmInfoPage.action', '/bank/firmInfo/gotoRgstDelFirmInfoPage.action', '28', '5', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2801005001', '2801005000', '执行', null, '/bank/firmInfo/gotoHXCrossFirmInfoPage.action', '/bank/firmInfo/gotoHXCrossFirmInfoPage.action', '28', '1', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2801005002', '2801005000', '执行签约', null, '/bank/firmInfo/synchroRegist.action', '/bank/firmInfo/synchroRegist.action', '28', '2', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2801005003', '2801005000', '执行他行签约', null, '/bank/firmInfo/gotoRgstHX.action', '/bank/firmInfo/gotoRgstHXaction', '28', '3', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2801005005', '2801005000', '执行解约', null, '/bank/firmInfo/delRegist.action', '/bank/firmInfo/gotoRgstHXaction', '28', '5', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2801005006', '2801005000', '执行签约', null, '/bank/firmInfo/openRegist.action', '/bank/firmInfo/openRegist.action', '28', '6', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2801005004', '2801005000', '国付宝执行签约', null, '/bank/firmInfo/gotoRgstDelFirmInfoPageGFB.action', '/bank/firmInfo/gotoRgstDelFirmInfoPageGFB.action', '28', '4', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2801001002', '2801001000', '国付宝执行划转', null, '/bank/money/moneyTransferGFB.action', '/bank/money/moneyTransferGFB.action', '28', '2', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301005001', '2301005000', '成交明细', null, '/front/app/mgr/trade/holding/holdingDetails.action', '/front/app/mgr/trade/holding/holdingDetails.action', '23', '1', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301005002', '2301005000', '撤销成交', null, '/front/app/mgr/trade/holding/repealHolding.action', '/front/app/mgr/trade/holding/repealHolding.action', '23', '2', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301006000', '2301000000', '协议交收合同管理', null, '/front/app/mgr/trade/tradecontract/tradeList.action', '/front/app/mgr/trade/tradecontract/tradeList.action?sortColumns=order+by+time+desc', '23', '6', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301006001', '2301006000', '合同查看', null, '/front/app/mgr/trade/tradecontract/tradeDetails.action', '/front/app/mgr/trade/tradecontract/tradeDetails.action', '23', '1', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301006002', '2301006000', '转入保证金跳转', null, '/front/app/mgr/trade/tradecontract/forwardPaymentReserve.action', '/front/app/mgr/trade/tradecontract/forwardPaymentReserve.action', '23', '2', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301006003', '2301006000', '转入保证金操作', null, '/front/app/mgr/trade/tradecontract/paymentReserve.action', '/front/app/mgr/trade/tradecontract/paymentReserve.action', '23', '3', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301006004', '2301006000', '转入仓单跳转', null, '/front/app/mgr/trade/tradecontract/forwardTransferGoods.action', '/front/app/mgr/trade/tradecontract/forwardTransferGoods.action', '23', '4', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301006005', '2301006000', '转入仓单操作', null, '/front/app/mgr/trade/tradecontract/transferGoods.action', '/front/app/mgr/trade/tradecontract/transferGoods.action', '23', '5', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301009001', '2301009000', '撤销操作', null, '/front/app/mgr/trade/offSetcontract/revocationOffSet.action', '/front/app/mgr/trade/offSetcontract/revocationOffSeth.action', '23', '1', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301009002', '2301009000', '处理操作', null, '/front/app/mgr/trade/offSetcontract/agreeOffSet.action', '/front/app/mgr/trade/offSetcontract/agreeOffSet.action', '23', '2', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301009003', '2301009000', '处理跳转操作', null, '/front/app/mgr/trade/offSetcontract/forwardAgreeOffSet.action', '/front/app/mgr/trade/offSetcontract/forwardAgreeOffSet.action', '23', '3', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301010000', '2301000000', '追缴货款申请管理', null, '/front/app/mgr/trade/goodsMoneyApply/list.action', '/front/app/mgr/trade/goodsMoneyApply/list.action?sortColumns=order+by+id+desc', '23', '10', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301010001', '2301010000', '撤销追缴货款', null, '/front/app/mgr/trade/goodsMoneyApply/withdrawLastGoodsMoneyApply.action', '/front/app/mgr/trade/goodsMoneyApply/withdrawLastGoodsMoneyApply.action', '23', '1', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301010002', '2301010000', '支付尾款操作', null, '/front/app/mgr/trade/goodsMoneyApply/paymentBalanceToSell.action', '/front/app/mgr/trade/goodsMoneyApply/paymentBalanceToSell.action', '23', '7', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301010003', '2301010000', '支付尾款跳转', null, '/front/app/mgr/trade/goodsMoneyApply/forwardPaymentBalanceToSell.action', '/front/app/mgr/trade/goodsMoneyApply/forwardPaymentBalanceToSell.action', '23', '6', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301010004', '2301010000', '支付首款操作', null, '/front/app/mgr/trade/goodsMoneyApply/paymentMoneyToSell.action', '/front/app/mgr/trade/goodsMoneyApply/paymentMoneyToSell.action', '23', '3', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301010005', '2301010000', '支付首款跳转', null, '/front/app/mgr/trade/goodsMoneyApply/forwardPaymentMoneyToSell.action', '/front/app/mgr/trade/goodsMoneyApply/forwardPaymentMoneyToSell.action', '23', '2', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301010006', '2301010000', '支付第二期货款操作', null, '/front/app/mgr/trade/goodsMoneyApply/paySecondGoods.action', '/front/app/mgr/trade/goodsMoneyApply/paySecondGoods.action', '23', '5', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301010007', '2301010000', '支付第二期货款跳转', null, '/front/app/mgr/trade/goodsMoneyApply/forwardSecondPaymentMoneyToSell.action', '/front/app/mgr/trade/goodsMoneyApply/forwardSecondPaymentMoneyToSell.action', '23', '4', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301011000', '2301000000', '结束合同申请管理', null, '/front/app/mgr/trade/endTradeApply/list.action', '/front/app/mgr/trade/endTradeApply/list.action?sortColumns=order+by+applyId+desc', '23', '11', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2302000000', '9900000000', '后续维权与仲裁', null, null, null, '23', '2', '0', '-1', '0', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2302001000', '2302000000', '仲裁添加检查', null, '/ajaxcheck/*', '/ajaxcheck/*', '23', '1', '0', '1', '2304', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2302002000', '2302000000', '申请退款', null, '/front/app/mgr/arbitration/refund/*', '/front/app/mgr/arbitration/refund/list.action?sortColumns=order+by+arbitrationId+desc', '23', '2', '0', '0', '2304', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2302002001', '2302002000', '退款申请', null, '/front/app/mgr/arbitration/refund/add*', null, '23', '1', '0', '1', '2304', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2302003000', '2302000000', '申请退货', null, '/front/app/mgr/arbitration/return/*', '/front/app/mgr/arbitration/return/list.action?sortColumns=order+by+arbitrationId+desc', '23', '1', '0', '0', '2304', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2302003001', '2302003000', '退货申请', null, '/front/app/mgr/arbitration/return/add*', null, '23', '1', '0', '1', '2304', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2302004000', '2302000000', '投诉', null, '/front/app/mgr/arbitration/complain/*', '/front/app/mgr/arbitration/complain/list.action?sortColumns=order+by+arbitrationId+desc', '23', '3', '0', '0', '2304', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2302004001', '2302004000', '投诉申请', null, '/front/app/mgr/arbitration/complain/add*', null, '3', '1', '0', '1', '0', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2303000000', '9900000000', '预备委托', null, null, null, '23', '3', '0', '-1', '0', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2303001000', '2303000000', '预备委托管理', null, '/front/app/mgr/commodity/goodsResource/commodityList.action', '/front/app/mgr/commodity/goodsResource/commodityList.action?sortColumns=order+by+resourceID+desc', '23', '1', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2303001001', '2303001000', '预备委托查看', null, '/front/app/mgr/commodity/goodsResource/commodityDetails.action', '/front/app/mgr/commodity/goodsResource/commodityDetails.action', '23', '1', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2303001002', '2303001000', '预备委托修改', null, '/front/app/mgr/commodity/goodsResource/updateCommodity.action', '/front/app/mgr/commodity/goodsResource/updateCommodity.action', '23', '2', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2303001003', '2303001000', '预备委托到委托', null, '/front/app/mgr/commodity/goodsResource/addCommodityToOrders.action', '/front/app/mgr/commodity/goodsResource/addCommodityToOrders.action', '23', '3', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2303001004', '2303001000', '删除预备委托', null, '/front/app/mgr/commodity/goodsResource/deleteCommodity.action', '/front/app/mgr/commodity/goodsResource/deleteCommodity.action', '23', '4', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2303001005', '2303001000', '预备委托详情图片', null, '/front/app/mgr/commodity/goodsResource/showImages.action', '/front/app/mgr/commodity/goodsResource/showImages.action', '23', '5', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2303002000', '2303000000', '添加预备委托', null, '/front/app/mgr/commodity/goodsResource/forwardCommodity.action', '/front/app/mgr/commodity/goodsResource/forwardCommodity.action', '23', '2', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2303002001', '2303002000', '添加预备委托操作', null, '/front/app/mgr/commodity/goodsResource/addCommodity.action', '/front/app/mgr/commodity/goodsResource/addCommodity.action', '23', '1', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2304000000', '9900000000', '委托模版', null, null, null, '23', '4', '0', '-1', '0', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2304001000', '2304000000', '委托模版列表', null, '/front/app/mgr/commodity/goodstemplate/templateList.action', '/front/app/mgr/commodity/goodstemplate/templateList.action?sortColumns=order+by+templateID+desc', '23', '1', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2304001001', '2304001000', '进入模板修改页面', null, '/front/app/mgr/commodity/goodstemplate/gotoTemplateMod.action', '/front/app/mgr/commodity/goodstemplate/gotoTemplateMod.action', '23', '1', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2304001002', '2304001000', '修改模板信息', null, '/front/app/mgr/commodity/goodstemplate/templateMod.action', '/front/app/mgr/commodity/goodstemplate/templateMod.action', '23', '2', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2304001003', '2304001000', '从模板修改页面直接删除模板', null, '/front/app/mgr/commodity/goodstemplate/templateDel.action', '/front/app/mgr/commodity/goodstemplate/templateDel.action', '23', '3', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2304001004', '2304001000', '从列表页面删除模板', null, '/front/app/mgr/commodity/goodstemplate/templateDelList.action', '/front/app/mgr/commodity/goodstemplate/templateDelList.action', '23', '4', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2304002000', '2304000000', '委托模版添加', null, '/front/app/mgr/commodity/goodstemplate/gotoTemplateAdd.action', '/front/app/mgr/commodity/goodstemplate/gotoTemplateAdd.action', '23', '2', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2304002001', '2304002000', '添加模板', null, '/front/app/mgr/commodity/goodstemplate/templateAdd.action', '/front/app/mgr/commodity/goodstemplate/templateAdd.action', '23', '1', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2304002002', '2304002000', '选择模板列表', null, '/front/app/mgr/commodity/goodstemplate/templateChoseList.action', '/front/app/mgr/commodity/goodstemplate/templateChoseList.action', '23', '2', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2304002003', '2304002000', '通过模板编号获取模板的json串', null, '/front/app/mgr/commodity/jsontemplate/getTemplateByID.action', '/front/app/mgr/commodity/jsontemplate/getTemplateByID.action', '23', '3', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2305000000', '9900000000', '资金管理', null, null, null, '23', '5', '0', '-1', '0', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2305001000', '2305000000', '资金情况', null, '/front/app/mgr/funds/fundsDetails.action', '/front/app/mgr/funds/fundsDetails.action', '23', '1', '0', '0', '2305', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2305002000', '2305000000', '诚信保障金管理', null, '/front/app/mgr/funds/subscriptionView.action', '/front/app/mgr/funds/subscriptionView.action?sortColumns=order+by+createTime+desc', '23', '2', '0', '0', '2305', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2305002001', '2305002000', '获取诚信保证金ajax访问权限', null, '/front/app/mgr/jsonforMgrfunds/subscriptionView.action', '/front/app/mgr/jsonforMgrfunds/subscriptionView.action', '23', '1', '0', '0', '2305', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2305002002', '2305002000', '转入诚信保障金权限', null, '/front/app/mgr/funds/inputSubscriptionView.action', '/front/app/mgr/funds/inputSubscriptionView.action', '23', '2', '0', '0', '2305', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2305002003', '2305002000', '转出诚信保障金权限', null, '/front/app/mgr/funds/outSubscriptionView.action', '/front/app/mgr/funds/outSubscriptionView.action', '23', '3', '0', '0', '2305', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2305003000', '2305000000', '资金流水', null, '/front/app/mgr/funds/fundsList.action', '/front/app/mgr/funds/fundsList.action?sortColumns=order+by+fundFlowID+desc', '23', '3', '0', '0', '2305', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2101000000', '9900000000', '竞价交易', null, '/front/app/*', null, '21', '1', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('1502000000', '9900000000', '报表查询', null, null, null, '15', '2', '0', '-1', '1513', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('1502010000', '1502000000', '资金结算', null, '/front/app/timebargain/report/*', '/front/app/timebargain/report/printFund.jsp', '15', '1', '0', '0', '1513', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('1502010001', '1502010000', '资金结算表查询权限', null, '/front/app/timebargain/report/firmFundsQuery.action', null, '15', '1', '-1', '1', '1513', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('1502020000', '1502000000', '成交记录', null, '/front/app/timebargain/report/*', '/front/app/timebargain/report/printTrade.jsp', '15', '2', '0', '0', '1513', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('1502020001', '1502020000', '成交记录表查询权限', null, '/front/app/timebargain/report/tradesQuery.action', null, '15', '1', '-1', '1', '1513', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('1502030000', '1502000000', '转让盈亏明细', null, '/front/app/timebargain/report/*', '/front/app/timebargain/report/printTransferProfitAndLoss.jsp', '15', '3', '0', '0', '1513', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('1502030001', '1502030000', '转让盈亏明细表查询权限', null, '/front/app/timebargain/report/transferProfitAndLossQuery.action', null, '15', '1', '-1', '1', '1513', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('1502040000', '1502000000', '订货汇总', null, '/front/app/timebargain/report/*', '/front/app/timebargain/report/printHoldSum.jsp', '15', '4', '0', '0', '1513', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('1502040001', '1502040000', '订货汇总表查询权限', null, '/front/app/timebargain/report/firmHoldSumQuery.action', null, '15', '1', '-1', '1', '1513', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('1502050000', '1502000000', '当前仓单抵顶数量', null, '/front/app/timebargain/report/*', '/front/app/timebargain/report/validGageBillQuery.action', '15', '5', '0', '0', '1513', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('1502060000', '1502000000', '当前资金明细', null, '/front/app/timebargain/report/*', '/front/app/timebargain/report/fundDetailQuery.action', '15', '6', '0', '0', '1513', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('1502070000', '1502000000', '交收信息', null, '/front/app/timebargain/report/*', '/front/app/timebargain/report/printTradeSettle.jsp', '15', '7', '0', '0', '1513', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('1502070001', '1502070000', '交收信息表查询权限', null, '/front/app/timebargain/report/tradeSettleQuery.action', null, '15', '1', '-1', '1', '1513', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('1501000000', '9900000000', '延期交收', null, null, null, '15', '1', '0', '-1', '1513', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('1501010000', '1501000000', '交收申报', null, '/front/app/timebargain/delay/*', '/front/app/timebargain/delay/frame.jsp', '15', '1', '0', '0', '1513', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('1501010001', '1501010000', '延期交收行情实时查询', null, '/front/app/timebargain/delayAjax/delayRealTimeInfo.action*', '/front/app/timebargain/delayAjax/delayRealTimeInfo.action', '15', '1', '0', '1', '1513', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('1501010002', '1501010000', '申报查询', null, '/front/app/timebargain/delayAjax/delayOrderQuery.action*', '/front/app/timebargain/delayAjax/delayOrderQuery.action', '15', '2', '0', '1', '1513', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('1501010003', '1501010000', '订货查询', null, '/front/app/timebargain/delayAjax/delayCommodityHoldingQuery.action*', '/front/app/timebargain/delayAjax/delayCommodityHoldingQuery.action', '15', '3', '0', '1', '1513', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('1501010004', '1501010000', '资金查询', null, '/front/app/timebargain/delayAjax/capitalQuery.action*', '/front/app/timebargain/delayAjax/capitalQuery.action', '15', '4', '0', '1', '1513', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('1501010005', '1501010000', '交割申报', null, '/front/app/timebargain/delayAjax/delayOrder.action*', '/front/app/timebargain/delayAjax/delayOrder.action', '15', '5', '0', '0', '1513', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('1501010006', '1501010000', '撤销所选单', null, '/front/app/timebargain/delayAjax/cancelDelayOrder.action*', '/front/app/timebargain/delayAjax/cancelDelayOrder.action', '15', '6', '0', '1', '1513', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('1501020000', '1501000000', '历史委托', null, '/front/app/timebargain/delay/*', '/front/app/timebargain/delay/delayOrderHistory.action?sortColumns=order by orderTime desc&pageSize=10', '15', '2', '0', '-1', '1513', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('1501020001', '1501020000', '历史委托分页跳转', null, '/front/app/timebargain/delay/delayOrderHistory.action*', '/front/app/timebargain/delay/delayOrderHistory.action', '15', '1', '0', '0', '1513', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301006006', '2301006000', '关闭交易操作', null, '/front/app/mgr/trade/tradecontract/withdrawTrade.action', '/front/app/mgr/trade/tradecontract/withdrawTrade.action', '23', '6', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301006007', '2301006000', '转入货款跳转', null, '/front/app/mgr/trade/tradecontract/forwardPaymentGoodsMoney.action', '/front/app/mgr/trade/tradecontract/forwardPaymentGoodsMoney.action', '23', '7', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301006008', '2301006000', '转入货款操作', null, '/front/app/mgr/trade/tradecontract/paymentGoodsMoney.action', '/front/app/mgr/trade/tradecontract/paymentGoodsMoney.action', '23', '8', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301006009', '2301006000', '申请损益跳转', null, '/front/app/mgr/trade/tradecontract/forwardPerformAskOffset.action', '/front/app/mgr/trade/tradecontract/forwardPerformAskOffset.action', '23', '9', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301006010', '2301006000', '申请损益操作', null, '/front/app/mgr/trade/tradecontract/performAskOffset.action', '/front/app/mgr/trade/tradecontract/performAskOffset.action', '23', '10', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301006011', '2301006000', '撤销损益操作', null, '/front/app/mgr/trade/tradecontract/performWithdrawOffset.action', '/front/app/mgr/trade/tradecontract/performWithdrawOffset.action', '23', '11', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301006012', '2301006000', '处理损益跳转', null, '/front/app/mgr/trade/tradecontract/forwardPerformDisposeOffset.action', '/front/app/mgr/trade/tradecontract/forwardPerformDisposeOffset.action', '23', '12', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301006013', '2301006000', '处理损益操作', null, '/front/app/mgr/trade/tradecontract/performDisposeOffset.action', '/front/app/mgr/trade/tradecontract/performDisposeOffset.action', '23', '13', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301006014', '2301006000', '支付首款操作', null, '/front/app/mgr/trade/tradecontract/paymentMoneyToSell.action', '/front/app/mgr/trade/tradecontract/paymentMoneyToSell.action', '23', '14', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301006015', '2301006000', '支付尾款操作', null, '/front/app/mgr/trade/tradecontract/paymentBalanceToSell.action', '/front/app/mgr/trade/tradecontract/paymentBalanceToSell.action', '23', '15', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301006016', '2301006000', '违约申请操作', null, '/front/app/mgr/trade/tradecontract/performBreachAsk.action', '/front/app/mgr/trade/tradecontract/performBreachAsk.action', '23', '16', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301006017', '2301006000', '撤销违约操作', null, '/front/app/mgr/trade/tradecontract/performWithdrawAsk.action', '/front/app/mgr/trade/tradecontract/performWithdrawAsk.action', '23', '20', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301006018', '2301006000', '处理违约跳转', null, '/front/app/mgr/trade/tradecontract/forwardPerformBreach.action', '/front/app/mgr/trade/tradecontract/forwardPerformBreach.action', '23', '18', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301006019', '2301006000', '处理违约操作', null, '/front/app/mgr/trade/tradecontract/performBreach.action', '/front/app/mgr/trade/tradecontract/performBreach.action', '23', '19', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301006020', '2301006000', '支付首款跳转', null, '/front/app/mgr/trade/tradecontract/forwardPaymentMoneyToSell.action', '/front/app/mgr/trade/tradecontract/forwardPaymentMoneyToSell.action', '23', '20', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301006021', '2301006000', '支付尾款跳转', null, '/front/app/mgr/trade/tradecontract/forwardPaymentBalanceToSell.action', '/front/app/mgr/trade/tradecontract/forwardPaymentBalanceToSell.action', '23', '21', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301006022', '2301006000', '无损益操作', null, '/front/app/mgr/trade/tradecontract/noOffSetApply.action', '/front/app/mgr/trade/tradecontract/noOffSetApply.action', '23', '22', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301006023', '2301006000', '追缴货款申请', null, '/front/app/mgr/trade/tradecontract/lastGoodsMoneyApply.action', '/front/app/mgr/trade/tradecontract/lastGoodsMoneyApply.action', '23', '23', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301006024', '2301006000', '撤销货款申请', null, '/front/app/mgr/trade/tradecontract/withdrawLastGoodsMoneyApply.action', '/front/app/mgr/trade/tradecontract/withdrawLastGoodsMoneyApply.action', '23', '24', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301006025', '2301006000', '二次货款跳转', null, '/front/app/mgr/trade/tradecontract/forwardSecondPaymentMoneyToSell.action', '/front/app/mgr/trade/tradecontract/forwardSecondPaymentMoneyToSell.action', '23', '25', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301006026', '2301006000', '二次货款操作', null, '/front/app/mgr/trade/tradecontract/paySecondGoods.action', '/front/app/mgr/trade/tradecontract/paySecondGoods.action', '23', '26', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301007000', '2301000000', '自主交收合同管理', null, '/front/app/mgr/trade/tradeAutonomy/tradeList.action', '/front/app/mgr/trade/tradeAutonomy/tradeList.action?sortColumns=order+by+time+desc', '23', '7', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301007001', '2301007000', '合同查看', null, '/front/app/mgr/trade/tradeAutonomy/tradeDetails.action', '/front/app/mgr/trade/tradeAutonomy/tradeDetails.action', '23', '1', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2301007002', '2301007000', '转入保证金跳转', null, '/front/app/mgr/trade/tradeAutonomy/forwardPaymentReserve.action', '/front/app/mgr/trade/tradeAutonomy/forwardPaymentReserve.action', '23', '2', '0', '0', '2309', 'Y');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('9900000000', null, '主菜单', null, null, null, '99', '99', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('9900000001', '-1', '验证码', null, '/front/public/jsp/loginimage.jsp', '/front/public/jsp/loginimage.jsp', '99', '1', '0', '-2', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('9900000047', '-1', 'wx注册页面', null, '/front/logon/registerwx.jsp', '/front/logon/registerwx.jsp', '99', '47', '0', '-2', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2101000001', '2101000000', '竞价交易', null, '/dwr*', null, '21', '3', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('9900000045', '-1', '协议书页面', null, '/front/logon/pageXYS.jsp', '/front/logon/pageXYS.jsp', '99', '45', '0', '-2', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('1301004040', '1301004000', '卖出仓单列表权限', null, '/front/bill/exit/stockBySeller.action', '/front/bill/exit/stockBySeller.action', '13', '4', '0', '0', '1310', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('1301004050', '1301004000', '查看发票信息权限', null, '/front/bill/exit/showInvoice.action', '/front/bill/exit/showInvoice.action', '13', '5', '0', '0', '1310', 'N');
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('1301004060', '1301004000', '确认收货权限', null, '/front/bill/exit/stockConfirm.action', '/front/bill/exit/stockConfirm.action', '13', '6', '0', '0', '1310', 'N');

-- ----------------------------
-- Table structure for C_FRONT_ROLE
-- ----------------------------
DROP TABLE "TRADE_GNNT"."C_FRONT_ROLE";
CREATE TABLE "TRADE_GNNT"."C_FRONT_ROLE" (
"ID" NUMBER(10) NOT NULL ,
"NAME" VARCHAR2(32 BYTE) NOT NULL ,
"DESCRIPTION" VARCHAR2(256 BYTE) NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON COLUMN "TRADE_GNNT"."C_FRONT_ROLE"."ID" IS '角色Id';
COMMENT ON COLUMN "TRADE_GNNT"."C_FRONT_ROLE"."NAME" IS '角色名称';
COMMENT ON COLUMN "TRADE_GNNT"."C_FRONT_ROLE"."DESCRIPTION" IS '描述';

-- ----------------------------
-- Records of C_FRONT_ROLE
-- ----------------------------

-- ----------------------------
-- Table structure for C_FRONT_ROLE_RIGHT
-- ----------------------------
DROP TABLE "TRADE_GNNT"."C_FRONT_ROLE_RIGHT";
CREATE TABLE "TRADE_GNNT"."C_FRONT_ROLE_RIGHT" (
"RIGHTID" NUMBER(10) NOT NULL ,
"ROLEID" NUMBER(10) NOT NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON COLUMN "TRADE_GNNT"."C_FRONT_ROLE_RIGHT"."RIGHTID" IS '权限Id
权限Id';
COMMENT ON COLUMN "TRADE_GNNT"."C_FRONT_ROLE_RIGHT"."ROLEID" IS '角色Id';

-- ----------------------------
-- Records of C_FRONT_ROLE_RIGHT
-- ----------------------------

-- ----------------------------
-- Table structure for C_FRONT_USER_RIGHT
-- ----------------------------
DROP TABLE "TRADE_GNNT"."C_FRONT_USER_RIGHT";
CREATE TABLE "TRADE_GNNT"."C_FRONT_USER_RIGHT" (
"RIGHTID" NUMBER(10) NOT NULL ,
"USERID" VARCHAR2(12 BYTE) NOT NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON COLUMN "TRADE_GNNT"."C_FRONT_USER_RIGHT"."RIGHTID" IS '权限Id
权限Id';
COMMENT ON COLUMN "TRADE_GNNT"."C_FRONT_USER_RIGHT"."USERID" IS '管理员Id';

-- ----------------------------
-- Records of C_FRONT_USER_RIGHT
-- ----------------------------

-- ----------------------------
-- Table structure for C_FRONT_USER_ROLE
-- ----------------------------
DROP TABLE "TRADE_GNNT"."C_FRONT_USER_ROLE";
CREATE TABLE "TRADE_GNNT"."C_FRONT_USER_ROLE" (
"USERID" VARCHAR2(12 BYTE) NOT NULL ,
"ROLEID" NUMBER(10) NOT NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON COLUMN "TRADE_GNNT"."C_FRONT_USER_ROLE"."USERID" IS '管理员Id';
COMMENT ON COLUMN "TRADE_GNNT"."C_FRONT_USER_ROLE"."ROLEID" IS '角色Id
角色Id';

-- ----------------------------
-- Records of C_FRONT_USER_ROLE
-- ----------------------------

-- ----------------------------
-- Table structure for C_GLOBALLOG_ALL
-- ----------------------------
DROP TABLE "TRADE_GNNT"."C_GLOBALLOG_ALL";
CREATE TABLE "TRADE_GNNT"."C_GLOBALLOG_ALL" (
"ID" NUMBER(15) NOT NULL ,
"OPERATOR" VARCHAR2(32 BYTE) NULL ,
"OPERATETIME" DATE DEFAULT sysdate  NULL ,
"OPERATETYPE" NUMBER(4) NULL ,
"OPERATEIP" VARCHAR2(32 BYTE) NULL ,
"OPERATORTYPE" VARCHAR2(32 BYTE) NULL ,
"MARK" VARCHAR2(4000 BYTE) NULL ,
"OPERATECONTENT" VARCHAR2(4000 BYTE) NULL ,
"CURRENTVALUE" VARCHAR2(4000 BYTE) NULL ,
"OPERATERESULT" NUMBER(1) DEFAULT 0  NULL ,
"LOGTYPE" NUMBER(2) DEFAULT 0  NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON COLUMN "TRADE_GNNT"."C_GLOBALLOG_ALL"."ID" IS 'ID';
COMMENT ON COLUMN "TRADE_GNNT"."C_GLOBALLOG_ALL"."OPERATOR" IS '操作人';
COMMENT ON COLUMN "TRADE_GNNT"."C_GLOBALLOG_ALL"."OPERATETIME" IS '操作时间';
COMMENT ON COLUMN "TRADE_GNNT"."C_GLOBALLOG_ALL"."OPERATETYPE" IS '操作类型';
COMMENT ON COLUMN "TRADE_GNNT"."C_GLOBALLOG_ALL"."OPERATEIP" IS '操作IP';
COMMENT ON COLUMN "TRADE_GNNT"."C_GLOBALLOG_ALL"."OPERATORTYPE" IS '操作人种类';
COMMENT ON COLUMN "TRADE_GNNT"."C_GLOBALLOG_ALL"."MARK" IS '标示';
COMMENT ON COLUMN "TRADE_GNNT"."C_GLOBALLOG_ALL"."OPERATECONTENT" IS '操作内容';
COMMENT ON COLUMN "TRADE_GNNT"."C_GLOBALLOG_ALL"."CURRENTVALUE" IS '当前值';
COMMENT ON COLUMN "TRADE_GNNT"."C_GLOBALLOG_ALL"."OPERATERESULT" IS '操作结果 1 成功  0 失败';
COMMENT ON COLUMN "TRADE_GNNT"."C_GLOBALLOG_ALL"."LOGTYPE" IS '0 其他，1 后台，2 前台，3 核心';

-- ----------------------------
-- Records of C_GLOBALLOG_ALL
-- ----------------------------

-- ----------------------------
-- Table structure for C_GLOBALLOG_ALL_H
-- ----------------------------
DROP TABLE "TRADE_GNNT"."C_GLOBALLOG_ALL_H";
CREATE TABLE "TRADE_GNNT"."C_GLOBALLOG_ALL_H" (
"ID" NUMBER(15) NOT NULL ,
"OPERATOR" VARCHAR2(32 BYTE) NULL ,
"OPERATETIME" DATE NULL ,
"OPERATETYPE" NUMBER(4) NULL ,
"OPERATEIP" VARCHAR2(32 BYTE) NULL ,
"OPERATORTYPE" VARCHAR2(32 BYTE) NULL ,
"MARK" VARCHAR2(4000 BYTE) NULL ,
"OPERATECONTENT" VARCHAR2(4000 BYTE) NULL ,
"CURRENTVALUE" VARCHAR2(4000 BYTE) NULL ,
"OPERATERESULT" NUMBER(1) DEFAULT 0  NULL ,
"LOGTYPE" NUMBER(2) NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON COLUMN "TRADE_GNNT"."C_GLOBALLOG_ALL_H"."ID" IS 'ID';
COMMENT ON COLUMN "TRADE_GNNT"."C_GLOBALLOG_ALL_H"."OPERATOR" IS '操作人';
COMMENT ON COLUMN "TRADE_GNNT"."C_GLOBALLOG_ALL_H"."OPERATETIME" IS '操作时间';
COMMENT ON COLUMN "TRADE_GNNT"."C_GLOBALLOG_ALL_H"."OPERATETYPE" IS '操作类型';
COMMENT ON COLUMN "TRADE_GNNT"."C_GLOBALLOG_ALL_H"."OPERATEIP" IS '操作IP';
COMMENT ON COLUMN "TRADE_GNNT"."C_GLOBALLOG_ALL_H"."OPERATORTYPE" IS '操作人种类';
COMMENT ON COLUMN "TRADE_GNNT"."C_GLOBALLOG_ALL_H"."MARK" IS '标示';
COMMENT ON COLUMN "TRADE_GNNT"."C_GLOBALLOG_ALL_H"."OPERATECONTENT" IS '操作内容';
COMMENT ON COLUMN "TRADE_GNNT"."C_GLOBALLOG_ALL_H"."CURRENTVALUE" IS '当前值';
COMMENT ON COLUMN "TRADE_GNNT"."C_GLOBALLOG_ALL_H"."OPERATERESULT" IS '操作结果 1 成功  0 失败';
COMMENT ON COLUMN "TRADE_GNNT"."C_GLOBALLOG_ALL_H"."LOGTYPE" IS '0 其他，1 后台，2 前台，3 核心';

-- ----------------------------
-- Records of C_GLOBALLOG_ALL_H
-- ----------------------------

-- ----------------------------
-- Table structure for C_LOGCATALOG
-- ----------------------------
DROP TABLE "TRADE_GNNT"."C_LOGCATALOG";
CREATE TABLE "TRADE_GNNT"."C_LOGCATALOG" (
"CATALOGID" NUMBER(4) NOT NULL ,
"MODULEID" NUMBER(2) NOT NULL ,
"CATALOGNAME" VARCHAR2(32 BYTE) NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON TABLE "TRADE_GNNT"."C_LOGCATALOG" IS '日志分类，4位数字的编码，以日志模块ID开头。';
COMMENT ON COLUMN "TRADE_GNNT"."C_LOGCATALOG"."CATALOGID" IS '日志分类ID：4位数字的编码，详见备注Notes。';
COMMENT ON COLUMN "TRADE_GNNT"."C_LOGCATALOG"."MODULEID" IS '10综合管理平台
11财务系统
12监管仓库管理系统
13仓单管理系统
14融资系统
15订单交易
18投资类大宗商品交易系统
19加盟会员管理系统
20做市商交易系统
21竞价系统
22银行接入及结算系统
23E现货
24单点登录系统
25实时行情分析系统
26交易客户端
98demo系统
99公用系统';
COMMENT ON COLUMN "TRADE_GNNT"."C_LOGCATALOG"."CATALOGNAME" IS '日志分类名';

-- ----------------------------
-- Records of C_LOGCATALOG
-- ----------------------------
INSERT INTO "TRADE_GNNT"."C_LOGCATALOG" VALUES ('1001', '10', '角色管理日志');
INSERT INTO "TRADE_GNNT"."C_LOGCATALOG" VALUES ('1011', '10', '管理员管理日志');
INSERT INTO "TRADE_GNNT"."C_LOGCATALOG" VALUES ('1021', '10', '交易商管理日志');
INSERT INTO "TRADE_GNNT"."C_LOGCATALOG" VALUES ('1031', '10', '交易员管理日志');
INSERT INTO "TRADE_GNNT"."C_LOGCATALOG" VALUES ('1041', '10', '公告消息管理日志');
INSERT INTO "TRADE_GNNT"."C_LOGCATALOG" VALUES ('1051', '10', '内容审核日志');
INSERT INTO "TRADE_GNNT"."C_LOGCATALOG" VALUES ('1061', '10', '统计查询日志');
INSERT INTO "TRADE_GNNT"."C_LOGCATALOG" VALUES ('1071', '10', '商品管理日志');
INSERT INTO "TRADE_GNNT"."C_LOGCATALOG" VALUES ('1091', '10', '代为交易员日志');
INSERT INTO "TRADE_GNNT"."C_LOGCATALOG" VALUES ('1101', '11', '凭证管理日志');
INSERT INTO "TRADE_GNNT"."C_LOGCATALOG" VALUES ('1102', '11', '帐务查询日志');
INSERT INTO "TRADE_GNNT"."C_LOGCATALOG" VALUES ('1103', '11', '交易商资金日志');
INSERT INTO "TRADE_GNNT"."C_LOGCATALOG" VALUES ('1104', '11', '帐务维护日志');
INSERT INTO "TRADE_GNNT"."C_LOGCATALOG" VALUES ('1300', '13', '交易核心错误日志');
INSERT INTO "TRADE_GNNT"."C_LOGCATALOG" VALUES ('1301', '13', '交易核心信息日志');
INSERT INTO "TRADE_GNNT"."C_LOGCATALOG" VALUES ('1310', '13', '仓单管理日志');
INSERT INTO "TRADE_GNNT"."C_LOGCATALOG" VALUES ('1320', '13', '仓库管理日志');
INSERT INTO "TRADE_GNNT"."C_LOGCATALOG" VALUES ('3201', '32', '前台登录管理');
INSERT INTO "TRADE_GNNT"."C_LOGCATALOG" VALUES ('3202', '32', '前台修改密码管理');
INSERT INTO "TRADE_GNNT"."C_LOGCATALOG" VALUES ('3203', '32', '后台登录管理');
INSERT INTO "TRADE_GNNT"."C_LOGCATALOG" VALUES ('3204', '32', '后台修改密码');
INSERT INTO "TRADE_GNNT"."C_LOGCATALOG" VALUES ('1901', '19', '加盟商后台日志');
INSERT INTO "TRADE_GNNT"."C_LOGCATALOG" VALUES ('1910', '19', '加盟商前台公用日志');
INSERT INTO "TRADE_GNNT"."C_LOGCATALOG" VALUES ('1915', '19', '加盟商前台订单日志');
INSERT INTO "TRADE_GNNT"."C_LOGCATALOG" VALUES ('1501', '15', '订单交易核心信息日志');
INSERT INTO "TRADE_GNNT"."C_LOGCATALOG" VALUES ('1502', '15', '订单交易核心错误日志');
INSERT INTO "TRADE_GNNT"."C_LOGCATALOG" VALUES ('1503', '15', '订单运营管理日志');
INSERT INTO "TRADE_GNNT"."C_LOGCATALOG" VALUES ('1504', '15', '订单交易参数设置日志');
INSERT INTO "TRADE_GNNT"."C_LOGCATALOG" VALUES ('1505', '15', '订单交易商设置日志');
INSERT INTO "TRADE_GNNT"."C_LOGCATALOG" VALUES ('1506', '15', '订单数据查询日志');
INSERT INTO "TRADE_GNNT"."C_LOGCATALOG" VALUES ('1507', '15', '订单统计报表日志');
INSERT INTO "TRADE_GNNT"."C_LOGCATALOG" VALUES ('1508', '15', '订单交收管理日志');
INSERT INTO "TRADE_GNNT"."C_LOGCATALOG" VALUES ('1509', '15', '订单风险监控日志');
INSERT INTO "TRADE_GNNT"."C_LOGCATALOG" VALUES ('1510', '15', '订单市场交易操作日志');
INSERT INTO "TRADE_GNNT"."C_LOGCATALOG" VALUES ('1511', '15', '订单强制减仓日志');
INSERT INTO "TRADE_GNNT"."C_LOGCATALOG" VALUES ('1512', '15', '订单系统维护日志');
INSERT INTO "TRADE_GNNT"."C_LOGCATALOG" VALUES ('1513', '15', '订单延期交收日志');
INSERT INTO "TRADE_GNNT"."C_LOGCATALOG" VALUES ('1514', '15', '订单加盟商佣金查询日志');
INSERT INTO "TRADE_GNNT"."C_LOGCATALOG" VALUES ('9901', '99', '公用系统日志');
INSERT INTO "TRADE_GNNT"."C_LOGCATALOG" VALUES ('2300', '23', '交易核心错误日志');
INSERT INTO "TRADE_GNNT"."C_LOGCATALOG" VALUES ('2301', '23', '交易核心信息日志');
INSERT INTO "TRADE_GNNT"."C_LOGCATALOG" VALUES ('2304', '23', '仲裁日志');
INSERT INTO "TRADE_GNNT"."C_LOGCATALOG" VALUES ('2305', '23', '资金处理日志');
INSERT INTO "TRADE_GNNT"."C_LOGCATALOG" VALUES ('2306', '23', '运营管理日志');
INSERT INTO "TRADE_GNNT"."C_LOGCATALOG" VALUES ('2307', '23', '参数设置日志');
INSERT INTO "TRADE_GNNT"."C_LOGCATALOG" VALUES ('2308', '23', '商品管理日志');
INSERT INTO "TRADE_GNNT"."C_LOGCATALOG" VALUES ('2309', '23', '交易日志');
INSERT INTO "TRADE_GNNT"."C_LOGCATALOG" VALUES ('2310', '23', '商铺管理日志');
INSERT INTO "TRADE_GNNT"."C_LOGCATALOG" VALUES ('2320', '23', '统计查询日志');
INSERT INTO "TRADE_GNNT"."C_LOGCATALOG" VALUES ('2101', '21', '竞价核心信息日志');
INSERT INTO "TRADE_GNNT"."C_LOGCATALOG" VALUES ('2102', '21', '竞价核心错误日志');
INSERT INTO "TRADE_GNNT"."C_LOGCATALOG" VALUES ('2103', '21', '竞价交易系统管理日志');
INSERT INTO "TRADE_GNNT"."C_LOGCATALOG" VALUES ('2104', '21', '竞价交易商设置日志');
INSERT INTO "TRADE_GNNT"."C_LOGCATALOG" VALUES ('2105', '21', '竞价商品管理日志');
INSERT INTO "TRADE_GNNT"."C_LOGCATALOG" VALUES ('2106', '21', '竞价交易查询日志');
INSERT INTO "TRADE_GNNT"."C_LOGCATALOG" VALUES ('2107', '21', '竞价报表查询日志');
INSERT INTO "TRADE_GNNT"."C_LOGCATALOG" VALUES ('2108', '21', '竞价合同管理日志');

-- ----------------------------
-- Table structure for C_MARKETINFO
-- ----------------------------
DROP TABLE "TRADE_GNNT"."C_MARKETINFO";
CREATE TABLE "TRADE_GNNT"."C_MARKETINFO" (
"INFONAME" VARCHAR2(128 BYTE) NOT NULL ,
"INFOVALUE" VARCHAR2(128 BYTE) NOT NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;

-- ----------------------------
-- Records of C_MARKETINFO
-- ----------------------------
INSERT INTO "TRADE_GNNT"."C_MARKETINFO" VALUES ('JMSBrokerURL', 'tcp://10.0.100.181:20071');
INSERT INTO "TRADE_GNNT"."C_MARKETINFO" VALUES ('abbreviation', 'yrdce');
INSERT INTO "TRADE_GNNT"."C_MARKETINFO" VALUES ('copyrightof', '长三角商品交易所信息技术中心');
INSERT INTO "TRADE_GNNT"."C_MARKETINFO" VALUES ('frontIsNeedKey', 'N');
INSERT INTO "TRADE_GNNT"."C_MARKETINFO" VALUES ('marketEmail', 'service@yrdce.com');
INSERT INTO "TRADE_GNNT"."C_MARKETINFO" VALUES ('marketNO', '0');
INSERT INTO "TRADE_GNNT"."C_MARKETINFO" VALUES ('marketName', '长三角商品交易所');
INSERT INTO "TRADE_GNNT"."C_MARKETINFO" VALUES ('marketPhone', '13888888888');
INSERT INTO "TRADE_GNNT"."C_MARKETINFO" VALUES ('mgrIsNeedKey', 'N');
INSERT INTO "TRADE_GNNT"."C_MARKETINFO" VALUES ('warehouseIsNeedKey', 'N');

-- ----------------------------
-- Table structure for C_MYMENU
-- ----------------------------
DROP TABLE "TRADE_GNNT"."C_MYMENU";
CREATE TABLE "TRADE_GNNT"."C_MYMENU" (
"USERID" VARCHAR2(32 BYTE) NOT NULL ,
"RIGHTID" NUMBER(10) NOT NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;

-- ----------------------------
-- Records of C_MYMENU
-- ----------------------------

-- ----------------------------
-- Table structure for C_RIGHT
-- ----------------------------
DROP TABLE "TRADE_GNNT"."C_RIGHT";
CREATE TABLE "TRADE_GNNT"."C_RIGHT" (
"ID" NUMBER(10) NOT NULL ,
"PARENTID" NUMBER(10) NULL ,
"NAME" VARCHAR2(128 BYTE) NULL ,
"ICON" VARCHAR2(128 BYTE) NULL ,
"AUTHORITYURL" VARCHAR2(512 BYTE) NULL ,
"VISITURL" VARCHAR2(512 BYTE) NULL ,
"MODULEID" NUMBER(2) NOT NULL ,
"SEQ" NUMBER(3) NULL ,
"VISIBLE" NUMBER(1) NULL ,
"TYPE" NUMBER(1) NOT NULL ,
"CATALOGID" NUMBER(4) NULL ,
"ISWRITELOG" VARCHAR2(1 BYTE) DEFAULT 'N'  NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON COLUMN "TRADE_GNNT"."C_RIGHT"."ID" IS ' 规范：
1：开头两位为系统模块号
2: 第三四位为一级菜单
3：第五六位为二级菜单
4：第七八位为三级菜单
5：第九十位为页面中的增删改查
';
COMMENT ON COLUMN "TRADE_GNNT"."C_RIGHT"."PARENTID" IS '父关联';
COMMENT ON COLUMN "TRADE_GNNT"."C_RIGHT"."NAME" IS '权限名称';
COMMENT ON COLUMN "TRADE_GNNT"."C_RIGHT"."ICON" IS '图标';
COMMENT ON COLUMN "TRADE_GNNT"."C_RIGHT"."AUTHORITYURL" IS '权限路径';
COMMENT ON COLUMN "TRADE_GNNT"."C_RIGHT"."VISITURL" IS '真实路径';
COMMENT ON COLUMN "TRADE_GNNT"."C_RIGHT"."MODULEID" IS '10综合管理平台
11财务系统
12监管仓库管理系统
13仓单管理系统
14融资系统
15订单交易
18投资类大宗商品交易系统
19加盟会员管理系统
20做市商交易系统
21竞价系统
22银行接入及结算系统
23E现货
24单点登录系统
25实时行情分析系统
26交易客户端
98demo系统
99公用系统';
COMMENT ON COLUMN "TRADE_GNNT"."C_RIGHT"."SEQ" IS '序号';
COMMENT ON COLUMN "TRADE_GNNT"."C_RIGHT"."VISIBLE" IS '是否可见-1 不可见0 可见';
COMMENT ON COLUMN "TRADE_GNNT"."C_RIGHT"."TYPE" IS '类型-3:只检查session不检查权限的url -2：无需判断权限的URL -1： 父菜单类型 0：子菜单类型 1：页面内增删改查权限';
COMMENT ON COLUMN "TRADE_GNNT"."C_RIGHT"."CATALOGID" IS '日志类型 0不写日志 其它对应表c_logcatalog 的CATALOGID字段';
COMMENT ON COLUMN "TRADE_GNNT"."C_RIGHT"."ISWRITELOG" IS '''Y''：写日志、''N''：不写日志';

-- ----------------------------
-- Records of C_RIGHT
-- ----------------------------
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('9901000001', '-1', '登录页面', null, '/mgr/logon.jsp', null, '99', '1', '0', '-2', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('9901000002', '-1', '验证码', null, '/mgr/public/jsp/logoncheckimage.jsp', null, '99', '2', '0', '-2', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('9901000003', '-1', '最外围页面', null, '/mgr/frame/framepage.jsp', null, '99', '3', '0', '-3', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('9901000004', '-1', '没有头部的主页面', null, '/mgr/frame/mainframe_nohead.jsp', null, '99', '4', '0', '-3', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('9901000005', '-1', '请等待页面', null, '/mgr/frame/waiting.jsp', null, '99', '5', '0', '-3', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('9901000006', '-1', '无权限页面', null, '/mgr/public/jsp/noright.jsp', null, '99', '6', '0', '-2', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('9901000007', '-1', 'session失效页面', null, '/mgr/public/jsp/nosession.jsp', null, '99', '7', '0', '-2', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('9901000008', '-1', '错误页面', null, '/mgr/public/jsp/error.jsp', null, '99', '8', '0', '-3', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('9901000009', '-1', '存放用户AU系统中sessionID', null, '/mgr/public/jsp/session.jsp', null, '99', '9', '0', '-3', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('9901000010', '-1', '主页面', null, '/mgr/frame/mainframe.jsp', null, '99', '10', '0', '-3', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('9901000011', '-1', '靠上页面', null, '/mgr/frame/topframe.jsp', null, '99', '11', '0', '-3', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('9901000012', '-1', '展示主页面', null, '/mgr/frame/rightframe.jsp', null, '99', '12', '0', '-3', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('9901000013', '-1', '展示上页面', null, '/mgr/frame/rightframe_top.jsp', null, '99', '13', '0', '-3', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('9901000014', '-1', '展示下页面', null, '/mgr/frame/rightframe_bottom.jsp', null, '99', '14', '0', '-3', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('9901000015', '-1', '分栏页面', null, '/mgr/frame/shrinkbar.jsp', null, '99', '15', '0', '-3', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('9901000016', '-1', '菜单显示页面', null, '/mgr/frame/leftMenu.jsp', null, '99', '16', '0', '-3', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('9901000017', '-1', '菜单页面', null, '/menu/menuList.action', null, '99', '17', '0', '-3', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('9901000018', '-1', '快捷菜单设置跳转', null, '/myMenu/getMyMenu.action', null, '99', '18', '0', '-3', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('9901000019', '-1', '快捷菜单设置修改', null, '/myMenu/updateMyMenu.action', null, '99', '19', '0', '-3', '9901', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('9901000020', '-1', 'activemq访问路径', null, '/amq', null, '99', '20', '0', '-3', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('9901000021', '-1', '登陆', null, '/user/logon.action', null, '99', '21', '0', '-2', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('9901000022', '-1', '用户退出', null, '/user/logout.action', null, '99', '22', '0', '-2', '9901', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('9901000023', '-1', '修改风格页面', null, '/mgr/frame/shinstyle.jsp', null, '99', '23', '0', '-3', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('9901000024', '-1', '修改风格', null, '/user/saveShinStyle.action', null, '99', '24', '0', '-3', '9901', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('9901000025', '-1', '修改登录密码跳转', null, '/self/passwordSelfMod.action', null, '99', '25', '0', '-3', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('9901000026', '-1', '修改登录密码', null, '/self/passwordSelfSave.action', null, '99', '26', '0', '-3', '9901', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('9901000027', '-1', '查询数据库时间', null, '/sysDate/getDate.action', null, '99', '27', '0', '-3', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('9901000041', '-1', '主页面', null, '/mgr/frame/commonmenu/mainframe.jsp', null, '99', '41', '0', '-3', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('9901000042', '-1', '靠上页面', null, '/mgr/frame/commonmenu/topframe.jsp', null, '99', '42', '0', '-3', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('9901000043', '-1', '最外围页面', null, '/mgr/frame/commonmenu/framepage.jsp', null, '99', '43', '0', '-3', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('9901000044', '-1', '所有系统退出页面', null, '/mgr/public/jsp/logoutall.jsp', null, '99', '44', '0', '-2', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1101010600', '1101010000', '已结算凭证查询', '29_29.gif', '/finance/voucher/voucherHistoryList.action', '/finance/voucher/voucherHistoryList.action', '11', '6', '0', '0', '1101', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1101010601', '1101010600', '查看凭证', null, '/finance/voucher/view*', null, '11', '1', '0', '1', '1101', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1101020100', '1101020000', '分类账', '29_29.gif', '/finance/financialQuery/*', '/finance/financialQuery/ledger.action', '11', '1', '0', '0', '1102', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1101020200', '1101020000', '分类账合计', '29_29.gif', '/finance/financialQuery/*', '/finance/financialQuery/ledgerSum.action', '11', '2', '0', '0', '1102', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1101020300', '1101020000', '账簿查询', '29_29.gif', '/finance/financialQuery/*', '/finance/financialQuery/ledgerQuery.action?sortColumns=order+by+bdate', '11', '3', '0', '0', '1102', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1101020400', '1101020000', '结算查询', '29_29.gif', '/finance/financialQuery/*', '/finance/financialQuery/balanceQuery.action', '11', '4', '0', '0', '1102', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1101020500', '1101020000', '结算日报表', '29_29.gif', '/finance/financialQuery/*', '/finance/financialQuery/balanceDayReport.action', '11', '5', '0', '0', '1102', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1101020501', '1101020500', '列表权限', null, '/finance/financialQuery/list*', null, '11', '1', '0', '1', '1102', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1101030100', '1101030000', '交易商当前资金', '29_29.gif', '/finance/firmfunds/firmcurfunds.action', '/finance/firmfunds/firmcurfunds.action?sortColumns=order+by+firmId', '11', '1', '0', '0', '1103', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1101030101', '1101030100', '交易商资金详情', '29_29.gif', '/finance/firmfunds/fundsdetail.action', '/finance/firmfunds/fundsdetail.action', '11', '1', '0', '0', '1103', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1101030200', '1101030000', '交易商资金流水', '29_29.gif', '/finance/firmfunds/firmfundflow.action', '/finance/firmfunds/firmfundflow.action?sortColumns=order+by+fundFlowId+desc', '11', '2', '0', '0', '1103', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1101030300', '1101030000', '交易商总账单', '29_29.gif', '/finance/firmfunds/clientLedger.action', '/finance/firmfunds/clientLedger.action?sortColumns=order+by+b_Date', '11', '3', '0', '0', '1103', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1101030400', '1101030000', '交易商总账单合计', '29_29.gif', '/finance/firmfunds/clientLedgerSum.action', '/finance/firmfunds/clientLedgerSum.action', '11', '4', '0', '0', '1103', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1101040100', '1101040000', '快捷录入模板', '29_29.gif', '/finance/financialVindicate/voucherModelList.action', '/finance/financialVindicate/voucherModelList.action?sortColumns=order+by+code', '11', '1', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1101040101', '1101040100', '模板详情', null, '/finance/financialVindicate/voucherModelDetails.action', null, '11', '1', '0', '1', '1104', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1101040102', '1101040100', '添加模板', null, '/finance/financialVindicate/addVoucherModel*', null, '11', '2', '0', '1', '1104', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1101040103', '1101040101', '修改模板', null, '/finance/financialVindicate/update*', null, '11', '3', '0', '1', '1104', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1101040104', '1101040100', '删除模板', null, '/finance/financialVindicate/delete*', null, '11', '4', '0', '1', '1104', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1101040200', '1101040000', '财务结算', '29_29.gif', '/mgr/app/finance/clearStatus/balance.jsp', '/mgr/app/finance/clearStatus/balance.jsp', '11', '2', '0', '0', '1104', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1101040205', '1101040200', '结算', null, '/finance/clearStatus/financeBalance.action', null, '11', '1', '0', '1', '1104', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1101040206', '1101040200', '查看结算状态列表', null, '/finance/clearStatus/clearStatusList.action', null, '11', '2', '0', '1', '1104', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1101040207', '1101040200', '查看结算详情状态', null, '/ajaxcheckVoucherModel/voucherModel/getStatusJson.action', null, '11', '3', '0', '1', '1104', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1101040208', '1101040200', '查看结算状态', null, '/mgr/app/finance/clearStatus/financeBalance.jsp', null, '11', '4', '0', '1', '1104', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1101040300', '1101040000', '摘要维护', '29_29.gif', '/finance/summary/summaryList.action', '/finance/summary/summaryList.action?sortColumns=order+by+summaryNo', '11', '3', '0', '0', '1104', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1101040301', '1101040300', '摘要详情', null, '/finance/summary/summaryDetails.action', null, '11', '1', '0', '1', '1104', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1101040302', '1101040300', '添加摘要', null, '/finance/summary/addSummary*', null, '11', '2', '0', '1', '1104', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1101040303', '1101040301', '修改摘要', null, '/finance/summary/update*', null, '11', '3', '0', '1', '1104', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1101040304', '1101040300', '删除摘要', null, '/finance/summary/delete*', null, '11', '4', '0', '1', '1104', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1101040400', '1101040000', '科目维护', '29_29.gif', '/finance/account/accountList.action', '/finance/account/accountList.action?sortColumns=order+by+code', '11', '4', '0', '0', '1104', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1101040401', '1101040400', '科目详情', null, '/finance/account/accountDetails.action', null, '11', '1', '0', '1', '1104', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1101040402', '1101040400', '添加科目', null, '/finance/account/addAccount*', null, '11', '2', '0', '1', '1104', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1101040403', '1101040401', '修改科目', null, '/finance/account/update*', null, '11', '3', '0', '1', '1104', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1101040404', '1101040400', '删除科目', null, '/finance/account/delete*', null, '11', '4', '0', '1', '1104', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1301000000', '9900000000', '仓单及仓库管理', null, null, null, '13', '1', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1301010000', '1301000000', '仓单管理', '42_42.gif', null, null, '13', '1', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1301010100', '1301010000', '未注册仓单列表', '29_29.gif', '/stock/list/*', '/stock/list/stockList.action?sortColumns=order+by+stockId', '13', '1', '0', '0', '1310', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1301010101', '1301010100', '仓单添加权限', null, '/stock/list/add*', null, '13', '1', '0', '1', '1310', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1301010102', '1301010100', '查看品名权限', null, '/stock/addStock/jsonForStock/getBreedByCategoryID.action', '/stock/addStock/jsonForStock/getBreedByCategoryID.action', '13', '2', '0', '1', '1310', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1301010103', '1301010100', '查看属性权限', null, '/stock/addStock/jsonForStock/getPropertyValueByBreedID.action', '/stock/addStock/jsonForStock/getPropertyValueByBreedID.action', '13', '3', '0', '1', '1310', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1301010104', '1301010100', '仓单注册权限', null, '/stock/list/registerStock.action', '/stock/list/registerStock.action', '13', '4', '0', '1', '1310', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1301010105', '1301010100', '仓单出库跳转', null, '/stock/list/forwardStockOut.action', '/stock/list/forwardStockOut.action', '13', '5', '0', '1', '1310', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1301010106', '1301010105', '仓单出库权限', null, '/stock/list/stockOut.action', '/stock/list/stockOut.action', '13', '6', '0', '1', '1310', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1301010107', '1301010100', '查看权限', null, '/stock/list/stockDetails.action', null, '13', '7', '0', '1', '1310', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1301010108', '1301010100', '拆单跳转权限', null, '/stock/list/forwardDismantleStock.action', null, '13', '8', '0', '1', '1310', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1301010109', '1301010100', '拆单操作权限', null, '/stock/list/dismantleStock.action', null, '13', '9', '0', '1', '1310', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1301010200', '1301010000', '注册仓单列表', '29_29.gif', '/stock/registerlist/*', '/stock/registerlist/stockList.action?sortColumns=order+by+stockId', '13', '2', '0', '0', '1310', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1301010201', '1301010200', '仓单注销权限', null, '/stock/registerlist/logoutStock.action', '/stock/registerlist/logoutStock.action', '13', '1', '0', '1', '1310', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1301010202', '1301010200', '查看权限', null, '/stock/list/stockDetails.action', null, '13', '2', '0', '1', '1310', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1301010300', '1301010000', '出库单列表', '29_29.gif', '/stock/exitlist/*', '/stock/exitlist/stockListHxx.action?sortColumns=order+by+stockId&isQueryDB=true', '13', '3', '0', '0', '1310', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1301010301', '1301010300', '查看权限', null, '/stock/list/stockDetails.action', null, '13', '1', '0', '1', '1310', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1301010400', '1301010000', '已拆仓单列表', '29_29.gif', '/stock/dismantlelist/*', '/stock/dismantlelist/stockDismantleList.action?sortColumns=order+by+dismantleId&isQueryDB=true', '13', '4', '0', '0', '1310', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1301010401', '1301010400', '查看权限', null, '/stock/list/stockDetails.action', null, '13', '1', '0', '1', '1310', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1301010402', '1301010400', '查看拆仓单权限', null, '/stock/dismantlelist/dismantleDetails.action', null, '13', '2', '0', '1', '1310', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1301010500', '1301010000', '仓单日志查询', '29_29.gif', '/stock/log/*', '/stock/log/list.action?sortColumns=order+by+createTime&isQueryDB=true', '13', '5', '0', '0', '1310', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1301020000', '1301000000', '仓单业务', '42_42.gif', null, null, '13', '2', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1301020100', '1301020000', '拆单申请管理', '29_29.gif', '/stockoperation/apart/*', '/stockoperation/apart/list.action?sortColumns=order+by+id', '13', '1', '0', '0', '1310', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1301020101', '1301020100', '拆单权限', null, '/stockoperation/apart/updateStockDispose.action', null, '13', '1', '0', '1', '1310', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1301020102', '1301020101', '拆单成功权限', null, '/stockoperation/apart/updateDisposeSuccess.action', null, '13', '2', '0', '1', '1310', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1301020103', '1301020101', '拆单失败权限', null, '/stockoperation/apart/updateDisposeFail.action', null, '13', '3', '0', '1', '1310', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1301020104', '1301020100', '查看权限', null, '/stockoperation/apart/stockDetails.action', null, '13', '4', '0', '1', '1310', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1301020210', '1301020000', '融资仓单', '29_29.gif', '/stockoperation/financing/*', '/stockoperation/financing/list.action?sortColumns=order+by+id&isQueryDB=true', '13', '2', '0', '0', '1310', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1301020211', '1301020210', '查看权限', null, '/stockoperation/financing/stockDetails.action', null, '13', '1', '0', '1', '1310', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1301020310', '1301020000', '卖仓单', '29_29.gif', '/stockoperation/sell/*', '/stockoperation/sell/list.action?sortColumns=order+by+id&isQueryDB=true', '13', '3', '0', '0', '1310', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1301020311', '1301020310', '查看权限', null, '/stockoperation/sell/stockDetails.action', null, '13', '1', '0', '1', '1310', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1301020410', '1301020000', '交收仓单', '29_29.gif', '/stockoperation/settlement/*', '/stockoperation/settlement/list.action?sortColumns=order+by+id&isQueryDB=true', '13', '4', '0', '0', '1310', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1301020510', '1301020000', '冻结仓单', '29_29.gif', '/stockoperation/frozen/*', '/stockoperation/frozen/list.action?sortColumns=order+by+id&isQueryDB=true', '13', '5', '0', '0', '1310', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1301020511', '1301020510', '查看权限', null, '/stockoperation/frozen/stockDetails.action', null, '13', '1', '0', '1', '1310', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1301020411', '1301020410', '交收仓单查看权限', null, '/stockoperation/settlement/stockDetails.action', null, '13', '1', '0', '1', '1310', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1301030000', '1301000000', '仓库管理', '42_42.gif', null, null, '13', '3', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1301030100', '1301030000', '仓库维护', '29_29.gif', '/stock/warehouse/*', '/stock/warehouse/list.action?sortColumns=order+by+id+desc', '13', '1', '0', '0', '1320', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1301030101', '1301030100', '查看权限', null, '/stock/warehouse/forwardUpdate.action', null, '13', '1', '0', '1', '1320', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1301030102', '1301030100', '添加权限', null, '/stock/warehouse/add*', null, '13', '2', '0', '1', '1320', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1301030103', '1301030101', '修改权限', null, '/stock/warehouse/update.action', null, '13', '3', '0', '1', '1320', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1301030104', '1301030100', '删除权限', null, '/stock/warehouse/delete.action', null, '13', '4', '0', '1', '1320', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1201020600', '1301020000', '出库仓单申请列表', '29_29.gif', '/stock/exitlist/*', '/stock/exitlist/stockOutApplyList.action?sortColumns=order+by+stockId&isQueryDB=true', '13', '6', '0', '0', '1310', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1201020601', '1201020600', '仓单出库跳转权限', null, '/stock/exitlist/stockOutForward.action', null, '13', '1', '0', '1', '1320', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1201020602', '1201020600', '撤销仓单出库申请', null, '/stock/exitlist/stockOutCancel.action', null, '13', '2', '0', '1', '1320', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1201020603', '1201020600', '仓单出库权限', null, '/stock/exitlist/stockOutReal.action', null, '13', '3', '0', '1', '1320', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1201030105', '1301030100', '添加仓库管理员权限', null, '/stock/warehouseUser/add*', null, '13', '5', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1201030106', '1301030100', '修改仓库管理员密码权限', null, '/stock/warehouseUser/update*', null, '13', '6', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1201030200', '1301030000', '仓库管理员操作日志', '29_29.gif', '/warehouse/log/*', '/warehouse/log/operList.action?sortColumns=order+by+createTime&isQueryDB=true', '13', '1', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1201030300', '1301030000', '仓库管理员登录日志', '29_29.gif', '/warehouse/log/*', '/warehouse/log/logonList.action?sortColumns=order+by+createTime&isQueryDB=true', '13', '1', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1901000000', '9900000000', '加盟商', null, null, null, '19', '0', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1901010000', '1901000000', '参数设置', '42_42.gif', null, null, '19', '1', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1901020000', '1901000000', '加盟商管理', '42_42.gif', null, null, '19', '2', '0', '-1', '1901', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1901030000', '1901000000', '佣金查询', '42_42.gif', null, null, '19', '3', '0', '-1', '1901', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1901010100', '1901010000', '付佣金参数设置', '29_29.gif', '/config/ready/readyParamList.action', '/config/ready/readyParamList.action', '19', '1', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1901010200', '1901010000', '默认佣金设置', '29_29.gif', '/config/default/defaultParamList.action', '/config/default/defaultParamList.action', '19', '2', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1901010300', '1901010000', '特殊佣金设置', '29_29.gif', '/config/special/specialParamList.action', '/config/special/specialParamList.action', '19', '3', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1901020100', '1901020000', '加盟商区域设置', '29_29.gif', '/broker/brokerManagement/listBrokerArea/*', '/broker/brokerManagement/listBrokerArea.action?sortColumns=order+by+areaId+asc', '19', '1', '0', '0', '1901', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1901020200', '1901020000', '加盟商设置', '29_29.gif', '/broker/brokerManagement/listBroker/*', '/broker/brokerManagement/listBroker.action', '19', '2', '0', '0', '1901', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1901030100', '1901030000', '待付佣金', '29_29.gif', '/broker/brokerDataquery/listBrokerReward/*', '/broker/brokerDataquery/listBrokerReward.action', '19', '1', '0', '0', '1901', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1901010101', '1901010100', '修改权限', null, '/config/ready/update*', null, '19', '1', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1901010201', '1901010200', '查看权限', null, '/config/default/detail*', null, '19', '1', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1901010202', '1901010200', '修改权限', null, '/config/default/update*', null, '19', '2', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1901010301', '1901010300', '添加权限', null, '/config/special/add*', null, '19', '1', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1901010302', '1901010300', '查看权限', null, '/config/special/detail*', null, '19', '2', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1901010303', '1901010300', '修改权限', null, '/config/special/update*', null, '19', '3', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1901010304', '1901010300', '删除权限', null, '/config/special/delete*', null, '19', '4', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1901020101', '1901020100', '添加权限', null, '/broker/brokerManagement/addBrokerArea*', null, '19', '1', '0', '1', '1901', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1901020102', '1901020100', '查看权限', null, '/broker/brokerManagement/detailBrokerArea*', null, '19', '2', '0', '1', '1901', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1901020103', '1901020100', '修改权限', null, '/broker/brokerManagement/updateBrokerArea*', null, '19', '3', '0', '1', '1901', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1901020104', '1901020100', '删除权限', null, '/broker/brokerManagement/deleteBrokerArea*', null, '19', '4', '0', '1', '1901', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1901020201', '1901020200', '添加权限', null, '/broker/brokerManagement/addBroker*', null, '19', '1', '0', '1', '1901', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1901020202', '1901020200', '查看权限', null, '/broker/brokerManagement/detailBroker*', null, '19', '2', '0', '1', '1901', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1901020203', '1901020200', '修改权限', null, '/broker/brokerManagement/updateBroker*', null, '19', '3', '0', '1', '1901', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1901020204', '1901020200', '删除权限', null, '/broker/brokerManagement/deleteBroker*', null, '19', '4', '0', '1', '1901', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1901030101', '1901030100', '修改权限', null, '/broker/brokerDataquery/updateBrokerReward*', null, '19', '1', '0', '1', '1901', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501000000', '9900000000', '订单交易', null, null, null, '15', '0', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501010000', '1501000000', '运营管理', '42_42.gif', null, null, '15', '1', '0', '-1', '1503', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501020000', '1501000000', '交易参数设置', '42_42.gif', null, null, '15', '2', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501030000', '1501000000', '交易商设置', '42_42.gif', null, null, '15', '3', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501040000', '1501000000', '数据查询', '42_42.gif', null, null, '15', '4', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501050000', '1501000000', '统计报表', '42_42.gif', null, null, '15', '6', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501060000', '1501000000', '交收管理', '42_42.gif', null, null, '15', '7', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501070000', '1501000000', '风险监控', '42_42.gif', null, null, '15', '8', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501080000', '1501000000', '市场交易操作', '42_42.gif', null, null, '15', '9', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501090000', '1501000000', '强制减仓', '42_42.gif', null, null, '15', '10', '0', '-1', '1511', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501100000', '1501000000', '系统维护', '42_42.gif', null, null, '15', '11', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501110000', '1501000000', '延期交易', '42_42.gif', null, null, '15', '12', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501140000', '1501000000', '加盟商查询', '42_42.gif', null, null, '15', '5', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501010200', '1501010000', '结算处理', '29_29.gif', '/mgr/app/timebargain/trademanager/tradeEnd.jsp', '/mgr/app/timebargain/trademanager/tradeEnd.jsp', '15', '2', '0', '0', '1503', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501010100', '1501010000', '交易状态管理', '29_29.gif', '/timebargain/tradeManager/*', '/timebargain/tradeManager/tradeStatus.action', '15', '1', '0', '0', '1503', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1000000001', '-1', '商品展示树右栏', null, '/mgr/app/integrated/category/rightframe.jsp', null, '10', '1', '0', '-2', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1000000002', '-1', '商品展示树分栏', null, '/mgr/app/integrated/category/shrinkbar.jsp', null, '10', '2', '0', '-2', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1000000003', '-1', '商品展示树主框架', null, '/mgr/app/integrated/category/mainframe.jsp', null, '10', '3', '0', '-2', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1000000004', '-1', '品名展示树右栏', null, '/mgr/app/integrated/breed/rightframe.jsp', null, '10', '4', '0', '-2', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1000000005', '-1', '品名展示树分栏', null, '/mgr/app/integrated/breed/shrinkbar.jsp', null, '10', '5', '0', '-2', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1000000006', '-1', '品名展示树主框架', null, '/mgr/app/integrated/breed/mainframe.jsp', null, '10', '6', '0', '-2', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001000000', '9900000000', '用户管理', null, null, null, '10', '1', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001010000', '1001000000', '交易用户', '10_10.gif', null, null, '10', '1', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001010100', '1001010000', '交易商注册审核', '10_101.gif', '/trade/mfirm/*', '/trade/mfirm/mfirmApplyList.action?sortColumns=order+by+createTime+desc', '10', '1', '0', '0', '1021', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001010101', '1001010100', '交易商申请详情', null, '/trade/mfirm/forword*', null, '10', '1', '0', '1', '1021', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001010102', '1001010100', '交易商申请通过', null, '/trade/mfirm/auditPass.action', null, '10', '2', '0', '1', '1021', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001010103', '1001010100', '交易商审核不通过', null, '/trade/mfirm/auditUnPass.action', null, '10', '3', '0', '1', '1021', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001010200', '1001010000', '交易商列表', '10_102.gif', '/trade/mfirm/*', '/trade/mfirm/list.action?sortColumns=order+by+createtime+desc', '10', '2', '0', '0', '1021', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001010201', '1001010200', '冻结交易商', null, '/trade/mfirm/freeze.action', null, '10', '1', '0', '1', '1021', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001010202', '1001010200', '添加交易商权限', null, '/trade/mfirm/add*', null, '10', '2', '0', '1', '1021', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001010203', '1001010200', '查看交易商权限', null, '/trade/mfirm/updateForwardMfirm.action', null, '10', '3', '0', '1', '1021', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001010204', '1001010203', '修改交易商', null, '/trade/mfirm/updateMfirm.action', null, '10', '4', '0', '1', '1021', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001010300', '1001010000', '添加交易商', '10_103.gif', '/trade/mfirm/addDirectForwardMfirm.action', '/trade/mfirm/addDirectForwardMfirm.action', '10', '3', '0', '0', '1021', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001010400', '1001010000', '已冻结交易商', '10_104.gif', '/trade/mfirm/*', '/trade/mfirm/freezeFirmList.action?sortColumns=order+by+createtime+desc', '10', '4', '0', '0', '1021', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001010401', '1001010400', '查看已冻结交易商权限', null, '/trade/mfirm/updateForwardMfirmDetails.action', null, '10', '1', '0', '1', '1021', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001010402', '1001010401', '解冻交易商', null, '/trade/mfirm/unfreeze.action', null, '10', '2', '0', '1', '1021', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001010403', '1001010400', '注销交易商', null, '/trade/mfirm/expurgate.action', null, '10', '3', '0', '1', '1021', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001010500', '1001010000', '已注销交易商', '10_105.gif', '/trade/mfirm/*', '/trade/mfirm/expurgateFirmList.action?sortColumns=order+by+createtime+desc&isQueryDB=true', '10', '5', '0', '0', '1021', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001010501', '1001010500', '查看已注销交易商权限', null, '/trade/mfirm/updateForwardMfirmDetails.action', null, '10', '1', '0', '1', '1021', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001010600', '1001010000', '交易员管理', '10_106.gif', '/trade/trader/*', '/trade/trader/list.action?sortColumns=order+by+createtime+desc', '10', '6', '0', '0', '1031', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001010601', '1001010600', '查看交易员权限', null, '/trade/trader/updateForwardTrader.action', null, '10', '1', '0', '1', '1031', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001010602', '1001010600', '禁止登录', null, '/trade/trader/forbideTrader.action', null, '10', '2', '0', '1', '1031', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001010603', '1001010600', '恢复登录', null, '/trade/trader/recoverTrader.action', null, '10', '3', '0', '1', '1031', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001010604', '1001010600', '查看交易员口令权限', null, '/trade/trader/updateForwardTraderCodes.action', null, '10', '4', '0', '1', '1031', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001010605', '1001010601', '修改交易员权限', null, '/trade/trader/updateTrader.action', null, '10', '5', '0', '1', '1031', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001010606', '1001010604', '修改交易员口令权限', null, '/trade/trader/updateTraderCodes.action', null, '10', '6', '0', '1', '1031', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001010607', '1001010600', '添加交易员', null, '/trade/trader/addTrader*', null, '10', '7', '0', '1', '1031', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001010700', '1001010000', '在线交易员', '10_107.gif', '/trade/trader/online/*', '/trade/trader/online/onlineList.action', '10', '7', '0', '0', '1031', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001010701', '1001010700', '强制在线交易员下线权限', null, '/trade/trader/online/downOnlineTrader.action', null, '10', '1', '0', '1', '1031', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001010800', '1001010000', '异常登录处理', '10_108.gif', '/trade/errorLogonLog/*', '/trade/errorLogonLog/list.action', '10', '8', '0', '0', '1031', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001010801', '1001010800', '查看异常登录权限', null, '/trade/errorLogonLog/getDetail.action', null, '10', '1', '0', '1', '1031', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001010802', '1001010800', '修改异常登录权限', null, '/trade/errorLogonLog/active*', null, '10', '2', '0', '1', '1031', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001010900', '1001010000', '交易商操作日志', '10_109.gif', '/logquery/mfirmLogQuery/*', '/logquery/mfirmLogQuery/mfirmlogList.action?sortColumns=order+by+occurTime+desc&isQueryDB=true', '10', '12', '0', '0', '1021', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001011000', '1001010000', '登录日志', '10_110.gif', '/logquery/queryOperateLogSearch/*', '/logquery/queryOperateLogSearch/frontList.action?sortColumns=order+by+operateTime+desc&isQueryDB=true', '10', '10', '0', '0', '1031', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001011100', '1001010000', '代为交易员管理', '10_111.gif', '/trade/agenttrader/*', '/trade/agenttrader/list.action?sortColumns=order+by+createtime+desc', '10', '9', '0', '0', '1091', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001011101', '1001011100', '添加代为交易员权限', null, '/trade/agenttrader/add*', null, '10', '3', '0', '1', '1091', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001011102', '1001011100', '查看代为交易员权限', null, '/trade/agenttrader/details*', null, '10', '1', '0', '1', '1091', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001011103', '1001011100', '删除代为交易员权限', null, '/trade/agenttrader/delete*', null, '10', '5', '0', '1', '1091', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001011104', '1001011100', '修改代为交易员权限', null, '/trade/agenttrader/update*', null, '10', '4', '0', '1', '1091', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001011105', '1001011100', '修改代为交易员密码权限', null, '/trade/agenttrader/updatePassword*', null, '10', '2', '0', '1', '1091', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001011106', '1001011100', '修改代为交易员跳转权限', null, '/trade/agenttrader/updateForward*', null, '10', '6', '0', '1', '1091', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001020000', '1001000000', '系统用户', '10_20.gif', null, null, '10', '2', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001020100', '1001020000', '角色管理', '10_201.gif', '/role/*', '/role/commonRoleList.action?sortColumns=order+by+id', '10', '1', '0', '0', '1001', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001020101', '1001020100', '添加角色', null, '/role/add*', null, '10', '1', '0', '1', '1001', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001020102', '1001020100', '修改角色', null, '/role/update*', null, '10', '2', '0', '1', '1001', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001020103', '1001020100', '删除角色', null, '/role/delete*', null, '10', '3', '0', '1', '1001', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001020200', '1001020000', '系统用户管理', '10_202.gif', '/user/*', '/user/list.action?sortColumns=order+by+userId', '10', '2', '0', '0', '1011', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001020201', '1001020200', '查看系统用户权限', null, '/user/forwardUpdate.action', null, '10', '1', '0', '1', '1011', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001020202', '1001020200', '添加系统用户权限', null, '/user/add*', null, '10', '2', '0', '1', '1011', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001020203', '1001020201', '修改系统用户权限', null, '/user/update.action', null, '10', '3', '0', '1', '1011', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001020204', '1001020200', '关联角色查看权限', null, '/user/forwardRelatedRight.action', null, '10', '4', '0', '1', '1011', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001020205', '1001020204', '关联角色修改权限', null, '/user/updateRelatedRight.action', null, '10', '5', '0', '1', '1011', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001020206', '1001020200', '系统用户密码查看权限', null, '/user/forwardUpdatePassword.action', null, '10', '6', '0', '1', '1011', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001020207', '1001020206', '系统用户密码修改权限', null, '/user/updatePassword.action', null, '10', '7', '0', '1', '1011', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001020300', '1001020000', '在线管理员', '10_203.gif', '/user/online/*', '/user/online/list.action', '10', '3', '0', '0', '1011', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001020301', '1001020300', '强制在线管理员下线权限', null, '/user/online/downOnlineUser.action', null, '10', '1', '0', '1', '1011', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001020400', '1001020000', '操作日志', '10_204.gif', '/logquery/queryOperateLogSearch/*', '/logquery/queryOperateLogSearch/list.action?sortColumns=order+by+operateTime+desc&isQueryDB=true', '10', '4', '0', '0', '1011', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001020500', '1001020000', '登录日志', '10_205.gif', '/logquery/queryOperateLogSearch/*', '/logquery/queryOperateLogSearch/mgrList.action?sortColumns=order+by+id&isQueryDB=true', '10', '5', '0', '0', '1011', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001020600', '1001020000', '后台管理日志', '10_502.gif', '/logquery/*', '/logquery/mgrManageLogList/list.action?sortColumns=order+by+id&isQueryDB=true', '10', '6', '0', '0', '1011', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001020700', '1001020000', '核心管理日志', '10_502.gif', '/logquery/*', '/logquery/coreManageLogList/list.action?sortColumns=order+by+id&isQueryDB=true', '10', '7', '0', '0', '1011', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001030000', '1001000000', '交易商属性字典', '42_42.gif', null, null, '10', '3', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001030100', '1001030000', '地域维护', '29_29.gif', '/mfirmAttribute/mainTenance/*', '/mfirmAttribute/mainTenance/zoneList.action?sortColumns=order+by+sortNo', '10', '1', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001030101', '1001030100', '地域添加权限', null, '/mfirmAttribute/mainTenance/add*', null, '10', '1', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001030102', '1001030100', '地域修改权限', null, '/mfirmAttribute/mainTenance/update*', null, '10', '2', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001030103', '1001030100', '地域删除权限', null, '/mfirmAttribute/mainTenance/delete*', null, '10', '3', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001030200', '1001030000', '行业维护', '29_29.gif', '/mfirmAttribute/mainTenance/*', '/mfirmAttribute/mainTenance/industryList.action?sortColumns=order+by+sortNo', '10', '2', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001030201', '1001030200', '行业添加权限', null, '/mfirmAttribute/mainTenance/add*', null, '10', '1', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001030202', '1001030200', '行业修改权限', null, '/mfirmAttribute/mainTenance/update*', null, '10', '2', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001030203', '1001030200', '行业删除权限', null, '/mfirmAttribute/mainTenance/delete*', null, '10', '3', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501010102', '1501010100', '修改恢复时间权限', '29_29.gif', '/timebargain/tradeManager/updateRecoverTime.action', null, '15', '2', '0', '1', '1503', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501010103', '1501010100', '修改恢复时间页面', '29_29.gif', '/timebargain/tradeManager/updateRecoverTimeToPage.action', null, '15', '3', '0', '1', '1503', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501010101', '1501010100', '修改状态权限', '29_29.gif', '/timebargain/tradeManager/updateTradeStatus.action', null, '15', '1', '0', '1', '1503', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501010203', '1501010200', '交易结算状态列表', null, '/timebargain/tradeManager/clearStatusList.action', null, '15', '3', '0', '1', '1503', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501010204', '1501010200', '交易结算', null, '/timebargain/tradeManager/tradeEnd.action', null, '15', '4', '0', '1', '1503', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501010201', '1501010200', '交易结算系统状态页面', null, '/mgr/app/timebargain/trademanager/tradeEndMarketStatus.jsp', null, '15', '1', '0', '1', '1503', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501020100', '1501020000', '交易市场参数', '29_29.gif', '/timebargain/tradeparams/marketList.action', '/timebargain/tradeparams/marketList.action', '15', '1', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501020200', '1501020000', '交易节管理', '29_29.gif', '/timebargain/tradeparams/tradeTimeList.action', '/timebargain/tradeparams/tradeTimeList.action?sortColumns=order+by+sectionID+asc', '15', '2', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501020300', '1501020000', '商品管理', '29_29.gif', '/timebargain/tradeparams/breedsList.action', '/timebargain/tradeparams/breedsList.action?sortColumns=order+by+breedID+asc', '15', '3', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501020400', '1501020000', '非交易日设置', '29_29.gif', '/timebargain/tradeparams/notTradeDayList.action', '/timebargain/tradeparams/notTradeDayList.action', '15', '4', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501020500', '1501020000', '手续费套餐', '29_29.gif', '/timebargain/tradeparams/tariffList.action', '/timebargain/tradeparams/tariffList.action', '15', '5', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501030100', '1501030000', '交易权限', '29_29.gif', '/timebargain/firmSet/tradePrivilege/*', '/timebargain/firmSet/tradePrivilege/tradePrivilege.action', '15', '1', '0', '0', '1505', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501030101', '1501030100', '选项卡权限', null, '/mgr/app/timebargain/firmSet/tradePrivilege_head.jsp', null, '15', '1', '0', '1', '1505', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501030102', '1501030100', '列表权限', null, '/timebargain/firmSet/tradePrivilege/list*', null, '15', '2', '0', '1', '1505', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501030103', '1501030102', '修改状态', null, '/timebargain/firmSet/tradePrivilege/updateStatus*', null, '15', '3', '0', '1', '1505', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501030104', '1501030102', '添加权限', null, '/timebargain/firmSet/tradePrivilege/add*', null, '15', '4', '0', '1', '1505', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501030105', '1501030102', '删除权限', null, '/timebargain/firmSet/tradePrivilege/delete*', null, '15', '5', '0', '1', '1505', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501030106', '1501030102', '查看权限', null, '/timebargain/firmSet/tradePrivilege/view*', null, '15', '6', '0', '1', '1505', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501030107', '1501030106', '修改权限', null, '/timebargain/firmSet/tradePrivilege/update*', null, '15', '7', '0', '1', '1505', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501030108', '1501030102', '批量操作', null, '/timebargain/firmSet/tradePrivilege/batchSet*', null, '15', '9', '0', '1', '1505', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501030200', '1501030000', '风控设置', '29_29.gif', '/timebargain/firmSet/risk/*', '/timebargain/firmSet/risk/riskList.action', '15', '2', '0', '0', '1505', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501030203', '1501030200', '查看权限', null, '/timebargain/firmSet/risk/view*', null, '15', '3', '0', '1', '1505', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501030204', '1501030203', '修改权限', null, '/timebargain/firmSet/risk/update*', null, '15', '4', '0', '1', '1505', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501030300', '1501030000', '商品特殊设置', '29_29.gif', '/timebargain/firmSet/commoditySpecial/*', '/timebargain/firmSet/commoditySpecial/commoditySpecial.action', '15', '3', '0', '0', '1505', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501030301', '1501030300', '选项卡权限', null, '/mgr/app/timebargain/firmSet/commoditySpecial_head.jsp', null, '15', '1', '0', '1', '1505', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501030302', '1501030300', '列表权限', null, '/timebargain/firmSet/commoditySpecial/list*', null, '15', '2', '0', '1', '1505', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501030303', '1501030302', '添加权限', null, '/timebargain/firmSet/commoditySpecial/add*', null, '15', '3', '0', '1', '1505', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501030304', '1501030302', '删除权限', null, '/timebargain/firmSet/commoditySpecial/delete*', null, '15', '4', '0', '1', '1505', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501030305', '1501030302', '查看权限', null, '/timebargain/firmSet/commoditySpecial/view*', null, '15', '5', '0', '1', '1505', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501030306', '1501030305', '修改权限', null, '/timebargain/firmSet/commoditySpecial/update*', null, '15', '6', '0', '1', '1505', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501030400', '1501030000', '品种特殊设置', '29_29.gif', '/timebargain/firmSet/breedSpecial/*', '/timebargain/firmSet/breedSpecial/breedSpecial.action', '15', '4', '0', '0', '1505', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501030401', '1501030400', '选项卡权限', null, '/mgr/app/timebargain/firmSet/breedSpecial_head.jsp', null, '15', '1', '0', '1', '1505', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501030402', '1501030400', '列表权限', null, '/timebargain/firmSet/breedSpecial/list*', null, '15', '2', '0', '1', '1505', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501030403', '1501030402', '添加权限', null, '/timebargain/firmSet/breedSpecial/add*', null, '15', '3', '0', '1', '1505', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501030404', '1501030402', '删除权限', null, '/timebargain/firmSet/breedSpecial/delete*', null, '15', '4', '0', '1', '1505', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501030405', '1501030402', '查看权限', null, '/timebargain/firmSet/breedSpecial/view*', null, '15', '5', '0', '1', '1505', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501030406', '1501030405', '修改权限', null, '/timebargain/firmSet/breedSpecial/update*', null, '15', '6', '0', '1', '1505', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501030500', '1501030000', '手续费套餐选择', '29_29.gif', '/timebargain/firmSet/firmTariff/*', '/timebargain/firmSet/firmTariff/firmTariffList.action?sortColumns=order+by+modifyTime+desc', '15', '5', '0', '0', '1505', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501030503', '1501030500', '查看权限', null, '/timebargain/firmSet/firmTariff/view*', null, '15', '3', '0', '1', '1505', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501030504', '1501030503', '修改权限', null, '/timebargain/firmSet/firmTariff/update*', null, '15', '4', '0', '1', '1505', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501040100', '1501040000', '资金情况', '29_29.gif', '/timebargain/dataquery/listCustomerFunds/*', '/timebargain/dataquery/listCustomerFunds.action', '15', '1', '0', '0', '1506', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501040101', '1501040100', '查看权限', null, '/timebargain/dataquery/customerFunds*', null, '15', '1', '0', '1', '1506', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501040200', '1501040000', '委托情况', '29_29.gif', '/timebargain/dataquery/listOrder/*', '/timebargain/dataquery/listOrder.action', '15', '2', '0', '0', '1506', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501040300', '1501040000', '指定转让委托', '29_29.gif', '/timebargain/dataquery/listSpecFrozenHold/*', '/timebargain/dataquery/listSpecFrozenHold.action?sortColumns=order+by+id+desc', '15', '3', '0', '0', '1506', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501040400', '1501040000', '成交情况', '29_29.gif', '/timebargain/dataquery/listTrade/*', '/timebargain/dataquery/listTrade.action', '15', '4', '0', '0', '1506', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501040500', '1501040000', '交易商订货合计', '29_29.gif', '/timebargain/dataquery/listFirmHoldPosition/*', '/timebargain/dataquery/listFirmHoldPosition.action', '15', '5', '0', '0', '1506', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501040600', '1501040000', '客户订货合计', '29_29.gif', '/timebargain/dataquery/listHoldPosition/*', '/timebargain/dataquery/listHoldPosition.action', '15', '6', '0', '0', '1506', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501040700', '1501040000', '订货明细', '29_29.gif', '/timebargain/dataquery/listHold/*', '/timebargain/dataquery/listHold.action', '15', '7', '0', '0', '1506', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501040800', '1501040000', '商品行情', '29_29.gif', '/timebargain/dataquery/listQuotation/*', '/timebargain/dataquery/listQuotation.action', '15', '8', '0', '0', '1506', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501040900', '1501040000', '商品查询', '29_29.gif', '/timebargain/dataquery/listQueryCommodity/*', '/timebargain/dataquery/listQueryCommodity.action', '15', '9', '0', '0', '1506', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501040901', '1501040900', '查看商品权限', null, '/timebargain/dataquery/detailCommodity*', null, '15', '1', '0', '1', '1506', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501050100', '1501050000', '综合日报表', '29_29.gif', '/timebargain/todayTogetherReport/firmlist.action', '/timebargain/todayTogetherReport/firmlist.action', '15', '1', '0', '0', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501050101', '1501050100', '综合日报表查看权限', null, '/timebargain/todayTogetherReport/todayTogether*', null, '15', '1', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501050102', '1501050100', '综合日报表跳转权限', null, '/mgr/app/timebargain/printReport/todayTogetherReport*', null, '15', '2', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501050200', '1501050000', '资金结算表', '29_29.gif', '/timebargain/fundSettlementReport/fundSettlementQuery.action', '/timebargain/fundSettlementReport/fundSettlementQuery.action', '15', '2', '0', '0', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501050201', '1501050200', '资金结算表查看权限', null, '/timebargain/fundSettlementReport/fundSettlement*', null, '15', '1', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501050202', '1501050200', '资金结算表跳转权限', null, '/mgr/app/timebargain/printReport/fundSettlementReport*', null, '15', '2', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501050300', '1501050000', '转让盈亏明细', '29_29.gif', '/timebargain/transferProfitAndLoss/transferProfitAndLossQuery.action', '/timebargain/transferProfitAndLoss/transferProfitAndLossQuery.action', '15', '3', '0', '0', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501050301', '1501050300', '转让盈亏明细查看权限', null, '/timebargain/transferProfitAndLoss/transferProfitAndLoss*', null, '15', '1', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501050302', '1501050300', '转让盈亏明细跳转权限', null, '/mgr/app/timebargain/printReport/transferProfitAndLossReport*', null, '15', '2', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501050400', '1501050000', '成交量统计', '29_29.gif', '/timebargain/tradeMonthReport/tradeMonthQuery.action', '/timebargain/tradeMonthReport/tradeMonthQuery.action', '15', '4', '0', '0', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001030300', '1001030000', '证件类型维护', '29_29.gif', '/mfirmAttribute/mainTenance/*', '/mfirmAttribute/mainTenance/certificateTypeList.action?sortColumns=order+by+sortNo', '10', '3', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001030301', '1001030300', '证件类型添加权限', null, '/mfirmAttribute/mainTenance/add*', null, '10', '1', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001030302', '1001030300', '证件类型修改权限', null, '/mfirmAttribute/mainTenance/update*', null, '10', '2', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001030303', '1001030300', '证件类型删除权限', null, '/mfirmAttribute/mainTenance/delete*', null, '10', '3', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001030400', '1001030000', '交易商类别维护', '29_29.gif', '/mfirmAttribute/mainTenance/*', '/mfirmAttribute/mainTenance/firmCategoryList.action?sortColumns=order+by+sortNo', '10', '4', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001030401', '1001030400', '交易商类别添加权限', null, '/mfirmAttribute/mainTenance/add*', null, '10', '1', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001030402', '1001030400', '交易商类别修改权限', null, '/mfirmAttribute/mainTenance/update*', null, '10', '2', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1001030403', '1001030400', '交易商类别删除权限', null, '/mfirmAttribute/mainTenance/delete*', null, '10', '3', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1002000000', '9900000000', '运营管理', null, null, null, '10', '3', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1002010000', '1002000000', '内容审核', '10_30.gif', null, null, '10', '1', '-1', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1002010100', '1002010000', '待审核列表', '10_301.gif', '/audit/baseAudit/waitAuditList.action', '/audit/baseAudit/waitAuditList.action?isQueryDB=true', '10', '1', '0', '0', '1051', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1002010101', '1002010100', '查看待审核详细信息', null, '/audit/baseAudit/waitAuditDetails.action', null, '10', '1', '0', '1', '1051', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1002010200', '1002010000', '审核通过列表', '10_302.gif', '/audit/baseAudit/passAuditList.action', '/audit/baseAudit/passAuditList.action', '10', '2', '0', '0', '1051', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1002010201', '1002010200', '审核通过查看权限', null, '/audit/baseAudit/passAuditDetails.action', null, '10', '1', '0', '1', '1051', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1002010202', '1002010200', '审核通过修改权限', null, '/audit/baseAudit/passApply*', null, '10', '2', '0', '1', '1051', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1002010300', '1002010000', '审核驳回列表', '10_303.gif', '/audit/baseAudit/rejectAuditList.action', '/audit/baseAudit/rejectAuditList.action', '10', '3', '0', '0', '1051', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1002010301', '1002010300', '审核驳回查看权限', null, '/audit/baseAudit/rejectAuditDetails.action', null, '10', '1', '0', '1', '1051', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1002010302', '1002010300', '审核驳回修改权限', null, '/audit/baseAudit/rejectApply*', null, '10', '2', '0', '1', '1051', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1002010400', '1002010000', '可撤销列表', '10_304.gif', '/audit/baseAudit/canWithdrawList.action', '/audit/baseAudit/canWithdrawList.action', '10', '4', '0', '0', '1051', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1002010401', '1002010400', '可撤销查看权限', null, '/audit/baseAudit/canWithdrawDetails.action', null, '10', '1', '0', '1', '1051', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1002010402', '1002010400', '可撤销修改权限', null, '/audit/baseAudit/withdrawApply*', null, '10', '2', '0', '1', '1051', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1002010500', '1002010000', '已撤销列表', '10_305.gif', '/audit/baseAudit/withdrawedList.action', '/audit/baseAudit/withdrawedList.action?isQueryDB=true', '10', '5', '0', '0', '1051', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1002010501', '1002010500', '已撤销查看权限', null, '/audit/baseAudit/withdrawedDetails.action', null, '10', '1', '0', '1', '1051', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1002020000', '1002000000', '公告消息', '10_40.gif', null, null, '10', '2', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1002020100', '1002020000', '公告管理', '10_401.gif', '/trade/notice/*', '/trade/notice/noticeList.action?sortColumns=order+by+createTime+desc', '10', '1', '0', '0', '1041', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1002020101', '1002020100', '查看公告', null, '/trade/notice/noticeDetail.action', null, '10', '1', '0', '1', '1041', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1002020102', '1002020100', '删除公告', null, '/trade/notice/deleteNotices.action', null, '10', '2', '0', '1', '1041', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1002020103', '1002020100', '添加公告', null, '/trade/notice/addNotice*', null, '10', '3', '0', '1', '1041', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1002020200', '1002020000', '消息管理', '10_402.gif', '/trade/message/*', '/trade/message/messageList.action?sortColumns=order+by+createTime+desc', '10', '2', '0', '0', '1041', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1002020201', '1002020200', '查看消息', null, '/trade/message/forwardMessage.action', null, '10', '1', '0', '1', '1041', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1002020202', '1002020200', '删除消息', null, '/trade/message/deleteMessage.action', null, '10', '2', '0', '1', '1041', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1002020203', '1002020200', '添加消息', null, '/trade/message/add*', null, '10', '3', '0', '1', '1041', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1003000000', '9900000000', '商品管理', null, null, null, '10', '2', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1003010000', '1003000000', '商品分类', '10_60.gif', null, null, '10', '1', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1003010100', '1003010000', '商品分类管理', '10_601.gif', '/category/commodity/*', '/category/commodity/categoryShow.action', '10', '1', '0', '0', '1071', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1003010101', '1003010100', '分类添加权限', null, '/category/commodity/add*', null, '10', '1', '0', '1', '1071', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1003010102', '1003010100', '商品展示权限', null, '/category/commodity/categoryTree*', null, '10', '2', '0', '1', '1071', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1003010103', '1003010100', '商品修改权限', null, '/category/commodity/update*', null, '10', '3', '0', '1', '1071', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1003010104', '1003010100', '商品删除权限', null, '/category/commodity/delete*', null, '10', '4', '0', '1', '1071', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1003010200', '1003010000', '商品品名管理', '10_602.gif', '/category/breed/*', '/category/breed/breedShow.action', '10', '2', '0', '0', '1071', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1003010201', '1003010200', '品名添加权限', null, '/category/breed/add*', null, '10', '1', '0', '1', '1071', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1003010202', '1003010200', '品名展示权限', null, '/category/breed/breedTree*', null, '10', '2', '0', '1', '1071', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1003010203', '1003010200', '品名修改权限', null, '/category/breed/update*', null, '10', '3', '0', '1', '1071', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1003010204', '1003010200', '品名删除权限', null, '/category/breed/delete*', null, '10', '4', '0', '1', '1071', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1003010205', '1003010200', '判断属性值类型权限', null, '/stock/addBreedProps/jsonForProps/getBreedPropsValueType.action', null, '10', '5', '0', '1', '1071', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1003010206', '1003010203', '获取分类信息权限', null, '/commoditymanage/jsonForCommodity/getCommodityInfoByCategoryId.action', null, '10', '1', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1003010207', '1003010203', '展示品名图片权限', null, '/nosecurity/pic/getBreedPic.action', null, '10', '2', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1003010300', '1003010000', '分类属性类型管理', '10_60.gif', '/category/propertytype/*', '/category/propertytype/list.action?sortColumns=order+by+sortNo', '10', '3', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1003010301', '1003010300', '分类属性类型添加权限', null, '/category/propertytype/add*', null, '10', '1', '0', '1', '1071', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1003010302', '1003010300', '分类属性类型修改权限', null, '/category/propertytype/update*', null, '10', '2', '0', '1', '1071', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1003010303', '1003010300', '分类属性类型删除权限', null, '/category/propertytype/delete*', null, '10', '3', '0', '1', '1071', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1009000000', '9900000000', '统计查询', null, null, null, '10', '9', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1009000100', '1009000000', '统计', '10_50.gif', null, null, '10', '1', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1009000110', '1009000100', '开户统计', '10_501.gif', '/statisticsQuery/frontlogon/*', '/statisticsQuery/mfirmCreate/mfirmCreateForwardQuery.action', '10', '1', '0', '0', '1061', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1009000111', '1009000110', '查询开户统计权限', null, 'mgr/app/integrated/statistics/mfirmcreate.rptdesign', null, '10', '1', '0', '1', '1061', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1009000120', '1009000100', '登录统计', '10_502.gif', '/statisticsQuery/frontlogon/*', '/statisticsQuery/frontlogon/frontLogonForwardQuery.action', '10', '2', '0', '0', '1061', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1009000121', '1009000120', '查询登录统计权限', null, 'mgr/app/integrated/statistics/frontlogon.rptdesign', null, '10', '1', '0', '1', '1061', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1101000000', '9900000000', '资金管理', null, null, null, '11', '2', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1101010000', '1101000000', '凭证管理', '42_42.gif', null, null, '11', '1', '0', '-1', '1101', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1101020000', '1101000000', '账务查询', '42_42.gif', null, null, '11', '2', '0', '-1', '1102', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1101030000', '1101000000', '交易商资金', '42_42.gif', null, null, '11', '3', '0', '-1', '1103', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1101040000', '1101000000', '账务维护', '42_42.gif', null, null, '11', '4', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1101010100', '1101010000', '录入凭证', '29_29.gif', '/finance/voucher/voucherList.action', '/finance/voucher/voucherList.action', '11', '1', '0', '0', '1101', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1101010101', '1101010100', '添加凭证', null, '/finance/voucher/add*', null, '11', '1', '0', '1', '1101', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1101010102', '1101010100', '删除凭证', null, '/finance/voucher/delete*', null, '11', '2', '0', '1', '1101', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1101010103', '1101010100', '查看凭证', null, '/finance/voucher/view*', null, '11', '3', '0', '1', '1101', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1101010104', '1101010103', '修改凭证', null, '/finance/voucher/update*', null, '11', '1', '0', '1', '1101', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1101010200', '1101010000', '快捷录入', '29_29.gif', null, '/finance/voucher/addVoucherFastForward.action', '11', '2', '0', '0', '1101', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1101010201', '1101010200', '生成凭证', '29_29.gif', '/finance/voucher/addVoucherFast*', null, '11', '1', '0', '1', '1101', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1101010300', '1101010000', '凭证确认', '29_29.gif', '/finance/voucher/voucherConfirmList.action', '/finance/voucher/voucherConfirmList.action', '11', '3', '0', '0', '1101', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1101010301', '1101010300', '提交审核', '29_29.gif', '/finance/voucher/auditOne*', null, '11', '1', '0', '1', '1101', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1101010302', '1101010300', '全部提交审核', '29_29.gif', '/finance/voucher/auditAll*', null, '11', '2', '0', '1', '1101', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1101010303', '1101010300', '查看凭证', null, '/finance/voucher/view*', null, '11', '3', '0', '1', '1101', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1101010400', '1101010000', '财务审核', '29_29.gif', '/finance/voucher/voucherAuditList.action', '/finance/voucher/voucherAuditList.action', '11', '4', '0', '0', '1101', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1101010401', '1101010400', '审核通过', '29_29.gif', '/finance/voucher/auditVoucher*', null, '11', '1', '0', '1', '1101', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1101010402', '1101010400', '审核失败', '29_29.gif', '/finance/voucher/auditVoucher*', null, '11', '2', '0', '1', '1101', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1101010403', '1101010400', '查看凭证', null, '/finance/voucher/view*', null, '11', '3', '0', '1', '1101', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1101010500', '1101010000', '未结算凭证查询', '29_29.gif', '/finance/voucher/voucherCurrentList.action', '/finance/voucher/voucherCurrentList.action', '11', '5', '0', '0', '1101', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1101010501', '1101010500', '查看凭证', null, '/finance/voucher/view*', null, '11', '1', '0', '1', '1101', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('9900000000', null, '主菜单', null, null, null, '99', '1', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501070600', '1501070000', '商品订货监控', '29_29.gif', '/timebargain/tradeMonitor/monitor*', '/timebargain/tradeMonitor/monitorGetCommodityList.action?type=commodityMonitor', '15', '6', '0', '0', '1509', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501070601', '1501070600', '商品订货监控权限', null, '/mgr/app/timebargain/tradeMonitor/monitor_commodity*', null, '15', '1', '0', '1', '1509', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501070602', '1501070600', '商品订货监控查询权限', null, '/timebargain/tradeMonitor/monitor*', null, '15', '2', '0', '1', '1509', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501070700', '1501070000', '交易商订货监控', '29_29.gif', '/timebargain/tradeMonitor/monitor*', '/timebargain/tradeMonitor/monitorGetCommodityList.action?type=firmMonitor', '15', '7', '0', '0', '1509', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501070701', '1501070700', '交易商订货监控权限', null, '/timebargain/tradeMonitor/monitor*', null, '15', '1', '0', '1', '1509', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501070800', '1501070000', '资金预警', '29_29.gif', '/mgr/app/timebargain/tradeMonitor/monitor_fundsAnalysis.jsp', '/mgr/app/timebargain/tradeMonitor/monitor_fundsAnalysis.jsp', '15', '8', '0', '0', '1509', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501070801', '1501070800', '资金预警权限', null, '/timebargain/tradeMonitor/monitor*', null, '15', '1', '0', '1', '1509', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501070900', '1501070000', '排行分析', '29_29.gif', '/mgr/app/timebargain/tradeMonitor/monitor_analyseInfo.jsp', '/mgr/app/timebargain/tradeMonitor/monitor_analyseInfo.jsp', '15', '9', '0', '0', '1509', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501070901', '1501070900', '排行分析权限', null, '/timebargain/tradeMonitor/monitor*', null, '15', '1', '0', '1', '1509', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501071000', '1501070000', '未成交内存队列', '29_29.gif', '/timebargain/tradeMonitor/monitor*', '/timebargain/tradeMonitor/monitorGetCommodityList.action?type=saleQueue', '15', '10', '0', '0', '1509', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501071001', '1501071000', '未成交内存队列权限', null, '/mgr/app/timebargain/tradeMonitor/memoryMonitor/monitor_*', null, '15', '1', '0', '1', '1509', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501071002', '1501071000', '未成交内存队列查询权限', null, '/timebargain/tradeMonitor/monitor*', null, '15', '2', '0', '1', '1509', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501071100', '1501070000', '等待撮合内存队列', '29_29.gif', '/timebargain/tradeMonitor/monitor*', '/timebargain/tradeMonitor/monitorGetCommodityList.action?type=waitOrder', '15', '11', '0', '0', '1509', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501071101', '1501071100', '等待撮合内存队列权限', null, '/timebargain/tradeMonitor/monitor*', null, '15', '1', '0', '1', '1509', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501071200', '1501070000', '系统设置', '29_29.gif', '/timebargain/tradeMonitor/monitor*', '/timebargain/tradeMonitor/monitorParameterEdit.action', '15', '12', '0', '0', '1509', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501071201', '1501071200', '系统设置权限', null, '/timebargain/tradeMonitor/monitor*', null, '15', '1', '0', '1', '1509', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501080100', '1501080000', '代为委托', '29_29.gif', '/timebargain/authorize/authorizeForward.action', '/timebargain/authorize/authorizeForward.action', '15', '1', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501080101', '1501080100', '代为委托员登陆验证', null, '/timebargain/authorize/chkLogin.action', null, '15', '1', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501080102', '1501080100', '代为委托员登陆', null, '/timebargain/authorize/loginConsigner.action', null, '15', '2', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501080103', '1501080100', '代为委托员注销', null, '/timebargain/authorize/logoffConsigner.action*', null, '15', '3', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501080105', '1501080100', '代为委托跳转', null, '/timebargain/authorize/editOrder.action', null, '15', '5', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501080106', '1501080100', '代为委托操作', null, '/timebargain/authorize/order.action', null, '15', '6', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501080107', '1501080100', '代为委托员登陆框架', null, '/mgr/app/timebargain/authorize/traderLogin.jsp', null, '15', '7', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501080108', '1501080100', '代为委托员登陆页面', null, '/mgr/app/timebargain/authorize/traderLogin_form.jsp', null, '15', '8', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501080200', '1501080000', '代为撤单', '29_29.gif', '/timebargain/authorize/noTradeListForward.action', '/timebargain/authorize/noTradeListForward.action', '15', '2', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501080201', '1501080200', '代为撤单列表查询', null, '/timebargain/authorize/noTradeList.action', null, '15', '1', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501080202', '1501080200', '代为撤单操作', null, '/timebargain/authorize/withdrawOrder.action', null, '15', '2', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501080300', '1501080000', '强行转让', '29_29.gif', '/timebargain/authorize/forceForward.action', '/timebargain/authorize/forceForward.action', '15', '3', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501080301', '1501080300', '强转列表查询', null, '/timebargain/authorize/searchForceClose.action', null, '15', '1', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501080302', '1501080300', '强转信息查询', null, '/timebargain/authorize/forceCloseInfo.action*', null, '15', '2', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501080303', '1501080300', '强转操作', null, '/timebargain/authorize/forceClose.action', null, '15', '3', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501080304', '1501080300', '查询一手对应保证金', null, '/ajaxcheck/order/searchForceCloseMoney.action*', null, '15', '4', '-1', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501080305', '1501080300', '强转信息查询框架', null, '/mgr/app/timebargain/authorize/forceClose_list_qp.jsp*', null, '15', '5', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501080400', '1501080000', '修改代为委托员口令', '29_29.gif', '/timebargain/authorize/passwordForward.action', '/timebargain/authorize/passwordForward.action', '15', '4', '-1', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501080401', '1501080400', '修改代为委托员口令跳转', null, '/timebargain/authorize/updatePasswordForward.action', null, '15', '1', '-1', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501080402', '1501080400', '修改代为委托员口令操作', null, '/timebargain/authorize/updatePassword.action', null, '15', '2', '-1', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501080500', '1501080000', '强行转让过期持仓', '29_29.gif', '/timebargain/authorize/detailForceCloseForward.action', '/timebargain/authorize/detailForceCloseForward.action', '15', '5', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501080501', '1501080500', '强转过期列表查询', null, '/timebargain/authorize/searchDetailForceClose.action', null, '15', '1', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501080502', '1501080500', '查看权限', null, '/timebargain/authorize/viewDetailForceClose.action', null, '15', '2', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501080503', '1501080502', '强制转让', null, '/timebargain/authorize/detailForceClose.action', null, '15', '3', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501090100', '1501090000', '强减向导', '29_29.gif', '/timebargain/deduct/toDeductPosition.action', '/timebargain/deduct/toDeductPosition.action', '15', '1', '0', '0', '1511', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501090200', '1501090000', '强减查询', '29_29.gif', '/timebargain/deduct/*', '/timebargain/deduct/deducPositionList.action', '15', '2', '0', '0', '1511', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501090300', '1501090000', '强减委托录入', '29_29.gif', '/timebargain/deduct/deductOrderAddForward.action', '/timebargain/deduct/deductOrderAddForward.action', '15', '3', '0', '0', '1511', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501090101', '1501090100', '添加权限', '29_29.gif', '/timebargain/deduct/addDeductPosition.action', '/timebargain/deduct/addDeductPosition.action', '15', '1', '0', '1', '1511', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501090103', '1501090100', '修改页面权限', '29_29.gif', '/timebargain/deduct/updateDeductPositionForward.action', '/timebargain/deduct/updateDeductPositionForward.action', '15', '3', '0', '1', '1511', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501090108', '1501090100', '执行强减权限', '29_29.gif', '/timebargain/deduct/deductGo.action', '/timebargain/deduct/deductGo.action', '15', '8', '0', '1', '1511', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501090201', '1501090200', '客户保留查询权限', '29_29.gif', '/timebargain/deduct/deductKeepFirmByDeductId.action', '/timebargain/deduct/deductKeepFirmByDeductId.action', '15', '1', '0', '1', '1511', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501090202', '1501090200', '详细信息查询权限', '29_29.gif', '/timebargain/deduct/deductInfoByDeductId.action', '/timebargain/deduct/deductInfoByDeductId.action', '15', '2', '0', '1', '1511', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501090203', '1501090200', '强减明细查询权限', '29_29.gif', '/timebargain/deduct/deductDetailByDeductId.action', '/timebargain/deduct/deductDetailByDeductId.action', '15', '3', '0', '1', '1511', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501090301', '1501090300', '添加权限', '29_29.gif', '/timebargain/deduct/addDeductOrder.action', '/timebargain/deduct/addDeductOrder.action', '15', '1', '0', '1', '1511', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501090104', '1501090100', '修改权限', '29_29.gif', '/timebargain/deduct/updateDeductPosition.action', '/timebargain/deduct/updateDeductPosition.action', '15', '4', '0', '1', '1511', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501090105', '1501090100', '排序权限', '29_29.gif', '/timebargain/deduct/deductKeepFirmForward.action', '/timebargain/deduct/deductKeepFirmForward.action', '15', '5', '0', '1', '1511', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501090102', '1501090100', '添加权限', '29_29.gif', '/timebargain/deduct/addKeepFirm.action', '/timebargain/deduct/addKeepFirm.action', '15', '2', '0', '1', '1511', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501090109', '1501090100', '验证权限', '29_29.gif', '/ajaxCheck/deduct/formCheckDeductKeepByIds.action', 'ajaxCheck/deduct/formCheckDeductKeepByIds.action', '15', '9', '0', '1', '1511', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501090106', '1501090100', '生成强减权限', '29_29.gif', '/timebargain/deduct/operateDeductDetail.action', '/timebargain/deduct/operateDeductDetail.action', '15', '6', '0', '1', '1511', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501090107', '1501090100', '删除权限', '29_29.gif', '/timebargain/deduct/deleteDeductKeep.action', '/timebargain/deduct/deleteDeductKeep.action', '15', '7', '0', '1', '1511', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501100100', '1501100000', '异常处理', '29_29.gif', '/timebargain/xtwh/agencyYCCL.action', '/timebargain/xtwh/agencyYCCL.action', '15', '1', '0', '0', '1512', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501100101', '1501100100', '异常处理权限', null, '/timebargain/xtwh/yccl*', null, '15', '1', '0', '1', '1512', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501110100', '1501110000', '延期交收节', '29_29.gif', '/timebargain/delay/sectionList.action', '/timebargain/delay/sectionList.action', '15', '1', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501110200', '1501110000', '商品交收权限', '29_29.gif', '/timebargain/delay/commodityList.action', '/timebargain/delay/commodityList.action', '15', '2', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501110300', '1501110000', '交易商交收权限', '29_29.gif', '/timebargain/delay/privilegeList.action', '/timebargain/delay/privilegeList.action?sortColumns=order+by+ID+asc', '15', '3', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501110400', '1501110000', '延期交收状态', '29_29.gif', '/timebargain/delay/delayStatusList.action', '/timebargain/delay/delayStatusList.action', '15', '4', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501110500', '1501110000', '延期委托查询', '29_29.gif', '/timebargain/delay/delayOrdersList.action', '/timebargain/delay/delayOrdersList.action?opr=T_DelayOrders&sortColumns=order+by+firmId+asc', '15', '5', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501110600', '1501110000', '中立仓成交查询', '29_29.gif', '/timebargain/delay/delayTradeList.action', '/timebargain/delay/delayTradeList.action?opr=T_DelayTrade&sortColumns=order+by+firmId+asc', '15', '6', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501110700', '1501110000', '延期行情查询', '29_29.gif', '/timebargain/delay/delayQuotationList.action', '/timebargain/delay/delayQuotationList.action?opr=T_DelayQuotation&sortColumns=order+by+commodityId+asc', '15', '7', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501020101', '1501020100', '修改权限', null, '/timebargain/tradeparams/updatemarket.action', null, '15', '1', '0', '1', '1504', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501020201', '1501020200', '添加权限', null, '/timebargain/tradeparams/addTradeTime*', null, '15', '1', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501020202', '1501020200', '删除权限', null, '/timebargain/tradeparams/deleteTradeTime*', null, '15', '2', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501020203', '1501020200', '查看权限', null, '/timebargain/tradeparams/detailTradeTime*', null, '15', '3', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501020204', '1501020203', '修改权限', null, '/timebargain/tradeparams/updateTradeTime*', null, '15', '1', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501020301', '1501020300', '添加品种权限', null, '/timebargain/tradeparams/addBreed*', null, '15', '1', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501020302', '1501020300', '查看品种权限', null, '/timebargain/tradeparams/detailBreed*', null, '15', '2', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501020303', '1501020300', '提交品种权限', null, '/timebargain/tradeparams/updateBreed*', null, '15', '3', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501020304', '1501020300', '删除品种权限', null, '/timebargain/tradeparams/deleteBreed*', null, '15', '4', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501020308', '1501020300', '查看对应商品权限', null, '/timebargain/tradeparams/detailToCommodity*', null, '15', '8', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501020309', '1501020300', '添加商品权限', null, '/timebargain/tradeparams/addCommodity*', null, '15', '9', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501020310', '1501020300', '查看商品权限', null, '/timebargain/tradeparams/detailCommodity*', null, '15', '10', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501020311', '1501020300', '提交商品权限', null, '/timebargain/tradeparams/updateCommodity*', null, '15', '11', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501020312', '1501020300', '删除商品权限', null, '/timebargain/tradeparams/deleteCommodity*', null, '15', '12', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501020401', '1501020400', '修改非交易日权限', null, '/timebargain/tradeparams/updateTradeDay*', null, '15', '1', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501020402', '1501020400', '查看日历权限', null, '/timebargain/tradeparams/detailCalendar*', null, '15', '2', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501020403', '1501020400', '设置交易节权限', null, '/timebargain/tradeparams/setTradeDay*', null, '15', '3', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501020501', '1501020500', '添加权限', null, '/timebargain/tradeparams/addTariff*', null, '15', '1', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501020502', '1501020500', '查看权限', null, '/timebargain/tradeparams/detailTariff*', null, '15', '2', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501020503', '1501020500', '删除权限', null, '/timebargain/tradeparams/deleteTariff*', null, '15', '3', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501110101', '1501110100', '修改权限', null, '/timebargain/delay/updateSection*', null, '15', '1', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501110102', '1501110100', '删除权限', null, '/timebargain/delay/deleteSection*', null, '15', '2', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501110201', '1501110200', '修改权限', null, '/timebargain/delay/updateCommodity*', null, '15', '1', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501110301', '1501110300', '添加权限', null, '/timebargain/delay/addPrivilege*', null, '15', '1', '0', '1', '1513', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501110302', '1501110300', '查看权限', null, '/timebargain/delay/detailPrivilege*', null, '15', '2', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501110303', '1501110300', '修改权限', null, '/timebargain/delay/updatePrivilege*', null, '15', '3', '0', '1', '1513', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501110304', '1501110300', '删除权限', null, '/timebargain/delay/deletePrivilege*', null, '15', '4', '0', '1', '1513', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501110401', '1501110400', '修改权限', null, '/timebargain/delay/updateDelayStatus*', null, '15', '1', '0', '1', '1513', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501120000', '1501000000', '申请', '42_42.gif', null, null, '15', '13', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501120200', '1501120000', '商品手续费', '29_29.gif', '/timebargain/apply/commodityFeeAppList.action', '/timebargain/apply/commodityFeeAppList.action?sortColumns=order+by+id+desc', '15', '2', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501120300', '1501120000', '商品保证金', '29_29.gif', '/timebargain/apply/commodityMarginAppList.action', '/timebargain/apply/commodityMarginAppList.action?sortColumns=order+by+id+desc', '15', '3', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501130000', '1501000000', '审核', '42_42.gif', null, null, '15', '14', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501130200', '1501130000', '商品手续费', '29_29.gif', '/timebargain/check/commodityFeeCheList.action', '/timebargain/check/commodityFeeCheList.action', '15', '2', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501130300', '1501130000', '商品保证金', '29_29.gif', '/timebargain/check/commodityMarginCheList.action', '/timebargain/check/commodityMarginCheList.action', '15', '3', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501120201', '1501120200', '添加权限', null, '/timebargain/apply/addCommodityFeeApp*', null, '15', '1', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501120202', '1501120200', '查看权限', null, '/timebargain/apply/detailCommodityFeeApp*', null, '15', '2', '-1', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501120203', '1501120200', '修改权限', null, '/timebargain/apply/updateCommodityFeeApp*', null, '15', '3', '-1', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501130201', '1501130200', '查看权限', null, '/timebargain/check/detailCommodityFeeChe*', null, '15', '1', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501130202', '1501130200', '修改权限', null, '/timebargain/check/updateCommodityFeeChe*', null, '15', '2', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501120301', '1501120300', '添加权限', null, '/timebargain/apply/addCommodityMarginApp*', null, '15', '1', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501120302', '1501120300', '查看权限', null, '/timebargain/apply/detailCommodityMarginApp*', null, '15', '2', '-1', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501120303', '1501120300', '修改权限', null, '/timebargain/apply/updateCommodityMarginApp*', null, '15', '3', '-1', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501130301', '1501130300', '查看权限', null, '/timebargain/check/detailCommodityMarginChe*', null, '15', '1', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501130302', '1501130300', '修改权限', null, '/timebargain/check/updateCommodityMarginChe*', null, '15', '2', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501140400', '1501140000', '加盟商手续费汇总', '29_29.gif', '/timebargain/brokerReward/*', '/timebargain/brokerReward/listBrokerTradeFee.action', '15', '4', '0', '0', '1514', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501140500', '1501140000', '分品种手续费汇总', '29_29.gif', '/timebargain/brokerReward/*', '/timebargain/brokerReward/listBreedTradeFee.action', '15', '5', '0', '0', '1514', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501140600', '1501140000', '交易商手续费汇总', '29_29.gif', '/timebargain/brokerReward/*', '/timebargain/brokerReward/listFirmTradeFee.action', '15', '6', '0', '0', '1514', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501140700', '1501140000', '加盟商资金合计', '29_29.gif', '/timebargain/dataquery/listBrokerFundsCount/*', '/timebargain/dataquery/listBrokerFundsCount.action', '15', '7', '0', '0', '1514', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501140800', '1501140000', '加盟商订货合计', '29_29.gif', '/timebargain/dataquery/listBrokerIndentCount/*', '/timebargain/dataquery/listBrokerIndentCount.action', '15', '8', '0', '0', '1514', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501140900', '1501140000', '加盟商成交合计', '29_29.gif', '/timebargain/dataquery/listBrokerTradeCount/*', '/timebargain/dataquery/listBrokerTradeCount.action', '15', '9', '0', '0', '1514', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501141000', '1501140000', '手续费汇总', '29_29.gif', '/timebargain/brokerReward/*', '/timebargain/brokerReward/brokerUserFeeList.action', '15', '10', '0', '0', '1514', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501141100', '1501140000', '手续费明细', '29_29.gif', '/timebargain/brokerReward/*', '/timebargain/brokerReward/hisDealDetailList.action', '15', '11', '0', '0', '1514', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2301000000', '9900000000', '商铺管理', null, null, null, '23', '1', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2301010000', '2301000000', '商铺', '42_42.gif', null, null, '23', '2', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2301010100', '2301010000', '推荐商铺', '29_29.gif', '/trade/shop/recommendShopList.action', '/trade/shop/recommendShopList.action?sortColumns=order+by+num', '23', '1', '0', '0', '2310', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2301010101', '2301010100', '删除权限', null, '/trade/shop/deleteRecommendShop.action', null, '23', '1', '0', '1', '2310', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2301010102', '2301010100', '添加权限', null, '/trade/shop/addRecommendShop*', null, '23', '3', '0', '1', '2310', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2301010200', '2301010000', '商铺列表', '29_29.gif', '/trade/shop/shopList.action', '/trade/shop/shopList.action?sortColumns=order+by+firmId', '23', '2', '0', '0', '2310', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2301010201', '2301010200', '查看权限', null, '/trade/shop/updateForward.action', null, '23', '1', '0', '1', '2310', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2301010202', '2301010201', '修改权限', null, '/trade/shop/updateShop.action', null, '23', '2', '0', '1', '2310', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2301010203', '2301010200', '商铺图片查看权限', null, '/trade/shop/updateForwardShowImages.action', null, '23', '3', '0', '1', '2310', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2301010204', '2301010203', '商铺图片显示权限', null, '/trade/shop/showImage.action', null, '23', '4', '0', '1', '2310', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2302000000', '9900000000', '资金管理', null, null, null, '23', '2', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2302010000', '2302000000', '交易商资金', '42_42.gif', null, null, '23', '1', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2302010100', '2302010000', '交易商资金情况', '29_29.gif', '/fundmanage/*', '/fundmanage/listFund.action?sortColumns=order+by+firmId&isQueryDB=true', '23', '1', '0', '0', '2305', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2302010200', '2302010000', '交易商保障金流水', '29_29.gif', '/fundmanage/*', '/fundmanage/listSubflow.action?sortColumns=order+by+flowId+desc&isQueryDB=true', '23', '2', '0', '0', '2305', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304000000', '9900000000', '交易管理', null, null, null, '23', '3', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304010000', '2304000000', '运营管理', '42_42.gif', null, null, '23', '1', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304010100', '2304010000', '交易状态管理', '29_29.gif', '/trademanage/market/*', '/trademanage/market/toMarketStatus.action', '23', '1', '0', '0', '2306', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304010101', '2304010100', '修改状态权限', null, '/trademanage/market/updateMarketStatus.action', null, '23', '1', '0', '1', '2306', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304010102', '2304010100', '修改时间权限', null, '/trademanage/market/updateRecoverTime*', null, '23', '2', '0', '1', '2306', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304010200', '2304010000', '非交易日设置', '29_29.gif', '/trademanage/tradeTime/*', '/trademanage/tradeTime/fowardTradeDaySet.action', '23', '2', '0', '0', '2306', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304010201', '2304010200', '修改权限', null, '/trademanage/tradeTime/updateTradeDay.action', null, '23', '1', '0', '1', '2306', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304010202', '2304010200', '实时生效权限', null, '/trademanage/tradeTime/updateTradeDayRT.action', null, '23', '2', '0', '1', '2306', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304010300', '2304010000', '交易节设置', '29_29.gif', '/trademanage/tradeTime/*', '/trademanage/tradeTime/fowardTradeTime.action', '23', '3', '0', '0', '2306', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304010301', '2304010300', '修改权限', null, '/trademanage/tradeTime/updateTradeTime.action', null, '23', '1', '0', '1', '2306', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304010302', '2304010300', '实时生效权限', null, '/trademanage/tradeTime/updateTradeTimeRT.action', null, '23', '2', '0', '1', '2306', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304010400', '2304010000', '交易日历', '29_29.gif', '/trademanage/tradeTime/*', '/trademanage/tradeTime/fowardTradeCalendar.action', '23', '4', '0', '0', '2306', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304010500', '2304010000', '系统运行模式', '29_29.gif', '/trademanage/market/*', '/trademanage/market/toMarketRunMode.action', '23', '5', '0', '0', '2306', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304010501', '2304010500', '修改权限', null, '/trademanage/market/updateMarketRunMode.action', null, '23', '1', '0', '1', '2306', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304010600', '2304010000', '商品维护', '29_29.gif', '/category/commodity/*', '/category/commodity/forwardCommodity.action', '23', '6', '0', '0', '2308', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304010601', '2304010600', '维护权限', null, '/category/commodity/performCommodity.action', null, '23', '1', '0', '1', '2308', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304010602', '2304010601', '品名展示权限', null, '/category/jsonForCategory/getBreedByCategoryID.action', null, '23', '2', '0', '1', '2308', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304010603', '2304010600', '商品同步权限', null, '/category/commodity/synCommodity.action', null, '23', '3', '0', '1', '2308', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304020000', '2304000000', '实时监控', '42_42.gif', null, null, '23', '2', '-1', '-1', '2306', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304020100', '2304020000', '委托监控', '29_29.gif', null, null, '23', '1', '0', '0', '2306', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304020200', '2304020000', '合同监控', '29_29.gif', null, null, '23', '2', '0', '0', '2306', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304020300', '2304020000', '资金监控', '29_29.gif', null, null, '23', '3', '0', '0', '2306', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304030000', '2304000000', '履约进程管理', '42_42.gif', null, null, '23', '3', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304030100', '2304030000', '委托查询', '29_29.gif', '/ordermanage/order/*', '/ordermanage/order/list.action?sortColumns=order+by+orderTime+desc', '23', '1', '0', '0', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304030101', '2304030100', '查看权限', null, '/ordermanage/order/orderDetails.action', null, '23', '1', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304030102', '2304030100', '图片查看权限', null, '/ordermanage/order/showImages.action', null, '23', '1', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304030200', '2304030000', '可撤销委托', '29_29.gif', '/ordermanage/revocationOrder/*', '/ordermanage/revocationOrder/list_revocable.action?sortColumns=order+by+orderTime+desc', '23', '2', '0', '0', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304030201', '2304030200', '查看权限', null, '/ordermanage/revocationOrder/orderDetails.action', null, '23', '1', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304030202', '2304030200', '撤销权限', null, '/ordermanage/revocationOrder/withdrawOrder.action', null, '23', '2', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304030300', '2304030000', '议价查询', '29_29.gif', '/subordermanage/subOrder/*', '/subordermanage/subOrder/list.action?sortColumns=order+by+createTime+desc', '23', '3', '0', '0', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304030301', '2304030300', '查看权限', null, '/subordermanage/subOrder/subOrderDetails.action', null, '23', '1', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304030400', '2304030000', '可撤销议价', '29_29.gif', '/subordermanage/revocationSubOrder/*', '/subordermanage/revocationSubOrder/subOrderList_revocable.action?sortColumns=order+by+createTime+desc', '23', '4', '0', '0', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304030401', '2304030400', '撤销权限', null, '/subordermanage/revocationSubOrder/withdrawSubOrder.action', null, '23', '1', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304030402', '2304030400', '查看权限', null, '/subordermanage/revocationSubOrder/subOrderDetails.action', null, '23', '2', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304030500', '2304030000', '订单查询', '29_29.gif', '/reservemanage/reserve/*', '/reservemanage/reserve/list.action?sortColumns=order+by+reserveId+desc', '23', '5', '0', '0', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304030501', '2304030500', '查看权限', null, '/reservemanage/reserve/reserveDetails.action', null, '23', '1', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304030600', '2304030000', '可撤销订单', '29_29.gif', '/reservemanage/revocationReserve/*', '/reservemanage/revocationReserve/reserveList_revocable.action?sortColumns=order+by+reserveId+desc', '23', '6', '0', '0', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304030601', '2304030600', '查看权限', null, '/reservemanage/revocationReserve/reserveDetails.action', null, '23', '1', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304030602', '2304030600', '撤销权限', null, '/reservemanage/revocationReserve/withdrawReserve.action', null, '23', '2', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304030700', '2304030000', '成交查询', '29_29.gif', '/holdingmanage/holding/*', '/holdingmanage/holding/list.action?sortColumns=order+by+holdingId+desc', '23', '7', '0', '0', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304030701', '2304030700', '查看权限', null, '/holdingmanage/holding/holdingDetails.action', null, '23', '1', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304030800', '2304030000', '可撤销成交', '29_29.gif', '/holdingmanage/revocationHolding/*', '/holdingmanage/revocationHolding/holdingList_revocable.action?sortColumns=order+by+holdingId+desc', '23', '8', '0', '0', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304030801', '2304030800', '查看权限', null, '/holdingmanage/revocationHolding/holdingDetails.action', null, '23', '2', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304030802', '2304030800', '关闭权限', null, '/holdingmanage/revocationHolding/withdrawTrade.action', null, '23', '1', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304030900', '2304030000', '协议交收合同查询', '29_29.gif', '/trademanage/tradeContract/*', '/trademanage/tradeContract/list.action?sortColumns=order+by+time+desc', '23', '9', '0', '0', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304030901', '2304030900', '查看权限', null, '/trademanage/tradeContract/tradeDetails.action', null, '23', '1', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304030910', '2304030901', '协议交收合同预览', null, '/trademanage/tradeContract/showTrade.action', null, '23', '1', '0', '0', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304031000', '2304030000', '自主交收合同查询', '29_29.gif', '/trademanage/tradeAutoContract/*', '/trademanage/tradeAutoContract/list.action?sortColumns=order+by+time+desc', '23', '10', '0', '0', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304031001', '2304031000', '查看权限', null, '/trademanage/tradeAutoContract/tradeDetails.action', null, '23', '1', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304031010', '2304031001', '自主交收合同预览', null, '/trademanage/tradeAutoContract/showTrade.action', null, '23', '1', '0', '0', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304031100', '2304030000', '违约申请查询', '29_29.gif', '/trademanage/breachApply/*', '/trademanage/breachApply/list.action?sortColumns=order+by+breachApplyId+desc', '23', '11', '0', '0', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304031200', '2304030000', '委托审核', '29_29.gif', '/ordermanage/auditOrder/*', '/ordermanage/auditOrder/list_audit.action?sortColumns=order+by+orderTime+desc', '23', '12', '0', '0', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304031201', '2304031200', '查看权限', null, '/ordermanage/auditOrder/orderDetails.action', null, '23', '1', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304031202', '2304031200', '审核通过权限', null, '/ordermanage/auditOrder/pass_audit.action', null, '23', '2', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304031203', '2304031200', '审核不通过权限', null, '/ordermanage/auditOrder/unpass_audit.action', null, '23', '3', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304031300', '2304030000', '追缴货款审核', '29_29.gif', '/trademanage/goodsMoneyApply/*', '/trademanage/goodsMoneyApply/list.action?sortColumns=order+by+id+desc', '23', '13', '0', '0', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304031301', '2304031300', '处理权限', null, '/trademanage/goodsMoneyApply/processApply.action', null, '23', '1', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304031302', '2304031300', '撤销权限', null, '/trademanage/goodsMoneyApply/revocationApply.action', null, '23', '2', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304031400', '2304030000', '异常合同处理', '29_29.gif', '/trademanage/auditTrade/*', '/trademanage/auditTrade/list_audit.action?sortColumns=order+by+time+desc', '23', '14', '0', '0', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304031401', '2304031400', '查看权限', null, '/trademanage/auditTrade/tradeDetails.action', null, '23', '1', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304031402', '2304031400', '处理待违约处理合同权限', null, '/trademanage/auditTrade/breach_process.action', null, '23', '2', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304031403', '2304031400', '恢复待违约处理合同权限', null, '/trademanage/auditTrade/breach_perform.action', null, '23', '3', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304031500', '2304030000', '结束合同申请管理', '29_29.gif', '/trademanage/endTradeApply/*', '/trademanage/endTradeApply/list.action?sortColumns=order+by+applyId+desc', '23', '15', '0', '0', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2801000000', '9900000000', '银行接口', null, null, null, '28', '1', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2801010000', '2801000000', '银行管理', '42_42.gif', null, null, '28', '1', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2801010100', '2801010000', '银行列表', '29_29.gif', '/bank/bank/*', '/bank/bank/bankList.action?sortColumns=order+by+bankID', '28', '1', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2801010101', '2801010100', '银行详情', null, '/bank/bank/updateBank*', '/bank/bank/updateBankForward.action', '28', '1', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2801010102', '2801010101', '修改银行信息', null, '/bank/bank/updateBank*', '/bank/bank/updateBank.action', '28', '2', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2801010103', '2801010100', '禁用银行', null, '/bank/bank/forbiddenBank.action', null, '28', '3', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2801010104', '2801010100', '启用银行', null, '/bank/bank/startUsingBank.action', null, '28', '4', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2801010105', '2801010100', '手续费设置跳转', null, '/bank/fee/setUpBankFee*', '/bank/fee/setUpBankFeeForward.action', '28', '5', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2801010106', '2801010105', '手续费设置', null, '/bank/fee/setUpBankFee*', '/bank/fee/setUpBankFee.action', '28', '6', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2801020000', '2801000000', '交易商管理', '42_42.gif', null, null, '28', '2', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2801020100', '2801020000', '交易商列表', '29_29.gif', '/bank/firm/*', '/bank/firm/firmList.action?sortColumns=order+by+firmID', '28', '1', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2801020101', '2801020100', '交易商详情', null, '/bank/firm/updateFirm*', '/bank/firm/updateFirmForward.action', '28', '1', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2801020102', '2801020101', '修改交易商', null, '/bank/firm/updateFirm*', '/bank/firm/updateFirm.action', '28', '2', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2801020103', '2801020100', '手续费设置跳转', null, '/bank/fee/setUpFirmFee*', '/bank/fee/setUpFirmFeeForward.action', '28', '3', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2801020104', '2801020103', '手续费设置', null, '/bank/fee/setUpFirmFee*', '/bank/fee/setUpFirmFee.action', '28', '4', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2801020105', '2801020000', '交易商绑定信息查询', null, '/bank/firmregistbank/*', '/bank/firmregistbank/firmIDRegistList.action?sortColumns=order+by+bank.bankID', '28', '5', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2801020106', '2801020105', '注册交易商关联信息跳转', null, '/bank/firmregistbank/addRegist*', '/bank/firmregistbank/addRegistForward.action', '28', '6', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2801020107', '2801020106', '注册交易商关联信息', null, '/bank/firmregistbank/addRegist*', '/bank/firmregistbank/addRegist.action', '28', '7', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2801020108', '2801020105', '修改交易商关联信息跳转', null, '/bank/firmregistbank/updateRegist*', '/bank/firmregistbank/updateRegistForward.action', '28', '8', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2801020109', '2801020108', '修改交易商关联信息', null, '/bank/firmregistbank/updateRegist*', '/bank/firmregistbank/updateRegist.action', '28', '9', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2801020110', '2801020105', '同步银行账号', null, '/bank/firmregistbank/synchroRegist.action', '/bank/firmregistbank/synchroRegist.action', '28', '10', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2801020111', '2801020105', '签约银行账号', null, '/bank/firmregistbank/openRegist.action', '/bank/firmregistbank/openRegist.action', '28', '11', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2801020112', '2801020105', '注销银行账号', null, '/bank/firmregistbank/delRegist.action', '/bank/firmregistbank/delRegist.action', '28', '12', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2801020113', '2801020105', '禁用银行账号', null, '/bank/firmregistbank/forbidRegist.action', '/bank/firmregistbank/forbidRegist.action', '28', '13', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2801020114', '2801020105', '恢复银行账号', null, '/bank/firmregistbank/recoverRegist.action', '/bank/firmregistbank/recoverRegist.action', '28', '14', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2801020115', '2801020105', '重置密码', null, '/bank/firmregistbank/resetsmmy.action', '/bank/firmregistbank/resetsmmy.action', '28', '15', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2801030000', '2801000000', '出入金管理', '42_42.gif', null, null, '28', '3', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2801030100', '2801030000', '资金流水', '29_29.gif', '/bank/capital/*', '/bank/capital/capitalInfoList.action?sortColumns=order+by+id+desc', '28', '1', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2801030200', '2801030000', '出金审核', '29_29.gif', '/bank/capital/*', '/bank/capital/outMoneyAuditList.action?sortColumns=order+by+id+desc', '28', '2', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2801030201', '2801030200', '出金审核通过', null, '/bank/capital/outMoneyAuditPass.action', null, '28', '1', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2801030202', '2801030200', '出金审核拒绝', null, '/bank/capital/outMoneyAuditRefuse.action', null, '28', '2', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2801030300', '2801030000', '二次审核', '29_29.gif', '/bank/capital/*', '/bank/capital/outMoneySecondAuditList.action?sortColumns=order+by+id+desc', '28', '3', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2801030301', '2801030300', '二次审核通过', null, '/bank/capital/outMoneySecondAuditPass.action', null, '28', '1', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2801030302', '2801030300', '二次审核拒绝', null, '/bank/capital/outMoneySecondAuditRefuse.action', null, '28', '2', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2801030400', '2801030000', '单边账审核', '29_29.gif', '/bank/capital/*', '/bank/capital/capitalUnilateralList.action?sortColumns=order+by+id+desc', '28', '4', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2801030401', '2801030400', '单边账审核通过', null, '/bank/capital/capitalUnilateralPass.action', null, '28', '1', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2801030402', '2801030400', '单边账审核拒绝', null, '/bank/capital/capitalUnilateralRefuse.action', null, '28', '2', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2801040000', '2801000000', '对账出入金', '42_42.gif', null, null, '28', '4', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2801040100', '2801040000', '对账', '29_29.gif', '/bank/verification/*', '/bank/verification/verificationForward.action', '28', '1', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2801040101', '2801040100', '取银行对账数据', null, '/bank/verification/getVerificationFile.action', '/bank/verification/getVerificationFile.action', '28', '1', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2801040102', '2801040100', '对出入金流水明细', null, '/bank/verification/getErrorCapitalInfo.action', '/bank/verification/getErrorCapitalInfo.action', '28', '2', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2801050000', '2801000000', '其他查询', '42_42.gif', null, null, '28', '5', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2801050100', '2801050000', '日志查询', '29_29.gif', '/bank/other/logList.action', '/bank/other/logList.action?sortColumns=order+by+logID+desc&isQueryDB=true', '28', '1', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2801050200', '2801050000', '字典查询', '29_29.gif', '/bank/other/dictionaryList.action', '/bank/other/dictionaryList.action?sortColumns=order+by+id', '28', '2', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2801040103', '2801040100', '发送清算', null, '/bank/verification/sendQsFile.action', '/bank/verification/sendQsFile.action', '28', '3', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2801040104', '2801040100', '资金核对', null, '/bank/verification/sentDZ.action', '/bank/verification/sentDZ.action', '28', '4', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2900000011', '-1', '连续现货系统合同监控', null, '/monitor/seriesspot/getTradeJson.action', null, '29', '5', '0', '-3', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2900000005', '-1', '跳转到在线人数监控页面', null, '/monitor/forward/forwardOnlineMonitor.action', null, '29', '1', '0', '-3', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2900000004', '-1', '跳转到竞价监控页面', null, '/monitor/forward/forwardVendueMonitor.action', null, '29', '1', '0', '-3', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2900000003', '-1', '跳转到连续现货监控页面', null, '/monitor/forward/forwardSeriesMonitor.action', null, '29', '1', '0', '-3', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2900000002', '-1', '跳转到现货监控页面', null, '/monitor/forward/forwardEspotMonitor.action', null, '29', '1', '0', '-3', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2900000008', '-1', '现货系统合同监控', null, '/monitor/espot/getTradeJson.action', null, '29', '3', '0', '-3', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2900000012', '-1', '连续现货系统持仓监控', null, '/monitor/seriesspot/getHoldJson.action', null, '29', '5', '0', '-3', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2900000010', '-1', '连续现货系统委托监控', null, '/monitor/seriesspot/getOrderJson.action', null, '29', '5', '0', '-3', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2900000009', '-1', '竞价系统监控', null, '/monitor/vendue/getOrderJson.action', null, '29', '4', '0', '-3', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2900000007', '-1', '现货系统委托监控', null, '/monitor/espot/getOrderJson.action', null, '29', '3', '0', '-3', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2900000006', '-1', '在线人数监控', null, '/monitor/online/getOnlineJson.action', null, '29', '2', '0', '-3', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2900000001', '-1', '跳转到监控主页面', null, '/monitor/forward/forwardMainMonitor.action', null, '29', '1', '0', '-3', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304031501', '2304031500', '处理结束合同申请权限', null, '/trademanage/endTradeApply/apply_process.action', null, '23', '1', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304031502', '2304031500', '撤销结束合同申请权限', null, '/trademanage/endTradeApply/apply_withdraw.action', null, '23', '2', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304031600', '2304030000', '溢短货款申请查询', '29_29.gif', '/trademanage/offSetApply/*', '/trademanage/offSetApply/list.action?sortColumns=order+by+offSetId+desc', '23', '16', '0', '0', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304040000', '2304000000', '委托默认参数', '42_42.gif', null, null, '23', '4', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304040100', '2304040000', '默认保证金支付期限', '29_29.gif', '/parameter/tradePreDays/*', '/parameter/tradePreDays/getTradePreDays.action', '23', '1', '0', '0', '2307', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304040101', '2304040100', '修改权限', null, '/parameter/tradePreDays/updateTradePreDays.action', null, '23', '1', '0', '1', '2307', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304040102', '2304040100', '实时生效权限', null, '/parameter/tradePreDays/updateSpendTradePreDays.action', null, '23', '2', '0', '1', '2307', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304040200', '2304040000', '默认备款备货期限', '29_29.gif', '/parameter/deliveryPreDays/*', '/parameter/deliveryPreDays/getDeliveryPreDays.action', '23', '2', '0', '0', '2307', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304040201', '2304040200', '修改权限', null, '/parameter/deliveryPreDays/updateDeliveryPreDays.action', null, '23', '1', '0', '1', '2307', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304040202', '2304040200', '实时生效权限', null, '/parameter/deliveryPreDays/updateSpendDeliveryPreDays.action', null, '23', '2', '0', '1', '2307', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304040300', '2304040000', '默认委托有效期限', '29_29.gif', '/parameter/orderValidDays/*', '/parameter/orderValidDays/getOrderValidDays.action', '23', '3', '0', '0', '2307', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304040301', '2304040300', '修改权限', null, '/parameter/orderValidDays/updateOrderValidDays.action', null, '23', '1', '0', '1', '2307', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304040302', '2304040300', '实时生效权限', null, '/parameter/orderValidDays/updateSpendOrderValidDays.action', null, '23', '2', '0', '1', '2307', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304050000', '2304000000', '个性化交易参数', '42_42.gif', null, null, '23', '5', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304050100', '2304050000', '委托审核', '29_29.gif', '/parameter/orderPropsAudit/*', '/parameter/orderPropsAudit/getOrderProps.action', '23', '1', '0', '0', '2307', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304050101', '2304050100', '修改权限', null, '/parameter/orderPropsAudit/update*', null, '23', '1', '0', '1', '2307', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304050200', '2304050000', '交易权限', '29_29.gif', '/parameter/tradeRight/*', '/parameter/tradeRight/list.action?sortColumns=order+by+tradeRightId', '23', '2', '0', '0', '2307', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304050201', '2304050200', '查看权限', null, '/parameter/tradeRight/modTradeRight.action', null, '23', '1', '0', '1', '2307', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304050202', '2304050200', '添加权限', null, '/parameter/tradeRight/add*', null, '23', '2', '0', '1', '2307', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304050203', '2304050201', '修改权限', null, '/parameter/tradeRight/updateTradeRight.action', null, '23', '3', '0', '1', '2307', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304050204', '2304050200', '删除权限', null, '/parameter/tradeRight/deleteTradeRight.action', null, '23', '4', '0', '1', '2307', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304050300', '2304050000', '交易手续费', '29_29.gif', '/parameter/firmTradeFee/*', '/parameter/firmTradeFee/list.action?sortColumns=order+by+primary.firm.firmId', '23', '3', '0', '0', '2307', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304050301', '2304050300', '查看权限', null, '/parameter/firmTradeFee/forwardFirmTradeFee.action', null, '23', '1', '0', '1', '2307', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304050302', '2304050300', '添加权限', null, '/parameter/firmTradeFee/add*', null, '23', '2', '0', '1', '2307', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304050303', '2304050301', '修改权限', null, '/parameter/firmTradeFee/updateFirmTradeFee.action', null, '23', '3', '0', '1', '2307', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304050304', '2304050300', '删除权限', null, '/parameter/firmTradeFee/deleteFirmTradeFee.action', null, '23', '4', '0', '1', '2307', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304050400', '2304050000', '交收手续费', '29_29.gif', '/parameter/firmDeliveryFee/*', '/parameter/firmDeliveryFee/list.action?sortColumns=order+by+primary.firm.firmId', '23', '4', '0', '0', '2307', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304050401', '2304050400', '查看权限', null, '/parameter/firmDeliveryFee/forwardFirmDeliveryFee.action', null, '23', '1', '0', '1', '2307', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304050402', '2304050400', '添加权限', null, '/parameter/firmDeliveryFee/add*', null, '23', '2', '0', '1', '2307', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304050403', '2304050401', '修改权限', null, '/parameter/firmDeliveryFee/updateFirmDeliveryFee.action', null, '23', '3', '0', '1', '2307', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304050404', '2304050400', '删除权限', null, '/parameter/firmDeliveryFee/deleteFirmDeliveryFee.action', null, '23', '4', '0', '1', '2307', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304050500', '2304050000', '履约保证金', '29_29.gif', '/parameter/firmDeliveryMargin/*', '/parameter/firmDeliveryMargin/list.action?sortColumns=order+by+primary.firm.firmId', '23', '5', '0', '0', '2307', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304050501', '2304050500', '查看权限', null, '/parameter/firmDeliveryMargin/forwardFirmDeliveryMargin.action', null, '23', '1', '0', '1', '2307', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304050502', '2304050500', '添加权限', null, '/parameter/firmDeliveryMargin/add*', null, '23', '2', '0', '1', '2307', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304050503', '2304050501', '修改权限', null, '/parameter/firmDeliveryMargin/updateFirmDeliveryMargin.action', null, '23', '3', '0', '1', '2307', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304050504', '2304050500', '删除权限', null, '/parameter/firmDeliveryMargin/deleteFirmDeliveryMargin.action', null, '23', '4', '0', '1', '2307', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304060000', '2304000000', '系统默认交易参数', '42_42.gif', null, null, '23', '6', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304060100', '2304060000', '默认交易手续费', '29_29.gif', '/parameter/poundage/*', '/parameter/poundage/getPoundage.action', '23', '1', '0', '0', '2307', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304060101', '2304060100', '修改权限', null, '/parameter/poundage/updatePoundage.action', null, '23', '1', '0', '1', '2307', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304060102', '2304060100', '实时生效权限', null, '/parameter/poundage/updateSpendPoundage.action', null, '23', '2', '0', '1', '2307', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304060200', '2304060000', '默认交收手续费', '29_29.gif', '/parameter/deliveryFee/*', '/parameter/deliveryFee/getDeliveryFee.action', '23', '2', '0', '0', '2307', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304060201', '2304060200', '修改权限', null, '/parameter/deliveryFee/updateDeliveryFee.action', null, '23', '1', '0', '1', '2307', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304060202', '2304060200', '实时生效权限', null, '/parameter/deliveryFee/updateSpendDeliveryFee.action', null, '23', '2', '0', '1', '2307', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304060300', '2304060000', '单笔委托诚信保障金', '29_29.gif', '/parameter/margin/*', '/parameter/margin/getMargin.action', '23', '3', '0', '0', '2307', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304060301', '2304060300', '修改权限', null, '/parameter/margin/updateMargin.action', null, '23', '1', '0', '1', '2307', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304060302', '2304060300', '实时生效权限', null, '/parameter/margin/updateSpendMargin.action', null, '23', '2', '0', '1', '2307', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304060400', '2304060000', '最低诚信保障金', '29_29.gif', '/parameter/subscription/*', '/parameter/subscription/getSubscription.action', '23', '4', '0', '0', '2307', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304060401', '2304060400', '修改权限', null, '/parameter/subscription/updateSubscription.action', null, '23', '1', '0', '1', '2307', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304060402', '2304060400', '实时生效权限', null, '/parameter/subscription/updateSpendSubscription.action', null, '23', '2', '0', '1', '2307', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304060500', '2304060000', '货款支付比例设置', '29_29.gif', '/parameter/restPayment/*', '/parameter/restPayment/getPayment.action', '23', '5', '0', '0', '2307', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304060501', '2304060500', '修改权限', null, '/parameter/restPayment/updatePayment.action', null, '23', '1', '0', '1', '2307', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304060502', '2304060500', '实时生效权限', null, '/parameter/restPayment/updateSpendPayment.action', null, '23', '2', '0', '1', '2307', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304060600', '2304060000', '最低履约保证金', '29_29.gif', '/parameter/deliveryMargin/*', '/parameter/deliveryMargin/getDeliveryMargin.action', '23', '6', '0', '0', '2307', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304060601', '2304060600', '修改权限', null, '/parameter/deliveryMargin/updateDeliveryMargin.action', null, '23', '1', '0', '1', '2307', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304060602', '2304060600', '实时生效权限', null, '/parameter/deliveryMargin/updateSpendDeliveryMargin.action', null, '23', '2', '0', '1', '2307', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304060700', '2304060000', '溢短比例', '29_29.gif', '/parameter/offset/*', '/parameter/offset/getOffset.action', '23', '7', '-1', '0', '2307', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304060701', '2304060700', '修改权限', null, '/parameter/offset/updateOffset.action', null, '23', '1', '-1', '1', '2307', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304060702', '2304060700', '实时生效权限', null, '/parameter/offset/updateSpendOffset.action', null, '23', '2', '-1', '1', '2307', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304070000', '2304000000', '仲裁处理', '42_42.gif', null, null, '23', '2', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304070100', '2304070000', '退货处理', '29_29.gif', '/trade/returnedGoods/*', '/trade/returnedGoods/returnedGoodsList.action?sortColumns=order+by+result+,+applyTime+desc', '23', '1', '0', '0', '2304', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304070101', '2304070100', '修改权限', null, '/trade/returnedGoods/dispose*', null, '23', '1', '0', '1', '2304', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304070200', '2304070000', '退款处理', '29_29.gif', '/trade/refund/*', '/trade/refund/refundList.action?sortColumns=order+by+result+,+applyTime+desc', '23', '2', '0', '0', '2304', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304070201', '2304070200', '修改权限', null, '/trade/refund/dispose*', null, '23', '1', '0', '1', '2304', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304070300', '2304070000', '投诉处理', '29_29.gif', '/trade/complaint/*', '/trade/complaint/complaintList.action?sortColumns=order+by+result+,+applyTime+desc', '23', '3', '0', '0', '2304', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304070301', '2304070300', '修改权限', null, '/trade/complaint/dispose*', null, '23', '1', '0', '1', '2304', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304080000', '2304000000', '结算处理', '42_42.gif', null, null, '23', '8', '-1', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304080100', '2304080000', '结算执行', '29_29.gif', null, null, '23', '1', '-1', '0', '2306', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2304080200', '2304080000', '结算设置', '29_29.gif', null, null, '23', '2', '-1', '0', '2306', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2305000000', '9900000000', '委托预处理', null, null, null, '23', '5', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2305010000', '2305000000', '预备委托', '42_42.gif', null, null, '23', '1', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2305010100', '2305010000', '预备委托列表', '29_29.gif', '/preordermanage/*', '/preordermanage/goodsResourceList.action?sortColumns=order+by+resourceId+desc&isQueryDB=true', '23', '1', '0', '0', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2305010101', '2305010100', '查看权限', null, '/preordermanage/updateForwardGoodsResource.action', null, '23', '1', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2305010102', '2305010100', '查看图片权限', null, '/preordermanage/showImages.action', null, '23', '2', '0', '1', null, 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2305020000', '2305000000', '模版管理', '42_42.gif', null, null, '23', '2', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2305020100', '2305020000', '委托模版', '29_29.gif', '/template/*', '/template/list.action?sortColumns=order+by+templateID+desc', '23', '2', '0', '0', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2305020101', '2305020100', '详情权限', null, '/template/forwardGoodsTemplateDetails.action', null, '23', '1', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2305020102', '2305020100', '修改跳转权限', null, '/template/forwardGoodsTemplate.action', null, '23', '2', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2305020103', '2305020100', '添加权限', null, '/template/add*', null, '23', '3', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2305020104', '2305020102', '修改权限', null, '/template/updateGoodsTemplate.action', null, '23', '4', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2305020105', '2305020103', '查看品名权限', null, '/template/json/getBreedByCategoryID.action', '/template/json/getBreedByCategoryID.action', '23', '5', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2305020106', '2305020103', '查看属性权限', null, '/template/json/getPropertyValueByBreedID.action', '/template/json/getPropertyValueByBreedID.action', '23', '6', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501050401', '1501050400', '成交统计量查看权限', null, '/timebargain/tradeMonthReport/tradeMonth*', null, '15', '1', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501050402', '1501050400', '成交统计量跳转权限', null, '/mgr/app/timebargain/printReport/tradeMonthReport*', null, '15', '2', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501050500', '1501050000', '成交记录', '29_29.gif', '/timebargain/bargainResultReport/bargainResultQuery.action', '/timebargain/bargainResultReport/bargainResultQuery.action', '15', '5', '0', '0', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501050501', '1501050500', '成交记录查看权限', null, '/timebargain/bargainResultReport/bargainResult*', null, '15', '1', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501050502', '1501050500', '成交记录跳转权限', null, '/mgr/app/timebargain/printReport/bargainResultReport*', null, '15', '2', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501050600', '1501050000', '订货汇总', '29_29.gif', '/timebargain/indentCollectReport/indentCollectQuery.action', '/timebargain/indentCollectReport/indentCollectQuery.action', '15', '6', '0', '0', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501050601', '1501050600', '订货汇总查看权限', null, '/timebargain/indentCollectReport/indentCollect*', null, '15', '1', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501050602', '1501050600', '订货汇总跳转权限', null, '/mgr/app/timebargain/printReport/indentCollectReport*', null, '15', '2', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501050700', '1501050000', '订货汇总(市值)', '29_29.gif', '/timebargain/ownGoodsCollectReport/ownGoodsCollectQuery.action', '/timebargain/ownGoodsCollectReport/ownGoodsCollectQuery.action', '15', '7', '0', '0', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501050701', '1501050700', '订货汇总(市值)查看权限', null, '/timebargain/ownGoodsCollectReport/ownGoodsCollect*', null, '15', '1', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501050702', '1501050700', '订货汇总(市值)跳转权限', null, '/mgr/app/timebargain/printReport/ownGoodsCollectReport*', null, '15', '2', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501050800', '1501050000', '资金日报表', '29_29.gif', '/timebargain/delayFinanceReport/delayFinanceQuery.action', '/timebargain/delayFinanceReport/delayFinanceQuery.action', '15', '8', '0', '0', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501050801', '1501050800', '资金日报表查看权限', null, '/timebargain/delayFinanceReport/delayFinance*', null, '15', '1', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501050802', '1501050800', '资金日报表跳转权限', null, '/mgr/app/timebargain/printReport/delayFinanceReport*', null, '15', '2', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501050900', '1501050000', '资金月报表', '29_29.gif', '/timebargain/monthFinanceReport/monthFinanceQuery.action', '/timebargain/monthFinanceReport/monthFinanceQuery.action', '15', '9', '0', '0', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501050901', '1501050900', '资金月报表查看权限', null, '/timebargain/monthFinanceReport/monthFinance*', null, '15', '1', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501050902', '1501050900', '资金月报表跳转权限', null, '/mgr/app/timebargain/printReport/monthFinanceReport*', null, '15', '2', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501051000', '1501050000', '资金不足情况', '29_29.gif', '/timebargain/tradeUserNotEnoughMoneyReport/tradeUserNotEnoughMoneyQuery.action', '/timebargain/tradeUserNotEnoughMoneyReport/tradeUserNotEnoughMoneyQuery.action', '15', '10', '0', '0', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501051001', '1501051000', '资金不足情况查看权限', null, '/timebargain/tradeUserNotEnoughMoneyReport/tradeUserNotEnoughMoney*', null, '15', '1', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501051002', '1501051000', '资金不足情况跳转权限', null, '/mgr/app/timebargain/printReport/tradeUserNotEnoughMoneyReport*', null, '15', '2', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501051100', '1501050000', '出入金记录', '29_29.gif', '/timebargain/cushInAndOutReport/cushInAndOutQuery.action', '/timebargain/cushInAndOutReport/cushInAndOutQuery.action', '15', '11', '0', '0', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501051101', '1501051100', '出入金记录查看权限', null, '/timebargain/cushInAndOutReport/cushInAndOut*', null, '15', '1', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501051102', '1501051100', '出入金记录跳转权限', null, '/mgr/app/timebargain/printReport/cushInAndOutReport*', null, '15', '2', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501051200', '1501050000', '浮动亏损统计表', '29_29.gif', '/timebargain/superAddBailReport/superAddBailQuery.action', '/timebargain/superAddBailReport/superAddBailQuery.action', '15', '12', '0', '0', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501051201', '1501051200', '浮动亏损统计表查看权限', null, '/timebargain/superAddBailReport/superAddBail*', null, '15', '1', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501051202', '1501051200', '浮动亏损统计表跳转权限', null, '/mgr/app/timebargain/printReport/superAddBailReport*', null, '15', '2', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501051300', '1501050000', '转让与交收盈亏', '29_29.gif', '/timebargain/tAPLStatisticReport/tAPLStatisticQuery.action', '/timebargain/tAPLStatisticReport/tAPLStatisticQuery.action', '15', '13', '0', '0', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501051301', '1501051300', '转让与交收盈亏查看权限', null, '/timebargain/tAPLStatisticReport/tAPLStatistic*', null, '15', '1', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501051302', '1501051300', '转让与交收盈亏跳转权限', null, '/mgr/app/timebargain/printReport/tAPLStatisticReport*', null, '15', '2', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501051400', '1501050000', '手续费统计', '29_29.gif', '/timebargain/serviceFeeReport/serviceFeeQuery.action', '/timebargain/serviceFeeReport/serviceFeeQuery.action', '15', '14', '0', '0', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501051401', '1501051400', '手续费统计查看权限', null, '/timebargain/serviceFeeReport/serviceFee*', null, '15', '1', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501051402', '1501051400', '手续费统计跳转权限', null, '/mgr/app/timebargain/printReport/serviceFeeReport*', null, '15', '2', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501051500', '1501050000', '订货明细', '29_29.gif', '/timebargain/indentDetailReport/indentDetailQuery.action', '/timebargain/indentDetailReport/indentDetailQuery.action', '15', '15', '0', '0', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501051501', '1501051500', '订货明细查看权限', null, '/timebargain/indentDetailReport/indentDetail*', null, '15', '1', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501051502', '1501051500', '订货明细跳转权限', null, '/mgr/app/timebargain/printReport/indentDetailReport*', null, '15', '2', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501051600', '1501050000', '订货统计', '29_29.gif', '/timebargain/indentStatisticReport/indentStatisticQuery.action', '/timebargain/indentStatisticReport/indentStatisticQuery.action', '15', '16', '0', '0', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501051601', '1501051600', '订货统计查看权限', null, '/timebargain/indentStatisticReport/indentStatistic*', null, '15', '1', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501051602', '1501051600', '订货统计跳转权限', null, '/mgr/app/timebargain/printReport/indentStatisticReport*', null, '15', '2', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501051700', '1501050000', '委托情况', '29_29.gif', '/timebargain/ordersReport/ordersQuery.action', '/timebargain/ordersReport/ordersQuery.action', '15', '17', '0', '0', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501051701', '1501051700', '委托情况查看权限', null, '/timebargain/ordersReport/orders*', null, '15', '1', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501051702', '1501051700', '委托情况跳转权限', null, '/mgr/app/timebargain/printReport/ordersReport*', null, '15', '2', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501051800', '1501050000', '当日分商品成交量', '29_29.gif', '/timebargain/comTradedayReport/comTradedayQuery.action', '/timebargain/comTradedayReport/comTradedayQuery.action', '15', '18', '0', '0', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501051801', '1501051800', '当日分商品成交量查看权限', null, '/timebargain/comTradedayReport/comTradeday*', null, '15', '1', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501051802', '1501051800', '当日分商品成交量跳转权限', null, '/mgr/app/timebargain/printReport/comTradedayReport*', null, '15', '2', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501051900', '1501050000', '分商品成交量', '29_29.gif', '/timebargain/comTradeReport/comTradeQuery.action', '/timebargain/comTradeReport/comTradeQuery.action', '15', '19', '0', '0', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501051901', '1501051900', '分商品成交量查看权限', null, '/timebargain/comTradeReport/comTrade*', null, '15', '1', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501051902', '1501051900', '分商品成交量跳转权限', null, '/mgr/app/timebargain/printReport/comTradeReport*', null, '15', '2', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501052000', '1501050000', '分交易商成交量', '29_29.gif', '/timebargain/comTradeDayRecordReport/comTradeDayRecordQuery.action', '/timebargain/comTradeDayRecordReport/comTradeDayRecordQuery.action', '15', '20', '0', '0', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501052001', '1501052000', '分交易商成交量查看权限', null, '/timebargain/comTradeDayRecordReport/comTradeDayRecord*', null, '15', '1', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501052002', '1501052000', '分交易商成交量跳转权限', null, '/mgr/app/timebargain/printReport/comTradeDayRecordReport*', null, '15', '2', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501052100', '1501050000', '分商品成交记录', '29_29.gif', '/timebargain/commodityTradeDayRecordReport/commodityTradeDayRecordQuery.action', '/timebargain/commodityTradeDayRecordReport/commodityTradeDayRecordQuery.action', '15', '21', '0', '0', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501052101', '1501052100', '分商品成交记录查看权限', null, '/timebargain/commodityTradeDayRecordReport/commodityTradeDayRecord*', null, '15', '1', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501052102', '1501052100', '分商品成交记录跳转权限', null, '/mgr/app/timebargain/printReport/commodityTradeDayRecordReport*', null, '15', '2', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501052200', '1501050000', '当日成交记录', '29_29.gif', '/timebargain/tradeDayResultReport/tradeDayResultQuery.action', '/timebargain/tradeDayResultReport/tradeDayResultQuery.action', '15', '22', '0', '0', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501052201', '1501052200', '当日成交记录查看权限', null, '/timebargain/tradeDayResultReport/tradeDayResult*', null, '15', '1', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501052202', '1501052200', '当日成交记录跳转权限', null, '/mgr/app/timebargain/printReport/tradeDayResultReport*', null, '15', '2', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501052300', '1501050000', '每日收市行情', '29_29.gif', '/timebargain/dayHQReport/dayHQQuery.action', '/timebargain/dayHQReport/dayHQQuery.action', '15', '23', '0', '0', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501052301', '1501052300', '每日收市行情查看权限', null, '/timebargain/dayHQReport/dayHQ*', null, '15', '1', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501052302', '1501052300', '每日收市行情跳转权限', null, '/mgr/app/timebargain/printReport/dayHQReport*', null, '15', '2', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501052400', '1501050000', '行情统计', '29_29.gif', '/timebargain/HQStatisticReport/HQStatisticQuery.action', '/timebargain/HQStatisticReport/HQStatisticQuery.action', '15', '24', '0', '0', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501052401', '1501052400', '行情统计查看权限', null, '/timebargain/HQStatisticReport/HQStatistic*', null, '15', '1', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501052402', '1501052400', '行情统计跳转权限', null, '/mgr/app/timebargain/printReport/HQStatisticReport*', null, '15', '2', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501052500', '1501050000', '抵顶记录', '29_29.gif', '/timebargain/supportsRecordReport/supportsRecordQuery.action', '/timebargain/supportsRecordReport/supportsRecordQuery.action', '15', '25', '0', '0', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501052501', '1501052500', '抵顶记录查看权限', null, '/timebargain/supportsRecordReport/supportsRecord*', null, '15', '1', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501052502', '1501052500', '抵顶记录跳转权限', null, '/mgr/app/timebargain/printReport/supportsRecordReport*', null, '15', '2', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501052600', '1501050000', '交收记录', '29_29.gif', '/timebargain/tradeResultReport/tradeResultQuery.action', '/timebargain/tradeResultReport/tradeResultQuery.action', '15', '26', '0', '0', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501052601', '1501052600', '交收记录查看权限', null, '/timebargain/tradeResultReport/tradeResult*', null, '15', '1', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501052602', '1501052600', '交收记录跳转权限', null, '/mgr/app/timebargain/printReport/tradeResultReport*', null, '15', '2', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501052700', '1501050000', '协议交收记录', '29_29.gif', '/timebargain/agreePCRecordReport/agreePCRecordQuery.action', '/timebargain/agreePCRecordReport/agreePCRecordQuery.action', '15', '27', '0', '0', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501052701', '1501052700', '协议交收记录查看权限', null, '/timebargain/agreePCRecordReport/agreePCRecord*', null, '15', '1', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501052702', '1501052700', '协议交收记录跳转权限', null, '/mgr/app/timebargain/printReport/agreePCRecordReport*', null, '15', '2', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501052800', '1501050000', '交收汇总', '29_29.gif', '/timebargain/bargainOnCollectReport/bargainOnCollectQuery.action', '/timebargain/bargainOnCollectReport/bargainOnCollectQuery.action', '15', '28', '0', '0', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501052801', '1501052800', '交收汇总查看权限', null, '/timebargain/bargainOnCollectReport/bargainOnCollect*', null, '15', '1', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501052802', '1501052800', '交收汇总跳转权限', null, '/mgr/app/timebargain/printReport/bargainOnCollectReport*', null, '15', '2', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501052900', '1501050000', '交收情况', '29_29.gif', '/timebargain/firmSettleReport/firmSettleQuery.action', '/timebargain/firmSettleReport/firmSettleQuery.action', '15', '29', '0', '0', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501052901', '1501052900', '交收情况查看权限', null, '/timebargain/firmSettleReport/firmSettle*', null, '15', '1', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501052902', '1501052900', '交收情况跳转权限', null, '/mgr/app/timebargain/printReport/firmSettleReport*', null, '15', '2', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501053000', '1501050000', '加盟商资金报表', '29_29.gif', '/timebargain/brokerFundflowReport/brokerFundflowQuery.action', '/timebargain/brokerFundflowReport/brokerFundflowQuery.action', '15', '30', '0', '0', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501053001', '1501053000', '加盟商资金报表查看权限', null, '/timebargain/brokerFundflowReport/brokerFundflow*', null, '15', '1', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501053002', '1501053000', '加盟商资金报表跳转权限', null, '/mgr/app/timebargain/printReport/brokerFundflowReport*', null, '15', '2', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501053100', '1501050000', '交易商分商品盈亏表', '29_29.gif', '/timebargain/firmCommodityTradePLReport/firmCommodityTradePLQuery.action', '/timebargain/firmCommodityTradePLReport/firmCommodityTradePLQuery.action', '15', '31', '0', '0', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501053101', '1501053100', '交易商分商品盈亏表查看权限', null, '/timebargain/firmCommodityTradePLReport/firmCommodityTradePL*', null, '15', '1', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501053102', '1501053100', '交易商分商品盈亏表跳转权限', null, '/mgr/app/timebargain/printReport/firmCommodityTradePLReport*', null, '15', '2', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501053200', '1501050000', '交易商分商品成交表', '29_29.gif', '/timebargain/firmCommodityTradeReport/firmCommodityTradeQuery.action', '/timebargain/firmCommodityTradeReport/firmCommodityTradeQuery.action', '15', '32', '0', '0', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501053201', '1501053200', '交易商分商品成交表查看权限', null, 'timebargain/firmCommodityTradeReport/firmCommodityTrade*', null, '15', '1', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501053202', '1501053200', '交易商分商品成交表跳转权限', null, '/mgr/app/timebargain/printReport/firmCommodityTradeReport*', null, '15', '2', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501053300', '1501050000', '商品综合汇总表', '29_29.gif', '/timebargain/contractCollectReport/contractCollectQuery.action', '/timebargain/contractCollectReport/contractCollectQuery.action', '15', '33', '0', '0', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501053301', '1501053300', '商品综合汇总表查看权限', null, '/timebargain/contractCollectReport/contractCollect*', null, '15', '1', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501053302', '1501053300', '商品综合汇总表跳转权限', null, '/mgr/app/timebargain/printReport/contractCollectReport*', null, '15', '2', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501053400', '1501050000', '交易商历史成交情况汇总', '29_29.gif', '/timebargain/brokerFirmTradeReport/brokerFirmTradeQuery.action', '/timebargain/brokerFirmTradeReport/brokerFirmTradeQuery.action', '15', '34', '0', '0', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501053401', '1501053400', '交易商历史成交情况汇总查看权限', null, '/timebargain/brokerFirmTradeReport/brokerFirmTrade*', null, '15', '1', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501053402', '1501053400', '交易商历史成交情况汇总跳转权限', null, '/mgr/app/timebargain/printReport/brokerFirmTradeReport*', null, '15', '2', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501053500', '1501050000', '分加盟商成交统计表', '29_29.gif', '/timebargain/tradeBybrokerReport/tradeBybrokerQuery.action', '/timebargain/tradeBybrokerReport/tradeBybrokerQuery.action', '15', '35', '0', '0', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501053501', '1501053500', '分加盟商成交统计表查看权限', null, '/timebargain/tradeBybrokerReport/tradeBybroker*', null, '15', '1', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501053502', '1501053500', '分加盟商成交统计表跳转权限', null, '/mgr/app/timebargain/printReport/tradeBybrokerReport*', null, '15', '2', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501053600', '1501050000', '分加盟商订货统计表', '29_29.gif', '/timebargain/holdBybrokerReport/holdBybrokerQuery.action', '/timebargain/holdBybrokerReport/holdBybrokerQuery.action', '15', '36', '0', '0', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501053601', '1501053600', '分加盟商订货统计表查看权限', null, '/timebargain/holdBybrokerReport/holdBybroker*', null, '15', '1', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501053602', '1501053600', '分加盟商订货统计表跳转权限', null, '/mgr/app/timebargain/printReport/holdBybrokerReport*', null, '15', '2', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501053700', '1501050000', '分加盟商综合统计表', '29_29.gif', '/timebargain/brokerAllReport/brokerAllQuery.action', '/timebargain/brokerAllReport/brokerAllQuery.action', '15', '37', '0', '0', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501053701', '1501053700', '分加盟商综合统计表查看权限', null, '/timebargain/brokerAllReport/brokerAll*', null, '15', '1', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501053702', '1501053700', '分加盟商综合统计表跳转权限', null, '/mgr/app/timebargain/printReport/brokerAllReport*', null, '15', '2', '0', '1', '1507', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501060100', '1501060000', '交收属性管理', '29_29.gif', '/timebargain/settleProps/listCommodity.action', '/timebargain/settleProps/listCommodity.action', '15', '1', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501060101', '1501060100', '删除权限', '29_29.gif', '/timebargain/settleProps/deleteSettleProps.action', null, '15', '1', '0', '0', '1508', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501060102', '1501060100', '跳转权限', '29_29.gif', '/timebargain/settleProps/forwardAddSettleProps.action', null, '15', '2', '0', '0', '1508', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501060103', '1501060100', 'ajax权限', '29_29.gif', '/timebargain/settleProps/jsonForSettleProps/getPropertyValueByBreedID.action', null, '15', '3', '0', '0', '1508', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501060104', '1501060100', '添加权限', '29_29.gif', '/timebargain/settleProps/addSettleProps.action', null, '15', '4', '0', '0', '1508', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501060200', '1501060000', '仓单添加', '29_29.gif', '/timebargain/bill/gageBillList/*', '/timebargain/bill/gageBillList.action', '15', '2', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501060201', '1501060200', '仓单添加权限ajax', null, '/ajaxCheck/bill/checkFirmExists.action*', null, '15', '1', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501060202', '1501060200', '仓单添加弹出查询按钮权限', null, '/timebargain/bill/getCommodity.action*', null, '15', '2', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501060203', '1501060200', '仓单添加查询仓单权限', null, '/timebargain/bill/getBillList.action*', null, '15', '3', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501060204', '1501060200', '仓单添加添加按钮权限', null, '/timebargain/bill/addGageBill.action*', null, '15', '4', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501060205', '1501060200', '仓单添加查看仓单详细信息', null, '/timebargain/bill/gageBillDetail.action*', null, '15', '5', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501060300', '1501060000', '仓单撤销', '29_29.gif', '/timebargain/bill/queryBillList*', '/timebargain/bill/queryBillList.action', '15', '3', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501060301', '1501060300', '仓单撤销撤销按钮权限', null, '/timebargain/bill/billCancel.action*', null, '15', '1', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501060400', '1501060000', '有效仓单数量', '29_29.gif', '/timebargain/bill/getValidGageBill*', '/timebargain/bill/getValidGageBill.action', '15', '4', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501060500', '1501060000', '抵顶业务', '29_29.gif', '/timebargain/applyGage/listApplyGage.action', '/timebargain/applyGage/listApplyGage.action', '15', '5', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501060503', '1501060500', '抵顶业务查看权限', '29_29.gif', '/timebargain/applyGage/viewById.action', null, '15', '3', '0', '0', '1508', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501060501', '1501060500', '抵顶业务跳转权限', '29_29.gif', '/timebargain/applyGage/forwardAddApplyGage.action', null, '15', '1', '0', '0', '1508', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501060502', '1501060500', '抵顶业务添加权限', '29_29.gif', '/timebargain/applyGage/addApplyGage.action', null, '15', '2', '0', '0', '1508', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501060504', '1501060500', '抵顶业务审核权限', '29_29.gif', '/timebargain/applyGage/auditApplyGage.action', null, '15', '4', '0', '0', '1508', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501060600', '1501060000', '抵顶数据查询', '29_29.gif', '/timebargain/bill/gageDataQuery*', '/timebargain/bill/gageDataQuery.action', '15', '6', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501060700', '1501060000', '提前交收', '29_29.gif', '/timebargain/aheadSettle/aheadSettleList.action*', '/timebargain/aheadSettle/aheadSettleList.action?sortColumns=order+by+applyID', '15', '7', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501060701', '1501060700', '提前交收申请', null, '/timebargain/aheadSettle/addAheadSettle*', null, '15', '1', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501060702', '1501060700', '可用仓单查询', null, '/timebargain/aheadSettle/getBillList.action', null, '15', '2', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501060703', '1501060700', '仓单详情查询', null, '/timebargain/aheadSettle/getBillListByApplyId.action', null, '15', '3', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501060704', '1501060700', '提前交收审核', null, '/timebargain/aheadSettle/aheadSettleAudit*', null, '15', '4', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501060800', '1501060000', '协议交收', '29_29.gif', '/timebargain/agreementSettle/agreementSettleList.action*', '/timebargain/agreementSettle/agreementSettleList.action?sortColumns=order+by+applyID+desc', '15', '8', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501060801', '1501060800', '添加权限', null, '/timebargain/agreementSettle/addAgreement*', null, '15', '1', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501060802', '1501060800', '审核跳转权限', null, '/timebargain/agreementSettle/agreementAuditForward*', null, '15', '2', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501060803', '1501060800', '审核权限', null, '/timebargain/agreementSettle/agreementCheck*', null, '15', '3', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501060900', '1501060000', '质押资金', '29_29.gif', '/timebargain/pledge/pledgeList.action*', '/timebargain/pledge/pledgeList.action?sortColumns=order+by+ID+desc', '15', '9', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501060901', '1501060900', '添加权限', null, '/timebargain/pledge/addPledge*', null, '15', '1', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501060902', '1501060900', '审核跳转权限', null, '/timebargain/pledge/pledgeAuditForward*', null, '15', '2', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501060903', '1501060900', '审核权限', null, '/timebargain/pledge/pledgeCheck*', null, '15', '3', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501060904', '1501060900', '查看权限', null, '/timebargain/pledge/getBillListByBillID*', null, '15', '4', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501061000', '1501060000', '非交易过户', '29_29.gif', '/timebargain/transfer/transferList.action*', '/timebargain/transfer/transferList.action?sortColumns=order+by+TransferID+desc', '15', '10', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501061001', '1501061000', '添加权限', null, '/timebargain/transfer/addTransfer*', null, '15', '1', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501061002', '1501061000', '删除权限', null, '/timebargain/transfer/delateTransfer*', null, '15', '2', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501061003', '1501061000', '跳转权限', null, '/timebargain/transfer/transferAuditForward*', null, '15', '3', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501061004', '1501061000', '审核权限', null, '/timebargain/transfer/transferCheck*', null, '15', '4', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501061100', '1501060000', '交收数据', '29_29.gif', '/timebargain/bill/showSettleData.action*', '/timebargain/bill/showSettleData.action', '15', '11', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501061200', '1501060000', '交收配对', '29_29.gif', '/timebargain/settleMatch/listSettleMatch.action', '/timebargain/settleMatch/listSettleMatch.action', '15', '12', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501061300', '1501060000', '配对处理', '29_29.gif', '/timebargain/settle/matchDispose/*', '/timebargain/settle/matchDispose/matchDisposeList.action?sortColumns=order+by+createTime+desc', '15', '13', '0', '0', '1508', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501061101', '1501061100', '交收数据选项卡页面', '29_29.gif', '/mgr/app/timebargain/settle/settleData_head.jsp', null, '15', '1', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501061102', '1501061100', '交收数据明细', '29_29.gif', '/timebargain/bill/listSettleDataDetail.action*', null, '15', '2', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501061103', '1501061100', '交收数据未配对数量', '29_29.gif', '/timebargain/bill/notPairTotal.action*', null, '15', '3', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501061104', '1501061100', '交收数据已配对数量', '29_29.gif', '/timebargain/bill/alreadyPairTotal.action*', null, '15', '4', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501061203', '1501061200', '添加配对', '29_29.gif', '/timebargain/settleMatch/addSettleMatch.action', null, '15', '3', '0', '0', '1508', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501061202', '1501061200', '可用仓单查询', null, '/timebargain/settleMatch/getBillList.action', null, '15', '2', '0', '1', '1508', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501061201', '1501061200', '添加跳转', '29_29.gif', '/timebargain/settleMatch/forwardAddSettleMatch.action', null, '15', '1', '0', '0', '1508', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501061303', '1501061300', '保证金转货款', null, '/timebargain/settle/matchDispose/marginToPayout.action', null, '15', '3', '0', '1', '1508', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501061304', '1501061300', '收货款', null, '/timebargain/settle/matchDispose/incomePayout.action', null, '15', '4', '0', '1', '1508', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501061305', '1501061300', '付货款', null, '/timebargain/settle/matchDispose/payPayout.action', null, '15', '5', '0', '1', '1508', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501061306', '1501061300', '货权转移', null, '/timebargain/settle/matchDispose/settleTransfer.action', null, '15', '6', '0', '1', '1508', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501061302', '1501061300', '设置升贴水', null, '/timebargain/settle/matchDispose/updateHL_Amount.action', null, '15', '2', '0', '1', '1508', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501061301', '1501061300', '查看详情', null, '/timebargain/settle/matchDispose/view*', null, '15', '1', '0', '1', '1508', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501061331', '1501061300', '配对仓单列表', null, '/timebargain/settle/matchDispose/billList.action', null, '15', '31', '0', '1', '1508', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501061309', '1501061300', '收买方违约金', null, '/timebargain/settle/matchDispose/takePenaltyFromB.action', null, '15', '8', '0', '1', '1508', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501061310', '1501061300', '收卖方违约金', null, '/timebargain/settle/matchDispose/takePenaltyFromS.action', null, '15', '8', '0', '1', '1508', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501061311', '1501061300', '买方交收盈亏', null, '/timebargain/settle/matchDispose/settlePL_B.action', null, '15', '8', '0', '1', '1508', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501061312', '1501061300', '卖方交收盈亏', null, '/timebargain/settle/matchDispose/settlePL_S.action', null, '15', '8', '0', '1', '1508', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501061313', '1501061300', '付买方违约金', null, '/timebargain/settle/matchDispose/payPenaltyToB.action', null, '15', '8', '0', '1', '1508', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501061314', '1501061300', '付卖方违约金', null, '/timebargain/settle/matchDispose/payPenaltyToS.action', null, '15', '8', '0', '1', '1508', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501061315', '1501061300', '违约处理完成', null, '/timebargain/settle/matchDispose/settleFinish_default.action', null, '15', '8', '0', '1', '1508', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501061307', '1501061300', '履约处理完成', null, '/timebargain/settle/matchDispose/settleFinish_agreement.action', null, '15', '7', '0', '1', '1508', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501061308', '1501061300', '作废', null, '/timebargain/settle/matchDispose/settleCancel.action', null, '15', '8', '0', '1', '1508', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501061330', '1501061300', '操作日志', null, '/timebargain/settle/matchDispose/settleMatchLogList.action', null, '15', '30', '0', '1', '1508', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501061332', '1501061300', '退卖方保证金', null, '/timebargain/settle/matchDispose/backSMargin.action', null, '15', '32', '0', '1', '1508', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501070100', '1501070000', '行情信息', '29_29.gif', '/mgr/app/timebargain/tradeMonitor/monitor_quotationInfo.jsp', '/mgr/app/timebargain/tradeMonitor/monitor_quotationInfo.jsp', '15', '1', '0', '0', '1509', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501070101', '1501070100', '行情信息权限', null, '/timebargain/tradeMonitor/monitor*', null, '15', '1', '0', '1', '1509', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501070200', '1501070000', '委托监控', '29_29.gif', '/timebargain/tradeMonitor/monitor*', '/timebargain/tradeMonitor/monitorGetCommodityList.action?type=orderMonitor', '15', '2', '0', '0', '1509', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501070201', '1501070200', '委托监控权限', null, '/timebargain/tradeMonitor/monitor*', null, '15', '1', '0', '1', '1509', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501070300', '1501070000', '未成交委托队列', '29_29.gif', '/timebargain/tradeMonitor/monitor*', '/timebargain/tradeMonitor/monitorGetCommodityList.action?type=unTradeInfo', '15', '3', '0', '0', '1509', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501070301', '1501070300', '未成交委托队列权限', null, '/mgr/app/timebargain/tradeMonitor/monitor_unTrade*', null, '15', '1', '0', '1', '1509', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501070302', '1501070300', '未成交委托队列查询权限', null, '/timebargain/tradeMonitor/monitor*', null, '15', '2', '0', '1', '1509', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501070400', '1501070000', '成交明细', '29_29.gif', '/timebargain/tradeMonitor/monitor*', '/timebargain/tradeMonitor/monitorGetCommodityList.action?type=tradeList', '15', '4', '0', '0', '1509', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501070401', '1501070400', '成交明细权限', null, '/timebargain/tradeMonitor/monitor*', null, '15', '1', '0', '1', '1509', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501070500', '1501070000', '成交综合统计', '29_29.gif', '/mgr/app/timebargain/tradeMonitor/monitor_tradeStatistic.jsp', '/mgr/app/timebargain/tradeMonitor/monitor_tradeStatistic.jsp', '15', '5', '0', '0', '1509', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1501070501', '1501070500', '成交综合统计权限', null, '/timebargain/tradeMonitor/monitor*', null, '15', '1', '0', '1', '1509', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2305020107', '2305020103', '查询交易模式', null, '/template/jsonForTrade/getTradeModeByBreedID.action', '/template/jsonForTrade/getTradeModeByBreedID.action', '23', '7', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2305020108', '2305020100', '删除权限', null, '/template/deleteGoodsTemplate.action', null, '23', '8', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2306000000', '9900000000', '代为交易', null, null, null, '23', '6', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2306010000', '2306000000', '交易相关', '42_42.gif', null, null, '23', '1', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2306010100', '2306010000', '发布委托', '29_29.gif', '/ordermanage/sendOrder/*', '/ordermanage/sendOrder/addOrderByFirm.action', '23', '1', '0', '0', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2306010101', '2306010100', '添加操作', null, '/ordermanage/sendOrder/add*', null, '23', '1', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2306010102', '2306010101', '查看品名权限', null, '/ordermanage/jsonForOrder/getBreedByCategoryID.action', null, '23', '2', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2306010103', '2306010101', '查看品名属性权限', null, '/ordermanage/jsonForOrder/getPropertyValueByBreedID.action', null, '23', '3', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2306010104', '2306010101', '选择仓单权限', null, '/ordermanage/sendOrder/getNotUseStock.action', null, '23', '4', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2306010105', '2306010101', '仓单展示权限', null, '/ordermanage/jsonForOrder/getStockJson.action', null, '23', '5', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2306010106', '2306010101', '选择模版权限', null, '/ordermanage/sendOrder/templateListChoose.action', null, '23', '6', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2306010107', '2306010101', '模版展示权限', null, '/template/json/getTemplateByID.action', null, '23', '7', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2306010200', '2306010000', '合同处理', '29_29.gif', '/trademanage/tradeprocess/*', '/trademanage/tradeprocess/forwardTradeProcess.action', '23', '2', '0', '0', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2306010201', '2306010200', '查看权限', null, '/trademanage/tradeprocess/getTradeByTradeNo.action', null, '23', '1', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2306010202', '2306010200', '转入保证金跳转权限', null, '/trademanage/tradeprocess/forwardPaymentReserve.action', null, '23', '2', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2306010203', '2306010200', '转入保证金操作权限', null, '/trademanage/tradeprocess/paymentReserve.action', null, '23', '3', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2306010204', '2306010200', '转入仓单跳转权限', null, '/trademanage/tradeprocess/forwardTransferGoods.action', null, '23', '4', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2306010205', '2306010200', '转入仓单操作权限', null, '/trademanage/tradeprocess/transferGoods.action', null, '23', '5', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2306010206', '2306010200', '转入货款跳转权限', null, '/trademanage/tradeprocess/forwardPaymentGoodsMoney*', null, '23', '6', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2306010207', '2306010200', '转入货款I操作权限', null, '/trademanage/tradeprocess/paymentGoodsMoney*', null, '23', '7', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2306010208', '2306010200', '关闭交易操作', null, '/trademanage/tradeprocess/withdrawTrade.action', null, '23', '8', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2306010209', '2306010200', '溢短货款申请跳转权限', null, '/trademanage/tradeprocess/forwardPerformAskOffset.action', null, '23', '9', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2306010210', '2306010200', '溢短货款申请操作权限', null, '/trademanage/tradeprocess/performAskOffset.action', null, '23', '10', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2306010211', '2306010200', '撤销溢短货款申请权限', null, '/trademanage/tradeprocess/performWithdrawOffset.action', null, '23', '11', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2306010212', '2306010200', '处理溢短货款跳转权限', null, '/trademanage/tradeprocess/forwardPerformDisposeOffset.action', null, '23', '12', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2306010213', '2306010200', '处理溢短货款操作权限', null, '/trademanage/tradeprocess/performDisposeOffset.action', null, '23', '13', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2306010214', '2306010200', '无溢短货款申请权限', null, '/trademanage/tradeprocess/noOffSetApply.action', null, '23', '14', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2306010215', '2306010200', '支付首款跳转权限', null, '/trademanage/tradeprocess/forwardPaymentMoneyToSell.action', null, '23', '15', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2306010216', '2306010200', '支付首款操作权限', null, '/trademanage/tradeprocess/paymentMoneyToSell.action', null, '23', '16', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2306010217', '2306010200', '支付二次货款跳转权限', null, '/trademanage/tradeprocess/forwardSecondPaymentMoneyToSell.action', null, '23', '17', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2306010218', '2306010200', '支付二次货款操作权限', null, '/trademanage/tradeprocess/paySecondGoods.action', null, '23', '18', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2306010219', '2306010200', '货款申请权限', null, '/trademanage/tradeprocess/lastGoodsMoneyApply.action', null, '23', '19', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2306010220', '2306010200', '撤销货款申请权限', null, '/trademanage/tradeprocess/withdrawLastGoodsMoneyApply.action', null, '23', '20', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2306010221', '2306010200', '支付尾款跳转权限', null, '/trademanage/tradeprocess/forwardPaymentBalanceToSell.action', null, '23', '21', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2306010222', '2306010200', '支付尾款操作权限', null, '/trademanage/tradeprocess/paymentBalanceToSell.action', null, '23', '22', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2306010223', '2306010200', '违约申请权限', null, '/trademanage/tradeprocess/performBreachAsk.action', null, '23', '23', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2306010224', '2306010200', '处理违约跳转权限', null, '/trademanage/tradeprocess/forwardPerformBreach.action', null, '23', '24', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2306010225', '2306010200', '处理违约操作权限', null, '/trademanage/tradeprocess/performBreach.action', null, '23', '25', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2306010226', '2306010200', '违约延迟跳转权限', null, '/trademanage/tradeprocess/toBreachDelay.action', null, '23', '26', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2306010227', '2306010200', '违约延迟操作权限', null, '/trademanage/tradeprocess/breachDelay.action', null, '23', '27', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2306010228', '2306010200', '支付仓单跳转权限', null, '/trademanage/tradeprocess/forwardPayWarehouse.action', null, '23', '28', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2306010229', '2306010200', '支付仓单操作权限', null, '/trademanage/tradeprocess/payWarehouse.action', null, '23', '29', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2306010230', '2306010200', '支付货款跳转权限', null, '/trademanage/tradeprocess/forwardPayGoods.action', null, '23', '30', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2306010231', '2306010200', '支付货款操作权限', null, '/trademanage/tradeprocess/payGoods.action', null, '23', '31', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2306010232', '2306010200', '结束合同申请权限', null, '/trademanage/tradeprocess/performEndTradeApply.action', null, '23', '32', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2306010233', '2306010200', '撤销结束合同申请权限', null, '/trademanage/tradeprocess/performRevokeEndTradeApply.action', null, '23', '33', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2306010234', '2306010200', '同意结束合同申请权限', null, '/trademanage/tradeprocess/performDisposeEndTradeApply.action', null, '23', '34', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2306010235', '2306010200', '撤销违约权限', null, '/trademanage/tradeprocess/performWithdrawAsk.action', null, '23', '55', '0', '1', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2306020000', '2306000000', '资金相关', '42_42.gif', null, null, '23', '2', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2306020100', '2306020000', '诚信保障金管理', '29_29.gif', '/fundmanage/funds/*', '/fundmanage/funds/forwardfund.action', '23', '1', '0', '0', '2305', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2306020101', '2306020100', '查看权限', null, '/fundmanage/funds/queryfund.action', null, '23', '1', '0', '1', '2305', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2306020102', '2306020100', '转入诚信保障金权限', null, '/fundmanage/funds/paymentSubscription.action', null, '23', '2', '0', '1', '2305', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2306020103', '2306020100', '转出诚信保障金权限', null, '/fundmanage/funds/refundmentSubscription.action', null, '23', '3', '0', '1', '2305', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2307000000', '9900000000', '统计查询', null, null, null, '23', '7', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2307010000', '2307000000', '统计', '42_42.gif', null, null, '23', '1', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2307010300', '2307010000', '资金排名统计', '29_29.gif', '/statisticsQuery/firmFund/*', '/statisticsQuery/firmFund/forwardQuery.action', '23', '3', '0', '0', '2320', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2307010301', '2307010300', '查询权限', null, 'mgr/app/espot/statistics/fundranking.rptdesign', null, '23', '1', '0', '1', '2320', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2307010400', '2307010000', '交易商委托统计', '29_29.gif', '/statisticsQuery/firmOrder/*', '/statisticsQuery/firmOrder/mfirmOrderForwardQuery.action', '23', '4', '0', '0', '2320', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2307010401', '2307010400', '查询权限', null, 'mgr/app/espot/statistics/mfirmorder.rptdesign', null, '23', '1', '0', '1', '2320', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2307010500', '2307010000', '交易商成交统计', '29_29.gif', '/statisticsQuery/firmTrade/*', '/statisticsQuery/firmTrade/mfirmTradeForwardQuery.action', '23', '5', '0', '0', '2320', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2307010501', '2307010500', '查询权限', null, 'mgr/app/espot/statistics/mfirmtrade.rptdesign', null, '23', '1', '0', '1', '2320', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2307010600', '2307010000', '交易商活跃度统计', '29_29.gif', '/statisticsQuery/firmRanking/*', '/statisticsQuery/firmRanking/mfirmRankingForwardQuery.action', '23', '6', '0', '0', '2320', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2307010601', '2307010600', '查询权限', null, 'mgr/app/espot/statistics/mfirmranking.rptdesign', null, '23', '1', '0', '1', '2320', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2307010700', '2307010000', '分类委托统计', '29_29.gif', '/statisticsQuery/categoryorderTrade/*', '/statisticsQuery/categoryorderTrade/categoryorderTradeQuery.action', '23', '7', '0', '0', '2320', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2307010701', '2307010700', '查询权限', null, 'mgr/app/espot/statistics/categoryordertrade.rptdesign', null, '23', '1', '0', '1', '2320', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2307010800', '2307010000', '分类委托活跃度统计', '29_29.gif', '/statisticsQuery/categoryOrderRanking/*', '/statisticsQuery/categoryOrderRanking/categoryOrderRankingForwardQuery.action', '23', '8', '0', '0', '2320', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2307010801', '2307010800', '查询权限', null, 'mgr/app/espot/statistics/categoryorderranking.rptdesign', null, '23', '1', '0', '1', '2320', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2307010900', '2307010000', '分类成交统计', '29_29.gif', '/statisticsQuery/categoryTrade/*', '/statisticsQuery/categoryTrade/categoryTradeQuery.action', '23', '9', '0', '0', '2320', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2307010901', '2307010900', '查询权限', null, 'mgr/app/espot/statistics/categorytrade.rptdesign', null, '23', '1', '0', '1', '2320', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2307011000', '2307010000', '分类成交额统计', '29_29.gif', '/statisticsQuery/categoryTradeAmount/*', '/statisticsQuery/categoryTradeAmount/categoryTradeAmountForwardQuery.action', '23', '10', '0', '0', '2320', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2307011001', '2307011000', '查询权限', null, 'mgr/app/espot/statistics/categorytradeamount.rptdesign', null, '23', '1', '0', '1', '2320', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2307011100', '2307010000', '分类交收类型统计', '29_29.gif', '/statisticsQuery/categorytradetype/*', '/statisticsQuery/categorytradetype/categoryTradeTypeForwardQuery.action', '23', '11', '0', '0', '2320', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2307011101', '2307011100', '查询权限', null, 'mgr/app/espot/statistics/categorytradetype.rptdesign', null, '23', '1', '0', '1', '2320', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2307011200', '2307010000', '分类成交活跃度统计', '29_29.gif', '/statisticsQuery/categoryRanking/*', '/statisticsQuery/categoryRanking/categoryRankingForwardQuery.action', '23', '12', '0', '0', '2320', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2307011201', '2307011200', '查询权限', null, 'mgr/app/espot/statistics/categoryranking.rptdesign', null, '23', '1', '0', '1', '2320', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2307011300', '2307010000', '分类收入分布统计', '29_29.gif', '/statisticsQuery/categoryrevenue/*', '/statisticsQuery/categoryrevenue/categoryRevenueForwardQuery.action', '23', '13', '0', '0', '2320', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2307011301', '2307011300', '查询权限', null, 'mgr/app/espot/statistics/categoryrevenue.rptdesign', null, '23', '1', '0', '1', '2320', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2307011400', '2307010000', '品名委托统计', '29_29.gif', '/statisticsQuery/breedOrderTrade/*', '/statisticsQuery/breedOrderTrade/breedOrderTradeQuery.action', '23', '14', '0', '0', '2320', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2307011401', '2307011400', '查询权限', null, 'mgr/app/espot/statistics/breedordertrade.rptdesign', null, '23', '1', '0', '1', '2320', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2307011500', '2307010000', '品名委托活跃度统计', '29_29.gif', '/statisticsQuery/breedOrderRanking/*', '/statisticsQuery/breedOrderRanking/breedOrderRankingForwardQuery.action', '23', '15', '0', '0', '2320', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2307011501', '2307011500', '查询权限', null, 'mgr/app/espot/statistics/breedorderranking.rptdesign', null, '23', '1', '0', '1', '2320', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2307011600', '2307010000', '品名成交统计', '29_29.gif', '/statisticsQuery/breedTrade/*', '/statisticsQuery/breedTrade/breedTradeQuery.action', '23', '16', '0', '0', '2320', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2307011601', '2307011600', '查询权限', null, 'mgr/app/espot/statistics/breedtrade.rptdesign', null, '23', '1', '0', '1', '2320', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2307011700', '2307010000', '品名成交额统计', '29_29.gif', '/statisticsQuery/breedTradeAmount/*', '/statisticsQuery/breedTradeAmount/breedTradeAmountForwardQuery.action', '23', '17', '0', '0', '2320', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2307011701', '2307011700', '查询权限', null, 'mgr/app/espot/statistics/breedtradeamount.rptdesign', null, '23', '1', '0', '1', '2320', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2307011800', '2307010000', '品名交收类型统计', '29_29.gif', '/statisticsQuery/cbreedtradetype/*', '/statisticsQuery/breedtradetype/breedTradeTypeForwardQuery.action', '23', '18', '0', '0', '2320', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2307011801', '2307011800', '查询权限', null, 'mgr/app/espot/statistics/breedtradetype.rptdesign', null, '23', '1', '0', '1', '2320', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2307011900', '2307010000', '品名成交活跃度统计', '29_29.gif', '/statisticsQuery/breedRanking/*', '/statisticsQuery/breedRanking/breedRankingForwardQuery.action', '23', '19', '0', '0', '2320', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2307011901', '2307011900', '查询权限', null, 'mgr/app/espot/statistics/breedranking.rptdesign', null, '23', '1', '0', '1', '2320', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2307012000', '2307010000', '品名收入分布统计', '29_29.gif', '/statisticsQuery/breedrevenue/*', '/statisticsQuery/breedrevenue/breedRevenueForwardQuery.action', '23', '20', '0', '0', '2320', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2307012001', '2307012000', '查询权限', null, 'mgr/app/espot/statistics/breedrevenue.rptdesign', null, '23', '1', '0', '1', '2320', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2307012100', '2307010000', '平台收入统计', '29_29.gif', '/statisticsQuery/platformRevenue/*', '/statisticsQuery/platformRevenue/platformRrevenueForwardQuery.action', '23', '21', '0', '0', '2320', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2307012101', '2307012100', '查询权限', null, 'mgr/app/espot/statistics/platformrevenue.rptdesign', null, '23', '1', '0', '1', '2320', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2307012200', '2307010000', '违约情况统计', '29_29.gif', '/statisticsQuery/tradeBreach/*', '/statisticsQuery/tradeBreach/tradeBreachForwardQuery.action', '23', '22', '0', '0', '2320', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2307012201', '2307012200', '查询权限', null, 'mgr/app/espot/statistics/tradebreach.rptdesign', null, '23', '1', '0', '1', '2320', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2307012300', '2307010000', '市场仲裁统计', '29_29.gif', '/statisticsQuery/arbitration/*', '/statisticsQuery/arbitration/arbitrationForwardQuery.action', '23', '23', '0', '0', '2320', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2307012301', '2307012300', '查询权限', null, 'mgr/app/espot/statistics/arbitration.rptdesign', null, '23', '1', '0', '1', '2320', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2307012400', '2307010000', '资金情况统计', '29_29.gif', null, null, '23', '24', '-1', '0', '2320', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2307012401', '2307012400', '查询权限', null, null, null, '23', '1', '0', '1', '2320', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2307020000', '2307000000', '查询', '42_42.gif', null, null, '23', '2', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2307020100', '2307020000', '委托查询', '29_29.gif', '/search/order/*', '/search/order/searchOrder.action?sortColumns=order+by+orderTime+desc&isQueryDB=true', '23', '1', '0', '0', '2320', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2307020101', '2307020100', '查看权限', null, '/search/order/orderDetail.action', null, '23', '1', '0', '-2', '2320', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2307020200', '2307020000', '议价查询', '29_29.gif', '/search/subOrder/*', '/search/subOrder/searchSubOrder.action?sortColumns=order+by+createTime+desc&isQueryDB=true', '23', '2', '0', '0', '2320', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2307020201', '2307020200', '查看权限', null, '/search/subOrder/subOrderDetail.action', null, '23', '1', '0', '1', '2320', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2307020300', '2307020000', '协议交收合同查询', '29_29.gif', '/search/trade/*', '/search/trade/searchTrade.action?sortColumns=order+by+time+desc&isQueryDB=true', '23', '3', '0', '0', '2320', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2307020301', '2307020300', '查看权限', null, '/search/trade/tradeDetail.action', null, '23', '1', '0', '1', '2320', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2307020310', '2307020301', '协议交收合同预览', null, '/search/trade/showTrade.action', null, '23', '1', '0', '0', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2307020400', '2307020000', '自主交收合同查询', '29_29.gif', '/search/autoTrade/*', '/search/autoTrade/searchAutoTrade.action?sortColumns=order+by+time+desc&isQueryDB=true', '23', '4', '0', '0', '2320', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2307020401', '2307020400', '查看权限', null, '/search/trade/tradeDetail.action', null, '23', '1', '0', '1', '2320', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2307020410', '2307020401', '自主交收合同预览', null, '/search/autoTrade/showTrade.action', null, '23', '1', '0', '0', '2309', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2307020500', '2307020000', '订单查询', '29_29.gif', '/search/reserve/*', '/search/reserve/searchReserve.action?sortColumns=order+by+reserveId+desc&isQueryDB=true', '23', '5', '0', '0', '2320', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2307020501', '2307020500', '查看权限', null, '/search/reserve/reserveDetail.action', null, '23', '1', '0', '1', '2320', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2307020600', '2307020000', '成交查询', '29_29.gif', '/search/holding/*', '/search/holding/searchHolding.action?sortColumns=order+by+holdingId+desc&isQueryDB=true', '23', '6', '0', '0', '2320', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2307020601', '2307020600', '查看权限', null, '/search/holding/holdingDetail.action', null, '23', '1', '0', '1', '2320', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2307020700', '2307020000', '追缴货款申请查询', '29_29.gif', '/search/goodsMoneyApply/searchGoodsMoneyApply.action', '/search/goodsMoneyApply/searchGoodsMoneyApply.action?sortColumns=order+by+id+desc&isQueryDB=true', '23', '7', '0', '0', '2320', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101000000', '9900000000', '竞价系统', null, null, null, '21', '0', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101010000', '2101000000', '交易系统管理', '42_42.gif', null, null, '21', '1', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101020000', '2101000000', '交易商设置', '42_42.gif', null, null, '21', '2', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030000', '2101000000', '商品管理', '42_42.gif', null, null, '21', '3', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101040000', '2101000000', '交易查询', '42_42.gif', null, null, '21', '4', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101060000', '2101000000', '合同管理', '42_42.gif', null, null, '21', '5', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101010100', '2101010000', '系统版块配置', '29_29.gif', '/vendue/syspartition/list.action*', '/vendue/syspartition/list.action', '21', '1', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101010200', '2101010000', '默认交易节设置', '29_29.gif', '/mgr/app/vendue/system/frame/sysFlowControlMgrFrame.jsp', '/mgr/app/vendue/system/frame/sysFlowControlMgrFrame.jsp', '21', '2', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101010300', '2101010000', '交易节设置', '29_29.gif', '/mgr/app/vendue/system/frame/flowControlMgrFrame.jsp', '/mgr/app/vendue/system/frame/flowControlMgrFrame.jsp', '21', '3', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101010400', '2101010000', '交易管理', '29_29.gif', '/mgr/app/vendue/system/frame/tradeMgrFrame.jsp', '/mgr/app/vendue/system/frame/tradeMgrFrame.jsp', '21', '4', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101010500', '2101010000', '招标成交处理', '29_29.gif', '/mgr/app/vendue/system/frame/tenderSubmitMgrFrame.jsp', '/mgr/app/vendue/system/frame/tenderSubmitMgrFrame.jsp', '21', '5', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101020100', '2101020000', '交易商列表', '29_29.gif', '/vendue/tradeUser/tradeUserList.action', '/vendue/tradeUser/tradeUserList.action', '21', '1', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101020200', '2101020000', '交易权限', '29_29.gif', '/vendue/tradeAuthority/tradeAuthorityList.action', '/vendue/tradeAuthority/tradeAuthorityList.action', '21', '2', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101020300', '2101020000', '特殊设置', '29_29.gif', '/mgr/app/vendue/firmSet/frame/specialSetFrame.jsp', '/mgr/app/vendue/firmSet/frame/specialSetFrame.jsp', '21', '3', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030100', '2101030000', '商品默认设置', '29_29.gif', '/mgr/app/vendue/commodity/frame/commodityParamsFrame.jsp', '/mgr/app/vendue/commodity/frame/commodityParamsFrame.jsp', '21', '1', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030200', '2101030000', '所有商品列表', '29_29.gif', '/mgr/app/vendue/commodity/frame/commoditiesFrame.jsp', '/mgr/app/vendue/commodity/frame/commoditiesFrame.jsp', '21', '2', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030300', '2101030000', '商品审核', '29_29.gif', '/mgr/app/vendue/commodity/frame/commodityAuditFrame.jsp', '/mgr/app/vendue/commodity/frame/commodityAuditFrame.jsp', '21', '3', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030400', '2101030000', '当前交易商品', '29_29.gif', '/mgr/app/vendue/commodity/frame/curCommodityFrame.jsp', '/mgr/app/vendue/commodity/frame/curCommodityFrame.jsp', '21', '4', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030500', '2101030000', '历史商品列表', '29_29.gif', '/mgr/app/vendue/commodity/frame/hisCommodityFrame.jsp', '/mgr/app/vendue/commodity/frame/hisCommodityFrame.jsp', '21', '5', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101040100', '2101040000', '当前成交查询', '29_29.gif', '/mgr/app/vendue/bargain/frame/BargainMgrFrame.jsp', '/mgr/app/vendue/bargain/frame/BargainMgrFrame.jsp', '21', '1', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101040200', '2101040000', '当前报单查询', '29_29.gif', '/mgr/app/vendue/bargain/frame/CurSubmitMgrFrame.jsp', '/mgr/app/vendue/bargain/frame/CurSubmitMgrFrame.jsp', '21', '2', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101040300', '2101040000', '历史成交查询', '29_29.gif', '/mgr/app/vendue/bargain/frame/HisBargainMgrFrame.jsp', '/mgr/app/vendue/bargain/frame/HisBargainMgrFrame.jsp', '21', '3', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101040400', '2101040000', '历史报单查询', '29_29.gif', '/mgr/app/vendue/bargain/frame/HisSubmitMgrFrame.jsp', '/mgr/app/vendue/bargain/frame/HisSubmitMgrFrame.jsp', '21', '4', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101060100', '2101060000', '合同处理', '29_29.gif', '/mgr/app/vendue/bargainManager/frame/HisBargainMgrFrame.jsp', '/mgr/app/vendue/bargainManager/frame/HisBargainMgrFrame.jsp', '21', '1', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101010101', '2101010100', '修改系统板块设置跳转', null, '/vendue/syspartition/viewById.action*', null, '21', '2', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101010102', '2101010100', '修改系统板块设置', null, '/vendue/syspartition/update.action*', null, '21', '2', '0', '1', '2103', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030103', '2101030100', '商品默认设置添加', null, '/vendue/commodityparams/add.action', null, '21', null, '0', '1', '2015', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030104', '2101030100', '商品默认设置批量删除', null, '/vendue/commodityparams/deleteList.action', null, '21', null, '0', '1', '2015', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030105', '2101030100', '商品默认设置修改跳转', null, '/vendue/commodityparams/viewById.action', null, '21', null, '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030106', '2101030100', '商品默认设置修改', null, '/vendue/commodityparams/update.action', null, '21', null, '0', '1', '2015', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030101', '2101030100', '商品默认设置查询', null, '/vendue/commodityparams/list.action', null, '21', null, '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030102', '2101030100', '商品默认设置添加跳转', null, '/vendue/commodityparams/forwardAdd.action', null, '21', null, '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030203', '2101030200', '所有商品列表查询商品默认属性', null, '/ajaxquery/commodity/getCommodityParams.action', null, '21', null, '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030204', '2101030200', '所有商品列表添加', null, '/vendue/commodities/add.action', null, '21', null, '0', '1', '2015', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030201', '2101030200', '所有商品列表查询', null, '/vendue/commodities/list.action', null, '21', null, '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030205', '2101030200', '所有商品列表修改跳转', null, '/vendue/commodities/viewById.action', null, '21', null, '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030206', '2101030200', '所有商品列表修改', null, '/vendue/commodities/update.action', null, '21', null, '0', '1', '2015', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030210', '2101030200', '所有商品列表获取交收属性', null, '/ajaxquery/commodity/getCommextByCode.action', null, '21', null, '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030209', '2101030200', '所有商品列表查询交收属性', null, '/ajaxquery/commodity/getPropertyByBreed.action', null, '21', null, '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030208', '2101030200', '所有商品列表添加到当前商品', null, '/vendue/commodities/addToCur.action', null, '21', null, '0', '1', '2105', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030211', '2101030200', '所有商品列表获取是否拆分标的', null, '/ajaxquery/commodity/getIssplittarget.action', null, '21', null, '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030202', '2101030200', '所有商品列表添加跳转', null, '/vendue/commodities/forwardAdd.action', null, '21', null, '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030207', '2101030200', '所有商品列表批量删除', null, '/vendue/commodities/deleteList.action', null, '21', null, '0', '1', '2015', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030212', '2101030200', '所有商品列表获取交易模式id', null, '/ajaxquery/commodity/getTrademode.action', null, '21', null, '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030213', '2101030200', '所有商品列表根据交易商编码判断交易商是否存在', null, '/ajaxquery/commodity/isUseridExist.action', null, '21', null, '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030214', '2101030200', '所有商品列表详情查看', null, '/vendue/commodities/viewByIdForDetail.action', null, '21', null, '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030301', '2101030300', '商品审核查询', null, '/vendue/commodityaudit/list.action', null, '21', null, '0', '1', null, 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030302', '2101030300', '商品审核审核跳转', null, '/vendue/commodityaudit/viewById.action', null, '21', null, '0', '1', null, 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030303', '2101030300', '商品审核审核提交', null, '/vendue/commodityaudit/update.action', null, '21', null, '0', '1', null, 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030304', '2101030300', '商品审核彻底删除', null, '/vendue/commodityaudit/update.action', null, '21', null, '0', '1', null, 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101020101', '2101020100', '交易商更新跳转', null, '/vendue/tradeUser/updateTradeUserForward.action', '/vendue/tradeUser/updateTradeUserForward.action', '21', null, '0', '1', null, 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101020102', '2101020100', '更新交易商信息', null, '/vendue/tradeUser/updateTradeUser.action', '/vendue/tradeUser/updateTradeUser.action', '21', null, '0', '1', '2104', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101020201', '2101020200', '交易权限添加跳转', null, '/vendue/tradeAuthority/addTradeAuthorityforward.action', '/vendue/tradeAuthority/addTradeAuthorityforward.action', '21', null, '0', '1', null, 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101020202', '2101020200', '交易权限添加', null, '/vendue/tradeAuthority/addTradeAuthority.action', '/vendue/tradeAuthority/addTradeAuthority.action', '21', null, '0', '1', '2104', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101020203', '2101020200', '交易权限删除', null, '/vendue/tradeAuthority/delateTradeAuthority.action', '/vendue/tradeAuthority/delateTradeAuthority.action', '21', null, '0', '1', '2104', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101040101', '2101040100', '当前成交查询', null, '/vendue/vbargain/*', '/vendue/vbargain/bargainList.action', '21', null, '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101040201', '2101040200', '当前报单查询', null, '/vendue/vbargain/curSubmitList.action', '/vendue/vbargain/curSubmitList.action', '21', null, '0', '1', null, 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101040301', '2101040300', '历史成交查询', null, '/vendue/vbargain/hisBargainList.action', '/vendue/vbargain/hisBargainList.action', '21', null, '0', '1', null, 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101040401', '2101040400', '历史报单查询', null, '/vendue/vbargain/hisSubmitList.action', '/vendue/vbargain/hisSubmitList.action', '21', null, '0', '1', null, 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030501', '2101030500', '历史商品列表查询', '29_29.gif', '/vendue/hisCommodities/hisCommodityList.action', '/vendue/hisCommodities/hisCommodityList.action', '21', null, '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101060101', '2101060100', '合同查询', null, '/vendue/bargainManager/hisBargainList.action', '/vendue/bargainManager/hisBargainList.action', '21', null, '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101060102', '2101060100', '获取指定的合同', null, '/vendue/bargainManager/hisBargain.action', '/vendue/bargainManager/hisBargain.action', '21', null, '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101060103', '2101060100', '释放保证金', null, '/vendue/bargainManager/unfounds.action', '/vendue/bargainManager/unfounds.action', '21', null, '0', '1', '2108', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101010501', '2101010500', '获取招标成交列表', null, '/vendue/tenderSubmit/getTenderSubmitList.action', '/vendue/tenderSubmit/getTenderSubmitList.action', '21', null, '0', '1', null, 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101010502', '2101010500', '获取招标板块', null, '/vendue/tenderSubmit/partitionInfo.action', '/vendue/tenderSubmit/partitionInfo.action', '21', null, '0', '1', null, 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101010503', '2101010500', '删除招标委托', null, '/vendue/tenderSubmit/deleteTenderSubmitList.action', '/vendue/tenderSubmit/deleteTenderSubmitList.action', '21', null, '0', '1', '2103', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101010506', '2101010500', '确认招标成交', null, '/vendue/tenderSubmit/makeSureTenderSubmit.action', '/vendue/tenderSubmit/makeSureTenderSubmit.action', '21', null, '0', '1', '2103', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101010504', '2101010500', '招标委托添加跳转', null, '/vendue/tenderSubmit/addTenderSubmitForward.action', '/vendue/tenderSubmit/addTenderSubmitForward.action', '21', null, '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101010505', '2101010500', '招标委托添加', null, '/vendue/tenderSubmit/addTenderSubmit.action', '/vendue/tenderSubmit/addTenderSubmit.action', '21', null, '0', '1', '2103', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101010301', '2101010300', '交易节查询权限', null, '/vendue/system/listFlowControl.action', null, '21', '1', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101010302', '2101010300', '添加交易节跳转', null, '/vendue/system/forwardAddFlow.action', null, '21', '2', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101010303', '2101010300', '添加交易节', null, '/vendue/system/addFlow.action', null, '21', '3', '0', '0', '0', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101010305', '2101010300', '修改交易节', null, '/vendue/system/updateFlow.action', null, '21', '5', '0', '0', '0', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101010306', '2101010300', '删除交易节', null, '/vendue/system/deleteFlow.action', null, '21', '6', '0', '0', '0', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101010304', '2101010300', '修改交易节跳转', null, '/vendue/system/forwardUpdateFlow.action', null, '21', '4', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101010201', '2101010200', '默认交易节查询权限', null, '/vendue/system/listSysFlowControl.action', null, '21', '1', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101010202', '2101010200', '修改默认交易节跳转', null, '/vendue/system/forwardUpdateSysFlow.action', null, '21', '2', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101010203', '2101010200', '修改默认交易节', null, '/vendue/system/updateSysFlow.action', null, '21', '3', '0', '0', '0', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101020301', '2101020300', '特殊设置HeadFrame获取', null, '/vendue/firmSet/specialSetInfo.action', null, '21', '1', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101020302', '2101020300', '特殊手续费查看', null, '/vendue/firmSet/listSpecialFee.action', null, '21', '2', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101020303', '2101020300', '特殊手续费添加跳转', null, '/vendue/firmSet/forwardAddSpecialFee.action', null, '21', '3', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101020304', '2101020300', '特殊手续费添加', null, '/vendue/firmSet/addSpecialFee.action', null, '21', '4', '0', '0', '0', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101020305', '2101020300', '特殊手续费修改跳转', null, '/vendue/firmSet/forwardUpdateSpecialFee.action', null, '21', '5', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101020306', '2101020300', '特殊手续费修改', null, '/vendue/firmSet/updateSpecialFee.action', null, '21', '6', '0', '0', '0', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101020307', '2101020300', '特殊手续费删除', null, '/vendue/firmSet/deleteSpecialFee.action', null, '21', '7', '0', '0', '0', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101020308', '2101020300', '特殊保证金查看', null, '/vendue/firmSet/listSpecialMargin.action', null, '21', '8', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101020309', '2101020300', '特殊保证金添加跳转', null, '/vendue/firmSet/forwardAddSpecialMargin.action', null, '21', '9', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101020310', '2101020300', '特殊保证金添加', null, '/vendue/firmSet/addSpecialMargin.action', null, '21', '10', '0', '0', '0', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101020311', '2101020300', '特殊保证金修改跳转', null, '/vendue/firmSet/forwardUpdateSpecialMargin.action', null, '21', '11', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101020312', '2101020300', '特殊保证金修改', null, '/vendue/firmSet/updateSpecialMargin.action', null, '21', '12', '0', '0', '0', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101020313', '2101020300', '特殊保证金删除', null, '/vendue/firmSet/deleteSpecialMargin.action', null, '21', '13', '0', '0', '0', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101020314', '2101020300', '刷新特殊手续费', null, '/vendue/firmSet/refreshSpecialFee.action', null, '21', '14', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101020315', '2101020300', '刷新特殊保证金', null, '/vendue/firmSet/refreshSpecialMargin.action', null, '21', '15', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030401', '2101030400', '当前商品查询', null, '/vendue/curCommodity/listCurCommodity.action', null, '21', '1', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030402', '2101030400', '当前商品添加交易节跳转', null, '/mgr/app/vendue/commodity/curCommodity/curCommodity_addSection.jsp', null, '21', '2', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030403', '2101030400', '当前商品添加交易节', null, '/vendue/curCommodity/addSectionToCurCommodity.action', null, '21', '3', '0', '0', '0', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030404', '2101030400', '删除当前商品', null, '/vendue/curCommodity/deleteCurCommodity.action', null, '21', '4', '0', '0', '0', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030405', '2101030400', '当前商品插入交易节跳转', null, '/mgr/app/vendue/commodity/curCommodity/curCommodity_insertSection.jsp', null, '21', '5', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030406', '2101030400', '当前商品插入交易节', null, '/vendue/curCommodity/insertSectionToCurCommodity.action', null, '21', '6', '0', '0', '0', 'Y');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030407', '2101030400', '刷新当前商品', null, '/vendue/curCommodity/refreshCurCommodity.action', null, '21', '7', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101010401', '2101010400', '查系统状态权限', null, '/vendue/tradeMgr/fetchCurrSysState.action*', null, '21', '1', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101010402', '2101010400', '交易处理权限', null, '/vendue/tradeMgr/tradeProcess.action*', null, '21', '2', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101010403', '2101010400', '查看系统当前状态权限', null, '/vendue/tradeMgr/goFetchCurrSysState.action*', null, '21', '3', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101010404', '2101010400', '查看系统当前状态权限1', null, '/mgr/app/vendue/system/tradeMgr/go_fetchCurrSysState.jsp*', null, '21', '4', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1201020604', '1201020600', '仓单信息修改', null, '/stock/exitlist/stockOutUpdate.action', '/stock/exitlist/stockOutUpdate.action', '13', '4', '0', '1', '1320', 'N');
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('1201020605', '1201020600', '仓单确认收货权限', null, '/stock/exitlist/stockConfirm.action*', null, '13', '5', '0', '1', '1320', 'N');

-- ----------------------------
-- Table structure for C_ROLE
-- ----------------------------
DROP TABLE "TRADE_GNNT"."C_ROLE";
CREATE TABLE "TRADE_GNNT"."C_ROLE" (
"ID" NUMBER(10) NOT NULL ,
"NAME" VARCHAR2(32 BYTE) NOT NULL ,
"DESCRIPTION" VARCHAR2(256 BYTE) NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON COLUMN "TRADE_GNNT"."C_ROLE"."ID" IS '角色Id';
COMMENT ON COLUMN "TRADE_GNNT"."C_ROLE"."NAME" IS '角色名称';
COMMENT ON COLUMN "TRADE_GNNT"."C_ROLE"."DESCRIPTION" IS '描述';

-- ----------------------------
-- Records of C_ROLE
-- ----------------------------

-- ----------------------------
-- Table structure for C_ROLE_RIGHT
-- ----------------------------
DROP TABLE "TRADE_GNNT"."C_ROLE_RIGHT";
CREATE TABLE "TRADE_GNNT"."C_ROLE_RIGHT" (
"RIGHTID" NUMBER(10) NOT NULL ,
"ROLEID" NUMBER(10) NOT NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON COLUMN "TRADE_GNNT"."C_ROLE_RIGHT"."RIGHTID" IS '权限Id';
COMMENT ON COLUMN "TRADE_GNNT"."C_ROLE_RIGHT"."ROLEID" IS '角色Id';

-- ----------------------------
-- Records of C_ROLE_RIGHT
-- ----------------------------

-- ----------------------------
-- Table structure for C_SUBMODULE
-- ----------------------------
DROP TABLE "TRADE_GNNT"."C_SUBMODULE";
CREATE TABLE "TRADE_GNNT"."C_SUBMODULE" (
"MODULEID" NUMBER(4) NOT NULL ,
"CNNAME" VARCHAR2(64 BYTE) NOT NULL ,
"ENNAME" VARCHAR2(64 BYTE) NULL ,
"SHORTNAME" VARCHAR2(16 BYTE) NULL ,
"HOSTIP" VARCHAR2(16 BYTE) NULL ,
"PORT" NUMBER(6) NULL ,
"RMIDATAPORT" NUMBER(6) NULL ,
"PARENTMODULEID" NUMBER(2) NOT NULL ,
"REMARK" VARCHAR2(128 BYTE) NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON COLUMN "TRADE_GNNT"."C_SUBMODULE"."MODULEID" IS '此表为c_trademodule中的子模块配置表，模块ID不要与c_trademodule表中的模块ID重复';

-- ----------------------------
-- Records of C_SUBMODULE
-- ----------------------------

-- ----------------------------
-- Table structure for C_TRADEMODULE
-- ----------------------------
DROP TABLE "TRADE_GNNT"."C_TRADEMODULE";
CREATE TABLE "TRADE_GNNT"."C_TRADEMODULE" (
"MODULEID" NUMBER(2) NOT NULL ,
"CNNAME" VARCHAR2(64 BYTE) NOT NULL ,
"ENNAME" VARCHAR2(64 BYTE) NULL ,
"SHORTNAME" VARCHAR2(16 BYTE) NULL ,
"ADDFIRMFN" VARCHAR2(36 BYTE) NULL ,
"UPDATEFIRMSTATUSFN" VARCHAR2(36 BYTE) NULL ,
"DELFIRMFN" VARCHAR2(36 BYTE) NULL ,
"ISFIRMSET" CHAR(1 BYTE) DEFAULT 'N'  NOT NULL ,
"HOSTIP" VARCHAR2(16 BYTE) NULL ,
"PORT" NUMBER(6) NULL ,
"RMIDATAPORT" NUMBER(6) NULL ,
"ISBALANCECHECK" CHAR(1 BYTE) DEFAULT 'N'  NOT NULL ,
"ISNEEDBREED" CHAR(1 BYTE) NOT NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON COLUMN "TRADE_GNNT"."C_TRADEMODULE"."MODULEID" IS '10综合管理平台
11财务系统
12监管仓库管理系统
13仓单管理系统
14融资系统
15订单交易
18投资类大宗商品交易系统
19加盟会员管理系统
20做市商交易系统
21竞价系统
22银行接入及结算系统
23E现货
24单点登录系统
25实时行情分析系统
26交易客户端
98demo系统
99公用系统';
COMMENT ON COLUMN "TRADE_GNNT"."C_TRADEMODULE"."ISFIRMSET" IS '‘Y’ 是 ‘N’ 否 (如果需要在公用前台我的平台中显示本系统，还需要在公用系统的 spring_sys_msg.xml 中配置上本系统的配置信息)';
COMMENT ON COLUMN "TRADE_GNNT"."C_TRADEMODULE"."ISBALANCECHECK" IS 'Y：是 N：否';
COMMENT ON COLUMN "TRADE_GNNT"."C_TRADEMODULE"."ISNEEDBREED" IS '本系统是否需要综合管理平台增加的商品   Y:是   N:否';

-- ----------------------------
-- Records of C_TRADEMODULE
-- ----------------------------
INSERT INTO "TRADE_GNNT"."C_TRADEMODULE" VALUES ('10', '综合管理平台', 'integrated', '综合管理平台', null, null, null, 'Y', null, null, null, 'N', 'N');
INSERT INTO "TRADE_GNNT"."C_TRADEMODULE" VALUES ('11', '财务系统', 'finance', '财务系统', 'FN_F_firmADD', 'FN_F_FirmToStatus', 'FN_F_FirmDel', 'Y', null, null, null, 'N', 'N');
INSERT INTO "TRADE_GNNT"."C_TRADEMODULE" VALUES ('13', '仓单管理系统', 'bill', '仓单管理系统', 'FN_BI_firmADD', null, 'FN_BI_FirmDel', 'Y', '10.0.100.181', '20371', '20372', 'Y', 'N');
INSERT INTO "TRADE_GNNT"."C_TRADEMODULE" VALUES ('32', '单点登录系统', 'activeuser', '单点登录系统', null, null, null, 'N', null, null, null, 'N', 'N');
INSERT INTO "TRADE_GNNT"."C_TRADEMODULE" VALUES ('12', '仓库管理系统', 'warehouse', '仓库管理系统', null, null, null, 'N', null, null, null, 'N', 'N');
INSERT INTO "TRADE_GNNT"."C_TRADEMODULE" VALUES ('19', '加盟会员管理系统', 'broker', '加盟会员管理系统', 'FN_BR_firmADD', null, null, 'N', null, null, null, 'N', 'N');
INSERT INTO "TRADE_GNNT"."C_TRADEMODULE" VALUES ('15', '订单管理系统', 'timebargain', '订单管理系统', 'FN_T_firmADD', null, 'FN_T_FirmDel', 'Y', '10.0.100.181', '20671', '20672', 'Y', 'Y');
INSERT INTO "TRADE_GNNT"."C_TRADEMODULE" VALUES ('99', '公用系统', 'common', '公用系统', null, null, null, 'N', '10.0.100.181', '20171', '20172', 'Y', 'N');
INSERT INTO "TRADE_GNNT"."C_TRADEMODULE" VALUES ('21', '竞价系统', 'vendue', '竞价管理系统', 'FN_V_FirmAdd', null, 'FN_V_FirmDel', 'Y', '10.0.100.181', '20871', '20872', 'Y', 'Y');
INSERT INTO "TRADE_GNNT"."C_TRADEMODULE" VALUES ('40', 'IPO', 'ipo', 'IPO', null, null, null, 'Y', null, null, null, 'N', 'N');
INSERT INTO "TRADE_GNNT"."C_TRADEMODULE" VALUES ('28', '银行接口', 'bank', '银行接口', 'FN_F_B_firmADD', null, 'FN_F_B_FirmDEL', 'Y', null, '20571', '20572', 'N', 'N');

-- ----------------------------
-- Table structure for C_USER
-- ----------------------------
DROP TABLE "TRADE_GNNT"."C_USER";
CREATE TABLE "TRADE_GNNT"."C_USER" (
"ID" VARCHAR2(32 BYTE) NOT NULL ,
"NAME" VARCHAR2(32 BYTE) NULL ,
"PASSWORD" VARCHAR2(32 BYTE) NULL ,
"TYPE" VARCHAR2(20 BYTE) DEFAULT 'ADMIN'  NOT NULL ,
"DESCRIPTION" VARCHAR2(256 BYTE) NULL ,
"ISFORBID" CHAR(1 BYTE) DEFAULT 'N'  NOT NULL ,
"SKIN" VARCHAR2(16 BYTE) DEFAULT 'default'  NOT NULL ,
"KEYCODE" VARCHAR2(128 BYTE) DEFAULT '0123456789ABCDE'  NOT NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON COLUMN "TRADE_GNNT"."C_USER"."ID" IS '管理员Id';
COMMENT ON COLUMN "TRADE_GNNT"."C_USER"."NAME" IS '管理员名称';
COMMENT ON COLUMN "TRADE_GNNT"."C_USER"."PASSWORD" IS '密码';
COMMENT ON COLUMN "TRADE_GNNT"."C_USER"."TYPE" IS 'ADMIN：普通管理员角色DEFAULT_ADMIN：高级管理员角色DEFAULT_SUPER_ADMIN：默认超级管理员角色';
COMMENT ON COLUMN "TRADE_GNNT"."C_USER"."DESCRIPTION" IS '描述';
COMMENT ON COLUMN "TRADE_GNNT"."C_USER"."ISFORBID" IS 'Y：禁用
N：不禁用
';
COMMENT ON COLUMN "TRADE_GNNT"."C_USER"."SKIN" IS '皮肤';
COMMENT ON COLUMN "TRADE_GNNT"."C_USER"."KEYCODE" IS 'key';

-- ----------------------------
-- Records of C_USER
-- ----------------------------
INSERT INTO "TRADE_GNNT"."C_USER" VALUES ('888', '888', '4bfa5111887c94e2adaf74fa462f7aa5', 'DEFAULT_ADMIN', null, 'N', 'default', '0123456789ABCDE');
INSERT INTO "TRADE_GNNT"."C_USER" VALUES ('hl', '管理员测试', '7d940359a245b1d1f94437f59526d90c', 'DEFAULT_SUPER_ADMIN', null, 'N', 'gray', '0123456789ABCDE');
INSERT INTO "TRADE_GNNT"."C_USER" VALUES ('yxl', '贠晓利', 'fcc94a5594b3239b2fdb01265f0e4c3a', 'ADMIN', null, 'N', 'default', '0123456789ABCDE');
INSERT INTO "TRADE_GNNT"."C_USER" VALUES ('xm', '徐敏', '1939d864adfff6d1e19115e460cdb064', 'ADMIN', null, 'N', 'default', '0123456789ABCDE');
INSERT INTO "TRADE_GNNT"."C_USER" VALUES ('cj', '曹杰', '07316c1b02f64327c6edbe3d5ef6e54f', 'ADMIN', null, 'N', 'gray', '0123456789ABCDE');
INSERT INTO "TRADE_GNNT"."C_USER" VALUES ('zcy', '张春意', '4e175af1f004a72de97e84e9bc581a1f', 'ADMIN', null, 'N', 'gray', '0123456789ABCDE');
INSERT INTO "TRADE_GNNT"."C_USER" VALUES ('wje', '王家恩', '72d8fb6a427b28ee1bbe748e256c0336', 'ADMIN', null, 'N', 'default', '0123456789ABCDE');
INSERT INTO "TRADE_GNNT"."C_USER" VALUES ('ywl', '杨文龙', 'b2a8a549c72f0e6a1a37985374adbddc', 'ADMIN', null, 'N', 'default', '0123456789ABCDE');
INSERT INTO "TRADE_GNNT"."C_USER" VALUES ('qm', '钱淼', '63c151eb9004878968e869b1bddd041f', 'ADMIN', null, 'N', 'default', '0123456789ABCDE');
INSERT INTO "TRADE_GNNT"."C_USER" VALUES ('yx', '郁潇', '2474e34033e1c14e933a90d7134621af', 'ADMIN', null, 'N', 'default', '0123456789ABCDE');
INSERT INTO "TRADE_GNNT"."C_USER" VALUES ('zs', '张晟', 'a55f6b38c09591e9211769365945c8ba', 'ADMIN', null, 'N', 'default', '0123456789ABCDE');
INSERT INTO "TRADE_GNNT"."C_USER" VALUES ('dh', '邓浩', '1a6b7cef17235d2e3926816b979ce10b', 'ADMIN', null, 'N', 'default', '0123456789ABCDE');
INSERT INTO "TRADE_GNNT"."C_USER" VALUES ('zwh', '郑为豪', '5546e69881bc24c422ae44f90d6f0659', 'ADMIN', null, 'N', 'default', '0123456789ABCDE');
INSERT INTO "TRADE_GNNT"."C_USER" VALUES ('ggy', '顾高燕', '3e5545c4e5655ee4c452fb95ac7c0fbe', 'ADMIN', null, 'N', 'default', '0123456789ABCDE');
INSERT INTO "TRADE_GNNT"."C_USER" VALUES ('sy', '孙艳', 'ea19ae0ee86230344332c428f1a73ba8', 'ADMIN', null, 'N', 'gray', '0123456789ABCDE');
INSERT INTO "TRADE_GNNT"."C_USER" VALUES ('wht', '王灏天', '04e11d9f3de5c6bc43ec515b27934145', 'ADMIN', null, 'N', 'default', '0123456789ABCDE');
INSERT INTO "TRADE_GNNT"."C_USER" VALUES ('cd', '程栋', 'f261fe8683f07b1c92adc45ffbee9bc3', 'ADMIN', null, 'N', 'gray', '0123456789ABCDE');
INSERT INTO "TRADE_GNNT"."C_USER" VALUES ('002', 'gaob', 'd9dc70875c74131d4e6ace950732c8bb', 'ADMIN', null, 'N', 'default', '0123456789ABCDE');
INSERT INTO "TRADE_GNNT"."C_USER" VALUES ('admin', 'admin', '8c27fa338adc9e507b55dcc99d426b1c', 'DEFAULT_SUPER_ADMIN', '超级管理员', 'N', 'default', '0123456789ABCDE');
INSERT INTO "TRADE_GNNT"."C_USER" VALUES ('hyl', '胡玉龙', 'd15998dc97f71573525bf772d5eb09bc', 'ADMIN', null, 'N', 'default', '0123456789ABCDE');
INSERT INTO "TRADE_GNNT"."C_USER" VALUES ('byg', '贲余刚', '3a0706961c59387613e5d115bfcba5a0', 'DEFAULT_SUPER_ADMIN', null, 'N', 'gray', '0123456789ABCDE');
INSERT INTO "TRADE_GNNT"."C_USER" VALUES ('hxq', '洪学勤', 'c78f9d61791c7c2c2d4963d705d1f1c6', 'ADMIN', null, 'N', 'default', '0123456789ABCDE');
INSERT INTO "TRADE_GNNT"."C_USER" VALUES ('zjl', '周佳丽', '461acb8c8e5e65effe6323332729a38a', 'ADMIN', null, 'N', 'default', '0123456789ABCDE');
INSERT INTO "TRADE_GNNT"."C_USER" VALUES ('syj', '山永军', '29742003e3d114526aea505fbbae8d36', 'ADMIN', null, 'N', 'gray', '0123456789ABCDE');
INSERT INTO "TRADE_GNNT"."C_USER" VALUES ('ltc', '吕天才', 'b535bc59ce1b876d263b98115c6abc1a', 'ADMIN', null, 'N', 'default', '0123456789ABCDE');
INSERT INTO "TRADE_GNNT"."C_USER" VALUES ('zx', '郑雄', '19bb6c1003ff760643afde430348c856', 'DEFAULT_ADMIN', null, 'N', 'default', '0123456789ABCDE');
INSERT INTO "TRADE_GNNT"."C_USER" VALUES ('ml', '马亮', '04f2d5029d7297d890b9092414e092c9', 'ADMIN', null, 'N', 'default', '0123456789ABCDE');
INSERT INTO "TRADE_GNNT"."C_USER" VALUES ('syb', '施一波', '71506596ef5db3b24c1d2d4f5babed90', 'DEFAULT_SUPER_ADMIN', null, 'N', 'default', '0123456789ABCDE');
INSERT INTO "TRADE_GNNT"."C_USER" VALUES ('hxx', '黄小新', 'b7f5f35aeef00e5ee386125d9daf3020', 'DEFAULT_SUPER_ADMIN', null, 'N', 'default', '0123456789ABCDE');
INSERT INTO "TRADE_GNNT"."C_USER" VALUES ('qjj', '钱玠均', 'bcb572f814aab1bfe1154e88598bc8cd', 'ADMIN', null, 'N', 'default', '0123456789ABCDE');
INSERT INTO "TRADE_GNNT"."C_USER" VALUES ('1', '非凡哥', '7fa8282ad93047a4d6fe6111c93b308a', 'DEFAULT_ADMIN', '吔屎啦', 'N', 'gray', '0123456789ABCDE');
INSERT INTO "TRADE_GNNT"."C_USER" VALUES ('2', '2', '79d886010186eb60e3611cd4a5d0bcae', 'DEFAULT_ADMIN', null, 'N', 'gray', '0123456789ABCDE');
INSERT INTO "TRADE_GNNT"."C_USER" VALUES ('AAA', '管理员测试', '4de81ac246dc70a9cb84a79596225ae5', 'DEFAULT_SUPER_ADMIN', null, 'N', 'default', '0123456789ABCDE');

-- ----------------------------
-- Table structure for C_USER_RIGHT
-- ----------------------------
DROP TABLE "TRADE_GNNT"."C_USER_RIGHT";
CREATE TABLE "TRADE_GNNT"."C_USER_RIGHT" (
"RIGHTID" NUMBER(10) NOT NULL ,
"USERID" VARCHAR2(32 BYTE) NOT NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON COLUMN "TRADE_GNNT"."C_USER_RIGHT"."RIGHTID" IS '权限Id
权限Id';
COMMENT ON COLUMN "TRADE_GNNT"."C_USER_RIGHT"."USERID" IS '管理员Id';

-- ----------------------------
-- Records of C_USER_RIGHT
-- ----------------------------

-- ----------------------------
-- Table structure for C_USER_ROLE
-- ----------------------------
DROP TABLE "TRADE_GNNT"."C_USER_ROLE";
CREATE TABLE "TRADE_GNNT"."C_USER_ROLE" (
"USERID" VARCHAR2(32 BYTE) NOT NULL ,
"ROLEID" NUMBER(10) NOT NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON COLUMN "TRADE_GNNT"."C_USER_ROLE"."USERID" IS '管理员Id';
COMMENT ON COLUMN "TRADE_GNNT"."C_USER_ROLE"."ROLEID" IS '角色Id';

-- ----------------------------
-- Records of C_USER_ROLE
-- ----------------------------

-- ----------------------------
-- Table structure for C_XMLTEMPLATE
-- ----------------------------
DROP TABLE "TRADE_GNNT"."C_XMLTEMPLATE";
CREATE TABLE "TRADE_GNNT"."C_XMLTEMPLATE" (
"ID" NUMBER(12) NOT NULL ,
"CLOB" CLOB NOT NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;

-- ----------------------------
-- Records of C_XMLTEMPLATE
-- ----------------------------

-- ----------------------------
-- Indexes structure for table C_APPLY
-- ----------------------------

-- ----------------------------
-- Checks structure for table C_APPLY
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."C_APPLY" ADD CHECK ("ID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."C_APPLY" ADD CHECK ("APPLYTYPE" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."C_APPLY" ADD CHECK ("STATUS" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."C_APPLY" ADD CHECK ("CONTENT" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."C_APPLY" ADD CHECK ("CREATETIME" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."C_APPLY" ADD CHECK ("APPLYUSER" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."C_APPLY" ADD CHECK ("OPERATETYPE" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."C_APPLY" ADD CHECK ("ENTITYCLASS" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table C_APPLY
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."C_APPLY" ADD PRIMARY KEY ("ID");

-- ----------------------------
-- Indexes structure for table C_AUDIT
-- ----------------------------

-- ----------------------------
-- Checks structure for table C_AUDIT
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."C_AUDIT" ADD CHECK ("ID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."C_AUDIT" ADD CHECK ("APPLYID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."C_AUDIT" ADD CHECK ("STATUS" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."C_AUDIT" ADD CHECK ("AUDITUSER" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."C_AUDIT" ADD CHECK ("MODTIME" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table C_AUDIT
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."C_AUDIT" ADD PRIMARY KEY ("ID");

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

-- ----------------------------
-- Indexes structure for table C_FRONT_MYMENU
-- ----------------------------

-- ----------------------------
-- Checks structure for table C_FRONT_MYMENU
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."C_FRONT_MYMENU" ADD CHECK ("USERID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."C_FRONT_MYMENU" ADD CHECK ("RIGHTID" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table C_FRONT_MYMENU
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."C_FRONT_MYMENU" ADD PRIMARY KEY ("USERID", "RIGHTID");

-- ----------------------------
-- Indexes structure for table C_FRONT_RIGHT
-- ----------------------------

-- ----------------------------
-- Checks structure for table C_FRONT_RIGHT
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."C_FRONT_RIGHT" ADD CHECK (TYPE in (-3,-2,-1,0,1));
ALTER TABLE "TRADE_GNNT"."C_FRONT_RIGHT" ADD CHECK (VISIBLE in (-1,0));
ALTER TABLE "TRADE_GNNT"."C_FRONT_RIGHT" ADD CHECK ("ID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."C_FRONT_RIGHT" ADD CHECK ("TYPE" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table C_FRONT_RIGHT
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."C_FRONT_RIGHT" ADD PRIMARY KEY ("ID");

-- ----------------------------
-- Indexes structure for table C_FRONT_ROLE
-- ----------------------------

-- ----------------------------
-- Checks structure for table C_FRONT_ROLE
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."C_FRONT_ROLE" ADD CHECK ("ID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."C_FRONT_ROLE" ADD CHECK ("NAME" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table C_FRONT_ROLE
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."C_FRONT_ROLE" ADD PRIMARY KEY ("ID");

-- ----------------------------
-- Indexes structure for table C_FRONT_ROLE_RIGHT
-- ----------------------------

-- ----------------------------
-- Checks structure for table C_FRONT_ROLE_RIGHT
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."C_FRONT_ROLE_RIGHT" ADD CHECK ("RIGHTID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."C_FRONT_ROLE_RIGHT" ADD CHECK ("ROLEID" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table C_FRONT_ROLE_RIGHT
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."C_FRONT_ROLE_RIGHT" ADD PRIMARY KEY ("RIGHTID", "ROLEID");

-- ----------------------------
-- Indexes structure for table C_FRONT_USER_RIGHT
-- ----------------------------

-- ----------------------------
-- Checks structure for table C_FRONT_USER_RIGHT
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."C_FRONT_USER_RIGHT" ADD CHECK ("RIGHTID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."C_FRONT_USER_RIGHT" ADD CHECK ("USERID" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table C_FRONT_USER_RIGHT
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."C_FRONT_USER_RIGHT" ADD PRIMARY KEY ("RIGHTID", "USERID");

-- ----------------------------
-- Indexes structure for table C_FRONT_USER_ROLE
-- ----------------------------

-- ----------------------------
-- Checks structure for table C_FRONT_USER_ROLE
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."C_FRONT_USER_ROLE" ADD CHECK ("USERID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."C_FRONT_USER_ROLE" ADD CHECK ("ROLEID" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table C_FRONT_USER_ROLE
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."C_FRONT_USER_ROLE" ADD PRIMARY KEY ("USERID", "ROLEID");

-- ----------------------------
-- Indexes structure for table C_GLOBALLOG_ALL
-- ----------------------------

-- ----------------------------
-- Checks structure for table C_GLOBALLOG_ALL
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."C_GLOBALLOG_ALL" ADD CHECK (operateresult in(0,1));
ALTER TABLE "TRADE_GNNT"."C_GLOBALLOG_ALL" ADD CHECK ("ID" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table C_GLOBALLOG_ALL
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."C_GLOBALLOG_ALL" ADD PRIMARY KEY ("ID");

-- ----------------------------
-- Checks structure for table C_GLOBALLOG_ALL_H
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."C_GLOBALLOG_ALL_H" ADD CHECK (operateresult in(0,1));
ALTER TABLE "TRADE_GNNT"."C_GLOBALLOG_ALL_H" ADD CHECK ("ID" IS NOT NULL);

-- ----------------------------
-- Indexes structure for table C_LOGCATALOG
-- ----------------------------

-- ----------------------------
-- Checks structure for table C_LOGCATALOG
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."C_LOGCATALOG" ADD CHECK ("CATALOGID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."C_LOGCATALOG" ADD CHECK ("MODULEID" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table C_LOGCATALOG
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."C_LOGCATALOG" ADD PRIMARY KEY ("CATALOGID");

-- ----------------------------
-- Indexes structure for table C_MARKETINFO
-- ----------------------------

-- ----------------------------
-- Checks structure for table C_MARKETINFO
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."C_MARKETINFO" ADD CHECK ("INFONAME" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."C_MARKETINFO" ADD CHECK ("INFOVALUE" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table C_MARKETINFO
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."C_MARKETINFO" ADD PRIMARY KEY ("INFONAME", "INFOVALUE");

-- ----------------------------
-- Indexes structure for table C_MYMENU
-- ----------------------------

-- ----------------------------
-- Checks structure for table C_MYMENU
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."C_MYMENU" ADD CHECK ("USERID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."C_MYMENU" ADD CHECK ("RIGHTID" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table C_MYMENU
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."C_MYMENU" ADD PRIMARY KEY ("USERID", "RIGHTID");

-- ----------------------------
-- Indexes structure for table C_RIGHT
-- ----------------------------

-- ----------------------------
-- Checks structure for table C_RIGHT
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."C_RIGHT" ADD CHECK (TYPE in (-3,-2,-1,0,1));
ALTER TABLE "TRADE_GNNT"."C_RIGHT" ADD CHECK (VISIBLE in (-1,0));
ALTER TABLE "TRADE_GNNT"."C_RIGHT" ADD CHECK ("ID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."C_RIGHT" ADD CHECK ("MODULEID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."C_RIGHT" ADD CHECK ("TYPE" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table C_RIGHT
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."C_RIGHT" ADD PRIMARY KEY ("ID");

-- ----------------------------
-- Indexes structure for table C_ROLE
-- ----------------------------

-- ----------------------------
-- Checks structure for table C_ROLE
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."C_ROLE" ADD CHECK ("ID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."C_ROLE" ADD CHECK ("NAME" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table C_ROLE
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."C_ROLE" ADD PRIMARY KEY ("ID");

-- ----------------------------
-- Indexes structure for table C_ROLE_RIGHT
-- ----------------------------

-- ----------------------------
-- Checks structure for table C_ROLE_RIGHT
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."C_ROLE_RIGHT" ADD CHECK ("RIGHTID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."C_ROLE_RIGHT" ADD CHECK ("ROLEID" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table C_ROLE_RIGHT
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."C_ROLE_RIGHT" ADD PRIMARY KEY ("RIGHTID", "ROLEID");

-- ----------------------------
-- Indexes structure for table C_SUBMODULE
-- ----------------------------

-- ----------------------------
-- Checks structure for table C_SUBMODULE
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."C_SUBMODULE" ADD CHECK ("MODULEID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."C_SUBMODULE" ADD CHECK ("CNNAME" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."C_SUBMODULE" ADD CHECK ("PARENTMODULEID" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table C_SUBMODULE
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."C_SUBMODULE" ADD PRIMARY KEY ("MODULEID");

-- ----------------------------
-- Indexes structure for table C_TRADEMODULE
-- ----------------------------

-- ----------------------------
-- Checks structure for table C_TRADEMODULE
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."C_TRADEMODULE" ADD CHECK ("MODULEID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."C_TRADEMODULE" ADD CHECK ("CNNAME" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."C_TRADEMODULE" ADD CHECK ("ISFIRMSET" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."C_TRADEMODULE" ADD CHECK ("ISBALANCECHECK" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."C_TRADEMODULE" ADD CHECK ("ISNEEDBREED" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table C_TRADEMODULE
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."C_TRADEMODULE" ADD PRIMARY KEY ("MODULEID");

-- ----------------------------
-- Indexes structure for table C_USER
-- ----------------------------

-- ----------------------------
-- Checks structure for table C_USER
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."C_USER" ADD CHECK ("ID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."C_USER" ADD CHECK ("TYPE" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."C_USER" ADD CHECK ("ISFORBID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."C_USER" ADD CHECK ("SKIN" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."C_USER" ADD CHECK ("KEYCODE" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table C_USER
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."C_USER" ADD PRIMARY KEY ("ID");

-- ----------------------------
-- Indexes structure for table C_USER_RIGHT
-- ----------------------------

-- ----------------------------
-- Checks structure for table C_USER_RIGHT
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."C_USER_RIGHT" ADD CHECK ("RIGHTID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."C_USER_RIGHT" ADD CHECK ("USERID" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table C_USER_RIGHT
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."C_USER_RIGHT" ADD PRIMARY KEY ("RIGHTID", "USERID");

-- ----------------------------
-- Indexes structure for table C_USER_ROLE
-- ----------------------------

-- ----------------------------
-- Checks structure for table C_USER_ROLE
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."C_USER_ROLE" ADD CHECK ("USERID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."C_USER_ROLE" ADD CHECK ("ROLEID" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table C_USER_ROLE
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."C_USER_ROLE" ADD PRIMARY KEY ("USERID", "ROLEID");

-- ----------------------------
-- Indexes structure for table C_XMLTEMPLATE
-- ----------------------------

-- ----------------------------
-- Checks structure for table C_XMLTEMPLATE
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."C_XMLTEMPLATE" ADD CHECK ("ID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."C_XMLTEMPLATE" ADD CHECK ("CLOB" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."C_XMLTEMPLATE" ADD CHECK ("ID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."C_XMLTEMPLATE" ADD CHECK ("CLOB" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table C_XMLTEMPLATE
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."C_XMLTEMPLATE" ADD PRIMARY KEY ("ID");
