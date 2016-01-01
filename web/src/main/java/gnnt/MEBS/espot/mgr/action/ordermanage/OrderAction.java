package gnnt.MEBS.espot.mgr.action.ordermanage;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
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
import gnnt.MEBS.espot.core.kernel.IOrderAndPickoffOrder;
import gnnt.MEBS.espot.core.vo.FeeComputeArithmeticVO;
import gnnt.MEBS.espot.core.vo.OrderResultVO;
import gnnt.MEBS.espot.core.vo.ResultVO;
import gnnt.MEBS.espot.mgr.model.commoditymanage.Breed;
import gnnt.MEBS.espot.mgr.model.commoditymanage.BreedProps;
import gnnt.MEBS.espot.mgr.model.commoditymanage.Category;
import gnnt.MEBS.espot.mgr.model.commoditymanage.CategoryProperty;
import gnnt.MEBS.espot.mgr.model.commoditymanage.PropertyType;
import gnnt.MEBS.espot.mgr.model.firmmanage.MFirm;
import gnnt.MEBS.espot.mgr.model.ordermanage.Order;
import gnnt.MEBS.espot.mgr.model.ordermanage.OrderGoodsProperty;
import gnnt.MEBS.espot.mgr.model.ordermanage.OrderPic;
import gnnt.MEBS.espot.mgr.model.ordermanage.OrderPicHis;
import gnnt.MEBS.espot.mgr.model.parametermanage.TradeRight;
import gnnt.MEBS.espot.mgr.model.stockmanage.Stock;
import gnnt.MEBS.espot.mgr.model.stockmanage.StockGoodsProperty;
import gnnt.MEBS.espot.mgr.model.stockmanage.Warehouse;
import net.sf.json.JSONArray;

@Controller("orderAction")
@Scope("request")
public class OrderAction extends EcsideAction {
	private static final long serialVersionUID = 1L;
	@Autowired
	@Qualifier("orderService")
	private IOrderAndPickoffOrder orderService;
	private JSONArray jsonReturn;
	@Autowired
	@Qualifier("kernelService")
	private IKernelService kernelService;
	@Resource(name = "bsFlagMap")
	protected Map<String, String> bsFlagMap;
	@Resource(name = "deliveryDayTypeMap")
	protected Map<String, String> deliveryDayTypeMap;
	@Resource(name = "deliveryTypeMap")
	protected Map<String, String> deliveryTypeMap;
	@Resource(name = "orderStatusMap")
	protected Map<String, String> orderStatusMap;
	@Resource(name = "isPickOrSubOrderMap")
	protected Map<String, String> isPickOrSubOrderMap;
	private List<OrderGoodsProperty> goodsPropertys;
	@Resource(name = "tradeTypeMap")
	protected Map<String, String> tradeTypeMap;
	@Resource(name = "payTypeMap")
	protected Map<String, String> payTypeMap;
	private String[] fileNameFileName;
	private File[] fileName;
	@Autowired
	@Resource(name = "imageTypeList")
	private List<String> imageTypeList;
	private ResultVO result;

	public List<String> getImageTypeList() {
		return this.imageTypeList;
	}

	public String[] getFileNameFileName() {
		return this.fileNameFileName;
	}

	public void setFileNameFileName(String[] paramArrayOfString) {
		this.fileNameFileName = paramArrayOfString;
	}

	public File[] getFileName() {
		return this.fileName;
	}

	public void setFileName(File[] paramArrayOfFile) {
		this.fileName = paramArrayOfFile;
	}

	public List<OrderGoodsProperty> getGoodsPropertys() {
		return this.goodsPropertys;
	}

	public void setGoodsPropertys(List<OrderGoodsProperty> paramList) {
		this.goodsPropertys = paramList;
	}

	public JSONArray getJsonReturn() {
		return this.jsonReturn;
	}

	public void setJsonReturn(JSONArray paramJSONArray) {
		this.jsonReturn = paramJSONArray;
	}

	public Map<String, String> getOrderStatusMap() {
		return this.orderStatusMap;
	}

	public Map<String, String> getDeliveryTypeMap() {
		return this.deliveryTypeMap;
	}

	public Map<String, String> getBsFlagMap() {
		return this.bsFlagMap;
	}

	public Map<String, String> getDeliveryDayTypeMap() {
		return this.deliveryDayTypeMap;
	}

	public IOrderAndPickoffOrder getOrderService() {
		return this.orderService;
	}

	public void setOrderService(IOrderAndPickoffOrder paramIOrderAndPickoffOrder) {
		this.orderService = paramIOrderAndPickoffOrder;
	}

	public ResultVO getResult() {
		return this.result;
	}

	public void setResult(ResultVO paramResultVO) {
		this.result = paramResultVO;
	}

	public IKernelService getKernelService() {
		return this.kernelService;
	}

	public void setKernelService(IKernelService paramIKernelService) {
		this.kernelService = paramIKernelService;
	}

	public String addForwardOrder() {
		this.logger.debug("============添加跳转==========addForwardOrder=====");
		PageRequest localPageRequest = new PageRequest(" and primary.type='leaf' and primary.status=1 and primary.belongModule like '%23%'");
		localPageRequest.setPageSize(100000);
		localPageRequest.setSortColumns("order by primary.sortNo");
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
		String str2 = "select t.runtimevalue from E_SYSTEMPROPS t where t.key = 'DeliveryPreTime'";
		List localList3 = getService().getDao().queryBySql(str2);
		this.request.setAttribute("deliveryPreHour", ((Map) localList3.get(0)).get("RUNTIMEVALUE"));
		String str3 = "select t.runtimevalue from E_SYSTEMPROPS t where t.key = 'OrderValidTime'";
		List localList4 = getService().getDao().queryBySql(str3);
		this.request.setAttribute("orderPreHour", ((Map) localList4.get(0)).get("RUNTIMEVALUE"));
		return "success";
	}

	public int ifhasRight(String paramString1, int paramInt, String paramString2) {
		if ((paramInt != 2) && (paramInt != 3)) {
			paramInt = 1;
		}
		if (!"B".equalsIgnoreCase(paramString2)) {
			paramString2 = "S";
		}
		MFirm localMFirm = new MFirm();
		localMFirm.setFirmId(paramString1);
		localMFirm = (MFirm) getService().get(localMFirm);
		if ("D".equalsIgnoreCase(localMFirm.getStatus())) {
			addReturnValue(-1, 230003L, new Object[] { "交易商被冻结" });
			return -1;
		}
		if ("E".equalsIgnoreCase(localMFirm.getStatus())) {
			addReturnValue(-1, 230003L, new Object[] { "交易商已删除" });
			return -1;
		}
		QueryConditions localQueryConditions = new QueryConditions();
		localQueryConditions.addCondition("primary.firm.firmId", "=", localMFirm.getFirmId());
		PageRequest localPageRequest = new PageRequest(1, 2, localQueryConditions);
		Page localPage = getService().getPage(localPageRequest, new TradeRight());
		if ((localPage.getResult() != null) && (localPage.getResult().size() == 1)) {
			TradeRight localTradeRight = (TradeRight) localPage.getResult().get(0);
			if (paramInt == 1) {
				if (("B".equalsIgnoreCase(paramString2)) && (localTradeRight.getBuyOrder().intValue() == 0)) {
					addReturnValue(-1, 230003L, new Object[] { "您没有买委托的权限" });
					return -1;
				}
				if (("S".equalsIgnoreCase(paramString2)) && (localTradeRight.getSellOrder().intValue() == 0)) {
					addReturnValue(-1, 230003L, new Object[] { "您没有卖委托的权限" });
					return -1;
				}
			}
			if (paramInt == 2) {
				if (("B".equalsIgnoreCase(paramString2)) && (localTradeRight.getBuyPick().intValue() == 0)) {
					addReturnValue(-1, 230003L, new Object[] { "您没有购买的权限" });
					return -1;
				}
				if (("S".equalsIgnoreCase(paramString2)) && (localTradeRight.getSellPick().intValue() == 0)) {
					addReturnValue(-1, 230003L, new Object[] { "您没有销售的权限" });
					return -1;
				}
			}
		}
		return 1;
	}

	public String performOrder() {
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		String str1 = this.request.getParameter("firmId");
		if (("".equals(str1)) || (str1 == null)) {
			addReturnValue(-1, 230003L, new Object[] { "交易商为空！" });
			return "success";
		}
		String str2 = (String) ServletActionContext.getRequest().getAttribute("ExceededError");
		if (str2 != null) {
			this.logger.debug(str2);
			addReturnValue(-1, 236103L, new Object[] { str2 });
			return "success";
		}
		if (this.fileNameFileName != null) {
			for (int i = 0; i < this.fileNameFileName.length; i++) {
				if (this.fileNameFileName[i] != null) {
					String[] localObject1 = this.fileNameFileName[i].split("\\.");
					String str4 = localObject1[(localObject1.length - 1)];
					if (!this.imageTypeList.contains(str4.toLowerCase())) {
						addReturnValue(-1, 236102L);
						return "success";
					}
				}
			}
		}
		String str3 = "管理员：" + localUser.getUserId() + "代交易商：" + str1 + "发布委托";
		this.logger.debug(str3);
		Object localObject1 = (Order) this.entity;
		String str4 = "B";
		if (!"B".equalsIgnoreCase(((Order) localObject1).getBsFlag())) {
			str4 = "S";
		}
		if (ifhasRight(str1, 1, str4) < 0) {
			if (this.request.getAttribute("ReturnValue") != null) {
				writeOperateLog(2309, str3, 0, String.valueOf(this.request.getAttribute("ReturnValue")));
			}
			return "success";
		}
		String str5 = this.request.getParameter("tradeWay");
		if ("1".equals(str5)) {
			((Order) localObject1).setIsSuborder("N");
			((Order) localObject1).setIsPickOff("Y");
		} else if ("2".equals(str5)) {
			((Order) localObject1).setIsSuborder("Y");
			((Order) localObject1).setIsPickOff("Y");
		} else if ("3".equals(str5)) {
			((Order) localObject1).setIsSuborder("Y");
			((Order) localObject1).setIsPickOff("N");
		}
		((Order) localObject1).setFirmId(str1);
		((Order) localObject1).setTraderId(str1);
		this.logger.debug("================ISPAYMARGIN:" + ((Order) localObject1).getIsPayMargin());
		Object localObject2;
		if (this.goodsPropertys != null) {
			localObject2 = this.goodsPropertys.iterator();
			while (((Iterator) localObject2).hasNext()) {
				OrderGoodsProperty localOrderGoodsProperty = (OrderGoodsProperty) ((Iterator) localObject2).next();
				this.logger.debug("property[" + localOrderGoodsProperty.getPropertyName() + "][" + localOrderGoodsProperty.getPropertyValue() + "]");
				((Order) localObject1).addGoodsProperty(localOrderGoodsProperty);
			}
		}
		try {
			localObject2 = getOrderService().performOrder(((Order) localObject1).getOrderBO());
			if (((OrderResultVO) localObject2).getResult() < 0L) {
				addReturnValue(-1, 230003L, new Object[] { ((OrderResultVO) localObject2).getErrorInfo().replace("\n", "") });
				writeOperateLog(2309,
						str3 + "，分类编号 " + ((Order) localObject1).getCategoryId() + " 品名编号 " + ((Order) localObject1).getBreed().getBreedId(), 0,
						((OrderResultVO) localObject2).getErrorInfo().replace("\n", ""));
			} else if (((OrderResultVO) localObject2).getResult() == 0L) {
				addReturnValue(-1, 230005L, new Object[] { ((OrderResultVO) localObject2).getErrorInfo().replaceAll("\n", "") });
				writeOperateLog(2309,
						str3 + "，分类编号 " + ((Order) localObject1).getCategoryId() + " 品名编号 " + ((Order) localObject1).getBreed().getBreedId(), 0,
						((OrderResultVO) localObject2).getErrorInfo().replace("\n", ""));
			} else {
				if (this.fileName != null) {
					for (int j = 0; j < this.fileName.length; j++) {
						if (this.fileName[j] != null) {
							FileInputStream localFileInputStream = new FileInputStream(this.fileName[j]);
							byte[] arrayOfByte = new byte[localFileInputStream.available()];
							localFileInputStream.read(arrayOfByte);
							OrderPic localOrderPic = new OrderPic();
							localOrderPic.setOrderID(Long.valueOf(((OrderResultVO) localObject2).getOrderID()));
							localOrderPic.setPicture(arrayOfByte);
							getService().add(localOrderPic);
						}
					}
				}
				addReturnValue(1, 236100L);
				writeOperateLog(2309, str3 + ((OrderResultVO) localObject2).getOrderID(), 1, "");
			}
		} catch (Exception localException) {
			addReturnValue(-1, 230004L, new Object[] { "委托发布操作" });
			writeOperateLog(2309, str3, 0, localException.getMessage());
			this.logger.error(Tools.getExceptionTrace(localException));
		}
		return "success";
	}

	public String performOrderStock() {
		this.logger.debug("通过仓单委托");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		String str1 = this.request.getParameter("firmId");
		String str2 = this.request.getParameter("stockID");
		if (("".equals(str1)) || (str1 == null)) {
			addReturnValue(-1, 230003L, new Object[] { "交易商为空！" });
			return "success";
		}
		String str3 = (String) ServletActionContext.getRequest().getAttribute("ExceededError");
		if (str3 != null) {
			this.logger.debug(str3);
			addReturnValue(-1, 236103L, new Object[] { str3 });
			return "success";
		}
		if (this.fileNameFileName != null) {
			for (int i = 0; i < this.fileNameFileName.length; i++) {
				if (this.fileNameFileName[i] != null) {
					String[] localObject1 = this.fileNameFileName[i].split("\\.");
					String str5 = localObject1[(localObject1.length - 1)];
					if (!this.imageTypeList.contains(str5.toLowerCase())) {
						addReturnValue(-1, 236102L);
						return "success";
					}
				}
			}
		}
		if (("".equals(str2)) || (str2 == null)) {
			addReturnValue(-1, 230003L, new Object[] { "仓单为空！" });
			return "success";
		}
		String str4 = "管理员：" + localUser.getUserId() + "代交易商：" + str1 + "通过仓单：" + str2 + "发布委托";
		this.logger.debug(str4);
		Object localObject1 = (Order) this.entity;
		String str5 = "B";
		if (!"B".equalsIgnoreCase(((Order) localObject1).getBsFlag())) {
			str5 = "S";
		}
		if (ifhasRight(str1, 1, str5) < 0) {
			if (this.request.getAttribute("ReturnValue") != null) {
				writeOperateLog(2309, str4, 0, String.valueOf(this.request.getAttribute("ReturnValue")));
			}
			return "success";
		}
		String str6 = this.request.getParameter("tradeWay");
		if ("1".equals(str6)) {
			((Order) localObject1).setIsSuborder("N");
			((Order) localObject1).setIsPickOff("Y");
		} else if ("2".equals(str6)) {
			((Order) localObject1).setIsSuborder("Y");
			((Order) localObject1).setIsPickOff("Y");
		} else if ("3".equals(str6)) {
			((Order) localObject1).setIsSuborder("Y");
			((Order) localObject1).setIsPickOff("N");
		}
		((Order) localObject1).setFirmId(str1);
		((Order) localObject1).setTraderId(str1);
		this.logger.debug("================ISPAYMARGIN:" + ((Order) localObject1).getIsPayMargin());
		Object localObject2;
		if (this.goodsPropertys != null) {
			localObject2 = this.goodsPropertys.iterator();
			while (((Iterator) localObject2).hasNext()) {
				OrderGoodsProperty localOrderGoodsProperty = (OrderGoodsProperty) ((Iterator) localObject2).next();
				this.logger.debug("property[" + localOrderGoodsProperty.getPropertyName() + "][" + localOrderGoodsProperty.getPropertyValue() + "]");
				((Order) localObject1).addGoodsProperty(localOrderGoodsProperty);
			}
		}
		this.logger.debug("买方诚信保障金：" + ((Order) localObject1).getTradeMargin_B());
		this.logger.debug("卖方诚信保障金：" + ((Order) localObject1).getTradeMargin_S());
		this.logger.debug("买方交割保证金：" + ((Order) localObject1).getDeliveryMargin_B());
		this.logger.debug("卖方交割保证金：" + ((Order) localObject1).getDeliveryMargin_S());
		try {
			str4 = String.format(str4, new Object[] { str2 });
			localObject2 = getOrderService().performOrderStock(((Order) localObject1).getOrderBO().orderPO, str2);
			if (((OrderResultVO) localObject2).getResult() < 0L) {
				addReturnValue(-1, 23003L, new Object[] { ((OrderResultVO) localObject2).getErrorInfo().replace("\n", "").replaceAll("\n", "") });
				writeOperateLog(2309, str4, 0, ((OrderResultVO) localObject2).getErrorInfo().replace("\n", ""));
			} else if (((OrderResultVO) localObject2).getResult() == 0L) {
				addReturnValue(-1, 23005L, new Object[] { ((OrderResultVO) localObject2).getErrorInfo().replace("\n", "") });
				writeOperateLog(2309, str4, 0, ((OrderResultVO) localObject2).getErrorInfo().replace("\n", ""));
			} else {
				if (this.fileName != null) {
					for (int j = 0; j < this.fileName.length; j++) {
						if (this.fileName[j] != null) {
							FileInputStream localFileInputStream = new FileInputStream(this.fileName[j]);
							byte[] arrayOfByte = new byte[localFileInputStream.available()];
							localFileInputStream.read(arrayOfByte);
							OrderPic localOrderPic = new OrderPic();
							localOrderPic.setOrderID(Long.valueOf(((OrderResultVO) localObject2).getOrderID()));
							localOrderPic.setPicture(arrayOfByte);
							getService().add(localOrderPic);
						}
					}
				}
				addReturnValue(1, 236100L);
				writeOperateLog(2309, str4 + "成功，委托号：" + ((OrderResultVO) localObject2).getOrderID(), 1, "");
			}
		} catch (Exception localException) {
			addReturnValue(-1, 23004L, new Object[] { "仓单委托" });
			writeOperateLog(2309, str4 + "失败", 0, localException.getMessage());
			this.logger.error(Tools.getExceptionTrace(localException));
		}
		return "success";
	}

	public String orderDetails() {
		Order localOrder = (Order) getService().get(this.entity);
		PageRequest localPageRequest = new PageRequest(" and primary.orderID=" + localOrder.getOrderId());
		Page localPage = getService().getPage(localPageRequest, new OrderPic());
		this.request.setAttribute("imageList", localPage.getResult());
		this.entity = localOrder;
		putResourcePropertys(localOrder.getOrderGoodsProperties());
		return "success";
	}

	public String withdrawOrder() {
		this.logger.debug("enter withdrawOrder");
		String[] arrayOfString1 = this.request.getParameterValues("ids");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		String str1 = "";
		String str2 = "";
		String str3 = "";
		for (String str4 : arrayOfString1) {
			long l = Long.parseLong(str4);
			try {
				ResultVO localResultVO = this.orderService.withdrawOrder(l, localUser.getUserId());
				if (localResultVO.getResult() <= 0L) {
					addReturnValue(-1, -10001L, new Object[] { localResultVO.getErrorInfo() });
					str2 = str2 + str4 + ",";
					str3 = str3 + str4 + "：" + localResultVO.getErrorInfo() + ";";
				} else {
					addReturnValue(1, 233101L);
					str1 = str1 + str4 + ",";
				}
			} catch (Exception localException) {
				localException.printStackTrace();
				addReturnValue(-1, 230006L, new Object[] { "撤销委托操作" });
				str2 = str2 + str4 + ",";
				str3 = str3 + str4 + "：" + localException.getMessage() + ";";
			}
		}
		if (str2.length() > 0) {
			if (str1.length() > 0) {
				writeOperateLog(2309, "撤销委托号为：(" + str1.substring(0, str1.lastIndexOf(",")) + ")的委托成功,撤销委托号为：("
						+ str2.substring(0, str2.lastIndexOf(",")) + ")的委托失败", 0, str3.substring(0, str3.lastIndexOf(";")));
			} else {
				writeOperateLog(2309, "撤销委托号为：(" + str2.substring(0, str2.lastIndexOf(",")) + ")的委托失败", 0, str3.substring(0, str3.lastIndexOf(";")));
			}
		} else {
			writeOperateLog(2309, "撤销委托号为：(" + str1.substring(0, str1.lastIndexOf(",")) + ")的委托", 1, "");
		}
		return "success";
	}

	public String listRevocable() throws Exception {
		this.logger.debug("enter listRevocable");
		PageRequest localPageRequest = getPageRequest(this.request);
		QueryConditions localQueryConditions = (QueryConditions) localPageRequest.getFilters();
		localQueryConditions.addCondition("status", "in", "(0,1)");
		localPageRequest.setSortColumns("order by orderTime desc");
		listByLimit(localPageRequest);
		return "success";
	}

	public String listAudit() throws Exception {
		this.logger.debug("enter listAudit");
		PageRequest localPageRequest = getPageRequest(this.request);
		QueryConditions localQueryConditions = (QueryConditions) localPageRequest.getFilters();
		localQueryConditions.addCondition("status", "in", "(11)");
		localPageRequest.setSortColumns("order by orderId");
		listByLimit(localPageRequest);
		return "success";
	}

	public String passAudit() {
		this.logger.debug("enter passAudit");
		Order localOrder = (Order) this.entity;
		try {
			localOrder.setEffectOfTime(getService().getSysDate());
		} catch (Exception localException) {
			localOrder.setEffectOfTime(new Date());
		}
		localOrder.setStatus(Integer.valueOf(0));
		getService().update(localOrder);
		addReturnValue(1, 233102L);
		writeOperateLog(2309, "审核委托号为：" + localOrder.getOrderId() + "的委托", 1, "");
		return "success";
	}

	public String unPassAudit() {
		this.logger.debug("enter unPassAudit=======审核不通过");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		try {
			ResultVO localResultVO = this.orderService.withdrawOrder(((Long) this.entity.fetchPKey().getValue()).longValue(), localUser.getUserId());
			if (localResultVO.getResult() <= 0L) {
				addReturnValue(-1, 230003L, new Object[] { localResultVO.getErrorInfo() });
				writeOperateLog(2309, "审核委托号为：" + this.entity.fetchPKey().getValue() + "的委托", 0, localResultVO.getErrorInfo());
			} else {
				addReturnValue(1, 233103L);
				writeOperateLog(2309, "审核委托号为：" + this.entity.fetchPKey().getValue() + "的委托", 1, "");
			}
		} catch (Exception localException) {
			localException.printStackTrace();
			addReturnValue(-1, 230006L, new Object[] { "交易核心异常" });
			writeOperateLog(2309, "审核委托号为：" + this.entity.fetchPKey().getValue() + "的委托", 0, localException.getMessage());
		}
		return "success";
	}

	public String getBreedByCategoryID() {
		this.logger.debug("---通过商品分类ID查询品种信息并加入到json中---orderAction---getBreedByCategoryID--");
		this.jsonReturn = new JSONArray();
		long l = Tools.strToLong(this.request.getParameter("categoryId"), -1000L);
		String str1 = "";
		str1 = this.request.getParameter("firmId");
		String str2 = "select * from E_TRADERIGHT t where t.firmid='" + str1 + "'";
		List localList = getService().getListBySql(str2, new TradeRight());
		String str3 = "1";
		Object localObject1;
		if ((null != localList) && (localList.size() == 1)) {
			localObject1 = (TradeRight) localList.get(0);
			str3 = ((TradeRight) localObject1).getIsPickOff() + "";
		}
		if (l < 0L) {
			this.jsonReturn.add("=" + str3);
			return "success";
		}
		Object localObject2;
		try {
			localObject1 = this.kernelService.getDeliveryMarginArithmetic(str1, l);
			double d1 = this.kernelService.getOneTradeMargin();
			double d2 = this.kernelService.getOneTradeMargin();
			localObject2 = this.kernelService.getDeliveryMarginArithmetic("", l);
			this.jsonReturn.add(((FeeComputeArithmeticVO) localObject1).getMode() + ":" + ((FeeComputeArithmeticVO) localObject1).getRate() + "=" + d1
					+ "=" + ((FeeComputeArithmeticVO) localObject2).getMode() + ":" + ((FeeComputeArithmeticVO) localObject2).getRate() + "=" + d2
					+ "=" + str3);
			this.logger.debug(((FeeComputeArithmeticVO) localObject1).getMode() + ":" + ((FeeComputeArithmeticVO) localObject1).getRate() + "=" + d1
					+ "=" + ((FeeComputeArithmeticVO) localObject2).getMode() + ":" + ((FeeComputeArithmeticVO) localObject2).getRate() + "=" + d2
					+ "=" + str3);
		} catch (RemoteException localRemoteException) {
			this.jsonReturn.add("1:1=1:1");
			this.logger.error(Tools.getExceptionTrace(localRemoteException));
		}
		PageRequest localPageRequest = new PageRequest(" and primary.type='leaf'and primary.status=1 and primary.belongModule like '%23%'");
		localPageRequest.setSortColumns("order by  primary.parentCategory.sortNo,primary.sortNo");
		Page localPage = getService().getPage(localPageRequest, new Category());
		if ((localPage.getResult() != null) && (localPage.getResult().size() > 0)) {
			Iterator localIterator = localPage.getResult().iterator();
			while (localIterator.hasNext()) {
				StandardModel localStandardModel = (StandardModel) localIterator.next();
				Category localCategory = (Category) localStandardModel;
				if (l == localCategory.getCategoryId().longValue()) {
					localObject2 = localCategory.getBreedSet().iterator();
					while (((Iterator) localObject2).hasNext()) {
						Breed localBreed = (Breed) ((Iterator) localObject2).next();
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

	public String getPropertyPagValueByBreedID() {
		long l = Tools.strToLong(this.request.getParameter("breedId"), -1000L);
		if (l > 0L) {
			Breed localBreed = new Breed();
			localBreed.setBreedId(Long.valueOf(l));
			localBreed = (Breed) getService().get(localBreed);
			if (localBreed != null) {
				QueryConditions localQueryConditions = new QueryConditions();
				localQueryConditions.addCondition("status", "=", Integer.valueOf(0));
				PageRequest localPageRequest = new PageRequest(1, 100, localQueryConditions, " order by sortNo ");
				Page localPage = getService().getPage(localPageRequest, new PropertyType());
				HashMap localHashMap1 = new HashMap();
				LinkedHashMap localLinkedHashMap = new LinkedHashMap();
				if ((localPage != null) && (localPage.getResult() != null)) {
					for (int i = 0; i < localPage.getResult().size(); i++) {
						PropertyType localObject1 = (PropertyType) localPage.getResult().get(i);
						localLinkedHashMap.put(((PropertyType) localObject1).getPropertyTypeID(), new LinkedHashMap());
						localHashMap1.put(((PropertyType) localObject1).getPropertyTypeID(), ((PropertyType) localObject1).getName());
					}
				}
				Long localLong = Long.valueOf(-1L);
				localLinkedHashMap.put(localLong, new LinkedHashMap());
				localHashMap1.put(localLong, "其它属性");
				Object localObject1 = localBreed.getCategory().getPropertySet();
				HashMap localHashMap2 = new HashMap();
				Object localObject2 = ((Set) localObject1).iterator();
				Object localObject4;
				while (((Iterator) localObject2).hasNext()) {
					CategoryProperty localObject3 = (CategoryProperty) ((Iterator) localObject2).next();
					localObject4 = (Map) localLinkedHashMap.get(((CategoryProperty) localObject3).getPropertyTypeID());
					if (localObject4 == null) {
						localObject4 = (Map) localLinkedHashMap.get(localLong);
					}
					((Map) localObject4).put(((CategoryProperty) localObject3).getPropertyId(), new ArrayList());
					localHashMap2.put(((CategoryProperty) localObject3).getPropertyId(), localObject3);
				}
				if (localBreed.getPropsSet() != null) {
					localObject2 = localBreed.getPropsSet().iterator();
					while (((Iterator) localObject2).hasNext()) {
						BreedProps localObject3 = (BreedProps) ((Iterator) localObject2).next();
						localObject4 = (Map) localLinkedHashMap.get(((BreedProps) localObject3).getCategoryProperty().getPropertyTypeID());
						if (localObject4 == null) {
							localObject4 = (Map) localLinkedHashMap.get(localLong);
						}
						Object localObject5 = (List) ((Map) localObject4).get(((BreedProps) localObject3).getCategoryProperty().getPropertyId());
						if (localObject5 == null) {
							localObject5 = new ArrayList();
							((Map) localObject4).put(((BreedProps) localObject3).getCategoryProperty().getPropertyId(), localObject5);
						}
						((List) localObject5).add(localObject3);
					}
				}
				localObject2 = new LinkedHashMap();
				Object localObject3 = localLinkedHashMap.keySet().iterator();
				while (((Iterator) localObject3).hasNext()) {
					localObject4 = (Long) ((Iterator) localObject3).next();
					if (((Map) localLinkedHashMap.get(localObject4)).size() > 0) {
						((Map) localObject2).put(localObject4, localLinkedHashMap.get(localObject4));
					}
				}
				this.request.setAttribute("ptnameMap", localHashMap1);
				this.request.setAttribute("propertyMap", localObject2);
				this.request.setAttribute("categoryPropertyMap", localHashMap2);
			}
		}
		return "success";
	}

	public String getNotUseStock() {
		this.logger.debug("获取当前用户没有使用的仓单信息");
		String str1 = this.request.getParameter("firmId");
		String str2 = " and primary.ownerFirm='" + str1
				+ "'and primary.breed.belongModule like '%23%' and primary.breed.status=1 and primary.stockStatus=1 and 0=(select count(c.operationId) from primary.operations c)";
		PageRequest localPageRequest1 = new PageRequest(str2);
		Page localPage = null;
		try {
			localPage = getService().getPage(localPageRequest1, new Stock());
			if ((localPage.getResult() != null) && (localPage.getResult().size() > 0)) {
				Iterator localIterator = localPage.getResult().iterator();
				while (localIterator.hasNext()) {
					StandardModel localStandardModel = (StandardModel) localIterator.next();
					Stock localStock = (Stock) localStandardModel;
					PageRequest localPageRequest2 = new PageRequest(" and primary.categoryId=" + localStock.getBreed().getCategory().getCategoryId()
							+ " and primary.belongModule like '%23%' and primary.status=1");
					getService().getPage(localPageRequest2, new Category());
				}
			}
		} catch (Exception localException) {
			addReturnValue(-1, -10001L, new Object[] { "未使用仓单信息获取" });
			this.logger.error(Tools.getExceptionTrace(localException));
		}
		this.request.setAttribute("pageInfo", localPage);
		return "success";
	}

	public String getStockJson() {
		this.logger.debug("通过仓单编号获取仓单信息，并封装成json对象");
		String str = this.request.getParameter("stockID");
		if ((str != null) && (str.trim().length() > 0)) {
			this.jsonReturn = new JSONArray();
			Stock localStock = new Stock();
			localStock.setStockId(Long.valueOf(Tools.strToLong(str)));
			localStock = (Stock) getService().get(localStock);
			HashMap localHashMap1 = new HashMap();
			localHashMap1.put("tradeMode", localStock.getBreed().getTradeMode());
			localHashMap1.put("breedID", "" + localStock.getBreed().getBreedId());
			localHashMap1.put("breedName", localStock.getBreed().getBreedName());
			localHashMap1.put("categoryID", "" + localStock.getBreed().getCategory().getCategoryId());
			localHashMap1.put("warehouseID", localStock.getWarehouseId());
			localHashMap1.put("unit", localStock.getUnit());
			localHashMap1.put("quantity", localStock.getQuantity());
			ArrayList localArrayList = new ArrayList();
			QueryConditions localQueryConditions = new QueryConditions();
			localQueryConditions.addCondition("status", "=", Integer.valueOf(0));
			PageRequest localPageRequest = new PageRequest(1, 100, localQueryConditions, " order by sortNo ");
			Page localPage = getService().getPage(localPageRequest, new PropertyType());
			Object localObject2;
			if ((localPage != null) && (localPage.getResult() != null)) {
				for (int i = 0; i < localPage.getResult().size(); i++) {
					PropertyType localObject1 = (PropertyType) localPage.getResult().get(i);
					localObject2 = new HashMap();
					((Map) localObject2).put("name", ((PropertyType) localObject1).getName());
					((Map) localObject2).put("propertyTypeID", ((PropertyType) localObject1).getPropertyTypeID());
					((Map) localObject2).put("property", new JSONArray());
					localArrayList.add(localObject2);
				}
			}
			HashMap localHashMap2 = new HashMap();
			localHashMap2.put("name", "其它属性");
			localHashMap2.put("propertyTypeID", Integer.valueOf(-1));
			localHashMap2.put("property", new JSONArray());
			Object localObject1 = localStock.getGoodsProperties().iterator();
			JSONArray localJSONArray;
			while (((Iterator) localObject1).hasNext()) {
				localObject2 = (StockGoodsProperty) ((Iterator) localObject1).next();
				localJSONArray = null;
				HashMap localHashMap3 = new HashMap();
				localHashMap3.put("key", ((StockGoodsProperty) localObject2).getPropertyName());
				localHashMap3.put("value", ((StockGoodsProperty) localObject2).getPropertyValue());
				localHashMap3.put("tpid", "" + ((StockGoodsProperty) localObject2).getPropertyTypeID());
				for (int k = 0; k < localArrayList.size(); k++) {
					if (((StockGoodsProperty) localObject2).getPropertyTypeID().equals(((Map) localArrayList.get(k)).get("propertyTypeID"))) {
						localJSONArray = (JSONArray) ((Map) localArrayList.get(k)).get("property");
					}
				}
				if (localJSONArray == null) {
					localJSONArray = (JSONArray) localHashMap2.get("property");
				}
				localJSONArray.add(localHashMap3);
			}
			localObject1 = new ArrayList();
			for (int j = 0; j < localArrayList.size(); j++) {
				localJSONArray = (JSONArray) ((Map) localArrayList.get(j)).get("property");
				if (localJSONArray.size() > 0) {
					((List) localObject1).add(localArrayList.get(j));
				}
			}
			if (((JSONArray) localHashMap2.get("property")).size() > 0) {
				((List) localObject1).add(localHashMap2);
			}
			localHashMap1.put("property", localObject1);
			this.jsonReturn.add(localHashMap1);
		}
		this.logger.debug("---------------[" + this.jsonReturn.toString());
		return "success";
	}

	public String showImages() throws IOException {
		this.logger.debug("enter showImages");
		HttpServletResponse localHttpServletResponse = ServletActionContext.getResponse();
		ServletOutputStream localServletOutputStream = null;
		byte[] arrayOfByte = null;
		OrderPic localOrderPic = new OrderPic();
		localOrderPic.setId(Long.valueOf(Tools.strToLong(this.request.getParameter("id"), -1000L)));
		localOrderPic = (OrderPic) getService().get(localOrderPic);
		if (localOrderPic == null) {
			OrderPicHis localOrderPicHis = new OrderPicHis();
			localOrderPicHis.setId(Long.valueOf(Tools.strToLong(this.request.getParameter("id"), -1000L)));
			localOrderPicHis = (OrderPicHis) getService().get(localOrderPicHis);
			arrayOfByte = localOrderPicHis.getPicture();
		} else {
			arrayOfByte = localOrderPic.getPicture();
		}
		try {
			localHttpServletResponse.setContentType("text/html");
			localServletOutputStream = localHttpServletResponse.getOutputStream();
			localServletOutputStream.write(arrayOfByte);
			localServletOutputStream.flush();
			localServletOutputStream.close();
			localServletOutputStream = null;
		} catch (Exception localException) {
			localException.printStackTrace();
		} finally {
			if (localServletOutputStream != null) {
				localServletOutputStream.close();
				localServletOutputStream = null;
			}
		}
		return null;
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
