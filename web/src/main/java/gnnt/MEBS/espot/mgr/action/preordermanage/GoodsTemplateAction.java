package gnnt.MEBS.espot.mgr.action.preordermanage;

import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import gnnt.MEBS.common.mgr.action.EcsideAction;
import gnnt.MEBS.common.mgr.common.Page;
import gnnt.MEBS.common.mgr.common.PageRequest;
import gnnt.MEBS.common.mgr.common.QueryConditions;
import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.model.User;
import gnnt.MEBS.common.mgr.statictools.Tools;
import gnnt.MEBS.espot.core.kernel.IKernelService;
import gnnt.MEBS.espot.core.vo.FeeComputeArithmeticVO;
import gnnt.MEBS.espot.mgr.model.commoditymanage.Breed;
import gnnt.MEBS.espot.mgr.model.commoditymanage.BreedProps;
import gnnt.MEBS.espot.mgr.model.commoditymanage.Category;
import gnnt.MEBS.espot.mgr.model.commoditymanage.CategoryProperty;
import gnnt.MEBS.espot.mgr.model.commoditymanage.PropertyType;
import gnnt.MEBS.espot.mgr.model.preordermanage.GoodsTemplate;
import gnnt.MEBS.espot.mgr.model.preordermanage.GoodsTemplateProperty;
import gnnt.MEBS.espot.mgr.model.stockmanage.Warehouse;
import net.sf.json.JSONArray;

@Controller("goodsTemplateAction")
@Scope("request")
public class GoodsTemplateAction extends EcsideAction {
	private static final long serialVersionUID = 8940802390578628251L;
	@Autowired
	@Qualifier("kernelService")
	private IKernelService kernelService;
	@Resource(name = "isPickOrSubOrderMap")
	protected Map<String, String> isPickOrSubOrderMap;
	private JSONArray jsonReturn;
	@Resource(name = "deliveryDayTypeMap")
	protected Map<String, String> deliveryDayTypeMap;
	@Resource(name = "deliveryTypeMap")
	protected Map<String, String> deliveryTypeMap;
	@Resource(name = "bsFlagMap")
	protected Map<String, String> bsFlagMap;
	private List<GoodsTemplateProperty> goodsPropertys;
	@Resource(name = "tradeTypeMap")
	protected Map<String, String> tradeTypeMap;
	@Resource(name = "payTypeMap")
	protected Map<String, String> payTypeMap;

	public IKernelService getKernelService() {
		return this.kernelService;
	}

	public void setKernelService(IKernelService paramIKernelService) {
		this.kernelService = paramIKernelService;
	}

	public Map<String, String> getTradeTypeMap() {
		return this.tradeTypeMap;
	}

	public Map<String, String> getPayTypeMap() {
		return this.payTypeMap;
	}

	public Map<String, String> getDeliveryDayTypeMap() {
		return this.deliveryDayTypeMap;
	}

	public Map<String, String> getDeliveryTypeMap() {
		return this.deliveryTypeMap;
	}

	public JSONArray getJsonReturn() {
		return this.jsonReturn;
	}

	public List<GoodsTemplateProperty> getGoodsPropertys() {
		return this.goodsPropertys;
	}

	public void setGoodsPropertys(List<GoodsTemplateProperty> paramList) {
		this.goodsPropertys = paramList;
	}

	public Map<String, String> getBsFlagMap() {
		return this.bsFlagMap;
	}

	public Map<String, String> getIsPickOrSubOrderMap() {
		return this.isPickOrSubOrderMap;
	}

	public String templateList() throws Exception {
		this.logger.debug("enter templateList");
		PageRequest localPageRequest = super.getPageRequest(this.request);
		localPageRequest.setSortColumns("order by templateID desc");
		listByLimit(localPageRequest);
		return "success";
	}

	public String templateListChoose() throws Exception {
		this.logger.debug("enter templateListChoose");
		PageRequest localPageRequest = super.getPageRequest(this.request);
		QueryConditions localQueryConditions = (QueryConditions) localPageRequest.getFilters();
		String str = this.request.getParameter("firmId");
		if ((!"".equals(str)) && (str != null)) {
			localQueryConditions.addCondition("primary.breed.status", "=", Integer.valueOf(1));
			localQueryConditions.addCondition(" ", " ", "(primary.templateType=0 or primary.belongTOUser='" + str + "' )");
		}
		localPageRequest.setSortColumns("order by templateID desc");
		listByLimit(localPageRequest);
		this.request.setAttribute("firmId", str);
		return "success";
	}

	public String addForwardTemplate() {
		PageRequest localPageRequest = new PageRequest(" and primary.type='leaf' and primary.status=1 and primary.belongModule like '%23%'");
		localPageRequest.setPageSize(100000);
		localPageRequest.setSortColumns("order by primary.parentCategory.sortNo,primary.sortNo");
		Page localPage1 = getService().getPage(localPageRequest, new Category());
		List localList1 = localPage1.getResult();
		TreeSet localTreeSet = new TreeSet(new Comparator<Category>() {
			public int compare(Category paramAnonymousCategory1, Category paramAnonymousCategory2) {
				if ((paramAnonymousCategory1.getParentCategory().getCategoryId().longValue() == -1L)
						&& (paramAnonymousCategory2.getParentCategory().getCategoryId().longValue() != -1L)) {
					if (paramAnonymousCategory1.getSortNo().intValue() > paramAnonymousCategory2.getParentCategory().getSortNo().intValue()) {
						return 1;
					}
					return -1;
				}
				if ((paramAnonymousCategory1.getParentCategory().getCategoryId().longValue() != -1L)
						&& (paramAnonymousCategory2.getParentCategory().getCategoryId().longValue() == -1L)) {
					if (paramAnonymousCategory1.getParentCategory().getSortNo().intValue() < paramAnonymousCategory2.getSortNo().intValue()) {
						return -1;
					}
					return 1;
				}
				if ((paramAnonymousCategory1.getParentCategory().getCategoryId().longValue() == -1L)
						&& (paramAnonymousCategory2.getParentCategory().getCategoryId().longValue() == -1L)) {
					if (paramAnonymousCategory1.getSortNo().intValue() > paramAnonymousCategory2.getSortNo().intValue()) {
						return 1;
					}
					return -1;
				}
				if ((paramAnonymousCategory1.getParentCategory().getCategoryId().longValue() != -1L)
						&& (paramAnonymousCategory2.getParentCategory().getCategoryId().longValue() != -1L)) {
					if (paramAnonymousCategory1.getParentCategory().getSortNo().intValue() < paramAnonymousCategory2.getParentCategory().getSortNo()
							.intValue()) {
						return -1;
					}
					if (paramAnonymousCategory1.getParentCategory().getSortNo() == paramAnonymousCategory2.getParentCategory().getSortNo()) {
						if (paramAnonymousCategory1.getSortNo().intValue() > paramAnonymousCategory2.getSortNo().intValue()) {
							return 1;
						}
						return -1;
					}
					if (paramAnonymousCategory1.getParentCategory().getSortNo().intValue() > paramAnonymousCategory2.getParentCategory().getSortNo()
							.intValue()) {
						return 1;
					}
				}
				return 1;
			}
		});
		Object localObject1 = localList1.iterator();
		while (((Iterator) localObject1).hasNext()) {
			StandardModel localObject2 = (StandardModel) ((Iterator) localObject1).next();
			localTreeSet.add((Category) localObject2);
		}
		this.request.setAttribute("categoryList", localTreeSet);
		localObject1 = new QueryConditions();
		((QueryConditions) localObject1).addCondition("status", "=", Integer.valueOf(0));
		Object localObject2 = new PageRequest(1, 1000, localObject1, " order by id");
		Page localPage2 = getService().getPage((PageRequest) localObject2, new Warehouse());
		this.request.setAttribute("warehouseList", localPage2.getResult());
		String str1 = "select t.runtimevalue from E_SYSTEMPROPS t where t.key = 'TradePreTime'";
		List localList2 = getService().getDao().queryBySql(str1);
		this.request.setAttribute("tradePreHour", ((Map) localList2.get(0)).get("RUNTIMEVALUE"));
		String str2 = "select t.runtimevalue from E_SYSTEMPROPS t where t.key = 'OrderValidTime'";
		List localList3 = getService().getDao().queryBySql(str2);
		this.request.setAttribute("orderPreHour", ((Map) localList3.get(0)).get("RUNTIMEVALUE"));
		String str3 = "select t.runtimevalue from E_SYSTEMPROPS t where t.key = 'DeliveryPreTime'";
		List localList4 = getService().getDao().queryBySql(str3);
		this.request.setAttribute("deliveryPreHour", ((Map) localList4.get(0)).get("RUNTIMEVALUE"));
		return "success";
	}

	public String addGoodsTemplate() {
		GoodsTemplate localGoodsTemplate = (GoodsTemplate) this.entity;
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		String str = this.request.getParameter("tradeWay");
		if ("1".equals(str)) {
			localGoodsTemplate.setIsSuborder(Character.valueOf('N'));
			localGoodsTemplate.setIsPickOff(Character.valueOf('Y'));
		} else if ("2".equals(str)) {
			localGoodsTemplate.setIsSuborder(Character.valueOf('Y'));
			localGoodsTemplate.setIsPickOff(Character.valueOf('Y'));
		} else if ("3".equals(str)) {
			localGoodsTemplate.setIsSuborder(Character.valueOf('Y'));
			localGoodsTemplate.setIsPickOff(Character.valueOf('N'));
		}
		localGoodsTemplate.setBelongTOUser(localUser.getUserId());
		localGoodsTemplate.setTemplateType(Integer.valueOf(0));
		long l = localGoodsTemplate.getBreed().getBreedId().longValue();
		Breed localBreed = new Breed();
		localBreed.setBreedId(Long.valueOf(l));
		localBreed = (Breed) getService().get(localBreed);
		localGoodsTemplate.setUnit(localBreed.getUnit());
		if (this.goodsPropertys != null) {
			HashSet localHashSet = new HashSet();
			Iterator localIterator = this.goodsPropertys.iterator();
			while (localIterator.hasNext()) {
				GoodsTemplateProperty localGoodsTemplateProperty = (GoodsTemplateProperty) localIterator.next();
				localGoodsTemplateProperty.setTemplate(localGoodsTemplate);
				localHashSet.add(localGoodsTemplateProperty);
			}
			localGoodsTemplate.setContainGoodsTemplateProperty(localHashSet);
		}
		getService().add(localGoodsTemplate);
		addReturnValue(1, 119901L);
		writeOperateLog(2309, "委托模版号为" + localGoodsTemplate.getTemplateID() + "模版添加", 1, "");
		return "success";
	}

	public String forwardGoodsTemplate() throws Exception {
		this.logger.debug("enter forwardGoodsTemplate");
		String str1 = "select t.runtimevalue from E_SYSTEMPROPS t where t.key = 'TradePreTime'";
		List localList1 = getService().getDao().queryBySql(str1);
		this.request.setAttribute("tradePreHour", ((Map) localList1.get(0)).get("RUNTIMEVALUE"));
		QueryConditions localQueryConditions = new QueryConditions();
		localQueryConditions.addCondition("status", "=", Integer.valueOf(0));
		PageRequest localPageRequest = new PageRequest(1, 1000, localQueryConditions, " order by id");
		Page localPage = getService().getPage(localPageRequest, new Warehouse());
		this.request.setAttribute("warehouseList", localPage.getResult());
		GoodsTemplate localGoodsTemplate = (GoodsTemplate) getService().get(this.entity);
		putResourcePropertys(localGoodsTemplate.getContainGoodsTemplateProperty());
		String str2 = "select t.runtimevalue from E_SYSTEMPROPS t where t.key = 'OrderValidTime'";
		List localList2 = getService().getDao().queryBySql(str2);
		this.request.setAttribute("orderPreHour", ((Map) localList2.get(0)).get("RUNTIMEVALUE"));
		FeeComputeArithmeticVO localFeeComputeArithmeticVO = this.kernelService.getDeliveryMarginArithmetic("",
				localGoodsTemplate.getCategoryID().longValue());
		this.request.setAttribute("rate", Double.valueOf(localFeeComputeArithmeticVO.getRate()));
		this.request.setAttribute("mode", Integer.valueOf(localFeeComputeArithmeticVO.getMode()));
		this.entity = localGoodsTemplate;
		return "success";
	}

	public String getBreedByCategoryID() {
		this.logger.debug("---通过商品分类ID查询品种信息并加入到json中-getBreedByCategoryID--");
		this.jsonReturn = new JSONArray();
		long l = Tools.strToLong(this.request.getParameter("categoryId"), -1000L);
		if (l < 0L) {
			return "success";
		}
		this.logger.debug("FREE:========== " + this.kernelService);
		try {
			FeeComputeArithmeticVO localFeeComputeArithmeticVO = this.kernelService.getDeliveryMarginArithmetic("", l);
			double d = this.kernelService.getOneTradeMargin();
			this.logger.debug(
					"deliveryMargin:========== MODE:" + localFeeComputeArithmeticVO.getMode() + ",RATE:" + localFeeComputeArithmeticVO.getRate());
			this.logger.debug("oneTradeMargin:========== :" + d);
			this.jsonReturn.add(localFeeComputeArithmeticVO.getMode() + ":" + localFeeComputeArithmeticVO.getRate() + "=" + d);
			this.logger.debug(
					"======jsonReturn============" + localFeeComputeArithmeticVO.getMode() + ":" + localFeeComputeArithmeticVO.getRate() + "=" + d);
		} catch (RemoteException localRemoteException) {
			this.jsonReturn.add("1:1=1:1");
			this.logger.error(Tools.getExceptionTrace(localRemoteException));
		}
		PageRequest localPageRequest = new PageRequest(" and primary.type='leaf'and primary.status=1 and primary.belongModule like '%23%'");
		localPageRequest.setSortColumns("order by  primary.parentCategory.sortNo,primary.sortNo");
		Page localPage = getService().getPage(localPageRequest, new Category());
		if ((localPage.getResult() != null) && (localPage.getResult().size() > 0)) {
			Iterator localIterator1 = localPage.getResult().iterator();
			while (localIterator1.hasNext()) {
				StandardModel localStandardModel = (StandardModel) localIterator1.next();
				Category localCategory = (Category) localStandardModel;
				if (l == localCategory.getCategoryId().longValue()) {
					Iterator localIterator2 = localCategory.getBreedSet().iterator();
					while (localIterator2.hasNext()) {
						Breed localBreed = (Breed) localIterator2.next();
						if ((localBreed.getStatus().intValue() == 1) && (localBreed.getBelongModule() != null)
								&& (localBreed.getBelongModule().contains("23"))) {
							JSONArray localJSONArray = new JSONArray();
							localJSONArray.add(localBreed.getBreedId());
							localJSONArray.add(localBreed.getBreedName());
							localJSONArray.add(localBreed.getUnit());
							localJSONArray.add(localBreed.getTradeMode());
							this.jsonReturn.add(localJSONArray);
						}
					}
					break;
				}
			}
		}
		return "success";
	}

	public String getPropertyValueByBreedID() {
		this.logger.debug("通过品名编号获取品名属性信息");
		long l = Tools.strToLong(this.request.getParameter("breedId"), -1000L);
		this.jsonReturn = new JSONArray();
		PageRequest localPageRequest = new PageRequest(" and primary.type='leaf'and primary.status=1 and primary.belongModule like '%23%'");
		localPageRequest.setSortColumns("order by  primary.parentCategory.sortNo,primary.sortNo");
		Page localPage = getService().getPage(localPageRequest, new Category());
		if ((localPage.getResult() != null) && (localPage.getResult().size() > 0)) {
			Iterator localIterator1 = localPage.getResult().iterator();
			while (localIterator1.hasNext()) {
				StandardModel localStandardModel = (StandardModel) localIterator1.next();
				Category localCategory = (Category) localStandardModel;
				Iterator localIterator2 = localCategory.getBreedSet().iterator();
				while (localIterator2.hasNext()) {
					Breed localBreed = (Breed) localIterator2.next();
					if (l == localBreed.getBreedId().longValue()) {
						Iterator localIterator3 = localCategory.getPropertySet().iterator();
						while (localIterator3.hasNext()) {
							CategoryProperty localCategoryProperty = (CategoryProperty) localIterator3.next();
							JSONArray localJSONArray1 = new JSONArray();
							localJSONArray1.add(localCategoryProperty.getPropertyName());
							localJSONArray1.add(localCategoryProperty.getHasValueDict());
							if ("Y".equalsIgnoreCase(localCategoryProperty.getHasValueDict())) {
								JSONArray localJSONArray2 = new JSONArray();
								Iterator localIterator4 = localBreed.getPropsSet().iterator();
								while (localIterator4.hasNext()) {
									BreedProps localBreedProps = (BreedProps) localIterator4.next();
									if (localBreedProps.getCategoryProperty().getPropertyId() == localCategoryProperty.getPropertyId()) {
										localJSONArray2.add(localBreedProps.getPropertyValue());
									}
								}
								localJSONArray1.add(localJSONArray2);
							}
							localJSONArray1.add(localCategoryProperty.getIsNecessary());
							localJSONArray1.add(localCategoryProperty.getFieldType());
							this.jsonReturn.add(localJSONArray1);
						}
						this.logger.debug("获取属性名称或者值");
					}
				}
			}
		}
		return "success";
	}

	public String getTemplateByID() {
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
			localHashMap1.put("breedID", getValue(localGoodsTemplate.getBreed().getBreedId()));
			localHashMap1.put("tradeMode", getValue(localGoodsTemplate.getBreed().getTradeMode()));
			localHashMap1.put("categoryID", getValue(localGoodsTemplate.getCategoryID()));
			localHashMap1.put("bsFlag", getValue(localGoodsTemplate.getBsFlag()));
			localHashMap1.put("price", getValue(localGoodsTemplate.getPrice()));
			localHashMap1.put("quantity", getValue(localGoodsTemplate.getQuantity()));
			localHashMap1.put("unit", getValue(localGoodsTemplate.getBreed().getUnit()));
			localHashMap1.put("tradePreHoure", getValue(localGoodsTemplate.getTradePreHour()));
			localHashMap1.put("tradeMargin_b", getValue(localGoodsTemplate.getTradeMargin_b()));
			localHashMap1.put("tradeMargin_s", getValue(localGoodsTemplate.getTradeMargin_s()));
			localHashMap1.put("deliveryMode", getValue(localGoodsTemplate.getDeliveryType()));
			localHashMap1.put("deliveryDayType", getValue(localGoodsTemplate.getDeliveryDayType()));
			localHashMap1.put("deliveryPreHoure", getValue(localGoodsTemplate.getDeliveryPreHour()));
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
			localHashMap1.put("validHoure", getValue(localGoodsTemplate.getValidHour()));
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

	public String updateGoodsTemplate() {
		this.logger.debug("--enter updateGoodsTemplate 模版修改--");
		String str1 = "修改模板信息";
		GoodsTemplate localGoodsTemplate1 = (GoodsTemplate) this.entity;
		String str2 = this.request.getParameter("tradeWay");
		if ("1".equals(str2)) {
			localGoodsTemplate1.setIsSuborder(Character.valueOf('N'));
			localGoodsTemplate1.setIsPickOff(Character.valueOf('Y'));
		} else if ("2".equals(str2)) {
			localGoodsTemplate1.setIsSuborder(Character.valueOf('Y'));
			localGoodsTemplate1.setIsPickOff(Character.valueOf('Y'));
		} else if ("3".equals(str2)) {
			localGoodsTemplate1.setIsSuborder(Character.valueOf('Y'));
			localGoodsTemplate1.setIsPickOff(Character.valueOf('N'));
		}
		this.logger.debug("templateID====:" + localGoodsTemplate1.getTemplateID());
		str1 = str1 + "模板编号[" + localGoodsTemplate1.getTemplateID() + "]";
		GoodsTemplate localGoodsTemplate2 = (GoodsTemplate) getService().get(localGoodsTemplate1);
		getService().getDao().evict(localGoodsTemplate2);
		localGoodsTemplate1.setTemplateType(localGoodsTemplate2.getTemplateType());
		localGoodsTemplate1.setBelongTOUser(localGoodsTemplate2.getBelongTOUser());
		localGoodsTemplate1.setTradePreTime(localGoodsTemplate2.getTradePreTime());
		localGoodsTemplate1.setCategoryID(localGoodsTemplate2.getCategoryID());
		localGoodsTemplate1.setBsFlag(localGoodsTemplate2.getBsFlag());
		localGoodsTemplate1.setUnit(localGoodsTemplate2.getUnit());
		localGoodsTemplate1.setBreed(localGoodsTemplate2.getBreed());
		localGoodsTemplate1.setContainGoodsTemplateProperty(localGoodsTemplate2.getContainGoodsTemplateProperty());
		localGoodsTemplate1.setOrderTitle(localGoodsTemplate2.getOrderTitle());
		getService().update(this.entity);
		addReturnValue(1, 119902L);
		writeOperateLog(2308, str1, 1, "");
		return "success";
	}

	private void putResourcePropertys(Set<GoodsTemplateProperty> paramSet) {
		if ((paramSet != null) && (paramSet.size() > 0)) {
			LinkedHashMap localLinkedHashMap = new LinkedHashMap();
			QueryConditions localQueryConditions = new QueryConditions();
			localQueryConditions.addCondition("status", "=", Integer.valueOf(0));
			PageRequest localPageRequest = new PageRequest(1, 100, localQueryConditions, " order by sortNo ");
			Page localPage = getService().getPage(localPageRequest, new PropertyType());
			if ((localPage != null) && (localPage.getResult() != null)) {
				for (int i = 0; i < localPage.getResult().size(); i++) {
					PropertyType localObject1 = (PropertyType) localPage.getResult().get(i);
					localLinkedHashMap.put(localObject1, new ArrayList());
				}
			}
			ArrayList localArrayList = new ArrayList();
			Object localObject1 = paramSet.iterator();
			Object localObject3;
			while (((Iterator) localObject1).hasNext()) {
				GoodsTemplateProperty localObject2 = (GoodsTemplateProperty) ((Iterator) localObject1).next();
				localObject3 = null;
				Iterator localIterator = localLinkedHashMap.keySet().iterator();
				while (localIterator.hasNext()) {
					PropertyType localPropertyType = (PropertyType) localIterator.next();
					if ((((GoodsTemplateProperty) localObject2).getPropertyTypeID() != null)
							&& (((GoodsTemplateProperty) localObject2).getPropertyTypeID().equals(localPropertyType.getPropertyTypeID()))) {
						localObject3 = (List) localLinkedHashMap.get(localPropertyType);
					}
				}
				if (localObject3 == null) {
					localObject3 = localArrayList;
				}
				((List) localObject3).add(localObject2);
			}
			localObject1 = new LinkedHashMap();
			Object localObject2 = localLinkedHashMap.keySet().iterator();
			while (((Iterator) localObject2).hasNext()) {
				localObject3 = (PropertyType) ((Iterator) localObject2).next();
				if (((List) localLinkedHashMap.get(localObject3)).size() > 0) {
					((Map) localObject1).put(localObject3, localLinkedHashMap.get(localObject3));
				}
			}
			if (localArrayList.size() > 0) {
				localObject2 = new PropertyType();
				((PropertyType) localObject2).setName("其它属性");
				((PropertyType) localObject2).setPropertyTypeID(Long.valueOf(-1L));
				((Map) localObject1).put(localObject2, localArrayList);
			}
			this.request.setAttribute("tpmap", localObject1);
		}
	}
}
