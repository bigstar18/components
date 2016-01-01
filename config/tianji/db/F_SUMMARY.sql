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

Date: 2015-11-11 22:04:22
*/


-- ----------------------------
-- Table structure for F_SUMMARY
-- ----------------------------
DROP TABLE "TRADE_GNNT"."F_SUMMARY";
CREATE TABLE "TRADE_GNNT"."F_SUMMARY" (
"SUMMARYNO" CHAR(5 BYTE) NOT NULL ,
"SUMMARY" VARCHAR2(32 BYTE) NOT NULL ,
"LEDGERITEM" VARCHAR2(16 BYTE) NULL ,
"FUNDDCFLAG" CHAR(1 BYTE) DEFAULT 'N'  NOT NULL ,
"ACCOUNTCODEOPP" VARCHAR2(16 BYTE) NULL ,
"APPENDACCOUNT" CHAR(1 BYTE) DEFAULT 'N'  NOT NULL ,
"ISINIT" CHAR(1 BYTE) DEFAULT 'Y'  NOT NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON COLUMN "TRADE_GNNT"."F_SUMMARY"."FUNDDCFLAG" IS '该凭证如果涉及交易商资金，增加资金记贷方 C，减少资金记借方 D。
不涉及交易商资金：N';
COMMENT ON COLUMN "TRADE_GNNT"."F_SUMMARY"."ACCOUNTCODEOPP" IS '用于电脑凭证';
COMMENT ON COLUMN "TRADE_GNNT"."F_SUMMARY"."APPENDACCOUNT" IS '除了资金发生变动外，还有附加的财务账户变动。
T：增值税 Tax
W：担保金 Warranty
S：交收保证金 SettleMargin
N：无附加';
COMMENT ON COLUMN "TRADE_GNNT"."F_SUMMARY"."ISINIT" IS 'Y:是初始化数据,页面不允许删除和修改
N:不是初始化数据';

-- ----------------------------
-- Records of F_SUMMARY
-- ----------------------------
INSERT INTO "TRADE_GNNT"."F_SUMMARY" VALUES ('11001', '交易商入金', 'Deposit', 'C', null, 'N', 'Y');
INSERT INTO "TRADE_GNNT"."F_SUMMARY" VALUES ('11002', '交易商出金', 'Fetch', 'D', null, 'N', 'Y');
INSERT INTO "TRADE_GNNT"."F_SUMMARY" VALUES ('11003', '银转入金', 'Deposit', 'C', 'spec', 'N', 'Y');
INSERT INTO "TRADE_GNNT"."F_SUMMARY" VALUES ('11004', '银转出金', 'Fetch', 'D', 'spec', 'N', 'Y');
INSERT INTO "TRADE_GNNT"."F_SUMMARY" VALUES ('11005', '代收银转手续费', 'BankFee', 'D', '200303', 'N', 'Y');
INSERT INTO "TRADE_GNNT"."F_SUMMARY" VALUES ('11006', '结转代收银转手续费', null, 'N', null, 'N', 'Y');
INSERT INTO "TRADE_GNNT"."F_SUMMARY" VALUES ('11007', '发生银行费用', null, 'N', null, 'N', 'Y');
INSERT INTO "TRADE_GNNT"."F_SUMMARY" VALUES ('11011', '计提风险准备金', null, 'N', null, 'N', 'Y');
INSERT INTO "TRADE_GNNT"."F_SUMMARY" VALUES ('11012', '冲抵风险准备金', 'OtherItem', 'N', null, 'N', 'Y');
INSERT INTO "TRADE_GNNT"."F_SUMMARY" VALUES ('11013', '收抵押手续费', null, 'N', null, 'N', 'Y');
INSERT INTO "TRADE_GNNT"."F_SUMMARY" VALUES ('11014', '结转代收质押手续费', null, 'N', null, 'N', 'Y');
INSERT INTO "TRADE_GNNT"."F_SUMMARY" VALUES ('11015', '代收仓储费', null, 'N', null, 'N', 'Y');
INSERT INTO "TRADE_GNNT"."F_SUMMARY" VALUES ('11016', '结转交收代收仓储费', null, 'N', null, 'N', 'Y');
INSERT INTO "TRADE_GNNT"."F_SUMMARY" VALUES ('11017', '发生银行利息', null, 'N', null, 'N', 'Y');
INSERT INTO "TRADE_GNNT"."F_SUMMARY" VALUES ('11018', '付交易商存款利息', 'OtherItem', 'C', '2007', 'N', 'Y');
INSERT INTO "TRADE_GNNT"."F_SUMMARY" VALUES ('11019', '内部结转', null, 'N', null, 'N', 'Y');
INSERT INTO "TRADE_GNNT"."F_SUMMARY" VALUES ('15100', '交收收交易商税费', 'OtherItem_T', 'D', '100515*', 'N', 'N');
INSERT INTO "TRADE_GNNT"."F_SUMMARY" VALUES ('15101', '交收退交易商税费', 'OtherItem_T', 'C', '100515*', 'N', 'N');
INSERT INTO "TRADE_GNNT"."F_SUMMARY" VALUES ('15001', '订单收交易手续费', 'TradeFee_T', 'D', '20030115', 'N', 'Y');
INSERT INTO "TRADE_GNNT"."F_SUMMARY" VALUES ('15002', '订单收交易保证金', 'Margin_T', 'D', '200215*', 'W', 'Y');
INSERT INTO "TRADE_GNNT"."F_SUMMARY" VALUES ('15003', '订单退交易保证金', 'Margin_T', 'C', '200215*', 'W', 'Y');
INSERT INTO "TRADE_GNNT"."F_SUMMARY" VALUES ('15004', '订单收浮亏', 'FL_T', 'D', '200215*', 'N', 'Y');
INSERT INTO "TRADE_GNNT"."F_SUMMARY" VALUES ('15005', '订单退浮亏', 'FL_T', 'C', '200215*', 'N', 'Y');
INSERT INTO "TRADE_GNNT"."F_SUMMARY" VALUES ('15006', '订单付交易盈利', 'TradePL_T', 'C', '200215*', 'T', 'Y');
INSERT INTO "TRADE_GNNT"."F_SUMMARY" VALUES ('15007', '订单收交易亏损', 'TradePL_T', 'D', '200215*', 'T', 'Y');
INSERT INTO "TRADE_GNNT"."F_SUMMARY" VALUES ('15008', '订单收交易商货款', 'Payout_T', 'D', '200215*', 'N', 'Y');
INSERT INTO "TRADE_GNNT"."F_SUMMARY" VALUES ('15009', '订单付交易商货款', 'Income_T', 'C', '200215*', 'N', 'Y');
INSERT INTO "TRADE_GNNT"."F_SUMMARY" VALUES ('15010', '订单收交收手续费', 'SettleFee_T', 'D', '20030215', 'N', 'Y');
INSERT INTO "TRADE_GNNT"."F_SUMMARY" VALUES ('15011', '订单付交收盈利', 'SettlePL_T', 'C', '200215*', 'T', 'Y');
INSERT INTO "TRADE_GNNT"."F_SUMMARY" VALUES ('15012', '订单收交收亏损', 'SettlePL_T', 'D', '200215*', 'T', 'Y');
INSERT INTO "TRADE_GNNT"."F_SUMMARY" VALUES ('15013', '订单收交收保证金', 'SettleMargin_T', 'D', '200215*', 'N', 'Y');
INSERT INTO "TRADE_GNNT"."F_SUMMARY" VALUES ('15014', '订单退交收保证金', 'SettleMargin_T', 'C', '200215*', 'N', 'Y');
INSERT INTO "TRADE_GNNT"."F_SUMMARY" VALUES ('15015', '订单收净浮亏', 'FL_T', 'D', '200215$', 'N', 'Y');
INSERT INTO "TRADE_GNNT"."F_SUMMARY" VALUES ('15016', '订单退净浮亏', 'FL_T', 'C', '200215$', 'N', 'Y');
INSERT INTO "TRADE_GNNT"."F_SUMMARY" VALUES ('15017', '订单收违约金', 'OtherItem_T', 'D', '200415*', 'N', 'Y');
INSERT INTO "TRADE_GNNT"."F_SUMMARY" VALUES ('15018', '订单退违约金', 'OtherItem_T', 'C', '200415*', 'N', 'Y');
INSERT INTO "TRADE_GNNT"."F_SUMMARY" VALUES ('15019', '订单付佣金', 'Income_T', 'C', '20030115', 'N', 'Y');
INSERT INTO "TRADE_GNNT"."F_SUMMARY" VALUES ('15020', '订单收延期补偿费', 'SettleCompens_T', 'D', '200515*', 'N', 'Y');
INSERT INTO "TRADE_GNNT"."F_SUMMARY" VALUES ('15021', '订单付延期补偿费', 'SettleCompens_T', 'C', '200515*', 'N', 'Y');
INSERT INTO "TRADE_GNNT"."F_SUMMARY" VALUES ('15022', '订单结转交易手续费', null, 'N', null, 'N', 'Y');
INSERT INTO "TRADE_GNNT"."F_SUMMARY" VALUES ('15023', '订单结转交收手续费', null, 'N', null, 'N', 'Y');
INSERT INTO "TRADE_GNNT"."F_SUMMARY" VALUES ('15094', '订单退交易商担保金', null, 'C', '209915*', 'N', 'Y');
INSERT INTO "TRADE_GNNT"."F_SUMMARY" VALUES ('15095', '订单收交易商担保金', null, 'D', '209915*', 'N', 'Y');
INSERT INTO "TRADE_GNNT"."F_SUMMARY" VALUES ('15096', '订单出担保金', null, 'N', null, 'N', 'Y');
INSERT INTO "TRADE_GNNT"."F_SUMMARY" VALUES ('15097', '订单入担保金', null, 'N', null, 'N', 'Y');
INSERT INTO "TRADE_GNNT"."F_SUMMARY" VALUES ('15098', '订单返增值税', null, 'N', '1005*', 'N', 'Y');
INSERT INTO "TRADE_GNNT"."F_SUMMARY" VALUES ('15099', '订单收增值税', null, 'N', '1005*', 'N', 'Y');
INSERT INTO "TRADE_GNNT"."F_SUMMARY" VALUES ('23001', '现货收交易手续费', 'TradeFee_E', 'D', '20030123', 'N', 'Y');
INSERT INTO "TRADE_GNNT"."F_SUMMARY" VALUES ('23002', '现货收履约保证金', 'Margin_E', 'D', '200223', 'N', 'Y');
INSERT INTO "TRADE_GNNT"."F_SUMMARY" VALUES ('23003', '现货退履约保证金', 'MarginBack_E', 'C', '200223', 'N', 'Y');
INSERT INTO "TRADE_GNNT"."F_SUMMARY" VALUES ('23004', '现货收交收手续费', 'SettleFee_E', 'D', '20030223', 'N', 'Y');
INSERT INTO "TRADE_GNNT"."F_SUMMARY" VALUES ('23005', '现货收交易商货款', 'Payout_E', 'D', '200223', 'N', 'Y');
INSERT INTO "TRADE_GNNT"."F_SUMMARY" VALUES ('23006', '现货付交易商货款', 'Income_E', 'C', '200223', 'N', 'Y');
INSERT INTO "TRADE_GNNT"."F_SUMMARY" VALUES ('23010', '现货收违约金', 'OtherItem_E', 'D', '200423', 'N', 'Y');
INSERT INTO "TRADE_GNNT"."F_SUMMARY" VALUES ('23011', '现货付违约金', 'OtherItem_E', 'C', '200423', 'N', 'Y');
INSERT INTO "TRADE_GNNT"."F_SUMMARY" VALUES ('23012', '现货余额转诚信保障金', 'Subscirption_E', 'D', '200800#', 'N', 'Y');
INSERT INTO "TRADE_GNNT"."F_SUMMARY" VALUES ('23013', '现货诚信保障金转余额', 'Subscirption_E', 'C', '200800#', 'N', 'Y');
INSERT INTO "TRADE_GNNT"."F_SUMMARY" VALUES ('21001', '竞价收交易手续费', 'TradeFee_V', 'D', '20030121', 'N', 'Y');
INSERT INTO "TRADE_GNNT"."F_SUMMARY" VALUES ('21002', '竞价收交易保证金', 'Margin_V', 'D', '200221', 'N', 'Y');
INSERT INTO "TRADE_GNNT"."F_SUMMARY" VALUES ('21003', '竞价退交易保证金', 'Margin_V', 'C', '200221', 'N', 'Y');
INSERT INTO "TRADE_GNNT"."F_SUMMARY" VALUES ('21004', '竞价收交易商货款', 'Payout_V', 'D', '200221', 'N', 'Y');
INSERT INTO "TRADE_GNNT"."F_SUMMARY" VALUES ('21005', '竞价付交易商货款', 'Income_V', 'C', '200221', 'N', 'Y');
INSERT INTO "TRADE_GNNT"."F_SUMMARY" VALUES ('21016', '竞价收违约金', 'Payout_V', 'D', '200221', 'N', 'Y');
INSERT INTO "TRADE_GNNT"."F_SUMMARY" VALUES ('21017', '竞价付违约金', 'Income_V', 'C', '200221', 'N', 'Y');

-- ----------------------------
-- Indexes structure for table F_SUMMARY
-- ----------------------------

-- ----------------------------
-- Checks structure for table F_SUMMARY
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."F_SUMMARY" ADD CHECK ("SUMMARYNO" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."F_SUMMARY" ADD CHECK ("SUMMARY" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."F_SUMMARY" ADD CHECK ("FUNDDCFLAG" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."F_SUMMARY" ADD CHECK ("APPENDACCOUNT" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."F_SUMMARY" ADD CHECK ("ISINIT" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table F_SUMMARY
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."F_SUMMARY" ADD PRIMARY KEY ("SUMMARYNO");
