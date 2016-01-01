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

Date: 2015-11-17 22:45:45
*/


-- ----------------------------
-- Table structure for M_AGENTTRADER
-- ----------------------------
DROP TABLE "TRADE_GNNT"."M_AGENTTRADER";
CREATE TABLE "TRADE_GNNT"."M_AGENTTRADER" (
"AGENTTRADERID" VARCHAR2(40 BYTE) NOT NULL ,
"NAME" VARCHAR2(16 BYTE) NULL ,
"PASSWORD" VARCHAR2(64 BYTE) NOT NULL ,
"TYPE" NUMBER(2) DEFAULT 0  NOT NULL ,
"STATUS" NUMBER(2) DEFAULT 0  NOT NULL ,
"OPERATEFIRM" CLOB NULL ,
"CREATETIME" DATE DEFAULT sysdate  NULL ,
"MODIFYTIME" DATE NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON TABLE "TRADE_GNNT"."M_AGENTTRADER" IS '代为委托员表';
COMMENT ON COLUMN "TRADE_GNNT"."M_AGENTTRADER"."TYPE" IS '0 代为委托员
1 强平员';
COMMENT ON COLUMN "TRADE_GNNT"."M_AGENTTRADER"."STATUS" IS '0 正常
1 禁止登陆';
COMMENT ON COLUMN "TRADE_GNNT"."M_AGENTTRADER"."OPERATEFIRM" IS '空表示所有
否则交易商用逗号分隔，如 0001,0002,0003';
COMMENT ON COLUMN "TRADE_GNNT"."M_AGENTTRADER"."MODIFYTIME" IS '最后一次修改时间';

-- ----------------------------
-- Records of M_AGENTTRADER
-- ----------------------------
INSERT INTO "TRADE_GNNT"."M_AGENTTRADER" VALUES ('006', 'maliang', 'fe4f644183fad62a892368508685ec8c', '1', '0', '0001,0002,008,008013,10000,11111,126000000000108,22222,33333,44444,505000000000001,505000000000002,505000000000003,505000000000004,505000000000005,505000000000006,505000000000007,505000000000008,505000000000010,505000000000012,505000000000016,505000000000088,505000000000089,50500000000009,505000000000090,505000000000091,505000000000092,505000000000108,505000000000110,55555,601010001,601010002,66666,77777,88888,99999,gnnt01,gnnt02,gnnt03,gnnt04,test1,000100001,000200001,000200002,000200003,000200004,000200005,000200006,00021034,000210341,00030101,000301011,000301012,000301013,002000001,002000002,002000003,020000001,101000005000579,112,444,505000000000105,5050000000333,50500000100,601002022,606,606000001,60600000100,60600000110,60600000111,60600000180,606000002,606000008,606000009,606000011,606000012,606000013,606000014,606000015,606000016,606000017,606000018,606000019,606000020,606000021,606000022,606010000,606010001,606010002,606010003,606010004,606010005,606010006,606010007,606010008,606010009,606010010,606010012,606010013,606010014,606010015,607,607000001,607000002,607000003,607000004,607000005,607000006,607000007,607000008,607000009,607000010,607000011,607010001,607010002,607020001,607020002,608000123,608000333,609000000,618000000,622000000,HMR01,HMR02,Shimo001,Shimo002,Shimo003,Shimo004,Shimo005,ceshi1,gnnt01001,gnnt01002,gnnt021,gnnt022,gnnt023,gnnt05,gnnt06,gnnt07,gnnt08,gnnt09,gnnt09001,gnnt09002,gnnt09003,gnnt09004,gnnt09005,gnnt09006,gnnt09007,gnnt09008,gnnt09009,gnnt10,gnnt11,gnnt12,gnnt12001,gnnt65432,gnnt98765,h1,h2,hy001,hyl,jsb002,jsb003,test66,xh002,xh003,xh004,xh005,xh006,xh007,xh009,xh010,xh011,xh012,xh013,xh014,xh015', TO_DATE('2015-01-23 15:44:18', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-09-02 14:45:55', 'YYYY-MM-DD HH24:MI:SS'));

-- ----------------------------
-- Table structure for M_BREED
-- ----------------------------
DROP TABLE "TRADE_GNNT"."M_BREED";
CREATE TABLE "TRADE_GNNT"."M_BREED" (
"BREEDID" NUMBER(10) NOT NULL ,
"BREEDNAME" VARCHAR2(32 BYTE) NOT NULL ,
"UNIT" VARCHAR2(16 BYTE) NOT NULL ,
"TRADEMODE" NUMBER(1) DEFAULT 1  NOT NULL ,
"CATEGORYID" NUMBER(10) NOT NULL ,
"STATUS" NUMBER(1) DEFAULT 1  NULL ,
"PICTURE" BLOB NULL ,
"BELONGMODULE" VARCHAR2(30 BYTE) NULL ,
"SORTNO" NUMBER(10) NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON COLUMN "TRADE_GNNT"."M_BREED"."TRADEMODE" IS '交易模式 1：诚信保障金模式 2：保证金模式';
COMMENT ON COLUMN "TRADE_GNNT"."M_BREED"."STATUS" IS '1：正常 2：已删除';
COMMENT ON COLUMN "TRADE_GNNT"."M_BREED"."BELONGMODULE" IS '分类所属模块 以|分割';

-- ----------------------------
-- Records of M_BREED
-- ----------------------------
INSERT INTO "TRADE_GNNT"."M_BREED" VALUES ('1281', '建国60年大庆', '张', '1', '1140', '1', null, '15|21|23', '1002');
INSERT INTO "TRADE_GNNT"."M_BREED" VALUES ('1301', '钛', '吨', '1', '1002', '1', null, '15|21|23', '5');
INSERT INTO "TRADE_GNNT"."M_BREED" VALUES ('1140', '棉布', '批', '1', '1041', '1', null, '15|21|23', '1');
INSERT INTO "TRADE_GNNT"."M_BREED" VALUES ('1200', '莫干黄芽', '500克', '1', '1005', '1', null, '15|21|23', '1200');
INSERT INTO "TRADE_GNNT"."M_BREED" VALUES ('1001', '热轧卷', '吨', '1', '1001', '2', null, '15', '2');
INSERT INTO "TRADE_GNNT"."M_BREED" VALUES ('1003', '螺纹钢1504', '吨', '1', '1001', '2', null, '15', '4');
INSERT INTO "TRADE_GNNT"."M_BREED" VALUES ('1004', '螺纹钢1505', '吨', '1', '1001', '2', null, null, '5');
INSERT INTO "TRADE_GNNT"."M_BREED" VALUES ('1005', '螺纹钢1506', '吨', '1', '1001', '2', null, '15', '6');
INSERT INTO "TRADE_GNNT"."M_BREED" VALUES ('1007', '螺纹钢1508', '吨', '1', '1001', '2', null, '15', '8');
INSERT INTO "TRADE_GNNT"."M_BREED" VALUES ('1013', '铝', '吨', '1', '1002', '1', null, '15', '2');
INSERT INTO "TRADE_GNNT"."M_BREED" VALUES ('1014', '镍', '吨', '1', '1002', '1', null, '15', '3');
INSERT INTO "TRADE_GNNT"."M_BREED" VALUES ('1018', '贵金属', '克', '1', '1002', '2', null, '15', '5');
INSERT INTO "TRADE_GNNT"."M_BREED" VALUES ('1040', '山药', '批', '1', '1005', '1', null, '15|21|23', '1022');
INSERT INTO "TRADE_GNNT"."M_BREED" VALUES ('1141', '新疆棉花', '吨', '1', '1042', '1', null, '15|23', '1');
INSERT INTO "TRADE_GNNT"."M_BREED" VALUES ('1142', '涤纶化纤', '吨', '1', '1043', '1', null, '15|21|23', '2');
INSERT INTO "TRADE_GNNT"."M_BREED" VALUES ('1002', '螺纹钢1503', '吨', '1', '1001', '2', null, '15', '3');
INSERT INTO "TRADE_GNNT"."M_BREED" VALUES ('1006', '螺纹钢1507', '吨', '1', '1001', '2', null, '15', '7');
INSERT INTO "TRADE_GNNT"."M_BREED" VALUES ('1008', '螺纹钢1509', '手', '1', '1001', '2', null, '15', '9');
INSERT INTO "TRADE_GNNT"."M_BREED" VALUES ('1009', '螺纹钢1510', '吨', '1', '1001', '2', null, '15', '10');
INSERT INTO "TRADE_GNNT"."M_BREED" VALUES ('1010', '螺纹钢1511', '吨', '1', '1001', '2', null, '15', '11');
INSERT INTO "TRADE_GNNT"."M_BREED" VALUES ('1011', '螺纹钢1512', '吨', '1', '1001', '2', null, '15', '12');
INSERT INTO "TRADE_GNNT"."M_BREED" VALUES ('1012', '阴极铜', '吨', '1', '1002', '1', null, '15', '1');
INSERT INTO "TRADE_GNNT"."M_BREED" VALUES ('1015', '铅', '吨', '1', '1002', '1', null, '15', '4');
INSERT INTO "TRADE_GNNT"."M_BREED" VALUES ('1016', '热轧卷1505', '吨', '1', '1002', '2', null, '15', '5');
INSERT INTO "TRADE_GNNT"."M_BREED" VALUES ('1017', '热轧卷1506', '吨', '1', '1002', '2', null, '15', '6');
INSERT INTO "TRADE_GNNT"."M_BREED" VALUES ('1080', '香菇', '公斤', '1', '1005', '2', null, '15', '1050');
INSERT INTO "TRADE_GNNT"."M_BREED" VALUES ('1160', '黑木耳', '公斤', '1', '1005', '1', null, '15|21|23', '1110');
INSERT INTO "TRADE_GNNT"."M_BREED" VALUES ('1180', '橡木地板', '平方米', '1', '1060', '1', null, '15', '1022');
INSERT INTO "TRADE_GNNT"."M_BREED" VALUES ('1220', '金克拉', '克拉', '1', '1081', '2', null, '15', '1');
INSERT INTO "TRADE_GNNT"."M_BREED" VALUES ('1020', '白银', '克', '1', '1004', '1', null, '15', '2');
INSERT INTO "TRADE_GNNT"."M_BREED" VALUES ('1021', '铂金', '克', '1', '1004', '1', null, '15', '3');
INSERT INTO "TRADE_GNNT"."M_BREED" VALUES ('1041', '白砂糖', '吨', '1', '1005', '1', null, '15', '1023');
INSERT INTO "TRADE_GNNT"."M_BREED" VALUES ('1042', '动力煤', '吨', '1', '1008', '1', null, '15|21|23', '1024');
INSERT INTO "TRADE_GNNT"."M_BREED" VALUES ('1100', '绿茶（日照）', '500克', '1', '1005', '1', null, '15|21', '1070');
INSERT INTO "TRADE_GNNT"."M_BREED" VALUES ('1221', '铂金', '克拉', '1', '1081', '2', null, '15', '2');
INSERT INTO "TRADE_GNNT"."M_BREED" VALUES ('1000', '螺纹钢', '吨', '1', '1001', '1', null, '15', '1');
INSERT INTO "TRADE_GNNT"."M_BREED" VALUES ('1019', '黄金', '克', '1', '1004', '1', null, '15|21', '1');
INSERT INTO "TRADE_GNNT"."M_BREED" VALUES ('1060', '怀山药', '公斤', '1', '1005', '1', null, '15|21', '1043');
INSERT INTO "TRADE_GNNT"."M_BREED" VALUES ('1120', '石墨', '0.1吨', '1', '1008', '1', null, '15|21|23', '1080');
INSERT INTO "TRADE_GNNT"."M_BREED" VALUES ('1143', '高级竹炭', '千克', '1', '1044', '1', null, '15|21|23', '2');
INSERT INTO "TRADE_GNNT"."M_BREED" VALUES ('1240', '钻石', '克拉', '1', '1100', '1', null, '15|21|23', '1');
INSERT INTO "TRADE_GNNT"."M_BREED" VALUES ('1300', '无纺布', '批', '1', '1041', '1', null, '15|21|23', '2');
INSERT INTO "TRADE_GNNT"."M_BREED" VALUES ('1280', '80猴票', '张', '1', '1140', '1', null, '15|21|23', '1001');

-- ----------------------------
-- Table structure for M_BREEDPROPS
-- ----------------------------
DROP TABLE "TRADE_GNNT"."M_BREEDPROPS";
CREATE TABLE "TRADE_GNNT"."M_BREEDPROPS" (
"BREEDID" NUMBER(10) NOT NULL ,
"PROPERTYID" NUMBER(10) NOT NULL ,
"PROPERTYVALUE" VARCHAR2(64 BYTE) NOT NULL ,
"SORTNO" NUMBER(10) NOT NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON TABLE "TRADE_GNNT"."M_BREEDPROPS" IS '品名对应的属性值列表，有哪些属性来自商品分类属性表
';

-- ----------------------------
-- Records of M_BREEDPROPS
-- ----------------------------
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1300', '1061', '优', '1');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1280', '1160', '优', '1');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1140', '1060', '浙江', '2');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1140', '1061', '等级二', '2');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1143', '1070', '高级品', '1');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1143', '1070', '合格品', '2');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1120', '1080', 'GB/T3158-2008鳞片石墨-195', '1');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1200', '1005', '德清', '1');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1000', '1004', '1', '5');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1000', '1002', '很好', '4');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1120', '1041', '汇元', '1110');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1060', '1006', '怀字认证', '2');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1120', '1040', '鸡西', '1100');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1140', '1060', '江苏', '1');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1140', '1061', '等级一', '1');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1142', '1067', '金牌', '1');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1142', '1066', '二等品', '2');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1141', '1062', '新疆阿克苏', '1');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1141', '1064', '一等品', '1');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1141', '1064', '二等品', '2');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1141', '1063', '黄河', '2');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1143', '1068', '无锡', '1');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1143', '1068', '上海', '2');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1042', '1040', '贵州', '1');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1042', '1081', '汽运自提', '1');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1042', '1080', '一级品', '1');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1042', '1081', '码头交收', '2');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1042', '1040', '内蒙古', '2');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1042', '1080', '二级品', '2');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1042', '1041', '长商所', '1');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1120', '1081', '公路运输', '1');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1120', '1081', '铁路运输', '2');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1120', '1081', '轮船运输', '3');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1160', '1006', '森华源', '1');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1180', '1102', '910*127*15', '1');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1142', '1067', '银牌', '2');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1142', '1066', '一等品', '1');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1160', '1005', '绥棱县', '1');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1180', '1101', '唐部人', '1');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1100', '1006', '品岳茗茶', '1');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1142', '1065', '苏州', '3');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1000', '1001', '山东', '1');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1000', '1001', '江苏', '2');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1000', '1002', '16mm', '1');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1000', '1002', '25mm', '3');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1000', '1003', '黑色', '1');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1000', '1003', '白色', '2');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1000', '1004', '1MP', '1');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1040', '1005', '山东', '1');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1040', '1005', '河南', '2');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1040', '1005', '山西', '3');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1041', '1006', '明阳', '1');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1060', '1005', '焦作', '1');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1143', '1069', '老王', '1');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1000', '1003', '黄', '3');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1000', '1001', '浙江', '3');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1000', '1002', '20mm', '2');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1000', '1004', '1.5MP', '2');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1041', '1006', '白莲', '2');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1041', '1005', '南宁', '1');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1041', '1005', '东莞', '2');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1019', '1020', '1', '1');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1100', '1005', '日照', '1');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1142', '1065', '无锡', '1');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1142', '1065', '上海', '2');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1141', '1062', '新疆伊犁', '2');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1141', '1063', '长江', '1');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1200', '1006', '莫干芯', '1');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1000', '1003', '彩色', '4');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1280', '1160', '良', '2');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1281', '1160', '优', '1');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1281', '1160', '良', '2');
INSERT INTO "TRADE_GNNT"."M_BREEDPROPS" VALUES ('1300', '1060', '湖北仙桃', '1');

-- ----------------------------
-- Table structure for M_CATEGORY
-- ----------------------------
DROP TABLE "TRADE_GNNT"."M_CATEGORY";
CREATE TABLE "TRADE_GNNT"."M_CATEGORY" (
"CATEGORYID" NUMBER(10) NOT NULL ,
"CATEGORYNAME" VARCHAR2(64 BYTE) NOT NULL ,
"NOTE" VARCHAR2(256 BYTE) NULL ,
"TYPE" VARCHAR2(64 BYTE) NOT NULL ,
"SORTNO" NUMBER(10) NOT NULL ,
"PARENTCATEGORYID" NUMBER(10) NULL ,
"STATUS" NUMBER(1) DEFAULT 1  NULL ,
"ISOFFSET" CHAR(1 BYTE) DEFAULT 'Y'  NOT NULL ,
"OFFSETRATE" NUMBER(5,4) DEFAULT 0.05  NOT NULL ,
"BELONGMODULE" VARCHAR2(30 BYTE) NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON COLUMN "TRADE_GNNT"."M_CATEGORY"."TYPE" IS 'breed：品种
category：分类
leaf：叶子节点';
COMMENT ON COLUMN "TRADE_GNNT"."M_CATEGORY"."STATUS" IS '1：正常 2：已删除';
COMMENT ON COLUMN "TRADE_GNNT"."M_CATEGORY"."ISOFFSET" IS 'Y:此品种可能出现损溢 N:此品种不可能出现损溢';
COMMENT ON COLUMN "TRADE_GNNT"."M_CATEGORY"."OFFSETRATE" IS '申请损益万分比<1';
COMMENT ON COLUMN "TRADE_GNNT"."M_CATEGORY"."BELONGMODULE" IS '分类所属模块 以|分割';

-- ----------------------------
-- Records of M_CATEGORY
-- ----------------------------
INSERT INTO "TRADE_GNNT"."M_CATEGORY" VALUES ('1140', '邮票', 'YYY邮票', 'leaf', '100', '-1', '1', 'N', '0', '15|21|23');
INSERT INTO "TRADE_GNNT"."M_CATEGORY" VALUES ('1160', '化肥', null, 'category', '233', '-1', '1', 'N', '0', '15|21');
INSERT INTO "TRADE_GNNT"."M_CATEGORY" VALUES ('1161', '金坷垃', '好处都有啥，谁说对了就给他', 'leaf', '666', '1160', '1', 'N', '0', null);
INSERT INTO "TRADE_GNNT"."M_CATEGORY" VALUES ('1100', '无色金属', null, 'leaf', '9', '-1', '1', 'N', '0', '15|21|23');
INSERT INTO "TRADE_GNNT"."M_CATEGORY" VALUES ('-1', '长商所商品', '黑色金属，例如，螺纹钢，热轧卷等。有色金属，例如，铜，锌，铝，镍，铅等。', 'category', '1', null, '1', 'Y', '0.05', null);
INSERT INTO "TRADE_GNNT"."M_CATEGORY" VALUES ('1001', '黑色金属', '螺纹钢，热轧卷', 'leaf', '1', '-1', '1', 'Y', '0.30', '15');
INSERT INTO "TRADE_GNNT"."M_CATEGORY" VALUES ('1004', '贵金属', null, 'leaf', '3', '-1', '1', 'N', '0', '15|21');
INSERT INTO "TRADE_GNNT"."M_CATEGORY" VALUES ('1005', '农产品', '山药，白砂糖  怀山药,绿茶，黑木耳', 'leaf', '4', '-1', '1', 'N', '0', '15|21|23');
INSERT INTO "TRADE_GNNT"."M_CATEGORY" VALUES ('1006', '软商品', null, 'leaf', '5', '-1', '1', 'N', '0', '15');
INSERT INTO "TRADE_GNNT"."M_CATEGORY" VALUES ('1007', '化工产品', null, 'leaf', '6', '-1', '1', 'N', '0', '15|21|23');
INSERT INTO "TRADE_GNNT"."M_CATEGORY" VALUES ('1009', '铁矿石', null, 'leaf', '1', '1008', '2', 'N', '0', '15');
INSERT INTO "TRADE_GNNT"."M_CATEGORY" VALUES ('1010', '原油', null, 'leaf', '2', '1008', '2', 'N', '0', '15');
INSERT INTO "TRADE_GNNT"."M_CATEGORY" VALUES ('1040', '纺织原料', null, 'category', '1009', '-1', '1', 'Y', '0.10', '15|21|23');
INSERT INTO "TRADE_GNNT"."M_CATEGORY" VALUES ('1041', '棉原料', null, 'leaf', '1', '1040', '1', 'Y', '0.10', '15|21|23');
INSERT INTO "TRADE_GNNT"."M_CATEGORY" VALUES ('1043', '化纤', '化纤', 'leaf', '3', '1040', '1', 'Y', '0.15', '15|21|23');
INSERT INTO "TRADE_GNNT"."M_CATEGORY" VALUES ('1044', '竹炭纤维', null, 'leaf', '4', '1040', '1', 'Y', '0.20', '15|21|23');
INSERT INTO "TRADE_GNNT"."M_CATEGORY" VALUES ('1060', '建材', '橡木地板', 'leaf', '8', '-1', '1', 'N', '0', '15');
INSERT INTO "TRADE_GNNT"."M_CATEGORY" VALUES ('1008', '工业原料', '动力煤， 原油，石墨', 'leaf', '7', '-1', '1', 'N', '0', '15|21|23');
INSERT INTO "TRADE_GNNT"."M_CATEGORY" VALUES ('1015', '乙二醇', null, 'leaf', '5', '1007', '2', 'N', '0', '15');
INSERT INTO "TRADE_GNNT"."M_CATEGORY" VALUES ('1016', '草酸', null, 'leaf', '6', '1007', '2', 'N', '0', '15');
INSERT INTO "TRADE_GNNT"."M_CATEGORY" VALUES ('1018', '棉花', null, 'leaf', '2', '1006', '2', 'N', '0', '15');
INSERT INTO "TRADE_GNNT"."M_CATEGORY" VALUES ('1019', '橡胶', null, 'leaf', '3', '1006', '2', 'N', '0', '15');
INSERT INTO "TRADE_GNNT"."M_CATEGORY" VALUES ('1020', '大豆', null, 'leaf', '1', '1005', '2', 'N', '0', '15');
INSERT INTO "TRADE_GNNT"."M_CATEGORY" VALUES ('1021', '玉米', null, 'leaf', '2', '1005', '2', 'N', '0', '15');
INSERT INTO "TRADE_GNNT"."M_CATEGORY" VALUES ('1023', '籼稻', null, 'leaf', '4', '1005', '2', 'N', '0', '15');
INSERT INTO "TRADE_GNNT"."M_CATEGORY" VALUES ('1027', '棕榈油', null, 'leaf', '9', '1005', '2', 'N', '0', '15');
INSERT INTO "TRADE_GNNT"."M_CATEGORY" VALUES ('1029', '白银', null, 'leaf', '2', '1004', '2', 'N', '0', '15');
INSERT INTO "TRADE_GNNT"."M_CATEGORY" VALUES ('1030', '铂金', null, 'leaf', '3', '1004', '2', 'N', '0', '15');
INSERT INTO "TRADE_GNNT"."M_CATEGORY" VALUES ('1031', '黄金', null, 'leaf', '1', '1004', '2', 'N', '0', '15');
INSERT INTO "TRADE_GNNT"."M_CATEGORY" VALUES ('1080', '无色金属', null, 'leaf', '11', '-1', '2', 'N', '0', '15|23');
INSERT INTO "TRADE_GNNT"."M_CATEGORY" VALUES ('1081', '钻石', null, 'leaf', '1', '1080', '2', 'Y', '0.30', '15');
INSERT INTO "TRADE_GNNT"."M_CATEGORY" VALUES ('1000', '苍井空11', null, 'leaf', '11', '-1', '2', 'Y', '0.30', '15');
INSERT INTO "TRADE_GNNT"."M_CATEGORY" VALUES ('1002', '有色金属', '铜，铝，锌，镍，铅', 'leaf', '2', '-1', '1', 'N', '0', '15|21|23');
INSERT INTO "TRADE_GNNT"."M_CATEGORY" VALUES ('1003', '苍井空03', null, 'leaf', '3', '-1', '2', 'N', '0', null);
INSERT INTO "TRADE_GNNT"."M_CATEGORY" VALUES ('1011', 'PTA', null, 'leaf', '1', '1007', '2', 'N', '0', '15');
INSERT INTO "TRADE_GNNT"."M_CATEGORY" VALUES ('1012', 'S塑料', null, 'leaf', '2', '1007', '2', 'N', '0', '15');
INSERT INTO "TRADE_GNNT"."M_CATEGORY" VALUES ('1013', '聚丙烯', null, 'leaf', '3', '1007', '2', 'N', '0', '15');
INSERT INTO "TRADE_GNNT"."M_CATEGORY" VALUES ('1014', '聚氯乙烯', null, 'leaf', '4', '1007', '2', 'N', '0', '15');
INSERT INTO "TRADE_GNNT"."M_CATEGORY" VALUES ('1017', '白糖', null, 'leaf', '1', '1006', '2', 'N', '0', '15');
INSERT INTO "TRADE_GNNT"."M_CATEGORY" VALUES ('1022', '小麦', null, 'leaf', '3', '1005', '2', 'N', '0', '15');
INSERT INTO "TRADE_GNNT"."M_CATEGORY" VALUES ('1024', '豆粕', null, 'leaf', '5', '1005', '2', 'N', '0', '15');
INSERT INTO "TRADE_GNNT"."M_CATEGORY" VALUES ('1025', '豆油', null, 'leaf', '7', '1005', '2', 'N', '0', '15');
INSERT INTO "TRADE_GNNT"."M_CATEGORY" VALUES ('1026', '菜油', null, 'leaf', '8', '1005', '2', 'N', '0', '15');
INSERT INTO "TRADE_GNNT"."M_CATEGORY" VALUES ('1028', '黄金', null, 'leaf', '1', '1004', '2', 'N', '0', '15');
INSERT INTO "TRADE_GNNT"."M_CATEGORY" VALUES ('1032', '白银', null, 'leaf', '2', '1004', '2', 'N', '0', '15');
INSERT INTO "TRADE_GNNT"."M_CATEGORY" VALUES ('1042', '棉花', '棉花', 'leaf', '2', '1040', '1', 'Y', '0.20', '15|21|23');
INSERT INTO "TRADE_GNNT"."M_CATEGORY" VALUES ('1180', '哈哈', null, 'leaf', '10', '-1', '1', 'N', '0', '15');

-- ----------------------------
-- Table structure for M_CERTIFICATETYPE
-- ----------------------------
DROP TABLE "TRADE_GNNT"."M_CERTIFICATETYPE";
CREATE TABLE "TRADE_GNNT"."M_CERTIFICATETYPE" (
"CODE" NUMBER(2) NOT NULL ,
"NAME" VARCHAR2(32 BYTE) NOT NULL ,
"ISVISIBAL" CHAR(1 BYTE) DEFAULT 'Y'  NOT NULL ,
"SORTNO" NUMBER(2) DEFAULT 0  NOT NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON COLUMN "TRADE_GNNT"."M_CERTIFICATETYPE"."ISVISIBAL" IS 'Y 显示 N 不显示';

-- ----------------------------
-- Records of M_CERTIFICATETYPE
-- ----------------------------
INSERT INTO "TRADE_GNNT"."M_CERTIFICATETYPE" VALUES ('1', '居民身份证', 'Y', '1');
INSERT INTO "TRADE_GNNT"."M_CERTIFICATETYPE" VALUES ('2', '士官证', 'Y', '2');
INSERT INTO "TRADE_GNNT"."M_CERTIFICATETYPE" VALUES ('3', '学生证', 'N', '3');
INSERT INTO "TRADE_GNNT"."M_CERTIFICATETYPE" VALUES ('4', '驾驶证', 'Y', '4');
INSERT INTO "TRADE_GNNT"."M_CERTIFICATETYPE" VALUES ('5', '护照', 'Y', '5');
INSERT INTO "TRADE_GNNT"."M_CERTIFICATETYPE" VALUES ('6', '港澳通行证', 'Y', '6');

-- ----------------------------
-- Table structure for M_ERRORLOGINLOG
-- ----------------------------
DROP TABLE "TRADE_GNNT"."M_ERRORLOGINLOG";
CREATE TABLE "TRADE_GNNT"."M_ERRORLOGINLOG" (
"TRADERID" VARCHAR2(40 BYTE) NOT NULL ,
"LOGINDATE" DATE NOT NULL ,
"MODULEID" NUMBER(2) NOT NULL ,
"IP" VARCHAR2(32 BYTE) NOT NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON COLUMN "TRADE_GNNT"."M_ERRORLOGINLOG"."MODULEID" IS '10综合管理平台
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

-- ----------------------------
-- Records of M_ERRORLOGINLOG
-- ----------------------------
INSERT INTO "TRADE_GNNT"."M_ERRORLOGINLOG" VALUES ('6', TO_DATE('2015-11-16 20:31:54', 'YYYY-MM-DD HH24:MI:SS'), '10', '10.0.100.254');

-- ----------------------------
-- Table structure for M_FIRM
-- ----------------------------
DROP TABLE "TRADE_GNNT"."M_FIRM";
CREATE TABLE "TRADE_GNNT"."M_FIRM" (
"FIRMID" VARCHAR2(32 BYTE) NOT NULL ,
"NAME" VARCHAR2(32 BYTE) NOT NULL ,
"FULLNAME" VARCHAR2(128 BYTE) NULL ,
"TYPE" NUMBER(2) NOT NULL ,
"CONTACTMAN" VARCHAR2(32 BYTE) NOT NULL ,
"CERTIFICATETYPE" NUMBER(2) NOT NULL ,
"CERTIFICATENO" VARCHAR2(32 BYTE) NOT NULL ,
"PHONE" VARCHAR2(32 BYTE) NULL ,
"MOBILE" NUMBER(12) NOT NULL ,
"FAX" VARCHAR2(16 BYTE) NULL ,
"ADDRESS" VARCHAR2(128 BYTE) NULL ,
"POSTCODE" VARCHAR2(16 BYTE) NULL ,
"EMAIL" VARCHAR2(64 BYTE) NULL ,
"ZONECODE" VARCHAR2(16 BYTE) DEFAULT 'none'  NULL ,
"INDUSTRYCODE" VARCHAR2(16 BYTE) DEFAULT 'none'  NULL ,
"FIRMCATEGORYID" NUMBER(10) DEFAULT -1  NOT NULL ,
"ORGANIZATIONCODE" VARCHAR2(9 BYTE) NULL ,
"CORPORATEREPRESENTATIVE" VARCHAR2(32 BYTE) NULL ,
"NOTE" VARCHAR2(1024 BYTE) NULL ,
"EXTENDDATA" VARCHAR2(4000 BYTE) NULL ,
"CREATETIME" DATE DEFAULT sysdate  NOT NULL ,
"MODIFYTIME" DATE NULL ,
"STATUS" CHAR(1 BYTE) DEFAULT 'N'  NOT NULL ,
"APPLYID" NUMBER(10) NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON COLUMN "TRADE_GNNT"."M_FIRM"."TYPE" IS '1：法人
2：代理
3：个人';
COMMENT ON COLUMN "TRADE_GNNT"."M_FIRM"."FIRMCATEGORYID" IS '-1 表示未分类';
COMMENT ON COLUMN "TRADE_GNNT"."M_FIRM"."STATUS" IS 'N：正常 Normal
D：冻结 Disable
E：注销 Erase';

-- ----------------------------
-- Records of M_FIRM
-- ----------------------------
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('xh014', '朱睿', '朱睿', '3', '朱睿', '1', '123123123123123123', null, '15852767880', null, '无锡市滨湖区高浪路999号', null, '623304545@qq.com', 'WX', 'CYY', '-1', null, null, null, null, TO_DATE('2015-07-03 09:39:43', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-03 10:18:13', 'YYYY-MM-DD HH24:MI:SS'), 'N', '185');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('jsb002', 'jsb002', 'jsb002', '3', 'jsb002', '1', '430421198809148066', null, '13093656809', null, 'wuxi', null, 'abc@123.com', null, null, '-1', null, null, null, null, TO_DATE('2015-07-03 13:15:34', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-03 13:15:34', 'YYYY-MM-DD HH24:MI:SS'), 'N', '184');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('jsb003', 'jsb003', 'jsb003', '3', 'jsb003', '1', '430421198909158077', null, '13000000000', null, 'wuxi', null, 'wuxi@123.com', null, null, '-1', null, null, null, null, TO_DATE('2015-07-03 14:59:14', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-03 14:59:14', 'YYYY-MM-DD HH24:MI:SS'), 'N', '190');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('607000008', '姚东琴', '姚东琴', '3', '王颖', '1', '320581198812124521', null, '13814883567', null, '常熟兴港路', null, '149738965@qq.com', 'JS', 'CYY', '-1', null, null, null, null, TO_DATE('2015-07-22 10:00:07', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-22 10:00:07', 'YYYY-MM-DD HH24:MI:SS'), 'N', '281');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('607000009', '123456789', '123456789', '1', '123456789', '1', '430421198809148066', null, '13093056806', null, 'wuxi', null, 'abc@123.com', null, null, '-1', '123456', '123456789', null, null, TO_DATE('2015-08-03 15:10:42', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-08-03 15:10:42', 'YYYY-MM-DD HH24:MI:SS'), 'N', '321');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('000200007', '东方', '个', '3', '11111111111', '1', '345433333333333333', null, '13245678900', null, '耳闻耳闻 ', null, 'sfwref@qq.com', 'JSNJ', 'JR', '-1', null, null, null, null, TO_DATE('2015-09-10 21:29:55', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-09-10 21:29:55', 'YYYY-MM-DD HH24:MI:SS'), 'D', '461');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('666', 'f', 'gb', '3', 'gb', '1', '333333333333333333', null, '13222222222', null, 's', null, 'eefew@qq.com', null, null, '41', null, null, null, null, TO_DATE('2015-09-10 21:47:14', 'YYYY-MM-DD HH24:MI:SS'), null, 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('PG001', 'PG001', null, '3', 'PG001', '1', '123456123412341234', null, '15002795556', null, '广东省广州市', null, '123456@qq.com', null, null, '1', null, null, null, null, TO_DATE('2015-09-11 12:51:11', 'YYYY-MM-DD HH24:MI:SS'), null, 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('182', '金网-张天骥', null, '3', '张天骥', '1', '510102199302311024', null, '18200390958', null, '123', null, '123@qq.com', null, null, '1', null, null, null, null, TO_DATE('2015-09-15 14:02:08', 'YYYY-MM-DD HH24:MI:SS'), null, 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('YXG', 'CCCC', 'FFFF', '3', 'yxg', '1', '320102200010101221', null, '13344445555', null, 'sdfsfsd', null, 'y@yy.com', null, null, '1', null, null, null, null, TO_DATE('2015-10-10 13:59:40', 'YYYY-MM-DD HH24:MI:SS'), null, 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('606000028', '呵呵', '呵呵', '3', '呵呵', '1', '528954123685471200', null, '13905723422', null, '浙江', null, '12495010@qq.com', 'WX', 'JR', '-1', null, null, null, null, TO_DATE('2015-10-12 11:11:35', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-10-12 11:11:35', 'YYYY-MM-DD HH24:MI:SS'), 'N', '605');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('607000030', '马维维', '马维维', '3', '马维维', '1', '430421195509228066', null, '15861467598', null, '无锡滨湖区高浪路999号', null, 'abc@123.com', null, null, '-1', null, null, null, null, TO_DATE('2015-10-12 13:43:17', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-10-12 14:07:54', 'YYYY-MM-DD HH24:MI:SS'), 'N', '607');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('606000034', '咕咕', '咕咕', '3', '咕咕', '1', '234567887957487344', null, '13905723422', null, '浙江', null, '12495010@qq.com', 'WX', 'JR', '-1', null, null, null, null, TO_DATE('2015-10-12 14:08:45', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-10-12 14:08:45', 'YYYY-MM-DD HH24:MI:SS'), 'N', '612');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('505000000000006', '孙艳', '孙艳', '3', '孙艳', '1', '32000000088888', null, '13771130125', null, '高浪路999', null, '2850821289@qq.com', null, null, '1', null, null, null, null, TO_DATE('2014-12-12 11:05:13', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-03-25 10:23:06', 'YYYY-MM-DD HH24:MI:SS'), 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('505000000000003', '周佳丽', '周佳丽', '3', '周佳丽', '1', '3205556566564564', null, '15161678447', null, '高浪路99999', null, '760715191@qq.com', null, null, '1', null, null, null, null, TO_DATE('2014-12-12 12:51:11', 'YYYY-MM-DD HH24:MI:SS'), null, 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('505000000000012', '王尚博', '王尚博', '3', '王尚博', '1', '676876876876', null, '13342263239', null, '高浪东路999', null, '370473603@qq.com', null, null, '1', null, null, null, null, TO_DATE('2014-12-25 11:20:39', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-12-25 11:30:33', 'YYYY-MM-DD HH24:MI:SS'), 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('505000000000016', '王尚博', '王尚博', '3', '王尚博', '1', '4545645646546', null, '13342263239', null, '高浪东路999', null, '56125156156@qq.com', null, null, '1', null, null, null, null, TO_DATE('2014-12-25 11:33:05', 'YYYY-MM-DD HH24:MI:SS'), null, 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('11111', '哈哈哈', null, '3', '哈哈', '1', '8949848949498', null, '15236536587', null, '后哈哈哈哈哈哈', null, '15456156@qq.com', null, null, '1', null, null, null, null, TO_DATE('2015-01-20 11:11:05', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-03-25 10:24:21', 'YYYY-MM-DD HH24:MI:SS'), 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('0001', '机构1', '机构1', '1', '11', '1', '32000000000021', null, '15978452400', null, '123', null, '125@yrdce.com', 'WX', null, '1', '123456587', null, null, null, TO_DATE('2015-01-20 12:18:05', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-03-26 10:46:12', 'YYYY-MM-DD HH24:MI:SS'), 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('0002', '机构2', '机构2', '1', '22', '1', '654987456321456', null, '13856987412', null, '123321', null, '123@yrdce.com', 'WX', 'CYY', '2', '158794563', null, null, null, TO_DATE('2015-01-20 12:19:29', 'YYYY-MM-DD HH24:MI:SS'), null, 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('5050000000333', 'creamyc', null, '3', 'creamyc', '1', '32020513330322', null, '13305103333', null, '高浪路', null, 'creamyc@qq.com', null, null, '1', null, null, null, null, TO_DATE('2015-03-13 09:10:51', 'YYYY-MM-DD HH24:MI:SS'), null, 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('xh011', '罗宇灏', null, '3', 'xh011', '1', '320481199107121810', null, '15951261782', null, '长三角商品交易所有限公司', null, '1453212515@qq.com', null, null, '1', null, null, null, null, TO_DATE('2015-04-20 11:06:49', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-03 10:10:05', 'YYYY-MM-DD HH24:MI:SS'), 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('hyl', '胡玉龙', '胡玉龙', '3', '胡玉龙', '1', '320283198811270374', null, '13861852982', null, '无锡', null, 'huyl@yrdce.com', 'WX', 'FDC', '-1', null, null, null, null, TO_DATE('2015-06-08 10:32:05', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-06-08 10:32:05', 'YYYY-MM-DD HH24:MI:SS'), 'N', '105');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('606010007', 'dsaf', 'dsafdsa', '3', 'ffdsa', '1', '963258741123659874', null, '18900129774', null, 'safdasfdsa', null, 'sda@sina.cn', 'JS', 'CYY', '-1', null, null, null, null, TO_DATE('2015-06-15 16:01:28', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-06-15 16:01:28', 'YYYY-MM-DD HH24:MI:SS'), 'N', '148');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('000200004', '王欢', '王欢', '3', '王欢', '1', '342523199011288218', null, '18656396023', null, '安徽省广德县桃州镇和平村港东7号', null, '416746071@qq.com', 'WX', null, '-1', null, null, null, null, TO_DATE('2015-07-02 10:56:53', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-02 10:56:53', 'YYYY-MM-DD HH24:MI:SS'), 'N', '166');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('xh015', '吴张彬', '吴张彬', '3', '吴张彬', '1', '123456789123456789', null, '13735102222', null, '无锡市滨湖区高浪路999号', null, '478404225@qq.com', 'WX', 'CYY', '-1', null, null, null, null, TO_DATE('2015-07-03 09:39:24', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-03 09:39:24', 'YYYY-MM-DD HH24:MI:SS'), 'N', '186');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('607', '会员测试账号', '会员测试账号', '1', '翟小平', '1', '342523198012022222', null, '13000000000', null, '高浪路999号', null, 'abc@123.com', 'WX', 'FDC', '-1', '08948838X', '翟小平', null, null, TO_DATE('2015-07-06 09:24:16', 'YYYY-MM-DD HH24:MI:SS'), null, 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('606010014', 'dassa', 'dsadf', '3', 'afdsa', '1', '987456699885523369', null, '18900129774', null, 'fdsaagfdsaa', null, 'sda@sina.cn', null, null, '-1', null, null, null, null, TO_DATE('2015-07-06 09:37:08', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-06 09:37:08', 'YYYY-MM-DD HH24:MI:SS'), 'N', '225');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('607000003', 'jsb012', 'jsb012', '3', 'jsb012', '1', '342523198012022222', null, '13000000000', null, '高浪路', null, 'abc@123.com', null, null, '-1', null, null, null, null, TO_DATE('2015-07-06 09:59:49', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-06 09:59:49', 'YYYY-MM-DD HH24:MI:SS'), 'N', '234');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('606000017', 'vcsa', 'dsafdsa', '3', 'dsafdas', '1', '321456987741236589', null, '18900129774', null, 'dfsafdsafa', null, 'sfgsdad@sina.cn', 'JS', 'CYY', '-1', null, null, null, null, TO_DATE('2015-07-07 09:04:17', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-07 09:04:17', 'YYYY-MM-DD HH24:MI:SS'), 'N', '143');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('606000018', 'asfsa', 'dasfdsaf', '3', 'dsa', '1', '123654789963258741', null, '18900129774', null, 'dsafdas', null, 'dsafs@sina.cn', 'WX', 'CYY', '-1', null, null, null, null, TO_DATE('2015-07-07 09:04:38', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-07 09:04:38', 'YYYY-MM-DD HH24:MI:SS'), 'N', '141');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('606000019', '567', '567', '3', '567', '1', '430421198709145022', null, '13093056806', null, 'wuxi', null, '123@abc.com', 'WX', 'CYY', '-1', null, null, null, null, TO_DATE('2015-07-07 09:04:57', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-07 09:04:57', 'YYYY-MM-DD HH24:MI:SS'), 'N', '125');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('606000021', 'tt4t4', 't4tr', '3', '453', '1', '23020319870825003X', null, '13211112222', null, '4653655', null, '555@ss.com', 'WX', 'CYY', '-1', null, null, null, null, TO_DATE('2015-07-07 09:07:22', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-07 09:07:22', 'YYYY-MM-DD HH24:MI:SS'), 'N', '83');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('002000002', 'fdscbgfd', 'ssdvfdbg', '3', 'dsafdr', '1', '632147895698741235', null, '18900129774', null, 'vcfdsfda', null, 'dfsa@sina.cn', null, null, '-1', null, null, null, null, TO_DATE('2015-07-07 09:07:37', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-07 09:07:37', 'YYYY-MM-DD HH24:MI:SS'), 'N', '84');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('hy001', '莫干黄芽', null, '3', '莫干黄芽', '1', '123456123412341234', null, '15505101111', null, '无锡市', null, '1111@qq.com', null, null, '1', null, null, null, null, TO_DATE('2015-07-28 10:59:16', 'YYYY-MM-DD HH24:MI:SS'), null, 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('622000000', '孙建军', '孙建军', '3', '吴张彬', '1', '33050119921126135X', '000000000', '13735102222', '000000000', '。。。。。。', '315522', '478404225@qq.com', 'JSNJ', 'JR', '-1', null, null, null, null, TO_DATE('2015-08-25 11:11:57', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-08-25 11:11:57', 'YYYY-MM-DD HH24:MI:SS'), 'N', '421');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('606000031', '呜呜', '呜呜', '3', '呜呜', '1', '345367890987653325', null, '13905723422', null, '浙江', null, '12495010@qq.com', 'WX', 'JR', '-1', null, null, null, null, TO_DATE('2015-10-12 13:58:08', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-10-12 13:58:08', 'YYYY-MM-DD HH24:MI:SS'), 'N', '609');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('606000032', '卡卡', '卡卡', '3', '卡卡', '1', '345654789043547789', null, '13905723422', null, '浙江', null, '12495010@qq.com', 'WX', 'JR', '-1', null, null, null, null, TO_DATE('2015-10-12 13:58:18', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-10-12 13:58:18', 'YYYY-MM-DD HH24:MI:SS'), 'N', '610');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('777777', '贲余刚', '贲余刚', '3', '贲余刚', '1', '320891198799980011', null, '18690876567', null, '贲余刚', null, 'abc@baidu.com', null, null, '1', null, null, '贲余刚', null, TO_DATE('2015-10-17 12:33:54', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-10-18 10:29:46', 'YYYY-MM-DD HH24:MI:SS'), 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('1', '1', '1', '3', '1', '1', '111111111111111111', null, '15711111111', null, '1', null, '1@1.com', null, null, '1', null, null, null, null, TO_DATE('2015-10-28 10:39:03', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-11-05 14:53:43', 'YYYY-MM-DD HH24:MI:SS'), 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('2', '2', '2', '3', '2', '1', '222222222222222222', null, '15722222222', null, '2', null, '2@2.com', null, null, '1', null, null, null, null, TO_DATE('2015-10-28 10:40:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-11-04 14:27:27', 'YYYY-MM-DD HH24:MI:SS'), 'E', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('3', '3', '3', '3', '3', '1', '333333333333333333', null, '15733333333', null, '3', null, '3@3.com', null, null, '1', null, null, null, null, TO_DATE('2015-10-28 10:40:48', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-11-04 14:25:28', 'YYYY-MM-DD HH24:MI:SS'), 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('111', '222', '111', '3', '111', '1', '111', null, '15729292929', null, '111', null, '111@qq.com', null, null, '1', null, null, null, null, TO_DATE('2015-10-28 13:10:08', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-10-28 13:18:09', 'YYYY-MM-DD HH24:MI:SS'), 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('888888', '施一波', '施一波', '3', '施一波', '1', '320781198100091122', null, '18690876789', null, '万达', null, 'abc@sina.com', null, null, '1', null, null, null, null, TO_DATE('2015-10-29 10:06:42', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-11-05 14:40:25', 'YYYY-MM-DD HH24:MI:SS'), 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('222222', '222222', '222222', '2', '222222', '1', '222222222222222222', null, '13888888888', null, '222222', null, '222222@22.com', null, 'JR', '41', '222222', null, null, null, TO_DATE('2015-10-29 11:28:22', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-11-04 16:01:22', 'YYYY-MM-DD HH24:MI:SS'), 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('555555', '贲余刚测试', '贲余刚测试', '3', '贲余刚', '1', '320781198100091122', null, '18690876789', null, '万达', null, 'abc@sina.com', null, null, '1', null, null, null, null, TO_DATE('2015-10-29 13:31:22', 'YYYY-MM-DD HH24:MI:SS'), null, 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('999999', '贲余刚测试', '贲余刚测试', '3', '贲余刚', '1', '320781198100091122', null, '18690876789', null, '万达', null, 'abc@sina.com', null, null, '1', null, null, null, null, TO_DATE('2015-10-29 21:04:40', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-11-05 14:44:18', 'YYYY-MM-DD HH24:MI:SS'), 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('888', '888', '888', '1', '8888888888', '1', '888', null, '13728292929', null, '多少了卡积分哈', null, '124817@qq.com', null, null, '1', '888', null, null, null, TO_DATE('2015-10-30 16:07:40', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-11-05 18:19:50', 'YYYY-MM-DD HH24:MI:SS'), 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('4', '4', null, '3', '4', '1', '4', null, '15744444444', null, '4', null, '4@4.com', null, null, '1', null, null, null, null, TO_DATE('2015-10-31 14:35:48', 'YYYY-MM-DD HH24:MI:SS'), null, 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('222', '222', '222', '3', '222', '1', '222', null, '13593829382', null, 'dfksae ', null, 'sdklf@qq.com', null, null, '1', null, null, null, null, TO_DATE('2015-10-31 15:44:57', 'YYYY-MM-DD HH24:MI:SS'), null, 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('hl', '贲余刚测试', '贲余刚测试', '3', '贲余刚', '1', '320781198100091122', null, '18690876789', null, '万达', null, 'abc@sina.com', null, null, '1', null, null, null, null, TO_DATE('2015-11-02 20:03:35', 'YYYY-MM-DD HH24:MI:SS'), null, 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('6', '6', '6', '3', '6', '1', '6', null, '15766666666', null, '6', null, '6@6.com', null, null, '1', null, null, null, null, TO_DATE('2015-11-04 14:30:04', 'YYYY-MM-DD HH24:MI:SS'), null, 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('7', '7', '7', '3', '7', '1', '7', null, '15777777777', null, '7', null, '7@7.com', null, null, '1', null, null, null, null, TO_DATE('2015-11-04 14:35:19', 'YYYY-MM-DD HH24:MI:SS'), null, 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('22', '111111', '111111', '3', '啊但是vs发', '1', '2313213123123123123123', null, '13983728282', null, '弗兰克', null, 'sakfj@qq.com', null, null, '1', null, null, null, null, TO_DATE('2015-11-04 20:33:47', 'YYYY-MM-DD HH24:MI:SS'), null, 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('0', '0', '0', '3', '讽德诵功', '1', '35243532457209845', null, '13984848484', null, '啊flaw就 ', null, 'aflej@qq.com', null, null, '1', null, null, null, null, TO_DATE('2015-11-04 21:09:28', 'YYYY-MM-DD HH24:MI:SS'), null, 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('a', 'a', 'a', '3', 'da', '1', 'dafc', null, '13938383838', null, 'adfca', null, '1217498923@qq.com', null, null, '1', null, null, null, null, TO_DATE('2015-11-04 23:50:31', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-11-05 00:16:03', 'YYYY-MM-DD HH24:MI:SS'), 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('000', '000', '000', '3', 'jj', '1', '000', null, '15728282828', null, 'afi', null, '23431234@qq.ccom', null, null, '1', null, null, null, null, TO_DATE('2015-11-05 08:39:20', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-11-05 08:39:55', 'YYYY-MM-DD HH24:MI:SS'), 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('2221', 'ss', 'hh', '3', '1', '1', '3', null, '15711111111', null, '1', null, '1@1.COM', null, null, '1', null, null, null, null, TO_DATE('2015-11-06 14:02:26', 'YYYY-MM-DD HH24:MI:SS'), null, 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('test66', 'test66', null, '3', 'test66', '1', '234234123412', null, '15912345678', null, 'sdfa', null, 'sfa@sdfasd.com', null, null, '-1', null, null, null, null, TO_DATE('2015-03-05 17:27:34', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-03-05 17:27:34', 'YYYY-MM-DD HH24:MI:SS'), 'N', '21');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('608000123', '绿茶', null, '1', '绿茶兄', '1', '31231219920322123', null, '18305101234', null, '无锡市绿茶区绿茶县绿茶村', null, '123456789@qq.com', null, null, '1', '123', null, null, null, TO_DATE('2015-03-24 15:42:52', 'YYYY-MM-DD HH24:MI:SS'), null, 'D', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('xh005', '李宁', null, '3', '李宁', '1', '342222199312251619', null, '18949659640', null, '长三角商品交易所', null, 'idlining@foxmail.com', null, null, '1', null, null, null, null, TO_DATE('2015-04-01 10:50:53', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-03 10:00:46', 'YYYY-MM-DD HH24:MI:SS'), 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('xh009', '贠晓利', null, '3', '贠晓利', '1', '320481199107121810', null, '18626056712', null, '长三角商品交易所', null, 'wqs46@qq.com', null, null, '1', null, null, null, null, TO_DATE('2015-04-01 11:05:35', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-03 10:02:30', 'YYYY-MM-DD HH24:MI:SS'), 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('Shimo004', 'Shimo004', null, '3', '石墨', '1', '320211199112140718', null, '18651057180', null, '长三角商品交易所', null, '1529719529@qq.com', null, null, '1', null, null, null, null, TO_DATE('2015-04-13 09:32:12', 'YYYY-MM-DD HH24:MI:SS'), null, 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('Shimo005', 'Shimo005', null, '3', '石墨', '1', '320211199112140718', null, '18651057180', null, '长三角商品交易所', null, '1529719529@qq.com', null, null, '1', null, null, null, null, TO_DATE('2015-04-13 09:33:50', 'YYYY-MM-DD HH24:MI:SS'), null, 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('xh012', '孙建萍', 'sunjp', '3', '孙建萍', '1', '321281198903081405', null, '15261580293', null, '滨湖区高浪路', null, '1092343553@qq.com', null, null, '1', null, null, null, null, TO_DATE('2015-04-24 12:41:37', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-03 09:58:07', 'YYYY-MM-DD HH24:MI:SS'), 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('xh013', '肖伟杰', null, '3', '肖伟杰', '1', '320283199103176517', null, '15861681382', null, '滨湖区高浪路', null, '15861681382@163.com', null, null, '1', null, null, null, null, TO_DATE('2015-04-24 13:45:27', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-03 09:57:38', 'YYYY-MM-DD HH24:MI:SS'), 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('60600000180', 'Ocean', 'Ocean', '3', 'Ocean', '1', '430421197409148074', null, '13093056806', null, '无锡', null, 'wje@yrdce.com', null, null, '1', null, null, null, null, TO_DATE('2015-06-05 15:14:07', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-06-05 15:14:29', 'YYYY-MM-DD HH24:MI:SS'), 'N', '104');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('601002022', '张三', '张三', '3', '张三', '1', '400322195610221022', null, '15502198987', null, '无锡市', null, '4566@qq.com', null, null, '1', null, null, null, null, TO_DATE('2015-06-08 09:53:12', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-06-08 09:53:12', 'YYYY-MM-DD HH24:MI:SS'), 'N', '110');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('00021034', '无锡管理', '无锡管理', '1', '无锡', '1', '410233185610221022', null, '15502198987', null, '滨湖区', null, '5555@qq.com', null, null, '-1', '102356489', '无锡', null, null, TO_DATE('2015-06-08 10:07:44', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-06-08 10:07:44', 'YYYY-MM-DD HH24:MI:SS'), 'E', '111');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('112', '陈小陈', '陈小陈', '3', '陈小陈', '1', '320520199203220827', null, '18352523352', null, '高浪东路999', null, 'chenxiaochen@qq.com', null, null, '-1', null, null, null, null, TO_DATE('2015-06-08 10:33:38', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-06-08 10:33:38', 'YYYY-MM-DD HH24:MI:SS'), 'N', '112');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('60600000111', 'dajiahao', null, '3', 'asda', '1', '210381198801280162', null, '13000000000', null, 'asda', null, '125489658@qq.com', null, null, '-1', null, null, null, null, TO_DATE('2015-06-08 17:04:58', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-06-08 17:04:58', 'YYYY-MM-DD HH24:MI:SS'), 'N', '114');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('606010001', '居间测试1', null, '3', '居间', '1', '123456123412121234', null, '15502145634', null, '无锡市', null, '555@qq.com', null, null, '-1', null, null, null, null, TO_DATE('2015-06-10 11:44:46', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-06-10 11:44:46', 'YYYY-MM-DD HH24:MI:SS'), 'N', '120');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('606010004', '789', '789', '3', '789', '1', '430421198809258077', null, '13093056806', null, 'wuxi', null, 'wje@yrdce.com', 'WX', 'FDC', '-1', null, null, null, null, TO_DATE('2015-06-15 13:58:34', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-06-15 13:58:34', 'YYYY-MM-DD HH24:MI:SS'), 'N', '144');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('606010006', 'dsafa', 'dsafdsa', '3', 'fdas', '1', '123659874456987123', null, '18900129774', null, 'dsafdas', null, 'dsa@sina.cn', 'JS', 'FDC', '-1', null, null, null, null, TO_DATE('2015-06-15 14:41:43', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-06-15 14:41:43', 'YYYY-MM-DD HH24:MI:SS'), 'N', '147');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('606010008', 'fsdafds', 'dsafdsa', '3', 'fdsafdsa', '1', '123698745632145987', null, '18900129774', null, 'dsafdsa', null, 'dsa@sina.cn', 'JS', 'CYY', '-1', null, null, null, null, TO_DATE('2015-06-15 16:25:02', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-06-15 16:25:02', 'YYYY-MM-DD HH24:MI:SS'), 'N', '149');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('606010010', '网上开户', '网上开户', '3', '网上', '1', '123123123412341234', null, '15502198987', null, '无锡', null, '456@qq.com', null, null, '1', null, null, null, null, TO_DATE('2015-06-16 13:40:30', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-06-16 13:40:30', 'YYYY-MM-DD HH24:MI:SS'), 'N', '155');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('HMR01', '绥棱县大森林食品有限责任公司', '大森林食品', '1', '王淑梅', '1', '232332197003080020', null, '18646517235', null, '黑龙江省绥化市绥棱县绥北路', null, '2033211428@qq.com', null, null, '1', '75237577', '王淑梅', null, null, TO_DATE('2015-06-25 13:09:33', 'YYYY-MM-DD HH24:MI:SS'), null, 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('606000016', 'jsb008', 'jsb008', '3', 'jsb008', '1', '430421198809258044', null, '13090000000', null, 'wuxi', null, 'ab@123.com', null, null, '-1', null, null, null, null, TO_DATE('2015-07-07 09:03:30', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-07 09:03:30', 'YYYY-MM-DD HH24:MI:SS'), 'N', '224');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('606000020', '234', '234', '3', '234', '1', '430421197409148074', null, '13093056806', null, 'wuxi', null, '13@ad.com', 'WX', 'FDC', '-1', null, null, null, null, TO_DATE('2015-07-07 09:05:16', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-07 09:05:16', 'YYYY-MM-DD HH24:MI:SS'), 'N', '122');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('000200006', 'atre', '123123', '3', '12312', '1', '131127199112251234', null, '18810526926', null, '12312', null, '123@123.com', 'JS', 'CYY', '-1', null, null, null, null, TO_DATE('2015-07-07 09:08:03', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-07 09:08:03', 'YYYY-MM-DD HH24:MI:SS'), 'N', '86');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('607000004', '王新', '王新', '3', '王新', '1', '320520198214741254', null, '13913656059', null, '常熟', null, '145748524@qq.com', 'JS', 'CYY', '-1', null, null, null, null, TO_DATE('2015-07-08 09:21:15', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-08 09:21:15', 'YYYY-MM-DD HH24:MI:SS'), 'N', '241');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('607000005', '王英', '王英', '3', '王英', '1', '320520198714252141', null, '13814883555', null, '常熟', null, '12547411@qq.com', 'JS', 'CYY', '-1', null, null, null, null, TO_DATE('2015-07-08 10:46:05', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-08 10:46:05', 'YYYY-MM-DD HH24:MI:SS'), 'N', '244');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('618000000', '沈晨', '沈晨', '3', '沈晨', '1', '320581199312454152', null, '15151799450', null, '常熟兴港路', null, '149738965@qq.com', 'JS', 'CYY', '-1', null, null, null, null, TO_DATE('2015-07-22 09:57:50', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-22 09:57:50', 'YYYY-MM-DD HH24:MI:SS'), 'N', '282');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('ceshi', '长三角', null, '3', 'hyl', '1', '111111', null, '13861852981', null, 'wuxi ', null, 'huyl@yrdce.com', null, null, '1', null, null, null, null, TO_DATE('2015-08-20 14:20:56', 'YYYY-MM-DD HH24:MI:SS'), null, 'E', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('607000011', '贲总', '贲总', '3', '贲总', '1', '320481199107121811', null, '18626056711', null, '无锡市', null, '1453212511@qq.com', null, null, '-1', null, null, null, null, TO_DATE('2015-09-01 16:05:39', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-09-01 16:05:39', 'YYYY-MM-DD HH24:MI:SS'), 'N', '441');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('000200008', '孙艳', '孙艳', '3', '孙艳', '1', '320203198401252526', null, '13771130125', null, '高浪东路999号', null, '69660938@qq.com', 'WX', 'JR', '-1', null, null, null, null, TO_DATE('2015-09-21 12:54:26', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-09-21 12:54:26', 'YYYY-MM-DD HH24:MI:SS'), 'N', '543');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('607000021', '张彬', '张彬', '3', '张彬', '1', '33050119921126135X', '13735102222', '13735102222', '13735102222', '青年公寓', '313000', '478404225@qq.com', 'WX', 'JR', '-1', null, null, null, null, TO_DATE('2015-09-21 13:18:21', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-09-21 13:18:21', 'YYYY-MM-DD HH24:MI:SS'), 'N', '548');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('607000024', '孙艳', '孙艳', '3', '孙艳', '1', '320203198401252526', null, '13771130125', null, '高浪东路999号', null, '69660938@qq.com', 'WX', 'JR', '-1', null, null, null, null, TO_DATE('2015-09-23 09:42:02', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-09-23 09:42:02', 'YYYY-MM-DD HH24:MI:SS'), 'N', '567');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('607000025', '长城', '长城', '1', '孙建萍', '1', '321281198903081405', null, '15261580293', null, '无锡', null, '360320970@qq.com', null, 'JR', '-1', '123123', '孙建萍', null, null, TO_DATE('2015-09-23 09:42:37', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-09-23 09:42:37', 'YYYY-MM-DD HH24:MI:SS'), 'N', '566');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('606000024', '长三角商品交易所', 'css', '1', '李宁', '1', '123456789987654321', null, '18949659640', null, '无锡', null, 'idlover@qq.com', 'JS', 'JR', '-1', 'mmmmmmmmm', 'nnnnnnnnnnn', null, null, TO_DATE('2015-09-23 09:43:14', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-09-23 09:43:14', 'YYYY-MM-DD HH24:MI:SS'), 'N', '565');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('607000026', '罗', '罗', '3', '罗', '1', '320481199107121111', null, '18626056712', null, '罗', null, '1453212515@qq.com', null, null, '-1', null, null, null, null, TO_DATE('2015-09-23 09:44:19', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-09-23 09:44:19', 'YYYY-MM-DD HH24:MI:SS'), 'N', '563');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('607000027', 'wzb', 'wzb', '3', '吴张彬', '1', '33050119921126135X', '13735102222', '13735102222', '13735102222', '青年公寓', '313000', '478404225@qq.com', 'WX', 'JR', '-1', null, null, null, null, TO_DATE('2015-09-23 09:44:56', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-09-23 09:44:56', 'YYYY-MM-DD HH24:MI:SS'), 'N', '562');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('607000028', '无锡', '无锡', '1', '肖伟杰', '1', '111222555555558888', null, '15861681382', null, '无锡', null, '158616@163.com', 'WX', 'JR', '-1', '111', '肖伟杰', null, null, TO_DATE('2015-09-23 09:52:21', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-09-23 09:52:21', 'YYYY-MM-DD HH24:MI:SS'), 'N', '568');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('607000029', '啊哈哈', '啊', '1', '我', '1', '32020279890205453x', null, '15161573028', null, '们', null, 'z@163.com', 'JS', 'FDC', '-1', '1', '啊', null, null, TO_DATE('2015-09-23 09:52:46', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-09-23 09:52:46', 'YYYY-MM-DD HH24:MI:SS'), 'N', '569');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('606000026', '呆呆', '呆呆', '3', '呆呆', '1', '354678456123458906', null, '13905723422', null, '浙江', null, '12495010@qq.com', 'WX', 'JR', '-1', null, null, null, null, TO_DATE('2015-10-12 11:05:03', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-10-12 11:05:03', 'YYYY-MM-DD HH24:MI:SS'), 'N', '603');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('606000027', '牛牛', '牛牛', '3', '牛牛', '1', '258456321459632587', null, '13905723422', null, '浙江', null, '12495010@qq.com', 'WX', 'JR', '-1', null, null, null, null, TO_DATE('2015-10-12 11:11:25', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-10-12 11:11:25', 'YYYY-MM-DD HH24:MI:SS'), 'N', '604');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('606000029', '西西', '西西', '3', '西西', '1', '548726325954781254', null, '13905723422', null, '浙江', null, '12495010@qq.com', 'WX', 'JR', '-1', null, null, null, null, TO_DATE('2015-10-12 11:16:25', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-10-12 11:16:25', 'YYYY-MM-DD HH24:MI:SS'), 'N', '606');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('505000000000002', '吴成毅', '吴成毅', '3', '吴成毅', '1', '23412341234', null, '13988888888', null, '高浪路', null, 'wcy@yrdce.com', null, null, '2', null, null, null, null, TO_DATE('2014-11-12 17:25:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-11-18 03:43:11', 'YYYY-MM-DD HH24:MI:SS'), 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('505000000000007', '徐敏', '徐敏', '3', '徐敏', '1', '360403197203020920', null, '13915285182', null, '高浪路999号', null, '1253376625@qq.com', null, null, '1', null, null, null, null, TO_DATE('2014-12-12 09:57:45', 'YYYY-MM-DD HH24:MI:SS'), null, 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('505000000000005', '蔡津', '蔡津', '3', '蔡津', '1', '3205555880000', null, '13915357873', null, '高浪路999', null, '1060457745@qq.com', null, null, '1', null, null, null, null, TO_DATE('2014-12-12 11:09:16', 'YYYY-MM-DD HH24:MI:SS'), null, 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('505000000000010', '王家恩', '王家恩', '3', '王家恩', '1', '430421190000000000', null, '13000000000', null, '长三角商品交易所', null, 'wje@yrdce.com', null, null, '1', null, null, null, null, TO_DATE('2014-12-15 10:36:33', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-04-24 13:25:17', 'YYYY-MM-DD HH24:MI:SS'), 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('126000000000108', '张春意', null, '3', '张春意', '1', '320925199007210011', null, '13961878476', null, '无锡爱家', null, '709910405@qq.com', null, null, '1', null, null, null, null, TO_DATE('2014-12-16 12:59:29', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-12-16 13:01:30', 'YYYY-MM-DD HH24:MI:SS'), 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('008013', 'lvtctest', 'asdf', '3', '吕天 才', '1', '210504198001071335', null, '15190205070', null, 'dsfasdf', null, 'lvtc@yrdce.com', null, null, '1', null, null, null, null, TO_DATE('2014-12-25 07:43:06', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-12-25 08:02:44', 'YYYY-MM-DD HH24:MI:SS'), 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('505000000000108', '倪佳', null, '3', '倪佳', '1', '320219198408035779', null, '15961669984', null, '无锡', null, 'monk77@163.com', null, null, '1', null, null, null, null, TO_DATE('2014-12-25 11:22:25', 'YYYY-MM-DD HH24:MI:SS'), null, 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('601010001', '马亮', '马亮', '3', '马亮', '1', '370881198801143530', null, '13585087696', null, '山东曲阜', null, 'maliang305@163.com', null, null, '-1', null, null, null, null, TO_DATE('2015-01-06 13:33:54', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-03-25 13:53:56', 'YYYY-MM-DD HH24:MI:SS'), 'N', '2');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('601010002', '马亮', null, '3', '马亮', '1', '370881198801143530', null, '15615678303', null, '山东曲阜', null, 'maliang305@163.com', null, null, '-1', null, null, null, null, TO_DATE('2015-01-06 14:42:33', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-01-06 14:42:33', 'YYYY-MM-DD HH24:MI:SS'), 'N', '3');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('44444', '1556', null, '3', 'kkk', '1', '1561156561561', null, '15365485666', null, '555555', null, '5411564156@qq.com', null, null, '1', null, null, null, null, TO_DATE('2015-01-20 11:15:50', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-03-25 10:22:04', 'YYYY-MM-DD HH24:MI:SS'), 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('55555', '55', null, '3', 'hjah', '1', '5641561561156', null, '15355465888', null, '56464564', null, '586414656456@qq.com', null, null, '1', null, null, null, null, TO_DATE('2015-01-20 11:17:07', 'YYYY-MM-DD HH24:MI:SS'), null, 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('77777', '556', null, '3', '1225', '1', '848444464564', null, '15365425699', null, '5451465446', null, '5564655462@qq.com', null, null, '1', null, null, null, null, TO_DATE('2015-01-20 11:19:41', 'YYYY-MM-DD HH24:MI:SS'), null, 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('88888', '122', null, '3', '15455', '1', '5641456145646', null, '15325865455', null, '55555', null, '542541651465@qq.com', null, null, '1', null, null, null, null, TO_DATE('2015-01-20 11:21:33', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-03-25 10:23:51', 'YYYY-MM-DD HH24:MI:SS'), 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('99999', '445', null, '3', '2255', '1', '9584414641641', null, '13658436522', null, '12525112', null, '515611651@qq.com', null, null, '1', null, null, null, null, TO_DATE('2015-01-20 11:23:20', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-03-25 09:51:23', 'YYYY-MM-DD HH24:MI:SS'), 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('608000333', 'creamycc', null, '3', 'creamycc', '1', '310103199203220078', null, '18305100011', null, 'gaolanglulo', null, '123456789@qq.com', null, null, '1', null, null, null, null, TO_DATE('2015-03-25 11:00:41', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-03-25 11:06:28', 'YYYY-MM-DD HH24:MI:SS'), 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('xh001', '罗宇灏', null, '3', '罗宇灏', '1', '320481199107121810', null, '18626056712', null, '长三角商品交易所', null, '505644019@qq.com', null, null, '1', null, null, null, null, TO_DATE('2015-04-01 10:14:04', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-03 09:59:40', 'YYYY-MM-DD HH24:MI:SS'), 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('xh006', '王灏天', null, '3', '王灏天', '1', '32028319880405653X', null, '15651500942', null, '长三角商品交易所', null, '371042410@qq.com', null, null, '1', null, null, null, null, TO_DATE('2015-04-01 10:54:13', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-03 10:01:06', 'YYYY-MM-DD HH24:MI:SS'), 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('Shimo001', 'Shimo001', null, '3', 'shimo', '1', '320211199112140717', null, '18651057180', null, '长三角商品交易所', null, '1529719529@qq.com', null, null, '1', null, null, null, null, TO_DATE('2015-04-10 14:33:53', 'YYYY-MM-DD HH24:MI:SS'), null, 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('Shimo002', 'Shimo002', null, '3', '石墨', '1', '320211199112140718', null, '18651057180', null, '长三角商品交易所', null, '1529719529@qq.com', null, null, '1', null, null, null, null, TO_DATE('2015-04-13 09:28:15', 'YYYY-MM-DD HH24:MI:SS'), null, 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('Shimo003', 'Shimo003', null, '3', '石墨', '1', '320211199112140718', null, '18651057180', null, '长三角商品交易所', null, '1529719529@qq.com', null, null, '1', null, null, null, null, TO_DATE('2015-04-13 09:30:43', 'YYYY-MM-DD HH24:MI:SS'), null, 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('50500000100', '王家恩', '王家恩', '3', '王家恩', '1', '430421190000', null, '13000000000', null, '无锡', null, 'wje@yrdce.com', null, null, '-1', null, null, null, null, TO_DATE('2015-04-24 13:54:40', 'YYYY-MM-DD HH24:MI:SS'), null, 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('60600000110', 'dfsgd', 'vfdasgfda', '3', 'fgdfdafs', '1', '123698745563214789', null, '15100005555', null, 'fgdsbvba', null, 'dsafgd@sina.cn', null, null, '1', null, null, null, null, TO_DATE('2015-06-02 10:04:14', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-06-02 10:04:14', 'YYYY-MM-DD HH24:MI:SS'), 'N', '89');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('606000001', '现货挂牌会员部', '现货挂牌会员部', '3', '现货挂牌', '1', '320481199107121810', null, '18762652690', null, '现货挂牌', null, '1453212515@qq.com', 'JS', 'FDC', '-1', null, null, null, null, TO_DATE('2015-06-05 16:14:28', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-06-05 16:14:28', 'YYYY-MM-DD HH24:MI:SS'), 'N', '106');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('606000002', '韦青松', '韦青松', '3', '韦青松', '1', '320721199009135434', null, '18061517963', null, '无锡市高浪东路999号', null, 'wqs46@qq.com', 'WX', 'FDC', '-1', null, null, null, null, TO_DATE('2015-06-05 16:20:08', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-06-05 16:20:08', 'YYYY-MM-DD HH24:MI:SS'), 'N', '107');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('606010000', '居间测试', null, '3', '居间', '1', '123456123412121234', null, '15515151515', null, '无锡', null, '155@QQ.com', null, null, '-1', null, null, null, null, TO_DATE('2015-06-09 13:28:06', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-06-11 10:27:33', 'YYYY-MM-DD HH24:MI:SS'), 'N', '119');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('606000008', '模拟测试', '模拟测试', '3', '模拟测试', '1', '1234561234123412341234', null, '15502198987', null, '无锡', null, '555@163.com', 'JS', null, '-1', null, null, null, null, TO_DATE('2015-06-11 09:14:04', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-06-11 09:14:04', 'YYYY-MM-DD HH24:MI:SS'), 'N', '123');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('606010009', '890', '890', '3', '890', '1', '430421198809148055', null, '13093056806', null, 'wuxi', null, '123@abc.com', 'WX', 'FDC', '1', null, null, null, null, TO_DATE('2015-06-15 16:36:10', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-06-15 16:36:10', 'YYYY-MM-DD HH24:MI:SS'), 'N', '150');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('000210341', 'gnnt020', 'gnnt020', '3', 'gnnt020', '1', '430421198808148022', null, '13093056806', null, 'wuxi', null, '123@ab.com', 'WX', 'CYY', '-1', null, null, null, null, TO_DATE('2015-06-15 16:45:40', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-06-15 16:45:40', 'YYYY-MM-DD HH24:MI:SS'), 'N', '151');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('606000012', 'dsabvc', 'vsdadsa', '3', 'fgdhgfh', '1', '963258741123698745', null, '18911129775', null, 'fdshsfds', null, 'dfhbgfd@sina.cn', 'JS', 'CYY', '-1', null, null, null, null, TO_DATE('2015-07-02 10:59:15', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-02 10:59:15', 'YYYY-MM-DD HH24:MI:SS'), 'N', '88');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('606000013', 'jsb001', 'jsb001', '3', 'jsb001', '1', '430421198809158055', null, '13093056806', null, 'wuxi', null, 'abc@123.com', 'WX', 'FDC', '-1', null, null, null, null, TO_DATE('2015-07-02 19:33:04', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-02 19:33:04', 'YYYY-MM-DD HH24:MI:SS'), 'N', '183');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('606010013', 'dasfas', null, '3', 'fdsafdsg', '1', '698555966332256698', null, '18900129774', null, 'dsafdsa', null, 'dfsa@sina.cn', null, null, '-1', null, null, null, null, TO_DATE('2015-07-06 09:36:25', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-06 09:36:25', 'YYYY-MM-DD HH24:MI:SS'), 'N', '227');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('606000014', 'dsafda', null, '3', 'dsafas', '1', '130633987445563395', null, '18900129774', null, 'sdfdsa', null, 'vsda@sina.cn', null, null, '-1', null, null, null, null, TO_DATE('2015-07-06 09:36:50', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-06 09:36:50', 'YYYY-MM-DD HH24:MI:SS'), 'N', '226');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('607000001', '607000001', '607000001', '3', '607000001', '1', '342523198012022222', null, '13000000000', null, '高浪路999号', null, 'abc@123.com', null, null, '-1', null, null, null, null, TO_DATE('2015-07-06 09:44:07', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-06 09:44:07', 'YYYY-MM-DD HH24:MI:SS'), 'N', '228');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('607020001', '607020001', '607020001', '3', '607020001', '1', '342523198012022222', null, '13000000000', null, '高浪路', null, 'abc@123.com', null, null, '-1', null, null, null, null, TO_DATE('2015-07-06 09:44:53', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-06 09:44:53', 'YYYY-MM-DD HH24:MI:SS'), 'N', '230');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('607000002', 'jsb011', 'jsb011', '3', 'jsb011', '1', '342523198012022222', null, '13093056806', null, '高浪路', null, 'abc@123.com', null, null, '-1', null, null, null, null, TO_DATE('2015-07-06 09:55:49', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-06 09:55:49', 'YYYY-MM-DD HH24:MI:SS'), 'N', '233');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('607000006', '胡亿', '胡亿', '3', '胡亿', '1', '320520199141523652', null, '13913656059', null, '常熟', null, '1425874@qq.com', 'JS', 'CYY', '-1', null, null, null, null, TO_DATE('2015-07-08 11:09:59', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-08 11:09:59', 'YYYY-MM-DD HH24:MI:SS'), 'N', '243');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('607000007', '罗静', '罗静', '3', '罗静', '1', '320520197845214141', null, '13913656059', null, '常熟', null, '14745825@qq.com', 'JS', 'CYY', '-1', null, null, null, null, TO_DATE('2015-07-08 11:11:05', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-08 11:11:05', 'YYYY-MM-DD HH24:MI:SS'), 'N', '242');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('609000000', '龙猫', '龙猫', '3', '龙猫', '1', '330501199805182586', null, '13905723422', null, '浙江省湖州市爱山街道玉皇殿街83号', null, '979646584@qq.com', null, null, '-1', null, null, null, null, TO_DATE('2015-07-15 14:15:31', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-15 14:15:31', 'YYYY-MM-DD HH24:MI:SS'), 'N', '261');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('101000005000579', '胡玉龙', null, '3', '大猫', '1', '101000005000579', null, '13861852981', null, '无锡', null, 'huyl@yrdce.com', null, null, '1', null, null, null, null, TO_DATE('2015-08-13 11:28:27', 'YYYY-MM-DD HH24:MI:SS'), null, 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('ceshi1', 'ceshi1', null, '3', 'hyl', '1', '111111', null, '13861852981', null, 'wuxi ', null, 'huyl@yrdce.com', null, null, '1', null, null, null, null, TO_DATE('2015-08-20 14:23:26', 'YYYY-MM-DD HH24:MI:SS'), null, 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('h1', 'h1', '测试CDJW', '3', '13311111111', '2', '1234213', null, '13311111111', null, '21', null, '12@s.com', null, null, '1', null, null, null, null, TO_DATE('2015-08-27 16:13:07', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-08-28 09:38:52', 'YYYY-MM-DD HH24:MI:SS'), 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('001', 'df', 'sdf', '3', '333', '1', '342233333333333333', null, '18322222222', null, '3333', null, '222222@qq.com', 'WX', 'FDC', '-1', null, null, null, null, TO_DATE('2015-09-10 21:35:58', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-09-10 21:37:36', 'YYYY-MM-DD HH24:MI:SS'), 'D', '462');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('607000018', '长三角商品交易所', '长三角商品交易所', '1', '吴张彬', '1', '33050119921126135X', '13735102222', '13735102222', '13735102222', '长三角商品交易所', '313000', '478404225@qq.com', 'WX', 'JR', '-1', '111111111', '吴', null, null, TO_DATE('2015-09-14 13:48:15', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-09-14 13:48:15', 'YYYY-MM-DD HH24:MI:SS'), 'N', '504');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('008', '张永祥', '张永祥', '3', '张永祥', '1', '142327198508101714', null, '13771488707', null, '江苏省无锡市高浪东路999号', null, '86097823@qq.com', null, null, '2', null, null, '这个人很懒，什么都没留下！', null, TO_DATE('2014-11-18 03:17:04', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-11-18 03:42:55', 'YYYY-MM-DD HH24:MI:SS'), 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('50500000000009', '洪学勤', '洪学勤', '3', '洪学勤', '1', '32022222222222', null, '18626388318', null, '高浪路999', null, '2850821292@qq.com', null, null, '1', null, null, null, null, TO_DATE('2014-12-12 11:01:51', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-12-12 11:02:09', 'YYYY-MM-DD HH24:MI:SS'), 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('505000000000088', '花花', null, '3', '花花', '1', '561566116165156', null, '13661533696', null, '高浪东路999', null, '564165165165@qq.com', null, null, '1', null, null, null, null, TO_DATE('2015-01-19 14:26:03', 'YYYY-MM-DD HH24:MI:SS'), null, 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('505000000000089', '毛毛', null, '3', '毛毛', '1', '5464654564646', null, '13525469873', null, '高浪东路', null, '655651@qq.com', null, null, '1', null, null, null, null, TO_DATE('2015-01-19 14:29:23', 'YYYY-MM-DD HH24:MI:SS'), null, 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('606', '德清艾瑞商务信息咨询有限公司', '德清艾瑞商务信息咨询有限公司', '1', '宣守芬', '1', '342523198012022222', null, '15365845698', null, '浙江省德清县武康镇五里牌路70号', null, '564465454@qq.com', 'WX', 'FDC', '-1', '08948838X', '宣守芬', null, null, TO_DATE('2015-01-27 17:07:54', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-01-27 17:08:16', 'YYYY-MM-DD HH24:MI:SS'), 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('00030101', 'ddd', '张春意', '3', '张春意', '1', '320925199007210011', null, '13961878476', null, '无锡', null, '709910405@qq.com', null, null, '-1', null, null, null, null, TO_DATE('2015-03-06 11:09:41', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-03-25 10:55:49', 'YYYY-MM-DD HH24:MI:SS'), 'N', '41');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('xh002', '赵峥', null, '3', '赵峥', '1', '320211199112140717', null, '18651057180', null, '长三角商品交易所', null, '1529719529@qq.com', null, null, '1', null, null, null, null, TO_DATE('2015-04-01 10:21:06', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-03 09:59:56', 'YYYY-MM-DD HH24:MI:SS'), 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('xh003', '过佳', null, '3', '过佳', '1', '320283199111206552', null, '18762652690', null, '长三角商品交易所', null, '505644019@qq.com', null, null, '1', null, null, null, null, TO_DATE('2015-04-01 10:41:48', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-03 10:00:16', 'YYYY-MM-DD HH24:MI:SS'), 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('xh004', '邹强', null, '3', '邹强', '1', '320283199204127570', null, '15251514847', null, '长三角商品交易所', null, '751797178@qq.com', null, null, '1', null, null, null, null, TO_DATE('2015-04-01 10:44:50', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-03 09:59:19', 'YYYY-MM-DD HH24:MI:SS'), 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('xh007', '韦青松', null, '3', '韦青松', '1', '320721199009135434', null, '18012163077', null, '长三角商品交易所', null, 'wqs46@qq.com', null, null, '1', null, null, null, null, TO_DATE('2015-04-01 10:56:42', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-03 10:01:24', 'YYYY-MM-DD HH24:MI:SS'), 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('xh008', '姜海峰', null, '3', '姜海峰', '1', '320481199107121810', null, '15204178541', null, '长三角商品交易所', null, 'wqs46@qq.com', null, null, '1', null, null, null, null, TO_DATE('2015-04-01 10:59:08', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-03 10:02:06', 'YYYY-MM-DD HH24:MI:SS'), 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('xh010', '孙艳', null, '3', '孙艳', '1', '320481199107121810', null, '18762652690', null, '长三角商品交易所', null, 'wqs46@qq.com', null, null, '1', null, null, null, null, TO_DATE('2015-04-01 11:08:43', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-03 10:02:46', 'YYYY-MM-DD HH24:MI:SS'), 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('606010002', '456', '456', '3', '246', '1', '430421198809158022', null, '13093056806', null, '无锡', null, '123@abc.com', 'WX', 'CYY', '1', null, null, null, null, TO_DATE('2015-06-11 17:29:54', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-06-11 17:29:54', 'YYYY-MM-DD HH24:MI:SS'), 'N', '124');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('000200001', '900', '900', '3', '900', '1', '430421198808156088', null, '13093056806', null, 'wuxi', null, '123@ab.com', 'JS', 'CYY', '-1', null, null, null, null, TO_DATE('2015-06-15 16:55:01', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-06-15 16:55:01', 'YYYY-MM-DD HH24:MI:SS'), 'N', '152');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('606000009', '902', '902', '3', '902', '1', '430421199409258011', null, '13093056806', null, '902', null, '12@abc.com', null, null, '-1', null, null, null, null, TO_DATE('2015-06-15 17:03:49', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-06-26 09:12:28', 'YYYY-MM-DD HH24:MI:SS'), 'N', '154');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('606000011', '网上开户法人', '开户法人', '1', '法人', '1', '123456123412341234', null, '15502198987', null, '无锡', null, '155@qq.com', null, null, '-1', '123456789', '法人', null, null, TO_DATE('2015-06-16 13:56:20', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-06-16 13:56:20', 'YYYY-MM-DD HH24:MI:SS'), 'N', '156');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('000200003', '长三角商品交易所', '长三角商品交易所', '1', '孙建萍', '1', '321281198903081405', null, '15261580293', null, '无锡市滨湖区高浪路999号', null, '1092343553@qq.com', 'WX', 'CYY', '-1', 'YRDCE123', '孙建萍', null, null, TO_DATE('2015-06-16 14:25:25', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-06-16 14:25:25', 'YYYY-MM-DD HH24:MI:SS'), 'N', '158');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('606010012', '朱睿', '朱睿', '3', '朱睿', '1', '123456123412341234', null, '15852767880', null, '无锡市', null, '1232@qq.com', null, null, '-1', null, null, null, null, TO_DATE('2015-06-17 16:55:23', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-06-17 16:55:23', 'YYYY-MM-DD HH24:MI:SS'), 'N', '161');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('444', '444', null, '2', '444', '1', '444444444444444444', null, '18352523352', null, '4444444', null, '526548762@qq.com', null, null, '2', '444', null, null, null, TO_DATE('2015-06-19 09:46:57', 'YYYY-MM-DD HH24:MI:SS'), null, 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('505000000000105', 'zhang', null, '2', 'zhang', '1', '22222222222222222', null, '13961878476', null, '无锡', null, '709910405@qq.com', 'WX', null, '1', '2222222', null, null, null, TO_DATE('2015-06-19 09:59:42', 'YYYY-MM-DD HH24:MI:SS'), null, 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('000301013', '徐婷', '徐婷', '3', '徐婷', '1', '342523198904117622', null, '18605638321', null, '广德县万桂山', null, '316763004@qq.com', 'WX', 'FDC', '-1', null, null, null, null, TO_DATE('2015-06-23 09:06:09', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-06-23 09:06:09', 'YYYY-MM-DD HH24:MI:SS'), 'N', '163');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('607010001', '607010001', '607010001', '3', '607010001', '1', '342523198012022222', null, '13000000000', null, '高浪路', null, 'bc@123.com', null, null, '-1', null, null, null, null, TO_DATE('2015-07-06 09:44:31', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-06 09:44:31', 'YYYY-MM-DD HH24:MI:SS'), 'N', '229');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('607020002', 'jsb010', 'jsb010', '3', 'jsb010', '1', '342523198012022222', null, '13000000000', null, '高浪路', null, 'abc@123.com', null, null, '-1', null, null, null, null, TO_DATE('2015-07-06 09:51:13', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-06 09:51:13', 'YYYY-MM-DD HH24:MI:SS'), 'N', '232');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('607010002', 'jsb009', 'jsb009', '3', 'jsb009', '1', '342523198012022222', null, '13000000000', null, '高浪路999', null, 'abc@123.com', null, null, '-1', null, null, null, null, TO_DATE('2015-07-06 09:51:39', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-06 09:51:39', 'YYYY-MM-DD HH24:MI:SS'), 'N', '231');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('606000015', 'jsb006', 'jsb006', '3', 'jsb006', '1', '430421198809158099', null, '13000000000', null, 'wuxi', null, 'an@123.com', null, null, '-1', null, null, null, null, TO_DATE('2015-07-07 09:02:52', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-07 09:02:52', 'YYYY-MM-DD HH24:MI:SS'), 'N', '222');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('020000001', 'fdsafdsa', null, '3', 'dasfsda', '1', '123699855669922265', null, '18900129774', null, 'dsfdsfada', null, 'fdsafsd@sina.cn', null, null, '-1', null, null, null, null, TO_DATE('2015-07-07 09:03:04', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-07 09:03:04', 'YYYY-MM-DD HH24:MI:SS'), 'N', '203');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('606010015', 'jsb007', 'jsb007', '3', 'jsb007', '1', '430421198809258055', null, '13000000000', null, 'wuxi', null, 'ab@123.com', null, null, '-1', null, null, null, null, TO_DATE('2015-07-07 09:03:17', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-07 09:03:17', 'YYYY-MM-DD HH24:MI:SS'), 'N', '223');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('002000001', 'sxcdfgfre', 'asxxcdfer', '3', 'dfchre', '1', '987412365963214785', null, '18900129774', null, 'vcxreagfdg', null, 'sfvgew@sina.cn', null, null, '-1', null, null, null, null, TO_DATE('2015-07-07 09:06:58', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-07 09:06:58', 'YYYY-MM-DD HH24:MI:SS'), 'N', '81');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('000200005', 'sxdfdfs', 'vfdwfewd', '3', '王家恩', '1', '123654789987456321', null, '18900129774', null, '无锡', null, 'wje@yrdce.com', 'WX', 'FDC', '-1', null, null, null, null, TO_DATE('2015-07-07 09:07:09', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-07 09:07:09', 'YYYY-MM-DD HH24:MI:SS'), 'N', '82');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('000100001', 'qwesad', 'safdcewds', '3', 'dscs', '1', '987412365569874123', null, '18900129774', null, 'cxfdsadsa', null, 'dsa@sina.cn', null, null, '-1', null, null, null, null, TO_DATE('2015-07-07 09:07:50', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-07 09:07:50', 'YYYY-MM-DD HH24:MI:SS'), 'N', '85');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('002000003', 'sfdsbd', 'dsafds', '3', 'dsgd', '1', '123654789963214785', null, '18900129774', null, 'dbhfdfs', null, 'sfsa@sina.cn', null, null, '-1', null, null, null, null, TO_DATE('2015-07-07 09:08:18', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-07 09:08:18', 'YYYY-MM-DD HH24:MI:SS'), 'N', '87');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('607000010', '测试账户', '测试账户', '1', '测试账户', '1', '430421195508148066', null, '13093056806', null, '无锡', null, 'abc@123.com', null, null, '-1', '123456', '测试账户', null, null, TO_DATE('2015-08-04 08:17:03', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-08-04 08:17:03', 'YYYY-MM-DD HH24:MI:SS'), 'N', '341');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('606000022', '艾瑞1', '艾瑞1', '3', '艾瑞1', '1', '330521199012203669', null, '15557217016', null, '浙江德清', null, 'DQ@163.com', null, null, '-1', null, null, null, null, TO_DATE('2015-08-20 09:47:26', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-08-20 09:47:26', 'YYYY-MM-DD HH24:MI:SS'), 'N', '401');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('3203211988', 'chengdong', null, '1', '15240465600', '1', '320321198810241850', null, '15240465600', null, '无锡', null, '771535427@qq.com', 'JS', 'CYY', '1', '021', null, null, null, TO_DATE('2015-08-24 09:38:16', 'YYYY-MM-DD HH24:MI:SS'), null, 'E', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('h2', 'h2', '测试CDJW', '3', 'q', '2', '43254234', null, '13322222222', null, 'sa', null, 'ew@s.com', null, null, '1', null, null, null, null, TO_DATE('2015-08-28 09:40:04', 'YYYY-MM-DD HH24:MI:SS'), null, 'D', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('607000012', '孙建萍', '孙建萍', '3', '孙建萍', '1', '321281198903081405', '051085671111', '15261580293', null, '无锡市滨湖区高浪路', null, '360320970@qq.com', 'WX', 'JR', '-1', null, null, null, null, TO_DATE('2015-09-14 13:44:34', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-09-14 13:44:34', 'YYYY-MM-DD HH24:MI:SS'), 'N', '502');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('183', '金网-张天骥', null, '3', '张天骥', '1', '519103199204586751', null, '18200390957', null, '123213', null, '123@qq.com', null, null, '-1', null, null, null, null, TO_DATE('2015-09-15 14:04:32', 'YYYY-MM-DD HH24:MI:SS'), null, 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('607000019', '吴张彬', '吴张彬', '3', '吴张彬', '1', '33050119921126135X', '13735102222', '13735102222', '13735102222', '青年公寓', '313000', '478404225@qq.com', 'WX', 'JR', '-1', null, null, null, null, TO_DATE('2015-09-21 13:11:16', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-09-21 13:11:16', 'YYYY-MM-DD HH24:MI:SS'), 'N', '545');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('607000020', '罗', '罗', '3', '罗', '1', '320481199107121811', null, '18626056712', null, '罗', null, '145321555@qq.com', 'WX', 'JR', '-1', null, null, null, null, TO_DATE('2015-09-21 13:13:57', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-09-21 13:13:57', 'YYYY-MM-DD HH24:MI:SS'), 'N', '547');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('000200009', '黄克伟', '黄', '3', '啊', '1', '32020219890205453x', null, '15161573028', null, '啊', null, '929591355@qq.com', null, null, '-1', null, null, null, null, TO_DATE('2015-09-21 13:14:30', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-09-21 13:14:30', 'YYYY-MM-DD HH24:MI:SS'), 'N', '546');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('606000023', 'yrdce1', 'yrdce1', '1', '李宁', '1', '123456789012345678', null, '18949659640', null, '无锡市高浪东路999号', null, 'lin@yrdce.com', 'WX', 'JR', '-1', 'oooo', 'yrdce', null, null, TO_DATE('2015-09-21 13:24:07', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-09-21 13:24:07', 'YYYY-MM-DD HH24:MI:SS'), 'N', '549');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('607000022', '长三角', '长三角商品交易所', '3', '王灏天', '1', '32028319880405653x', '0510-68069027', '15651500942', '0510-68069027', '高浪东路999号', '214100', '371042410@qq.com', 'WX', 'JR', '-1', null, null, null, null, TO_DATE('2015-09-21 13:25:08', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-09-21 13:25:08', 'YYYY-MM-DD HH24:MI:SS'), 'N', '550');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('607000023', '无锡', '自己', '1', '肖伟杰', '1', '320283199103176522', null, '15861681382', null, '无锡', null, '15861681382@163.com', 'WX', 'JR', '-1', '1114', '肖伟杰', null, null, TO_DATE('2015-09-21 13:33:03', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-09-21 13:33:03', 'YYYY-MM-DD HH24:MI:SS'), 'N', '551');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('111111', 'ITC', 'ITC', '3', '111', '1', '11111111', null, '13645177902', null, 'ITC', null, 'abc@sina.com', null, null, '41', null, null, 'ITC测试', null, TO_DATE('2015-10-08 14:48:45', 'YYYY-MM-DD HH24:MI:SS'), null, 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('606000025', '木木', '木木', '3', '木木', '1', '123456789111001245', null, '13905723422', null, '浙江', null, '247388750@qq.com', 'WX', 'JR', '-1', null, null, null, null, TO_DATE('2015-10-12 11:02:05', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-10-12 15:16:20', 'YYYY-MM-DD HH24:MI:SS'), 'N', '602');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('606000030', '大大', '大大', '3', '大大', '1', '123124456642134789', null, '13905723422', null, '浙江', null, '12495010@qq.com', 'WX', 'JR', '-1', null, null, null, null, TO_DATE('2015-10-12 13:57:53', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-10-12 14:19:33', 'YYYY-MM-DD HH24:MI:SS'), 'N', '608');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('606000033', '七七', '七七', '3', '七七', '1', '325576786797898946', null, '13905723422', null, '浙江', null, '12495010@qq.com', 'WX', 'JR', '-1', null, null, null, null, TO_DATE('2015-10-12 13:58:29', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-10-12 13:58:29', 'YYYY-MM-DD HH24:MI:SS'), 'N', '611');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('607000031', 'c', '到宿舍是', '3', '汪汪', '1', '233333333333333333', '277737377737', '15951819927', null, '都会不放', null, '7777@qq.com', 'WX', 'FDC', '-1', null, null, null, null, TO_DATE('2015-10-20 08:26:23', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-10-20 08:26:23', 'YYYY-MM-DD HH24:MI:SS'), 'N', '622');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('607000032', 'dd', 'dd', '3', 'dd', '1', '321085198112040344', null, '18606191058', null, 'dd', null, 'dd@dd.com', 'JS', 'CYY', '-1', null, null, null, null, TO_DATE('2015-10-20 08:27:34', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-10-20 08:27:34', 'YYYY-MM-DD HH24:MI:SS'), 'N', '662');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('505000000000001', '郑雄', '郑雄', '3', '郑雄', '1', '352202198111070012', null, '15951511568', null, '高浪路', null, 'zx@yrdce.com', null, null, '3', null, null, null, null, TO_DATE('2014-11-11 13:43:22', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-03-05 18:03:03', 'YYYY-MM-DD HH24:MI:SS'), 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('505000000000008', '曹杰', '曹杰', '3', '哈哈', '1', '58676767676', null, '15806181827', null, '江苏省无锡市', null, '2587139141@qq.com', null, null, '1', null, null, null, null, TO_DATE('2014-12-12 10:13:59', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-12-12 10:18:07', 'YYYY-MM-DD HH24:MI:SS'), 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('test1', 'test1', null, '3', 'test', '1', '234123', null, '15912345678', null, 'wx', null, 'aa@est.com', null, null, '1', null, null, null, null, TO_DATE('2014-12-25 08:31:49', 'YYYY-MM-DD HH24:MI:SS'), null, 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('505000000000110', '朱伟', null, '3', '朱伟', '1', '321081198707150310', null, '18626096242', null, '无锡', null, '715654701@qq.com', null, null, '1', null, null, null, null, TO_DATE('2014-12-25 11:26:36', 'YYYY-MM-DD HH24:MI:SS'), null, 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('505000000000004', '王上博', '王上博', '3', '王上博', '1', '6655656', null, '13342263239', null, '高浪东路999', null, '56256526@qq.com', null, null, '1', null, null, null, null, TO_DATE('2014-12-25 11:38:11', 'YYYY-MM-DD HH24:MI:SS'), null, 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('505000000000090', '泡泡', null, '3', '泡泡', '1', '54545456465', null, '13756985632', null, '高浪东路999', null, '563156315@qq.com', null, null, '1', null, null, null, null, TO_DATE('2015-01-19 14:31:00', 'YYYY-MM-DD HH24:MI:SS'), null, 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('505000000000091', '打打', null, '3', '打打', '1', '5641616116', null, '13584396688', null, '高浪东路999', null, '5645641456@qq.com', null, null, '1', null, null, null, null, TO_DATE('2015-01-19 14:32:29', 'YYYY-MM-DD HH24:MI:SS'), null, 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('505000000000092', '哈哈', null, '3', '哈哈', '1', '87686876876', null, '15369785322', null, '高浪东路999', null, '564156156@qq.com', null, null, '1', null, null, null, null, TO_DATE('2015-01-19 14:33:57', 'YYYY-MM-DD HH24:MI:SS'), null, 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('22222', '看看', null, '3', '看看', '1', '444656454456', null, '15398765432', null, '额鹅鹅鹅', null, '5256256@qq.com', null, null, '1', null, null, null, null, TO_DATE('2015-01-20 11:12:56', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-03-25 10:24:34', 'YYYY-MM-DD HH24:MI:SS'), 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('33333', 'oak', null, '3', '5651', '1', '87687667678', null, '15365489677', null, '少时诵诗书', null, '156561561@qq.com', null, null, '1', null, null, null, null, TO_DATE('2015-01-20 11:13:58', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-03-25 10:24:03', 'YYYY-MM-DD HH24:MI:SS'), 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('66666', '222', null, '3', 'kk', '1', '564156145665', null, '15236525366', null, '卡卡卡卡', null, '545645656564@qq.com', null, null, '1', null, null, null, null, TO_DATE('2015-01-20 11:18:04', 'YYYY-MM-DD HH24:MI:SS'), null, 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('10000', '22', null, '3', '1235', '1', '846456465464', null, '15965489655', null, '444444', null, '5645641456@qq.com', null, null, '1', null, null, null, null, TO_DATE('2015-01-20 11:24:22', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-03-25 10:21:41', 'YYYY-MM-DD HH24:MI:SS'), 'N', null);
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('60600000100', '王家恩', null, '3', '王家恩', '1', '430421197509148077', null, '13093056808', null, '无锡', null, 'wje@yrdce.com', null, null, '1', null, null, null, null, TO_DATE('2015-03-31 19:22:31', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-08-18 13:59:54', 'YYYY-MM-DD HH24:MI:SS'), 'N', '61');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('606010003', '678', '678', '3', '678', '1', '430421198809148055', null, '13093056806', null, '无锡', null, 'wje@yrdce.com', 'WX', 'FDC', '-1', null, null, null, null, TO_DATE('2015-06-15 11:15:58', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-06-15 11:15:58', 'YYYY-MM-DD HH24:MI:SS'), 'N', '142');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('606010005', 'adsa', 'dsafdsaf', '3', 'dsafdas', '1', '321456987745896321', null, '18900129774', null, 'fdsafdasf', null, 'sadf@sina.cn', 'WX', 'CYY', '-1', null, null, null, null, TO_DATE('2015-06-15 14:37:26', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-06-15 14:37:26', 'YYYY-MM-DD HH24:MI:SS'), 'N', '145');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('000200002', '孙建萍', '孙建萍', '3', '孙建萍', '1', '321281198903081405', null, '15261580293', null, '江苏省无锡市高浪路999号', null, '1092343553@qq.com', 'WX', 'CYY', '-1', null, null, null, null, TO_DATE('2015-06-16 13:57:47', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-06-16 13:57:47', 'YYYY-MM-DD HH24:MI:SS'), 'N', '157');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('000301011', '王学志', '王学志', '3', '王学志', '1', '342523199609069116', '0563666666', '18256379293', '6666666', '安徽省广德县邱村', '666666', '546602015@qq.com', 'WX', 'FDC', '-1', null, null, null, null, TO_DATE('2015-06-23 09:04:37', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-06-23 09:04:37', 'YYYY-MM-DD HH24:MI:SS'), 'N', '165');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('000301012', '贾惠清', '贾惠清', '3', '贾惠清', '1', '130426199011071142', '15131544729', '15131544729', null, '河北省邯郸市涉县', '056400', '1719037849@qq.com', null, null, '-1', null, null, null, null, TO_DATE('2015-06-23 09:05:30', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-06-23 09:05:30', 'YYYY-MM-DD HH24:MI:SS'), 'N', '164');
INSERT INTO "TRADE_GNNT"."M_FIRM" VALUES ('HMR02', '黑木耳', null, '3', '黑木耳', '1', '232332197003080020', null, '18646517235', null, '黑龙江省绥化市', null, '2033211428@qq.com', null, null, '1', null, null, null, null, TO_DATE('2015-06-25 13:18:19', 'YYYY-MM-DD HH24:MI:SS'), null, 'N', null);

-- ----------------------------
-- Table structure for M_FIRM_APPLY
-- ----------------------------
DROP TABLE "TRADE_GNNT"."M_FIRM_APPLY";
CREATE TABLE "TRADE_GNNT"."M_FIRM_APPLY" (
"APPLYID" NUMBER(10) NOT NULL ,
"USERID" VARCHAR2(32 BYTE) NOT NULL ,
"PASSWORD" VARCHAR2(32 BYTE) NULL ,
"NAME" VARCHAR2(32 BYTE) NOT NULL ,
"FULLNAME" VARCHAR2(128 BYTE) NULL ,
"TYPE" NUMBER(2) NULL ,
"CONTACTMAN" VARCHAR2(32 BYTE) NULL ,
"CERTIFICATETYPE" NUMBER(2) NULL ,
"CERTIFICATENO" VARCHAR2(32 BYTE) NULL ,
"PHONE" VARCHAR2(32 BYTE) NULL ,
"MOBILE" NUMBER(12) NULL ,
"FAX" VARCHAR2(16 BYTE) NULL ,
"ADDRESS" VARCHAR2(128 BYTE) NULL ,
"POSTCODE" VARCHAR2(16 BYTE) NULL ,
"EMAIL" VARCHAR2(64 BYTE) NULL ,
"ZONECODE" VARCHAR2(16 BYTE) DEFAULT 'none'  NULL ,
"INDUSTRYCODE" VARCHAR2(16 BYTE) DEFAULT 'none'  NULL ,
"ORGANIZATIONCODE" VARCHAR2(9 BYTE) NULL ,
"CORPORATEREPRESENTATIVE" VARCHAR2(32 BYTE) NULL ,
"NOTE" VARCHAR2(1024 BYTE) NULL ,
"EXTENDDATA" VARCHAR2(4000 BYTE) NULL ,
"CREATETIME" DATE DEFAULT sysdate  NOT NULL ,
"MODIFYTIME" DATE NULL ,
"STATUS" NUMBER(1) DEFAULT 0  NOT NULL ,
"AUDITNOTE" VARCHAR2(256 BYTE) NULL ,
"BROKERID" VARCHAR2(32 BYTE) NULL ,
"PICTURE" BLOB NULL ,
"PICTURECS" BLOB NULL ,
"PICTUREOS" BLOB NULL ,
"YINGYEPIC" BLOB NULL ,
"SHUIWUPIC" BLOB NULL ,
"ZUZHIPIC" BLOB NULL ,
"KAIHUPIC" BLOB NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON COLUMN "TRADE_GNNT"."M_FIRM_APPLY"."TYPE" IS '1：法人
2：代理
3：个人';
COMMENT ON COLUMN "TRADE_GNNT"."M_FIRM_APPLY"."STATUS" IS '0：待审核
1：审核通过
2：审核不通过';

-- ----------------------------
-- Records of M_FIRM_APPLY
-- ----------------------------

-- ----------------------------
-- Table structure for M_FIRMCATEGORY
-- ----------------------------
DROP TABLE "TRADE_GNNT"."M_FIRMCATEGORY";
CREATE TABLE "TRADE_GNNT"."M_FIRMCATEGORY" (
"ID" NUMBER(10) NOT NULL ,
"NAME" VARCHAR2(128 BYTE) DEFAULT '未分类'  NOT NULL ,
"NOTE" VARCHAR2(128 BYTE) NULL ,
"ISVISIBAL" CHAR(1 BYTE) DEFAULT 'Y'  NOT NULL ,
"SORTNO" NUMBER(2) DEFAULT 0  NOT NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON COLUMN "TRADE_GNNT"."M_FIRMCATEGORY"."ISVISIBAL" IS 'Y 显示 N 不显示';

-- ----------------------------
-- Records of M_FIRMCATEGORY
-- ----------------------------
INSERT INTO "TRADE_GNNT"."M_FIRMCATEGORY" VALUES ('21', '白银贸易商', '白银贸易商', 'Y', '4');
INSERT INTO "TRADE_GNNT"."M_FIRMCATEGORY" VALUES ('1', '个人', '个人交易所', 'Y', '1');
INSERT INTO "TRADE_GNNT"."M_FIRMCATEGORY" VALUES ('2', '普通会员', '普通交易所会员', 'Y', '2');
INSERT INTO "TRADE_GNNT"."M_FIRMCATEGORY" VALUES ('3', '结算会员', '具有结算资格的会员', 'Y', '3');
INSERT INTO "TRADE_GNNT"."M_FIRMCATEGORY" VALUES ('41', '特别会员', null, 'Y', '11');
INSERT INTO "TRADE_GNNT"."M_FIRMCATEGORY" VALUES ('22', '白银供应商', '白银供应商', 'Y', '5');
INSERT INTO "TRADE_GNNT"."M_FIRMCATEGORY" VALUES ('23', '白银采购商', '白银采购商', 'Y', '6');

-- ----------------------------
-- Table structure for M_FIRMMODULE
-- ----------------------------
DROP TABLE "TRADE_GNNT"."M_FIRMMODULE";
CREATE TABLE "TRADE_GNNT"."M_FIRMMODULE" (
"MODULEID" NUMBER(2) NOT NULL ,
"FIRMID" VARCHAR2(32 BYTE) NOT NULL ,
"ENABLED" CHAR(1 BYTE) DEFAULT 'N'  NOT NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON TABLE "TRADE_GNNT"."M_FIRMMODULE" IS '交易商在各个交易模块是否可用';
COMMENT ON COLUMN "TRADE_GNNT"."M_FIRMMODULE"."MODULEID" IS '10综合管理平台
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
COMMENT ON COLUMN "TRADE_GNNT"."M_FIRMMODULE"."ENABLED" IS 'Y：启用  N：禁用';

-- ----------------------------
-- Records of M_FIRMMODULE
-- ----------------------------
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '10000', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '10000', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '10000', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '10000', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '10000', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '10000', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '10000', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '666', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '666', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '666', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '666', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '666', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '666', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '606010003', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '606010003', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '606010003', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '606010003', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '606010003', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '606010003', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '606010003', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '606010005', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '606010005', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '606010005', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '606010005', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '606010005', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '606010005', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '606010005', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '000200002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '000200002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '000200002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '000200002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '000200002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '000200002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '000200002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '000301011', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '000301011', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '000301011', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '000301011', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '000301011', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '000301011', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '000301011', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '000301012', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '000301012', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '000301012', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '000301012', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '000301012', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '000301012', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '000301012', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', 'HMR02', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', 'HMR02', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', 'HMR02', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', 'HMR02', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', 'HMR02', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', 'HMR02', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', 'HMR02', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', 'xh002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', 'xh002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', 'xh002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', 'xh002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', 'xh002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', 'xh002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', 'xh003', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', 'xh012', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', 'xh012', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', 'xh012', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', 'xh012', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', 'xh012', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', 'xh012', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', 'xh012', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', 'xh002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', 'xh003', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', 'xh003', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', 'xh003', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', 'xh003', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', 'xh003', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', 'xh003', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', 'xh014', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', 'xh014', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', 'xh014', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', 'xh014', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', 'xh014', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', 'xh014', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', 'xh014', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', 'jsb002', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', 'jsb002', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', 'jsb002', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', 'jsb002', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', 'jsb002', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', 'jsb002', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', 'jsb002', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', 'jsb003', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', 'jsb003', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', 'jsb003', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', 'jsb003', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', 'jsb003', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', 'jsb003', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', 'jsb003', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '607000008', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '607000008', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '607000008', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '607000008', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '607000008', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '607000008', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '607000008', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '607000009', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '607000009', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '607000009', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '607000009', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '607000009', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '607000009', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '607000009', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '000200007', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '000200007', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '000200007', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '000200007', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '000200007', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '000200007', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '000200007', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', 'PG001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', 'PG001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', 'PG001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', 'PG001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', 'PG001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', 'PG001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', 'PG001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '182', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '182', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '182', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '182', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '182', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '182', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '182', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', 'YXG', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', 'YXG', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', 'YXG', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', 'YXG', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', 'YXG', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', 'YXG', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', 'YXG', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '606000028', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '606000028', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '606000028', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '606000028', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '606000028', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '606000028', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '606000028', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '606000034', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '606000034', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '606000034', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '606000034', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '606000034', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '606000034', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '606000034', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '607000032', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '607000032', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '505000000000002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '505000000000002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '505000000000002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '505000000000002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '505000000000002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '607', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '607', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '607', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '607', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '607', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '505000000000003', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '505000000000003', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '505000000000003', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '505000000000003', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '505000000000003', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '008013', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '008013', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '008013', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '008013', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '008013', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '606010007', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '606010007', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '606010007', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '606010007', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '606010007', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '505000000000016', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '505000000000016', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '505000000000016', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '505000000000016', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '505000000000016', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '607', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '607', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', 'hyl', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', 'hyl', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', 'hyl', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '0002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '0002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '0002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '0002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '0002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '5050000000333', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '5050000000333', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '5050000000333', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '5050000000333', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '5050000000333', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '5050000000333', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '5050000000333', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', 'hyl', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', 'hyl', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', 'hyl', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', 'hyl', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '606010007', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '606010007', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '000200004', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '000200004', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '000200004', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '000200004', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '000200004', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '000200004', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '000200004', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', 'xh015', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', 'xh015', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', 'xh015', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', 'xh015', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', 'xh015', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', 'xh015', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', 'xh015', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', 'xh004', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', 'xh004', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', 'xh004', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', 'xh004', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', 'xh004', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', 'xh004', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', 'xh004', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', 'xh001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', 'xh001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', 'xh001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', 'xh001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', 'xh001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', 'xh001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', 'xh001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', 'xh005', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', 'xh005', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', 'xh005', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', 'xh005', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', 'xh005', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', 'xh005', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', 'xh005', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', 'xh006', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', 'xh006', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', 'xh006', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', 'xh006', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', 'xh006', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', 'xh006', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', 'xh006', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', 'xh007', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', 'xh007', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', 'xh007', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', 'xh007', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', 'xh007', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', 'xh007', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', 'xh007', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', 'xh008', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', 'xh008', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', 'xh008', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', 'xh008', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', 'xh008', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', 'xh008', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', 'xh008', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', 'xh009', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', 'xh009', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', 'xh009', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', 'xh009', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', 'xh009', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', 'xh009', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', 'xh009', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', 'xh010', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', 'xh010', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', 'xh010', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', 'xh010', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', 'xh010', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', 'xh010', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', 'xh010', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '606010014', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '606010014', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '606010014', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '606010014', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '606010014', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '606010014', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '606010014', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '607000003', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '607000003', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '607000003', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '607000003', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '607000003', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '607000003', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '607000003', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '606000017', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '606000017', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '606000017', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '606000017', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '606000017', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '606000017', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '606000017', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '606000018', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '606000018', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '606000018', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '606000018', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '606000018', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '606000018', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '606000018', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '606000019', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '606000019', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '606000019', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '606000019', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '606000019', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '606000019', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '606000019', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '606000021', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '606000021', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '606000021', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '606000021', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '606000021', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '606000021', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '606000021', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '002000002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '002000002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '002000002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '002000002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '002000002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '002000002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '002000002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', 'hy001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', 'hy001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', 'hy001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', 'hy001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', 'hy001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', 'hy001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', 'hy001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '60600000100', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '60600000100', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '60600000100', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '60600000100', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '60600000100', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '60600000100', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '60600000100', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '622000000', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '622000000', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '622000000', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '622000000', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '622000000', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '622000000', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '622000000', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '606000031', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '606000031', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '606000031', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '606000031', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '606000031', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '606000031', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '606000031', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '606000032', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '606000032', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '606000032', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '606000032', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '606000032', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '606000032', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '606000032', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '888', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '888', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '888', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '888', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '888', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('40', '888', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '888', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '6', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '6', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '6', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('40', '6', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '6', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '6', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '6', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', 'hl', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', 'hl', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', 'hl', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', 'hl', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', 'hl', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', 'hl', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '3', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '111', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '111', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '111', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '111', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '111', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '111', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '111', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '555555', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '555555', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '555555', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '555555', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '555555', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '555555', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '1', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '1', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '1', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '1', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('40', '1', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '1', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '1', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '2221', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('40', '222222', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '222222', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '222222', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '222222', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '222222', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '222222', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '222222', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '555555', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '2221', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '2221', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('40', '2221', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '2221', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '2221', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '2221', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('40', '666', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '0', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '0', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '0', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('40', '0', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '0', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '0', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '3', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '4', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '4', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '4', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '4', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '4', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '4', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '4', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '222', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '222', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '222', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '222', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '222', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '222', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '222', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '3', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('40', '3', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '3', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '3', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '3', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('40', '7', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', 'hl', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '7', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '7', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '7', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '7', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '7', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '7', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('40', '22', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '22', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '22', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '22', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '22', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '22', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '22', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '0', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '000', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '000', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '000', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '000', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('40', '000', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '000', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '000', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '888888', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '888888', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '888888', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '888888', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '888888', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('40', '888888', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '888888', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', 'a', '8');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', 'a', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', 'a', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('40', 'a', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', 'a', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', 'a', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', 'a', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '999999', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '999999', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '999999', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('40', '999999', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '999999', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '999999', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '999999', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', 'test66', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', 'test66', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', 'test66', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', 'test66', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', 'test66', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', 'test66', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', 'test66', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '608000123', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '608000123', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '608000123', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '608000123', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '608000123', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '608000123', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '608000123', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '99999', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '99999', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '99999', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '99999', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '99999', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '99999', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '99999', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '44444', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '44444', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '44444', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '44444', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '44444', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '44444', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '44444', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '33333', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '33333', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '33333', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '33333', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '33333', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '33333', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '33333', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '0001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '0001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '0001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '0001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '0001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '0001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '0001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', 'Shimo004', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', 'Shimo004', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', 'Shimo004', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', 'Shimo004', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', 'Shimo004', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', 'Shimo004', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', 'Shimo004', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', 'Shimo005', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', 'Shimo005', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', 'Shimo005', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', 'Shimo005', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', 'Shimo005', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', 'Shimo005', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', 'Shimo005', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '606000016', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '606000016', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '606000016', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '606000016', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '606000016', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '606000016', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '606000016', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '60600000180', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '60600000180', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '60600000180', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '60600000180', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '60600000180', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '60600000180', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '60600000180', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '112', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '112', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '112', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '112', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '112', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '112', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '112', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '601002022', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '601002022', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '601002022', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '601002022', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '601002022', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '601002022', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '601002022', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '607000024', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '607000024', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '607000024', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '607000024', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '607000024', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '607000024', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '607000024', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '60600000111', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '60600000111', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '60600000111', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '60600000111', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '60600000111', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '60600000111', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '60600000111', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '606010001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '606010001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '606010001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '606010001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '606010001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '606010001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '606010001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '606010004', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '606010004', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '606010004', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '606010004', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '606010004', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '606010004', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '606010004', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '606010006', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '606010006', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '606010006', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '606010006', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '606010006', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '606010006', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '606010006', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '606010008', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '606010008', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '606010008', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '606010008', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '606010008', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '606010008', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '606010008', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '606010010', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '606010010', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '606010010', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '606010010', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '606010010', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '606010010', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '606010010', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', 'HMR01', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', 'HMR01', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', 'HMR01', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', 'HMR01', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', 'HMR01', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', 'HMR01', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', 'HMR01', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '606000020', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '606000020', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '606000020', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '606000020', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '606000020', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '606000020', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '606000020', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '000200006', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '000200006', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '000200006', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '000200006', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '000200006', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '000200006', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '000200006', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '607000004', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '607000004', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '607000004', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '607000004', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '607000004', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '607000004', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '607000004', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '607000005', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '607000005', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '607000005', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '607000005', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '607000005', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '607000005', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '607000005', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '618000000', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '618000000', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '618000000', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '618000000', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '618000000', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '618000000', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '618000000', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '000200008', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '000200008', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '000200008', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '000200008', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '000200008', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '000200008', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '000200008', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '607000011', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '607000011', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '607000011', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '607000011', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '607000011', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '607000011', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '607000011', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '607000021', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '607000021', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '607000021', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '607000021', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '607000021', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '607000021', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '607000021', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '607000025', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '607000025', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '607000025', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '607000025', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '607000025', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '607000025', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '607000025', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '606000024', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '606000024', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '606000024', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '606000024', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '606000024', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '606000024', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '606000024', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '607000026', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '607000026', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '607000026', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '607000026', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '607000026', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '607000026', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '607000026', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '607000027', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '607000027', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '607000027', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '607000027', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '607000027', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '607000027', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '607000027', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '607000028', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '607000028', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '607000028', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '607000028', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '607000028', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '607000028', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '607000028', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '607000029', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '607000029', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '607000029', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '607000029', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '607000029', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '607000029', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '607000029', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '606000026', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '606000026', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '606000026', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '606000026', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '606000026', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '606000026', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '606000026', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '606000027', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '606000027', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '606000027', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '606000027', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '606000027', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '606000027', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '606000027', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '606000029', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '606000029', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '606000029', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '606000029', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '606000029', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '606000029', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '606000029', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '60600000110', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '60600000110', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '60600000110', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '60600000110', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '60600000110', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '505000000000007', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '505000000000007', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '505000000000007', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '505000000000007', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '505000000000007', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '505000000000005', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '505000000000005', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '505000000000005', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '505000000000005', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '505000000000005', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '126000000000108', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '126000000000108', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '126000000000108', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '126000000000108', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '126000000000108', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '008', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '008013', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '126000000000108', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '505000000000002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '505000000000003', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '601010002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '601010002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '601010002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '601010002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '601010002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '505000000000108', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '505000000000108', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '505000000000108', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '505000000000108', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '505000000000108', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '505000000000006', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '505000000000006', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '505000000000006', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '505000000000006', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '505000000000006', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '55555', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '55555', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '55555', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '55555', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '55555', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '77777', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '77777', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '77777', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '77777', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '77777', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '11111', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '11111', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '11111', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '11111', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '11111', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '505000000000006', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '88888', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '88888', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '88888', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '88888', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '505000000000006', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '88888', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '88888', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '88888', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '11111', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '11111', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '22222', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '22222', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '22222', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '22222', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '22222', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '22222', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '22222', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '00030101', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '00030101', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '00030101', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '00030101', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '00030101', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '00030101', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '00030101', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '0002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '505000000000004', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '505000000000005', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '505000000000007', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '505000000000008', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '60600000110', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '505000000000012', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '505000000000016', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '505000000000088', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '505000000000089', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '50500000000009', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '505000000000090', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '505000000000091', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '505000000000092', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '505000000000108', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '505000000000110', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '55555', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '601010002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '606', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '66666', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '77777', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', 'test1', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '0002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '008', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '008013', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '126000000000108', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '505000000000002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '505000000000003', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '505000000000004', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '505000000000005', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '505000000000007', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '505000000000008', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '60600000110', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '505000000000012', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '505000000000016', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '505000000000088', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '505000000000089', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '50500000000009', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '505000000000090', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '505000000000091', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '505000000000092', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '505000000000108', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '505000000000110', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '55555', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '601010002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '606', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '66666', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '77777', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', 'test1', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '606000014', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '606000014', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '606000014', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '606000014', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '606000014', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '606000014', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '606000014', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '607000001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '607000001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '607000001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '607000001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '607000001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '607000001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '607000001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', 'Shimo001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', 'Shimo001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', 'Shimo001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', 'Shimo001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', 'Shimo001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', 'Shimo001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', 'Shimo001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', 'Shimo002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', 'Shimo002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', 'Shimo002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', 'Shimo002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', 'Shimo002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', 'Shimo002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', 'Shimo002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', 'Shimo003', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', 'Shimo003', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', 'Shimo003', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', 'Shimo003', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', 'Shimo003', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', 'Shimo003', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', 'Shimo003', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '50500000100', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '50500000100', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '50500000100', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '50500000100', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '50500000100', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '50500000100', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '50500000100', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '606010000', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '606010000', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '606010000', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '606010000', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '606010000', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '606010000', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '606010000', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '606000001', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '606000001', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '606000001', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '606000001', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '606000001', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '606000001', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '606000001', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '606000002', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '606000002', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '606000002', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '606000002', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '606000002', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '606000002', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '606000002', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '606000008', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '606000008', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '606000008', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '606000008', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '606000008', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '606000008', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '606000008', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '606010009', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '606010009', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '606010009', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '606010009', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '606010009', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '606010009', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '606010009', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '000210341', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '000210341', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '000210341', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '000210341', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '000210341', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '000210341', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '000210341', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '606000012', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '606000012', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '606000012', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '606000012', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '606000012', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '606000012', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '606000012', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '606000013', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '606000013', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '606000013', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '606000013', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '606000013', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '606000013', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '606000013', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '606010013', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '606010013', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '606010013', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '606010013', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '606010013', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '606010013', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '606010013', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '607020001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '607020001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '607020001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '607020001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '607020001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '607020001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '607020001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '607000002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '607000002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '607000002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '607000002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '607000002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '607000002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '607000002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '607000006', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '607000006', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '607000006', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '607000006', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '607000006', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '607000006', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '607000006', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '607000007', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '607000007', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '607000007', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '607000007', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '607000007', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '607000007', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '607000007', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '609000000', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '609000000', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '609000000', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '609000000', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '609000000', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '609000000', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '609000000', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '101000005000579', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '101000005000579', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '101000005000579', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '101000005000579', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '101000005000579', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '101000005000579', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '101000005000579', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', 'h1', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', 'h1', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', 'h1', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', 'h1', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', 'h1', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', 'h1', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', 'h1', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', 'ceshi1', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', 'ceshi1', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', 'ceshi1', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', 'ceshi1', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', 'ceshi1', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', 'ceshi1', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', 'ceshi1', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '777777', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '777777', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '777777', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '777777', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '777777', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '777777', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '607000018', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '607000018', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '607000018', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '607000018', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '607000018', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '607000018', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '607000018', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '777777', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '50500000000009', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '50500000000009', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '50500000000009', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '50500000000009', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '50500000000009', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '008', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '008', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '008', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '008', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '008', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '601010001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '601010001', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '601010001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '601010001', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '601010001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '505000000000089', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '505000000000089', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '505000000000089', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '505000000000089', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '505000000000089', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '505000000000088', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '505000000000088', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '505000000000088', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '505000000000088', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '505000000000088', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '601010001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '601010001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', 'xh011', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', 'xh011', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', 'xh011', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '606', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '606', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '606', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '606', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '606', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '505000000000001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '505000000000001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '505000000000001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '505000000000001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '505000000000001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '505000000000001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '505000000000001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', 'xh011', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', 'xh011', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', 'xh011', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', 'xh011', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '607010001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '607010001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '607010001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '607010001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '607010001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '607010001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '607010001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '607020002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '607020002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '607020002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '607020002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '607020002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '607020002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '607020002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '607010002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '607010002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '607010002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '607010002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '607010002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '607010002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '607010002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '606000015', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '606000015', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '606000015', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '606000015', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '606000015', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '606000015', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '606000015', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '020000001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '020000001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '020000001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '020000001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '020000001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '020000001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '020000001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '505000000000010', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '505000000000010', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '505000000000010', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '505000000000010', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '505000000000010', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '505000000000010', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '505000000000010', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '606010002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '606010002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '606010002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '606010002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '606010002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '606010002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '606010002', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '000200001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '000200001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '000200001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '000200001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '000200001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '000200001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '000200001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', 'xh013', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', 'xh013', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', 'xh013', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', 'xh013', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', 'xh013', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', 'xh013', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '606010015', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '606000011', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '606000011', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '606000011', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '606000011', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '606000011', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '606000011', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '606000011', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '000200003', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '000200003', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '000200003', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '000200003', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '000200003', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '000200003', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '000200003', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '606010012', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '606010012', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '606010012', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '606010012', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '606010012', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '606010012', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '606010012', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '444', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '444', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '444', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '444', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '444', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '444', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '444', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '505000000000105', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '505000000000105', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '505000000000105', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '505000000000105', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '505000000000105', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '505000000000105', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '505000000000105', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '000301013', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '000301013', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '000301013', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '000301013', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '000301013', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '000301013', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '000301013', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '606000009', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '606000009', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '606000009', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '606000009', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '606000009', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '606000009', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '606000009', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', 'xh013', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '606010015', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '606010015', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '606010015', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '606010015', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '606010015', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '606010015', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '002000001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '002000001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '002000001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '002000001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '002000001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '002000001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '002000001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '000200005', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '000200005', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '000200005', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '000200005', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '000200005', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '000200005', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '000200005', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '000100001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '000100001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '000100001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '000100001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '000100001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '000100001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '000100001', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '002000003', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '002000003', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '002000003', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '002000003', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '002000003', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '002000003', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '002000003', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '607000010', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '607000010', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '607000010', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '607000010', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '607000010', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '607000010', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '607000010', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '606000022', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '606000022', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '606000022', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '606000022', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '606000022', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '606000022', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '606000022', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '183', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '183', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '183', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '183', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '183', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '183', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '183', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', 'h2', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', 'h2', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', 'h2', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', 'h2', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', 'h2', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', 'h2', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', 'h2', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '607000012', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '607000012', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '607000012', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '607000012', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '607000012', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '607000012', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '607000012', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '607000019', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '607000019', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '607000019', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '607000019', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '607000019', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '607000019', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '607000019', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '607000020', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '607000020', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '607000020', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '607000020', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '607000020', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '607000020', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '607000020', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '000200009', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '000200009', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '000200009', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '000200009', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '000200009', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '000200009', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '000200009', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '606000023', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '606000023', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '606000023', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '606000023', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '606000023', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '606000023', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '606000023', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '607000022', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '607000022', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '607000022', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '607000022', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '607000022', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '607000022', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '607000022', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '607000023', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '607000023', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '607000023', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '607000023', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '607000023', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '607000023', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '607000023', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '111111', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '111111', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '111111', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '111111', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '111111', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '111111', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '111111', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '607000032', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '606000025', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '606000025', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '606000025', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '606000025', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '606000025', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '606000025', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '606000025', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '606000033', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '606000033', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '606000033', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '606000033', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '606000033', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '606000033', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '606000033', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '607000030', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '607000030', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '607000030', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '607000030', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '607000030', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '607000030', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '607000030', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '606000030', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '606000030', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '606000030', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '606000030', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '606000030', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '606000030', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '606000030', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '607000031', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '607000031', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '607000031', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '607000031', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '607000031', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '607000031', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '607000031', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '607000032', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '607000032', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '607000032', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '607000032', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '505000000000008', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '505000000000008', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '505000000000008', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '505000000000008', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '505000000000008', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '505000000000012', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '505000000000012', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '505000000000012', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '505000000000012', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '505000000000012', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', 'test1', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', 'test1', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', 'test1', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', 'test1', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', 'test1', 'N');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '505000000000110', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '505000000000110', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '505000000000110', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '505000000000110', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '505000000000110', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '505000000000004', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '505000000000004', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '505000000000004', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '505000000000004', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '505000000000004', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '505000000000090', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '505000000000090', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '505000000000090', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '505000000000090', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '505000000000090', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '505000000000091', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '505000000000091', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '505000000000091', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '505000000000091', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '505000000000091', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '505000000000092', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '505000000000092', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '505000000000092', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '505000000000092', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '505000000000092', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '608000333', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '608000333', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '608000333', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '608000333', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('23', '608000333', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('10', '66666', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('28', '66666', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('15', '66666', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '66666', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('11', '66666', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('13', '608000333', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '608000333', 'Y');
INSERT INTO "TRADE_GNNT"."M_FIRMMODULE" VALUES ('21', '666', 'Y');

-- ----------------------------
-- Table structure for M_INDUSTRY
-- ----------------------------
DROP TABLE "TRADE_GNNT"."M_INDUSTRY";
CREATE TABLE "TRADE_GNNT"."M_INDUSTRY" (
"CODE" VARCHAR2(16 BYTE) NOT NULL ,
"NAME" VARCHAR2(32 BYTE) NOT NULL ,
"ISVISIBAL" CHAR(1 BYTE) DEFAULT 'Y'  NOT NULL ,
"SORTNO" NUMBER(2) DEFAULT 0  NOT NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON COLUMN "TRADE_GNNT"."M_INDUSTRY"."ISVISIBAL" IS 'Y 显示 N 不显示';

-- ----------------------------
-- Records of M_INDUSTRY
-- ----------------------------
INSERT INTO "TRADE_GNNT"."M_INDUSTRY" VALUES ('JR', '金融', 'Y', '3');
INSERT INTO "TRADE_GNNT"."M_INDUSTRY" VALUES ('CYY', '餐饮业', 'Y', '1');
INSERT INTO "TRADE_GNNT"."M_INDUSTRY" VALUES ('FDC', '房地产', 'Y', '2');

-- ----------------------------
-- Table structure for M_MESSAGE
-- ----------------------------
DROP TABLE "TRADE_GNNT"."M_MESSAGE";
CREATE TABLE "TRADE_GNNT"."M_MESSAGE" (
"MESSAGEID" NUMBER(10) NOT NULL ,
"MESSAGE" VARCHAR2(256 BYTE) NOT NULL ,
"RECIEVERTYPE" NUMBER(2) NOT NULL ,
"TRADERID" VARCHAR2(40 BYTE) NULL ,
"CREATETIME" DATE NULL ,
"USERID" VARCHAR2(32 BYTE) NOT NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON COLUMN "TRADE_GNNT"."M_MESSAGE"."RECIEVERTYPE" IS '接收人类型：1 在线交易员 2 在线管理员 3 在线用户 4 指定交易员 5 指定管理员';
COMMENT ON COLUMN "TRADE_GNNT"."M_MESSAGE"."USERID" IS '管理员Id';

-- ----------------------------
-- Records of M_MESSAGE
-- ----------------------------

-- ----------------------------
-- Table structure for M_NOTICE
-- ----------------------------
DROP TABLE "TRADE_GNNT"."M_NOTICE";
CREATE TABLE "TRADE_GNNT"."M_NOTICE" (
"NOTICEID" NUMBER(10) NOT NULL ,
"TITLE" VARCHAR2(64 BYTE) NOT NULL ,
"CONTENT" VARCHAR2(4000 BYTE) NULL ,
"CREATETIME" DATE NULL ,
"USERID" VARCHAR2(32 BYTE) NOT NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON COLUMN "TRADE_GNNT"."M_NOTICE"."USERID" IS '管理员Id';

-- ----------------------------
-- Records of M_NOTICE
-- ----------------------------
INSERT INTO "TRADE_GNNT"."M_NOTICE" VALUES ('21', '关于劳动节放假休市的通知', '尊敬的各授权服务机构（会员）及交易商、指定交收仓库：
2015年5月1日（星期五）到2015年5月3日（星期日）为五一国际劳动节，根据《国务院办公厅2015年部分节假日安排的通知》精神，长三角商品交易所研究决定，现货挂牌2015年国际劳动节放假休市安排如下：
1、2015年4月30日（星期四）为劳动节前最后交易日；
2、2015年5月1日（星期五）至2015年5月3日（星期日）为国际劳动节放假休市；
3、2015年5月4日（星期一）正常开市。
特此公告!
 

长三角商品交易所有限公司
二〇一五年四月二十七日
', TO_DATE('2015-04-27 15:24:39', 'YYYY-MM-DD HH24:MI:SS'), 'cc');
INSERT INTO "TRADE_GNNT"."M_NOTICE" VALUES ('41', '9.3放假通知', '........................', TO_DATE('2015-08-24 10:13:52', 'YYYY-MM-DD HH24:MI:SS'), 'cd');

-- ----------------------------
-- Table structure for M_PROCEDURES_ERRORCODE
-- ----------------------------
DROP TABLE "TRADE_GNNT"."M_PROCEDURES_ERRORCODE";
CREATE TABLE "TRADE_GNNT"."M_PROCEDURES_ERRORCODE" (
"MODULEID" NUMBER(2) NOT NULL ,
"ERRORCODE" NUMBER(12) NOT NULL ,
"ERRORINFO" VARCHAR2(1024 BYTE) NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON TABLE "TRADE_GNNT"."M_PROCEDURES_ERRORCODE" IS '交易商添加修改删除存储的错误码记录';
COMMENT ON COLUMN "TRADE_GNNT"."M_PROCEDURES_ERRORCODE"."MODULEID" IS '10综合管理平台
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

-- ----------------------------
-- Records of M_PROCEDURES_ERRORCODE
-- ----------------------------
INSERT INTO "TRADE_GNNT"."M_PROCEDURES_ERRORCODE" VALUES ('10', '-900', '交易商不存在');
INSERT INTO "TRADE_GNNT"."M_PROCEDURES_ERRORCODE" VALUES ('11', '-901', '交易商资金不为0');
INSERT INTO "TRADE_GNNT"."M_PROCEDURES_ERRORCODE" VALUES ('13', '-130', '交易商有可用的仓单');
INSERT INTO "TRADE_GNNT"."M_PROCEDURES_ERRORCODE" VALUES ('28', '-1', '交易商有与银行签约信息');
INSERT INTO "TRADE_GNNT"."M_PROCEDURES_ERRORCODE" VALUES ('23', '-230', '交易商有未结束的委托');
INSERT INTO "TRADE_GNNT"."M_PROCEDURES_ERRORCODE" VALUES ('23', '-231', '交易商有未结束的合同');
INSERT INTO "TRADE_GNNT"."M_PROCEDURES_ERRORCODE" VALUES ('23', '-232', '交易商有未答复的议价');
INSERT INTO "TRADE_GNNT"."M_PROCEDURES_ERRORCODE" VALUES ('23', '-233', '交易商保证金不为0');
INSERT INTO "TRADE_GNNT"."M_PROCEDURES_ERRORCODE" VALUES ('23', '-234', '交易商货款不为0');
INSERT INTO "TRADE_GNNT"."M_PROCEDURES_ERRORCODE" VALUES ('23', '-235', '交易商转出金额不为0');
INSERT INTO "TRADE_GNNT"."M_PROCEDURES_ERRORCODE" VALUES ('23', '-236', '交易商诚信金不为0');

-- ----------------------------
-- Table structure for M_PROPERTY
-- ----------------------------
DROP TABLE "TRADE_GNNT"."M_PROPERTY";
CREATE TABLE "TRADE_GNNT"."M_PROPERTY" (
"PROPERTYID" NUMBER(10) NOT NULL ,
"CATEGORYID" NUMBER(10) NOT NULL ,
"PROPERTYNAME" VARCHAR2(64 BYTE) NOT NULL ,
"HASVALUEDICT" CHAR(1 BYTE) NOT NULL ,
"STOCKCHECK" CHAR(1 BYTE) NOT NULL ,
"SEARCHABLE" CHAR(1 BYTE) NOT NULL ,
"SORTNO" NUMBER(10) NOT NULL ,
"ISNECESSARY" CHAR(1 BYTE) DEFAULT 'Y'  NOT NULL ,
"FIELDTYPE" NUMBER(2) DEFAULT 0  NOT NULL ,
"PROPERTYTYPEID" NUMBER(15) NOT NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON COLUMN "TRADE_GNNT"."M_PROPERTY"."HASVALUEDICT" IS 'Y：有值字典  N：无值字典';
COMMENT ON COLUMN "TRADE_GNNT"."M_PROPERTY"."STOCKCHECK" IS 'Y：检查  N：不检查 M：不完全检查(选择多个值，匹配其中之一)';
COMMENT ON COLUMN "TRADE_GNNT"."M_PROPERTY"."SEARCHABLE" IS 'Y：用于列表搜索 N：不用于搜索';
COMMENT ON COLUMN "TRADE_GNNT"."M_PROPERTY"."ISNECESSARY" IS 'Y：必填项；N：选填项';
COMMENT ON COLUMN "TRADE_GNNT"."M_PROPERTY"."FIELDTYPE" IS '0：字符串；1：数字';

-- ----------------------------
-- Records of M_PROPERTY
-- ----------------------------
INSERT INTO "TRADE_GNNT"."M_PROPERTY" VALUES ('1160', '1140', '品质', 'Y', 'Y', 'Y', '1', 'Y', '0', '2');
INSERT INTO "TRADE_GNNT"."M_PROPERTY" VALUES ('1060', '1041', '产地', 'Y', 'Y', 'Y', '1', 'Y', '0', '1');
INSERT INTO "TRADE_GNNT"."M_PROPERTY" VALUES ('1006', '1005', '品牌', 'Y', 'N', 'Y', '2', 'Y', '0', '1');
INSERT INTO "TRADE_GNNT"."M_PROPERTY" VALUES ('1040', '1008', '产地', 'Y', 'Y', 'Y', '1100', 'Y', '0', '1');
INSERT INTO "TRADE_GNNT"."M_PROPERTY" VALUES ('1041', '1008', '品牌', 'Y', 'Y', 'Y', '1110', 'Y', '0', '1');
INSERT INTO "TRADE_GNNT"."M_PROPERTY" VALUES ('1061', '1041', '等级', 'Y', 'Y', 'Y', '2', 'Y', '0', '2');
INSERT INTO "TRADE_GNNT"."M_PROPERTY" VALUES ('1062', '1042', '产地', 'Y', 'Y', 'Y', '1', 'Y', '0', '1');
INSERT INTO "TRADE_GNNT"."M_PROPERTY" VALUES ('1064', '1042', '质量指标', 'Y', 'Y', 'Y', '3', 'Y', '0', '2');
INSERT INTO "TRADE_GNNT"."M_PROPERTY" VALUES ('1065', '1043', '产地', 'Y', 'Y', 'Y', '1', 'Y', '0', '1');
INSERT INTO "TRADE_GNNT"."M_PROPERTY" VALUES ('1066', '1043', '质量指标', 'Y', 'Y', 'Y', '3', 'Y', '0', '2');
INSERT INTO "TRADE_GNNT"."M_PROPERTY" VALUES ('1067', '1043', '品牌', 'Y', 'Y', 'Y', '2', 'Y', '0', '120');
INSERT INTO "TRADE_GNNT"."M_PROPERTY" VALUES ('1069', '1044', '品牌', 'Y', 'Y', 'Y', '2', 'Y', '0', '120');
INSERT INTO "TRADE_GNNT"."M_PROPERTY" VALUES ('1070', '1044', '质量指标', 'Y', 'Y', 'Y', '3', 'Y', '0', '2');
INSERT INTO "TRADE_GNNT"."M_PROPERTY" VALUES ('1081', '1008', '交收属性', 'Y', 'M', 'Y', '4', 'Y', '0', '1');
INSERT INTO "TRADE_GNNT"."M_PROPERTY" VALUES ('1101', '1060', '品牌', 'Y', 'Y', 'Y', '2', 'Y', '0', '120');
INSERT INTO "TRADE_GNNT"."M_PROPERTY" VALUES ('1100', '1060', '质量等级', 'N', 'N', 'N', '1', 'N', '0', '2');
INSERT INTO "TRADE_GNNT"."M_PROPERTY" VALUES ('1102', '1060', '规格', 'Y', 'Y', 'Y', '3', 'Y', '0', '1');
INSERT INTO "TRADE_GNNT"."M_PROPERTY" VALUES ('1120', '1081', '钻石', 'Y', 'Y', 'Y', '1', 'Y', '0', '1');
INSERT INTO "TRADE_GNNT"."M_PROPERTY" VALUES ('1121', '1081', '克拉', 'Y', 'Y', 'Y', '2', 'Y', '0', '2');
INSERT INTO "TRADE_GNNT"."M_PROPERTY" VALUES ('1122', '1081', '铂金', 'Y', 'Y', 'Y', '3', 'Y', '0', '120');
INSERT INTO "TRADE_GNNT"."M_PROPERTY" VALUES ('1004', '1001', '拉升系数', 'Y', 'Y', 'Y', '4', 'Y', '0', '2');
INSERT INTO "TRADE_GNNT"."M_PROPERTY" VALUES ('1001', '1001', '产地', 'Y', 'Y', 'Y', '1', 'Y', '0', '1');
INSERT INTO "TRADE_GNNT"."M_PROPERTY" VALUES ('1002', '1001', '标准', 'Y', 'Y', 'Y', '2', 'Y', '0', '2');
INSERT INTO "TRADE_GNNT"."M_PROPERTY" VALUES ('1003', '1001', '产品颜色', 'Y', 'Y', 'Y', '3', 'Y', '0', '1');
INSERT INTO "TRADE_GNNT"."M_PROPERTY" VALUES ('1005', '1005', '产地', 'Y', 'N', 'Y', '1', 'Y', '0', '1');
INSERT INTO "TRADE_GNNT"."M_PROPERTY" VALUES ('1020', '1004', '品牌', 'Y', 'Y', 'Y', '1', 'Y', '0', '1');
INSERT INTO "TRADE_GNNT"."M_PROPERTY" VALUES ('1063', '1042', '品牌', 'Y', 'Y', 'Y', '2', 'Y', '0', '120');
INSERT INTO "TRADE_GNNT"."M_PROPERTY" VALUES ('1068', '1044', '产地', 'Y', 'Y', 'Y', '1', 'Y', '0', '1');
INSERT INTO "TRADE_GNNT"."M_PROPERTY" VALUES ('1080', '1008', '质量等级', 'Y', 'Y', 'Y', '3', 'Y', '0', '2');

-- ----------------------------
-- Table structure for M_PROPERTYTYPE
-- ----------------------------
DROP TABLE "TRADE_GNNT"."M_PROPERTYTYPE";
CREATE TABLE "TRADE_GNNT"."M_PROPERTYTYPE" (
"PROPERTYTYPEID" NUMBER(15) NOT NULL ,
"NAME" VARCHAR2(64 BYTE) NOT NULL ,
"STATUS" NUMBER(2) DEFAULT 0  NOT NULL ,
"SORTNO" NUMBER(2) NOT NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON COLUMN "TRADE_GNNT"."M_PROPERTYTYPE"."STATUS" IS '0 可见 1 不可见';

-- ----------------------------
-- Records of M_PROPERTYTYPE
-- ----------------------------
INSERT INTO "TRADE_GNNT"."M_PROPERTYTYPE" VALUES ('141', '小型张', '0', '11');
INSERT INTO "TRADE_GNNT"."M_PROPERTYTYPE" VALUES ('1', '基本属性', '0', '1');
INSERT INTO "TRADE_GNNT"."M_PROPERTYTYPE" VALUES ('2', '质量指标', '0', '2');
INSERT INTO "TRADE_GNNT"."M_PROPERTYTYPE" VALUES ('120', '品牌', '0', '3');
INSERT INTO "TRADE_GNNT"."M_PROPERTYTYPE" VALUES ('140', '单张', '0', '10');

-- ----------------------------
-- Table structure for M_SYSTEMPROPS
-- ----------------------------
DROP TABLE "TRADE_GNNT"."M_SYSTEMPROPS";
CREATE TABLE "TRADE_GNNT"."M_SYSTEMPROPS" (
"KEY" VARCHAR2(32 BYTE) NOT NULL ,
"VALUE" VARCHAR2(64 BYTE) NOT NULL ,
"RUNTIMEVALUE" VARCHAR2(64 BYTE) NULL ,
"NOTE" VARCHAR2(128 BYTE) NULL ,
"FIRMIDLENGTH" VARCHAR2(32 BYTE) DEFAULT '15'  NOT NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON COLUMN "TRADE_GNNT"."M_SYSTEMPROPS"."VALUE" IS '手续费、保证金等参数设置';

-- ----------------------------
-- Records of M_SYSTEMPROPS
-- ----------------------------
INSERT INTO "TRADE_GNNT"."M_SYSTEMPROPS" VALUES ('Offset', '1.0000', '1.0000', '损益比例上限', '15');

-- ----------------------------
-- Table structure for M_TRADER
-- ----------------------------
DROP TABLE "TRADE_GNNT"."M_TRADER";
CREATE TABLE "TRADE_GNNT"."M_TRADER" (
"TRADERID" VARCHAR2(40 BYTE) NOT NULL ,
"FIRMID" VARCHAR2(32 BYTE) NOT NULL ,
"NAME" VARCHAR2(32 BYTE) NOT NULL ,
"USERID" VARCHAR2(32 BYTE) NULL ,
"PASSWORD" VARCHAR2(32 BYTE) NOT NULL ,
"FORCECHANGEPWD" NUMBER(1) DEFAULT 1  NOT NULL ,
"STATUS" CHAR(1 BYTE) DEFAULT 'N'  NOT NULL ,
"TYPE" CHAR(1 BYTE) NOT NULL ,
"CREATETIME" DATE DEFAULT sysdate  NULL ,
"MODIFYTIME" DATE NULL ,
"KEYCODE" VARCHAR2(32 BYTE) NULL ,
"ENABLEKEY" CHAR(1 BYTE) NOT NULL ,
"TRUSTKEY" VARCHAR2(64 BYTE) NULL ,
"LASTIP" VARCHAR2(16 BYTE) NULL ,
"LASTTIME" DATE NULL ,
"SKIN" VARCHAR2(16 BYTE) DEFAULT 'default'  NOT NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON TABLE "TRADE_GNNT"."M_TRADER" IS '交易员表，每个交易商有个与交易商ID相同的交易员作为默认交易员，不可删除。';
COMMENT ON COLUMN "TRADE_GNNT"."M_TRADER"."FORCECHANGEPWD" IS '0：否
1：是';
COMMENT ON COLUMN "TRADE_GNNT"."M_TRADER"."STATUS" IS 'N：正常 Normal
D：禁用 Disable';
COMMENT ON COLUMN "TRADE_GNNT"."M_TRADER"."TYPE" IS 'A：管理员
N：一般交易员';
COMMENT ON COLUMN "TRADE_GNNT"."M_TRADER"."MODIFYTIME" IS '最后一次修改时间';
COMMENT ON COLUMN "TRADE_GNNT"."M_TRADER"."ENABLEKEY" IS 'Y：启用
N：不启用';
COMMENT ON COLUMN "TRADE_GNNT"."M_TRADER"."TRUSTKEY" IS '客户端登录成功后，在本地和服务端记录一个信任Key，不限制重试次数。';

-- ----------------------------
-- Records of M_TRADER
-- ----------------------------
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('h1', 'h1', 'h1', 'h1', '8dc2fd3b75746ff77654d6c377fd515b', '1', 'D', 'A', TO_DATE('2015-08-27 16:13:07', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-08-27 16:13:07', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '20150902105439867h128491.752869960375', '182.150.28.133', TO_DATE('2015-09-02 10:54:39', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('505000000000001', '505000000000001', '505000000000001', '505000000000001', '4df3d8b454fd23c2c8f6453d8252075e', '0', 'N', 'A', TO_DATE('2014-11-11 13:43:23', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-03-06 09:05:00', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '201506191050562415050000000000011114.863545440703', '58.215.28.94', TO_DATE('2015-06-19 10:50:56', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('0081', '008', '张永祥', 'zyx1', 'e8410caef68fd60495965d8d61453165', '1', 'D', 'N', TO_DATE('2014-12-12 01:02:19', 'YYYY-MM-DD HH24:MI:SS'), null, '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('5050000000000010', '505000000000001', '张小哥', '505000000000008', '1647f02d4830f7e827898d005cd331ec', '1', 'N', 'N', TO_DATE('2014-12-12 01:06:59', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-03-26 10:55:47', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('505000000000008', '505000000000008', '505000000000008', 'cj', 'ced4906b0638cbf74c9bc427a5786a6f', '1', 'N', 'A', TO_DATE('2014-12-12 10:13:59', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-03-25 09:20:13', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '2015082109560768750500000000000892072.09669342387', '58.215.28.94', TO_DATE('2015-08-21 09:56:07', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('00812', '008', 'lvtiancai', 'lvtc', 'cbf04dc724ae174507982a15e941740d', '1', 'N', 'N', TO_DATE('2014-12-25 07:34:05', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-12-29 11:02:57', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('test1', 'test1', 'test1', 'test1', '4a3252a5edf8fcaa8bde0bfcce79560d', '1', 'N', 'A', TO_DATE('2014-12-25 08:31:49', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-12-25 08:31:49', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '2015021420435823test162221.82192077365', '49.80.195.216', TO_DATE('2015-02-14 20:43:58', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('505000000000110', '505000000000110', '505000000000110', 'zhuwei', 'bf824301ecf987ded8b3858a91969f27', '1', 'N', 'A', TO_DATE('2014-12-25 11:26:36', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-12-25 11:26:36', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '2015040208474875250500000000011080425.52070269776', '58.215.28.94', TO_DATE('2015-04-02 08:47:48', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('505000000000004', '505000000000004', '505000000000004', '王上博', '004c875ddb3c8773ecb0824b490562b3', '1', 'N', 'A', TO_DATE('2014-12-25 11:38:11', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-12-25 11:38:11', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '2014123108450974250500000000000433118.75030420348', '58.215.28.94', TO_DATE('2014-12-31 08:45:09', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('505000000000090', '505000000000090', '505000000000090', '泡泡', 'b8e58929d9ad4ca1148f98caf7690f6f', '1', 'N', 'A', TO_DATE('2015-01-19 14:31:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-01-19 14:31:00', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('505000000000091', '505000000000091', '505000000000091', '打打', 'd973d4f9c47d10b0fcbe17becbd23402', '1', 'N', 'A', TO_DATE('2015-01-19 14:32:29', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-01-19 14:32:29', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('505000000000092', '505000000000092', '505000000000092', '哈哈', '30daf20ba900a80dc9d7f56793a2ae4c', '1', 'N', 'A', TO_DATE('2015-01-19 14:33:57', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-01-19 14:33:57', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '2015011914354076550500000000009225425.795281909035', '58.215.28.94', TO_DATE('2015-01-19 14:35:40', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('22222', '22222', '22222', '快快快', '12789474bb1349b42976821faa11f9a2', '1', 'N', 'A', TO_DATE('2015-01-20 11:12:56', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-01-20 11:12:56', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '201504092114265262222265765.56306158334', '180.113.16.112', TO_DATE('2015-04-09 21:14:25', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('33333', '33333', '33333', '啦', '49c138f0b16f4a0551a6d902296bdb9e', '1', 'N', 'A', TO_DATE('2015-01-20 11:13:58', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-01-20 11:13:58', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '201504130934499433333327764.724567144705', '120.195.154.68', TO_DATE('2015-04-13 09:34:49', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('66666', '66666', '66666', '122', 'dcf9c0e2f4e2dcd2c55a13ec0336c804', '1', 'N', 'A', TO_DATE('2015-01-20 11:18:05', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-01-20 11:18:05', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '201503262105234336666634023.19357935037', '115.238.240.153', TO_DATE('2015-03-26 21:05:22', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('10000', '10000', '10000', '22', '058f403c565f4583ac8e7d45433111bf', '1', 'N', 'A', TO_DATE('2015-01-20 11:24:22', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-01-20 11:24:22', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '20150326204612381000075730.47940327931', '115.238.240.153', TO_DATE('2015-03-26 20:46:12', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('60600000100', '60600000100', '60600000100', 'wangjiaen', '4798f6973e60502e20dd5fd06cd40d5b', '1', 'N', 'A', TO_DATE('2015-03-31 19:22:32', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-08-18 14:00:14', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '201510131705304596060000010083753.58887492015', '58.215.28.94', TO_DATE('2015-10-13 17:05:30', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('606010003', '606010003', '606010003', '678', '0ed7da6370f6ce781a9c74241c727bdb', '1', 'N', 'A', TO_DATE('2015-06-15 11:15:59', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-06-15 11:15:59', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('606010005', '606010005', '606010005', 'fdsgfdsg', '228dbfe6c9ad7eaa219147a211dc46e0', '1', 'N', 'A', TO_DATE('2015-06-15 14:37:26', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-06-15 14:37:26', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('000200002', '000200002', '000200002', '现货挂牌孙建萍', '8ff088f2edf04b50b6132e1697ea21bb', '1', 'N', 'A', TO_DATE('2015-06-16 13:57:47', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-06-16 13:57:47', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('000301011', '000301011', '000301011', '617000004', '6e72a2b93b94aea87dc6c844633dfa08', '1', 'N', 'A', TO_DATE('2015-06-23 09:04:38', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-06-23 09:04:38', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('000301012', '000301012', '000301012', '617000003', '90977f3f2709039c9553215652427f05', '1', 'N', 'A', TO_DATE('2015-06-23 09:05:31', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-06-23 09:05:31', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('HMR02', 'HMR02', 'HMR02', 'HMR02', '4d857ed04d78bd2e924b3fa595f6390f', '1', 'N', 'A', TO_DATE('2015-06-25 13:18:19', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-06-25 13:18:19', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '20150813092326626HMR0261319.641264402446', '123.165.133.109', TO_DATE('2015-08-13 09:23:26', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('HMR022', 'HMR02', 'HMR022', '黑木耳', '45a78ba844e3dacedeba2f65d3b4e2e3', '1', 'N', 'N', TO_DATE('2015-06-26 16:24:07', 'YYYY-MM-DD HH24:MI:SS'), null, '0123456789ABCDE', 'N', '20150803190113727HMR0223962.1611612774777', '42.102.148.63', TO_DATE('2015-08-03 19:01:13', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('HMR025', 'HMR02', 'HMR024', '黑木耳', '88a0f7597f7993791106c79362121d5b', '1', 'N', 'N', TO_DATE('2015-06-26 16:25:25', 'YYYY-MM-DD HH24:MI:SS'), null, '0123456789ABCDE', 'N', '20151012185206600HMR02584771.94505877684', '112.102.6.179', TO_DATE('2015-10-12 18:52:06', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('xh0091', 'xh009', '现货', '现货', '998c13ed521d6c47e622b6409e4c98e0', '1', 'N', 'N', TO_DATE('2015-06-26 16:49:39', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-06-26 16:51:42', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '20150626165111474xh009160034.46083922906', '58.215.28.94', TO_DATE('2015-06-26 16:51:11', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('xh014', 'xh014', 'xh014', 'xh014', 'd9139ccb774e7766646fd73d27f0b61b', '1', 'N', 'A', TO_DATE('2015-07-03 09:39:43', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-03 10:17:36', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '20150827154921770xh01468390.26189647402', '120.195.154.68', TO_DATE('2015-08-27 15:49:21', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('jsb002', 'jsb002', 'jsb002', 'jsb002', 'ec4d069a58c972963bb239674d0f2820', '1', 'N', 'A', TO_DATE('2015-07-03 13:15:34', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-03 13:15:34', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('jsb003', 'jsb003', 'jsb003', 'jsb003', 'bfc0d0d28dcbdd250d2178cb2446ff17', '1', 'N', 'A', TO_DATE('2015-07-03 14:59:14', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-03 14:59:14', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('607000008', '607000008', '607000008', '607000008', '8ba44d7e92e0e6b3c61a534ee0e30d04', '1', 'N', 'A', TO_DATE('2015-07-22 10:00:07', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-22 10:00:07', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '2015082414010346560700000875794.71991558418', '58.209.158.216', TO_DATE('2015-08-24 14:01:03', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('607000009', '607000009', '607000009', '123456789', '0c79cc110afdde497e6d8bd2aefeaee2', '1', 'N', 'A', TO_DATE('2015-08-03 15:10:42', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-08-03 15:10:42', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('h2', 'h2', 'h2', 'h2', '90e5fea0d07dae62c5f1ea6f2b2dfffa', '1', 'N', 'A', TO_DATE('2015-08-28 09:40:04', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-08-28 09:40:04', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '20150828131841595h255000.20966003644', '182.150.28.133', TO_DATE('2015-08-28 13:18:41', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('000200007', '000200007', '000200007', '123123123', '23a0d0cb3990b879b5d078342365f3c0', '1', 'N', 'A', TO_DATE('2015-09-10 21:29:55', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-09-10 21:29:55', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('001', '001', '001', '987654321', '5087387cf89516929adba9184872d9b1', '1', 'N', 'A', TO_DATE('2015-09-10 21:35:58', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-09-10 21:35:58', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('666', '666', '666', 'gb', '7be22a5be147ca0544783661011312dd', '1', 'N', 'A', TO_DATE('2015-09-10 21:47:14', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-09-10 21:47:14', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '201511160854230966626544.198339688242', '10.0.100.254', TO_DATE('2015-11-16 08:53:19', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('PG001', 'PG001', 'PG001', 'PG001', 'e86027464b32d2f337adeabc3ea4af50', '1', 'N', 'A', TO_DATE('2015-09-11 12:51:12', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-09-11 12:51:12', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '20150911234609274PG0017552.777441071712', '58.248.13.204', TO_DATE('2015-09-11 23:46:09', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('607000012', '607000012', '607000012', '607000014', 'b6d1c885109b429c415a57d22b97a098', '1', 'N', 'A', TO_DATE('2015-09-14 13:44:35', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-09-14 13:44:35', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('607000018', '607000018', '607000018', '606000018', '55048c269897d6c4edee8a5ade553733', '1', 'N', 'A', TO_DATE('2015-09-14 13:48:15', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-09-14 13:48:15', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '2015092110502358160700001862436.45673696485', '120.195.154.68', TO_DATE('2015-09-21 10:50:23', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('182', '182', '182', 'zhangtj', '3df277bec81e7198514d9dad27ff74f2', '1', 'N', 'A', TO_DATE('2015-09-15 14:02:09', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-09-15 14:02:09', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '2015091514053778618249979.6894502637', '182.150.28.133', TO_DATE('2015-09-15 14:05:37', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('183', '183', '183', '张', '6371cd846f28556438a775059e15ee74', '1', 'N', 'A', TO_DATE('2015-09-15 14:04:32', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-09-15 14:04:32', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '2015091514071714018381242.07653483677', '182.150.28.133', TO_DATE('2015-09-15 14:07:17', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('505000000000006', '505000000000006', '505000000000006', 'sy', 'fa75c8e86a376b9bafaccca187382bc2', '1', 'N', 'A', TO_DATE('2014-12-12 11:05:13', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-03-25 10:51:59', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '2015050615363964650500000000000633258.279128821414', '120.195.154.68', TO_DATE('2015-05-06 15:36:39', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('505000000000003', '505000000000003', '505000000000003', 'zjl', '8df0e1b4c352bbbf8d94f15828fce7b4', '1', 'N', 'A', TO_DATE('2014-12-12 12:51:11', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-03-25 09:19:30', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '2015032621103945650500000000000399942.011063398', '115.238.240.153', TO_DATE('2015-03-26 21:10:38', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('505000000000012', '505000000000012', '505000000000012', '王尚博', '191de8a27b45b479b6636e564edd4565', '1', 'N', 'A', TO_DATE('2014-12-25 11:20:40', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-12-25 11:53:28', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('11111', '11111', '11111', '哈哈哈', 'd0243956eef77b11b86154f10c4233b6', '1', 'N', 'A', TO_DATE('2015-01-20 11:11:05', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-03-18 09:07:58', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '201507291353333441111138642.97883583013', '221.235.44.6', TO_DATE('2015-07-29 13:53:33', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('0001', '0001', '0001', 'vip1', 'e5c6e5ccec361baebcf79859e49c5526', '1', 'N', 'A', TO_DATE('2015-01-20 12:18:05', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-03-26 10:54:09', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '20150203212310885000138925.62257116533', '120.195.154.68', TO_DATE('2015-02-03 21:23:10', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('0002', '0002', '0002', 'vip2', '3de2b02951b801792887ed72d8a7c8f2', '1', 'N', 'A', TO_DATE('2015-01-20 12:19:29', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-01-20 12:19:29', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '2015032412292236100026758.410420243299', '124.207.182.162', TO_DATE('2015-03-24 12:29:22', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('5050000000333', '5050000000333', '5050000000333', '5050000000333', 'ef4efc153c61e9d697cad6edf2338ceb', '1', 'N', 'A', TO_DATE('2015-03-13 09:10:51', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-03-13 09:10:51', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '20150831091739427505000000033386966.62051180055', '58.215.28.94', TO_DATE('2015-08-31 09:17:39', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('xh011', 'xh011', 'xh011', 'xh011', '5da29a946789575d480147775748b7c4', '1', 'N', 'A', TO_DATE('2015-04-20 11:06:49', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-04-20 11:06:49', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '20150923160457805xh01121044.219129035526', '120.195.154.68', TO_DATE('2015-09-23 16:04:57', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('hyl', 'hyl', 'hyl', 'hyl', '03b596674c6e75c33b2ff5187d0e1d6e', '1', 'N', 'A', TO_DATE('2015-06-08 10:32:05', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-06-08 10:32:05', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('606010007', '606010007', '606010007', 'fdgds', 'c652308163e06adefef85e0d662c0a31', '1', 'N', 'A', TO_DATE('2015-06-15 16:01:29', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-06-15 16:01:29', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('HMR023', 'HMR02', 'HMR023', '黑木耳', '9bf05d91956d81eeda67cce0b9402757', '1', 'N', 'N', TO_DATE('2015-06-26 16:24:32', 'YYYY-MM-DD HH24:MI:SS'), null, '0123456789ABCDE', 'N', '20150701144434533HMR02310790.464620195151', '112.102.29.101', TO_DATE('2015-07-01 14:44:34', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('HMR024', 'HMR02', 'HMR024', '黑木耳', '32198052d0573f269a78a73465f07ec2', '1', 'N', 'N', TO_DATE('2015-06-26 16:25:00', 'YYYY-MM-DD HH24:MI:SS'), null, '0123456789ABCDE', 'N', '20150804185541540HMR02446603.27238166044', '112.102.26.114', TO_DATE('2015-08-04 18:55:41', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('000200004', '000200004', '000200004', '617000001', 'f3ff055703c3a42b4dc76c6816b2f9eb', '1', 'N', 'A', TO_DATE('2015-07-02 10:56:53', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-02 10:56:53', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('xh015', 'xh015', 'xh015', 'xh015', '16cb51d03120bb9cd69513762aac7940', '1', 'N', 'A', TO_DATE('2015-07-03 09:39:24', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-03 09:39:24', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '20150921101400531xh01573202.26389815261', '120.195.154.68', TO_DATE('2015-09-21 10:14:00', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('607', '607', '607', '607', 'c835ffd131abb1a2645a911dfde43e70', '1', 'N', 'A', TO_DATE('2015-07-06 09:24:16', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-06 09:24:16', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('606010014', '606010014', '606010014', 'duzcbuilder', '422aecd8a9d0404a4dab03e4eee040ee', '1', 'N', 'A', TO_DATE('2015-07-06 09:37:09', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-06 09:37:09', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('607000003', '607000003', '607000003', 'jsb012', '8350ce3d751956928e996408af8272a1', '1', 'N', 'A', TO_DATE('2015-07-06 09:59:49', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-06 09:59:49', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('606000017', '606000017', '606000017', 'fdhsgfd', 'f752e5b18f906aaed76c824132e79461', '1', 'N', 'A', TO_DATE('2015-07-07 09:04:18', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-07 09:04:18', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('606000018', '606000018', '606000018', 'dsafsa', '22c82583271a69103e6fdd9bd3da29ca', '1', 'N', 'A', TO_DATE('2015-07-07 09:04:39', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-07 09:04:39', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('606000019', '606000019', '606000019', '567', '1c82952ccd5eedf8b2246942771513cc', '1', 'N', 'A', TO_DATE('2015-07-07 09:04:57', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-07 09:04:57', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('606000021', '606000021', '606000021', 'erwr4tr', '3e0ad111f9e90cc66d3d09595e7742a5', '1', 'N', 'A', TO_DATE('2015-07-07 09:07:23', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-07 09:07:23', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('002000002', '002000002', '002000002', 'safrd', '2210102863a0f2617cfa40b18b8fd346', '1', 'N', 'A', TO_DATE('2015-07-07 09:07:37', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-07 09:07:37', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('hy001', 'hy001', 'hy001', 'hy001', 'b45ec4211e15a1e031f2212e6300bb67', '1', 'N', 'A', TO_DATE('2015-07-28 10:59:16', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-28 10:59:16', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '20150730185835834hy00165764.44385923598', '60.211.240.170', TO_DATE('2015-07-30 18:58:35', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('622000000', '622000000', '622000000', '622000000', '4fd8ad391d521023b7efacf1d5ad599a', '1', 'N', 'A', TO_DATE('2015-08-25 11:11:57', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-08-27 16:11:22', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('607000019', '607000019', '607000019', '606000088', 'b331c5921a988ce14a242a8396e16d9c', '1', 'N', 'A', TO_DATE('2015-09-21 13:11:16', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-09-21 13:11:16', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('607000020', '607000020', '607000020', '606000188', '9525da927c37589e5512ed00d3ef3a1d', '1', 'N', 'A', TO_DATE('2015-09-21 13:13:57', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-09-21 13:13:57', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '2015092113151520660700002074552.29228319606', '120.195.154.68', TO_DATE('2015-09-21 13:15:15', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('000200009', '000200009', '000200009', '606010099', '08b237220e227a8d086782cff884427a', '1', 'N', 'A', TO_DATE('2015-09-21 13:14:31', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-09-21 13:14:31', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '2015092113153721700020000984786.00280980945', '120.195.154.68', TO_DATE('2015-09-21 13:15:37', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('606000023', '606000023', '606000023', '606000011', '51019684303d5d2ee05b9ec564836f5b', '1', 'N', 'A', TO_DATE('2015-09-21 13:24:07', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-09-21 13:24:07', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '2015092113254724860600002311146.1103536588', '120.195.154.68', TO_DATE('2015-09-21 13:25:47', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('607000022', '607000022', '607000022', '607000088', '2c800811f029b0bcf29c768022f12365', '1', 'N', 'A', TO_DATE('2015-09-21 13:25:08', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-09-21 13:25:08', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('607000023', '607000023', '607000023', '123456780', '40e32a1709ef365522beed7db5cbad60', '1', 'N', 'A', TO_DATE('2015-09-21 13:33:03', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-09-21 13:33:03', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '2015092113353825160700002364071.28817912462', '120.195.154.68', TO_DATE('2015-09-21 13:35:38', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('111111', '111111', '111111', 'ITC', '593c9b4a9390551d53e5cacf28ebd638', '1', 'N', 'A', TO_DATE('2015-10-08 14:48:46', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-10-08 14:48:46', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '2015103113012892811111144837.54670936337', '10.0.100.254', TO_DATE('2015-10-31 13:01:23', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('YXG', 'YXG', 'YXG', '100000', '37accadccd7f969a56134784be6c6e61', '1', 'N', 'A', TO_DATE('2015-10-10 13:59:40', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-10-10 13:59:40', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('606000025', '606000025', '606000025', '609000001', '664691adfecc3be635e2335326f689fc', '1', 'N', 'A', TO_DATE('2015-10-12 11:02:05', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-10-12 11:02:05', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '201510271548362060600002575847.74593942499', '106.38.220.76', TO_DATE('2015-10-27 15:48:36', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('606000028', '606000028', '606000028', '609000004', 'cf3b0e99dd89c442d00b5754f80f2e1c', '1', 'N', 'A', TO_DATE('2015-10-12 11:11:35', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-10-12 11:11:35', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '2015102713592998760600002824321.972989649254', '123.101.175.25', TO_DATE('2015-10-27 13:59:29', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('607000030', '607000030', '607000030', '130930568', 'ef795fbaa8fcbeaad0f396dec97f38a5', '1', 'N', 'A', TO_DATE('2015-10-12 13:43:17', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-10-12 14:21:43', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '201510121425160360700003056279.34231342341', '58.215.28.94', TO_DATE('2015-10-12 14:25:16', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('606000030', '606000030', '606000030', '609000006', 'c2256a8e30e3b5aa6f8b6500120825a8', '1', 'N', 'A', TO_DATE('2015-10-12 13:57:53', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-10-12 14:19:19', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '2015102709053853860600003037601.57839765988', '123.101.175.25', TO_DATE('2015-10-27 09:05:38', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('606000031', '606000031', '606000031', '609000007', '8ae839c08da300ef3cd3d1185de8b5c9', '1', 'N', 'A', TO_DATE('2015-10-12 13:58:08', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-10-12 13:58:08', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '2015102015090782460600003132887.87520663821', '218.77.90.139', TO_DATE('2015-10-20 15:09:07', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('test66', 'test66', 'test66', 'test66', '76c6a872b9a3e792526b6542b2f27d47', '1', 'N', 'A', TO_DATE('2015-03-05 17:27:34', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-03-05 17:27:34', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('608000123', '608000123', '608000123', '608000123', '78a3360544dcc4a1d75093e3aad56736', '1', 'N', 'A', TO_DATE('2015-03-24 15:42:52', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-03-24 15:42:52', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '201503262022230460800012319223.90239178784', '58.59.38.122', TO_DATE('2015-03-26 20:22:23', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('xh005', 'xh005', 'xh005', '现货005', '79c6d61148ed41d98f9ecd67256a6eaf', '1', 'N', 'A', TO_DATE('2015-04-01 10:50:53', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-04-01 10:50:53', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '20150923131830239xh00512383.733913585847', '120.195.154.68', TO_DATE('2015-09-23 13:18:30', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('xh009', 'xh009', 'xh009', '现货009', '879d4327a38456542c0e4217b1090831', '1', 'N', 'A', TO_DATE('2015-04-01 11:05:35', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-04-01 11:05:35', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '20151019151719223xh00944346.28971040004', '58.215.28.94', TO_DATE('2015-10-19 15:17:19', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('Shimo004', 'Shimo004', 'Shimo004', 'Shimo004', '5c12eb08c598b18ad3ffd3e16810e94a', '1', 'N', 'A', TO_DATE('2015-04-13 09:32:12', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-04-13 09:32:12', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '20150716192605814Shimo00450013.37900516497', '42.184.185.83', TO_DATE('2015-07-16 19:26:05', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('Shimo005', 'Shimo005', 'Shimo005', 'Shimo005', '05e1f233734fec3be8683fb17a3ee8be', '1', 'N', 'A', TO_DATE('2015-04-13 09:33:50', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-04-13 09:33:50', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '20150715081145962Shimo00515401.0546907712', '112.101.220.108', TO_DATE('2015-07-15 08:11:45', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('xh012', 'xh012', 'xh012', 'xh012', '11a8529843add37009c3584834885c0f', '1', 'N', 'A', TO_DATE('2015-04-24 12:41:37', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-04-24 12:41:37', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '20151012151938661xh01246642.6981709812', '120.195.154.68', TO_DATE('2015-10-12 15:19:38', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('xh013', 'xh013', 'xh013', 'xh013', 'b690bd503cdc5bf54b635e368624e2d3', '1', 'N', 'A', TO_DATE('2015-04-24 13:45:28', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-04-24 13:45:28', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '20151009102504812xh01331942.443117385366', '120.195.154.68', TO_DATE('2015-10-09 10:25:04', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('60600000180', '60600000180', '60600000180', 'Ocean', '1ad554587155c67ef599dccb37e45285', '1', 'N', 'A', TO_DATE('2015-06-05 15:14:07', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-06-05 15:15:42', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '201507071150198816060000018083070.57836718901', '58.215.28.94', TO_DATE('2015-07-07 11:50:19', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('601002022', '601002022', '601002022', 'asd123', 'bb6a485bf6f7ab0c8827bad59f362573', '1', 'N', 'A', TO_DATE('2015-06-08 09:53:13', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-06-08 09:53:13', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('00021034', '00021034', '00021034', '无锡', 'd791076de02dee7bdb57669c622827c8', '1', 'N', 'A', TO_DATE('2015-06-08 10:07:44', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-06-08 10:07:44', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('112', '112', '112', '陈小陈', 'dcf95f7ca8f2802485480bcc7c977f09', '1', 'N', 'A', TO_DATE('2015-06-08 10:33:38', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-06-08 10:33:38', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('60600000111', '60600000111', '60600000111', 'dajiahao', 'f37c1dba90b88436eddb4c37a3b78466', '1', 'N', 'A', TO_DATE('2015-06-08 17:04:58', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-06-08 17:04:58', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('606010001', '606010001', '606010001', '606010001', 'e1554fc62af97975ce987c62a847d991', '1', 'N', 'A', TO_DATE('2015-06-10 11:44:47', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-06-10 11:44:47', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '2015091416315766760601000146377.499244639555', '120.195.154.68', TO_DATE('2015-09-14 16:31:57', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('606010004', '606010004', '606010004', '789', '69bd54a439d9d4cf0704e2c70cb51631', '1', 'N', 'A', TO_DATE('2015-06-15 13:58:34', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-06-15 13:58:34', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('606010006', '606010006', '606010006', 'dsdsfvsdfsdfs', 'ddf63d869641664d9ae4f85871a8e06f', '1', 'N', 'A', TO_DATE('2015-06-15 14:41:43', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-06-15 14:41:43', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('606010008', '606010008', '606010008', 'dafdsa', 'bcd36d718ea2dfd808d3b423f03f6972', '1', 'N', 'A', TO_DATE('2015-06-15 16:25:02', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-06-15 16:25:02', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('606010010', '606010010', '606010010', '606010010', '7c05fb8c8d7ab3e6a46d360d7c7e2048', '1', 'N', 'A', TO_DATE('2015-06-16 13:40:30', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-06-16 13:40:30', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('HMR01', 'HMR01', 'HMR01', 'HMR01', 'bcbfa0211b7f43382f57df79548664af', '1', 'N', 'A', TO_DATE('2015-06-25 13:09:33', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-06-25 13:09:33', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '20150702085803567HMR0151210.200215049226', '112.102.5.58', TO_DATE('2015-07-02 08:58:03', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('606000016', '606000016', '606000016', 'jsb008', 'ddddc14bdca817e21a8b75af7b487497', '1', 'N', 'A', TO_DATE('2015-07-07 09:03:30', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-07 09:03:30', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('606000020', '606000020', '606000020', '234', 'b673aed78267683a57e01eb2b7d78da3', '1', 'N', 'A', TO_DATE('2015-07-07 09:05:17', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-07 09:05:17', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('000200006', '000200006', '000200006', 'atesta', 'af63f56aa1c105fb9b84402d52366076', '1', 'N', 'A', TO_DATE('2015-07-07 09:08:04', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-07 09:08:04', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('607000004', '607000004', '607000004', '王新', '3f4e8fb47ff5e417a3acf326e9b08dbb', '1', 'N', 'A', TO_DATE('2015-07-08 09:21:15', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-08 09:21:15', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '2015081008494361660700000446559.04128309761', '117.62.102.65', TO_DATE('2015-08-10 08:49:43', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('607000005', '607000005', '607000005', '王英', '1d87376d48935863e9fcd8982997eb17', '1', 'N', 'A', TO_DATE('2015-07-08 10:46:05', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-08 10:46:05', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '2015092810485735860700000546229.272000974386', '180.107.158.65', TO_DATE('2015-09-28 10:48:57', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('618000000', '618000000', '618000000', '618000000', '3963a023efe061cadc8db42c976035cb', '1', 'N', 'A', TO_DATE('2015-07-22 09:57:50', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-22 09:57:50', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '2015072308485039161800000076583.35443958803', '117.81.64.70', TO_DATE('2015-07-23 08:48:50', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('ceshi', 'ceshi', 'ceshi', 'ceshi', '2e28cac33d5da5d27f076ef0d9550033', '1', 'N', 'A', TO_DATE('2015-08-20 14:20:56', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-08-20 14:20:56', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('607000011', '607000011', '607000011', '607000011', '7e0209246efd5f6e024b1afb3e35ef11', '1', 'N', 'A', TO_DATE('2015-09-01 16:05:39', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-09-01 16:05:39', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '2015090116102837760700001131669.249232730912', '58.215.28.94', TO_DATE('2015-09-01 16:10:28', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('000200008', '000200008', '000200008', '606000000', '5bb5517e604c8adc4cc993581c2bc541', '1', 'N', 'A', TO_DATE('2015-09-21 12:54:26', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-09-21 12:54:26', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('607000021', '607000021', '607000021', '607000022', 'e08fa50b0389ea81f33d47696191e41c', '1', 'N', 'A', TO_DATE('2015-09-21 13:18:21', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-09-21 13:18:21', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '2015092113185178160700002119271.628213937252', '120.195.154.68', TO_DATE('2015-09-21 13:18:51', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('607000024', '607000024', '607000024', '606112233', '07bce6ba4a96449cbbb64f232b2383b1', '1', 'N', 'A', TO_DATE('2015-09-23 09:42:03', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-09-23 09:42:03', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '201509230958195260700002473579.44415541875', '120.195.154.68', TO_DATE('2015-09-23 09:58:19', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('607000025', '607000025', '607000025', '444555666', '402e47af26a87a4524bc45d268af8fa1', '1', 'N', 'A', TO_DATE('2015-09-23 09:42:38', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-09-23 09:42:38', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '2015092309472624260700002580907.09525114509', '120.195.154.68', TO_DATE('2015-09-23 09:47:26', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('606000024', '606000024', '606000024', '606000012', 'bf869a5f9ba0b00c3689d9fd0859927b', '1', 'N', 'A', TO_DATE('2015-09-23 09:43:14', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-09-23 09:43:14', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('607000026', '607000026', '607000026', '606008888', 'f6f85a23956c156456be21464ee29df2', '1', 'N', 'A', TO_DATE('2015-09-23 09:44:20', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-09-23 09:44:20', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '2015092309450135760700002626210.071501983413', '120.195.154.68', TO_DATE('2015-09-23 09:45:01', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('607000027', '607000027', '607000027', '607000067', '2e58de5bd739caa3254598d35c491f2a', '1', 'N', 'A', TO_DATE('2015-09-23 09:44:57', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-09-23 09:44:57', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '2015092810350691860700002787099.89419566625', '120.195.154.68', TO_DATE('2015-09-28 10:35:06', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('607000028', '607000028', '607000028', '741852963', 'ef6ce51adfc0e5f2c1d03bfd7fe28311', '1', 'N', 'A', TO_DATE('2015-09-23 09:52:21', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-09-23 09:52:21', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('607000029', '607000029', '607000029', '123456788', '4bb4bf3db9cf1d50378483c727a910d3', '1', 'N', 'A', TO_DATE('2015-09-23 09:52:47', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-09-23 09:52:47', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('606000026', '606000026', '606000026', '609000002', '5eeb6df765548e06e889ed4a02d0509e', '1', 'N', 'A', TO_DATE('2015-10-12 11:05:03', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-10-12 11:05:03', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '201510271302363560600002661811.195707725805', '123.101.175.25', TO_DATE('2015-10-27 13:02:36', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('606000027', '606000027', '606000027', '609000003', '48b03cb4714c70b5cba3a10525ee068b', '1', 'N', 'A', TO_DATE('2015-10-12 11:11:25', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-10-12 11:11:25', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '2015102713451147260600002757025.880729915254', '123.101.175.25', TO_DATE('2015-10-27 13:45:11', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('606000029', '606000029', '606000029', '609000005', '5be62bd65345e8744d7b2b0ebdf1e7ea', '0', 'N', 'A', TO_DATE('2015-10-12 11:16:25', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-10-12 11:16:25', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '2015102108491555760600002979628.13297901119', '60.184.26.178', TO_DATE('2015-10-21 08:49:15', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('77777bb', '77777', 'bbbbbb', 'bbbbbb', 'ff9a5930b2df737734e3ce036e914d82', '1', 'N', 'N', TO_DATE('2015-10-18 11:12:32', 'YYYY-MM-DD HH24:MI:SS'), null, '0123456789ABCDE', 'N', '2015101811204313577777bb14823.987719387089', '218.2.224.66', TO_DATE('2015-10-18 11:20:43', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('505000000000002', '505000000000002', '505000000000002', '吴成毅', '735fa5bb4d5b28cd3cf2d597257010f1', '1', 'N', 'A', TO_DATE('2014-11-12 17:25:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-12-22 10:46:22', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '2015051409043091550500000000000245775.51822407541', '140.206.244.177', TO_DATE('2015-05-14 09:04:30', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('505000000000007', '505000000000007', '505000000000007', '徐敏', '88bcc4d9c5a27a02b5f8afc42c1a0204', '1', 'N', 'A', TO_DATE('2014-12-12 09:57:45', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-03-02 10:04:25', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '201503021004370150500000000000712675.783201388413', '58.215.28.94', TO_DATE('2015-03-02 10:04:37', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('505000000000005', '505000000000005', '505000000000005', 'caij', 'ac570bd0ee81698ecf49ea5cce32a7ee', '1', 'N', 'A', TO_DATE('2014-12-12 11:09:16', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-12-12 11:09:16', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '2015032708462667650500000000000534177.14340841401', '120.195.154.68', TO_DATE('2015-03-27 08:46:26', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('505000000000010', '505000000000010', '505000000000010', 'wje', '887eedb07f909917b233965041afda0e', '1', 'N', 'A', TO_DATE('2014-12-15 10:36:33', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-04-24 13:42:48', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '2015081813434237250500000000001053425.582975653655', '58.215.28.94', TO_DATE('2015-08-18 13:43:41', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('126000000000108', '126000000000108', '126000000000108', 'zcy', '5b100e60fbb473f964aab81a0e359c7d', '1', 'N', 'A', TO_DATE('2014-12-16 12:59:30', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-12-16 13:22:28', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '2015032309193414512600000000010863703.76978946541', '58.215.28.94', TO_DATE('2015-03-23 09:19:34', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('008013', '008013', '008013', 'lvtctest', '89b3d6f6a0197bd093d2b600fb444d86', '1', 'N', 'A', TO_DATE('2014-12-25 07:43:06', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-01-10 13:30:07', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '2015102614045651500801365630.94320542086', '58.215.28.94', TO_DATE('2015-10-26 14:04:56', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('505000000000108', '505000000000108', '505000000000108', 'nijia', '7d312857a12921d428ff3bc55b0655b4', '1', 'N', 'A', TO_DATE('2014-12-25 11:22:25', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-01-10 13:48:14', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '2015012113002682250500000000010879365.75478633714', '58.215.28.94', TO_DATE('2015-01-21 13:00:26', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('601010001', '601010001', '601010001', 'maliang305', '21c7ae7c44bdd9997feac6bcded6a758', '1', 'N', 'A', TO_DATE('2015-01-06 13:33:54', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-01-06 13:33:54', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '2015010817000949860101000190925.54513998069', '58.215.28.94', TO_DATE('2015-01-08 17:00:09', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('601010002', '601010002', '601010002', 'maliang3477', '8ea2c80010248149cd36d24522265450', '1', 'N', 'A', TO_DATE('2015-01-06 14:42:33', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-01-06 14:42:33', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('44444', '44444', '44444', '6654', '796fdb9b80c2a6d96df84cec5b0b2947', '0', 'N', 'A', TO_DATE('2015-01-20 11:15:50', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-01-20 11:15:50', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '20150402112258446444446361.826758842304', '120.195.154.68', TO_DATE('2015-04-02 11:22:58', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('55555', '55555', '55555', '555', '3f09df902c74fc8d13bdc3483d38b55d', '1', 'N', 'A', TO_DATE('2015-01-20 11:17:07', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-01-20 11:17:07', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '201503262104124495555525813.22459836487', '115.238.240.153', TO_DATE('2015-03-26 21:04:11', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('77777', '77777', '77777', '556', '979476158457fda641eb59df4b2d5690', '1', 'N', 'A', TO_DATE('2015-01-20 11:19:41', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-01-20 11:19:41', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '201503262106233607777761811.703146973065', '115.238.240.153', TO_DATE('2015-03-26 21:06:22', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('88888', '88888', '88888', '1225', 'c7b20aaf27dfbd354492f29b93607fbe', '1', 'N', 'A', TO_DATE('2015-01-20 11:21:33', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-01-22 12:51:37', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '201504151357217638888860301.95232966019', '120.195.154.68', TO_DATE('2015-04-15 13:57:21', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('99999', '99999', '99999', '5552', '0f85ef7fa9b6470a819c0cc4a3605643', '1', 'N', 'A', TO_DATE('2015-01-20 11:23:20', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-01-20 11:23:20', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '201505061658222549999960254.087239094755', '120.195.154.68', TO_DATE('2015-05-06 16:58:22', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('608000333', '608000333', '608000333', 'creamycc', 'd7d4ab457a38b8fb677f41e786ed27e9', '1', 'N', 'A', TO_DATE('2015-03-25 11:00:41', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-03-25 11:00:41', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('xh001', 'xh001', 'xh001', '现货001', '435957876d6ed296af565f09092aa557', '1', 'N', 'A', TO_DATE('2015-04-01 10:14:04', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-04-01 10:14:04', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '20150703101110875xh00167184.8169876056', '120.195.154.68', TO_DATE('2015-07-03 10:11:10', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('xh006', 'xh006', 'xh006', '现货006', '215cbac8397a9a7e598b709d8ab05c86', '1', 'N', 'A', TO_DATE('2015-04-01 10:54:13', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-04-01 10:54:13', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '20151009095234980xh00621286.567348114382', '120.195.154.68', TO_DATE('2015-10-09 09:52:34', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('Shimo001', 'Shimo001', 'Shimo001', 'Shimo001', 'd52cc3691f0994fcd959dfced347347e', '1', 'N', 'A', TO_DATE('2015-04-10 14:33:53', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-04-10 14:33:53', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '20150820165047338Shimo00178702.59016337337', '42.101.151.229', TO_DATE('2015-08-20 16:50:47', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('Shimo002', 'Shimo002', 'Shimo002', 'Shimo002', 'b604f61a7ba62997344fef7c90764f5d', '1', 'N', 'A', TO_DATE('2015-04-13 09:28:15', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-04-13 09:28:15', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '2015060415575119Shimo0024361.074093864548', '42.184.188.93', TO_DATE('2015-06-04 15:57:51', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('Shimo003', 'Shimo003', 'Shimo003', 'Shimo003', '745e0c386d5ade93e16123bda934212c', '1', 'N', 'A', TO_DATE('2015-04-13 09:30:43', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-04-13 09:30:43', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '20150604155328104Shimo00371743.6383137812', '42.184.188.93', TO_DATE('2015-06-04 15:53:28', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('50500000100', '50500000100', '50500000100', '王家恩', '245c7b3f7a51159217819953993e1712', '1', 'N', 'A', TO_DATE('2015-04-24 13:54:40', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-04-24 13:54:40', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '201508181637098685050000010013254.84656382543', '58.215.28.94', TO_DATE('2015-08-18 16:37:08', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('60600000110', '60600000110', '60600000110', 'wdbgfdsbvs', 'f14cd23d22df7f72e631f9e445fa72b7', '1', 'N', 'A', TO_DATE('2015-06-02 10:04:14', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-06-02 10:04:14', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('606000001', '606000001', '606000001', '现货挂牌会员部', 'a4df395792592e93e7fb34b238a1ce62', '1', 'N', 'A', TO_DATE('2015-06-05 16:14:28', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-06-05 16:14:28', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('606000002', '606000002', '606000002', '交收部韦青松', 'd27404296b60b5a570b29a3021d65d74', '1', 'N', 'A', TO_DATE('2015-06-05 16:20:08', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-06-05 16:20:08', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('606010000', '606010000', '606010000', '居间', '2346e300dbd040624893601df749e0bf', '1', 'N', 'A', TO_DATE('2015-06-09 13:28:06', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-06-09 13:28:06', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('606000008', '606000008', '606000008', '606000008', 'cd916838b9fa19647c4eb1c996a6e2aa', '0', 'N', 'A', TO_DATE('2015-06-11 09:14:05', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-06-11 09:14:05', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '2015102608251556560600000828574.858493621192', '60.184.28.96', TO_DATE('2015-10-26 08:25:15', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('606010009', '606010009', '606010009', '890', 'e68657a69d7488e29f5bfb5af32b145f', '1', 'N', 'A', TO_DATE('2015-06-15 16:36:10', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-06-15 16:36:10', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('000210341', '000210341', '000210341', 'gnnt020', '3b241f73747ff56f2a8edafb8e77936b', '1', 'N', 'A', TO_DATE('2015-06-15 16:45:40', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-06-15 16:45:40', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('606000012', '606000012', '606000012', 'wqfvcxvfd', '4d2454ee869eef12c5a17cb398b4d651', '1', 'N', 'A', TO_DATE('2015-07-02 10:59:15', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-02 10:59:15', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('606000013', '606000013', '606000013', 'jsb001', '8302ed947687da529606290afd55720c', '1', 'N', 'A', TO_DATE('2015-07-02 19:33:04', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-02 19:33:04', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('606010013', '606010013', '606010013', 'dduzcbuildermem2', '03473804bba41b019cb71e28eb62688f', '1', 'N', 'A', TO_DATE('2015-07-06 09:36:25', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-06 09:36:25', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('606000014', '606000014', '606000014', 'duzcbuildermem', '8a9f4eef3818cd1c30751ea35cd68aaa', '1', 'N', 'A', TO_DATE('2015-07-06 09:36:51', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-06 09:36:51', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('607000001', '607000001', '607000001', '607000001', '2a55f301f5a711a63ec4238c8e4de8e7', '1', 'N', 'A', TO_DATE('2015-07-06 09:44:07', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-06 09:44:07', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('607020001', '607020001', '607020001', '607020001', '839382860fb0ceb45ad3e994561b4965', '1', 'N', 'A', TO_DATE('2015-07-06 09:44:54', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-06 09:44:54', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('607000002', '607000002', '607000002', 'jsb011', 'c143653be5de02e30132e07ba643287b', '1', 'N', 'A', TO_DATE('2015-07-06 09:55:49', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-06 09:55:49', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('607000006', '607000006', '607000006', '胡亿', 'b7d448005f0fb8624dac7551bf150282', '1', 'N', 'A', TO_DATE('2015-07-08 11:09:59', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-08 11:09:59', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '2015073110431728060700000651018.81757253261', '49.72.66.79', TO_DATE('2015-07-31 10:43:17', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('607000007', '607000007', '607000007', '罗静', 'a720d6ad6f8683bafdad26699d460d8c', '1', 'N', 'A', TO_DATE('2015-07-08 11:11:05', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-08 11:11:05', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '2015073110282492960700000739645.944160016035', '49.72.66.79', TO_DATE('2015-07-31 10:28:24', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('609000000', '609000000', '609000000', '609000000', 'd46e3b3202bc541df781a5d149c34664', '1', 'N', 'A', TO_DATE('2015-07-15 14:15:31', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-15 14:15:31', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '201507151416143786090000008844.881366209589', '14.215.80.165', TO_DATE('2015-07-15 14:16:14', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('008', '008', '505000000000003', '张永祥', '48a4afb0cac2984e833ea8f53906daf5', '1', 'N', 'N', TO_DATE('2014-11-18 03:17:05', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-04-16 21:56:41', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('50500000000009', '50500000000009', '50500000000009', 'hxq', 'd764a70312b23cb79a6152d0973d374d', '1', 'N', 'A', TO_DATE('2014-12-12 11:01:51', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-03-25 09:19:53', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('505000000000088', '505000000000088', '505000000000088', '花花', '1b4d7d09a8d7f15441233ec8409ced68', '1', 'N', 'A', TO_DATE('2015-01-19 14:26:03', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-01-19 14:26:03', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('505000000000089', '505000000000089', '505000000000089', '毛毛', '1d55bb1c4cc4a21acd0e539e6d22537e', '1', 'N', 'A', TO_DATE('2015-01-19 14:29:23', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-01-19 14:29:23', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('606', '606', '606', '德清艾瑞商务', '132aaceee9ef1260da77e27cbaf2fe36', '1', 'N', 'A', TO_DATE('2015-01-27 17:07:54', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-06-19 09:20:11', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '2015061909204229460613375.49593518781', '58.215.28.94', TO_DATE('2015-06-19 09:20:42', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('00030101', '00030101', '00030101', '张春', '1b5c519fcb3891df6a11bfff78bfd9a9', '1', 'N', 'A', TO_DATE('2015-03-06 11:09:42', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-03-06 11:09:42', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('xh002', 'xh002', 'xh002', '现货002', 'b0aa2e5d6301982caa0c46d026824c4f', '1', 'N', 'A', TO_DATE('2015-04-01 10:21:07', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-04-01 10:21:07', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '20150918134506731xh00263572.41156359173', '120.195.154.68', TO_DATE('2015-09-18 13:45:06', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('xh003', 'xh003', 'xh003', '现货003', 'e8e741c5f9cb951c39430f799becd49e', '1', 'N', 'A', TO_DATE('2015-04-01 10:41:48', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-04-01 10:41:48', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '20150821084852755xh00352192.19365308649', '120.195.154.68', TO_DATE('2015-08-21 08:48:52', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('xh004', 'xh004', 'xh004', '现货004', '4d6ca614e263cb513378e52ec407483c', '1', 'N', 'A', TO_DATE('2015-04-01 10:44:50', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-04-01 10:44:50', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '20150914155348742xh00415925.073518631649', '120.195.154.68', TO_DATE('2015-09-14 15:53:48', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('xh007', 'xh007', 'xh007', '现货007', '8cf876e513d874f49b4498ed0d0190ef', '1', 'N', 'A', TO_DATE('2015-04-01 10:56:42', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-04-01 10:56:42', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '2015092313254318xh00744071.08662011131', '120.195.154.68', TO_DATE('2015-09-23 13:25:42', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('xh008', 'xh008', 'xh008', '现货008', '562f9c3885fcd634d1d8c5ff39d86999', '1', 'N', 'A', TO_DATE('2015-04-01 10:59:08', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-04-01 10:59:08', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '20150918134414397xh00877282.6653054998', '120.195.154.68', TO_DATE('2015-09-18 13:44:14', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('xh010', 'xh010', 'xh010', '现货010', '1c15e5a656cd229417a00ad5de32b323', '1', 'N', 'A', TO_DATE('2015-04-01 11:08:43', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-04-01 11:08:43', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '20150923152445960xh01084270.19575684478', '120.195.154.68', TO_DATE('2015-09-23 15:24:45', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('606010002', '606010002', '606010002', '456', '79b845a63315ecd0a4520c6ec3a1b0ac', '1', 'N', 'A', TO_DATE('2015-06-11 17:29:54', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-06-11 17:29:54', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('000200001', '000200001', '000200001', '900', 'f287392bcccaf38cb13a742f50221215', '1', 'N', 'A', TO_DATE('2015-06-15 16:55:01', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-06-15 16:55:01', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('606000009', '606000009', '606000009', '902', '436bb75c16aca025383e02f3de9ca0c9', '1', 'N', 'A', TO_DATE('2015-06-15 17:03:49', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-06-26 09:13:42', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '2015070813075060560600000976454.14732766872', '58.215.28.94', TO_DATE('2015-07-08 13:07:50', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('606000011', '606000011', '606000011', '606010011', '205cbf3e4a39432f416f129b17098f35', '1', 'N', 'A', TO_DATE('2015-06-16 13:56:20', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-06-16 13:56:20', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('000200003', '000200003', '000200003', '长三角商品交易所法人', '55de94c648f5e1ba036788d6a9f47921', '1', 'N', 'A', TO_DATE('2015-06-16 14:25:25', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-06-16 14:25:25', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('606010012', '606010012', '606010012', '606010012', 'd2ed29a192016eab08aa3c335697a2eb', '1', 'N', 'A', TO_DATE('2015-06-17 16:55:23', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-06-17 16:55:23', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '2015091420150639360601001276698.05257855958', '49.80.195.20', TO_DATE('2015-09-14 20:15:06', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('444', '444', '444', '444', 'f04829b57e19504229cc56c53245fec5', '1', 'N', 'A', TO_DATE('2015-06-19 09:46:57', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-06-19 09:53:31', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '2015082115184166944449066.636486357536', '58.215.28.94', TO_DATE('2015-08-21 15:18:41', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('505000000000105', '505000000000105', '505000000000105', 'zhang', '78ce42ebafd29fc23a034c72c8d4180c', '1', 'N', 'A', TO_DATE('2015-06-19 09:59:42', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-06-19 09:59:42', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('000301013', '000301013', '000301013', '617000002', '4469e8f61d5338f5d1926430b9278cbc', '1', 'N', 'A', TO_DATE('2015-06-23 09:06:10', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-06-23 09:06:10', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('606000001801', '60600000180', 'Ocean01', 'Ocean01', '43bd57b12ed4103c42953fe3c6e9851a', '1', 'N', 'A', TO_DATE('2015-06-26 16:17:45', 'YYYY-MM-DD HH24:MI:SS'), null, '0123456789ABCDE', 'N', '201506261618386656060000018016736.866507676254', '58.215.28.94', TO_DATE('2015-06-26 16:18:38', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('HMR021', 'HMR02', 'HMR021', '黑木耳', 'db24d9c54bc06d3471634395eb6ce0dd', '1', 'N', 'N', TO_DATE('2015-06-26 16:23:34', 'YYYY-MM-DD HH24:MI:SS'), null, '0123456789ABCDE', 'N', '20151009104011387HMR02141448.40858544339', '112.102.15.110', TO_DATE('2015-10-09 10:40:11', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('HMR026', 'HMR02', 'HMR026', '黑木耳', 'a749c210284ba30984414058cc03d203', '1', 'N', 'N', TO_DATE('2015-06-26 16:25:51', 'YYYY-MM-DD HH24:MI:SS'), null, '0123456789ABCDE', 'N', '20150731085845353HMR02625007.18343787607', '42.102.148.63', TO_DATE('2015-07-31 08:58:45', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('607010001', '607010001', '607010001', '607010001', '35ffd6e43a472768529aeeaf508a74d9', '1', 'N', 'A', TO_DATE('2015-07-06 09:44:32', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-06 09:44:32', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('607020002', '607020002', '607020002', 'jsb010', 'dd843326434dfb046aff29920f29e538', '1', 'N', 'A', TO_DATE('2015-07-06 09:51:13', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-06 09:51:13', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('607010002', '607010002', '607010002', 'jsb009', '38db706efff1b5cbd12b086da02a6d11', '1', 'N', 'A', TO_DATE('2015-07-06 09:51:40', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-06 09:51:40', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('606000015', '606000015', '606000015', 'jsb006', 'a4d9ea9537bcb6ababeca0ae895705c0', '1', 'N', 'A', TO_DATE('2015-07-07 09:02:52', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-07 09:02:52', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('020000001', '020000001', '020000001', 'duzcbrtest1', 'dc12bb2dc3c86d58c639c1b5c5cccb10', '1', 'N', 'A', TO_DATE('2015-07-07 09:03:05', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-07 09:03:05', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('606010015', '606010015', '606010015', 'jsb007', '8ebe08bf6585fb3061f66029f353eda6', '1', 'N', 'A', TO_DATE('2015-07-07 09:03:17', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-07 09:03:17', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('002000001', '002000001', '002000001', 'qwsxcvf', 'c15b8e8a229f7938997c5dcfd868b7b8', '1', 'N', 'A', TO_DATE('2015-07-07 09:06:58', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-07 09:06:58', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('000200005', '000200005', '000200005', 'qwsdderf', '64a4fb67e2e019feba4ce23c32b0fb17', '1', 'N', 'A', TO_DATE('2015-07-07 09:07:09', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-07 09:07:09', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('000100001', '000100001', '000100001', 'qsxcdf', 'ea5114163c265e1f5e760b3ff66dcd6d', '1', 'N', 'A', TO_DATE('2015-07-07 09:07:51', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-07 09:07:51', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('002000003', '002000003', '002000003', 'qwqs', '1e4af3a1dffb9218978e6e1c069c5643', '1', 'N', 'A', TO_DATE('2015-07-07 09:08:18', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-07 09:08:18', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('607000010', '607000010', '607000010', '607000010', '8d75a16c13df0beb898a668eb02746f3', '1', 'N', 'A', TO_DATE('2015-08-04 08:17:03', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-08-18 09:16:12', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('101000005000579', '101000005000579', '101000005000579', '101000005000579', 'ef3732f2d88cce1dc0051d0dad1472f4', '1', 'N', 'A', TO_DATE('2015-08-13 11:28:27', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-08-13 11:28:27', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '2015090908373875310100000500057955953.84279043865', '58.215.28.94', TO_DATE('2015-09-09 08:37:38', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('606000022', '606000022', '606000022', '606000022', '2d3ef6b26a5f408bb6bf4e08b3dcc291', '1', 'N', 'A', TO_DATE('2015-08-20 09:47:26', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-08-20 09:47:26', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '2015082009573740160600002244494.166140708425', '101.67.103.53', TO_DATE('2015-08-20 09:57:37', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('ceshi1', 'ceshi1', 'ceshi1', 'ceshi1', '10051739416da6a734867b051a4b4e19', '0', 'N', 'A', TO_DATE('2015-08-20 14:23:26', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-10-08 16:39:28', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '20151107122617463ceshi182586.59148400354', '10.0.100.254', TO_DATE('2015-11-07 12:26:11', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('3203211988', '3203211988', '3203211988', 'chengdong', '4ae3db40761efe734522642a5909bfdf', '1', 'N', 'A', TO_DATE('2015-08-24 09:38:16', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-08-24 09:38:16', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('555555', '555555', '555555', '贲余刚', '5d7cd1f7c6164ed96ece46d53889a2da', '1', 'N', 'A', TO_DATE('2015-10-29 13:31:22', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-10-29 13:31:22', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '2015101918470564055555532838.82953483388', '10.0.100.254', TO_DATE('2015-10-29 13:31:22', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('222', '222', '222', '222', '0d777e9e30b918e9034ab610712c90cf', '1', 'N', 'A', TO_DATE('2015-10-31 15:44:57', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-10-31 15:44:57', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('222222', '222222', '222222', 'hxx', '4d18e2c96bb0f39c6d6dc690542b0bdc', '1', 'N', 'A', TO_DATE('2015-10-29 11:28:22', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-11-05 10:06:46', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '2015110902162153822222267832.18212358172', '10.0.100.254', TO_DATE('2015-11-09 02:15:26', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('999999', '999999', '999999', '贲余刚', '5d2c286355bb6f97d6a4df460056418b', '1', 'N', 'A', TO_DATE('2015-10-29 21:04:39', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-11-05 14:44:28', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '2015110414551957199999957422.19323677351', '10.0.100.254', TO_DATE('2015-11-04 14:55:14', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('hl', 'hl', 'hl', '贲余刚', '7d940359a245b1d1f94437f59526d90c', '1', 'N', 'A', TO_DATE('2015-11-02 20:03:35', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-11-02 20:03:35', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '20151019184705640hl32838.82953483388', '10.0.100.254', TO_DATE('2015-11-02 20:03:35', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('6', '6', '6', '6', 'cebee84570e2db07735ecc7a4085834c', '1', 'N', 'A', TO_DATE('2015-11-04 14:30:04', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-11-04 14:32:44', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('7', '7', '7', '7', 'b7e1aff249dbc9a7767b8e0fb370ec50', '1', 'N', 'A', TO_DATE('2015-11-04 14:35:19', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-11-04 14:35:19', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('22', '22', '22', '111111', 'bae5e3208a3c700e3db642b6631e95b9', '1', 'N', 'A', TO_DATE('2015-11-04 20:33:47', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-11-04 20:33:47', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '201511171448424952241359.64651642466', '10.0.100.254', TO_DATE('2015-11-17 14:47:38', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('0', '0', '0', '0', '29c3eea3f305d6b823f562ac4be35217', '1', 'N', 'A', TO_DATE('2015-11-04 21:09:28', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-11-04 21:09:28', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '2015110421175815809806.921773461885', '10.0.100.254', TO_DATE('2015-11-04 21:17:08', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('a', 'a', 'a', 'a', '5d793fc5b00a2348c3fb9ab59e5ca98a', '1', 'N', 'A', TO_DATE('2015-11-04 23:50:31', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-11-04 23:50:31', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('000', '000', '000', '000', '4c93008615c2d041e33ebac605d14b5b', '1', 'N', 'A', TO_DATE('2015-11-05 08:39:20', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-11-05 10:03:16', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '2015110516595067400092313.79034507852', '10.0.100.254', TO_DATE('2015-11-05 16:58:59', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('606000032', '606000032', '606000032', '609000008', '8c605d3b21faf20d7122464221523476', '1', 'N', 'A', TO_DATE('2015-10-12 13:58:19', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-10-12 13:58:19', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '2015102015093151460600003216077.265363148163', '218.77.90.139', TO_DATE('2015-10-20 15:09:31', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('606000033', '606000033', '606000033', '609000009', '87d97f742f7b309d644f71da1b373779', '1', 'N', 'A', TO_DATE('2015-10-12 13:58:29', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-10-12 13:58:29', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('606000034', '606000034', '606000034', '609000010', '26baa7ac6ec3d67a51a40ce5bac345cd', '1', 'N', 'A', TO_DATE('2015-10-12 14:08:45', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-10-12 14:08:45', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('777777', '777777', '777777', '贲余刚', '11c6603d52a4829f2b4ee8505a1157da', '1', 'N', 'A', TO_DATE('2015-10-17 12:33:55', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-10-17 12:33:55', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '2015110518004440877777740520.92030277693', '10.0.100.254', TO_DATE('2015-11-05 17:59:53', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('607000031', '607000031', '607000031', '607000031', 'b3cf6b3a2e2dd03cc42baea346de7c79', '1', 'N', 'A', TO_DATE('2015-10-20 08:26:23', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-10-20 08:26:23', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('607000032', '607000032', '607000032', '607000032', '512911b7df34e25b198a1d33816cc388', '1', 'N', 'A', TO_DATE('2015-10-20 08:27:34', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-10-20 08:27:34', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('1', '1', '1', '1', '7fa8282ad93047a4d6fe6111c93b308a', '1', 'N', 'A', TO_DATE('2015-10-28 10:39:03', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-11-05 14:53:59', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '20151117144802825179412.96499102077', '10.0.100.254', TO_DATE('2015-11-17 14:46:58', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('2', '2', '2', '2', '79d886010186eb60e3611cd4a5d0bcae', '1', 'N', 'A', TO_DATE('2015-10-28 10:40:01', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-10-28 10:40:01', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '201511031910250724188.658933041201', '10.0.100.254', TO_DATE('2015-11-03 19:10:15', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('4', '4', '4', '4', 'dcb64c94e1b81cd1cd3eb4a73ad27d99', '1', 'N', 'A', TO_DATE('2015-10-31 14:35:48', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-10-31 14:35:48', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '20151116203209220430760.450745571412', '10.0.100.254', TO_DATE('2015-11-16 20:31:05', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('3', '3', '3', '3', '074fd28eff0f5adea071694061739e55', '1', 'N', 'A', TO_DATE('2015-10-28 10:40:48', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-10-28 10:40:48', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '20151116204223539332153.613205056463', '10.0.100.254', TO_DATE('2015-11-16 20:41:19', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('888', '888', '888', '888', '134fb0bf3bdd54ee9098f4cbc4351b9a', '1', 'N', 'A', TO_DATE('2015-10-30 16:07:40', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-11-05 18:19:56', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '2015111714440687588811178.563299931544', '10.0.100.254', TO_DATE('2015-11-17 14:43:02', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('888888', '888888', '888888', '施一波', '154167043c863a4ef2381cfa5bfd4221', '1', 'N', 'A', TO_DATE('2015-10-29 10:06:42', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-11-05 14:43:33', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', '2015110714445940088888875493.57478512634', '10.0.100.254', TO_DATE('2015-11-07 14:44:06', 'YYYY-MM-DD HH24:MI:SS'), 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('111', '111', '111', '111', 'bbb8aae57c104cda40c93843ad5e6db8', '1', 'N', 'A', TO_DATE('2015-10-28 13:10:08', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-10-28 13:10:08', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');
INSERT INTO "TRADE_GNNT"."M_TRADER" VALUES ('2221', '2221', '2221', 'dd', '5ad7aa9ea64b7c05e525ab9eade6df98', '1', 'N', 'A', TO_DATE('2015-11-06 14:02:26', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-11-06 14:02:26', 'YYYY-MM-DD HH24:MI:SS'), '0123456789ABCDE', 'N', null, null, null, 'default');

-- ----------------------------
-- Table structure for M_TRADERMODULE
-- ----------------------------
DROP TABLE "TRADE_GNNT"."M_TRADERMODULE";
CREATE TABLE "TRADE_GNNT"."M_TRADERMODULE" (
"MODULEID" NUMBER(2) NOT NULL ,
"TRADERID" VARCHAR2(40 BYTE) NOT NULL ,
"ENABLED" CHAR(1 BYTE) DEFAULT 'N'  NOT NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON TABLE "TRADE_GNNT"."M_TRADERMODULE" IS '交易员在各个交易模块是否可用';
COMMENT ON COLUMN "TRADE_GNNT"."M_TRADERMODULE"."MODULEID" IS '10综合管理平台
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
COMMENT ON COLUMN "TRADE_GNNT"."M_TRADERMODULE"."ENABLED" IS 'Y：启用  N：禁用';

-- ----------------------------
-- Records of M_TRADERMODULE
-- ----------------------------
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '505000000000090', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '505000000000090', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '505000000000090', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '505000000000090', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '505000000000092', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '505000000000092', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '505000000000092', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '505000000000092', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '505000000000092', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '22222', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '22222', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '22222', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '22222', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '22222', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '33333', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '33333', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '33333', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '33333', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '33333', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '66666', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '66666', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '66666', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '66666', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '66666', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '10000', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '10000', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '10000', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '10000', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '10000', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '505000000000001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '505000000000001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '505000000000001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '505000000000001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '505000000000001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '505000000000001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '505000000000001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', 'PG001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', 'PG001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '606010003', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '606010003', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '606010003', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '606010003', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '606010003', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '606010003', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '606010003', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '606010005', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '606010005', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '606010005', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '606010005', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '606010005', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '606010005', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '606010005', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '000200002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '000200002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '000200002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '000200002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '000200002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '000200002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '000200002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '000301011', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '000301011', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '000301011', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '000301011', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '000301011', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '000301011', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '000301011', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '000301012', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '000301012', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '000301012', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '000301012', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '000301012', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '000301012', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '000301012', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', 'HMR02', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', 'HMR02', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', 'HMR02', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', 'HMR02', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', 'HMR02', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', 'HMR02', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', 'HMR02', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', 'HMR022', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', 'HMR022', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', 'HMR022', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', 'HMR022', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', 'HMR022', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', 'HMR022', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', 'HMR022', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', 'HMR025', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', 'HMR025', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', 'HMR025', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', 'HMR025', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', 'HMR025', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', 'HMR025', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', 'HMR025', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', 'xh0091', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', 'xh0091', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', 'xh0091', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', 'xh0091', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', 'xh0091', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', 'xh0091', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', 'xh0091', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', 'jsb002', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', 'jsb002', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', 'jsb002', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', 'jsb002', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', 'jsb002', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', 'jsb002', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', 'jsb002', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', 'jsb003', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', 'jsb003', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', 'jsb003', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', 'jsb003', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', 'jsb003', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', 'jsb003', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', 'jsb003', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '607000008', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '607000008', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '607000008', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '607000008', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '607000008', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '607000008', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '607000008', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '607000009', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '607000009', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '607000009', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '607000009', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '607000009', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '607000009', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '607000009', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '000200007', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '000200007', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '000200007', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '000200007', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '000200007', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '000200007', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '000200007', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '666', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '666', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '666', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '666', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('40', '666', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '666', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '666', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '182', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '182', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '182', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '182', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '182', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '182', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '182', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '607000022', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '607000022', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '607000022', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '607000022', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '607000022', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '607000023', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '607000023', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '607000023', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '607000023', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '607000023', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '607000023', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '607000023', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '111111', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '111111', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '111111', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '111111', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '111111', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '111111', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '111111', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', 'YXG', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', 'YXG', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', 'YXG', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', 'YXG', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', 'YXG', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', 'YXG', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', 'YXG', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '606000025', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '606000025', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '606000025', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '606000025', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '606000025', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '606000025', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '606000025', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '606000028', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '606000028', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '606000028', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '606000028', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '606000028', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '606000028', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '606000028', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '607000031', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '607000031', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '607000031', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '607000031', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '607000031', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '607000031', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '607000031', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '607000030', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '607000030', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '607000030', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '607000030', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '607000030', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '607000030', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '607000030', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '606000033', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '606000033', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '606000033', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '606000033', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '606000033', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '606000033', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '606000033', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '606000034', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '606000034', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '606000034', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '606000034', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '606000034', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '606000034', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '606000034', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '606000030', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '606000030', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '606000030', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '606000030', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '606000030', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '606000030', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '606000030', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '77777bb', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '77777bb', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '77777bb', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '77777bb', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '77777bb', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '77777bb', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '77777bb', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '607000032', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '607000032', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '607000032', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '607000032', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '607000032', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '607000032', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '607000032', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', 'xh011', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', 'xh011', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', 'xh011', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', 'xh011', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', 'xh011', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '505000000000003', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '505000000000003', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '505000000000003', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '505000000000003', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '505000000000003', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '0002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '0002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '0002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '0002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '0002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '505000000000012', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '505000000000012', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '505000000000012', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '505000000000012', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '505000000000012', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '11111', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '11111', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '11111', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '11111', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '11111', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '606010007', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '606010007', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '606010007', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '606010007', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '606010007', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '5050000000333', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '5050000000333', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '5050000000333', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '5050000000333', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '5050000000333', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '5050000000333', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '5050000000333', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', 'xh011', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', 'xh011', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', 'hyl', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', 'hyl', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', 'hyl', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', 'hyl', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', 'hyl', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', 'hyl', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', 'hyl', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '606010007', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '606010007', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', 'HMR023', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', 'HMR023', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', 'HMR023', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', 'HMR023', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', 'HMR023', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', 'HMR023', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', 'HMR023', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', 'HMR024', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', 'HMR024', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', 'HMR024', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', 'HMR024', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', 'HMR024', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', 'HMR024', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', 'HMR024', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '607', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '607', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '607', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '607', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '607', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '607', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '607', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '000200004', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '000200004', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '000200004', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '000200004', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '000200004', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '000200004', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '000200004', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', 'xh015', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', 'xh015', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', 'xh015', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', 'xh015', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', 'xh015', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', 'xh015', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', 'xh015', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', 'xh014', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', 'xh014', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', 'xh014', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', 'xh014', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', 'xh014', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', 'xh014', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', 'xh014', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '606010014', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '606010014', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '606010014', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '606010014', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '606010014', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '606010014', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '606010014', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '607000003', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '607000003', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '607000003', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '607000003', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '607000003', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '607000003', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '607000003', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '606000017', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '606000017', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '606000017', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '606000017', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '606000017', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '606000017', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '606000017', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '606000018', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '606000018', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '606000018', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '606000018', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '606000018', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '606000018', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '606000018', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '606000019', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '606000019', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '606000019', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '606000019', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '606000019', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '606000019', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '606000019', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '606000021', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '606000021', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '606000021', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '606000021', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '606000021', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '606000021', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '606000021', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '002000002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '002000002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '002000002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '002000002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '002000002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '002000002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '002000002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', 'hy001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', 'hy001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', 'hy001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', 'hy001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', 'hy001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', 'hy001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', 'hy001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '60600000100', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '60600000100', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '60600000100', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '60600000100', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '60600000100', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '60600000100', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '60600000100', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '622000000', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '622000000', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '622000000', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '622000000', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '622000000', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '622000000', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '622000000', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '606000031', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '606000031', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '606000031', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '606000031', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '606000031', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '606000031', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '606000031', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '606000032', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '606000032', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '606000032', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '606000032', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '606000032', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '606000032', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '606000032', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '777777', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '777777', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '777777', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '777777', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '777777', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '777777', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '777777', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '555555', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '555555', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '555555', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '555555', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '555555', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '555555', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '555555', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('30', '555555', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '222', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '222', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '222', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '222', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '222', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '222', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '222', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', 'test66', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', 'test66', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', 'test66', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', 'test66', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', 'test66', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', 'test66', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', 'test66', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '608000123', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '608000123', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '608000123', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '608000123', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '608000123', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '608000123', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '608000123', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '5050000000000010', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '5050000000000010', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '5050000000000010', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '5050000000000010', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '5050000000000010', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '5050000000000010', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '5050000000000010', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', 'xh005', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', 'xh005', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', 'xh005', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', 'xh005', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', 'xh005', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', 'xh005', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', 'xh005', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', 'xh009', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', 'xh009', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', 'xh009', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', 'xh009', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', 'xh009', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', 'xh009', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', 'xh009', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', 'Shimo004', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', 'Shimo004', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', 'Shimo004', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', 'Shimo004', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', 'Shimo004', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', 'Shimo004', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', 'Shimo004', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', 'Shimo005', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', 'Shimo005', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', 'Shimo005', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', 'Shimo005', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', 'Shimo005', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', 'Shimo005', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', 'Shimo005', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', 'xh012', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', 'xh012', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', 'xh012', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', 'xh012', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', 'xh012', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', 'xh012', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', 'xh012', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '505000000000010', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '505000000000010', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '505000000000010', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '505000000000010', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '505000000000010', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '505000000000010', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '505000000000010', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', 'xh013', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', 'xh013', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', 'xh013', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', 'xh013', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', 'xh013', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', 'xh013', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', 'xh013', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '112', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '112', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '112', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '112', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '112', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '112', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '112', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '60600000180', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '60600000180', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '60600000180', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '60600000180', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '60600000180', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '60600000180', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '60600000180', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '601002022', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '601002022', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '601002022', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '601002022', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '601002022', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '601002022', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '601002022', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '607000024', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '607000024', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '607000024', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '607000024', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '607000024', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '607000024', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '607000024', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '60600000111', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '60600000111', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '60600000111', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '60600000111', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '60600000111', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '60600000111', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '60600000111', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '606010001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '606010001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '606010001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '606010001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '606010001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '606010001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '606010001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '606010004', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '606010004', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '606010004', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '606010004', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '606010004', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '606010004', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '606010004', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '606010006', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '606010006', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '606010006', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '606010006', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '606010006', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '606010006', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '606010006', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '606010008', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '606010008', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '606010008', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '606010008', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '606010008', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '606010008', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '606010008', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '606010010', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '606010010', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '606010010', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '606010010', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '606010010', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '606010010', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '606010010', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', 'HMR01', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', 'HMR01', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', 'HMR01', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', 'HMR01', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', 'HMR01', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', 'HMR01', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', 'HMR01', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '606000016', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '606000016', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '606000016', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '606000016', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '606000016', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '606000016', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '606000016', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '606000020', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '606000020', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '606000020', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '606000020', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '606000020', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '606000020', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '606000020', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '000200006', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '000200006', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '000200006', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '000200006', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '000200006', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '000200006', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '000200006', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '607000004', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '607000004', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '607000004', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '607000004', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '607000004', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '607000004', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '607000004', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '607000005', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '607000005', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '607000005', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '607000005', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '607000005', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '607000005', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '607000005', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '618000000', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '618000000', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '618000000', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '618000000', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '618000000', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '618000000', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '618000000', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '000200008', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '000200008', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '000200008', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '000200008', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '000200008', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '000200008', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '000200008', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '607000011', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '607000011', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '607000011', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '607000011', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '607000011', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '607000011', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '607000011', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '607000021', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '607000021', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '607000021', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '607000021', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '607000021', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '607000021', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '607000021', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '607000025', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '607000025', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '607000025', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '607000025', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '607000025', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '607000025', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '607000025', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '606000024', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '606000024', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '606000024', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '606000024', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '606000024', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '606000024', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '606000024', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '607000026', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '607000026', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '607000026', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '607000026', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '607000026', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '607000026', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '607000026', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '607000027', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '607000027', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '607000027', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '607000027', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '607000027', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '607000027', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '607000027', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '607000028', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '607000028', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '607000028', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '607000028', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '607000028', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '607000028', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '607000028', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '607000029', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '607000029', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '607000029', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '607000029', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '607000029', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '607000029', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '607000029', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '606000026', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '606000026', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '606000026', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '606000026', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '606000026', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '606000026', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '606000026', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '606000027', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '606000027', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '606000027', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '606000027', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '606000027', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '606000027', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '606000027', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '606000029', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '606000029', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '606000029', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '606000029', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '606000029', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '606000029', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '606000029', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '505000000000002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '505000000000002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '505000000000002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '505000000000002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '505000000000002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '50500000100', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '50500000100', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '50500000100', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '50500000100', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '50500000100', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '505000000000007', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '505000000000007', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '505000000000007', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '505000000000007', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '505000000000007', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '505000000000005', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '505000000000005', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '505000000000005', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '505000000000005', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '505000000000005', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '126000000000108', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '126000000000108', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '126000000000108', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '126000000000108', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '126000000000108', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '606010000', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '606010000', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '606010000', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '606010000', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '606010000', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '505000000000007', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '505000000000005', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '606010000', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '126000000000108', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '601010001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '601010001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '601010001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '601010001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '601010001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '505000000000108', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '505000000000108', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '505000000000108', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '505000000000108', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '505000000000108', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '00812', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '00812', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '00812', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '00812', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '00812', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '601010002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '601010002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '601010002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '601010002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '601010002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '44444', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '44444', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '44444', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '44444', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '44444', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '55555', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '55555', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '55555', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '55555', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '55555', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '77777', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '77777', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '77777', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '77777', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '77777', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '88888', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '88888', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '88888', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '88888', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '88888', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '99999', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '99999', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '99999', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '99999', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '99999', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '505000000000006', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '505000000000006', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '505000000000006', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '505000000000006', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '505000000000006', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '505000000000006', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '505000000000006', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '608000333', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '608000333', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '608000333', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '608000333', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '608000333', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '608000333', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '608000333', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '505000000000002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '008013', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '505000000000108', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '601010001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '601010002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '44444', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '55555', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '77777', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '88888', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '99999', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '50500000100', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '50500000000009', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '505000000000088', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '505000000000089', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '606', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '0081', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '505000000000008', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '00812', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', 'test1', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '505000000000110', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '505000000000004', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '505000000000090', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '505000000000091', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '505000000000092', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '22222', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '33333', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '66666', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '10000', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '505000000000003', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '505000000000012', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '11111', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '0002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '505000000000002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '505000000000007', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '505000000000005', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '606010000', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '126000000000108', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '008013', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '505000000000108', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '601010001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '601010002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '44444', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '55555', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '77777', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '88888', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '99999', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '50500000100', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '50500000000009', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '505000000000088', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '505000000000089', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '606', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '0081', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '505000000000008', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '00812', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', 'test1', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '505000000000110', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '505000000000004', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '505000000000090', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '505000000000091', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '505000000000092', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '22222', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '33333', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '66666', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '10000', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '505000000000003', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '505000000000012', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '11111', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '0002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', 'xh001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', 'xh001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', 'xh001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', 'xh001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', 'xh001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', 'xh001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', 'xh001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', 'xh006', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', 'xh006', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', 'xh006', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', 'xh006', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', 'xh006', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', 'xh006', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', 'xh006', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', 'Shimo001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', 'Shimo001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', 'Shimo001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', 'Shimo001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', 'Shimo001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', 'Shimo001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', 'Shimo001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', 'Shimo002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', 'Shimo002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', 'Shimo002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', 'Shimo002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', 'Shimo002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', 'Shimo002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', 'Shimo002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', 'Shimo003', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', 'Shimo003', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', 'Shimo003', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', 'Shimo003', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', 'Shimo003', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', 'Shimo003', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', 'Shimo003', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '008', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '008', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '008', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '008', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '008', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '008', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '008', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '60600000110', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '60600000110', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '60600000110', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '60600000110', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '60600000110', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '60600000110', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '60600000110', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '606000001', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '606000001', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '606000001', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '606000001', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '606000001', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '606000001', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '606000001', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '606000002', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '606000002', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '606000002', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '606000002', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '606000002', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '606000002', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '606000002', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '606000008', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '606000008', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '606000008', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '606000008', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '606000008', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '606000008', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '606000008', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '606010009', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '606010009', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '606010009', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '606010009', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '606010009', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '606010009', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '606010009', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '000210341', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '000210341', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '000210341', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '000210341', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '000210341', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '000210341', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '000210341', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '606000012', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '606000012', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '606000012', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '606000012', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '606000012', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '606000012', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '606000012', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '606000013', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '606000013', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '606000013', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '606000013', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '606000013', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '606000013', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '606000013', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '606010013', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '606010013', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '606010013', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '606010013', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '606010013', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '606010013', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '606010013', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '606000014', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '606000014', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '606000014', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '606000014', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '606000014', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '606000014', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '606000014', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '607000001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '607000001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '607000001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '607000001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '607000001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '607000001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '607000001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '607020001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '607020001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '607020001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '607020001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '607020001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '607020001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '607020001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '607000002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '607000002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '607000002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '607000002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '607000002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '607000002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '607000002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '607000006', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '607000006', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '607000006', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '607000006', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '607000006', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '607000006', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '607000006', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '607000007', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '607000007', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '607000007', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '607000007', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '607000007', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '607000007', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '607000007', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '609000000', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '609000000', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '609000000', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '609000000', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '609000000', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '609000000', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '609000000', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '101000005000579', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '101000005000579', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '101000005000579', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '101000005000579', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '101000005000579', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '101000005000579', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '101000005000579', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '505000000000088', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '505000000000088', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '505000000000088', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '505000000000088', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '505000000000088', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '50500000000009', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '50500000000009', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '50500000000009', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '50500000000009', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '50500000000009', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '505000000000089', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '505000000000089', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '505000000000089', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '505000000000089', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '505000000000089', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '606', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '606', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '606', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '606', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '606', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '00030101', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '00030101', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '00030101', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '00030101', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '00030101', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '00030101', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '00030101', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '0001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '0001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '0001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '0001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '0001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '0001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '0001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', 'xh002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', 'xh002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', 'xh002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', 'xh002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', 'xh002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', 'xh002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', 'xh002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', 'xh003', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', 'xh003', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', 'xh003', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', 'xh003', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', 'xh003', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', 'xh003', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', 'xh003', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', 'xh004', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', 'xh004', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', 'xh004', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', 'xh004', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', 'xh004', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', 'xh004', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', 'xh004', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', 'xh007', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', 'xh007', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', 'xh007', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', 'xh007', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', 'xh007', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', 'xh007', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', 'xh007', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', 'xh008', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', 'xh008', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', 'xh008', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', 'xh008', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', 'xh008', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', 'xh008', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', 'xh008', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', 'xh010', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', 'xh010', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', 'xh010', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', 'xh010', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', 'xh010', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', 'xh010', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', 'xh010', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '606010002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '606010002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '606010002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '606010002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '606010002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '606010002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '606010002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '000200001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '000200001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '000200001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '000200001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '000200001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '000200001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '000200001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '606000009', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '606000009', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '606000009', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '606000009', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '606000009', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '606000009', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '606000009', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '606000011', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '606000011', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '606000011', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '606000011', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '606000011', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '606000011', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '606000011', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '000200003', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '000200003', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '000200003', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '000200003', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '000200003', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '000200003', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '000200003', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '606010012', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '606010012', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '606010012', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '606010012', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '606010012', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '606010012', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '606010012', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '444', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '444', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '444', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '444', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '444', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '444', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '444', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '505000000000105', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '505000000000105', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '505000000000105', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '505000000000105', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '505000000000105', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '505000000000105', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '505000000000105', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '000301013', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '000301013', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '000301013', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '000301013', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '000301013', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '000301013', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '000301013', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '606000001801', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '606000001801', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '606000001801', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '606000001801', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '606000001801', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '606000001801', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '606000001801', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', 'HMR021', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', 'HMR021', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', 'HMR021', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', 'HMR021', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', 'HMR021', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', 'HMR021', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', 'HMR021', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', 'HMR026', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', 'HMR026', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', 'HMR026', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', 'HMR026', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', 'HMR026', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', 'HMR026', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', 'HMR026', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '607010001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '607010001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '607010001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '607010001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '607010001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '607010001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '607010001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '607020002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '607020002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '607020002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '607020002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '607020002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '607020002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '607020002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '607010002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '607010002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '607010002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '607010002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '607010002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '607010002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '607010002', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '606000015', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '606000015', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '606000015', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '606000015', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '606000015', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '606000015', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '606000015', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '020000001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '020000001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '020000001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '020000001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '020000001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '020000001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '020000001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '606010015', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '606010015', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '606010015', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '606010015', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '606010015', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '606010015', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '606010015', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '002000001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '002000001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '002000001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '002000001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '002000001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '002000001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '002000001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '000200005', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '000200005', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '000200005', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '000200005', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '000200005', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '000200005', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '000200005', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '000100001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '000100001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '000100001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '000100001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '000100001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '000100001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '000100001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '002000003', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '002000003', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '002000003', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '002000003', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '002000003', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '002000003', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '002000003', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '607000010', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '607000010', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '607000010', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '607000010', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '607000010', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '607000010', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '607000010', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '001', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '001', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '001', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '001', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '001', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '001', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '001', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '606000022', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '606000022', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '606000022', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '606000022', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '606000022', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '606000022', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '606000022', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', 'ceshi1', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', 'ceshi1', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', 'ceshi1', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', 'ceshi1', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', 'ceshi1', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', 'ceshi1', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', 'ceshi1', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', 'h1', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', 'h1', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', 'h1', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', 'h1', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', 'h1', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', 'h1', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', 'h1', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', 'h2', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', 'h2', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', 'h2', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', 'h2', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', 'h2', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', 'h2', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', 'h2', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '607000012', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '607000012', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '607000012', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '607000012', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '607000012', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '607000012', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '607000012', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '607000018', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '607000018', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '607000018', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '607000018', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '607000018', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '607000018', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '607000018', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '183', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '183', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '183', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '183', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '183', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '183', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '183', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '607000019', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '607000019', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '607000019', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '607000019', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '607000019', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '607000019', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '607000019', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '607000020', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '607000020', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '607000020', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '607000020', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '607000020', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '607000020', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '607000020', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '000200009', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '000200009', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '000200009', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '000200009', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '000200009', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '000200009', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '000200009', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '606000023', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '606000023', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '606000023', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '606000023', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '606000023', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '606000023', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '606000023', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '607000022', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '607000022', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', 'PG001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', 'PG001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', 'PG001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', 'PG001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', 'PG001', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '0081', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '0081', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '0081', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '0081', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '0081', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '505000000000008', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '505000000000008', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '505000000000008', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '505000000000008', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '505000000000008', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '505000000000091', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '505000000000091', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '505000000000091', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '505000000000091', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '505000000000091', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '008013', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '008013', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '008013', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '008013', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '008013', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', 'test1', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', 'test1', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', 'test1', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', 'test1', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', 'test1', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '505000000000110', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '505000000000110', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '505000000000110', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '505000000000110', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '505000000000110', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '505000000000004', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '505000000000004', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '505000000000004', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '505000000000004', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '505000000000004', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '505000000000090', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '3', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '3', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '3', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '3', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '3', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '3', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '3', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '4', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '4', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '4', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '4', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '4', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '4', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '4', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '111', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '111', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '111', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '111', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '111', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '111', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', '111', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '888', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '888', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '888', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '888', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('40', '888', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '888', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '888', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '2221', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '2221', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '2221', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('40', '2221', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '2221', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '2221', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '2221', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('23', 'hl', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', 'hl', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', 'hl', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', 'hl', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', 'hl', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', 'hl', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', 'hl', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('30', 'hl', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '6', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '6', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '6', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('40', '6', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '6', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '6', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '6', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('40', '7', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '7', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '7', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '7', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '7', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '7', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '7', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('40', '22', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '22', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '22', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '22', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '22', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '22', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '22', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '0', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '0', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '0', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('40', '0', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '0', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '0', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '0', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', 'a', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', 'a', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', 'a', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', 'a', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('40', 'a', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', 'a', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', 'a', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('40', '1', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '1', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '1', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '1', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '1', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '1', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '1', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('40', '000', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '000', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '000', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '000', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '000', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '000', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '000', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '222222', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('40', '222222', 'N');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '222222', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '222222', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '222222', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '222222', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '222222', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '888888', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '888888', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '888888', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '888888', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '888888', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '888888', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('40', '888888', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('10', '999999', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('40', '999999', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('21', '999999', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('13', '999999', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('28', '999999', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('15', '999999', 'Y');
INSERT INTO "TRADE_GNNT"."M_TRADERMODULE" VALUES ('11', '999999', 'Y');

-- ----------------------------
-- Table structure for M_ZONE
-- ----------------------------
DROP TABLE "TRADE_GNNT"."M_ZONE";
CREATE TABLE "TRADE_GNNT"."M_ZONE" (
"CODE" VARCHAR2(16 BYTE) NOT NULL ,
"NAME" VARCHAR2(32 BYTE) NOT NULL ,
"ISVISIBAL" CHAR(1 BYTE) DEFAULT 'Y'  NOT NULL ,
"SORTNO" NUMBER(2) DEFAULT 0  NOT NULL 
)
LOGGING
NOCOMPRESS
NOCACHE

;
COMMENT ON COLUMN "TRADE_GNNT"."M_ZONE"."ISVISIBAL" IS 'Y 显示 N 不显示';

-- ----------------------------
-- Records of M_ZONE
-- ----------------------------
INSERT INTO "TRADE_GNNT"."M_ZONE" VALUES ('JSNJ', '南京', 'Y', '3');
INSERT INTO "TRADE_GNNT"."M_ZONE" VALUES ('JS', '江苏', 'Y', '1');
INSERT INTO "TRADE_GNNT"."M_ZONE" VALUES ('WX', '江苏省无锡市', 'Y', '2');

-- ----------------------------
-- Indexes structure for table M_AGENTTRADER
-- ----------------------------

-- ----------------------------
-- Checks structure for table M_AGENTTRADER
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."M_AGENTTRADER" ADD CHECK ("AGENTTRADERID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_AGENTTRADER" ADD CHECK ("PASSWORD" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_AGENTTRADER" ADD CHECK ("TYPE" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_AGENTTRADER" ADD CHECK ("STATUS" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table M_AGENTTRADER
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."M_AGENTTRADER" ADD PRIMARY KEY ("AGENTTRADERID");

-- ----------------------------
-- Indexes structure for table M_BREED
-- ----------------------------

-- ----------------------------
-- Checks structure for table M_BREED
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."M_BREED" ADD CHECK ("BREEDID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_BREED" ADD CHECK ("BREEDNAME" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_BREED" ADD CHECK ("UNIT" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_BREED" ADD CHECK ("TRADEMODE" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_BREED" ADD CHECK ("CATEGORYID" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table M_BREED
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."M_BREED" ADD PRIMARY KEY ("BREEDID");

-- ----------------------------
-- Indexes structure for table M_BREEDPROPS
-- ----------------------------

-- ----------------------------
-- Checks structure for table M_BREEDPROPS
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."M_BREEDPROPS" ADD CHECK ("BREEDID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_BREEDPROPS" ADD CHECK ("PROPERTYID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_BREEDPROPS" ADD CHECK ("PROPERTYVALUE" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_BREEDPROPS" ADD CHECK ("SORTNO" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table M_BREEDPROPS
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."M_BREEDPROPS" ADD PRIMARY KEY ("BREEDID", "PROPERTYID", "PROPERTYVALUE");

-- ----------------------------
-- Indexes structure for table M_CATEGORY
-- ----------------------------

-- ----------------------------
-- Checks structure for table M_CATEGORY
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."M_CATEGORY" ADD CHECK ("CATEGORYID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_CATEGORY" ADD CHECK ("CATEGORYNAME" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_CATEGORY" ADD CHECK ("TYPE" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_CATEGORY" ADD CHECK ("SORTNO" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_CATEGORY" ADD CHECK ("ISOFFSET" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_CATEGORY" ADD CHECK ("OFFSETRATE" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table M_CATEGORY
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."M_CATEGORY" ADD PRIMARY KEY ("CATEGORYID");

-- ----------------------------
-- Indexes structure for table M_CERTIFICATETYPE
-- ----------------------------

-- ----------------------------
-- Checks structure for table M_CERTIFICATETYPE
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."M_CERTIFICATETYPE" ADD CHECK ("CODE" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_CERTIFICATETYPE" ADD CHECK ("NAME" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_CERTIFICATETYPE" ADD CHECK ("ISVISIBAL" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_CERTIFICATETYPE" ADD CHECK ("SORTNO" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table M_CERTIFICATETYPE
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."M_CERTIFICATETYPE" ADD PRIMARY KEY ("CODE");

-- ----------------------------
-- Checks structure for table M_ERRORLOGINLOG
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."M_ERRORLOGINLOG" ADD CHECK ("TRADERID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_ERRORLOGINLOG" ADD CHECK ("LOGINDATE" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_ERRORLOGINLOG" ADD CHECK ("MODULEID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_ERRORLOGINLOG" ADD CHECK ("IP" IS NOT NULL);

-- ----------------------------
-- Indexes structure for table M_FIRM
-- ----------------------------

-- ----------------------------
-- Checks structure for table M_FIRM
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."M_FIRM" ADD CHECK ("FIRMID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_FIRM" ADD CHECK ("NAME" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_FIRM" ADD CHECK ("TYPE" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_FIRM" ADD CHECK ("CONTACTMAN" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_FIRM" ADD CHECK ("CERTIFICATETYPE" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_FIRM" ADD CHECK ("CERTIFICATENO" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_FIRM" ADD CHECK ("MOBILE" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_FIRM" ADD CHECK ("FIRMCATEGORYID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_FIRM" ADD CHECK ("CREATETIME" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_FIRM" ADD CHECK ("STATUS" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table M_FIRM
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."M_FIRM" ADD PRIMARY KEY ("FIRMID");

-- ----------------------------
-- Indexes structure for table M_FIRM_APPLY
-- ----------------------------

-- ----------------------------
-- Checks structure for table M_FIRM_APPLY
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."M_FIRM_APPLY" ADD CHECK ("APPLYID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_FIRM_APPLY" ADD CHECK ("USERID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_FIRM_APPLY" ADD CHECK ("NAME" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_FIRM_APPLY" ADD CHECK ("CREATETIME" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_FIRM_APPLY" ADD CHECK ("STATUS" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table M_FIRM_APPLY
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."M_FIRM_APPLY" ADD PRIMARY KEY ("APPLYID");

-- ----------------------------
-- Indexes structure for table M_FIRMCATEGORY
-- ----------------------------

-- ----------------------------
-- Checks structure for table M_FIRMCATEGORY
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."M_FIRMCATEGORY" ADD CHECK ("ID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_FIRMCATEGORY" ADD CHECK ("NAME" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_FIRMCATEGORY" ADD CHECK ("ISVISIBAL" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_FIRMCATEGORY" ADD CHECK ("SORTNO" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table M_FIRMCATEGORY
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."M_FIRMCATEGORY" ADD PRIMARY KEY ("ID");

-- ----------------------------
-- Indexes structure for table M_FIRMMODULE
-- ----------------------------

-- ----------------------------
-- Checks structure for table M_FIRMMODULE
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."M_FIRMMODULE" ADD CHECK ("MODULEID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_FIRMMODULE" ADD CHECK ("FIRMID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_FIRMMODULE" ADD CHECK ("ENABLED" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table M_FIRMMODULE
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."M_FIRMMODULE" ADD PRIMARY KEY ("MODULEID", "FIRMID");

-- ----------------------------
-- Indexes structure for table M_INDUSTRY
-- ----------------------------

-- ----------------------------
-- Checks structure for table M_INDUSTRY
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."M_INDUSTRY" ADD CHECK ("CODE" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_INDUSTRY" ADD CHECK ("NAME" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_INDUSTRY" ADD CHECK ("ISVISIBAL" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_INDUSTRY" ADD CHECK ("SORTNO" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table M_INDUSTRY
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."M_INDUSTRY" ADD PRIMARY KEY ("CODE");

-- ----------------------------
-- Indexes structure for table M_MESSAGE
-- ----------------------------

-- ----------------------------
-- Checks structure for table M_MESSAGE
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."M_MESSAGE" ADD CHECK ("MESSAGEID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_MESSAGE" ADD CHECK ("MESSAGE" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_MESSAGE" ADD CHECK ("RECIEVERTYPE" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_MESSAGE" ADD CHECK ("USERID" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table M_MESSAGE
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."M_MESSAGE" ADD PRIMARY KEY ("MESSAGEID");

-- ----------------------------
-- Indexes structure for table M_NOTICE
-- ----------------------------

-- ----------------------------
-- Checks structure for table M_NOTICE
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."M_NOTICE" ADD CHECK ("NOTICEID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_NOTICE" ADD CHECK ("TITLE" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_NOTICE" ADD CHECK ("USERID" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table M_NOTICE
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."M_NOTICE" ADD PRIMARY KEY ("NOTICEID");

-- ----------------------------
-- Indexes structure for table M_PROCEDURES_ERRORCODE
-- ----------------------------

-- ----------------------------
-- Checks structure for table M_PROCEDURES_ERRORCODE
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."M_PROCEDURES_ERRORCODE" ADD CHECK ("MODULEID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_PROCEDURES_ERRORCODE" ADD CHECK ("ERRORCODE" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table M_PROCEDURES_ERRORCODE
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."M_PROCEDURES_ERRORCODE" ADD PRIMARY KEY ("MODULEID", "ERRORCODE");

-- ----------------------------
-- Indexes structure for table M_PROPERTY
-- ----------------------------
CREATE INDEX "TRADE_GNNT"."UK_M_PROPERTY"
ON "TRADE_GNNT"."M_PROPERTY" ("CATEGORYID" ASC, "PROPERTYNAME" ASC)
LOGGING
VISIBLE;

-- ----------------------------
-- Checks structure for table M_PROPERTY
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."M_PROPERTY" ADD CHECK ("PROPERTYID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_PROPERTY" ADD CHECK ("CATEGORYID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_PROPERTY" ADD CHECK ("PROPERTYNAME" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_PROPERTY" ADD CHECK ("HASVALUEDICT" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_PROPERTY" ADD CHECK ("STOCKCHECK" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_PROPERTY" ADD CHECK ("SEARCHABLE" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_PROPERTY" ADD CHECK ("SORTNO" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_PROPERTY" ADD CHECK ("ISNECESSARY" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_PROPERTY" ADD CHECK ("FIELDTYPE" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_PROPERTY" ADD CHECK ("PROPERTYTYPEID" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table M_PROPERTY
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."M_PROPERTY" ADD PRIMARY KEY ("PROPERTYID");

-- ----------------------------
-- Indexes structure for table M_PROPERTYTYPE
-- ----------------------------

-- ----------------------------
-- Checks structure for table M_PROPERTYTYPE
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."M_PROPERTYTYPE" ADD CHECK ("PROPERTYTYPEID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_PROPERTYTYPE" ADD CHECK ("NAME" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_PROPERTYTYPE" ADD CHECK ("STATUS" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_PROPERTYTYPE" ADD CHECK ("SORTNO" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table M_PROPERTYTYPE
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."M_PROPERTYTYPE" ADD PRIMARY KEY ("PROPERTYTYPEID");

-- ----------------------------
-- Indexes structure for table M_SYSTEMPROPS
-- ----------------------------

-- ----------------------------
-- Checks structure for table M_SYSTEMPROPS
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."M_SYSTEMPROPS" ADD CHECK ("KEY" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_SYSTEMPROPS" ADD CHECK ("VALUE" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_SYSTEMPROPS" ADD CHECK ("FIRMIDLENGTH" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table M_SYSTEMPROPS
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."M_SYSTEMPROPS" ADD PRIMARY KEY ("KEY");

-- ----------------------------
-- Indexes structure for table M_TRADER
-- ----------------------------

-- ----------------------------
-- Checks structure for table M_TRADER
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."M_TRADER" ADD CHECK ("TRADERID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_TRADER" ADD CHECK ("FIRMID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_TRADER" ADD CHECK ("NAME" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_TRADER" ADD CHECK ("PASSWORD" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_TRADER" ADD CHECK ("FORCECHANGEPWD" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_TRADER" ADD CHECK ("STATUS" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_TRADER" ADD CHECK ("TYPE" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_TRADER" ADD CHECK ("ENABLEKEY" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_TRADER" ADD CHECK ("SKIN" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table M_TRADER
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."M_TRADER" ADD PRIMARY KEY ("TRADERID");

-- ----------------------------
-- Indexes structure for table M_TRADERMODULE
-- ----------------------------

-- ----------------------------
-- Checks structure for table M_TRADERMODULE
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."M_TRADERMODULE" ADD CHECK ("MODULEID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_TRADERMODULE" ADD CHECK ("TRADERID" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_TRADERMODULE" ADD CHECK ("ENABLED" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table M_TRADERMODULE
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."M_TRADERMODULE" ADD PRIMARY KEY ("MODULEID", "TRADERID");

-- ----------------------------
-- Indexes structure for table M_ZONE
-- ----------------------------

-- ----------------------------
-- Checks structure for table M_ZONE
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."M_ZONE" ADD CHECK ("CODE" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_ZONE" ADD CHECK ("NAME" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_ZONE" ADD CHECK ("ISVISIBAL" IS NOT NULL);
ALTER TABLE "TRADE_GNNT"."M_ZONE" ADD CHECK ("SORTNO" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table M_ZONE
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."M_ZONE" ADD PRIMARY KEY ("CODE");

-- ----------------------------
-- Foreign Key structure for table "TRADE_GNNT"."M_BREED"
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."M_BREED" ADD FOREIGN KEY ("CATEGORYID") REFERENCES "TRADE_GNNT"."M_CATEGORY" ("CATEGORYID") DISABLE;

-- ----------------------------
-- Foreign Key structure for table "TRADE_GNNT"."M_BREEDPROPS"
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."M_BREEDPROPS" ADD FOREIGN KEY ("BREEDID") REFERENCES "TRADE_GNNT"."M_BREED" ("BREEDID") DISABLE;
ALTER TABLE "TRADE_GNNT"."M_BREEDPROPS" ADD FOREIGN KEY ("PROPERTYID") REFERENCES "TRADE_GNNT"."M_PROPERTY" ("PROPERTYID") DISABLE;

-- ----------------------------
-- Foreign Key structure for table "TRADE_GNNT"."M_PROPERTY"
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."M_PROPERTY" ADD FOREIGN KEY ("CATEGORYID") REFERENCES "TRADE_GNNT"."M_CATEGORY" ("CATEGORYID") DISABLE;
ALTER TABLE "TRADE_GNNT"."M_PROPERTY" ADD FOREIGN KEY ("PROPERTYTYPEID") REFERENCES "TRADE_GNNT"."M_PROPERTYTYPE" ("PROPERTYTYPEID") DISABLE;

-- ----------------------------
-- Foreign Key structure for table "TRADE_GNNT"."M_TRADER"
-- ----------------------------
ALTER TABLE "TRADE_GNNT"."M_TRADER" ADD FOREIGN KEY ("FIRMID") REFERENCES "TRADE_GNNT"."M_FIRM" ("FIRMID") DISABLE;
