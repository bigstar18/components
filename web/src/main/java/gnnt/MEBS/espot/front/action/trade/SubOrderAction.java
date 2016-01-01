package gnnt.MEBS.espot.front.action.trade;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import gnnt.MEBS.common.front.action.StandardAction;
import gnnt.MEBS.common.front.common.Page;
import gnnt.MEBS.common.front.common.PageRequest;
import gnnt.MEBS.common.front.common.QueryConditions;
import gnnt.MEBS.common.front.model.StandardModel;
import gnnt.MEBS.common.front.model.integrated.MFirm;
import gnnt.MEBS.common.front.model.integrated.User;
import gnnt.MEBS.common.front.service.UserService;
import gnnt.MEBS.common.front.statictools.ActionUtil;
import gnnt.MEBS.common.front.statictools.Tools;
import gnnt.MEBS.espot.core.kernel.IOrderAndPickoffOrder;
import gnnt.MEBS.espot.core.vo.ResultVO;
import gnnt.MEBS.espot.front.model.commodity.Category;
import gnnt.MEBS.espot.front.model.commodity.PropertyType;
import gnnt.MEBS.espot.front.model.trade.GoodsProperty;
import gnnt.MEBS.espot.front.model.trade.GoodsPropertyBase;
import gnnt.MEBS.espot.front.model.trade.GoodsPropertyHis;
import gnnt.MEBS.espot.front.model.trade.OrderPic;
import gnnt.MEBS.espot.front.model.trade.SubOrder;
import gnnt.MEBS.espot.front.model.trade.SubOrderBase;
import gnnt.MEBS.espot.front.model.trade.SubOrderHis;

@Controller("subOrderAction")
@Scope("request")
public class SubOrderAction extends StandardAction {
	private static final long serialVersionUID = 4145370732506814507L;
	@Autowired
	@Qualifier("com_userService")
	private UserService userService;
	@Autowired
	@Qualifier("orderAndPickoffOrderService")
	private IOrderAndPickoffOrder orderAndPickoffOrderService;
	@Resource(name = "suborderStatus")
	Map<String, String> suborderStatus;
	@Resource(name = "bsFlagMap")
	Map<String, String> bsFlagMap;
	@Resource(name = "deliveryType")
	Map<String, String> deliveryType;
	@Resource(name = "deliveryDayTypeMap")
	Map<Integer, String> deliveryDayType;
	@Resource(name = "isPermit")
	Map<String, String> isPermit;
	@Resource(name = "isNo")
	Map<String, String> isNo;

	public Map<Integer, String> getDeliveryDayType() {
		return this.deliveryDayType;
	}

	public Map<String, String> getIsNo() {
		return this.isNo;
	}

	public Map<String, String> getIsPermit() {
		return this.isPermit;
	}

	public UserService getUserService() {
		return this.userService;
	}

	public IOrderAndPickoffOrder getOrderAndPickoffOrderService() {
		return this.orderAndPickoffOrderService;
	}

	public Map<String, String> getBsFlagMap() {
		return this.bsFlagMap;
	}

	public Map<String, String> getDeliveryType() {
		return this.deliveryType;
	}

	public Map<String, String> getSuborderStatus() {
		return this.suborderStatus;
	}

	public String performSubOrder() {
		String str = "对委托%s发起议价申请";
		this.logger.debug("提交议价申请");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		SubOrder localSubOrder = (SubOrder) this.entity;
		localSubOrder.setSubFirmID(localUser.getBelongtoFirm().getFirmID());
		str = String.format(str, new Object[] { localSubOrder.getBelongtoOrder().getOrderID() });
		try {
			if (ifhasRight(3, "S") < 0) {
				if (this.request.getAttribute("ReturnValue") != null) {
					writeOperateLog(2309, str, 0, String.valueOf(this.request.getAttribute("ReturnValue")));
				}
				return "success";
			}
			ResultVO localResultVO = this.orderAndPickoffOrderService.performSubOrder(localSubOrder.getSubOrderPO());
			if (localResultVO.getResult() < 0L) {
				addReturnValue(-1, 2300002L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
				writeOperateLog(2309, str, 0, localResultVO.getErrorInfo().replace("\n", ""));
			} else if (localResultVO.getResult() == 0L) {
				addReturnValue(-1, 230000L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
				writeOperateLog(2309, str, 0, localResultVO.getErrorInfo().replace("\n", ""));
			} else {
				addReturnValue(1, 2310301L);
				writeOperateLog(2309, str, 1, "");
			}
		} catch (Exception localException) {
			addReturnValue(-1, 9930091L, new Object[] { localException.getMessage().replaceAll("\n", "") });
			writeOperateLog(2309, str, 0, localException.getMessage());
			this.logger.error(Tools.getExceptionTrace(localException));
		}
		return "success";
	}

	public int ifhasRight(int paramInt, String paramString) {
		if ((paramInt != 2) && (paramInt != 3)) {
			paramInt = 1;
		}
		if (!"B".equalsIgnoreCase(paramString)) {
			paramString = "S";
		}
		User localUser1 = (User) this.request.getSession().getAttribute("CurrentUser");
		User localUser2 = this.userService.getTraderByID(localUser1.getTraderID());
		MFirm localMFirm = localUser2.getBelongtoFirm();
		if ("D".equalsIgnoreCase(localMFirm.getStatus())) {
			addReturnValue(-1, 2310101L);
			return -1;
		}
		if ("E".equalsIgnoreCase(localMFirm.getStatus())) {
			addReturnValue(-1, 2300002L, new Object[] { "交易商已删除" });
			return -1;
		}
		if ("D".equalsIgnoreCase(localUser2.getStatus())) {
			addReturnValue(-1, 2310102L);
			return -1;
		}
		return 1;
	}

	public String revokeSubOrder() {
		String str = "撤销议价申请%s";
		this.logger.debug("撤销议价申请");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		long l = Tools.strToLong(this.request.getParameter("subOrderID"), -1000L);
		if (l > 0L) {
			str = String.format(str, new Object[] { Long.valueOf(l) });
			try {
				ResultVO localResultVO = this.orderAndPickoffOrderService.withdrawSubOrder(l, localUser.getTraderID(), 2);
				if (localResultVO.getResult() < 0L) {
					addReturnValue(-1, 2300002L, new Object[] { localResultVO.getErrorInfo().replaceAll("\n", "") });
					writeOperateLog(2309, str, 0, localResultVO.getErrorInfo().replace("\n", ""));
				} else if (localResultVO.getResult() == 0L) {
					addReturnValue(-1, 2300003L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, str, 0, localResultVO.getErrorInfo().replace("\n", ""));
				} else {
					addReturnValue(1, 2310302L);
					writeOperateLog(2309, str, 1, "");
				}
			} catch (Exception localException) {
				addReturnValue(-1, 9930091L, new Object[] { localException.getMessage().replaceAll("\n", "") });
				this.logger.error(Tools.getExceptionTrace(localException));
			}
		} else {
			str = String.format(str, new Object[] { "" });
			writeOperateLog(2309, str, 0, "传入议价编号为空");
			addReturnValue(-1, 2300002L, new Object[] { "传入议价编号为空撤销议价" });
		}
		return "success";
	}

	public String refuseSubOrder() {
		String str1 = "拒绝对方议价申请%s";
		this.logger.debug("拒绝议价信息");
		long l = Tools.strToLong(this.request.getParameter("subOrderID"), -1000L);
		String str2 = this.request.getParameter("reply");
		if (l > 0L) {
			str1 = String.format(str1, new Object[] { Long.valueOf(l) });
			try {
				ResultVO localResultVO = this.orderAndPickoffOrderService.replySubOrder(l, str2);
				if (localResultVO.getResult() < 0L) {
					addReturnValue(-1, 2300002L, new Object[] { localResultVO.getErrorInfo().replaceAll("\n", "") });
					writeOperateLog(2309, str1, 0, localResultVO.getErrorInfo().replace("\n", ""));
				} else if (localResultVO.getResult() == 0L) {
					addReturnValue(-1, 2300003L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, str1, 0, localResultVO.getErrorInfo().replace("\n", ""));
				} else {
					addReturnValue(1, 2310303L);
					writeOperateLog(2309, str1, 1, "");
				}
			} catch (Exception localException) {
				addReturnValue(-1, 9930091L, new Object[] { localException.getMessage().replaceAll("\n", "") });
				writeOperateLog(2309, str1, 0, localException.getMessage());
				this.logger.error(Tools.getExceptionTrace(localException));
			}
		} else {
			str1 = String.format(str1, new Object[] { "" });
			writeOperateLog(2309, str1, 0, "传入议价编号为空");
			addReturnValue(-1, 2300001L, new Object[] { "传入议价编号为空回复议价" });
		}
		return "success";
	}

	public String suborderList() {
		this.logger.debug("议价列表查询");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		PageRequest localPageRequest = null;
		try {
			localPageRequest = ActionUtil.getPageRequest(this.request);
		} catch (Exception localException) {
			this.logger.error(Tools.getExceptionTrace(localException));
		}
		QueryConditions localQueryConditions = (QueryConditions) localPageRequest.getFilters();
		localQueryConditions.addCondition(" ", " ", "(subFirmID='" + localUser.getBelongtoFirm().getFirmID()
				+ "' or belongtoOrder.belongtoMFirm.firmID='" + localUser.getBelongtoFirm().getFirmID() + "')");
		String str = this.request.getParameter("launcher");
		if ("main".equals(str)) {
			localQueryConditions.addCondition(" ", " ", "subFirmID='" + localUser.getBelongtoFirm().getFirmID() + "'");
		} else if ("other".equals(str)) {
			localQueryConditions.addCondition(" ", " ", "belongtoOrder.belongtoMFirm.firmID='" + localUser.getBelongtoFirm().getFirmID() + "'");
		}
		Object localObject = null;
		if ("H".equalsIgnoreCase(this.request.getParameter("isHistory"))) {
			localObject = new SubOrderHis();
		} else {
			localObject = new SubOrder();
		}
		Page localPage = getService().getPage(localPageRequest, (StandardModel) localObject);
		this.request.setAttribute("launcher", str);
		this.request.setAttribute("isHistory", this.request.getParameter("isHistory"));
		this.request.setAttribute("pageInfo", localPage);
		this.request.setAttribute("oldParams", ActionUtil.getParametersStartingWith(this.request, "gnnt_"));
		return "success";
	}

	public String suborderDetails() {
		this.logger.debug("议价详细信息");
		long l1 = Tools.strToLong(this.request.getParameter("subOrderID"), -1000L);
		String str = this.request.getParameter("isForPickOff");
		if (l1 > 0L) {
			Object localObject1 = null;
			long l2 = 1000L;
			if ("H".equalsIgnoreCase(this.request.getParameter("isHistory"))) {
				localObject1 = new SubOrderHis();
				((SubOrderBase) localObject1).setSubOrderID(Long.valueOf(l1));
				localObject1 = (SubOrderBase) getService().get((StandardModel) localObject1);
				l2 = ((SubOrderHis) localObject1).getBelongtoOrder().getCategoryID().longValue();
			} else {
				localObject1 = new SubOrder();
				((SubOrderBase) localObject1).setSubOrderID(Long.valueOf(l1));
				localObject1 = (SubOrderBase) getService().get((StandardModel) localObject1);
				l2 = ((SubOrder) localObject1).getBelongtoOrder().getCategoryID().longValue();
				if (null != str) {
					if (((SubOrder) localObject1).getBelongtoOrder().getStatus().intValue() == 2) {
						addReturnValue(-1, 2310107L);
					} else if (((SubOrder) localObject1).getBelongtoOrder().getStatus().intValue() == 3) {
						addReturnValue(-1, 2310108L);
					}
				}
			}
			if (localObject1 != null) {
				LinkedHashSet localObject2 = new LinkedHashSet();
				if ((localObject1 instanceof SubOrderHis)) {
					SubOrderHis localObject3 = (SubOrderHis) localObject1;
					if ((((SubOrderHis) localObject3).getBelongtoOrder() != null)
							&& (((SubOrderHis) localObject3).getBelongtoOrder().getContainGoodsProperty() != null)) {
						Iterator localObject4 = ((SubOrderHis) localObject3).getBelongtoOrder().getContainGoodsProperty().iterator();
						while (((Iterator) localObject4).hasNext()) {
							GoodsPropertyHis localObject5 = (GoodsPropertyHis) ((Iterator) localObject4).next();
							((Set) localObject2).add(localObject5);
						}
					}
				} else {
					SubOrder localObject3 = (SubOrder) localObject1;
					if ((((SubOrder) localObject3).getBelongtoOrder() != null)
							&& (((SubOrder) localObject3).getBelongtoOrder().getContainGoodsProperty() != null)) {
						Iterator localObject4 = ((SubOrder) localObject3).getBelongtoOrder().getContainGoodsProperty().iterator();
						while (((Iterator) localObject4).hasNext()) {
							GoodsProperty localObject5 = (GoodsProperty) ((Iterator) localObject4).next();
							((Set) localObject2).add(localObject5);
						}
					}
				}
				putResourcePropertys((Set) localObject2);
			}
			Object localObject2 = new PageRequest(" and primary.status=1 and primary.categoryID=" + l2);
			Object localObject3 = getService().getPage((PageRequest) localObject2, new Category());
			this.request.setAttribute("page", localObject3);
			this.request.setAttribute("isHistory", this.request.getParameter("isHistory"));
			this.request.setAttribute("subOrder", localObject1);
			Object localObject4 = new PageRequest(" and primary.orderID=" + ((SubOrder) localObject1).getBelongtoOrder().getOrderID());
			((PageRequest) localObject4).setPageSize(100);
			Object localObject5 = getService().getPage((PageRequest) localObject4, new OrderPic());
			this.request.setAttribute("imagePicList", localObject5);
		}
		if (null != str) {
			return "forPickOff";
		}
		return "success";
	}

	private void putResourcePropertys(Set<GoodsPropertyBase> paramSet) {
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
				GoodsPropertyBase localObject2 = (GoodsPropertyBase) ((Iterator) localObject1).next();
				localObject3 = null;
				Iterator localIterator = localLinkedHashMap.keySet().iterator();
				while (localIterator.hasNext()) {
					PropertyType localPropertyType = (PropertyType) localIterator.next();
					if ((((GoodsPropertyBase) localObject2).getPropertyTypeID() != null)
							&& (((GoodsPropertyBase) localObject2).getPropertyTypeID().equals(localPropertyType.getPropertyTypeID()))) {
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
