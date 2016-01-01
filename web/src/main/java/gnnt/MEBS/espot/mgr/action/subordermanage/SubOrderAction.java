package gnnt.MEBS.espot.mgr.action.subordermanage;

import java.util.ArrayList;
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

import gnnt.MEBS.common.mgr.action.EcsideAction;
import gnnt.MEBS.common.mgr.common.Page;
import gnnt.MEBS.common.mgr.common.PageRequest;
import gnnt.MEBS.common.mgr.common.QueryConditions;
import gnnt.MEBS.common.mgr.model.User;
import gnnt.MEBS.espot.core.kernel.IOrderAndPickoffOrder;
import gnnt.MEBS.espot.core.vo.ResultVO;
import gnnt.MEBS.espot.mgr.model.commoditymanage.PropertyType;
import gnnt.MEBS.espot.mgr.model.ordermanage.OrderGoodsProperty;
import gnnt.MEBS.espot.mgr.model.subordermanage.SubOrder;

@Controller("subOrderAction")
@Scope("request")
public class SubOrderAction extends EcsideAction {
	private static final long serialVersionUID = 1L;
	@Autowired
	@Qualifier("orderService")
	private IOrderAndPickoffOrder orderService;
	@Resource(name = "firmTypeMap")
	protected Map<String, String> firmTypeMap;
	@Resource(name = "subOrderStatusMap")
	protected Map<String, String> subOrderStatusMap;

	public Map<String, String> getFirmTypeMap() {
		return this.firmTypeMap;
	}

	public Map<String, String> getSubOrderStatusMap() {
		return this.subOrderStatusMap;
	}

	public IOrderAndPickoffOrder getOrderService() {
		return this.orderService;
	}

	public void setOrderService(IOrderAndPickoffOrder paramIOrderAndPickoffOrder) {
		this.orderService = paramIOrderAndPickoffOrder;
	}

	public String subOrderListRevocable() throws Exception {
		this.logger.debug("enter subOrderListRevocable");
		PageRequest localPageRequest = getPageRequest(this.request);
		QueryConditions localQueryConditions = (QueryConditions) localPageRequest.getFilters();
		localQueryConditions.addCondition("status", "=", Integer.valueOf(0));
		localPageRequest.setSortColumns("order by createTime desc");
		listByLimit(localPageRequest);
		return "success";
	}

	public String withdrawSubOrder() {
		this.logger.debug("enter withdrawSubOrder");
		String[] arrayOfString1 = this.request.getParameterValues("ids");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		String str1 = "";
		String str2 = "";
		String str3 = "";
		for (String str4 : arrayOfString1) {
			long l = Long.parseLong(str4);
			try {
				ResultVO localResultVO = this.orderService.withdrawSubOrder(l, localUser.getUserId(), 3);
				if (localResultVO.getResult() <= 0L) {
					addReturnValue(-1, 230003L, new Object[] { localResultVO.getErrorInfo() });
					str2 = str2 + str4 + ",";
					str3 = str3 + str4 + "：" + localResultVO.getErrorInfo() + ";";
				} else {
					addReturnValue(1, 233101L);
					str1 = str1 + str4 + ",";
				}
			} catch (Exception localException) {
				localException.printStackTrace();
				addReturnValue(-1, 230006L, new Object[] { "撤销议价操作" });
				str2 = str2 + str4 + ",";
				str3 = str3 + str4 + "：" + localException.getMessage() + ";";
			}
		}
		if (str2.length() > 0) {
			if (str1.length() > 0) {
				writeOperateLog(2309, "撤销议价编号为：(" + str1.substring(0, str1.lastIndexOf(",")) + ")的议价信息成功,撤销议价编号为：("
						+ str2.substring(0, str2.lastIndexOf(",")) + ")的议价信息失败", 0, str3.substring(0, str3.lastIndexOf(";")));
			} else {
				writeOperateLog(2309, "撤销议价编号为：(" + str2.substring(0, str2.lastIndexOf(",")) + ")的议价信息失败", 0,
						str3.substring(0, str3.lastIndexOf(";")));
			}
		} else {
			writeOperateLog(2309, "撤销议价编号为：(" + str1.substring(0, str1.lastIndexOf(",")) + ")的议价信息", 1, "");
		}
		return "success";
	}

	public String subOrderDetails() throws Exception {
		super.viewById();
		SubOrder localSubOrder = (SubOrder) this.entity;
		if ((localSubOrder != null) && (localSubOrder.getOrder() != null)) {
			putResourcePropertys(localSubOrder.getOrder().getOrderGoodsProperties());
		}
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
}
