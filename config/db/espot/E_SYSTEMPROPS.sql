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

Date: 2015-11-17 20:43:14
*/


-- ----------------------------
-- Table structure for E_SYSTEMPROPS
-- ----------------------------
DROP TABLE "TRADE_GNNT"."E_SYSTEMPROPS";
CREATE TABLE "TRADE_GNNT"."E_SYSTEMPROPS" (
"KEY" VARCHAR2(32 BYTE) NOT NULL ,
"VALUE" VARCHAR2(64 BYTE) NOT NULL ,
"RUNTIMEVALUE" VARCHAR2(64 BYTE) NULL ,
"NOTE" VARCHAR2(128 BYTE) NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON COLUMN "TRADE_GNNT"."E_SYSTEMPROPS"."VALUE" IS '手续费、保证金等参数设置';

-- ----------------------------
-- Records of E_SYSTEMPROPS
-- ----------------------------
INSERT INTO "TRADE_GNNT"."E_SYSTEMPROPS" VALUES ('LeastSubscription', '1000', '1000', '最低风险金');
INSERT INTO "TRADE_GNNT"."E_SYSTEMPROPS" VALUES ('TradePreTime', '2', '2', '默认保证金支付期限(小时)');
INSERT INTO "TRADE_GNNT"."E_SYSTEMPROPS" VALUES ('DeliveryPreTime', '5', '5', '默认交收准备期限(小时)');
INSERT INTO "TRADE_GNNT"."E_SYSTEMPROPS" VALUES ('OrderValidTime', '24', '24', '默认委托有效期限(小时)');
INSERT INTO "TRADE_GNNT"."E_SYSTEMPROPS" VALUES ('TradeFeeMode', '2', '2', '交易手续费模式 1：固定值 2：百分比');
INSERT INTO "TRADE_GNNT"."E_SYSTEMPROPS" VALUES ('TradeFeeRate', '0.01', '0.01', '交易手续费率');
INSERT INTO "TRADE_GNNT"."E_SYSTEMPROPS" VALUES ('OneTradeMargin', '1000', '1000', '单笔诚信保障金');
INSERT INTO "TRADE_GNNT"."E_SYSTEMPROPS" VALUES ('TradeMarginMagnification', '2', '2', '诚信保障金放大率');
INSERT INTO "TRADE_GNNT"."E_SYSTEMPROPS" VALUES ('DeliveryFeeMode', '2', '2', '交收手续费模式 1：固定值 2：百分比');
INSERT INTO "TRADE_GNNT"."E_SYSTEMPROPS" VALUES ('DeliveryFeeRate', '0.02', '0.02', '交收手续费率');
INSERT INTO "TRADE_GNNT"."E_SYSTEMPROPS" VALUES ('DeliveryMarginMode', '2', '2', '交收保证金模式 1：固定值 2：百分比');
INSERT INTO "TRADE_GNNT"."E_SYSTEMPROPS" VALUES ('DeliveryMarginRate', '0.2', '0.2', '交收保证金率');
INSERT INTO "TRADE_GNNT"."E_SYSTEMPROPS" VALUES ('FirstPaymentRate', '0.200000', '0.200000', '首款比例');
INSERT INTO "TRADE_GNNT"."E_SYSTEMPROPS" VALUES ('SecondPaymentRate', '0.600000', '0.600000', '第二笔货款比例');
INSERT INTO "TRADE_GNNT"."E_SYSTEMPROPS" VALUES ('PayTimes', '3', '3', '付款次数 只能为2或者3');
INSERT INTO "TRADE_GNNT"."E_SYSTEMPROPS" VALUES ('BuyOrderAudit', '1', '1', '买挂牌是否需要审核 0：需要 1 不需要');
INSERT INTO "TRADE_GNNT"."E_SYSTEMPROPS" VALUES ('SellOrderAudit', '1', '1', '卖挂牌是否需要审核 0：需要 1 不需要');
INSERT INTO "TRADE_GNNT"."E_SYSTEMPROPS" VALUES ('SellPledgeAudit', '1', '1', '卖仓单是否需要审核 0：需要 1 不需要');
INSERT INTO "TRADE_GNNT"."E_SYSTEMPROPS" VALUES ('Offset', '1', '1', '溢短比例');

-- ----------------------------
-- Indexes structure for table E_SYSTEMPROPS
-- ----------------------------

-- ----------------------------
-- Checks structure for table E_SYSTEMPROPS
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."E_SYSTEMPROPS" ADD CHECK ("KEY" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."E_SYSTEMPROPS" ADD CHECK ("VALUE" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table E_SYSTEMPROPS
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."E_SYSTEMPROPS" ADD PRIMARY KEY ("KEY");
