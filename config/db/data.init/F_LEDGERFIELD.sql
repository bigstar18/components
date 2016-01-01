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

Date: 2015-11-11 22:53:12
*/


-- ----------------------------
-- Table structure for F_LEDGERFIELD
-- ----------------------------
DROP TABLE "TRADE_GNNT"."F_LEDGERFIELD";
CREATE TABLE "TRADE_GNNT"."F_LEDGERFIELD" (
"CODE" VARCHAR2(16 BYTE) NOT NULL ,
"NAME" VARCHAR2(32 BYTE) NOT NULL ,
"FIELDSIGN" NUMBER(1) NOT NULL ,
"MODULEID" CHAR(2 BYTE) NOT NULL ,
"ORDERNUM" NUMBER(5) NOT NULL ,
"ISINIT" CHAR(1 BYTE) DEFAULT 'Y'  NOT NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON COLUMN "TRADE_GNNT"."F_LEDGERFIELD"."FIELDSIGN" IS '1：增项 -1：减项';
COMMENT ON COLUMN "TRADE_GNNT"."F_LEDGERFIELD"."MODULEID" IS '10综合管理平台
11财务系统
13仓单管理系统
14融资系统
15订单交易
18投资类大宗商品交易系统
20做市商交易系统
21竞价系统
22银行接入及结算系统
23E现货';
COMMENT ON COLUMN "TRADE_GNNT"."F_LEDGERFIELD"."ORDERNUM" IS '前两位模块号后三位排序号
';
COMMENT ON COLUMN "TRADE_GNNT"."F_LEDGERFIELD"."ISINIT" IS 'Y:是初始化数据,页面不允许删除和修改
N:不是初始化数据';

-- ----------------------------
-- Records of F_LEDGERFIELD
-- ----------------------------
INSERT INTO "TRADE_GNNT"."F_LEDGERFIELD" VALUES ('Deposit', '入金', '1', '11', '1', 'Y');
INSERT INTO "TRADE_GNNT"."F_LEDGERFIELD" VALUES ('Fetch', '出金', '-1', '11', '2', 'Y');
INSERT INTO "TRADE_GNNT"."F_LEDGERFIELD" VALUES ('BankFee', '银转手续费', '-1', '11', '3', 'Y');
INSERT INTO "TRADE_GNNT"."F_LEDGERFIELD" VALUES ('OtherItem', '当日其他项', '1', '11', '4', 'Y');
INSERT INTO "TRADE_GNNT"."F_LEDGERFIELD" VALUES ('Margin_T', '订单保证金变动', '1', '15', '15000', 'Y');
INSERT INTO "TRADE_GNNT"."F_LEDGERFIELD" VALUES ('FL_T', '订单浮亏变动', '1', '15', '15001', 'Y');
INSERT INTO "TRADE_GNNT"."F_LEDGERFIELD" VALUES ('SettleMargin_T', '订单交收保证金变动', '1', '15', '15002', 'Y');
INSERT INTO "TRADE_GNNT"."F_LEDGERFIELD" VALUES ('TradePL_T', '订单转让盈亏', '1', '15', '15003', 'Y');
INSERT INTO "TRADE_GNNT"."F_LEDGERFIELD" VALUES ('SettlePL_T', '订单交收盈亏', '1', '15', '15004', 'Y');
INSERT INTO "TRADE_GNNT"."F_LEDGERFIELD" VALUES ('Income_T', '订单销售收入', '1', '15', '15005', 'Y');
INSERT INTO "TRADE_GNNT"."F_LEDGERFIELD" VALUES ('Payout_T', '订单购货支出', '-1', '15', '15006', 'Y');
INSERT INTO "TRADE_GNNT"."F_LEDGERFIELD" VALUES ('TradeFee_T', '订单交易手续费', '-1', '15', '15007', 'Y');
INSERT INTO "TRADE_GNNT"."F_LEDGERFIELD" VALUES ('SettleFee_T', '订单交收手续费', '-1', '15', '15008', 'Y');
INSERT INTO "TRADE_GNNT"."F_LEDGERFIELD" VALUES ('SettleCompens_T', '订单交割补偿费', '1', '15', '15009', 'Y');
INSERT INTO "TRADE_GNNT"."F_LEDGERFIELD" VALUES ('OtherItem_T', '订单当日其他项', '1', '15', '15010', 'Y');
INSERT INTO "TRADE_GNNT"."F_LEDGERFIELD" VALUES ('TradeFee_E', '现货收交易手续费', '-1', '23', '23000', 'Y');
INSERT INTO "TRADE_GNNT"."F_LEDGERFIELD" VALUES ('Margin_E', '现货收交收保证金', '-1', '23', '23001', 'Y');
INSERT INTO "TRADE_GNNT"."F_LEDGERFIELD" VALUES ('MarginBack_E', '现货退交收保证金', '1', '23', '23002', 'Y');
INSERT INTO "TRADE_GNNT"."F_LEDGERFIELD" VALUES ('SettleFee_E', '现货收交收费用', '-1', '23', '23003', 'Y');
INSERT INTO "TRADE_GNNT"."F_LEDGERFIELD" VALUES ('Payout_E', '现货收交易商货款', '-1', '23', '23004', 'Y');
INSERT INTO "TRADE_GNNT"."F_LEDGERFIELD" VALUES ('Income_E', '现货付交易商货款', '1', '23', '23005', 'Y');
INSERT INTO "TRADE_GNNT"."F_LEDGERFIELD" VALUES ('Subscirption_E', '诚信保障金', '-1', '23', '23006', 'Y');
INSERT INTO "TRADE_GNNT"."F_LEDGERFIELD" VALUES ('OtherItem_E', '现货当日其他项', '1', '23', '23007', 'Y');
INSERT INTO "TRADE_GNNT"."F_LEDGERFIELD" VALUES ('Income_V', '竞价销售收入', '1', '21', '21000', 'Y');
INSERT INTO "TRADE_GNNT"."F_LEDGERFIELD" VALUES ('Payout_V', '竞价购货支出', '-1', '21', '21001', 'Y');
INSERT INTO "TRADE_GNNT"."F_LEDGERFIELD" VALUES ('TradeFee_V', '竞价交易手续费', '-1', '21', '21002', 'Y');
INSERT INTO "TRADE_GNNT"."F_LEDGERFIELD" VALUES ('Margin_V', '竞价保证金', '-1', '21', '21003', 'Y');

-- ----------------------------
-- Indexes structure for table F_LEDGERFIELD
-- ----------------------------

-- ----------------------------
-- Checks structure for table F_LEDGERFIELD
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."F_LEDGERFIELD" ADD CHECK ("CODE" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."F_LEDGERFIELD" ADD CHECK ("NAME" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."F_LEDGERFIELD" ADD CHECK ("FIELDSIGN" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."F_LEDGERFIELD" ADD CHECK ("MODULEID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."F_LEDGERFIELD" ADD CHECK ("ORDERNUM" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."F_LEDGERFIELD" ADD CHECK ("ISINIT" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table F_LEDGERFIELD
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."F_LEDGERFIELD" ADD PRIMARY KEY ("CODE");
