package gnnt.MEBS.common.front.common;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.sql.DataSource;

import gnnt.MEBS.checkLogon.check.front.FrontCheck;
import gnnt.MEBS.checkLogon.util.Tool;
import gnnt.MEBS.common.front.model.StandardModel;
import gnnt.MEBS.common.front.model.TradeModule;
import gnnt.MEBS.common.front.model.front.Menu;
import gnnt.MEBS.common.front.model.front.Right;
import gnnt.MEBS.common.front.service.MenuService;
import gnnt.MEBS.common.front.service.RightService;
import gnnt.MEBS.common.front.service.StandardService;
import gnnt.MEBS.common.front.statictools.ApplicationContextInit;
import gnnt.MEBS.common.front.statictools.Tools;
import gnnt.MEBS.logonServerUtil.au.LogonActualize;

public class Global implements ServletContextListener {
	public static final String TOLOGINPREURL = "preUrl";
	public static final String CURRENTUSERSTR = "CurrentUser";
	public static final String TOLOGINURLREASON = "reason";
	public static final String SESSIONID = "sessionID";
	public static final String USERID = "userID";
	public static final String FROMMODULEID = "FromModuleID";
	public static final String FROMLOGONTYPE = "FromLogonType";
	public static final String SELFLOGONTYPE = "LogonType";
	public static final String SELFLMODULEID = "ModuleID";
	public static final String ISSUPERADMIN = "IsSuperAdmin";
	public static final String RETURNVALUE = "ReturnValue";
	public static int COMMONMODULEID = 99;
	public static long ROOTRIGHTID = 9900000000L;
	private static Integer selfModuleID;
	private static String selfLogonType;
	private static List<Integer> moduleIDArray;
	public static Map<Integer, Map<Object, Object>> modelContextMap;
	public static final String HAVERIGHTMENU = "HaveRightMenu";
	private static Menu rootMenu;
	private static Right rightTree;
	private static Map<String, String> marketInfoMap;

	public void contextDestroyed(ServletContextEvent arg0) {
	}

	public void contextInitialized(ServletContextEvent arg0) {
		MenuService menuService = (MenuService) ApplicationContextInit.getBean("com_menuService");
		StandardService standardService = (StandardService) ApplicationContextInit.getBean("com_standardService");

		ROOTRIGHTID = Tools.strToLong(ApplicationContextInit.getConfig("RootRightID"), ROOTRIGHTID);

		modelContextMap = getContextMap(menuService);

		List<Map<Object, Object>> listMap = standardService.getListBySql("select * from c_marketInfo");
		marketInfoMap = new LinkedHashMap();
		if ((listMap != null) && (listMap.size() > 0)) {
			for (Map<Object, Object> map : listMap) {
				marketInfoMap.put((String) map.get("INFONAME"), (String) map.get("INFOVALUE"));
			}
		}
		rootMenu = getMenuById(menuService);

		RightService rightService = (RightService) ApplicationContextInit.getBean("com_rightService");

		rightTree = rightService.loadRightTree();

		int callMode = Tool.strToInt(ApplicationContextInit.getConfig("CallMode"), 0);

		DataSource dataSource = (DataSource) ApplicationContextInit.getBean("dataSource");

		int clearRMITimes = Tool.strToInt(ApplicationContextInit.getConfig("clearRMITimes"), -1);

		Map<String, Long> auExpireTimeMap = null;
		Long timeSpace = null;
		try {
			auExpireTimeMap = (Map) ApplicationContextInit.getBean("auExpireTimeMap");
			timeSpace = Long.valueOf(Tool.strToLong(ApplicationContextInit.getConfig("timeSpace"), 200L));
		} catch (Exception localException1) {
		}
		try {
			LogonActualize.createInstance(getSelfModuleID(), callMode, dataSource, auExpireTimeMap, timeSpace.longValue(), clearRMITimes, "front");
		} catch (Exception e) {
			e.printStackTrace();
		}
		FrontCheck.createInstance(dataSource);
	}

	public static Menu getRootMenu() {
		return rootMenu;
	}

	public static Right getRightTree() {
		return rightTree;
	}

	private Map<Integer, Map<Object, Object>> getContextMap(StandardService menuService) {
		StandardService standardService = (StandardService) ApplicationContextInit.getBean("com_standardService");

		Map<Integer, Map<Object, Object>> result = new LinkedHashMap();

		Map<Integer, Map<Object, Object>> springTradeModuleMap = new LinkedHashMap();
		Object key;
		try {
			List<Map<Object, Object>> listMap = standardService
					.getListBySql("select * from c_deploy_config t where t.systype='front' order by t.sortno,t.moduleid asc");
			for (Map<Object, Object> map : listMap) {
				Map<Object, Object> mapClone = new HashMap();
				for (Iterator localIterator2 = map.keySet().iterator(); localIterator2.hasNext();) {
					key = localIterator2.next();
					mapClone.put(key, map.get(key));
				}
				springTradeModuleMap.put(Integer.valueOf(Tools.strToInt(mapClone.get("MODULEID").toString())), mapClone);
			}
		} catch (Exception localException) {
		}
		if ((springTradeModuleMap != null) && (springTradeModuleMap.size() > 0)) {
			List<StandardModel> list = menuService
					.getListBySql("select * from c_trademodule where 1=1 and (isFirmSet='Y' or moduleID=" + COMMONMODULEID + ")", new TradeModule());
			if (list != null) {
				for (Integer moduleID : springTradeModuleMap.keySet()) {
					for (key = list.iterator(); ((Iterator) key).hasNext();) {
						StandardModel model = (StandardModel) ((Iterator) key).next();
						TradeModule tm = (TradeModule) model;
						if ((moduleID != null) && (moduleID.equals(tm.getModuleID()))) {
							Map<Object, Object> value = (Map) springTradeModuleMap.get(moduleID);
							if (value != null) {
								value.put("enName", tm.getEnName());
								value.put("isFirmset", tm.getIsFirmSet());
								value.put("cnName", tm.getCnName());
								value.put("shortName", tm.getShortName());
							}
							result.put(moduleID, value);
							break;
						}
					}
				}
			}
		}
		return result;
	}

	private Menu getMenuById(MenuService menuService) {
		Menu rootMenu = menuService.getMenuById(ROOTRIGHTID, getModuleIDList());

		// 将根菜单的子菜单按照模块号的顺序进行排序
		if (modelContextMap != null && modelContextMap.size() > 0) {
			// 重新定义新的子菜单集合
			Set<Menu> childMenuSet = new LinkedHashSet<Menu>();
			// 遍历配置的模块编号
			for (Integer moduleId : modelContextMap.keySet()) {
				// 遍历查询出来的子菜单信息
				for (Menu menu : rootMenu.getChildMenuSet()) {
					// 如果两个模块号相等则将菜单加入新定义的子菜单集合
					if (moduleId != null && moduleId.equals(menu.getModuleId())) {
						childMenuSet.add(menu);
					}
				}
			}
			rootMenu.setChildMenuSet(childMenuSet);
		}

		return rootMenu;
	}

	public static List<Integer> getModuleIDList() {
		if (moduleIDArray == null) {
			synchronized (Global.class) {
				if (moduleIDArray == null) {
					moduleIDArray = new ArrayList();
					moduleIDArray.add(Integer.valueOf(COMMONMODULEID));
					int module = getSelfModuleID();
					if (module != COMMONMODULEID) {
						moduleIDArray.add(Integer.valueOf(module));
					} else if (modelContextMap != null) {
						for (Integer moduleId : modelContextMap.keySet()) {
							moduleIDArray.add(moduleId);
						}
					}
				}
			}
		}
		return moduleIDArray;
	}

	public static int getSelfModuleID() {
		if (selfModuleID == null) {
			synchronized (Global.class) {
				if (selfModuleID == null) {
					try {
						selfModuleID = Integer.valueOf(Tools.strToInt(ApplicationContextInit.getConfig("SelfModuleID"), COMMONMODULEID));
					} catch (Exception e) {
						selfModuleID = Integer.valueOf(COMMONMODULEID);
					}
				}
			}
		}
		return selfModuleID.intValue();
	}

	public static String getSelfLogonType() {
		if (selfLogonType == null) {
			synchronized (Global.class) {
				if (selfLogonType == null) {
					selfLogonType = ApplicationContextInit.getConfig("selfLogonType");
					if ((selfLogonType == null) || (selfLogonType.length() == 0)) {
						selfLogonType = "web";
					}
				}
			}
		}
		return selfLogonType;
	}

	public static Map<String, String> getMarketInfoMap() {
		return marketInfoMap;
	}
}
