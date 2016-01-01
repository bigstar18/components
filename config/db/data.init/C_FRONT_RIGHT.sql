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

Date: 2015-11-11 22:50:26
*/


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
