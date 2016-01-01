package gnnt.MEBS.espot.mgr.action.search;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import gnnt.MEBS.common.mgr.action.EcsideAction;
import gnnt.MEBS.common.mgr.common.Page;
import gnnt.MEBS.common.mgr.common.PageRequest;
import gnnt.MEBS.common.mgr.common.QueryConditions;
import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.statictools.Tools;
import gnnt.MEBS.espot.mgr.model.commoditymanage.PropertyType;
import gnnt.MEBS.espot.mgr.model.holdingmanage.Holding;
import gnnt.MEBS.espot.mgr.model.holdingmanage.HoldingHis;
import gnnt.MEBS.espot.mgr.model.ordermanage.Order;
import gnnt.MEBS.espot.mgr.model.ordermanage.OrderGoodsProperty;
import gnnt.MEBS.espot.mgr.model.ordermanage.OrderGoodsPropertyHis;
import gnnt.MEBS.espot.mgr.model.ordermanage.OrderHis;
import gnnt.MEBS.espot.mgr.model.ordermanage.OrderPic;
import gnnt.MEBS.espot.mgr.model.ordermanage.OrderPicHis;
import gnnt.MEBS.espot.mgr.model.parametermanage.SystemProps;
import gnnt.MEBS.espot.mgr.model.reservemanage.Reserve;
import gnnt.MEBS.espot.mgr.model.reservemanage.ReserveHis;
import gnnt.MEBS.espot.mgr.model.subordermanage.SubOrder;
import gnnt.MEBS.espot.mgr.model.subordermanage.SubOrderHis;
import gnnt.MEBS.espot.mgr.model.trademanage.GoodsMoneyApply;
import gnnt.MEBS.espot.mgr.model.trademanage.GoodsMoneyApplyHis;
import gnnt.MEBS.espot.mgr.model.trademanage.TradeContract;
import gnnt.MEBS.espot.mgr.model.trademanage.TradeContractHis;
import gnnt.MEBS.espot.mgr.model.trademanage.TradeGoodsProperty;
import gnnt.MEBS.espot.mgr.model.trademanage.TradeGoodsPropertyHis;

@Controller("searchAction")
@Scope("request")
public class SearchAction extends EcsideAction {
	private static final long serialVersionUID = 1508339069613171151L;
	@Resource(name = "bsFlagMap")
	protected Map<String, String> bsFlagMap;
	@Resource(name = "deliveryDayTypeMap")
	protected Map<String, String> deliveryDayTypeMap;
	@Resource(name = "deliveryTypeMap")
	protected Map<String, String> deliveryTypeMap;
	@Resource(name = "orderStatusMap")
	protected Map<String, String> orderStatusMap;
	@Resource(name = "tradeContractStatusMap")
	protected Map<String, String> tradeContractStatusMap;
	@Resource(name = "tradeAutoContractStatusMap")
	protected Map<String, String> tradeAutoContractStatusMap;
	@Resource(name = "subOrderStatusMap")
	protected Map<String, String> subOrderStatusMap;
	@Resource(name = "reserveTypeMap")
	protected Map<String, String> reserveTypeMap;
	@Resource(name = "holdingTypeMap")
	protected Map<String, String> holdingTypeMap;
	@Resource(name = "firmStatusMap")
	protected Map<String, String> firmStatusMap;
	@Resource(name = "mfirmTypeMap")
	protected Map<String, String> firmTypeMap;
	private int tradeType;
	@Resource(name = "goodsMoneyApplyMap")
	protected Map<Integer, String> goodsMoneyApplyMap;
	@Resource(name = "goodsMoneyTypeMap")
	protected Map<Integer, String> goodsMoneyTypeMap;

	public int getTradeType() {
		return this.tradeType;
	}

	public void setTradeType(int paramInt) {
		this.tradeType = paramInt;
	}

	public Map<String, String> getTradeAutoContractStatusMap() {
		return this.tradeAutoContractStatusMap;
	}

	public Map<String, String> getBsFlagMap() {
		return this.bsFlagMap;
	}

	public Map<String, String> getDeliveryDayTypeMap() {
		return this.deliveryDayTypeMap;
	}

	public Map<String, String> getDeliveryTypeMap() {
		return this.deliveryTypeMap;
	}

	public Map<String, String> getOrderStatusMap() {
		return this.orderStatusMap;
	}

	public Map<String, String> getTradeContractStatusMap() {
		return this.tradeContractStatusMap;
	}

	public Map<String, String> getReserveTypeMap() {
		return this.reserveTypeMap;
	}

	public Map<String, String> getHoldingTypeMap() {
		return this.holdingTypeMap;
	}

	public Map<String, String> getFirmStatusMap() {
		return this.firmStatusMap;
	}

	public Map<String, String> getFirmTypeMap() {
		return this.firmTypeMap;
	}

	public Map<String, String> getSubOrderStatusMap() {
		return this.subOrderStatusMap;
	}

	public Map<Integer, String> getGoodsMoneyApplyMap() {
		return this.goodsMoneyApplyMap;
	}

	public Map<Integer, String> getGoodsMoneyTypeMap() {
		return this.goodsMoneyTypeMap;
	}

	public String searchOrder() throws Exception {
		String str = this.request.getParameter("type");
		this.logger.debug("=================  listOrder===type=" + str);
		if ((str != null) && (str.equals("H"))) {
			this.entity = new OrderHis();
			str = "H";
		} else {
			this.entity = new Order();
			str = "D";
		}
		super.listByLimit();
		this.request.setAttribute("type", str);
		return "success";
	}

	public String searchOrderDetail() {
		this.logger.debug("enter searchOrderDetail");
		String str = this.request.getParameter("type");
		Order localOrder = (Order) this.entity;
		PageRequest localPageRequest = new PageRequest(" and primary.orderID=" + localOrder.getOrderId());
		Object localObject;
		if ((str != "") && (str.equals("H"))) {
			localObject = new OrderHis();
			((OrderHis) localObject).setOrderId(localOrder.getOrderId());
			this.entity = getQueryService().get((StandardModel) localObject);
			Page localPage = getService().getPage(localPageRequest, new OrderPicHis());
			this.request.setAttribute("imageList", localPage.getResult());
		} else {
			this.entity = getQueryService().get(localOrder);
			localObject = getService().getPage(localPageRequest, new OrderPic());
			this.request.setAttribute("imageList", ((Page) localObject).getResult());
		}
		this.entity = getQueryService().get(this.entity);
		if ((this.entity instanceof Order)) {
			putResourcePropertys(((Order) this.entity).getOrderGoodsProperties());
		} else {
			putResourcePropertys_h(((OrderHis) this.entity).getOrderGoodsProperties());
		}
		return "success";
	}

	public String searchSubOrder() throws Exception {
		String str = this.request.getParameter("type");
		this.logger.debug("=================  listSubOrder===type=" + str);
		if ((str != null) && (str.equals("H"))) {
			this.entity = new SubOrderHis();
			str = "H";
		} else {
			this.entity = new SubOrder();
			str = "D";
		}
		super.listByLimit();
		this.request.setAttribute("type", str);
		return "success";
	}

	public String searchSubOrderDetail() {
		this.logger.debug("enter searchSubOrderDetail");
		String str = this.request.getParameter("type");
		SubOrder localSubOrder = (SubOrder) this.entity;
		if ((str != "") && (str.equals("H"))) {
			SubOrderHis localSubOrderHis = new SubOrderHis();
			localSubOrderHis.setSubOrderId(localSubOrder.getSubOrderId());
			this.entity = getQueryService().get(localSubOrderHis);
		} else {
			this.entity = getQueryService().get(localSubOrder);
		}
		this.entity = getQueryService().get(this.entity);
		if ((this.entity instanceof SubOrder)) {
			putResourcePropertys(((SubOrder) this.entity).getOrder().getOrderGoodsProperties());
		} else {
			putResourcePropertys_h(((SubOrderHis) this.entity).getOrder().getOrderGoodsProperties());
		}
		return "success";
	}

	public String searchTrade() throws Exception {
		String str = this.request.getParameter("type");
		this.logger.debug("=================  searchTrade===type=" + str);
		if ((str != null) && (str.equals("H"))) {
			this.entity = new TradeContractHis();
			str = "H";
		} else {
			this.entity = new TradeContract();
			str = "D";
		}
		PageRequest localPageRequest = super.getPageRequest(this.request);
		QueryConditions localQueryConditions = (QueryConditions) localPageRequest.getFilters();
		localQueryConditions.addCondition("primary.tradeType", "=", Integer.valueOf(this.tradeType));
		listByLimit(localPageRequest);
		this.request.setAttribute("type", str);
		SystemProps localSystemProps = new SystemProps();
		localSystemProps.setPropsKey("PayTimes");
		localSystemProps = (SystemProps) getService().get(localSystemProps);
		this.request.setAttribute("PayTimes", Integer.valueOf(Tools.strToInt(localSystemProps.getRunTimeValue())));
		return "success";
	}

	public String searchTradeDetail() throws Exception {
		this.logger.debug("enter searchTradeDetail");
		String str = this.request.getParameter("type");
		TradeContract localTradeContract = (TradeContract) this.entity;
		Object localObject;
		if ((str != null) && (str.equals("H"))) {
			localObject = new TradeContractHis();
			((TradeContractHis) localObject).setTradeNo(localTradeContract.getTradeNo());
			this.entity = getQueryService().get((StandardModel) localObject);
			localObject = (TradeContractHis) this.entity;
			Calendar localCalendar = Calendar.getInstance();
			localCalendar.setTime(((TradeContractHis) localObject).getTime());
			localCalendar.add(13, ((TradeContractHis) localObject).getTradePreTime().intValue());
			this.request.setAttribute("tradePreTime", localCalendar.getTime());
		} else {
			this.entity = getQueryService().get(localTradeContract);
			localTradeContract = (TradeContract) this.entity;
			localObject = Calendar.getInstance();
			((Calendar) localObject).setTime(localTradeContract.getTime());
			((Calendar) localObject).add(13, localTradeContract.getTradePreTime().intValue());
			this.request.setAttribute("tradePreTime", ((Calendar) localObject).getTime());
		}
		this.entity = getQueryService().get(this.entity);
		if ((this.entity instanceof TradeContract)) {
			putResourcePropertys_t(((TradeContract) this.entity).getTradeGoodsProperties());
		} else {
			putResourcePropertys_t_h(((TradeContractHis) this.entity).getTradeGoodsProperties());
		}
		return "success";
	}

	public String searchReserve() throws Exception {
		String str = this.request.getParameter("type");
		this.logger.debug("=================  seachReserve===type=" + str);
		if ((str != null) && (str.equals("H"))) {
			this.entity = new ReserveHis();
			str = "H";
		} else {
			this.entity = new Reserve();
			str = "D";
		}
		super.listByLimit();
		this.request.setAttribute("type", str);
		return "success";
	}

	public String searchReserveDetail() {
		this.logger.debug("enter searchReserveDetail");
		String str = this.request.getParameter("type");
		Reserve localReserve = (Reserve) this.entity;
		if ((str != "") && (str.equals("H"))) {
			ReserveHis localReserveHis = new ReserveHis();
			localReserveHis.setReserveId(localReserve.getReserveId());
			this.entity = getQueryService().get(localReserveHis);
		} else {
			this.entity = getQueryService().get(localReserve);
		}
		this.entity = getQueryService().get(this.entity);
		return "success";
	}

	public String searchHolding() throws Exception {
		String str = this.request.getParameter("type");
		if ((str != null) && (str.equals("H"))) {
			this.entity = new HoldingHis();
			str = "H";
		} else {
			this.entity = new Holding();
			str = "D";
		}
		super.listByLimit();
		this.request.setAttribute("type", str);
		return "success";
	}

	public String searchHoldingDetail() {
		this.logger.debug("enter searchHoldingDetail");
		String str = this.request.getParameter("type");
		Holding localHolding = (Holding) this.entity;
		if ((str != "") && (str.equals("H"))) {
			HoldingHis localHoldingHis = new HoldingHis();
			localHoldingHis.setHoldingId(localHolding.getHoldingId());
			this.entity = getQueryService().get(localHoldingHis);
		} else {
			this.entity = getQueryService().get(localHolding);
		}
		this.entity = getQueryService().get(this.entity);
		return "success";
	}

	public String searchGoodsMoneyApply() throws Exception {
		String str = this.request.getParameter("type");
		this.logger.debug("=================  searchGoodsMoneyApply===type=" + str);
		if ((str != null) && (str.equals("H"))) {
			this.entity = new GoodsMoneyApplyHis();
			str = "H";
		} else {
			this.entity = new GoodsMoneyApply();
			str = "D";
		}
		PageRequest localPageRequest = super.getPageRequest(this.request);
		localPageRequest.setSortColumns(" order by id desc");
		listByLimit(localPageRequest);
		this.request.setAttribute("type", str);
		return "success";
	}

	private void putResourcePropertys(Set<OrderGoodsProperty> paramSet) {
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
				OrderGoodsProperty localObject2 = (OrderGoodsProperty) ((Iterator) localObject1).next();
				localObject3 = null;
				Iterator localIterator = localLinkedHashMap.keySet().iterator();
				while (localIterator.hasNext()) {
					PropertyType localPropertyType = (PropertyType) localIterator.next();
					if ((((OrderGoodsProperty) localObject2).getPropertyTypeID() != null)
							&& (((OrderGoodsProperty) localObject2).getPropertyTypeID().equals(localPropertyType.getPropertyTypeID()))) {
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

	private void putResourcePropertys_h(Set<OrderGoodsPropertyHis> paramSet) {
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
				OrderGoodsPropertyHis localObject2 = (OrderGoodsPropertyHis) ((Iterator) localObject1).next();
				localObject3 = null;
				Iterator localIterator = localLinkedHashMap.keySet().iterator();
				while (localIterator.hasNext()) {
					PropertyType localPropertyType = (PropertyType) localIterator.next();
					if ((((OrderGoodsPropertyHis) localObject2).getPropertyTypeID() != null)
							&& (((OrderGoodsPropertyHis) localObject2).getPropertyTypeID().equals(localPropertyType.getPropertyTypeID()))) {
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

	private void putResourcePropertys_t(Set<TradeGoodsProperty> paramSet) {
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
				TradeGoodsProperty localObject2 = (TradeGoodsProperty) ((Iterator) localObject1).next();
				localObject3 = null;
				Iterator localIterator = localLinkedHashMap.keySet().iterator();
				while (localIterator.hasNext()) {
					PropertyType localPropertyType = (PropertyType) localIterator.next();
					if ((((TradeGoodsProperty) localObject2).getPropertyTypeID() != null)
							&& (((TradeGoodsProperty) localObject2).getPropertyTypeID().equals(localPropertyType.getPropertyTypeID()))) {
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

	private void putResourcePropertys_t_h(Set<TradeGoodsPropertyHis> paramSet) {
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
				TradeGoodsPropertyHis localObject2 = (TradeGoodsPropertyHis) ((Iterator) localObject1).next();
				localObject3 = null;
				Iterator localIterator = localLinkedHashMap.keySet().iterator();
				while (localIterator.hasNext()) {
					PropertyType localPropertyType = (PropertyType) localIterator.next();
					if ((((TradeGoodsPropertyHis) localObject2).getPropertyTypeID() != null)
							&& (((TradeGoodsPropertyHis) localObject2).getPropertyTypeID().equals(localPropertyType.getPropertyTypeID()))) {
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
