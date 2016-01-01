package gnnt.MEBS.broker.mgr.action;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import gnnt.MEBS.broker.mgr.model.brokerManagement.Broker;
import gnnt.MEBS.broker.mgr.model.brokerManagement.BrokerArea;
import gnnt.MEBS.broker.mgr.model.brokerManagement.BrokerMenu;
import gnnt.MEBS.broker.mgr.model.brokerManagement.BrokerRight;
import gnnt.MEBS.broker.mgr.model.brokerManagement.BrokerType;
import gnnt.MEBS.broker.mgr.model.brokerManagement.FirmAndBroker;
import gnnt.MEBS.broker.mgr.service.BaseService;
import gnnt.MEBS.broker.mgr.service.BrokerRightService;
import gnnt.MEBS.broker.mgr.util.StringUtil;
import gnnt.MEBS.common.mgr.action.EcsideAction;
import gnnt.MEBS.common.mgr.common.Global;
import gnnt.MEBS.common.mgr.common.Page;
import gnnt.MEBS.common.mgr.common.PageRequest;
import gnnt.MEBS.common.mgr.common.QueryConditions;
import gnnt.MEBS.common.mgr.common.ReturnValue;
import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.model.TradeModule;
import gnnt.MEBS.common.mgr.statictools.Tools;

@Controller("brokerManagementAction")
@Scope("request")
public class BrokerManagementAction extends EcsideAction {
	private static final long serialVersionUID = 2002561331506495872L;
	@Autowired
	@Qualifier("baseService")
	private BaseService baseService;
	@Resource(name = "memberTypeMap")
	Map<String, String> memberTypeMap;
	@Resource(name = "typeMap")
	Map<Integer, String> typeMap;
	@Autowired
	@Qualifier("com_brokerRightService")
	private BrokerRightService brokerRightService;
	private static Map<Integer, TradeModule> tradeModuleMap;
	private static LinkedHashMap<Integer, List<BrokerMenu>> rightMap;

	public Map<String, String> getMemberTypeMap() {
		return this.memberTypeMap;
	}

	public void setMemberTypeMap(Map<String, String> paramMap) {
		this.memberTypeMap = paramMap;
	}

	public Map<Integer, String> getTypeMap() {
		return this.typeMap;
	}

	public void setTypeMap(Map<Integer, String> paramMap) {
		this.typeMap = paramMap;
	}

	public String addBrokerforward() {
		this.logger.debug("addBrokerforward");
		List localList1 = getService().getListBySql("select * from br_brokerarea", new BrokerArea());
		this.request.setAttribute("brokerAreaList", localList1);
		List localList2 = getService().getListBySql("select * from BR_BrokerType", new BrokerType());
		this.request.setAttribute("brokerTypeList", localList2);
		return "success";
	}

	public String updateBrokerforward() {
		this.logger.debug("updateBrokerforward");
		this.entity = getService().get(this.entity);
		List localList1 = getService().getListBySql("select * from br_brokerarea", new BrokerArea());
		this.request.setAttribute("brokerAreaList", localList1);
		List localList2 = getService().getListBySql("select * from BR_BrokerType", new BrokerType());
		this.request.setAttribute("brokerTypeList", localList2);
		return "success";
	}

	public String updateBrokerFirmforward() throws Exception {
		this.logger.debug("enter updateBrokerFirmforward");
		PageRequest localPageRequest = getPageRequest(this.request);
		QueryConditions localQueryConditions = (QueryConditions) localPageRequest.getFilters();
		String str = this.request.getParameter("brokerId");
		localQueryConditions.addCondition("primary.brokerId", "=", str);
		Page localPage = getService().getPage(localPageRequest, this.entity);
		this.request.setAttribute("pageInfo", localPage);
		this.request.setAttribute("brokerId", str);
		this.request.setAttribute("oldParams", getParametersStartingWith(this.request, "gnnt_"));
		return "success";
	}

	public String addBrokerFirmforward() {
		String str = this.request.getParameter("brokerId");
		this.request.setAttribute("brokerId", str);
		return "success";
	}

	public String addBrokerFirm() throws Exception {
		FirmAndBroker localFirmAndBroker = (FirmAndBroker) this.entity;
		List localList = getService().getListBySql("select * from BR_FIRMANDBROKER where firmid='" + localFirmAndBroker.getFirmId() + "'");
		if ((localList != null) && (localList.size() > 0)) {
			addReturnValue(1, 121901L, new Object[] { "所辖用户添加失败，交易商已有所属经纪人" });
		} else {
			localFirmAndBroker.setBindTime(getService().getSysDate());
			getService().add(localFirmAndBroker);
			addReturnValue(1, 119901L);
		}
		return "success";
	}

	public Map<Integer, List<BrokerMenu>> getBrokerMenuMap() {
		rightMap = null;
		if (rightMap == null) {
			synchronized (getClass()) {
				if (rightMap == null) {
					rightMap = new LinkedHashMap();
					Map localMap = getTradeModuleMap();
					if (localMap != null) {
						Object localObject1 = localMap.keySet().iterator();
						while (((Iterator) localObject1).hasNext()) {
							int i = ((Integer) ((Iterator) localObject1).next()).intValue();
							rightMap.put(Integer.valueOf(i), new ArrayList());
						}
						localObject1 = null;
						Iterator localIterator = getChildRightSet().iterator();
						while (localIterator.hasNext()) {
							BrokerMenu localBrokerMenu = (BrokerMenu) localIterator.next();
							localObject1 = (List) rightMap.get(localBrokerMenu.getModuleId());
							if (localObject1 != null) {
								((List) localObject1).add(localBrokerMenu);
							} else {
								this.logger.debug("系统中包含有 " + localBrokerMenu.getModuleId() + " 模块的权限，但是不包含本模块");
							}
						}
					}
				}
			}
		}
		return rightMap;
	}

	private Set<BrokerMenu> getChildRightSet() {
		BrokerMenu localBrokerMenu = new BrokerMenu();
		localBrokerMenu.setId(Long.valueOf(9900000000L));
		localBrokerMenu = (BrokerMenu) getService().get(localBrokerMenu);
		return localBrokerMenu.getChildRightSet();
	}

	private Map<Integer, TradeModule> getTradeModuleMap() {
		if (tradeModuleMap == null)
			synchronized (getClass()) {
				if (tradeModuleMap == null) {
					tradeModuleMap = new LinkedHashMap();
					Map map = Global.modelContextMap;
					if (map != null) {
						Object obj = null;
						List list = getService()
								.getListBySql("select c.moduleid from c_deploy_config c where c.systype = 'broker' and c.moduleid <> 99");
						for (Integer integer = Integer.valueOf(0); integer.intValue() < list.size();) {
							Object obj1 = map.keySet().iterator();
							do {
								if (!((Iterator) (obj1)).hasNext())
									break;
								Integer integer1 = (Integer) ((Iterator) (obj1)).next();
								Map map1 = (Map) map.get(integer1);
								TradeModule trademodule = new TradeModule();
								trademodule.setAddFirmFn((String) map1.get("addFirmFn"));
								trademodule.setCnName((String) map1.get("cnName"));
								trademodule.setDelFirmFn((String) map1.get("delFirmFn"));
								trademodule.setEnName((String) map1.get("enName"));
								trademodule.setIsFirmSet((String) map1.get("isFirmSet"));
								trademodule.setModuleId(integer1);
								trademodule.setShortName((String) map1.get("shortName"));
								trademodule.setUpdateFirmStatusFn((String) map1.get("updateFirmStatusFn"));
								int i = Integer.parseInt(((Map) (Map) list.get(integer.intValue())).get("MODULEID").toString());
								if (i != integer1.intValue())
									continue;
								tradeModuleMap.put(integer1, trademodule);
								break;
							} while (true);
							obj1 = integer;
							Integer integer2 = integer = Integer.valueOf(integer.intValue() + 1);
							Object _tmp = obj1;
						}

					}
				}
			}
		return tradeModuleMap;
	}

	public String setBrokerRightforward() throws Exception {
		getBrokerMenuMap();
		String str = this.request.getParameter("brokerId");
		Broker localBroker = this.brokerRightService.getBrokerById(str, false);
		this.request.setAttribute("broker", localBroker);
		this.request.setAttribute("tradeModuleMap", getTradeModuleMap());
		this.request.setAttribute("rightMap", getBrokerMenuMap());
		return "success";
	}

	public String updateBrokerModuleRight() {
		String str1 = this.request.getParameter("brokerId");
		String str2 = this.request.getParameter("broType");
		int i = Tools.strToInt(this.request.getParameter("moduleId"), 64536);
		if ((str1 == null) || (str1.length() <= 0)) {
			return "error";
		}
		if (i <= 0) {
			return "error";
		}
		Map localMap = getBrokerMenuMap();
		if ((localMap == null) || (localMap.get(Integer.valueOf(i)) == null)) {
			return "error";
		}
		this.request.setAttribute("module", getTradeModuleMap().get(Integer.valueOf(i)));
		this.request.setAttribute("frightList", localMap.get(Integer.valueOf(i)));
		this.request.setAttribute("brotype", str2);
		QueryConditions localQueryConditions = new QueryConditions();
		localQueryConditions.addCondition("brokerId", "=", str1);
		localQueryConditions.addCondition("cright.moduleId", "=", Integer.valueOf(i));
		PageRequest localPageRequest = new PageRequest(1, 100000, localQueryConditions, "");
		Page localPage = getService().getPage(localPageRequest, new BrokerRight());
		if ((localPage != null) && (localPage.getResult() != null) && (localPage.getResult().size() > 0)) {
			HashMap localHashMap = new HashMap();
			Iterator localIterator = localPage.getResult().iterator();
			while (localIterator.hasNext()) {
				StandardModel localStandardModel = (StandardModel) localIterator.next();
				localHashMap.put(((BrokerRight) localStandardModel).getCright().getId(), Boolean.valueOf(true));
			}
			this.request.setAttribute("brokerRightMap", localHashMap);
		}
		return "success";
	}

	public String updateBrokerRight() {
		String str1 = "修改加盟商权限";
		this.logger.debug(str1);
		try {
			Object localObject1 = this.request.getParameter("brokerId");
			String[] arrayOfString1 = this.request.getParameterValues("chmoduleIds");
			String[] arrayOfString2 = this.request.getParameterValues("ck");
			Broker localBroker = this.brokerRightService.getBrokerById((String) localObject1, true);
			if (localBroker == null) {
				addReturnValue(-1, 121901L, new Object[] { "保存加盟商权限失败，加盟商【" + localBroker.getName() + "】不存在" });
				String str2 = "error";
				ReturnValue localReturnValue2;
				return str2;
			}
			this.brokerRightService.saveBrokerRight(localBroker, arrayOfString2, arrayOfString1);
			addReturnValue(1, 121901L, new Object[] { "保存加盟商【" + localBroker.getName() + "】权限成功" });
			localObject1 = (ReturnValue) this.request.getAttribute("ReturnValue");
			if (localObject1 != null) {
				if (((ReturnValue) localObject1).getResult() > 0) {
					writeOperateLog(1901, str1, 1, ((ReturnValue) localObject1).getInfo());
				} else {
					writeOperateLog(1901, str1, 0, ((ReturnValue) localObject1).getInfo());
				}
			}
		} catch (Exception localException) {
			addReturnValue(-1, 999998L);
		} finally {
			ReturnValue localReturnValue1;
			ReturnValue localReturnValue3 = (ReturnValue) this.request.getAttribute("ReturnValue");
			if (localReturnValue3 != null) {
				if (localReturnValue3.getResult() > 0) {
					writeOperateLog(1901, str1, 1, localReturnValue3.getInfo());
				} else {
					writeOperateLog(1901, str1, 0, localReturnValue3.getInfo());
				}
			}
		}
		return "success";
	}

	public String addBroker() throws Exception {
		this.logger.debug("enter addBroker");
		Broker localBroker = (Broker) this.entity;
		localBroker.getBrokerId();
		localBroker.getPassword();
		String str = StringUtil.encodePassword(localBroker.getBrokerId() + localBroker.getPassword(), "MD5");
		localBroker.setPassword(str);
		localBroker.setModifyTime(getService().getSysDate());
		List localList = getService().getListBySql("select * from BR_FIRMANDBROKER where FirmId='" + localBroker.getFirmId() + "'");
		if ((localList != null) && (localList.size() > 0)) {
			addReturnValue(1, 121901L, new Object[] { "添加失败，加盟商账号已被关联！" });
		} else {
			getService().add(localBroker);
			FirmAndBroker localFirmAndBroker = new FirmAndBroker();
			localFirmAndBroker.setBrokerId(localBroker.getBrokerId());
			localFirmAndBroker.setFirmId(localBroker.getFirmId());
			localFirmAndBroker.setBindTime(getService().getSysDate());
			getService().add(localFirmAndBroker);
			addReturnValue(1, 119901L);
		}
		return "success";
	}

	public String updateBroker() throws Exception {
		this.logger.debug("enter updateBroker");
		this.baseService.update(this.entity);
		addReturnValue(1, 119902L);
		return "success";
	}

	public String updateBrokerPassword() {
		this.logger.debug("enter updateBrokerPassword");
		Broker localBroker = (Broker) this.entity;
		localBroker.getBrokerId();
		localBroker.getPassword();
		String str = StringUtil.encodePassword(localBroker.getBrokerId() + localBroker.getPassword(), "MD5");
		localBroker.setPassword(str);
		getService().update(localBroker);
		addReturnValue(1, 119902L);
		return "success";
	}

	public String deleteBroker() throws SecurityException, NoSuchFieldException {
		logger.debug("enter delete");
		String as[] = request.getParameterValues("ids");
		if (as == null || as.length == 0)
			throw new IllegalArgumentException("删除主键数组不能为空！");
		if (entity == null)
			throw new IllegalArgumentException("业务对象为空，所以操作表未知，不允许通过主键数组批量删除！");
		if (entity.fetchPKey() == null || entity.fetchPKey().getKey() == null || entity.fetchPKey().getKey().length() == 0)
			throw new IllegalArgumentException("业务对象未设置主键，不允许通过主键数组批量删除！");
		Class class1 = entity.getClass().getDeclaredField(entity.fetchPKey().getKey()).getType();
		Object aobj[];
		if (class1.equals(Long.class)) {
			aobj = new Long[as.length];
			for (int i = 0; i < as.length; i++)
				aobj[i] = Long.valueOf(as[i]);

		} else if (class1.equals(Integer.class)) {
			aobj = new Integer[as.length];
			for (int j = 0; j < as.length; j++)
				aobj[j] = Integer.valueOf(as[j]);

		} else {
			aobj = as;
		}
		int k = 0;
		for (int l = 0; l < aobj.length; l++) {
			List list = getService()
					.getListBySql((new StringBuilder()).append("select t.* from BR_BROKERREWARD t where 1=1 and t.Amount > 0 and brokerId ='")
							.append(aobj[l].toString()).append("'").toString());
			if (list != null && list.size() > 0) {
				addReturnValue(1, 0x1dc2dL, new Object[] { (new StringBuilder()).append(aobj[l].toString()).append("加盟商里有未付清佣金，不允许删除！").toString() });
				k = 0;
				break;
			}
			List list1 = getService().getListBySql((new StringBuilder()).append("select firmid from BR_FIRMANDBROKER where brokerid='")
					.append(aobj[l].toString()).append("'").toString());
			if (list1 != null && list1.size() > 1) {
				addReturnValue(1, 0x1dc2dL,
						new Object[] { (new StringBuilder()).append(aobj[l].toString()).append("加盟商里有所辖交易商，不允许删除！请先删除其所辖交易商！").toString() });
				k = 0;
				break;
			}
			if (list1 == null || list1.size() != 1)
				continue;
			k++;
			HashMap hashmap = (HashMap) list1.get(0);
			String s = String.valueOf(hashmap.get("FIRMID"));
			List list2 = getService().getListBySql(
					(new StringBuilder()).append("select firmid from br_broker where brokerid='").append(aobj[l].toString()).append("'").toString());
			HashMap hashmap1 = (HashMap) list2.get(0);
			String s1 = String.valueOf(hashmap1.get("FIRMID"));
			if (s.equals(s1)) {
				FirmAndBroker firmandbroker = new FirmAndBroker();
				firmandbroker.setFirmId(s);
				getService().delete(firmandbroker);
				Broker broker = new Broker();
				broker.setBrokerId(aobj[l].toString());
				getService().delete(broker);
			}
		}

		if (k > 0)
			addReturnValue(1, 0x1d45fL);
		return "success";
	}

	public String deleteBrokerFirm() throws SecurityException, NoSuchFieldException {
		logger.debug("enter delete");
		String as[] = request.getParameterValues("ids");
		if (as == null || as.length == 0)
			throw new IllegalArgumentException("删除主键数组不能为空！");
		if (entity == null)
			throw new IllegalArgumentException("业务对象为空，所以操作表未知，不允许通过主键数组批量删除！");
		if (entity.fetchPKey() == null || entity.fetchPKey().getKey() == null || entity.fetchPKey().getKey().length() == 0)
			throw new IllegalArgumentException("业务对象未设置主键，不允许通过主键数组批量删除！");
		Class class1 = entity.getClass().getDeclaredField(entity.fetchPKey().getKey()).getType();
		Object aobj[];
		if (class1.equals(Long.class)) {
			aobj = new Long[as.length];
			for (int i = 0; i < as.length; i++)
				aobj[i] = Long.valueOf(as[i]);

		} else if (class1.equals(Integer.class)) {
			aobj = new Integer[as.length];
			for (int j = 0; j < as.length; j++)
				aobj[j] = Integer.valueOf(as[j]);

		} else {
			aobj = as;
		}
		List list = Arrays.asList(aobj);
		String s = "";
		String s1 = request.getParameter("brokerId");
		List list1 = getService()
				.getListBySql((new StringBuilder()).append("select firmid from br_broker where brokerid='").append(s1).append("'").toString());
		HashMap hashmap = (HashMap) list1.get(0);
		String s2 = String.valueOf(hashmap.get("FIRMID"));
		int k = 0;
		for (int l = list.size(); k < l; k++)
			if (!s2.equals(list.get(k))) {
				FirmAndBroker firmandbroker = new FirmAndBroker();
				String s3 = list.get(k).toString();
				firmandbroker.setFirmId(s3);
				getService().delete(firmandbroker);
			} else {
				s = list.get(k).toString();
			}

		if (list.size() > 0 && !s.equals(""))
			addReturnValue(1, 0x1dc2dL, new Object[] { (new StringBuilder()).append(s).append("交易商是加盟商自己，不可删除！").toString() });
		else
			addReturnValue(1, 0x1d45fL);
		return "success";
	}
}
