
INSERT INTO "TRADE_GNNT"."L_MODULEANDAU" ("MODULEID", "CONFIGID") VALUES ('40', '199001');
INSERT INTO "TRADE_GNNT"."L_MODULEANDAU" ("MODULEID", "CONFIGID") VALUES ('40', '223001');


INSERT INTO "TRADE_GNNT"."C_TRADEMODULE" VALUES ('40', 'IPO', 'ipo', 'IPO', null, null, null, 'Y', null, null, null, 'N', 'N');




INSERT INTO "TRADE_GNNT"."C_DEPLOY_CONFIG" VALUES ('40', 'ipo_mgr', 'ipo_mgr.png', null, '/mgr/frame/mainframe_nohead.jsp', null, null, null, 'mgr', '40');
INSERT INTO "TRADE_GNNT"."C_DEPLOY_CONFIG" VALUES ('40', 'ipo_front', 'ico_ipo.png', null, '/front/frame/mainframe.jsp', null, null, null, 'front', '40');


--借用espot的认证服务
INSERT INTO "TRADE_GNNT"."L_AUCONFIG" VALUES ('223001', '172.17.12.22', '31111', '31112', 'EspotFront', '1', 'front');

INSERT INTO "TRADE_GNNT"."C_LOGCATALOG" VALUES ('4001', '40', 'IPO系统');

INSERT INTO "TRADE_GNNT"."BR_BROKERTYPE" VALUES ('1', '发行会员');
INSERT INTO "TRADE_GNNT"."BR_BROKERTYPE" VALUES ('2', '承销会员');

INSERT INTO "TRADE_GNNT"."W_TRADEMODULE" VALUES ('40', 'ipo', '发售仓库', '发售仓库', NULL, NULL, NULL, 'N', NULL, NULL, NULL, 'N', 'Y');
INSERT INTO "TRADE_GNNT"."W_LOGCATALOG"  VALUES ('4001', '40', 'IPO系统');
INSERT INTO "TRADE_GNNT"."C_DEPLOY_CONFIG" VALUES ('40', 'ipo_warehouse', 'ipo_mgr.png', NULL, '/mgr/frame/mainframe_nohead.jsp', NULL, NULL, NULL, 'warehouse', '40');

