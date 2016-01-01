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

Date: 2015-11-11 22:48:50
*/


-- ----------------------------
-- Table structure for BR_BROKERMENU
-- ----------------------------
DROP TABLE "TRADE_GNNT"."BR_BROKERMENU";
CREATE TABLE "TRADE_GNNT"."BR_BROKERMENU" (
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
"ISWRITELOG" VARCHAR2(1 BYTE) DEFAULT 'N'  NULL ,
"ONLYMEMBER" NUMBER(2) DEFAULT 0  NOT NULL ,
"MENUBROKERTYPE" NUMBER(2) DEFAULT 0  NOT NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;

-- ----------------------------
-- Records of BR_BROKERMENU
-- ----------------------------
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('9901000027', '-1', '查询数据库时间', null, '/sysDate/getDate.action', null, '99', '27', '0', '-3', '0', 'Y', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('9901000026', '-1', '修改登录密码', null, '/self/passwordSelfSave.action', null, '99', '26', '0', '-3', '9901', 'Y', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('9901000025', '-1', '修改登录密码跳转', null, '/broker/frame/modpasswordself.jsp', null, '99', '25', '0', '-3', '0', 'Y', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('9901000024', '-1', '修改风格', null, '/user/saveShinStyle.action', null, '99', '24', '0', '-3', '9901', 'Y', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('9901000023', '-1', '修改风格页面', null, '/broker/frame/shinstyle.jsp', null, '99', '23', '0', '-3', '0', 'Y', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('9901000022', '-1', '用户退出', null, '/user/logout.action', null, '99', '22', '0', '-2', '9901', 'Y', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('9901000021', '-1', '登陆', null, '/user/logon.action', null, '99', '21', '0', '-2', '0', 'Y', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('9901000020', '-1', 'activemq访问路径', null, '/amq', null, '99', '20', '0', '-3', '0', 'Y', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('9901000019', '-1', '快捷菜单设置修改', null, '/myMenu/updateMyMenu.action', null, '99', '19', '0', '-3', '9901', 'Y', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('9901000018', '-1', '快捷菜单设置跳转', null, '/myMenu/getMyMenu.action', null, '99', '18', '0', '-3', '0', 'Y', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('9901000017', '-1', '菜单页面', null, '/menu/menuList.action', null, '99', '17', '0', '-3', '0', 'Y', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('9901000016', '-1', '菜单显示页面', null, '/broker/frame/leftMenu.jsp', null, '99', '16', '0', '-3', '0', 'Y', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('9901000015', '-1', '分栏页面', null, '/broker/frame/shrinkbar.jsp', null, '99', '15', '0', '-3', '0', 'Y', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('9901000014', '-1', '展示下页面', null, '/broker/frame/rightframe_bottom.jsp', null, '99', '14', '0', '-3', '0', 'Y', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('9901000013', '-1', '展示上页面', null, '/broker/frame/rightframe_top.jsp', null, '99', '13', '0', '-3', '0', 'Y', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('9901000012', '-1', '展示主页面', null, '/broker/frame/rightframe.jsp', null, '99', '12', '0', '-3', '0', 'Y', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('9901000011', '-1', '靠上页面', null, '/broker/frame/topframe.jsp', null, '99', '11', '0', '-3', '0', 'Y', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('9901000010', '-1', '主页面', null, '/broker/frame/mainframe.jsp', null, '99', '10', '0', '-3', '0', 'Y', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('9901000009', '-1', '存放用户AU系统中sessionID', null, '/broker/public/jsp/session.jsp', null, '99', '9', '0', '-3', '0', 'Y', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('9901000008', '-1', '错误页面', null, '/broker/public/jsp/error.jsp', null, '99', '8', '0', '-3', '0', 'Y', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('9901000007', '-1', 'session失效页面', null, '/broker/public/jsp/nosession.jsp', null, '99', '7', '0', '-2', '0', 'Y', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('9901000006', '-1', '无权限页面', null, '/broker/public/jsp/noright.jsp', null, '99', '6', '0', '-2', '0', 'Y', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('9901000005', '-1', '请等待页面', null, '/broker/frame/waiting.jsp', null, '99', '5', '0', '-3', '0', 'Y', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('9901000004', '-1', '没有头部的主页面', null, '/broker/frame/mainframe_nohead.jsp', null, '99', '4', '0', '-3', '0', 'Y', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('9901000003', '-1', '最外围页面', null, '/broker/frame/framepage.jsp', null, '99', '3', '0', '-3', '0', 'Y', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('9901000002', '-1', '验证码', null, '/broker/public/jsp/logoncheckimage.jsp', null, '99', '2', '0', '-2', '0', 'Y', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('9901000001', '-1', '登录页面', null, '/broker/logon.jsp', null, '99', '1', '0', '-2', '0', 'Y', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('9900000000', null, '主菜单', null, null, null, '99', '1', '0', '-1', '0', 'Y', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1001000000', '9900000000', '综合加盟商端', null, null, null, '10', '0', '0', '-1', '0', 'N', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1001010000', '1001000000', '用户管理', '42_42.gif', null, null, '10', '1', '0', '-1', '1910', 'N', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1001020000', '1001000000', '资金查询', '42_42.gif', null, null, '10', '2', '0', '-1', '1910', 'N', '1', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1001030000', '1001000000', '居间商管理', '42_42.gif', null, null, '10', '3', '0', '-1', '0', 'N', '1', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1001010100', '1001010000', '未审核交易商', '29_29.gif', '/broker/firmManager/listFirmApply.action', '/broker/firmManager/listFirmApply.action?sortColumns=order+by+createtime+desc', '10', '1', '0', '0', '1910', 'N', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1001010201', '1001010200', '查看已审核交易商', '29_29.gif', '/broker/firmManager/viewByIdFirm.action', '/broker/firmManager/viewByIdFirm.action', '10', '1', '0', '1', '1910', 'N', '1', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1001020100', '1001020000', '待付佣金', '29_29.gif', '/broker/clientLedger/listBrokerReward.action', '/broker/clientLedger/listBrokerReward.action', '10', '1', '0', '0', '1910', 'N', '1', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1001020200', '1001020000', '总账明细', '29_29.gif', '/broker/clientLedger/clientLedger.action', '/broker/clientLedger/clientLedger.action?sortColumns=order+by+b_Date', '10', '2', '0', '0', '1910', 'N', '1', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1001020300', '1001020000', '总账汇总', '29_29.gif', '/broker/clientLedger/clientLedgerSum.action', '/broker/clientLedger/clientLedgerSum.action', '10', '3', '0', '0', '1910', 'N', '1', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1001030100', '1001030000', '设置居间商', '29_29.gif', '/broker/brokerage/brokeragelist.action', '/broker/brokerage/brokeragelist.action?sortColumns=order+by+brokerageid+asc', '10', '1', '0', '0', '1910', 'N', '1', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1001030101', '1001030100', '居间商添加权限跳转', null, '/broker/brokerage/brokerageforward.action', null, '10', '1', '0', '1', '1910', 'N', '1', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1001030102', '1001030100', '居间商删除权限', null, '/broker/brokerage/deleteBrokerage.action', null, '10', '2', '0', '1', '1910', 'N', '1', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1001030103', '1001030100', '居间商跳查权限', null, '/broker/brokerage/viewByIdBrokerage.action', null, '10', '3', '0', '1', '1910', 'N', '1', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1001030104', '1001030100', '居间商修改权限', null, '/broker/brokerage/updateBrokerage.action', null, '10', '4', '0', '1', '1910', 'N', '1', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1001030105', '1001030100', '居间商添加权限', null, '/broker/brokerage/addBrokerage.action', null, '10', '5', '0', '1', '1910', 'N', '1', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1001030106', '1001030100', '居间商密码修改权限', null, '/broker/brokerage/updatePWD*', null, '10', '6', '0', '1', '1910', 'N', '1', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1001030107', '1001030100', '交易商绑定关系权限', null, '/broker/brokerage/managerFirm*', null, '10', '7', '0', '1', '1910', 'N', '1', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1001010101', '1001010100', '开户申请添加页面', '29_29.gif', '/broker/firmManager/forwardAddFirmApply.action', '/broker/firmManager/forwardAddFirmApply.action', '10', '1', '0', '1', '1910', 'N', '1', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1001010103', '1001010100', '删除开户申请', '29_29.gif', '/broker/firmManager/delete.action', '/broker/firmManager/delete.action', '10', '3', '0', '1', '1910', 'N', '1', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1001010104', '1001010100', '查看开户申请', '29_29.gif', '/broker/firmManager/viewByIdFirmApply.action', '/broker/firmManager/viewByIdFirmApply.action', '10', '4', '0', '1', '1910', 'N', '1', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1001010105', '1001010100', '修改开户申请', '29_29.gif', '/broker/firmManager/updateFirmApply.action', '/broker/firmManager/updateFirmApply.action', '10', '5', '0', '1', '1910', 'N', '1', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1001010102', '1001010100', '添加开户申请', '29_29.gif', '/broker/firmManager/addFirmApply.action', '/broker/firmManager/addFirmApply.action', '10', '2', '0', '1', '1910', 'N', '1', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1001010200', '1001010000', '已审核交易商', '29_29.gif', '/broker/firmManager/listFirm.action', '/broker/firmManager/listFirm.action', '10', '2', '0', '0', '1910', 'N', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1001010202', '1001010200', '修改已审核交易商', '29_29.gif', '/broker/firmManager/updateFirm.action', '/broker/firmManager/updateFirm.action', '10', '2', '0', '1', '1910', 'N', '1', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1001010300', '1001010000', '交易商开户申请', '29_29.gif', '/broker/firmManager/forwardAddFirm.action', '/broker/firmManager/forwardAddFirm.action', '10', '1', '0', '0', '1901', 'N', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1001010301', '1001010300', '申请提交', null, '/broker/firmManager/addFirm.action', null, '10', '1', '0', '1', '1901', 'N', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1501010000', '1501000000', '交易商套餐设置', '42_42.gif', null, null, '15', '1', '0', '-1', '0', 'N', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1501020000', '1501000000', '佣金查询', '42_42.gif', null, null, '15', '2', '0', '-1', '0', 'N', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1501000000', '9900000000', '订单加盟商端', null, null, null, '15', '0', '0', '-1', '0', 'N', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1501030000', '1501000000', '统计报表', '42_42.gif', null, null, '15', '3', '0', '-1', '0', 'N', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1501040000', '1501000000', '风险监控', '42_42.gif', null, null, '15', '4', '0', '-1', '0', 'N', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1501050000', '1501000000', '代为转让', '42_42.gif', null, null, '15', '5', '0', '-1', '0', 'N', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1501010100', '1501010000', '套餐设置', '29_29.gif', '/firm/tariff/tariffList.action', '/firm/tariff/tariffList.action?sortColumns=order+by+firmID+asc', '15', '1', '0', '0', '0', 'N', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1501010101', '1501010100', '查看权限', null, '/firm/tariff/detailTariff*', null, '15', '1', '0', '1', '0', 'N', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1501010102', '1501010100', '修改权限', null, '/firm/tariff/updateTariff*', null, '15', '2', '0', '1', '0', 'N', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1501020100', '1501020000', '交易商佣金明细', '29_29.gif', '/firm/tariff/tradeFeeFirmList.action', '/firm/tariff/tradeFeeFirmList.action', '15', '1', '0', '0', '0', 'N', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1501020200', '1501020000', '分品种佣金汇总', '29_29.gif', '/firm/tariff/tradeFeeFirmCommodityList.action', '/firm/tariff/tradeFeeFirmCommodityList.action', '15', '2', '0', '0', '0', 'N', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1501030100', '1501030000', '订货统计表', '29_29.gif', '/timebargain/report/indentStatisticQuery.action', '/timebargain/report/indentStatisticQuery.action', '15', '1', '0', '0', '1915', 'N', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1501030101', '1501030100', '订货统计查看保存', null, '/timebargain/report/indentStatisticReport*', null, '15', '1', '0', '1', '1915', 'N', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1501030200', '1501030000', '订货汇总表', '29_29.gif', '/timebargain/report/indentCollectQuery.action', '/timebargain/report/indentCollectQuery.action', '15', '2', '0', '0', '1915', 'N', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1501030201', '1501030200', '订货汇总查看权限', null, '/timebargain/indentCollectReport/indentCollectReport*', null, '15', '1', '0', '1', '1915', 'N', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1501030202', '1501030200', '订货汇总跳转权限', null, '/app/timebargain/report/indentCollectReport*', null, '15', '2', '0', '1', '1915', 'N', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1501030300', '1501030000', '分商品成交量统计表', '29_29.gif', '/timebargain/report/comTradeQuery.action', '/timebargain/report/comTradeQuery.action', '15', '3', '0', '0', '1915', 'N', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1501030301', '1501030300', '分商品成交量查看保存', null, '/timebargain/report/comTradeReport*', null, '15', '1', '0', '1', '1915', 'N', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1501030400', '1501030000', '资金结算表', '29_29.gif', '/timebargain/report/fundSettlementQuery.action', '/timebargain/report/fundSettlementQuery.action', '15', '4', '0', '0', '1915', 'N', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1501030401', '1501030400', '资金结算表查看权限', null, '/timebargain/fundSettlementReport/fundSettlement*', null, '15', '1', '0', '1', '1915', 'N', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1501030402', '1501030400', '资金结算表跳转权限', null, '/app/timebargain/report/fundSettlementReport*', null, '15', '2', '0', '1', '1915', 'N', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1501030500', '1501030000', '资金汇总表', '29_29.gif', '/timebargain/report/fundCollectQuery.action', '/timebargain/report/fundCollectQuery.action', '15', '5', '0', '0', '1915', 'N', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1501030501', '1501030500', '资金汇总查看权限', null, '/timebargain/fundCollectReport/fundCollect*', null, '15', '1', '0', '1', '1915', 'N', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1501030502', '1501030500', '资金汇总跳转权限', null, '/app/timebargain/report/fundCollectReport*', null, '15', '2', '0', '1', '1915', 'N', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1501030600', '1501030000', '转让盈亏明细表', '29_29.gif', '/timebargain/report/transferProfitAndLossQuery.action', '/timebargain/report/transferProfitAndLossQuery.action', '15', '6', '0', '0', '1915', 'N', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1501030601', '1501030600', '转让盈亏明细表查看权限', null, '/timebargain/transferProfitAndLoss/transferProfitAndLoss*', null, '15', '1', '0', '1', '1915', 'N', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1501030602', '1501030600', '转让盈亏明细表跳转权限', null, '/app/timebargain/report/transferProfitAndLossReport*', null, '15', '2', '0', '1', '1915', 'N', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1501030700', '1501030000', '成交记录表', '29_29.gif', '/timebargain/report/bargainResultQuery.action', '/timebargain/report/bargainResultQuery.action', '15', '7', '0', '0', '1915', 'N', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1501030701', '1501030700', '成交记录表查看权限', null, '/timebargain/bargainResultReport/bargainResultReport*', null, '15', '1', '0', '1', '1915', 'N', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1501030702', '1501030700', '成交记录表跳转权限', null, '/app/timebargain/report/bargainResultReport*', null, '15', '2', '0', '1', '1915', 'N', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1501030800', '1501030000', '交割情况表', '29_29.gif', '/timebargain/report/settleStatusQuery.action', '/timebargain/report/settleStatusQuery.action', '15', '8', '0', '0', '1915', 'N', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1501030801', '1501030800', '交割情况查看保存', null, '/timebargain/report/settleStatusReport*', null, '15', '1', '0', '1', '1915', 'N', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1501030900', '1501030000', '资金不足情况表', '29_29.gif', '/timebargain/report/tradeUserNotEnoughMoneyQuery.action', '/timebargain/report/tradeUserNotEnoughMoneyQuery.action', '15', '9', '0', '0', '1915', 'N', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1501030901', '1501030900', '资金不足情况查看保存', null, '/timebargain/report/tradeUserNotEnoughMoneyReport*', null, '15', '1', '0', '1', '1915', 'N', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1501040100', '1501040000', '成交明细', '29_29.gif', '/timebargain/monitor/monitor*', '/timebargain/monitor/monitorGetCommodityList.action?type=tradeList', '15', '1', '0', '0', '1915', 'N', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1501040101', '1501040100', '成交明细查询权限', null, '/timebargain/monitor/monitor*', null, '15', '1', '0', '1', '1915', 'N', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1501040200', '1501040000', '商品订货监控', '29_29.gif', '/timebargain/monitor/monitor*', '/timebargain/monitor/monitorGetCommodityList.action?type=commodityMonitor', '15', '2', '0', '0', '1915', 'N', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1501040300', '1501040000', '委托监控', '29_29.gif', '/timebargain/monitor/monitor*', '/timebargain/monitor/monitorGetCommodityList.action?type=orderMonitor', '15', '3', '0', '0', '1915', 'N', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1501040400', '1501040000', '资金预警', '29_29.gif', '/broker/app/timebargain/monitor/monitor_fundsAnalysis.jsp', '/broker/app/timebargain/monitor/monitor_fundsAnalysis.jsp', '15', '4', '0', '0', '1915', 'N', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1501040500', '1501040000', '排行分析', '29_29.gif', '/broker/app/timebargain/monitor/monitor_analyseInfo.jsp', '/broker/app/timebargain/monitor/monitor_analyseInfo.jsp', '15', '5', '0', '0', '1915', 'N', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1501050100', '1501050000', '代为转让', '29_29.gif', '/timebargain/authorize/forceForward.action', '/timebargain/authorize/forceForward.action', '15', '1', '0', '0', '0', 'N', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1501050200', '1501050000', '代为撤单', '29_29.gif', '/timebargain/authorize/noTradeListForward.action', '/timebargain/authorize/noTradeListForward.action', '15', '2', '0', '0', '0', 'N', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1501050300', '1501050000', '修改代为委托员密码', '29_29.gif', '/timebargain/authorize/passwordForward.action', '/timebargain/authorize/passwordForward.action', '15', '3', '0', '0', '0', 'N', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1501050101', '1501050100', '代为委托员登陆验证', null, '/timebargain/authorize/chkLogin.action*', null, '15', '1', '0', '1', '0', 'N', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1501050102', '1501050100', '代为委托员登陆', null, '/timebargain/authorize/loginConsigner.action', null, '15', '2', '0', '1', '0', 'N', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1501050103', '1501050100', '代为委托员注销', null, '/timebargain/authorize/logoffConsigner.action*', null, '15', '3', '0', '1', '0', 'N', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1501050104', '1501050100', '代为委托员密码修改', null, '/timebargain/authorize/passwordConsigner.action', null, '15', '4', '0', '1', '0', 'N', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1501050105', '1501050100', '代为委托员登陆框架', null, '/broker/app/timebargain/authorize/traderLogin.jsp', null, '15', '5', '0', '1', '0', 'N', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1501050106', '1501050100', ' 代为委托员登陆页面', null, '/broker/app/timebargain/authorize/traderLogin_form.jsp', null, '15', '6', '0', '1', '0', 'N', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1501050107', '1501050100', '强转列表查询', null, '/timebargain/authorize/searchForceClose.action', null, '15', '7', '0', '1', '0', 'N', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1501050108', '1501050100', '强转信息查询', null, '/timebargain/authorize/forceCloseInfo.action*', null, '15', '8', '0', '1', '0', 'N', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1501050109', '1501050100', '强转操作', null, '/timebargain/authorize/forceClose.action', null, '15', '9', '0', '1', '0', 'N', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1501050110', '1501050100', '查询一手对应保证金', null, '/ajaxcheck/order/searchForceCloseMoney.action*', null, '15', '10', '0', '1', '0', 'N', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1501050111', '1501050100', '强转信息查询框架', null, '/broker/app/timebargain/authorize/forceClose_list_qp.jsp*', null, '15', '11', '0', '1', '0', 'N', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1501050201', '1501050200', '代为撤单列表查询', null, '/timebargain/authorize/noTradeList.action', null, '15', '1', '0', '1', '0', 'N', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1501050202', '1501050200', '代为撤单操作', null, '/timebargain/authorize/withdrawOrder.action', null, '15', '2', '0', '1', '0', 'N', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1501050301', '1501050300', '修改代为委托员密码跳转', null, '/timebargain/authorize/updatePasswordForward.action', null, '15', '1', '0', '1', '0', 'N', '0', '0');
INSERT INTO "TRADE_GNNT"."BR_BROKERMENU" VALUES ('1501050302', '1501050300', '修改代为委托员密码操作', null, '/timebargain/authorize/updatePassword.action', null, '15', '2', '0', '1', '0', 'N', '0', '0');

-- ----------------------------
-- Indexes structure for table BR_BROKERMENU
-- ----------------------------

-- ----------------------------
-- Checks structure for table BR_BROKERMENU
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."BR_BROKERMENU" ADD CHECK (TYPE in (-3,-2,-1,0,1));
ALTER TABLE "TRADE_GNNT"."BR_BROKERMENU" ADD CHECK (VISIBLE in (-1,0));
ALTER TABLE "TRADE_GNNT"."BR_BROKERMENU" ADD CHECK ("ID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."BR_BROKERMENU" ADD CHECK ("MODULEID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."BR_BROKERMENU" ADD CHECK ("TYPE" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."BR_BROKERMENU" ADD CHECK ("ONLYMEMBER" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."BR_BROKERMENU" ADD CHECK ("MENUBROKERTYPE" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table BR_BROKERMENU
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."BR_BROKERMENU" ADD PRIMARY KEY ("ID");
