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

Date: 2015-11-17 15:09:41
*/


-- ----------------------------
-- Table structure for V_TEMPLETCLASSSET
-- ----------------------------
DROP TABLE "TRADE_GNNT"."V_TEMPLETCLASSSET";
CREATE TABLE "TRADE_GNNT"."V_TEMPLETCLASSSET" (
"ID" NUMBER(10) NOT NULL ,
"CLASS" VARCHAR2(256 BYTE) NOT NULL ,
"TYPE" NUMBER(2) NOT NULL ,
"NAME" VARCHAR2(256 BYTE) NOT NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;

-- ----------------------------
-- Records of V_TEMPLETCLASSSET
-- ----------------------------
INSERT INTO "TRADE_GNNT"."V_TEMPLETCLASSSET" VALUES ('1', 'gnnt.MEBS.vendue.service.impl.FirmLimitImpl', '0', '交易商权限验证');
INSERT INTO "TRADE_GNNT"."V_TEMPLETCLASSSET" VALUES ('2', 'gnnt.MEBS.priceranking.server.tradeEngine.impl.ValidetCommodityForBuy', '1', '竞买商品属性验证');
INSERT INTO "TRADE_GNNT"."V_TEMPLETCLASSSET" VALUES ('3', 'gnnt.MEBS.priceranking.server.tradeEngine.impl.ValidetCommodityForSell', '1', '竞卖商品属性验证');
INSERT INTO "TRADE_GNNT"."V_TEMPLETCLASSSET" VALUES ('4', 'gnnt.MEBS.priceranking.server.tradeEngine.impl.ValidetCommodityForBid', '1', '招标商品属性验证');
INSERT INTO "TRADE_GNNT"."V_TEMPLETCLASSSET" VALUES ('5', 'gnnt.MEBS.priceranking.server.tradeEngine.impl.TradeRuleForSplit', '2', '拆分交易规则');
INSERT INTO "TRADE_GNNT"."V_TEMPLETCLASSSET" VALUES ('6', 'gnnt.MEBS.priceranking.server.tradeEngine.impl.TradeRuleForMonoblock', '2', '不拆分交易规则');
INSERT INTO "TRADE_GNNT"."V_TEMPLETCLASSSET" VALUES ('7', 'gnnt.MEBS.priceranking.server.tradeEngine.impl.TradeRuleForBid', '2', '招标交易规则');
INSERT INTO "TRADE_GNNT"."V_TEMPLETCLASSSET" VALUES ('8', 'gnnt.MEBS.priceranking.server.tradeEngine.impl.TradeProcessForBuyImpl', '3', '竞买成交对象');
INSERT INTO "TRADE_GNNT"."V_TEMPLETCLASSSET" VALUES ('9', 'gnnt.MEBS.priceranking.server.tradeEngine.impl.TradeProcessForSellImpl', '3', '竞卖成交对象');
INSERT INTO "TRADE_GNNT"."V_TEMPLETCLASSSET" VALUES ('10', 'gnnt.MEBS.priceranking.server.tradeEngine.impl.TradeProcessForBidImpl', '3', '招标成交对象');
INSERT INTO "TRADE_GNNT"."V_TEMPLETCLASSSET" VALUES ('11', 'gnnt.MEBS.priceranking.server.timeEngine.impl.KernelEngineImpl', '4', '竞买竞卖流程控制');
INSERT INTO "TRADE_GNNT"."V_TEMPLETCLASSSET" VALUES ('13', 'gnnt.MEBS.priceranking.server.timeEngine.impl.CountDownEngineImpl', '5', '倒计时对象');

-- ----------------------------
-- Indexes structure for table V_TEMPLETCLASSSET
-- ----------------------------

-- ----------------------------
-- Checks structure for table V_TEMPLETCLASSSET
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."V_TEMPLETCLASSSET" ADD CHECK ("ID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."V_TEMPLETCLASSSET" ADD CHECK ("CLASS" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."V_TEMPLETCLASSSET" ADD CHECK ("TYPE" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."V_TEMPLETCLASSSET" ADD CHECK ("NAME" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."V_TEMPLETCLASSSET" ADD CHECK ("ID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."V_TEMPLETCLASSSET" ADD CHECK ("CLASS" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."V_TEMPLETCLASSSET" ADD CHECK ("TYPE" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."V_TEMPLETCLASSSET" ADD CHECK ("NAME" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table V_TEMPLETCLASSSET
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."V_TEMPLETCLASSSET" ADD PRIMARY KEY ("ID");
