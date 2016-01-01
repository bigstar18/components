INSERT INTO "TRADE_GNNT"."C_TRADEMODULE" VALUES ('21', '竞价系统', 'vendue', '竞价管理系统', 'FN_V_FirmAdd', NULL, 'FN_V_FirmDel', 'Y', '172.17.12.22', '20871', '20872', 'Y', 'Y');

INSERT INTO "TRADE_GNNT"."L_MODULEANDAU" VALUES ('21', '199001')
INSERT INTO "TRADE_GNNT"."L_MODULEANDAU" VALUES ('21', '221001')

INSERT INTO "TRADE_GNNT"."L_AUCONFIG" VALUES ('199001', '172.17.12.22', '30171', '30172', 'CommonMgr', '1', 'mgr')
INSERT INTO "TRADE_GNNT"."L_AUCONFIG" VALUES ('221001', '172.17.12.22', '30671', '30672', 'VendueFront', '1', 'front')

INSERT INTO "TRADE_GNNT"."C_DEPLOY_CONFIG" VALUES ('21', 'vendue_front', 'vendue_front.png', NULL, '/front/app/vendue/vendue1_nkst/submit/main.jsp', NULL, NULL, NULL, 'front', '21')
INSERT INTO "TRADE_GNNT"."C_DEPLOY_CONFIG" VALUES ('21', 'vendue_mgr', 'vendue_mgr.png', NULL, '/mgr/frame/mainframe_nohead.jsp', NULL, NULL, NULL, 'mgr', '21')

INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2101000000', '9900000000', '竞价交易', NULL, '/front/app/*', NULL, '21', '1', '0', '1', '0', 'N')
INSERT INTO "TRADE_GNNT"."C_FRONT_RIGHT" VALUES ('2101000001', '2101000000', '竞价交易', NULL, '/dwr*', NULL, '21', '3', '0', '1', '0', 'N')


INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101000000', '9900000000', '竞价系统', NULL, NULL, NULL, '21', '0', '0', '-1', '0', 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101010000', '2101000000', '交易系统管理', '42_42.gif', NULL, NULL, '21', '1', '0', '-1', '0', 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101020000', '2101000000', '交易商设置', '42_42.gif', NULL, NULL, '21', '2', '0', '-1', '0', 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030000', '2101000000', '商品管理', '42_42.gif', NULL, NULL, '21', '3', '0', '-1', '0', 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101040000', '2101000000', '交易查询', '42_42.gif', NULL, NULL, '21', '4', '0', '-1', '0', 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101060000', '2101000000', '合同管理', '42_42.gif', NULL, NULL, '21', '5', '0', '-1', '0', 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101010100', '2101010000', '系统版块配置', '29_29.gif', '/vendue/syspartition/list.action*', '/vendue/syspartition/list.action', '21', '1', '0', '0', '0', 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101010200', '2101010000', '默认交易节设置', '29_29.gif', '/mgr/app/vendue/system/frame/sysFlowControlMgrFrame.jsp', '/mgr/app/vendue/system/frame/sysFlowControlMgrFrame.jsp', '21', '2', '0', '0', '0', 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101010300', '2101010000', '交易节设置', '29_29.gif', '/mgr/app/vendue/system/frame/flowControlMgrFrame.jsp', '/mgr/app/vendue/system/frame/flowControlMgrFrame.jsp', '21', '3', '0', '0', '0', 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101010400', '2101010000', '交易管理', '29_29.gif', '/mgr/app/vendue/system/frame/tradeMgrFrame.jsp', '/mgr/app/vendue/system/frame/tradeMgrFrame.jsp', '21', '4', '0', '0', '0', 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101010500', '2101010000', '招标成交处理', '29_29.gif', '/mgr/app/vendue/system/frame/tenderSubmitMgrFrame.jsp', '/mgr/app/vendue/system/frame/tenderSubmitMgrFrame.jsp', '21', '5', '0', '0', '0', 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101020100', '2101020000', '交易商列表', '29_29.gif', '/vendue/tradeUser/tradeUserList.action', '/vendue/tradeUser/tradeUserList.action', '21', '1', '0', '0', '0', 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101020200', '2101020000', '交易权限', '29_29.gif', '/vendue/tradeAuthority/tradeAuthorityList.action', '/vendue/tradeAuthority/tradeAuthorityList.action', '21', '2', '0', '0', '0', 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101020300', '2101020000', '特殊设置', '29_29.gif', '/mgr/app/vendue/firmSet/frame/specialSetFrame.jsp', '/mgr/app/vendue/firmSet/frame/specialSetFrame.jsp', '21', '3', '0', '0', '0', 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030100', '2101030000', '商品默认设置', '29_29.gif', '/mgr/app/vendue/commodity/frame/commodityParamsFrame.jsp', '/mgr/app/vendue/commodity/frame/commodityParamsFrame.jsp', '21', '1', '0', '0', '0', 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030200', '2101030000', '所有商品列表', '29_29.gif', '/mgr/app/vendue/commodity/frame/commoditiesFrame.jsp', '/mgr/app/vendue/commodity/frame/commoditiesFrame.jsp', '21', '2', '0', '0', '0', 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030300', '2101030000', '商品审核', '29_29.gif', '/mgr/app/vendue/commodity/frame/commodityAuditFrame.jsp', '/mgr/app/vendue/commodity/frame/commodityAuditFrame.jsp', '21', '3', '0', '0', '0', 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030400', '2101030000', '当前交易商品', '29_29.gif', '/mgr/app/vendue/commodity/frame/curCommodityFrame.jsp', '/mgr/app/vendue/commodity/frame/curCommodityFrame.jsp', '21', '4', '0', '0', '0', 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030500', '2101030000', '历史商品列表', '29_29.gif', '/mgr/app/vendue/commodity/frame/hisCommodityFrame.jsp', '/mgr/app/vendue/commodity/frame/hisCommodityFrame.jsp', '21', '5', '0', '0', '0', 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101040100', '2101040000', '当前成交查询', '29_29.gif', '/mgr/app/vendue/bargain/frame/BargainMgrFrame.jsp', '/mgr/app/vendue/bargain/frame/BargainMgrFrame.jsp', '21', '1', '0', '0', '0', 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101040200', '2101040000', '当前报单查询', '29_29.gif', '/mgr/app/vendue/bargain/frame/CurSubmitMgrFrame.jsp', '/mgr/app/vendue/bargain/frame/CurSubmitMgrFrame.jsp', '21', '2', '0', '0', '0', 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101040300', '2101040000', '历史成交查询', '29_29.gif', '/mgr/app/vendue/bargain/frame/HisBargainMgrFrame.jsp', '/mgr/app/vendue/bargain/frame/HisBargainMgrFrame.jsp', '21', '3', '0', '0', '0', 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101040400', '2101040000', '历史报单查询', '29_29.gif', '/mgr/app/vendue/bargain/frame/HisSubmitMgrFrame.jsp', '/mgr/app/vendue/bargain/frame/HisSubmitMgrFrame.jsp', '21', '4', '0', '0', '0', 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101060100', '2101060000', '合同处理', '29_29.gif', '/mgr/app/vendue/bargainManager/frame/HisBargainMgrFrame.jsp', '/mgr/app/vendue/bargainManager/frame/HisBargainMgrFrame.jsp', '21', '1', '0', '0', '0', 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101010101', '2101010100', '修改系统板块设置跳转', NULL, '/vendue/syspartition/viewById.action*', NULL, '21', '2', '0', '1', '0', 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101010102', '2101010100', '修改系统板块设置', NULL, '/vendue/syspartition/update.action*', NULL, '21', '2', '0', '1', '2103', 'Y')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030103', '2101030100', '商品默认设置添加', NULL, '/vendue/commodityparams/add.action', NULL, '21', NULL, '0', '1', '2015', 'Y')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030104', '2101030100', '商品默认设置批量删除', NULL, '/vendue/commodityparams/deleteList.action', NULL, '21', NULL, '0', '1', '2015', 'Y')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030105', '2101030100', '商品默认设置修改跳转', NULL, '/vendue/commodityparams/viewById.action', NULL, '21', NULL, '0', '1', '0', 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030106', '2101030100', '商品默认设置修改', NULL, '/vendue/commodityparams/update.action', NULL, '21', NULL, '0', '1', '2015', 'Y')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030101', '2101030100', '商品默认设置查询', NULL, '/vendue/commodityparams/list.action', NULL, '21', NULL, '0', '1', '0', 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030102', '2101030100', '商品默认设置添加跳转', NULL, '/vendue/commodityparams/forwardAdd.action', NULL, '21', NULL, '0', '1', '0', 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030203', '2101030200', '所有商品列表查询商品默认属性', NULL, '/ajaxquery/commodity/getCommodityParams.action', NULL, '21', NULL, '0', '1', '0', 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030204', '2101030200', '所有商品列表添加', NULL, '/vendue/commodities/add.action', NULL, '21', NULL, '0', '1', '2015', 'Y')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030201', '2101030200', '所有商品列表查询', NULL, '/vendue/commodities/list.action', NULL, '21', NULL, '0', '1', '0', 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030205', '2101030200', '所有商品列表修改跳转', NULL, '/vendue/commodities/viewById.action', NULL, '21', NULL, '0', '1', '0', 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030206', '2101030200', '所有商品列表修改', NULL, '/vendue/commodities/update.action', NULL, '21', NULL, '0', '1', '2015', 'Y')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030210', '2101030200', '所有商品列表获取交收属性', NULL, '/ajaxquery/commodity/getCommextByCode.action', NULL, '21', NULL, '0', '1', '0', 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030209', '2101030200', '所有商品列表查询交收属性', NULL, '/ajaxquery/commodity/getPropertyByBreed.action', NULL, '21', NULL, '0', '1', '0', 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030208', '2101030200', '所有商品列表添加到当前商品', NULL, '/vendue/commodities/addToCur.action', NULL, '21', NULL, '0', '1', '2105', 'Y')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030211', '2101030200', '所有商品列表获取是否拆分标的', NULL, '/ajaxquery/commodity/getIssplittarget.action', NULL, '21', NULL, '0', '1', '0', 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030202', '2101030200', '所有商品列表添加跳转', NULL, '/vendue/commodities/forwardAdd.action', NULL, '21', NULL, '0', '1', '0', 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030207', '2101030200', '所有商品列表批量删除', NULL, '/vendue/commodities/deleteList.action', NULL, '21', NULL, '0', '1', '2015', 'Y')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030212', '2101030200', '所有商品列表获取交易模式id', NULL, '/ajaxquery/commodity/getTrademode.action', NULL, '21', NULL, '0', '1', '0', 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030213', '2101030200', '所有商品列表根据交易商编码判断交易商是否存在', NULL, '/ajaxquery/commodity/isUseridExist.action', NULL, '21', NULL, '0', '1', '0', 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030214', '2101030200', '所有商品列表详情查看', NULL, '/vendue/commodities/viewByIdForDetail.action', NULL, '21', NULL, '0', '1', '0', 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030301', '2101030300', '商品审核查询', NULL, '/vendue/commodityaudit/list.action', NULL, '21', NULL, '0', '1', NULL, 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030302', '2101030300', '商品审核审核跳转', NULL, '/vendue/commodityaudit/viewById.action', NULL, '21', NULL, '0', '1', NULL, 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030303', '2101030300', '商品审核审核提交', NULL, '/vendue/commodityaudit/update.action', NULL, '21', NULL, '0', '1', NULL, 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030304', '2101030300', '商品审核彻底删除', NULL, '/vendue/commodityaudit/update.action', NULL, '21', NULL, '0', '1', NULL, 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101020101', '2101020100', '交易商更新跳转', NULL, '/vendue/tradeUser/updateTradeUserForward.action', '/vendue/tradeUser/updateTradeUserForward.action', '21', NULL, '0', '1', NULL, 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101020102', '2101020100', '更新交易商信息', NULL, '/vendue/tradeUser/updateTradeUser.action', '/vendue/tradeUser/updateTradeUser.action', '21', NULL, '0', '1', '2104', 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101020201', '2101020200', '交易权限添加跳转', NULL, '/vendue/tradeAuthority/addTradeAuthorityforward.action', '/vendue/tradeAuthority/addTradeAuthorityforward.action', '21', NULL, '0', '1', NULL, 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101020202', '2101020200', '交易权限添加', NULL, '/vendue/tradeAuthority/addTradeAuthority.action', '/vendue/tradeAuthority/addTradeAuthority.action', '21', NULL, '0', '1', '2104', 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101020203', '2101020200', '交易权限删除', NULL, '/vendue/tradeAuthority/delateTradeAuthority.action', '/vendue/tradeAuthority/delateTradeAuthority.action', '21', NULL, '0', '1', '2104', 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101040101', '2101040100', '当前成交查询', NULL, '/vendue/vbargain/*', '/vendue/vbargain/bargainList.action', '21', NULL, '0', '1', '0', 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101040201', '2101040200', '当前报单查询', NULL, '/vendue/vbargain/curSubmitList.action', '/vendue/vbargain/curSubmitList.action', '21', NULL, '0', '1', NULL, 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101040301', '2101040300', '历史成交查询', NULL, '/vendue/vbargain/hisBargainList.action', '/vendue/vbargain/hisBargainList.action', '21', NULL, '0', '1', NULL, 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101040401', '2101040400', '历史报单查询', NULL, '/vendue/vbargain/hisSubmitList.action', '/vendue/vbargain/hisSubmitList.action', '21', NULL, '0', '1', NULL, 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030501', '2101030500', '历史商品列表查询', '29_29.gif', '/vendue/hisCommodities/hisCommodityList.action', '/vendue/hisCommodities/hisCommodityList.action', '21', NULL, '0', '1', '0', 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101060101', '2101060100', '合同查询', NULL, '/vendue/bargainManager/hisBargainList.action', '/vendue/bargainManager/hisBargainList.action', '21', NULL, '0', '1', '0', 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101060102', '2101060100', '获取指定的合同', NULL, '/vendue/bargainManager/hisBargain.action', '/vendue/bargainManager/hisBargain.action', '21', NULL, '0', '1', '0', 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101060103', '2101060100', '释放保证金', NULL, '/vendue/bargainManager/unfounds.action', '/vendue/bargainManager/unfounds.action', '21', NULL, '0', '1', '2108', 'Y')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101010501', '2101010500', '获取招标成交列表', NULL, '/vendue/tenderSubmit/getTenderSubmitList.action', '/vendue/tenderSubmit/getTenderSubmitList.action', '21', NULL, '0', '1', NULL, 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101010502', '2101010500', '获取招标板块', NULL, '/vendue/tenderSubmit/partitionInfo.action', '/vendue/tenderSubmit/partitionInfo.action', '21', NULL, '0', '1', NULL, 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101010503', '2101010500', '删除招标委托', NULL, '/vendue/tenderSubmit/deleteTenderSubmitList.action', '/vendue/tenderSubmit/deleteTenderSubmitList.action', '21', NULL, '0', '1', '2103', 'Y')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101010506', '2101010500', '确认招标成交', NULL, '/vendue/tenderSubmit/makeSureTenderSubmit.action', '/vendue/tenderSubmit/makeSureTenderSubmit.action', '21', NULL, '0', '1', '2103', 'Y')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101010504', '2101010500', '招标委托添加跳转', NULL, '/vendue/tenderSubmit/addTenderSubmitForward.action', '/vendue/tenderSubmit/addTenderSubmitForward.action', '21', NULL, '0', '1', '0', 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101010505', '2101010500', '招标委托添加', NULL, '/vendue/tenderSubmit/addTenderSubmit.action', '/vendue/tenderSubmit/addTenderSubmit.action', '21', NULL, '0', '1', '2103', 'Y')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101010301', '2101010300', '交易节查询权限', NULL, '/vendue/system/listFlowControl.action', NULL, '21', '1', '0', '0', '0', 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101010302', '2101010300', '添加交易节跳转', NULL, '/vendue/system/forwardAddFlow.action', NULL, '21', '2', '0', '0', '0', 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101010303', '2101010300', '添加交易节', NULL, '/vendue/system/addFlow.action', NULL, '21', '3', '0', '0', '0', 'Y')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101010305', '2101010300', '修改交易节', NULL, '/vendue/system/updateFlow.action', NULL, '21', '5', '0', '0', '0', 'Y')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101010306', '2101010300', '删除交易节', NULL, '/vendue/system/deleteFlow.action', NULL, '21', '6', '0', '0', '0', 'Y')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101010304', '2101010300', '修改交易节跳转', NULL, '/vendue/system/forwardUpdateFlow.action', NULL, '21', '4', '0', '0', '0', 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101010201', '2101010200', '默认交易节查询权限', NULL, '/vendue/system/listSysFlowControl.action', NULL, '21', '1', '0', '0', '0', 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101010202', '2101010200', '修改默认交易节跳转', NULL, '/vendue/system/forwardUpdateSysFlow.action', NULL, '21', '2', '0', '0', '0', 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101010203', '2101010200', '修改默认交易节', NULL, '/vendue/system/updateSysFlow.action', NULL, '21', '3', '0', '0', '0', 'Y')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101020301', '2101020300', '特殊设置HeadFrame获取', NULL, '/vendue/firmSet/specialSetInfo.action', NULL, '21', '1', '0', '0', '0', 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101020302', '2101020300', '特殊手续费查看', NULL, '/vendue/firmSet/listSpecialFee.action', NULL, '21', '2', '0', '0', '0', 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101020303', '2101020300', '特殊手续费添加跳转', NULL, '/vendue/firmSet/forwardAddSpecialFee.action', NULL, '21', '3', '0', '0', '0', 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101020304', '2101020300', '特殊手续费添加', NULL, '/vendue/firmSet/addSpecialFee.action', NULL, '21', '4', '0', '0', '0', 'Y')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101020305', '2101020300', '特殊手续费修改跳转', NULL, '/vendue/firmSet/forwardUpdateSpecialFee.action', NULL, '21', '5', '0', '0', '0', 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101020306', '2101020300', '特殊手续费修改', NULL, '/vendue/firmSet/updateSpecialFee.action', NULL, '21', '6', '0', '0', '0', 'Y')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101020307', '2101020300', '特殊手续费删除', NULL, '/vendue/firmSet/deleteSpecialFee.action', NULL, '21', '7', '0', '0', '0', 'Y')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101020308', '2101020300', '特殊保证金查看', NULL, '/vendue/firmSet/listSpecialMargin.action', NULL, '21', '8', '0', '0', '0', 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101020309', '2101020300', '特殊保证金添加跳转', NULL, '/vendue/firmSet/forwardAddSpecialMargin.action', NULL, '21', '9', '0', '0', '0', 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101020310', '2101020300', '特殊保证金添加', NULL, '/vendue/firmSet/addSpecialMargin.action', NULL, '21', '10', '0', '0', '0', 'Y')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101020311', '2101020300', '特殊保证金修改跳转', NULL, '/vendue/firmSet/forwardUpdateSpecialMargin.action', NULL, '21', '11', '0', '0', '0', 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101020312', '2101020300', '特殊保证金修改', NULL, '/vendue/firmSet/updateSpecialMargin.action', NULL, '21', '12', '0', '0', '0', 'Y')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101020313', '2101020300', '特殊保证金删除', NULL, '/vendue/firmSet/deleteSpecialMargin.action', NULL, '21', '13', '0', '0', '0', 'Y')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101020314', '2101020300', '刷新特殊手续费', NULL, '/vendue/firmSet/refreshSpecialFee.action', NULL, '21', '14', '0', '0', '0', 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101020315', '2101020300', '刷新特殊保证金', NULL, '/vendue/firmSet/refreshSpecialMargin.action', NULL, '21', '15', '0', '0', '0', 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030401', '2101030400', '当前商品查询', NULL, '/vendue/curCommodity/listCurCommodity.action', NULL, '21', '1', '0', '0', '0', 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030402', '2101030400', '当前商品添加交易节跳转', NULL, '/mgr/app/vendue/commodity/curCommodity/curCommodity_addSection.jsp', NULL, '21', '2', '0', '0', '0', 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030403', '2101030400', '当前商品添加交易节', NULL, '/vendue/curCommodity/addSectionToCurCommodity.action', NULL, '21', '3', '0', '0', '0', 'Y')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030404', '2101030400', '删除当前商品', NULL, '/vendue/curCommodity/deleteCurCommodity.action', NULL, '21', '4', '0', '0', '0', 'Y')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030405', '2101030400', '当前商品插入交易节跳转', NULL, '/mgr/app/vendue/commodity/curCommodity/curCommodity_insertSection.jsp', NULL, '21', '5', '0', '0', '0', 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030406', '2101030400', '当前商品插入交易节', NULL, '/vendue/curCommodity/insertSectionToCurCommodity.action', NULL, '21', '6', '0', '0', '0', 'Y')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101030407', '2101030400', '刷新当前商品', NULL, '/vendue/curCommodity/refreshCurCommodity.action', NULL, '21', '7', '0', '0', '0', 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101010401', '2101010400', '查系统状态权限', NULL, '/vendue/tradeMgr/fetchCurrSysState.action*', NULL, '21', '1', '0', '1', '0', 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101010402', '2101010400', '交易处理权限', NULL, '/vendue/tradeMgr/tradeProcess.action*', NULL, '21', '2', '0', '1', '0', 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101010403', '2101010400', '查看系统当前状态权限', NULL, '/vendue/tradeMgr/goFetchCurrSysState.action*', NULL, '21', '3', '0', '1', '0', 'N')
INSERT INTO "TRADE_GNNT"."C_RIGHT" VALUES ('2101010404', '2101010400', '查看系统当前状态权限1', NULL, '/mgr/app/vendue/system/tradeMgr/go_fetchCurrSysState.jsp*', NULL, '21', '4', '0', '1', '0', 'N')


INSERT INTO "TRADE_GNNT"."C_LOGCATALOG" VALUES ('2101', '21', '竞价核心信息日志');
INSERT INTO "TRADE_GNNT"."C_LOGCATALOG" VALUES ('2102', '21', '竞价核心错误日志');
INSERT INTO "TRADE_GNNT"."C_LOGCATALOG" VALUES ('2103', '21', '竞价交易系统管理日志');
INSERT INTO "TRADE_GNNT"."C_LOGCATALOG" VALUES ('2104', '21', '竞价交易商设置日志');
INSERT INTO "TRADE_GNNT"."C_LOGCATALOG" VALUES ('2105', '21', '竞价商品管理日志');
INSERT INTO "TRADE_GNNT"."C_LOGCATALOG" VALUES ('2106', '21', '竞价交易查询日志');
INSERT INTO "TRADE_GNNT"."C_LOGCATALOG" VALUES ('2107', '21', '竞价报表查询日志');
INSERT INTO "TRADE_GNNT"."C_LOGCATALOG" VALUES ('2108', '21', '竞价合同管理日志');


INSERT INTO "TRADE_GNNT"."F_BANKCLEARLEDGERCONFIG" VALUES ('Margin_V', '1', '1');
INSERT INTO "TRADE_GNNT"."F_BANKCLEARLEDGERCONFIG" VALUES ('TradeFee_V', '0', '1');


INSERT INTO "TRADE_GNNT"."F_LEDGERFIELD" VALUES ('Income_V', '竞价销售收入', '1', '21', '21000', 'Y');
INSERT INTO "TRADE_GNNT"."F_LEDGERFIELD" VALUES ('Payout_V', '竞价购货支出', '-1', '21', '21001', 'Y');
INSERT INTO "TRADE_GNNT"."F_LEDGERFIELD" VALUES ('TradeFee_V', '竞价交易手续费', '-1', '21', '21002', 'Y');
INSERT INTO "TRADE_GNNT"."F_LEDGERFIELD" VALUES ('Margin_V', '竞价保证金', '-1', '21', '21003', 'Y');


INSERT INTO "TRADE_GNNT"."F_SUMMARY" VALUES ('21001', '竞价收交易手续费', 'TradeFee_V', 'D', '20030121', 'N', 'Y');
INSERT INTO "TRADE_GNNT"."F_SUMMARY" VALUES ('21002', '竞价收交易保证金', 'Margin_V', 'D', '200221', 'N', 'Y');
INSERT INTO "TRADE_GNNT"."F_SUMMARY" VALUES ('21003', '竞价退交易保证金', 'Margin_V', 'C', '200221', 'N', 'Y');
INSERT INTO "TRADE_GNNT"."F_SUMMARY" VALUES ('21004', '竞价收交易商货款', 'Payout_V', 'D', '200221', 'N', 'Y');
INSERT INTO "TRADE_GNNT"."F_SUMMARY" VALUES ('21005', '竞价付交易商货款', 'Income_V', 'C', '200221', 'N', 'Y');
INSERT INTO "TRADE_GNNT"."F_SUMMARY" VALUES ('21016', '竞价收违约金', 'Payout_V', 'D', '200221', 'N', 'Y');
INSERT INTO "TRADE_GNNT"."F_SUMMARY" VALUES ('21017', '竞价付违约金', 'Income_V', 'C', '200221', 'N', 'Y');



