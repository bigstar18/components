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

Date: 2015-11-13 21:20:18
*/


-- ----------------------------
-- Table structure for W_ERRORLOGINLOG
-- ----------------------------
DROP TABLE "TRADE_GNNT"."W_ERRORLOGINLOG";
CREATE TABLE "TRADE_GNNT"."W_ERRORLOGINLOG" (
"ERRORLOGINID" NUMBER(15) NOT NULL ,
"USERID" VARCHAR2(32 BYTE) NOT NULL ,
"LOGINDATE" DATE NOT NULL ,
"WAREHOUSEID" VARCHAR2(32 BYTE) NOT NULL ,
"IP" VARCHAR2(32 BYTE) NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON COLUMN "TRADE_GNNT"."W_ERRORLOGINLOG"."USERID" IS '管理员Id';

-- ----------------------------
-- Records of W_ERRORLOGINLOG
-- ----------------------------

-- ----------------------------
-- Table structure for W_GLOBALLOG_ALL
-- ----------------------------
DROP TABLE "TRADE_GNNT"."W_GLOBALLOG_ALL";
CREATE TABLE "TRADE_GNNT"."W_GLOBALLOG_ALL" (
"ID" NUMBER(15) NOT NULL ,
"OPERATOR" VARCHAR2(32 BYTE) NULL ,
"WAREHOUSEID" VARCHAR2(32 BYTE) NULL ,
"OPERATETIME" DATE DEFAULT sysdate  NULL ,
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
COMMENT ON COLUMN "TRADE_GNNT"."W_GLOBALLOG_ALL"."ID" IS 'ID';
COMMENT ON COLUMN "TRADE_GNNT"."W_GLOBALLOG_ALL"."OPERATOR" IS '操作人';
COMMENT ON COLUMN "TRADE_GNNT"."W_GLOBALLOG_ALL"."OPERATETIME" IS '操作时间';
COMMENT ON COLUMN "TRADE_GNNT"."W_GLOBALLOG_ALL"."OPERATETYPE" IS '操作类型';
COMMENT ON COLUMN "TRADE_GNNT"."W_GLOBALLOG_ALL"."OPERATEIP" IS '操作IP';
COMMENT ON COLUMN "TRADE_GNNT"."W_GLOBALLOG_ALL"."OPERATORTYPE" IS '操作人种类';
COMMENT ON COLUMN "TRADE_GNNT"."W_GLOBALLOG_ALL"."MARK" IS '标示';
COMMENT ON COLUMN "TRADE_GNNT"."W_GLOBALLOG_ALL"."OPERATECONTENT" IS '操作内容';
COMMENT ON COLUMN "TRADE_GNNT"."W_GLOBALLOG_ALL"."CURRENTVALUE" IS '当前值';
COMMENT ON COLUMN "TRADE_GNNT"."W_GLOBALLOG_ALL"."OPERATERESULT" IS '操作结果 1 成功  0 失败';

-- ----------------------------
-- Records of W_GLOBALLOG_ALL
-- ----------------------------

-- ----------------------------
-- Table structure for W_GLOBALLOG_ALL_H
-- ----------------------------
DROP TABLE "TRADE_GNNT"."W_GLOBALLOG_ALL_H";
CREATE TABLE "TRADE_GNNT"."W_GLOBALLOG_ALL_H" (
"ID" NUMBER(15) NOT NULL ,
"OPERATOR" VARCHAR2(32 BYTE) NULL ,
"WAREHOUSEID" VARCHAR2(32 BYTE) NULL ,
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
COMMENT ON COLUMN "TRADE_GNNT"."W_GLOBALLOG_ALL_H"."ID" IS 'ID';
COMMENT ON COLUMN "TRADE_GNNT"."W_GLOBALLOG_ALL_H"."OPERATOR" IS '操作人';
COMMENT ON COLUMN "TRADE_GNNT"."W_GLOBALLOG_ALL_H"."OPERATETIME" IS '操作时间';
COMMENT ON COLUMN "TRADE_GNNT"."W_GLOBALLOG_ALL_H"."OPERATETYPE" IS '操作类型';
COMMENT ON COLUMN "TRADE_GNNT"."W_GLOBALLOG_ALL_H"."OPERATEIP" IS '操作IP';
COMMENT ON COLUMN "TRADE_GNNT"."W_GLOBALLOG_ALL_H"."OPERATORTYPE" IS '操作人种类';
COMMENT ON COLUMN "TRADE_GNNT"."W_GLOBALLOG_ALL_H"."MARK" IS '标示';
COMMENT ON COLUMN "TRADE_GNNT"."W_GLOBALLOG_ALL_H"."OPERATECONTENT" IS '操作内容';
COMMENT ON COLUMN "TRADE_GNNT"."W_GLOBALLOG_ALL_H"."CURRENTVALUE" IS '当前值';
COMMENT ON COLUMN "TRADE_GNNT"."W_GLOBALLOG_ALL_H"."OPERATERESULT" IS '操作结果 1 成功  0 失败';

-- ----------------------------
-- Records of W_GLOBALLOG_ALL_H
-- ----------------------------

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
-- Table structure for W_MYMENU
-- ----------------------------
DROP TABLE "TRADE_GNNT"."W_MYMENU";
CREATE TABLE "TRADE_GNNT"."W_MYMENU" (
"USERID" VARCHAR2(32 BYTE) NOT NULL ,
"RIGHTID" NUMBER(10) NOT NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;

-- ----------------------------
-- Records of W_MYMENU
-- ----------------------------

-- ----------------------------
-- Table structure for W_RIGHT
-- ----------------------------
DROP TABLE "TRADE_GNNT"."W_RIGHT";
CREATE TABLE "TRADE_GNNT"."W_RIGHT" (
"ID" NUMBER(10) NOT NULL ,
"PARENTID" NUMBER(10) NULL ,
"NAME" VARCHAR2(128 BYTE) NULL ,
"MODULEID" NUMBER(2) NOT NULL ,
"ICON" VARCHAR2(128 BYTE) NULL ,
"AUTHORITYURL" VARCHAR2(512 BYTE) NULL ,
"VISITURL" VARCHAR2(512 BYTE) NULL ,
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
COMMENT ON COLUMN "TRADE_GNNT"."W_RIGHT"."ID" IS ' 规范：
1：开头两位为系统模块号
2: 第三四位为一级菜单
3：第五六位为二级菜单
4：第七八位为三级菜单
5：第九十位为页面中的增删改查
';
COMMENT ON COLUMN "TRADE_GNNT"."W_RIGHT"."PARENTID" IS '父关联';
COMMENT ON COLUMN "TRADE_GNNT"."W_RIGHT"."NAME" IS '权限名称';
COMMENT ON COLUMN "TRADE_GNNT"."W_RIGHT"."ICON" IS '图标';
COMMENT ON COLUMN "TRADE_GNNT"."W_RIGHT"."AUTHORITYURL" IS '权限路径';
COMMENT ON COLUMN "TRADE_GNNT"."W_RIGHT"."VISITURL" IS '真实路径';
COMMENT ON COLUMN "TRADE_GNNT"."W_RIGHT"."SEQ" IS '序号';
COMMENT ON COLUMN "TRADE_GNNT"."W_RIGHT"."VISIBLE" IS '是否可见-1 不可见0 可见';
COMMENT ON COLUMN "TRADE_GNNT"."W_RIGHT"."TYPE" IS '类型-3:只检查session不检查权限的url -2：无需判断权限的URL -1： 父菜单类型 0：子菜单类型 1：页面内增删改查权限';
COMMENT ON COLUMN "TRADE_GNNT"."W_RIGHT"."CATALOGID" IS '日志类型 0不写日志 其它对应表w_logcatalog 的CATALOGID字段';
COMMENT ON COLUMN "TRADE_GNNT"."W_RIGHT"."ISWRITELOG" IS '''Y''：写日志、''N''：不写日志';

-- ----------------------------
-- Records of W_RIGHT
-- ----------------------------
INSERT INTO "TRADE_GNNT"."W_RIGHT" VALUES ('9900000000', null, '主菜单', '99', null, null, null, '1', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."W_RIGHT" VALUES ('9901000001', '-1', '登录页面', '99', null, '/mgr/logon.jsp', null, '1', '0', '-2', '0', 'N');
INSERT INTO "TRADE_GNNT"."W_RIGHT" VALUES ('9901000002', '-1', '验证码', '99', null, '/mgr/public/jsp/logoncheckimage.jsp', null, '2', '0', '-2', '0', 'N');
INSERT INTO "TRADE_GNNT"."W_RIGHT" VALUES ('9901000003', '-1', '最外围页面', '99', null, '/mgr/frame/framepage.jsp', null, '3', '0', '-3', '0', 'N');
INSERT INTO "TRADE_GNNT"."W_RIGHT" VALUES ('9901000004', '-1', '没有头部的主页面', '99', null, '/mgr/frame/mainframe_nohead.jsp', null, '4', '0', '-3', '0', 'N');
INSERT INTO "TRADE_GNNT"."W_RIGHT" VALUES ('9901000006', '-1', '无权限页面', '99', null, '/mgr/public/jsp/noright.jsp', null, '6', '0', '-2', '0', 'N');
INSERT INTO "TRADE_GNNT"."W_RIGHT" VALUES ('9901000007', '-1', 'session失效页面', '99', null, '/mgr/public/jsp/nosession.jsp', null, '7', '0', '-2', '0', 'N');
INSERT INTO "TRADE_GNNT"."W_RIGHT" VALUES ('9901000008', '-1', '错误页面', '99', null, '/mgr/public/jsp/error.jsp', null, '8', '0', '-3', '0', 'N');
INSERT INTO "TRADE_GNNT"."W_RIGHT" VALUES ('9901000009', '-1', '存放用户AU系统中sessionID', '99', null, '/mgr/public/jsp/session.jsp', null, '9', '0', '-3', '0', 'N');
INSERT INTO "TRADE_GNNT"."W_RIGHT" VALUES ('9901000010', '-1', '主页面', '99', null, '/mgr/frame/mainframe.jsp', null, '10', '0', '-3', '0', 'N');
INSERT INTO "TRADE_GNNT"."W_RIGHT" VALUES ('9901000011', '-1', '靠上页面', '99', null, '/mgr/frame/topframe.jsp', null, '11', '0', '-3', '0', 'N');
INSERT INTO "TRADE_GNNT"."W_RIGHT" VALUES ('9901000012', '-1', '展示主页面', '99', null, '/mgr/frame/rightframe.jsp', null, '12', '0', '-3', '0', 'N');
INSERT INTO "TRADE_GNNT"."W_RIGHT" VALUES ('9901000013', '-1', '展示上页面', '99', null, '/mgr/frame/rightframe_top.jsp', null, '13', '0', '-3', '0', 'N');
INSERT INTO "TRADE_GNNT"."W_RIGHT" VALUES ('9901000014', '-1', '展示下页面', '99', null, '/mgr/frame/rightframe_bottom.jsp', null, '14', '0', '-3', '0', 'N');
INSERT INTO "TRADE_GNNT"."W_RIGHT" VALUES ('9901000015', '-1', '分栏页面', '99', null, '/mgr/frame/shrinkbar.jsp', null, '15', '0', '-3', '0', 'N');
INSERT INTO "TRADE_GNNT"."W_RIGHT" VALUES ('9901000016', '-1', '菜单显示页面', '99', null, '/mgr/frame/leftMenu.jsp', null, '16', '0', '-3', '0', 'N');
INSERT INTO "TRADE_GNNT"."W_RIGHT" VALUES ('9901000017', '-1', '菜单页面', '99', null, '/menu/menuList.action', null, '17', '0', '-3', '0', 'N');
INSERT INTO "TRADE_GNNT"."W_RIGHT" VALUES ('9901000018', '-1', '快捷菜单设置跳转', '99', null, '/myMenu/getMyMenu.action', null, '18', '0', '-3', '0', 'N');
INSERT INTO "TRADE_GNNT"."W_RIGHT" VALUES ('9901000019', '-1', '快捷菜单设置修改', '99', null, '/myMenu/updateMyMenu.action', null, '19', '0', '-3', '9901', 'N');
INSERT INTO "TRADE_GNNT"."W_RIGHT" VALUES ('9901000020', '-1', 'activemq访问路径', '99', null, '/amq', null, '20', '0', '-3', '0', 'N');
INSERT INTO "TRADE_GNNT"."W_RIGHT" VALUES ('9901000021', '-1', '登陆', '99', null, '/user/logon.action', null, '21', '0', '-2', '0', 'N');
INSERT INTO "TRADE_GNNT"."W_RIGHT" VALUES ('9901000022', '-1', '用户退出', '99', null, '/user/logout.action', null, '22', '0', '-2', '9901', 'N');
INSERT INTO "TRADE_GNNT"."W_RIGHT" VALUES ('9901000023', '-1', '修改风格页面', '99', null, '/mgr/frame/shinstyle.jsp', null, '23', '0', '-3', '0', 'N');
INSERT INTO "TRADE_GNNT"."W_RIGHT" VALUES ('9901000024', '-1', '修改风格', '99', null, '/user/saveShinStyle.action', null, '24', '0', '-3', '9901', 'N');
INSERT INTO "TRADE_GNNT"."W_RIGHT" VALUES ('9901000025', '-1', '修改登录密码跳转', '99', null, '/self/passwordSelfMod.action', null, '25', '0', '-3', '0', 'N');
INSERT INTO "TRADE_GNNT"."W_RIGHT" VALUES ('9901000026', '-1', '修改登录密码', '99', null, '/self/passwordSelfSave.action', null, '26', '0', '-3', '9901', 'N');
INSERT INTO "TRADE_GNNT"."W_RIGHT" VALUES ('9901000027', '-1', '查询数据库时间', '99', null, '/sysDate/getDate.action', null, '27', '0', '-3', '0', 'N');
INSERT INTO "TRADE_GNNT"."W_RIGHT" VALUES ('9901000028', '-1', '等待跳转页面', '99', null, '/mgr/frame/waiting.jsp', null, '28', '0', '-3', '0', 'N');
INSERT INTO "TRADE_GNNT"."W_RIGHT" VALUES ('1201000000', '9900000000', '管理员管理', '12', null, null, null, '1', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."W_RIGHT" VALUES ('1201010000', '1201000000', '用户管理', '12', '42_42.gif', null, null, '1', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."W_RIGHT" VALUES ('1201010100', '1201010000', '用户设置', '12', '29_29.gif', '/user/*', '/user/list.action?sortColumns=order+by+userId', '1', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."W_RIGHT" VALUES ('1201010101', '1201010100', '添加用户权限', '12', null, '/user/add*', null, '1', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."W_RIGHT" VALUES ('1201010102', '1201010100', '修改用户权限', '12', null, '/user/update*', null, '2', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."W_RIGHT" VALUES ('1201010103', '1201010100', '删除用户权限', '12', null, '/user/delete*', null, '3', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."W_RIGHT" VALUES ('1201010104', '1201010100', '关联角色查看权限', '12', null, '/user/forwardRelatedRight.action', null, '4', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."W_RIGHT" VALUES ('1201010105', '1201010104', '关联角色修改权限', '12', null, '/user/updateRelatedRight.action', null, '1', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."W_RIGHT" VALUES ('1201010106', '1201010100', '系统用户密码查看权限', '12', null, '/user/forwardUpdatePassword.action', null, '5', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."W_RIGHT" VALUES ('1201010107', '1201010106', '系统用户密码修改权限', '12', null, '/user/updatePassword.action', null, '1', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."W_RIGHT" VALUES ('1201010200', '1201010000', '角色管理', '12', '29_29.gif', '/role/*', '/role/roleList.action?sortColumns=order+by+id', '2', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."W_RIGHT" VALUES ('1201010201', '1201010200', '添加角色', '12', null, '/role/add*', '/role/addRole.action', '1', '0', '1', '1201', 'N');
INSERT INTO "TRADE_GNNT"."W_RIGHT" VALUES ('1201010202', '1201010200', '修改角色', '12', null, '/role/update*', '/role/updateRole.action', '2', '0', '1', '1201', 'N');
INSERT INTO "TRADE_GNNT"."W_RIGHT" VALUES ('1201010203', '1201010200', '删除角色', '12', null, '/role/delete*', '/role/deleteRole.action', '3', '0', '1', '1201', 'N');
INSERT INTO "TRADE_GNNT"."W_RIGHT" VALUES ('1201010300', '1201010000', '用户解锁', '12', '29_29.gif', '/user/errorLogonLog/*', '/user/errorLogonLog/list.action?sortColumns=order+by+userID', '3', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."W_RIGHT" VALUES ('1201010301', '1201010300', '查看异常登录权限', '12', null, '/user/errorLogonLog/getDetail.action', null, '1', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."W_RIGHT" VALUES ('1201010302', '1201010300', '修改异常登录权限', '12', null, '/user/errorLogonLog/active*', null, '2', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."W_RIGHT" VALUES ('1201010400', '1201010000', '管理员操作日志', '12', '29_29.gif', '/log/*', '/log/list.action?sortColumns=order+by+operateTime+desc', '4', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."W_RIGHT" VALUES ('1202000000', '9900000000', '仓单管理', '12', null, null, null, '2', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."W_RIGHT" VALUES ('1202010000', '1202000000', '仓单管理', '12', '42_42.gif', null, null, '1', '0', '-1', '0', 'N');
INSERT INTO "TRADE_GNNT"."W_RIGHT" VALUES ('1202010100', '1202010000', '可用仓单管理', '12', '29_29.gif', '/stock/list/*', '/stock/list/stockList.action?sortColumns=order+by+stockId', '1', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."W_RIGHT" VALUES ('1202010101', '1202010100', '查看权限', '12', null, '/stock/list/stockDetails.action', null, '1', '0', '1', null, 'N');
INSERT INTO "TRADE_GNNT"."W_RIGHT" VALUES ('1202010102', '1202010100', '仓单添加权限', '12', null, '/stock/list/add*', null, '2', '0', '1', null, 'N');
INSERT INTO "TRADE_GNNT"."W_RIGHT" VALUES ('1202010103', '1202010100', '查看品名权限', '12', null, '/stock/addStock/jsonForStock/getBreedByCategoryID.action', '/stock/addStock/jsonForStock/getBreedByCategoryID.action', '3', '0', '1', null, 'N');
INSERT INTO "TRADE_GNNT"."W_RIGHT" VALUES ('1202010104', '1202010100', '查看属性权限', '12', null, '/stock/addStock/jsonForStock/getPropertyValueByBreedID.action', '/stock/addStock/jsonForStock/getPropertyValueByBreedID.action', '4', '0', '1', null, 'N');
INSERT INTO "TRADE_GNNT"."W_RIGHT" VALUES ('1202010200', '1202010000', '拆单申请管理', '12', '29_29.gif', '/stock/apart/*', '/stock/apart/list.action?sortColumns=order+by+id', '2', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."W_RIGHT" VALUES ('1202010201', '1202010200', '查看仓单详情权限', '12', null, '/stock/apart/stockDetails*', '/stock/apart/stockDetails.action', '1', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."W_RIGHT" VALUES ('1202010202', '1202010200', '拆仓单修改权限', '12', null, '/stock/apart/update*', null, '2', '0', '1', null, 'N');
INSERT INTO "TRADE_GNNT"."W_RIGHT" VALUES ('1202010300', '1202010000', '已拆仓单列表', '12', '29_29.gif', '/stock/dismantlelist*', '/stock/dismantlelist/stockDismantleList.action?sortColumns=order+by+dismantleId&isQueryDB=true', '3', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."W_RIGHT" VALUES ('1202010301', '1202010300', '查看仓单详情权限', '12', null, '/stock/dismantlelist/dismantleDetails*', '/stock/dismantlelist/dismantleDetails.action', '1', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."W_RIGHT" VALUES ('1202010400', '1202010000', '出库申请管理', '12', '29_29.gif', '/stock/exitlist/*', '/stock/exitlist/stockOutApplyList.action?sortColumns=order+by+stockId', '4', '0', '0', '0', 'N');
INSERT INTO "TRADE_GNNT"."W_RIGHT" VALUES ('1202010401', '1202010400', '查看仓单详情权限', '12', null, '/stock/exitlist/stockOut*', '/stock/exitlist/stockOutReal.action', '1', '0', '1', '0', 'N');
INSERT INTO "TRADE_GNNT"."W_RIGHT" VALUES ('1202010500', '1202010000', '出库仓单列表', '12', '29_29.gif', '/stock/exitlist*', '/stock/exitlist/stockList.action?sortColumns=order+by+stockId&isQueryDB=true', '5', '0', '0', '0', 'N');

-- ----------------------------
-- Table structure for W_ROLE
-- ----------------------------
DROP TABLE "TRADE_GNNT"."W_ROLE";
CREATE TABLE "TRADE_GNNT"."W_ROLE" (
"ID" NUMBER(10) NOT NULL ,
"NAME" VARCHAR2(32 BYTE) NOT NULL ,
"WAREHOUSEID" VARCHAR2(32 BYTE) NOT NULL ,
"DESCRIPTION" VARCHAR2(256 BYTE) NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON COLUMN "TRADE_GNNT"."W_ROLE"."ID" IS '角色Id';
COMMENT ON COLUMN "TRADE_GNNT"."W_ROLE"."NAME" IS '角色名称';
COMMENT ON COLUMN "TRADE_GNNT"."W_ROLE"."DESCRIPTION" IS '描述';

-- ----------------------------
-- Records of W_ROLE
-- ----------------------------

-- ----------------------------
-- Table structure for W_ROLE_RIGHT
-- ----------------------------
DROP TABLE "TRADE_GNNT"."W_ROLE_RIGHT";
CREATE TABLE "TRADE_GNNT"."W_ROLE_RIGHT" (
"RIGHTID" NUMBER(10) NOT NULL ,
"ROLEID" NUMBER(10) NOT NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON COLUMN "TRADE_GNNT"."W_ROLE_RIGHT"."RIGHTID" IS '权限Id';
COMMENT ON COLUMN "TRADE_GNNT"."W_ROLE_RIGHT"."ROLEID" IS '角色Id';

-- ----------------------------
-- Records of W_ROLE_RIGHT
-- ----------------------------

-- ----------------------------
-- Table structure for W_TRADEMODULE
-- ----------------------------
DROP TABLE "TRADE_GNNT"."W_TRADEMODULE";
CREATE TABLE "TRADE_GNNT"."W_TRADEMODULE" (
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
COMMENT ON COLUMN "TRADE_GNNT"."W_TRADEMODULE"."MODULEID" IS '10综合管理平台
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
COMMENT ON COLUMN "TRADE_GNNT"."W_TRADEMODULE"."ISFIRMSET" IS '‘Y’ 是 ‘N’ 否 (如果需要在公用前台我的平台中显示本系统，还需要在公用系统的 spring_sys_msg.xml 中配置上本系统的配置信息)';
COMMENT ON COLUMN "TRADE_GNNT"."W_TRADEMODULE"."ISBALANCECHECK" IS 'Y：是 N：否';
COMMENT ON COLUMN "TRADE_GNNT"."W_TRADEMODULE"."ISNEEDBREED" IS '本系统是否需要综合管理平台增加的商品   Y:是   N:否';

-- ----------------------------
-- Records of W_TRADEMODULE
-- ----------------------------
INSERT INTO "TRADE_GNNT"."W_TRADEMODULE" VALUES ('99', 'common', '公用系统', '公用系统', null, null, null, 'N', null, null, null, 'N', 'Y');
INSERT INTO "TRADE_GNNT"."W_TRADEMODULE" VALUES ('12', 'integrated', '综合系统', '综合系统', null, null, null, 'N', null, null, null, 'N', 'Y');

-- ----------------------------
-- Table structure for W_USER
-- ----------------------------
DROP TABLE "TRADE_GNNT"."W_USER";
CREATE TABLE "TRADE_GNNT"."W_USER" (
"USERID" VARCHAR2(32 BYTE) NOT NULL ,
"WAREHOUSEID" VARCHAR2(32 BYTE) NOT NULL ,
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
COMMENT ON COLUMN "TRADE_GNNT"."W_USER"."USERID" IS '管理员Id';
COMMENT ON COLUMN "TRADE_GNNT"."W_USER"."NAME" IS '管理员名称';
COMMENT ON COLUMN "TRADE_GNNT"."W_USER"."PASSWORD" IS '密码';
COMMENT ON COLUMN "TRADE_GNNT"."W_USER"."TYPE" IS 'ADMIN：普通管理员角色DEFAULT_ADMIN：高级管理员角色DEFAULT_SUPER_ADMIN：默认超级管理员角色';
COMMENT ON COLUMN "TRADE_GNNT"."W_USER"."DESCRIPTION" IS '描述';
COMMENT ON COLUMN "TRADE_GNNT"."W_USER"."ISFORBID" IS 'Y：禁用
N：不禁用
';
COMMENT ON COLUMN "TRADE_GNNT"."W_USER"."SKIN" IS '皮肤';
COMMENT ON COLUMN "TRADE_GNNT"."W_USER"."KEYCODE" IS 'key';

-- ----------------------------
-- Records of W_USER
-- ----------------------------
INSERT INTO "TRADE_GNNT"."W_USER" VALUES ('111111', '188', '黄晓新', '593c9b4a9390551d53e5cacf28ebd638', 'DEFAULT_SUPER_ADMIN', null, 'N', 'default', '0123456789ABCDE');
INSERT INTO "TRADE_GNNT"."W_USER" VALUES ('sy', '0001', '孙艳', '852d11f09d769c21329ff2b9af138524', 'DEFAULT_SUPER_ADMIN', null, 'N', 'default', '0123456789ABCDE');
INSERT INTO "TRADE_GNNT"."W_USER" VALUES ('huaishanyao01', '0004', '张三', 'be7dd9fe6efacb2d64fc4ea3df74bb0d', 'DEFAULT_SUPER_ADMIN', null, 'N', 'default', '0123456789ABCDE');
INSERT INTO "TRADE_GNNT"."W_USER" VALUES ('xiangmudiban', '008', 'xiangmudiban', '1d2e11b9ad8f3d7926d6ca789ad83efc', 'DEFAULT_SUPER_ADMIN', null, 'N', 'default', '0123456789ABCDE');
INSERT INTO "TRADE_GNNT"."W_USER" VALUES ('L', '0006', 'L', '3e5f1217a504acacfd1f16459b9b3bea', 'ADMIN', null, 'N', 'default', '0123456789ABCDE');
INSERT INTO "TRADE_GNNT"."W_USER" VALUES ('1', '0006', '1', '7fa8282ad93047a4d6fe6111c93b308a', 'ADMIN', null, 'N', 'default', '0123456789ABCDE');
INSERT INTO "TRADE_GNNT"."W_USER" VALUES ('huangya', '006', 'huangya', '1ef795efeeecca42510e919ccc2590be', 'DEFAULT_SUPER_ADMIN', null, 'N', 'default', '0123456789ABCDE');
INSERT INTO "TRADE_GNNT"."W_USER" VALUES ('heimuer', '007', 'heimuer', '3d2d88a9f70e36851fbe665c7130d8ab', 'DEFAULT_SUPER_ADMIN', null, 'N', 'default', '0123456789ABCDE');
INSERT INTO "TRADE_GNNT"."W_USER" VALUES ('wht', '0006', 'wht', 'b204ca20e8c3e9bc5813d9021eefbaae', 'DEFAULT_SUPER_ADMIN', null, 'N', 'default', '0123456789ABCDE');
INSERT INTO "TRADE_GNNT"."W_USER" VALUES ('CDJW', '001', 'h', '05becb940d139e908283a83c27ea2f14', 'DEFAULT_SUPER_ADMIN', null, 'N', 'default', '0123456789ABCDE');
INSERT INTO "TRADE_GNNT"."W_USER" VALUES ('0002', '0002', 'sy0002', 'ba6a0510bf74ba229684a7a3865b560c', 'DEFAULT_SUPER_ADMIN', null, 'N', 'gray', '0123456789ABCDE');
INSERT INTO "TRADE_GNNT"."W_USER" VALUES ('0003', '0003', 'sy0003', '847b0ad509ee4b97e81c2d3be530aa1a', 'DEFAULT_SUPER_ADMIN', null, 'N', 'default', '0123456789ABCDE');
INSERT INTO "TRADE_GNNT"."W_USER" VALUES ('gnnt', '2', 'gnnt', '2f659cb076e185e50e5ead9507cec224', 'DEFAULT_SUPER_ADMIN', null, 'N', 'default', '0123456789ABCDE');
INSERT INTO "TRADE_GNNT"."W_USER" VALUES ('WQS', '005', 'WQS', '113d3d66fa9d1367eb012e6d99391098', 'DEFAULT_SUPER_ADMIN', null, 'N', 'default', '0123456789ABCDE');
INSERT INTO "TRADE_GNNT"."W_USER" VALUES ('moganhuangya', '009', 'moganhuangya', '8f03fdb027db7f2d4205c220bc425746', 'DEFAULT_SUPER_ADMIN', null, 'N', 'default', '0123456789ABCDE');

-- ----------------------------
-- Table structure for W_USER_RIGHT
-- ----------------------------
DROP TABLE "TRADE_GNNT"."W_USER_RIGHT";
CREATE TABLE "TRADE_GNNT"."W_USER_RIGHT" (
"RIGHTID" NUMBER(10) NOT NULL ,
"USERID" VARCHAR2(32 BYTE) NOT NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON COLUMN "TRADE_GNNT"."W_USER_RIGHT"."RIGHTID" IS '权限Id
权限Id';
COMMENT ON COLUMN "TRADE_GNNT"."W_USER_RIGHT"."USERID" IS '管理员Id';

-- ----------------------------
-- Records of W_USER_RIGHT
-- ----------------------------

-- ----------------------------
-- Table structure for W_USER_ROLE
-- ----------------------------
DROP TABLE "TRADE_GNNT"."W_USER_ROLE";
CREATE TABLE "TRADE_GNNT"."W_USER_ROLE" (
"USERID" VARCHAR2(32 BYTE) NOT NULL ,
"ROLEID" NUMBER(10) NOT NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON COLUMN "TRADE_GNNT"."W_USER_ROLE"."USERID" IS '管理员Id';
COMMENT ON COLUMN "TRADE_GNNT"."W_USER_ROLE"."ROLEID" IS '角色Id';

-- ----------------------------
-- Records of W_USER_ROLE
-- ----------------------------

-- ----------------------------
-- Indexes structure for table W_ERRORLOGINLOG
-- ----------------------------

-- ----------------------------
-- Checks structure for table W_ERRORLOGINLOG
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."W_ERRORLOGINLOG" ADD CHECK ("ERRORLOGINID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."W_ERRORLOGINLOG" ADD CHECK ("USERID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."W_ERRORLOGINLOG" ADD CHECK ("LOGINDATE" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."W_ERRORLOGINLOG" ADD CHECK ("WAREHOUSEID" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table W_ERRORLOGINLOG
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."W_ERRORLOGINLOG" ADD PRIMARY KEY ("ERRORLOGINID");

-- ----------------------------
-- Indexes structure for table W_GLOBALLOG_ALL
-- ----------------------------

-- ----------------------------
-- Checks structure for table W_GLOBALLOG_ALL
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."W_GLOBALLOG_ALL" ADD CHECK (operateresult in(0,1));
ALTER TABLE "TRADE_GNNT"."W_GLOBALLOG_ALL" ADD CHECK ("ID" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table W_GLOBALLOG_ALL
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."W_GLOBALLOG_ALL" ADD PRIMARY KEY ("ID");

-- ----------------------------
-- Checks structure for table W_GLOBALLOG_ALL_H
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."W_GLOBALLOG_ALL_H" ADD CHECK (operateresult in(0,1));
ALTER TABLE "TRADE_GNNT"."W_GLOBALLOG_ALL_H" ADD CHECK ("ID" IS NOT NULL);

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

-- ----------------------------
-- Indexes structure for table W_MYMENU
-- ----------------------------

-- ----------------------------
-- Checks structure for table W_MYMENU
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."W_MYMENU" ADD CHECK ("USERID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."W_MYMENU" ADD CHECK ("RIGHTID" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table W_MYMENU
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."W_MYMENU" ADD PRIMARY KEY ("USERID", "RIGHTID");

-- ----------------------------
-- Indexes structure for table W_RIGHT
-- ----------------------------

-- ----------------------------
-- Checks structure for table W_RIGHT
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."W_RIGHT" ADD CHECK (TYPE in (-3,-2,-1,0,1));
ALTER TABLE "TRADE_GNNT"."W_RIGHT" ADD CHECK (VISIBLE in (-1,0));
ALTER TABLE "TRADE_GNNT"."W_RIGHT" ADD CHECK ("ID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."W_RIGHT" ADD CHECK ("MODULEID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."W_RIGHT" ADD CHECK ("TYPE" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table W_RIGHT
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."W_RIGHT" ADD PRIMARY KEY ("ID");

-- ----------------------------
-- Indexes structure for table W_ROLE
-- ----------------------------

-- ----------------------------
-- Checks structure for table W_ROLE
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."W_ROLE" ADD CHECK ("ID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."W_ROLE" ADD CHECK ("NAME" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."W_ROLE" ADD CHECK ("WAREHOUSEID" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table W_ROLE
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."W_ROLE" ADD PRIMARY KEY ("ID");

-- ----------------------------
-- Indexes structure for table W_ROLE_RIGHT
-- ----------------------------

-- ----------------------------
-- Checks structure for table W_ROLE_RIGHT
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."W_ROLE_RIGHT" ADD CHECK ("RIGHTID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."W_ROLE_RIGHT" ADD CHECK ("ROLEID" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table W_ROLE_RIGHT
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."W_ROLE_RIGHT" ADD PRIMARY KEY ("RIGHTID", "ROLEID");

-- ----------------------------
-- Indexes structure for table W_TRADEMODULE
-- ----------------------------

-- ----------------------------
-- Checks structure for table W_TRADEMODULE
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."W_TRADEMODULE" ADD CHECK ("MODULEID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."W_TRADEMODULE" ADD CHECK ("CNNAME" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."W_TRADEMODULE" ADD CHECK ("ISFIRMSET" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."W_TRADEMODULE" ADD CHECK ("ISBALANCECHECK" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."W_TRADEMODULE" ADD CHECK ("ISNEEDBREED" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table W_TRADEMODULE
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."W_TRADEMODULE" ADD PRIMARY KEY ("MODULEID");

-- ----------------------------
-- Indexes structure for table W_USER
-- ----------------------------

-- ----------------------------
-- Checks structure for table W_USER
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."W_USER" ADD CHECK ("USERID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."W_USER" ADD CHECK ("WAREHOUSEID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."W_USER" ADD CHECK ("TYPE" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."W_USER" ADD CHECK ("ISFORBID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."W_USER" ADD CHECK ("SKIN" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."W_USER" ADD CHECK ("KEYCODE" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table W_USER
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."W_USER" ADD PRIMARY KEY ("USERID");

-- ----------------------------
-- Indexes structure for table W_USER_RIGHT
-- ----------------------------

-- ----------------------------
-- Checks structure for table W_USER_RIGHT
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."W_USER_RIGHT" ADD CHECK ("RIGHTID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."W_USER_RIGHT" ADD CHECK ("USERID" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table W_USER_RIGHT
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."W_USER_RIGHT" ADD PRIMARY KEY ("RIGHTID", "USERID");

-- ----------------------------
-- Indexes structure for table W_USER_ROLE
-- ----------------------------

-- ----------------------------
-- Checks structure for table W_USER_ROLE
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."W_USER_ROLE" ADD CHECK ("USERID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."W_USER_ROLE" ADD CHECK ("ROLEID" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table W_USER_ROLE
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."W_USER_ROLE" ADD PRIMARY KEY ("USERID", "ROLEID");
