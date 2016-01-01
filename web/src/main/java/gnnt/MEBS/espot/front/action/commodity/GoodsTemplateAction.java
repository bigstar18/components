package gnnt.MEBS.espot.front.action.commodity;

import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import gnnt.MEBS.common.front.action.StandardAction;
import gnnt.MEBS.common.front.common.Page;
import gnnt.MEBS.common.front.common.PageRequest;
import gnnt.MEBS.common.front.common.QueryConditions;
import gnnt.MEBS.common.front.model.integrated.User;
import gnnt.MEBS.common.front.statictools.ActionUtil;
import gnnt.MEBS.common.front.statictools.ApplicationContextInit;
import gnnt.MEBS.common.front.statictools.Tools;
import gnnt.MEBS.espot.core.kernel.IKernelService;
import gnnt.MEBS.espot.front.common.XTradeFrontGlobal;
import gnnt.MEBS.espot.front.model.commodity.Breed;
import gnnt.MEBS.espot.front.model.commodity.Category;
import gnnt.MEBS.espot.front.model.commodity.GoodsTemplate;
import gnnt.MEBS.espot.front.model.commodity.GoodsTemplateProperty;
import gnnt.MEBS.espot.front.model.trade.TradeRight;
import gnnt.MEBS.espot.front.model.warehousestock.WareHouse;
import net.sf.json.JSONArray;

@Controller("goodsTemplateAction")
@Scope("request")
public class GoodsTemplateAction extends StandardAction {
	private static final long serialVersionUID = -5439737252511860049L;
	@Resource(name = "kernelService")
	private IKernelService kernelService;
	private List<GoodsTemplateProperty> goodsPropertys;
	@Resource(name = "bsFlagMap")
	Map<String, String> bsFlagMap;
	private JSONArray jsonReturn;

	public List<GoodsTemplateProperty> getGoodsPropertys() {
		return this.goodsPropertys;
	}

	public void setGoodsPropertys(List<GoodsTemplateProperty> paramList) {
		this.goodsPropertys = paramList;
	}

	public Map<String, String> getBsFlagMap() {
		return this.bsFlagMap;
	}

	public String templateList() {
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		PageRequest localPageRequest = null;
		try {
			localPageRequest = ActionUtil.getPageRequest(this.request);
		} catch (Exception localException) {
			this.logger.error(Tools.getExceptionTrace(localException));
		}
		QueryConditions localQueryConditions = (QueryConditions) localPageRequest.getFilters();
		String str = this.request.getParameter("belongto");
		if ((null != str) && (!"".equals(str))) {
			if ("sys".equalsIgnoreCase(str)) {
				localQueryConditions.addCondition("templateType", "=", Integer.valueOf(0));
			} else if ("main".equalsIgnoreCase(str)) {
				localQueryConditions.addCondition("belongTOUser", "=", localUser.getBelongtoFirm().getFirmID());
			}
		} else {
			localQueryConditions.addCondition(" ", " ",
					"((belongTOUser='" + localUser.getBelongtoFirm().getFirmID() + "' and templateType='1') or templateType='0')");
		}
		localQueryConditions.addCondition("primary.breed.belongtoCategory.status", "=", Integer.valueOf(1));
		if ("".equals(localPageRequest.getSortColumns())) {
			localPageRequest.setSortColumns(" order by templateID desc");
		}
		Page localPage = getService().getPage(localPageRequest, new GoodsTemplate());
		this.request.setAttribute("belongto", str);
		this.request.setAttribute("pageInfo", localPage);
		this.request.setAttribute("oldParams", ActionUtil.getParametersStartingWith(this.request, "gnnt_"));
		return "success";
	}

	public String getFirstCategory() {
		this.logger.debug("查询分类信息====================================================================");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		String str = "select * from E_TradeRight where FirmID='" + localUser.getBelongtoFirm().getFirmID() + "'";
		this.logger.debug("查询交易特殊权限： " + str);
		List localList = getService().getListBySql(str, new TradeRight());
		TradeRight localTradeRight = null;
		if ((null != localList) && (localList.size() == 1)) {
			localTradeRight = (TradeRight) localList.get(0);
			this.request.setAttribute("tradeRight", localTradeRight);
		}
		ArrayList localArrayList = new ArrayList();
		Page localPage = XTradeFrontGlobal.getCategoryPage();
		Iterator localIterator = localPage.getResult().iterator();
		while (localIterator.hasNext()) {
			Category localCategory = (Category) localIterator.next();
			if ((localCategory.getCategoryID().longValue() > 0L) && ("leaf".equalsIgnoreCase(localCategory.getType()))
					&& (localCategory.getStatus().intValue() == 1)) {
				localArrayList.add(localCategory);
			}
		}
		this.request.setAttribute("categoryList", localArrayList);
		return "success";
	}

	public String templateAdd() {
		String str1 = "添加委托模板";
		this.logger.debug(str1 + "操作");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		GoodsTemplate localGoodsTemplate = (GoodsTemplate) this.entity;
		String str2 = this.request.getParameter("tradeWay");
		if ("1".equals(str2)) {
			localGoodsTemplate.setIsSuborder("N");
			localGoodsTemplate.setIsPickOff("Y");
		} else if ("2".equals(str2)) {
			localGoodsTemplate.setIsSuborder("Y");
			localGoodsTemplate.setIsPickOff("Y");
		} else if ("3".equals(str2)) {
			localGoodsTemplate.setIsSuborder("Y");
			localGoodsTemplate.setIsPickOff("N");
		}
		localGoodsTemplate.setBelongTOUser(localUser.getBelongtoFirm().getFirmID());
		localGoodsTemplate.setTemplateType(Integer.valueOf(1));
		String str3 = this.request.getParameter("warehouseID");
		String[] arrayOfString = str3.split("-");
		if ((arrayOfString != null) && (arrayOfString.length > 0)) {
			localGoodsTemplate.setWarehouseID(arrayOfString[0]);
		}
		str1 = str1 + "，分类编号 " + localGoodsTemplate.getCategoryID() + " 品名编号 " + localGoodsTemplate.getBreed().getBreedID();
		if (this.goodsPropertys != null) {
			Iterator localIterator = this.goodsPropertys.iterator();
			while (localIterator.hasNext()) {
				GoodsTemplateProperty localGoodsTemplateProperty = (GoodsTemplateProperty) localIterator.next();
				localGoodsTemplateProperty.setTemplate(localGoodsTemplate);
				localGoodsTemplate.addContainGoodsTemplateProperty(localGoodsTemplateProperty);
			}
			try {
				getService().add(this.entity);
				addReturnValue(1, 9910001L);
				writeOperateLog(2309, str1, 1, "");
			} catch (Exception localException) {
				addReturnValue(-1, 9930093L);
				writeOperateLog(2309, str1, 0, localException.getMessage());
				this.logger.error(Tools.getExceptionTrace(localException));
			}
		} else {
			addReturnValue(-1, 2330201L);
			writeOperateLog(2309, str1, 0, ApplicationContextInit.getErrorInfo("-3006"));
		}
		return "success";
	}

	public String templateDetail() {
		logger.debug("模板详细信息查询");
		String s = "select t.runtimevalue from E_SYSTEMPROPS t where t.key = 'TradePreTime'";
		List list = getService().getDao().queryBySql(s);
		Integer integer = Integer.valueOf(((Map) list.get(0)).get("RUNTIMEVALUE").toString());
		request.setAttribute("tradePreHoure", integer);
		long l = Tools.strToLong(request.getParameter("templateID"), -1000L);
		GoodsTemplate goodstemplate = new GoodsTemplate();
		if (l > 0L) {
			goodstemplate.setTemplateID(Long.valueOf(l));
			goodstemplate = (GoodsTemplate) getService().get(goodstemplate);
			request.setAttribute("template", goodstemplate);
			boolean flag = false;
			Object obj = XTradeFrontGlobal.getCategoryPage().getResult().iterator();
			do {
				if (!((Iterator) (obj)).hasNext())
					break;
				Category category = (Category) ((Iterator) (obj)).next();
				if (category.getCategoryID().longValue() > 0L && "leaf".equalsIgnoreCase(category.getType())) {
					Iterator iterator = category.getContainBreed().iterator();
					do {
						if (!iterator.hasNext())
							break;
						Breed breed = (Breed) iterator.next();
						if (breed.getBreedID().longValue() == goodstemplate.getBreed().getBreedID().longValue()) {
							request.setAttribute("breedList", category.getContainBreed());
							flag = true;
						}
					} while (!flag);
				}
			} while (!flag);
			obj = new PageRequest(
					(new StringBuilder()).append(" and primary.status=1 and primary.categoryID=").append(goodstemplate.getCategoryID()).toString());
			Page page = getService().getPage(((PageRequest) (obj)), new Category());
			String s1 = "select * from BI_WareHouse where status=0 order by id";
			List list1 = super.getService().getListBySql(s1, new WareHouse());
			logger.debug((new StringBuilder()).append("wareHouses: ").append(list1.size()).toString());
			request.setAttribute("wareHouses", list1);
			request.setAttribute("page", page);
			try {
				User user = (User) request.getSession().getAttribute("CurrentUser");
				gnnt.MEBS.espot.core.vo.FeeComputeArithmeticVO feecomputearithmeticvo = kernelService
						.getDeliveryMarginArithmetic(user.getBelongtoFirm().getFirmID(), goodstemplate.getCategoryID().longValue());
				gnnt.MEBS.espot.core.vo.FeeComputeArithmeticVO feecomputearithmeticvo1 = kernelService.getDeliveryMarginArithmetic("",
						goodstemplate.getCategoryID().longValue());
				request.setAttribute("deliveryMargin", feecomputearithmeticvo);
				request.setAttribute("delistDeliveryMargin", feecomputearithmeticvo1);
			} catch (RemoteException remoteexception) {
				remoteexception.printStackTrace();
			}
		}
		getFirstCategory();
		return "success";
	}

	public String templateMod() {
		String str1 = "修改模板信息";
		GoodsTemplate localGoodsTemplate1 = (GoodsTemplate) this.entity;
		String str2 = this.request.getParameter("tradeWay");
		if ("1".equals(str2)) {
			localGoodsTemplate1.setIsSuborder("N");
			localGoodsTemplate1.setIsPickOff("Y");
		} else if ("2".equals(str2)) {
			localGoodsTemplate1.setIsSuborder("Y");
			localGoodsTemplate1.setIsPickOff("Y");
		} else if ("3".equals(str2)) {
			localGoodsTemplate1.setIsSuborder("Y");
			localGoodsTemplate1.setIsPickOff("N");
		}
		GoodsTemplate localGoodsTemplate2 = (GoodsTemplate) getService().get(localGoodsTemplate1);
		Set localSet = localGoodsTemplate2.getContainGoodsTemplateProperty();
		str1 = str1 + "模板编号[" + localGoodsTemplate1.getTemplateID() + "]";
		if (this.goodsPropertys != null) {
			ArrayList localArrayList1 = new ArrayList();
			ArrayList localArrayList2 = new ArrayList();
			Iterator localIterator1 = localSet.iterator();
			GoodsTemplateProperty localGoodsTemplateProperty1;
			int i;
			Iterator localIterator2;
			GoodsTemplateProperty localGoodsTemplateProperty2;
			while (localIterator1.hasNext()) {
				localGoodsTemplateProperty1 = (GoodsTemplateProperty) localIterator1.next();
				i = 1;
				localIterator2 = this.goodsPropertys.iterator();
				while (localIterator2.hasNext()) {
					localGoodsTemplateProperty2 = (GoodsTemplateProperty) localIterator2.next();
					if (localGoodsTemplateProperty1.getPropertyName().equals(localGoodsTemplateProperty2.getPropertyName())) {
						localGoodsTemplateProperty1.setPropertyValue(localGoodsTemplateProperty2.getPropertyValue());
						localGoodsTemplate1.addContainGoodsTemplateProperty(localGoodsTemplateProperty1);
						i = 0;
						break;
					}
				}
				if (i != 0) {
					localArrayList1.add(localGoodsTemplateProperty1);
				}
			}
			localIterator1 = this.goodsPropertys.iterator();
			while (localIterator1.hasNext()) {
				localGoodsTemplateProperty1 = (GoodsTemplateProperty) localIterator1.next();
				i = 1;
				localIterator2 = localSet.iterator();
				while (localIterator2.hasNext()) {
					localGoodsTemplateProperty2 = (GoodsTemplateProperty) localIterator2.next();
					if (localGoodsTemplateProperty2.getPropertyName().equals(localGoodsTemplateProperty1.getPropertyName())) {
						i = 0;
					}
				}
				if (i != 0) {
					localArrayList2.add(localGoodsTemplateProperty1);
				}
			}
			if (localArrayList1.size() > 0) {
				localIterator1 = localArrayList1.iterator();
				while (localIterator1.hasNext()) {
					localGoodsTemplateProperty1 = (GoodsTemplateProperty) localIterator1.next();
					localSet.remove(localGoodsTemplateProperty1);
					localGoodsTemplateProperty1.setTemplate(null);
				}
			}
			if (localArrayList2.size() > 0) {
				localIterator1 = localArrayList2.iterator();
				while (localIterator1.hasNext()) {
					localGoodsTemplateProperty1 = (GoodsTemplateProperty) localIterator1.next();
					localGoodsTemplateProperty1.setTemplate(localGoodsTemplate2);
					localSet.add(localGoodsTemplateProperty1);
				}
			}
			getService().getDao().evict(localGoodsTemplate2);
			localGoodsTemplate1.setTemplateType(localGoodsTemplate2.getTemplateType());
			localGoodsTemplate1.setBelongTOUser(localGoodsTemplate2.getBelongTOUser());
			localGoodsTemplate1.setTradePreTime(localGoodsTemplate2.getTradePreTime());
			localGoodsTemplate1.setContainGoodsTemplateProperty(localSet);
			getService().updateForContainNull(this.entity);
			this.logger.debug("getQuantity  ============" + localGoodsTemplate1.getQuantity());
			addReturnValue(1, 9910003L);
			writeOperateLog(2309, str1, 0, "");
		} else {
			addReturnValue(-1, 2330201L);
			writeOperateLog(2309, str1, 0, ApplicationContextInit.getErrorInfo("-3006"));
		}
		return "success";
	}

	public JSONArray getJsonReturn() {
		return this.jsonReturn;
	}

	public String getTemplateByID() {
		String str = "select t.runtimevalue from E_SYSTEMPROPS t where t.key = 'TradePreTime'";
		List localList = getService().getDao().queryBySql(str);
		Integer localInteger = Integer.valueOf(((Map) localList.get(0)).get("RUNTIMEVALUE").toString());
		this.logger.debug("通过编号获取模板信息并封装成json");
		this.jsonReturn = new JSONArray();
		GoodsTemplate localGoodsTemplate = new GoodsTemplate();
		localGoodsTemplate.setTemplateID(Long.valueOf(Tools.strToLong(this.request.getParameter("templateID"), -1000L)));
		this.logger.debug("模板编号：" + localGoodsTemplate.getTemplateID());
		if (localGoodsTemplate.getTemplateID().longValue() > 0L) {
			localGoodsTemplate = (GoodsTemplate) getService().get(localGoodsTemplate);
			HashMap localHashMap1 = new HashMap();
			localHashMap1.put("orderTitle", getValue(localGoodsTemplate.getOrderTitle()));
			localHashMap1.put("breedName", getValue(localGoodsTemplate.getBreed().getBreedName()));
			localHashMap1.put("breedID", getValue(localGoodsTemplate.getBreed().getBreedID()));
			localHashMap1.put("tradeMode", getValue(localGoodsTemplate.getBreed().getTradeMode()));
			localHashMap1.put("categoryID", getValue(localGoodsTemplate.getCategoryID()));
			localHashMap1.put("bsFlag", getValue(localGoodsTemplate.getBsFlag()));
			localHashMap1.put("price", getValue(localGoodsTemplate.getPrice()));
			localHashMap1.put("quantity", getValue(localGoodsTemplate.getQuantity()));
			localHashMap1.put("unit", getValue(localGoodsTemplate.getBreed().getUnit()));
			localHashMap1.put("tradePreHoure", localInteger + "");
			localHashMap1.put("tradeMargin_b", getValue(localGoodsTemplate.getTradeMargin_b()));
			localHashMap1.put("tradeMargin_s", getValue(localGoodsTemplate.getTradeMargin_s()));
			localHashMap1.put("deliveryMode", getValue(localGoodsTemplate.getDeliveryType()));
			localHashMap1.put("deliveryDayType", getValue(localGoodsTemplate.getDeliveryDayType()));
			localHashMap1.put("deliveryPreHoure", getValue(localGoodsTemplate.getDeliveryPreHoure()));
			localHashMap1.put("deliveryDay", getValue(localGoodsTemplate.getDeliveryDay()));
			localHashMap1.put("deliveryMargin_b", getValue(localGoodsTemplate.getDeliveryMargin_b()));
			localHashMap1.put("deliveryMargin_s", getValue(localGoodsTemplate.getDeliveryMargin_s()));
			localHashMap1.put("deliveryType", getValue(localGoodsTemplate.getDeliveryType()));
			localHashMap1.put("deliveryAddress", getValue(localGoodsTemplate.getDeliveryAddress()));
			localHashMap1.put("warehouseID", getValue(localGoodsTemplate.getWarehouseID()));
			localHashMap1.put("remark", getValue(localGoodsTemplate.getRemark()));
			localHashMap1.put("validTime", getValue(localGoodsTemplate.getValidTime()));
			localHashMap1.put("minTradeQty", getValue(localGoodsTemplate.getMinTradeQty()));
			localHashMap1.put("tradeUnit", getValue(localGoodsTemplate.getTradeUnit()));
			localHashMap1.put("isPickOff", getValue(localGoodsTemplate.getIsPickOff()));
			localHashMap1.put("isSuborder", getValue(localGoodsTemplate.getIsSuborder()));
			localHashMap1.put("belongTOUser", "" + getValue(localGoodsTemplate.getBelongTOUser()));
			localHashMap1.put("tradeType", "" + getValue(localGoodsTemplate.getTradeType()));
			localHashMap1.put("payType", "" + getValue(localGoodsTemplate.getPayType()));
			localHashMap1.put("validHoure", getValue(localGoodsTemplate.getValidHoure()));
			this.logger.debug("========validTime:" + (String) localHashMap1.get("validTime"));
			JSONArray localJSONArray = new JSONArray();
			Set localSet = localGoodsTemplate.getContainGoodsTemplateProperty();
			if (localSet != null) {
				Iterator localIterator = localSet.iterator();
				while (localIterator.hasNext()) {
					GoodsTemplateProperty localGoodsTemplateProperty = (GoodsTemplateProperty) localIterator.next();
					HashMap localHashMap2 = new HashMap();
					localHashMap2.put("propertyName", localGoodsTemplateProperty.getPropertyName());
					localHashMap2.put("propertyValue", localGoodsTemplateProperty.getPropertyValue());
					localJSONArray.add(localHashMap2);
				}
			}
			this.jsonReturn.add(localHashMap1);
			this.jsonReturn.add(localJSONArray);
		}
		return "success";
	}

	private String getValue(Object paramObject) {
		return getValue(paramObject, 2);
	}

	private String getValue(Object paramObject, int paramInt) {
		if (paramObject == null) {
			return "";
		}
		if ((paramObject instanceof String)) {
			return paramObject.toString();
		}
		if ((paramObject instanceof Integer)) {
			return paramObject.toString();
		}
		if ((paramObject instanceof Date)) {
			return Tools.fmtDate((Date) paramObject);
		}
		if ((paramObject instanceof Double)) {
			return Tools.fmtDouble2(((Double) paramObject).doubleValue());
		}
		return paramObject.toString();
	}
}
