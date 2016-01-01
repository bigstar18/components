package gnnt.MEBS.espot.front.action.trade;

import java.math.BigDecimal;
import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
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
import gnnt.MEBS.common.front.statictools.ActionUtil;
import gnnt.MEBS.common.front.statictools.ApplicationContextInit;
import gnnt.MEBS.common.front.statictools.Arith;
import gnnt.MEBS.common.front.statictools.Tools;
import gnnt.MEBS.espot.core.kernel.IFundsProcess;
import gnnt.MEBS.espot.core.kernel.IKernelService;
import gnnt.MEBS.espot.core.kernel.IReserveProcess;
import gnnt.MEBS.espot.core.kernel.ITradeProcess;
import gnnt.MEBS.espot.core.kernel.IWareHouseStockProcess;
import gnnt.MEBS.espot.core.vo.ResultVO;
import gnnt.MEBS.espot.front.common.XTradeFrontGlobal;
import gnnt.MEBS.espot.front.model.commodity.Category;
import gnnt.MEBS.espot.front.model.commodity.Property;
import gnnt.MEBS.espot.front.model.commodity.PropertyType;
import gnnt.MEBS.espot.front.model.trade.BreachApply;
import gnnt.MEBS.espot.front.model.trade.GoodsMoneyApply;
import gnnt.MEBS.espot.front.model.trade.GoodsProperty;
import gnnt.MEBS.espot.front.model.trade.GoodsPropertyBase;
import gnnt.MEBS.espot.front.model.trade.GoodsPropertyHis;
import gnnt.MEBS.espot.front.model.trade.Holding;
import gnnt.MEBS.espot.front.model.trade.NoOffset;
import gnnt.MEBS.espot.front.model.trade.OffSetApply;
import gnnt.MEBS.espot.front.model.trade.Order;
import gnnt.MEBS.espot.front.model.trade.OrderHis;
import gnnt.MEBS.espot.front.model.trade.Reserve;
import gnnt.MEBS.espot.front.model.trade.SystemProps;
import gnnt.MEBS.espot.front.model.trade.Trade;
import gnnt.MEBS.espot.front.model.trade.TradeBase;
import gnnt.MEBS.espot.front.model.trade.TradeGoodsProperty;
import gnnt.MEBS.espot.front.model.trade.TradeHis;
import gnnt.MEBS.espot.front.model.trade.TradeProcessLog;
import gnnt.MEBS.espot.front.model.trade.TradeProcessLogHis;
import gnnt.MEBS.espot.front.model.warehousestock.Stock;
import gnnt.MEBS.espot.front.model.warehousestock.WareHouseGoodsProperty;

@Controller("tradeProcessAction")
@Scope("request")
public class TradeProcessAction extends StandardAction {
	private static final long serialVersionUID = -6161679036316448106L;
	private static final int SCALE = 2;
	@Autowired
	@Qualifier("tradeProcessService")
	private ITradeProcess tradeProcessService;
	@Autowired
	@Qualifier("reserveProcessService")
	private IReserveProcess reserveProcessService;
	@Autowired
	@Qualifier("wareHouseStockService")
	private IWareHouseStockProcess wareHouseStockService;
	@Autowired
	@Qualifier("processService")
	private IFundsProcess processService;
	@Autowired
	@Qualifier("kernelService")
	private IKernelService kernelService;
	@Resource(name = "deliveryType")
	Map<String, String> deliveryType;
	@Resource(name = "tradeStatus")
	Map<String, String> tradeStatus;
	@Resource(name = "breachStatus")
	Map<String, String> breachStatus;
	@Resource(name = "offSetStatus")
	Map<String, String> offSetStatus;
	@Resource(name = "endTradeApplyStatus")
	Map<Integer, String> endTradeApplyStatus;

	public IWareHouseStockProcess getWareHouseStockService() {
		return this.wareHouseStockService;
	}

	public IFundsProcess getProcessService() {
		return this.processService;
	}

	public Map<String, String> getDeliveryType() {
		return this.deliveryType;
	}

	public Map<String, String> getOffSetStatus() {
		return this.offSetStatus;
	}

	public Map<Integer, String> getEndTradeApplyStatus() {
		return this.endTradeApplyStatus;
	}

	public Map<String, String> getBreachStatus() {
		return this.breachStatus;
	}

	public IKernelService getKernelService() {
		return this.kernelService;
	}

	public Map<String, String> getTradeStatus() {
		return this.tradeStatus;
	}

	public IReserveProcess getReserveProcessService() {
		return this.reserveProcessService;
	}

	public ITradeProcess getTradeProcessService() {
		return this.tradeProcessService;
	}

	public String tradeList() {
		this.logger.debug("查询合同信息列表");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		String str1 = this.request.getParameter("isHistory");
		PageRequest localPageRequest = null;
		try {
			localPageRequest = ActionUtil.getPageRequest(this.request);
		} catch (Exception localException) {
			this.logger.error(Tools.getExceptionTrace(localException));
		}
		QueryConditions localQueryConditions = (QueryConditions) localPageRequest.getFilters();
		localQueryConditions.addCondition("tradeType", "=", Integer.valueOf(0));
		String str2 = this.request.getParameter("bsFlag");
		if ("B".equals(str2)) {
			localQueryConditions.addCondition(" ", " ", "bfirmID='" + localUser.getBelongtoFirm().getFirmID() + "'");
		} else if ("S".equals(str2)) {
			localQueryConditions.addCondition(" ", " ", "sfirmID='" + localUser.getBelongtoFirm().getFirmID() + "'");
		} else {
			localQueryConditions.addCondition(" ", " ",
					" (bfirmID='" + localUser.getBelongtoFirm().getFirmID() + "' or sfirmID='" + localUser.getBelongtoFirm().getFirmID() + "')");
		}
		Object localObject1 = null;
		if ((null != str1) && (str1.equals("H"))) {
			localObject1 = new TradeHis();
		} else {
			localObject1 = new Trade();
		}
		Page localPage = getService().getPage(localPageRequest, (StandardModel) localObject1);
		this.request.setAttribute("isHistory", str1);
		if (((str1 == null) || (!str1.equals("H"))) && (localPage.getResult() != null) && (localPage.getResult().size() > 0)) {
			this.logger.debug("查询出合同条数为：" + localPage.getResult().size());
			Iterator localObject2 = localPage.getResult().iterator();
			while (((Iterator) localObject2).hasNext()) {
				StandardModel localStandardModel = (StandardModel) ((Iterator) localObject2).next();
				Trade localTrade = (Trade) localStandardModel;
				this.logger.debug("判断合同[" + localTrade.getTradeNo() + "]按钮权限");
				Map localMap = getTradeButtonMap(localTrade);
				localTrade.setButtonMap(localMap);
			}
		}
		Object localObject2 = new SystemProps();
		((SystemProps) localObject2).setPropsKey("PayTimes");
		localObject2 = (SystemProps) getService().get((StandardModel) localObject2);
		this.request.setAttribute("PayTimes", Integer.valueOf(Tools.strToInt(((SystemProps) localObject2).getRunTimeValue())));
		this.request.setAttribute("bsFlag", str2);
		this.request.setAttribute("pageInfo", localPage);
		this.request.setAttribute("oldParams", ActionUtil.getParametersStartingWith(this.request, "gnnt_"));
		return "success";
	}

	public String tradeDetails() {
		this.logger.debug("查询合同明细信息");
		String str1 = this.request.getParameter("backUrl");
		String str2 = this.request.getParameter("isHistory");
		this.logger.debug("==========backUrl:" + str1 + "isHistory==" + str2);
		this.request.setAttribute("backUrl", str1);
		this.logger.debug(str1);
		this.logger.debug(this.request.getRequestURI());
		this.logger.debug(this.request.getRequestURL());
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		Object localObject1 = null;
		int i = (null != str2) && (str2.equals("H")) ? 1 : 0;
		if (i != 0) {
			localObject1 = new TradeHis();
			((TradeBase) localObject1).setTradeNo((Long) this.entity.fetchPKey().getValue());
			localObject1 = (TradeBase) getService().get((StandardModel) localObject1);
		} else {
			localObject1 = isMyTrade(this.entity, localUser);
			((Trade) localObject1).setButtonMap(getTradeButtonMap((Trade) localObject1));
		}
		if (localObject1 == null) {
			addReturnValue(-1, 2310600L);
		} else {
			this.request.setAttribute("tradePreTime",
					Tools.dateAddSeconds(((TradeBase) localObject1).getTime(), ((TradeBase) localObject1).getTradePreTime()));
			this.request.setAttribute("isHistory", str2);
			this.entity = ((StandardModel) localObject1);
			PageRequest localPageRequest = new PageRequest(
					" and primary.trade.tradeNo=" + ((TradeBase) localObject1).getTradeNo() + " order by logId");
			localPageRequest.setPageSize(1000);
			Page localPage = null;
			if (i != 0) {
				localPage = getService().getPage(localPageRequest, new TradeProcessLogHis());
			} else {
				localPage = getService().getPage(localPageRequest, new TradeProcessLog());
			}
			MFirm localMFirm1 = new MFirm();
			localMFirm1.setFirmID(((TradeBase) localObject1).getBfirmID());
			localMFirm1 = (MFirm) getService().get(localMFirm1);
			MFirm localMFirm2 = new MFirm();
			localMFirm2.setFirmID(((TradeBase) localObject1).getSfirmID());
			localMFirm2 = (MFirm) getService().get(localMFirm2);
			this.request.setAttribute("bfirm", localMFirm1);
			this.request.setAttribute("sfirm", localMFirm2);
			this.request.setAttribute("pageInfo", localPage);
			SystemProps localSystemProps = new SystemProps();
			localSystemProps.setPropsKey("PayTimes");
			localSystemProps = (SystemProps) getService().get(localSystemProps);
			this.request.setAttribute("PayTimes", Integer.valueOf(Tools.strToInt(localSystemProps.getRunTimeValue())));
			LinkedHashSet localLinkedHashSet = new LinkedHashSet();
			Order localOrder = new Order();
			localOrder.setOrderID(((TradeBase) localObject1).getOrderID());
			localOrder = (Order) super.getService().get(localOrder);
			Object localObject2;
			Object localObject3;
			Object localObject4;
			if (localOrder != null) {
				localObject2 = localOrder.getContainGoodsProperty();
				localObject3 = ((Set) localObject2).iterator();
				while (((Iterator) localObject3).hasNext()) {
					localObject4 = (GoodsProperty) ((Iterator) localObject3).next();
					localLinkedHashSet.add(localObject4);
				}
				this.request.setAttribute("goodsPropertys", localObject2);
			} else {
				localObject2 = new OrderHis();
				((OrderHis) localObject2).setOrderID(((TradeBase) localObject1).getOrderID());
				localObject2 = (OrderHis) super.getService().get((StandardModel) localObject2);
				localObject3 = ((OrderHis) localObject2).getContainGoodsProperty();
				localObject4 = ((Set) localObject3).iterator();
				while (((Iterator) localObject4).hasNext()) {
					GoodsPropertyHis localGoodsPropertyHis = (GoodsPropertyHis) ((Iterator) localObject4).next();
					localLinkedHashSet.add(localGoodsPropertyHis);
				}
				this.request.setAttribute("goodsPropertys", localObject3);
			}
			putResourcePropertys(localLinkedHashSet);
		}
		return "success";
	}

	public String forwardPaymentReserve() throws Exception {
		this.logger.debug("------转入保证金 功能跳转----forwardPaymentReserve---");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		Trade localTrade = isMyTrade(this.entity, localUser);
		if (localTrade == null) {
			addReturnValue(-1, 2310600L);
		} else {
			boolean bool = appendMagin(localTrade, localUser);
			if (bool) {
				BigDecimal localBigDecimal = getRealGoods();
				Reserve localReserve = getReserveByTrade(localTrade, localUser, true);
				this.request.setAttribute("reserve", localReserve);
				this.request.setAttribute("realFunds", localBigDecimal);
			} else {
				addReturnValue(-1, 2310652L);
			}
		}
		return "success";
	}

	public String paymentReserve() throws Exception {
		this.logger.debug("------转入保证金操作 ----paymentReserve---");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		Trade localTrade = isMyTrade(this.entity, localUser);
		if (localTrade == null) {
			addReturnValue(-1, 2310600L);
			writeOperateLog(2309, "为合同转入保证金", 0, ApplicationContextInit.getErrorInfo("2310600"));
		} else {
			boolean bool = appendMagin(localTrade, localUser);
			if (bool) {
				String str = this.request.getParameter("reserveId");
				BigDecimal localBigDecimal = getRealGoods();
				if ((str != null) && (!"".equals(str)) && (localTrade.getTradeNo() != null)) {
					Reserve localReserve = new Reserve();
					localReserve.setReserveID(Long.valueOf(Tools.strToLong(str)));
					localReserve = (Reserve) getService().get(localReserve);
					if (localBigDecimal.doubleValue() >= localReserve.getPayableReserve().doubleValue()) {
						ResultVO localResultVO = this.processService.paymentReserve(localUser.getBelongtoFirm().getFirmID(),
								localTrade.getTradeNo().longValue(), localReserve.getPayableReserve().doubleValue());
						if (localResultVO.getResult() < 0L) {
							addReturnValue(-1, 2300002L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
							writeOperateLog(2309, "订单号为：" + str + "的订单转入保证金", 0, localResultVO.getErrorInfo().replace("\n", ""));
						} else if (localResultVO.getResult() == 0L) {
							addReturnValue(-1, 2300003L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
							writeOperateLog(2309, "订单号为：" + str + "的订单转入保证金", 0, localResultVO.getErrorInfo().replace("\n", ""));
						} else {
							addReturnValue(1, 2310611L);
							writeOperateLog(2309, "订单号为：" + str + "的订单转入保证金", 1, null);
						}
					} else {
						addReturnValue(-1, 2310651L);
						writeOperateLog(2309, "订单号为：" + str + "的订单转入保证金", 0, ApplicationContextInit.getErrorInfo("2310602"));
					}
				}
			} else {
				addReturnValue(-1, 2310652L);
				writeOperateLog(2309, "合同号为：" + localTrade.getTradeNo() + "的合同操作", 0, ApplicationContextInit.getErrorInfo("2310601"));
			}
		}
		return "success";
	}

	public String forwardTransferGoods() throws Exception {
		this.logger.debug("------转入仓单跳转 ----forwardTransferGoods---");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		this.request.setAttribute("oldParams", ActionUtil.getParametersStartingWith(this.request, "gnnt_"));
		MFirm localMFirm = localUser.getBelongtoFirm();
		Trade localTrade = isMyTrade(this.entity, localUser);
		if (localTrade == null) {
			addReturnValue(-1, 2310600L);
			this.request.setAttribute("allMax", Integer.valueOf(0));
			this.request.setAttribute("allMin", Integer.valueOf(0));
			this.request.setAttribute("quantity", Integer.valueOf(0));
			this.request.setAttribute("min", Integer.valueOf(0));
			this.request.setAttribute("max", Integer.valueOf(0));
		} else {
			this.entity = localTrade;
			boolean bool = appendWarehouse(localTrade, localUser);
			if (bool) {
				Long localLong = localTrade.getBelongtoBreed().getBreedID();
				PageRequest localPageRequest = ActionUtil.getPageRequest(this.request);
				QueryConditions localQueryConditions = (QueryConditions) localPageRequest.getFilters();
				localQueryConditions.addCondition("primary.belongtoFirm.firmID", "=", localUser.getBelongtoFirm().getFirmID());
				localQueryConditions.addCondition("primary.status", "=", Integer.valueOf(1));
				if (("1".equals(localTrade.getDeliveryType())) && (localTrade.getWarehouseID() != null)) {
					localQueryConditions.addCondition("primary.warehouseID", "=", localTrade.getWarehouseID());
				}
				localQueryConditions.addCondition("primary.belongtoBreed.breedID", "=", localLong);
				localQueryConditions.addCondition(" ", " ", "0=(select count(c.operationID) from primary.containOperation as c)");
				Page localPage = getService().getPage(localPageRequest, new Stock());
				List localList1 = localPage.getResult();
				Double localDouble = Double.valueOf(0.0D);
				String str1 = "select t.* from M_CATEGORY t,M_BREED tt where tt.breedid='" + localLong
						+ "' and t.categoryid = tt.categoryid and t.isOffSet='Y'";
				this.logger.debug("sql_offset==========" + str1);
				List localList2 = getService().getDao().queryBySql(str1, new Category());
				if ((localList2 != null) && (localList2.size() > 0) && (localList2.get(0) != null)) {
					localDouble = ((Category) localList2.get(0)).getOffsetRate();
				}
				double d1 = localTrade.getQuantity().doubleValue();
				double d2 = Arith.format(Arith.mul(d1, localDouble.doubleValue()), 2);
				double d3 = Arith.add(d1, d2);
				double d4 = Arith.sub(d1, d2);
				this.request.setAttribute("allMax", Double.valueOf(Arith.format(d3, 2)));
				this.request.setAttribute("allMin", Double.valueOf(Arith.format(d4, 2)));
				if ((localList1 == null) || (localList1.size() < 1)) {
					this.request.setAttribute("quantity", Integer.valueOf(0));
					this.request.setAttribute("min", Integer.valueOf(0));
					this.request.setAttribute("max", Integer.valueOf(0));
					return "success";
				}
				ArrayList localArrayList1 = new ArrayList();
				if (localTrade.getStatus().intValue() == 3) {
					String localObject1 = "select * from E_Holding where TradeNo='" + localTrade.getTradeNo() + "' and FirmID='"
							+ localMFirm.getFirmID() + "'";
					List localObject2 = super.getService().getListBySql((String) localObject1, new Holding());
					if (((List) localObject2).size() == 1) {
						Holding localObject3 = (Holding) ((List) localObject2).get(0);
						d3 = Arith.sub(d3, ((Holding) localObject3).getPayGoodsMoney().doubleValue());
						d4 = Arith.sub(d4, ((Holding) localObject3).getPayGoodsMoney().doubleValue());
						d1 = Arith.sub(d1, ((Holding) localObject3).getPayGoodsMoney().doubleValue());
					}
				} else if (localTrade.getStatus().intValue() == 0) {
					String localObject1 = "select * from E_Reserve where TradeNo='" + localTrade.getTradeNo() + "' and FirmID='"
							+ localMFirm.getFirmID() + "'";
					List localObject2 = super.getService().getListBySql((String) localObject1, new Reserve());
					if (((List) localObject2).size() == 1) {
						Reserve localObject3 = (Reserve) ((List) localObject2).get(0);
						d3 = Arith.sub(d3, ((Reserve) localObject3).getGoodsQuantity().doubleValue());
						d4 = Arith.sub(d4, ((Reserve) localObject3).getGoodsQuantity().doubleValue());
						d1 = Arith.sub(d1, ((Reserve) localObject3).getGoodsQuantity().doubleValue());
					}
				}
				Object localObject1 = localTrade.getTradeGoodsPropertys();
				Object localObject2 = new HashMap();
				Object localObject3 = ((Set) localObject1).iterator();
				while (((Iterator) localObject3).hasNext()) {
					TradeGoodsProperty localObject4 = (TradeGoodsProperty) ((Iterator) localObject3).next();
					((Map) localObject2).put(((TradeGoodsProperty) localObject4).getPropertyName(),
							Tools.delNull(((TradeGoodsProperty) localObject4).getPropertyValue()));
				}
				localObject3 = "select * from M_Property p where p.categoryid = (select b.categoryid from M_breed b where b.breedid = (select t.breedid from E_Trade t where t.tradeno='"
						+ localTrade.getTradeNo() + "'))";
				this.logger.debug("===sql: " + (String) localObject3);
				Object localObject4 = getService().getListBySql((String) localObject3, new Property());
				ArrayList localArrayList2 = new ArrayList();
				HashMap localHashMap1 = new HashMap();
				Iterator localIterator1 = ((List) localObject4).iterator();
				StandardModel localStandardModel;
				Object localObject5;
				while (localIterator1.hasNext()) {
					localStandardModel = (StandardModel) localIterator1.next();
					localObject5 = (Property) localStandardModel;
					if ((((Property) localObject5).getStockCheck() != null) && ("Y".equals(((Property) localObject5).getStockCheck().toString()))) {
						localHashMap1.put(((Property) localObject5).getPropertyName(), "Y");
						localArrayList2.add(((Property) localObject5).getPropertyName());
					} else if ((((Property) localObject5).getStockCheck() != null)
							&& ("M".equals(((Property) localObject5).getStockCheck().toString()))) {
						localHashMap1.put(((Property) localObject5).getPropertyName(), "M");
						localArrayList2.add(((Property) localObject5).getPropertyName());
					}
				}
				this.logger.debug("========  offset:  " + localDouble);
				localIterator1 = localList1.iterator();
				while (localIterator1.hasNext()) {
					localStandardModel = (StandardModel) localIterator1.next();
					localObject5 = (Stock) localStandardModel;
					if (((Stock) localObject5).getQuantity().doubleValue() <= Arith.format(d3, 2)) {
						Set localSet = ((Stock) localObject5).getContainProperty();
						HashMap localHashMap2 = new HashMap();
						Iterator localIterator2 = localSet.iterator();
						while (localIterator2.hasNext()) {
							WareHouseGoodsProperty localObject6 = (WareHouseGoodsProperty) localIterator2.next();
							localHashMap2.put(((WareHouseGoodsProperty) localObject6).getPropertyName(),
									Tools.delNull(((WareHouseGoodsProperty) localObject6).getPropertyValue()));
						}
						int i = 1;
						Object localObject6 = localArrayList2.iterator();
						while (((Iterator) localObject6).hasNext()) {
							String str2 = (String) ((Iterator) localObject6).next();
							if (((localHashMap2.get(str2) == null)
									&& (((Map) localObject2)
											.get(str2) != null))
									|| ((localHashMap2.get(str2) != null) && (((Map) localObject2).get(str2) == null))
									|| ((localHashMap2.get(str2) != null) && (((Map) localObject2).get(str2) != null)
											&& ((("Y".equals(localHashMap1.get(str2)))
													&& (!((String) localHashMap2.get(str2)).equals(((Map) localObject2).get(str2))))
													|| (("M".equals(localHashMap1.get(str2)))
															&& (!("|" + (String) ((Map) localObject2).get(str2) + "|")
																	.contains("|" + (String) localHashMap2.get(str2) + "|")))))) {
								i = 0;
							}
						}
						if (i != 0) {
							localArrayList1.add(localObject5);
						}
					}
				}
				this.request.setAttribute("quantity", Double.valueOf(d1));
				this.request.setAttribute("min", Double.valueOf(Arith.format(d4, 2)));
				this.request.setAttribute("max", Double.valueOf(Arith.format(d3, 2)));
				this.request.setAttribute("result", localArrayList1);
			} else {
				addReturnValue(-1, 2310653L);
				this.request.setAttribute("allMax", Integer.valueOf(0));
				this.request.setAttribute("allMin", Integer.valueOf(0));
				this.request.setAttribute("quantity", Integer.valueOf(0));
				this.request.setAttribute("min", Integer.valueOf(0));
				this.request.setAttribute("max", Integer.valueOf(0));
			}
		}
		this.logger.debug("==============   oldparamater");
		return "success";
	}

	public String transferGoods() {
		this.logger.debug("------转入仓单操作 ----transferGoods---");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		Trade localTrade = isMyTrade(this.entity, localUser);
		if (localTrade == null) {
			addReturnValue(-1, 2310600L);
			writeOperateLog(2309, "为合同转入仓单", 0, ApplicationContextInit.getErrorInfo("2310600"));
		} else {
			String[] arrayOfString = this.request.getParameterValues("cks");
			String str = this.request.getParameter("isLast");
			this.logger.debug("============================= isLast:" + str);
			boolean bool = appendWarehouse(localTrade, localUser);
			if (bool) {
				ResultVO localResultVO = new ResultVO();
				localResultVO.setResult(1L);
				Object localObject;
				if (localTrade.getStatus().intValue() == 0) {
					localObject = getReserveByTrade(localTrade, localUser, true);
					localResultVO = this.wareHouseStockService.transferGoodsForReserve(((Reserve) localObject).getReserveID().longValue(),
							arrayOfString, Boolean.valueOf(str).booleanValue());
				} else if (localTrade.getStatus().intValue() == 3) {
					localObject = getHoldingByTrade(localTrade, localUser, true);
					localResultVO = this.wareHouseStockService.transferGoodsForTrade(((Holding) localObject).getHoldingID().longValue(),
							arrayOfString, Boolean.valueOf(str).booleanValue());
				}
				if (localResultVO.getResult() < 0L) {
					addReturnValue(-1, 2300002L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "合同" + localTrade.getTradeNo() + "转入仓单", 0, localResultVO.getErrorInfo().replace("\n", ""));
				} else if (localResultVO.getResult() == 0L) {
					addReturnValue(-1, 2300003L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "合同" + localTrade.getTradeNo() + "转入仓单", 0, localResultVO.getErrorInfo().replace("\n", ""));
				} else {
					addReturnValue(1, 2310612L);
					writeOperateLog(2309, "合同" + localTrade.getTradeNo() + "转入仓单", 1, null);
				}
			} else {
				addReturnValue(-1, 2310653L);
				writeOperateLog(2309, "合同号为：" + localTrade.getTradeNo() + "的合同操作", 0, ApplicationContextInit.getErrorInfo("-6005"));
			}
		}
		return "success";
	}

	public String withdrawTrade() throws Exception {
		this.logger.debug("------关闭交易操作  ----withdrawTrade---");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		Trade localTrade = isMyTrade(this.entity, localUser);
		if (localTrade == null) {
			addReturnValue(-1, 2310600L);
			writeOperateLog(2309, "关闭交易", 0, ApplicationContextInit.getErrorInfo("2310600"));
		} else {
			boolean bool = closeTrade(localTrade, localUser);
			if (bool) {
				ResultVO localResultVO = new ResultVO();
				Object localObject;
				if (localTrade.getStatus().intValue() == 0) {
					localObject = getReserveByTrade(localTrade, localUser, true);
					localResultVO = this.reserveProcessService.withdrawReserve(((Reserve) localObject).getReserveID().longValue(),
							localUser.getBelongtoFirm().getFirmID());
				} else if (localTrade.getStatus().intValue() == 3) {
					localObject = getHoldingByTrade(localTrade, localUser, true);
					localResultVO = this.tradeProcessService.withdrawTrade(((Holding) localObject).getHoldingID().longValue(),
							localUser.getBelongtoFirm().getFirmID());
				}
				if (localResultVO.getResult() < 0L) {
					addReturnValue(-1, 2300002L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "合同" + localTrade.getTradeNo() + "关闭交易", 0, localResultVO.getErrorInfo().replace("\n", ""));
				} else if (localResultVO.getResult() == 0L) {
					addReturnValue(-1, 2300003L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "合同" + localTrade.getTradeNo() + "关闭交易", 0, localResultVO.getErrorInfo().replace("\n", ""));
				} else {
					addReturnValue(1, 2310613L);
					writeOperateLog(2309, "合同" + localTrade.getTradeNo() + "关闭交易", 1, null);
				}
			} else {
				addReturnValue(-1, 2310654L);
				writeOperateLog(2309, "合同号为：" + localTrade.getTradeNo() + "的合同操作", 0, ApplicationContextInit.getErrorInfo("-6006"));
			}
		}
		return "success";
	}

	public String forwardPaymentGoodsMoney() throws Exception {
		this.logger.debug("---转入货款跳转---------forwardPaymentGoodsMoney---------");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		Trade localTrade = isMyTrade(this.entity, localUser);
		if (localTrade == null) {
			addReturnValue(-1, 2310600L);
		} else {
			boolean bool = appendGoods(localTrade, localUser);
			if (bool) {
				double d1 = Arith.format(Arith.mul(localTrade.getQuantity().doubleValue(), localTrade.getPrice().doubleValue()), 2);
				this.entity = localTrade;
				Set localSet = localTrade.getContainHolding();
				Iterator localIterator = localSet.iterator();
				while (localIterator.hasNext()) {
					Holding localHolding = (Holding) localIterator.next();
					if (localHolding.getFirmID().equals(localUser.getBelongtoFirm().getFirmID())) {
						this.request.setAttribute("PayMargin", localHolding.getPayMargin());
					}
				}
				double d2 = localTrade.getBuyTradeFee().doubleValue();
				double d3 = localTrade.getBuyDeliveryFee().doubleValue();
				BigDecimal localBigDecimal = getRealGoods();
				this.request.setAttribute("tradeFeeMoney", Double.valueOf(d2));
				this.request.setAttribute("deliveryFeeMoney", Double.valueOf(d3));
				this.request.setAttribute("realFunds", localBigDecimal);
				this.request.setAttribute("goods", Double.valueOf(d1));
				this.request.setAttribute("deliveryDay", localTrade.getDeliveryDay());
			} else {
				addReturnValue(-1, 2310655L);
			}
		}
		return "success";
	}

	public String paymentGoodsMoney() {
		this.logger.debug("---转入货款操作---------paymentGoodsMoney---------");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		Trade localTrade = isMyTrade(this.entity, localUser);
		if (localTrade == null) {
			addReturnValue(-1, 2310600L);
			writeOperateLog(2309, "为合同转入货款", 0, ApplicationContextInit.getErrorInfo("2310600"));
		} else {
			boolean bool = appendGoods(localTrade, localUser);
			if (bool) {
				Holding localHolding = getHoldingByTrade(localTrade, localUser, true);
				ResultVO localResultVO = this.processService.paymentGoodsMoney(localHolding.getHoldingID().longValue());
				if (localResultVO.getResult() < 0L) {
					addReturnValue(-1, 2300002L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "合同" + localTrade.getTradeNo() + "转入货款", 0, localResultVO.getErrorInfo().replace("\n", ""));
				} else if (localResultVO.getResult() == 0L) {
					addReturnValue(-1, 2300003L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "合同" + localTrade.getTradeNo() + "转入货款", 0, localResultVO.getErrorInfo().replace("\n", ""));
				} else {
					addReturnValue(1, 2310614L);
					writeOperateLog(2309, "合同" + localTrade.getTradeNo() + "转入货款", 1, null);
				}
			} else {
				addReturnValue(-1, 2310655L);
				writeOperateLog(2309, "合同号为：" + localTrade.getTradeNo() + "的合同操作", 0, ApplicationContextInit.getErrorInfo("-6007"));
			}
		}
		return "success";
	}

	public String forwardPerformAskOffset() {
		this.logger.debug("-----申请溢短货款跳转----------forwardPerformAskOffset-----");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		Trade localTrade = isMyTrade(this.entity, localUser);
		if (localTrade == null) {
			addReturnValue(-1, 2310600L);
		} else {
			boolean bool = offSetApply(localTrade, localUser);
			if (bool) {
				this.entity = localTrade;
				Holding localHolding = null;
				if (localTrade.getBfirmID().equals(localUser.getBelongtoFirm().getFirmID())) {
					localHolding = getHoldingByTrade(localTrade, localUser, true);
				} else {
					localHolding = getHoldingByTrade(localTrade, localUser, false);
				}
				if (localHolding != null) {
					double d1 = Arith.format(localTrade.getPrice().doubleValue() * localTrade.getQuantity().doubleValue()
							* localTrade.getBelongtoBreed().getBelongtoCategory().getOffsetRate().doubleValue(), 2);
					double d2 = Arith.format(localHolding.getPayGoodsMoney().doubleValue() - localHolding.getPayoff().doubleValue()
							- localHolding.getTransferMoney().doubleValue(), 2);
					if (!localTrade.getBfirmID().equals(localUser.getBelongtoFirm().getFirmID())) {
						this.request.setAttribute("offSetMax", Double.valueOf(d1));
					} else if (Arith.sub(d1, d2) >= 0.0D) {
						this.request.setAttribute("offSetMax", Double.valueOf(d2));
					} else {
						this.request.setAttribute("offSetMax", Double.valueOf(d1));
					}
				}
			} else {
				addReturnValue(-1, 2310656L);
			}
		}
		return "success";
	}

	public String performAskOffset() {
		this.logger.debug("----溢短货款申请操作-----------performAskOffset-----------");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		Trade localTrade = isMyTrade(this.entity, localUser);
		if (localTrade == null) {
			addReturnValue(-1, 2310600L);
			writeOperateLog(2309, "溢短货款申请", 0, ApplicationContextInit.getErrorInfo("2310600"));
		} else {
			boolean bool = offSetApply(localTrade, localUser);
			if (bool) {
				String str = this.request.getParameter("money");
				Holding localHolding = getHoldingByTrade(localTrade, localUser, true);
				ResultVO localResultVO = this.tradeProcessService.performAskOffset(localHolding.getHoldingID().longValue(), Double.parseDouble(str));
				if (localResultVO.getResult() < 0L) {
					addReturnValue(-1, 2300002L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "合同" + localTrade.getTradeNo() + "溢短货款申请", 0, localResultVO.getErrorInfo().replace("\n", ""));
				} else if (localResultVO.getResult() == 0L) {
					addReturnValue(-1, 2300003L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "合同" + localTrade.getTradeNo() + "溢短货款申请", 0, localResultVO.getErrorInfo().replace("\n", ""));
				} else {
					addReturnValue(1, 2310615L);
					writeOperateLog(2309, "合同" + localTrade.getTradeNo() + "溢短货款申请", 1, null);
				}
			} else {
				addReturnValue(-1, 2310656L);
				writeOperateLog(2309, "合同号为：" + localTrade.getTradeNo() + "的合同操作", 0, ApplicationContextInit.getErrorInfo("-6008"));
			}
		}
		return "success";
	}

	public String performWithdrawOffset() {
		this.logger.debug("----撤销溢短货款操作--performWithdrawOffset---");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		Trade localTrade = isMyTrade(this.entity, localUser);
		if (localTrade == null) {
			addReturnValue(-1, 2310600L);
			writeOperateLog(2309, "撤销溢短货款", 0, ApplicationContextInit.getErrorInfo("2310600"));
		} else {
			boolean bool = revocationOffSetApply(localTrade, localUser);
			if (bool) {
				Holding localHolding = getHoldingByTrade(localTrade, localUser, true);
				ResultVO localResultVO = this.tradeProcessService.performWithdrawOffset(localHolding.getHoldingID().longValue());
				if (localResultVO.getResult() < 0L) {
					addReturnValue(-1, 2300002L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "合同" + localTrade.getTradeNo() + "撤销溢短货款", 0, localResultVO.getErrorInfo().replace("\n", ""));
				} else if (localResultVO.getResult() == 0L) {
					addReturnValue(-1, 2300003L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "合同" + localTrade.getTradeNo() + "撤销溢短货款", 0, localResultVO.getErrorInfo().replace("\n", ""));
				} else {
					addReturnValue(1, 2310616L);
					writeOperateLog(2309, "合同" + localTrade.getTradeNo() + "撤销溢短货款", 1, null);
				}
			} else {
				addReturnValue(-1, 2310657L);
				writeOperateLog(2309, "合同号为：" + localTrade.getTradeNo() + "的合同操作", 0, ApplicationContextInit.getErrorInfo("-6008"));
			}
		}
		return "success";
	}

	public String forwardPerformDisposeOffset() {
		this.logger.debug("-----处理溢短货款跳转---------forwardPerformDisposeOffset---------");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		Trade localTrade = isMyTrade(this.entity, localUser);
		if (localTrade == null) {
			addReturnValue(-1, 2310600L);
		} else {
			boolean bool = disposeOffSetApply(localTrade, localUser);
			if (bool) {
				Holding localHolding = getHoldingByTrade(localTrade, localUser, false);
				OffSetApply localOffSetApply = new OffSetApply();
				localOffSetApply.setOffSetId(localHolding.getOffsetID());
				localOffSetApply = (OffSetApply) getService().get(localOffSetApply);
				this.entity = localTrade;
				this.request.setAttribute("offSet", localOffSetApply);
			} else {
				addReturnValue(-1, 2310658L);
			}
		}
		return "success";
	}

	public String performDisposeOffset() {
		this.logger.debug("-----处理溢短货款操作---------performDisposeOffset---------");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		Trade localTrade = isMyTrade(this.entity, localUser);
		if (localTrade == null) {
			addReturnValue(-1, 2310600L);
			writeOperateLog(2309, "处理溢短货款", 0, ApplicationContextInit.getErrorInfo("2310600"));
		} else {
			boolean bool = disposeOffSetApply(localTrade, localUser);
			if (bool) {
				Holding localHolding = getHoldingByTrade(localTrade, localUser, true);
				ResultVO localResultVO = this.tradeProcessService.performDisposeOffset(localHolding.getHoldingID().longValue());
				if (localResultVO.getResult() < 0L) {
					addReturnValue(-1, 2300002L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "合同" + localTrade.getTradeNo() + "处理溢短货款", 0, localResultVO.getErrorInfo().replace("\n", ""));
				} else if (localResultVO.getResult() == 0L) {
					addReturnValue(-1, 2300003L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "合同" + localTrade.getTradeNo() + "处理溢短货款", 0, localResultVO.getErrorInfo().replace("\n", ""));
				} else {
					addReturnValue(1, 2310617L);
					writeOperateLog(2309, "合同" + localTrade.getTradeNo() + "处理溢短货款", 1, null);
				}
			} else {
				addReturnValue(-1, 2310658L);
				writeOperateLog(2309, "合同号为：" + localTrade.getTradeNo() + "的合同操作", 0, ApplicationContextInit.getErrorInfo("-6010"));
			}
		}
		return "success";
	}

	public String noOffSetApply() {
		this.logger.debug("----- 卖方确认无溢短货款申请 ----- noOffSetApply -----");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		Trade localTrade = isMyTrade(this.entity, localUser);
		if (localTrade == null) {
			addReturnValue(-1, 2310600L);
			writeOperateLog(2309, "卖方确认无溢短货款申请", 0, ApplicationContextInit.getErrorInfo("2310600"));
		} else {
			boolean bool = noOffSetApply(localTrade, localUser);
			if (bool) {
				Holding localHolding = getHoldingByTrade(localTrade, localUser, true);
				ResultVO localResultVO = this.tradeProcessService.performWithoutOffset(localHolding.getHoldingID().longValue());
				if (localResultVO.getResult() < 0L) {
					addReturnValue(-1, 2300002L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "合同" + localTrade + "卖方确认无溢短货款申请", 0, localResultVO.getErrorInfo().replace("\n", ""));
				} else if (localResultVO.getResult() == 0L) {
					addReturnValue(-1, 2300003L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "合同" + localTrade.getTradeNo() + "卖方确认无溢短货款申请", 0, localResultVO.getErrorInfo().replace("\n", ""));
				} else {
					addReturnValue(1, 2310618L);
					writeOperateLog(2309, "合同" + localTrade.getTradeNo() + "卖方确认无溢短货款申请", 1, null);
				}
			} else {
				addReturnValue(-1, 2310659L);
				writeOperateLog(2309, "合同号为：" + localTrade.getTradeNo() + "的合同操作", 0, ApplicationContextInit.getErrorInfo("-6010"));
			}
		}
		return "success";
	}

	public String forwardPaymentMoneyToSell() throws Exception {
		this.logger.debug("-----支付首款跳转---------forwardPaymentMoneyToSell---------");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		Trade localTrade = isMyTrade(this.entity, localUser);
		double d1 = 0.0D;
		double d2 = 0.0D;
		if (localTrade == null) {
			addReturnValue(-1, 2310600L);
		} else {
			boolean bool = payFirstGoods(localTrade, localUser);
			if (bool) {
				PageRequest localPageRequest = new PageRequest(
						" and primary.belongtoTrade.tradeNo=" + localTrade.getTradeNo() + " and primary.bsFlag='B'");
				Page localPage = getService().getPage(localPageRequest, new Holding());
				Holding localHolding = new Holding();
				if ((localPage.getResult() != null) && (localPage.getResult().size() > 0)) {
					localHolding = (Holding) localPage.getResult().get(0);
				}
				d1 = Arith.format(localHolding.getPayGoodsMoney().doubleValue() - localHolding.getTransferMoney().doubleValue(), 2);
				SystemProps localSystemProps = new SystemProps();
				localSystemProps.setPropsKey("FirstPaymentRate");
				localSystemProps = (SystemProps) getService().get(localSystemProps);
				d2 = Tools.strToDouble(localSystemProps.getRunTimeValue(), 0.0D);
			} else {
				addReturnValue(-1, 2310660L);
			}
		}
		this.request.setAttribute("payAllGoods", Double.valueOf(d1));
		this.request.setAttribute("payFirstGoods",
				Double.valueOf(Arith.format(Arith.mul(localTrade.getQuantity().doubleValue() * localTrade.getPrice().doubleValue(), d2), 2)));
		return "success";
	}

	public String paymentMoneyToSell() {
		this.logger.debug("-----支付首款操作---------paymentMoneyToSell---------");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		Trade localTrade = isMyTrade(this.entity, localUser);
		if (localTrade == null) {
			addReturnValue(-1, 2310600L);
			writeOperateLog(2309, "为合同支付首款", 0, ApplicationContextInit.getErrorInfo("2310600"));
		} else {
			boolean bool = payFirstGoods(localTrade, localUser);
			if (bool) {
				Holding localHolding = getHoldingByTrade(localTrade, localUser, true);
				SystemProps localSystemProps = new SystemProps();
				localSystemProps.setPropsKey("FirstPaymentRate");
				localSystemProps = (SystemProps) getService().get(localSystemProps);
				ResultVO localResultVO = this.processService.paymentFirstMoneyToSell(localHolding.getHoldingID().longValue(),
						Tools.strToDouble(localSystemProps.getRunTimeValue(), 0.0D));
				if (localResultVO.getResult() < 0L) {
					addReturnValue(-1, 2300002L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "合同" + localTrade.getTradeNo() + "支付首款", 0, localResultVO.getErrorInfo().replace("\n", ""));
				} else if (localResultVO.getResult() == 0L) {
					addReturnValue(-1, 2300003L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "合同" + localTrade.getTradeNo() + "支付首款", 0, localResultVO.getErrorInfo().replace("\n", ""));
				} else {
					addReturnValue(1, 2310619L);
					writeOperateLog(2309, "合同" + localTrade.getTradeNo() + "支付首款", 1, null);
				}
			} else {
				addReturnValue(-1, 2310660L);
				writeOperateLog(2309, "合同号为：" + localTrade.getTradeNo() + "的合同操作", 0, ApplicationContextInit.getErrorInfo("-6011"));
			}
		}
		return "success";
	}

	public String forwardSecondPaymentMoneyToSell() {
		this.logger.debug("-----支付二次货款跳转---------forwardSecondPaymentMoneyToSell---------");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		Trade localTrade = isMyTrade(this.entity, localUser);
		double d1 = 0.0D;
		double d2 = 0.0D;
		double d3 = 0.0D;
		double d4 = 0.0D;
		double d5 = 0.0D;
		if (localTrade == null) {
			addReturnValue(-1, 2310600L);
		} else {
			boolean bool = paySecondGoods(localTrade, localUser);
			if (bool) {
				PageRequest localPageRequest = new PageRequest(
						" and primary.belongtoTrade.tradeNo=" + localTrade.getTradeNo() + " and primary.bsFlag='B'");
				Page localPage = getService().getPage(localPageRequest, new Holding());
				Holding localHolding = new Holding();
				if ((localPage.getResult() != null) && (localPage.getResult().size() > 0)) {
					localHolding = (Holding) localPage.getResult().get(0);
				}
				d1 = Arith.format(localHolding.getPayGoodsMoney().doubleValue() - localHolding.getTransferMoney().doubleValue(), 2);
				OffSetApply localOffSetApply = new OffSetApply();
				localOffSetApply.setOffSetId(localHolding.getOffsetID());
				localOffSetApply = (OffSetApply) getService().get(localOffSetApply);
				SystemProps localSystemProps1 = new SystemProps();
				localSystemProps1.setPropsKey("SecondPaymentRate");
				localSystemProps1 = (SystemProps) getService().get(localSystemProps1);
				d2 = Tools.strToDouble(localSystemProps1.getRunTimeValue(), 0.0D);
				d4 = Arith.format(Arith.mul(localTrade.getPrice().doubleValue() * localTrade.getQuantity().doubleValue(), d2), 2);
				if (localOffSetApply != null) {
					if (localOffSetApply.getFirm().getFirmID().equals(localUser.getBelongtoFirm().getFirmID())) {
						double d6 = localOffSetApply.getOffSet().doubleValue();
						if (Arith.sub(d6, d4) >= 0.0D) {
							d5 = 0.0D;
							this.request.setAttribute("pay", "Y");
						} else {
							d5 = Arith.sub(d4, d6);
							this.request.setAttribute("pay", "N");
						}
					} else {
						d5 = d4;
					}
				} else {
					d5 = d4;
				}
				SystemProps localSystemProps2 = new SystemProps();
				localSystemProps2.setPropsKey("FirstPaymentRate");
				localSystemProps2 = (SystemProps) getService().get(localSystemProps2);
				d3 = Tools.strToDouble(localSystemProps2.getRunTimeValue(), 0.0D);
			} else {
				addReturnValue(-1, 2310661L);
			}
		}
		this.request.setAttribute("payAllGoods", Double.valueOf(d1));
		this.request.setAttribute("payMoney", Double.valueOf(d5));
		this.request.setAttribute("paySecondMoney", Double.valueOf(d4));
		this.request.setAttribute("payFirstGoods",
				Double.valueOf(Arith.format(Arith.mul(localTrade.getPrice().doubleValue() * localTrade.getQuantity().doubleValue(), d3), 2)));
		return "success";
	}

	public String paySecondGoods() {
		this.logger.debug("----- 支付二次货款操作 ----- paySecondGoods -----");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		Trade localTrade = isMyTrade(this.entity, localUser);
		if (localTrade == null) {
			addReturnValue(-1, 2310600L);
			writeOperateLog(2309, "为合同支付二次货款", 0, ApplicationContextInit.getErrorInfo("2310600"));
		} else {
			boolean bool = paySecondGoods(localTrade, localUser);
			if (bool) {
				Holding localHolding = getHoldingByTrade(localTrade, localUser, true);
				SystemProps localSystemProps = new SystemProps();
				localSystemProps.setPropsKey("SecondPaymentRate");
				localSystemProps = (SystemProps) getService().get(localSystemProps);
				ResultVO localResultVO = this.processService.paymentSecondMoneyToSell(localHolding.getHoldingID().longValue(),
						Tools.strToDouble(localSystemProps.getRunTimeValue(), 0.0D));
				if (localResultVO.getResult() < 0L) {
					addReturnValue(-1, 2300002L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "合同" + localTrade.getTradeNo() + "支付二次货款", 0, localResultVO.getErrorInfo().replace("\n", ""));
				} else if (localResultVO.getResult() == 0L) {
					addReturnValue(-1, 2300003L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "合同" + localTrade.getTradeNo() + "支付二次货款", 0, localResultVO.getErrorInfo().replace("\n", ""));
				} else {
					addReturnValue(1, 2310620L);
					writeOperateLog(2309, "合同" + localTrade.getTradeNo() + "支付二次货款", 1, null);
				}
			} else {
				addReturnValue(-1, 2310661L);
				writeOperateLog(2309, "合同号为：" + localTrade.getTradeNo() + "的合同操作", 0, ApplicationContextInit.getErrorInfo("-6011"));
			}
		}
		return "success";
	}

	public String lastGoodsMoneyApply() {
		this.logger.debug("----- 追缴申请 ----- lastMoneyPage -----");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		Trade localTrade = isMyTrade(this.entity, localUser);
		if (localTrade == null) {
			addReturnValue(-1, 2310600L);
			writeOperateLog(2309, "为合同申请货款追缴", 0, ApplicationContextInit.getErrorInfo("2310600"));
		} else {
			boolean bool = lastGoodsMoneyApply(localTrade, localUser);
			if (bool) {
				ResultVO localResultVO = this.tradeProcessService.performAskGoodsMoney(localTrade.getTradeNo().longValue());
				if (localResultVO.getResult() < 0L) {
					addReturnValue(-1, 2300002L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "合同" + localTrade.getTradeNo() + "货款追缴申请", 0, localResultVO.getErrorInfo().replace("\n", ""));
				} else if (localResultVO.getResult() == 0L) {
					addReturnValue(-1, 2300003L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "合同" + localTrade.getTradeNo() + "货款追缴申请", 0, localResultVO.getErrorInfo().replace("\n", ""));
				} else {
					addReturnValue(1, 2310621L);
					writeOperateLog(2309, "合同" + localTrade.getTradeNo() + "货款追缴申请", 1, null);
				}
			} else {
				addReturnValue(-1, 2310662L);
				writeOperateLog(2309, "合同号为：" + localTrade.getTradeNo() + "的合同操作", 0, ApplicationContextInit.getErrorInfo("-6018"));
			}
		}
		return "success";
	}

	public String withdrawLastGoodsMoneyApply() {
		this.logger.debug("----- 撤销货款申请 ----- withdrawLastGoodsMoneyApply -----");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		Trade localTrade = isMyTrade(this.entity, localUser);
		if (localTrade == null) {
			addReturnValue(-1, 2310600L);
			writeOperateLog(2309, "为合同撤销货款追缴申请", 0, ApplicationContextInit.getErrorInfo("2310600"));
		} else {
			boolean bool = disposelastGoodsMoney(localTrade, localUser);
			if (bool) {
				ResultVO localResultVO = this.tradeProcessService.performWithdrawGoodsMoney(localTrade.getTradeNo().longValue(),
						localUser.getBelongtoFirm().getFirmID());
				if (localResultVO.getResult() < 0L) {
					addReturnValue(-1, 2300002L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "合同" + localTrade.getTradeNo() + "撤销货款追缴申请", 0, localResultVO.getErrorInfo().replace("\n", ""));
				} else if (localResultVO.getResult() == 0L) {
					addReturnValue(-1, 2300003L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "合同" + localTrade.getTradeNo() + "撤销货款追缴申请", 0, localResultVO.getErrorInfo().replace("\n", ""));
				} else {
					addReturnValue(1, 2310622L);
					writeOperateLog(2309, "合同" + localTrade.getTradeNo() + "撤销货款追缴申请", 1, null);
				}
			} else {
				addReturnValue(-1, 2310663L);
				writeOperateLog(2309, "合同号为：" + localTrade.getTradeNo() + "的合同操作", 0, ApplicationContextInit.getErrorInfo("-6019"));
			}
		}
		return "success";
	}

	public String forwardPaymentBalanceToSell() throws Exception {
		this.logger.debug("-----支付尾款跳转---------forwardPaymentBalanceToSell---------");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		Trade localTrade = isMyTrade(this.entity, localUser);
		double d1 = 0.0D;
		double d2 = 0.0D;
		if (localTrade == null) {
			addReturnValue(-1, 2310600L);
		} else {
			boolean bool = payLeastGoods(localTrade, localUser);
			if (bool) {
				PageRequest localPageRequest = new PageRequest(
						" and primary.belongtoTrade.tradeNo=" + localTrade.getTradeNo() + " and primary.bsFlag='B'");
				Page localPage = getService().getPage(localPageRequest, new Holding());
				Holding localHolding = new Holding();
				if ((localPage.getResult() != null) && (localPage.getResult().size() > 0)) {
					localHolding = (Holding) localPage.getResult().get(0);
				}
				d1 = Arith.format(localHolding.getPayGoodsMoney().doubleValue() - localHolding.getTransferMoney().doubleValue(), 2);
				d2 = localHolding.getPayGoodsMoney().doubleValue() - localHolding.getTransferMoney().doubleValue()
						- localHolding.getPayoff().doubleValue();
			} else {
				addReturnValue(-1, 2310670L);
			}
		}
		this.request.setAttribute("payAllGoods", Double.valueOf(d1));
		this.request.setAttribute("payLeastGoods", Double.valueOf(Arith.format(d2, 2)));
		return "success";
	}

	public String paymentBalanceToSell() {
		this.logger.debug("-----支付尾款操作---------paymentBalanceToSell---------");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		Trade localTrade = isMyTrade(this.entity, localUser);
		if (localTrade == null) {
			addReturnValue(-1, 2310600L);
			writeOperateLog(2309, "为合同支付尾款", 0, ApplicationContextInit.getErrorInfo("2310600"));
		} else {
			boolean bool = payLeastGoods(localTrade, localUser);
			if (bool) {
				Holding localHolding = getHoldingByTrade(localTrade, localUser, true);
				ResultVO localResultVO = this.processService.paymentBalanceToSell(localHolding.getHoldingID().longValue());
				if (localResultVO.getResult() < 0L) {
					addReturnValue(-1, 2300002L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "合同" + localTrade.getTradeNo() + "支付尾款", 0, localResultVO.getErrorInfo().replace("\n", ""));
				} else if (localResultVO.getResult() == 0L) {
					addReturnValue(-1, 2300003L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "合同" + localTrade.getTradeNo() + "支付尾款", 0, localResultVO.getErrorInfo().replace("\n", ""));
				} else {
					addReturnValue(1, 2310628L);
					writeOperateLog(2309, "合同" + localTrade.getTradeNo() + "支付尾款", 1, null);
				}
			} else {
				addReturnValue(-1, 2310670L);
				writeOperateLog(2309, "合同号为：" + localTrade.getTradeNo() + "的合同操作", 0, ApplicationContextInit.getErrorInfo("-6012"));
			}
		}
		return "success";
	}

	public String performBreachAsk() {
		this.logger.debug("--违约申请操作----------performBreachAsk----------");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		Trade localTrade = isMyTrade(this.entity, localUser);
		if (localTrade == null) {
			addReturnValue(-1, 2310600L);
			writeOperateLog(2309, "合同违约申请", 0, ApplicationContextInit.getErrorInfo("2310600"));
		} else {
			boolean bool = breachApply(localTrade, localUser);
			if (bool) {
				ResultVO localResultVO = new ResultVO();
				Object localObject;
				if (localTrade.getStatus().intValue() == 0) {
					localObject = getReserveByTrade(localTrade, localUser, true);
					localResultVO = this.reserveProcessService.performBreachAsk(((Reserve) localObject).getReserveID().longValue());
				} else if (localTrade.getStatus().intValue() == 3) {
					localObject = getHoldingByTrade(localTrade, localUser, true);
					localResultVO = this.tradeProcessService.performBreachAsk(((Holding) localObject).getHoldingID().longValue());
				}
				if (localResultVO.getResult() < 0L) {
					addReturnValue(-1, 2300002L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "合同" + localTrade.getTradeNo() + "申请违约", 0, localResultVO.getErrorInfo().replace("\n", ""));
				} else if (localResultVO.getResult() == 0L) {
					addReturnValue(-1, 2300003L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "合同" + localTrade.getTradeNo() + "申请违约", 0, localResultVO.getErrorInfo().replace("\n", ""));
				} else {
					addReturnValue(1, 2310401L);
					writeOperateLog(2309, "合同" + localTrade.getTradeNo() + "申请违约", 1, null);
				}
			} else {
				addReturnValue(-1, 2310671L);
				writeOperateLog(2309, "合同号为：" + localTrade.getTradeNo() + "的合同操作", 0, ApplicationContextInit.getErrorInfo("-6013"));
			}
		}
		return "success";
	}

	public String performWithdrawAsk() throws RemoteException {
		this.logger.debug("-- 撤销违约操作----------performWithdrawAsk----------");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		Trade localTrade = isMyTrade(this.entity, localUser);
		if (localTrade == null) {
			addReturnValue(-1, 2310600L);
			writeOperateLog(2309, "合同撤销违约", 0, ApplicationContextInit.getErrorInfo("2310600"));
		} else {
			boolean bool = revocationBreachApply(localTrade, localUser);
			if (bool) {
				Object localObject;
				ResultVO localResultVO;
				if (localTrade.getStatus().intValue() == 0) {
					localObject = getReserveByTrade(localTrade, localUser, true);
					localResultVO = this.reserveProcessService.performWithdrawAsk(((Reserve) localObject).getReserveID().longValue());
					if (localResultVO.getResult() < 0L) {
						addReturnValue(-1, 2300002L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
						writeOperateLog(2309, "合同" + localTrade.getTradeNo() + "撤销违约", 0, localResultVO.getErrorInfo().replace("\n", ""));
					} else if (localResultVO.getResult() == 0L) {
						addReturnValue(-1, 2300003L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
						writeOperateLog(2309, "合同" + localTrade.getTradeNo() + "撤销违约", 0, localResultVO.getErrorInfo().replace("\n", ""));
					} else {
						addReturnValue(1, 2310402L);
						writeOperateLog(2309, "合同" + localTrade.getTradeNo() + "撤销违约", 1, null);
					}
				} else if (localTrade.getStatus().intValue() == 3) {
					localObject = getHoldingByTrade(localTrade, localUser, true);
					localResultVO = this.tradeProcessService.performWithdrawAsk(((Holding) localObject).getHoldingID().longValue());
					if (localResultVO.getResult() < 0L) {
						addReturnValue(-1, 2300002L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
						writeOperateLog(2309, "合同" + localTrade.getTradeNo() + "撤销违约", 0, localResultVO.getErrorInfo().replace("\n", ""));
					} else if (localResultVO.getResult() == 0L) {
						addReturnValue(-1, 2300003L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
						writeOperateLog(2309, "合同" + localTrade.getTradeNo() + "撤销违约", 0, localResultVO.getErrorInfo().replace("\n", ""));
					} else {
						addReturnValue(1, 2310402L);
						writeOperateLog(2309, "合同" + localTrade.getTradeNo() + "撤销违约", 1, null);
					}
				}
			} else {
				addReturnValue(-1, 2310672L);
				writeOperateLog(2309, "合同号为：" + localTrade.getTradeNo() + "的合同操作", 0, ApplicationContextInit.getErrorInfo("-6014"));
			}
		}
		return "success";
	}

	public String forwardPerformBreach() {
		this.logger.debug("-- 处理违约跳转---------forwardPerformBreach----------");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		Trade localTrade = isMyTrade(this.entity, localUser);
		if (localTrade == null) {
			addReturnValue(-1, 2310600L);
		} else {
			Double localDouble = null;
			boolean bool = disposeBreachApply(localTrade, localUser);
			this.entity = localTrade;
			if (localTrade.getBfirmID().equals(localUser.getBelongtoFirm().getFirmID())) {
				if (localTrade.getStatus().intValue() == 0) {
					localDouble = localTrade.getTradeMargin_B();
				} else if (localTrade.getStatus().intValue() == 3) {
					localDouble = localTrade.getDeliveryMargin_B();
				}
			} else if (localTrade.getStatus().intValue() == 0) {
				localDouble = localTrade.getTradeMargin_S();
			} else if (localTrade.getStatus().intValue() == 3) {
				localDouble = localTrade.getDeliveryMargin_S();
			}
			BreachApply localBreachApply = getBreachApplyByTrade(localTrade, localUser, false);
			if (localBreachApply != null) {
				int i = Tools.strToInt(this.kernelService.getConfigInfo("BufferDate"), 1);
				Date localDate1 = localBreachApply.getApplyTime();
				long l = localDate1.getTime() + i * 60 * 60 * 1000;
				if ((localBreachApply.getDelayTime() != null) && (localBreachApply.getDelayTime().longValue() > 0L)) {
					l += localBreachApply.getDelayTime().longValue() * 1000L;
				}
				Date localDate2 = new Date(l);
				this.request.setAttribute("time", localDate2);
			}
			this.request.setAttribute("money", localDouble);
			if (!bool) {
				addReturnValue(-1, 2310673L);
			}
		}
		return "success";
	}

	public String performBreach() throws RemoteException {
		this.logger.debug("-- 处理违约操作----------performBreach----------");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		Trade localTrade = isMyTrade(this.entity, localUser);
		if (localTrade == null) {
			addReturnValue(-1, 2310600L);
		} else {
			boolean bool = disposeBreachApply(localTrade, localUser);
			if (bool) {
				if (localTrade.getStatus().intValue() == 0) {
					int i = 0;
					if (localTrade.getBfirmID().equals(localUser.getBelongtoFirm().getFirmID())) {
						i = 1;
					} else if (localTrade.getSfirmID().equals(localUser.getBelongtoFirm().getFirmID())) {
						i = 2;
					}
					ResultVO localResultVO2 = this.reserveProcessService.performReserveBreach(localTrade.getTradeNo().longValue(), i);
					if (localResultVO2.getResult() < 0L) {
						addReturnValue(-1, 2300002L, new Object[] { localResultVO2.getErrorInfo().replace("\n", "") });
						writeOperateLog(2309, "合同" + localTrade.getTradeNo() + "处理违约", 0, localResultVO2.getErrorInfo().replace("\n", ""));
					} else if (localResultVO2.getResult() == 0L) {
						addReturnValue(-1, 2300003L, new Object[] { localResultVO2.getErrorInfo().replace("\n", "") });
						writeOperateLog(2309, "合同" + localTrade.getTradeNo() + "处理违约", 0, localResultVO2.getErrorInfo().replace("\n", ""));
					} else {
						addReturnValue(1, 2310629L);
						writeOperateLog(2309, "合同" + localTrade.getTradeNo() + "处理违约", 1, null);
					}
				} else if (localTrade.getStatus().intValue() == 3) {
					ResultVO localResultVO1 = this.tradeProcessService.performTradeBreach(localTrade.getTradeNo().longValue(),
							localUser.getBelongtoFirm().getFirmID());
					if (localResultVO1.getResult() < 0L) {
						addReturnValue(-1, 2300002L, new Object[] { localResultVO1.getErrorInfo().replace("\n", "") });
						writeOperateLog(2309, "合同" + localTrade.getTradeNo() + "处理违约", 0, localResultVO1.getErrorInfo().replace("\n", ""));
					} else if (localResultVO1.getResult() == 0L) {
						addReturnValue(-1, 2300003L, new Object[] { localResultVO1.getErrorInfo().replace("\n", "") });
						writeOperateLog(2309, "合同" + localTrade.getTradeNo() + "处理违约", 0, localResultVO1.getErrorInfo().replace("\n", ""));
					} else {
						addReturnValue(1, 2310629L);
						writeOperateLog(2309, "合同" + localTrade.getTradeNo() + "处理违约", 1, null);
					}
				}
			} else {
				addReturnValue(-1, 2310673L);
				writeOperateLog(2309, "合同号为：" + localTrade.getTradeNo() + "的合同操作", 0, ApplicationContextInit.getErrorInfo("-6015"));
			}
		}
		return "success";
	}

	public String breachList() throws Exception {
		this.logger.debug("违约列表查询");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		PageRequest localPageRequest = null;
		Page localPage = getTradePage();
		String str = "";
		if ((localPage.getResult() != null) && (localPage.getResult().size() > 0)) {
			Iterator localObject1 = localPage.getResult().iterator();
			while (((Iterator) localObject1).hasNext()) {
				StandardModel localObject2 = (StandardModel) ((Iterator) localObject1).next();
				Trade localObject3 = (Trade) localObject2;
				str = str + ((Trade) localObject3).getTradeNo() + ",";
			}
		}
		localPageRequest = ActionUtil.getPageRequest(this.request);
		Object localObject1 = (QueryConditions) localPageRequest.getFilters();
		Object localObject2 = this.request.getParameter("breach");
		if (!"".equals(str)) {
			str = str.substring(0, str.length() - 1);
			((QueryConditions) localObject1).addCondition("primary.tradeNo", "in", "(" + str + ")");
			if ("S".equals(localObject2)) {
				((QueryConditions) localObject1).addCondition("primary.firm.firmID", "=", localUser.getBelongtoFirm().getFirmID());
			} else if ("R".equals(localObject2)) {
				((QueryConditions) localObject1).addCondition("primary.firm.firmID", "!=", localUser.getBelongtoFirm().getFirmID());
			}
		} else {
			((QueryConditions) localObject1).addCondition("primary.breachApplyId", "=", Long.valueOf(-1L));
		}
		Object localObject3 = getService().getPage(localPageRequest, new BreachApply());
		this.request.setAttribute("breach", localObject2);
		this.request.setAttribute("pageInfo", localObject3);
		this.request.setAttribute("oldParams", ActionUtil.getParametersStartingWith(this.request, "gnnt_"));
		return "success";
	}

	public String toBreachDelay() {
		String str1 = this.request.getParameter("tradeNO");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		String str2 = "select * from E_BreachApply b where b.tradeno='" + str1 + "' and b.firmid='" + localUser.getBelongtoFirm().getFirmID()
				+ "' and b.status='0'";
		List localList = super.getService().getListBySql(str2, new BreachApply());
		BreachApply localBreachApply;
		if (localList.size() > 0) {
			this.request.setAttribute("entity", localList.get(0));
			localBreachApply = (BreachApply) localList.get(0);
			int i = Tools.strToInt(this.kernelService.getConfigInfo("BufferDate"), 1);
			Date localDate1 = localBreachApply.getApplyTime();
			Date localDate2 = new Date(localDate1.getTime() + i * 60 * 60 * 1000);
			this.request.setAttribute("time", localDate2);
			String str3 = this.kernelService.getConfigInfo("BufferDate");
			this.request.setAttribute("bufferDate", str3);
		} else {
			localBreachApply = new BreachApply();
			this.request.setAttribute("entity", localBreachApply);
			addReturnValue(-1, 2310404L);
		}
		return "success";
	}

	public String breachDelay() {
		BreachApply localBreachApply1 = (BreachApply) this.entity;
		if (null == localBreachApply1.getBreachApplyId()) {
			addReturnValue(-1, 2310669L);
			return "success";
		}
		BreachApply localBreachApply2 = (BreachApply) getService().get(localBreachApply1.clone());
		if ((localBreachApply2.getTrade() == null)
				|| ((0 != localBreachApply2.getTrade().getStatus().intValue()) && (3 != localBreachApply2.getTrade().getStatus().intValue()))) {
			addReturnValue(-1, 2310404L);
			return "success";
		}
		localBreachApply1.setDelayTime(Long.valueOf(localBreachApply1.getDelayTime().longValue() * 60L * 60L));
		getService().update(localBreachApply1);
		String str = localBreachApply2.getTrade().getBfirmID().equals(localBreachApply2.getFirm().getFirmID())
				? localBreachApply2.getTrade().getSfirmID() : localBreachApply2.getTrade().getBfirmID();
		try {
			this.kernelService.sendMsgToTrader(str,
					"违约号：" + localBreachApply1.getBreachApplyId() + "的违约延期" + localBreachApply1.getDelayTime().longValue() / 3600L + "小时！");
			addReturnValue(1, 9910001L);
			writeOperateLog(2309,
					"违约号：" + localBreachApply1.getBreachApplyId() + "的违约延期" + localBreachApply1.getDelayTime().longValue() / 3600L + "小时", 1, null);
		} catch (Exception localException) {
			localException.printStackTrace();
		}
		return "success";
	}

	public String offSetList() throws Exception {
		this.logger.debug("溢短货款列表查询");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		PageRequest localPageRequest = null;
		String str1 = localUser.getBelongtoFirm().getFirmID();
		String str2 = "select t.*, t.rowid from E_TRADE t where t.bfirmid='" + str1 + "' or t.sfirmid='" + str1 + "'";
		String str3 = "";
		List localList = super.getService().getListBySql(str2, new Trade());
		if ((localList != null) && (localList.size() > 0)) {
			Iterator localObject1 = localList.iterator();
			while (((Iterator) localObject1).hasNext()) {
				StandardModel localObject2 = (StandardModel) ((Iterator) localObject1).next();
				Trade localObject3 = (Trade) localObject2;
				this.logger.debug(((Trade) localObject3).getTradeNo());
				str3 = str3 + ((Trade) localObject3).getTradeNo() + ",";
			}
		}
		localPageRequest = ActionUtil.getPageRequest(this.request);
		Object localObject1 = (QueryConditions) localPageRequest.getFilters();
		Object localObject2 = this.request.getParameter("loss");
		if (!"".equals(str3)) {
			str3 = str3.substring(0, str3.length() - 1);
			((QueryConditions) localObject1).addCondition("primary.tradeNo", "in", "(" + str3 + ")");
			if ("S".equals(localObject2)) {
				((QueryConditions) localObject1).addCondition("primary.firm.firmID", "=", localUser.getBelongtoFirm().getFirmID());
			} else if ("R".equals(localObject2)) {
				((QueryConditions) localObject1).addCondition("primary.firm.firmID", "!=", localUser.getBelongtoFirm().getFirmID());
			}
		} else {
			((QueryConditions) localObject1).addCondition("primary.offSetId", "=", Long.valueOf(-1L));
		}
		Object localObject3 = getService().getPage(localPageRequest, new OffSetApply());
		this.request.setAttribute("loss", localObject2);
		this.request.setAttribute("pageInfo", localObject3);
		this.request.setAttribute("oldParams", ActionUtil.getParametersStartingWith(this.request, "gnnt_"));
		return "success";
	}

	public Page<StandardModel> getTradePage() {
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		PageRequest localPageRequest = new PageRequest(" and (primary.bfirmID='" + localUser.getBelongtoFirm().getFirmID() + "' or primary.sfirmID='"
				+ localUser.getBelongtoFirm().getFirmID() + "')");
		localPageRequest.setPageSize(100000000);
		Page localPage = getService().getPage(localPageRequest, new Trade());
		return localPage;
	}

	public Trade isMyTrade(StandardModel paramStandardModel, User paramUser) {
		if (paramStandardModel.fetchPKey().getValue() == null) {
			return null;
		}
		Trade localTrade = (Trade) getService().get(paramStandardModel);
		if ((localTrade.getBfirmID().equals(paramUser.getBelongtoFirm().getFirmID()))
				|| (localTrade.getSfirmID().equals(paramUser.getBelongtoFirm().getFirmID()))) {
			return localTrade;
		}
		return null;
	}

	public boolean appendMagin(Trade paramTrade, User paramUser) {
		if (paramTrade.getStatus().intValue() == 0) {
			Reserve localReserve = getReserveByTrade(paramTrade, paramUser, true);
			return localReserve.getStatus().intValue() == 0;
		}
		return false;
	}

	public boolean appendWarehouse(Trade paramTrade, User paramUser) {
		if (!paramTrade.getSfirmID().equals(paramUser.getBelongtoFirm().getFirmID())) {
			return false;
		}
		Object localObject;
		if (paramTrade.getStatus().intValue() == 0) {
			localObject = getReserveByTrade(paramTrade, paramUser, true);
			return ((Reserve) localObject).getStatus().intValue() == 0;
		}
		if (paramTrade.getStatus().intValue() == 3) {
			localObject = getHoldingByTrade(paramTrade, paramUser, true);
			if (((Holding) localObject).getStatus().intValue() == 1) {
				if (paramTrade.getOrderID() != null) {
					Order localOrder = new Order();
					localOrder.setOrderID(paramTrade.getOrderID());
					localOrder = (Order) getService().get(localOrder);
					if (localOrder == null) {
						OrderHis localOrderHis = new OrderHis();
						localOrderHis.setOrderID(paramTrade.getOrderID());
						localOrderHis = (OrderHis) getService().get(localOrderHis);
						if (localOrderHis.getPledgeFlag().intValue() == 1) {
							return false;
						}
					} else if (localOrder.getPledgeFlag().intValue() == 1) {
						return false;
					}
				}
				return true;
			}
			return false;
		}
		return false;
	}

	public boolean closeTrade(Trade paramTrade, User paramUser) {
		Object localObject;
		if (paramTrade.getStatus().intValue() == 0) {
			localObject = getReserveByTrade(paramTrade, paramUser, true);
			return ((Reserve) localObject).getStatus().intValue() != 1;
		}
		if (paramTrade.getStatus().intValue() == 3) {
			localObject = getHoldingByTrade(paramTrade, paramUser, true);
			return ((Holding) localObject).getStatus().intValue() == 1;
		}
		return false;
	}

	public boolean appendGoods(Trade paramTrade, User paramUser) {
		if (!paramTrade.getBfirmID().equals(paramUser.getBelongtoFirm().getFirmID())) {
			return false;
		}
		if (paramTrade.getStatus().intValue() == 3) {
			Holding localHolding = getHoldingByTrade(paramTrade, paramUser, true);
			return localHolding.getStatus().intValue() == 1;
		}
		return false;
	}

	public boolean offSetApply(Trade paramTrade, User paramUser) {
		PageRequest localPageRequest1 = new PageRequest(
				" and primary.categoryID=" + paramTrade.getBelongtoBreed().getBelongtoCategory().getCategoryID());
		getService().getPage(localPageRequest1, new Category());
		if (paramTrade.getStatus().intValue() == 6) {
			if ("N".equalsIgnoreCase(paramTrade.getBelongtoBreed().getBelongtoCategory().getIsOffset())) {
				return false;
			}
			if (paramTrade.getSfirmID().equals(paramUser.getBelongtoFirm().getFirmID())) {
				PageRequest localPageRequest2 = new PageRequest(" and tradeNo=" + paramTrade.getTradeNo());
				Page localPage = getService().getPage(localPageRequest2, new NoOffset());
				if ((localPage != null) && (localPage.getResult() != null) && (localPage.getResult().size() > 0)) {
					return false;
				}
			}
			PageRequest localPageRequest2 = new PageRequest(" and primary.tradeNo= " + paramTrade.getTradeNo() + " and primary.status!=1");
			Page localPage = getService().getPage(localPageRequest2, new OffSetApply());
			return (localPage.getResult() == null) || (localPage.getResult().size() <= 0);
		}
		return false;
	}

	public boolean revocationOffSetApply(Trade paramTrade, User paramUser) {
		if ((paramTrade.getStatus().intValue() == 5) || (paramTrade.getStatus().intValue() == 6) || (paramTrade.getStatus().intValue() == 7)) {
			OffSetApply localOffSetApply = getOffSetApplyByTrade(paramTrade, paramUser, true);
			if (localOffSetApply == null) {
				return false;
			}
			return localOffSetApply.getStatus().intValue() == 0;
		}
		return false;
	}

	public boolean disposeOffSetApply(Trade paramTrade, User paramUser) {
		if (paramTrade.getStatus().intValue() == 6) {
			OffSetApply localOffSetApply = getOffSetApplyByTrade(paramTrade, paramUser, false);
			if (localOffSetApply == null) {
				return false;
			}
			return localOffSetApply.getStatus().intValue() == 0;
		}
		return false;
	}

	public boolean noOffSetApply(Trade paramTrade, User paramUser) {
		PageRequest localPageRequest = new PageRequest(
				" and primary.categoryID=" + paramTrade.getBelongtoBreed().getBelongtoCategory().getCategoryID());
		getService().getPage(localPageRequest, new Category());
		if (!paramTrade.getSfirmID().equals(paramUser.getBelongtoFirm().getFirmID())) {
			return false;
		}
		if (paramTrade.getStatus().intValue() != 6) {
			return false;
		}
		if ("N".equalsIgnoreCase(paramTrade.getBelongtoBreed().getBelongtoCategory().getIsOffset())) {
			return false;
		}
		Holding localHolding = getHoldingByTrade(paramTrade, paramUser, true);
		if (localHolding.getOffsetID().longValue() < 0L) {
			PageRequest localObject = new PageRequest(" and tradeNo=" + paramTrade.getTradeNo());
			Page localPage = getService().getPage((PageRequest) localObject, new NoOffset());
			return (localPage == null) || (localPage.getResult() == null) || (localPage.getResult().size() <= 0);
		}
		Object localObject = new OffSetApply();
		((OffSetApply) localObject).setOffSetId(localHolding.getOffsetID());
		localObject = (OffSetApply) getService().get((StandardModel) localObject);
		if (localObject != null) {
			if (((OffSetApply) localObject).getStatus().intValue() == 0) {
				return false;
			}
			return ((OffSetApply) localObject).getStatus().intValue() == 1;
		}
		return false;
	}

	public boolean payFirstGoods(Trade paramTrade, User paramUser) {
		if (!paramTrade.getBfirmID().equals(paramUser.getBelongtoFirm().getFirmID())) {
			return false;
		}
		return paramTrade.getStatus().intValue() == 5;
	}

	public boolean paySecondGoods(Trade paramTrade, User paramUser) {
		if (XTradeFrontGlobal.PAYTIMES == 2) {
			return false;
		}
		PageRequest localPageRequest = new PageRequest(
				" and primary.categoryID=" + paramTrade.getBelongtoBreed().getBelongtoCategory().getCategoryID());
		getService().getPage(localPageRequest, new Category());
		if (!paramTrade.getBfirmID().equals(paramUser.getBelongtoFirm().getFirmID())) {
			return false;
		}
		if (paramTrade.getStatus().intValue() != 6) {
			return false;
		}
		if ("N".equalsIgnoreCase(paramTrade.getBelongtoBreed().getBelongtoCategory().getIsOffset())) {
			return true;
		}
		Holding localHolding = getHoldingByTrade(paramTrade, paramUser, false);
		if (localHolding.getOffsetID().longValue() < 0L) {
			PageRequest localObject1 = new PageRequest(" and tradeNo=" + paramTrade.getTradeNo());
			Page localObject2 = getService().getPage((PageRequest) localObject1, new NoOffset());
			return (localObject2 == null) || ((((Page) localObject2).getResult() != null) && (((Page) localObject2).getResult().size() > 0));
		}
		Object localObject1 = new OffSetApply();
		((OffSetApply) localObject1).setOffSetId(localHolding.getOffsetID());
		localObject1 = (OffSetApply) getService().get((StandardModel) localObject1);
		if (localObject1 != null) {
			if (((OffSetApply) localObject1).getStatus().intValue() == 0) {
				return false;
			}
			if (((OffSetApply) localObject1).getStatus().intValue() == 1) {
				PageRequest localObject2 = new PageRequest(" and tradeNo=" + paramTrade.getTradeNo());
				Page localPage = getService().getPage((PageRequest) localObject2, new NoOffset());
				return (localPage == null) || ((localPage.getResult() != null) && (localPage.getResult().size() > 0));
			}
			return true;
		}
		Object localObject2 = new PageRequest(" and tradeNo=" + paramTrade.getTradeNo());
		Page localPage = getService().getPage((PageRequest) localObject2, new NoOffset());
		return (localPage == null) || ((localPage.getResult() != null) && (localPage.getResult().size() > 0));
	}

	public boolean payLeastGoods(Trade paramTrade, User paramUser) {
		if (!paramTrade.getBfirmID().equals(paramUser.getBelongtoFirm().getFirmID())) {
			return false;
		}
		if (XTradeFrontGlobal.PAYTIMES == 2) {
			PageRequest localPageRequest = new PageRequest(
					" and primary.categoryID=" + paramTrade.getBelongtoBreed().getBelongtoCategory().getCategoryID());
			getService().getPage(localPageRequest, new Category());
			if (!paramTrade.getBfirmID().equals(paramUser.getBelongtoFirm().getFirmID())) {
				return false;
			}
			if (paramTrade.getStatus().intValue() != 6) {
				return false;
			}
			if ("N".equalsIgnoreCase(paramTrade.getBelongtoBreed().getBelongtoCategory().getIsOffset())) {
				return true;
			}
			Holding localHolding = getHoldingByTrade(paramTrade, paramUser, false);
			if (localHolding.getOffsetID().longValue() < 0L) {
				PageRequest localObject1 = new PageRequest(" and tradeNo=" + paramTrade.getTradeNo());
				Page localObject2 = getService().getPage((PageRequest) localObject1, new NoOffset());
				return (localObject2 == null) || ((((Page) localObject2).getResult() != null) && (((Page) localObject2).getResult().size() > 0));
			}
			Object localObject1 = new OffSetApply();
			((OffSetApply) localObject1).setOffSetId(localHolding.getOffsetID());
			localObject1 = (OffSetApply) getService().get((StandardModel) localObject1);
			if (localObject1 != null) {
				if (((OffSetApply) localObject1).getStatus().intValue() == 0) {
					return false;
				}
				if (((OffSetApply) localObject1).getStatus().intValue() == 1) {
					PageRequest localObject2 = new PageRequest(" and tradeNo=" + paramTrade.getTradeNo());
					Page localPage = getService().getPage((PageRequest) localObject2, new NoOffset());
					return (localPage == null) || ((localPage.getResult() != null) && (localPage.getResult().size() > 0));
				}
				return true;
			}
			Object localObject2 = new PageRequest(" and tradeNo=" + paramTrade.getTradeNo());
			Page localPage = getService().getPage((PageRequest) localObject2, new NoOffset());
			return (localPage == null) || ((localPage.getResult() != null) && (localPage.getResult().size() > 0));
		}
		return paramTrade.getStatus().intValue() == 7;
	}

	public boolean lastGoodsMoneyApply(Trade paramTrade, User paramUser) {
		if (!paramTrade.getSfirmID().equals(paramUser.getBelongtoFirm().getFirmID())) {
			return false;
		}
		User localUser = new User();
		PageRequest localPageRequest1 = new PageRequest(" and primary.belongtoFirm.firmID='" + paramTrade.getBfirmID() + "'");
		Page localPage1 = getService().getPage(localPageRequest1, new User());
		if ((localPage1.getResult() != null) && (localPage1.getResult().size() > 0)) {
			localUser = (User) localPage1.getResult().get(0);
		}
		if (((XTradeFrontGlobal.PAYTIMES == 2) && (payLeastGoods(paramTrade, localUser)))
				|| ((XTradeFrontGlobal.PAYTIMES == 3) && (paramTrade.getStatus().intValue() == 7)) || (payFirstGoods(paramTrade, localUser))
				|| (paySecondGoods(paramTrade, localUser))) {
			QueryConditions localQueryConditions = new QueryConditions();
			localQueryConditions.addCondition("tradeNO", "=", paramTrade.getTradeNo());
			localQueryConditions.addCondition("status", "=", Integer.valueOf(0));
			PageRequest localPageRequest2 = new PageRequest(1, 5, localQueryConditions);
			Page localPage2 = getService().getPage(localPageRequest2, new GoodsMoneyApply());
			return (localPage2.getResult() == null) || (localPage2.getResult().size() <= 0);
		}
		return false;
	}

	public boolean disposelastGoodsMoney(Trade paramTrade, User paramUser) {
		if (!paramTrade.getSfirmID().equals(paramUser.getBelongtoFirm().getFirmID())) {
			return false;
		}
		User localUser = new User();
		PageRequest localPageRequest1 = new PageRequest(" and primary.belongtoFirm.firmID='" + paramTrade.getBfirmID() + "'");
		Page localPage1 = getService().getPage(localPageRequest1, new User());
		if ((localPage1.getResult() != null) && (localPage1.getResult().size() > 0)) {
			localUser = (User) localPage1.getResult().get(0);
		}
		if (((XTradeFrontGlobal.PAYTIMES == 2) && (paramTrade.getStatus().intValue() != 6)) || ((XTradeFrontGlobal.PAYTIMES == 3)
				&& (paramTrade.getStatus().intValue() != 7) && (!payFirstGoods(paramTrade, localUser)) && (!paySecondGoods(paramTrade, localUser)))) {
			return false;
		}
		QueryConditions localQueryConditions = new QueryConditions();
		localQueryConditions.addCondition("tradeNO", "=", paramTrade.getTradeNo());
		localQueryConditions.addCondition("status", "=", Integer.valueOf(0));
		PageRequest localPageRequest2 = new PageRequest(1, 5, localQueryConditions);
		Page localPage2 = getService().getPage(localPageRequest2, new GoodsMoneyApply());
		return (localPage2.getResult() != null) && (localPage2.getResult().size() > 0);
	}

	public boolean breachApply(Trade paramTrade, User paramUser) {
		if ((paramTrade.getStatus().intValue() != 0) && (paramTrade.getStatus().intValue() != 3)) {
			return false;
		}
		boolean bool = revocationBreachApply(paramTrade, paramUser);
		if (bool) {
			return false;
		}
		if (paramTrade.getStatus().intValue() == 0) {
			long l = getService().getSysDate().getTime() - paramTrade.getTime().getTime();
			if (l / 1000L <= paramTrade.getTradePreTime().intValue()) {
				return false;
			}
			Reserve localReserve1 = getReserveByTrade(paramTrade, paramUser, true);
			Reserve localReserve2 = getReserveByTrade(paramTrade, paramUser, false);
			return (localReserve1.getStatus().intValue() == 1) && (localReserve2.getStatus().intValue() == 0);
		}
		if (paramTrade.getStatus().intValue() == 3) {
			if (getService().getSysDate().getTime() <= paramTrade.getDeliveryDay().getTime()) {
				return false;
			}
			Holding localHolding1 = getHoldingByTrade(paramTrade, paramUser, true);
			Holding localHolding2 = getHoldingByTrade(paramTrade, paramUser, false);
			return (localHolding1.getStatus().intValue() == 2) && (localHolding2.getStatus().intValue() == 1);
		}
		return false;
	}

	public boolean revocationBreachApply(Trade paramTrade, User paramUser) {
		if ((paramTrade.getStatus().intValue() != 0) && (paramTrade.getStatus().intValue() != 3)) {
			return false;
		}
		BreachApply localBreachApply = getBreachApplyByTrade(paramTrade, paramUser, true);
		if (localBreachApply == null) {
			return false;
		}
		return localBreachApply.getStatus().intValue() == 0;
	}

	public boolean disposeBreachApply(Trade paramTrade, User paramUser) {
		if (paramTrade.getStatus().intValue() != 0) {
			return false;
		}
		BreachApply localBreachApply = getBreachApplyByTrade(paramTrade, paramUser, false);
		if (localBreachApply == null) {
			return false;
		}
		return localBreachApply.getStatus().intValue() == 0;
	}

	private Boolean tradeBreachDelay(Trade paramTrade, User paramUser) {
		if ((paramTrade.getStatus().intValue() != 3) && (paramTrade.getStatus().intValue() != 0)) {
			return Boolean.valueOf(false);
		}
		String str = "select * from E_BreachApply b where b.tradeno='" + paramTrade.getTradeNo() + "' and b.firmid='"
				+ paramUser.getBelongtoFirm().getFirmID() + "' and b.status='0'";
		List localList = getService().getListBySql(str);
		this.logger.debug("list.size()   " + localList.size() + ":::");
		if (localList.size() > 0) {
			return Boolean.valueOf(true);
		}
		return Boolean.valueOf(false);
	}

	public Map<String, Boolean> getTradeButtonMap(Trade paramTrade) {
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		HashMap localHashMap = new HashMap();
		localHashMap.put("appendMagin", Boolean.valueOf(appendMagin(paramTrade, localUser)));
		localHashMap.put("appendWarehouse", Boolean.valueOf(appendWarehouse(paramTrade, localUser)));
		localHashMap.put("closeTrade", Boolean.valueOf(closeTrade(paramTrade, localUser)));
		localHashMap.put("appendGoods", Boolean.valueOf(appendGoods(paramTrade, localUser)));
		localHashMap.put("offSetApply", Boolean.valueOf(offSetApply(paramTrade, localUser)));
		localHashMap.put("revocationOffSetApply", Boolean.valueOf(revocationOffSetApply(paramTrade, localUser)));
		localHashMap.put("disposeOffSetApply", Boolean.valueOf(disposeOffSetApply(paramTrade, localUser)));
		localHashMap.put("noOffSetApply", Boolean.valueOf(noOffSetApply(paramTrade, localUser)));
		localHashMap.put("payFirstGoods", Boolean.valueOf(payFirstGoods(paramTrade, localUser)));
		localHashMap.put("paySecondGoods", Boolean.valueOf(paySecondGoods(paramTrade, localUser)));
		localHashMap.put("payLeastGoods", Boolean.valueOf(payLeastGoods(paramTrade, localUser)));
		localHashMap.put("lastGoodsMoneyApply", Boolean.valueOf(lastGoodsMoneyApply(paramTrade, localUser)));
		localHashMap.put("disposelastGoodsMoney", Boolean.valueOf(disposelastGoodsMoney(paramTrade, localUser)));
		localHashMap.put("breachApply", Boolean.valueOf(breachApply(paramTrade, localUser)));
		localHashMap.put("revocationBreachApply", Boolean.valueOf(revocationBreachApply(paramTrade, localUser)));
		localHashMap.put("disposeBreachApply", Boolean.valueOf(disposeBreachApply(paramTrade, localUser)));
		localHashMap.put("breachDelay", tradeBreachDelay(paramTrade, localUser));
		this.logger.debug(localHashMap);
		return localHashMap;
	}

	public BigDecimal getRealGoods() throws Exception {
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		BigDecimal localBigDecimal = (BigDecimal) getService().executeProcedure("{?=call FN_F_GetRealFunds(?,?) }",
				new Object[] { localUser.getBelongtoFirm().getFirmID(), Integer.valueOf(0) });
		return localBigDecimal;
	}

	public Reserve getReserveByTrade(Trade paramTrade, User paramUser, boolean paramBoolean) {
		this.logger.debug("-----查看合同下的用户的订单----getReserveByTrade-------");
		Object localObject = new Reserve();
		Set localSet = paramTrade.getContainReserve();
		Iterator localIterator = localSet.iterator();
		while (localIterator.hasNext()) {
			Reserve localReserve = (Reserve) localIterator.next();
			if (paramBoolean) {
				if (localReserve.getFirmID().equals(paramUser.getBelongtoFirm().getFirmID())) {
					localObject = localReserve;
					break;
				}
			} else if (!localReserve.getFirmID().equals(paramUser.getBelongtoFirm().getFirmID())) {
				localObject = localReserve;
				break;
			}
		}
		return (Reserve) localObject;
	}

	public Holding getHoldingByTrade(Trade paramTrade, User paramUser, boolean paramBoolean) {
		this.logger.debug("-----查看合同下的用户的持仓----getHoldingByTrade-------");
		Object localObject = new Holding();
		Set localSet = paramTrade.getContainHolding();
		Iterator localIterator = localSet.iterator();
		while (localIterator.hasNext()) {
			Holding localHolding = (Holding) localIterator.next();
			if (paramBoolean) {
				if (localHolding.getFirmID().equals(paramUser.getBelongtoFirm().getFirmID())) {
					localObject = localHolding;
					break;
				}
			} else if (!localHolding.getFirmID().equals(paramUser.getBelongtoFirm().getFirmID())) {
				localObject = localHolding;
				break;
			}
		}
		return (Holding) localObject;
	}

	public OffSetApply getOffSetApplyByTrade(Trade paramTrade, User paramUser, boolean paramBoolean) {
		this.logger.debug("-----查看合同下的溢短货款信息----getOffSetApplyByTrade-------");
		OffSetApply localOffSetApply = new OffSetApply();
		Holding localHolding = getHoldingByTrade(paramTrade, paramUser, paramBoolean);
		if (localHolding.getOffsetID() == null) {
			return null;
		}
		localOffSetApply.setOffSetId(localHolding.getOffsetID());
		localOffSetApply = (OffSetApply) getService().get(localOffSetApply);
		if (localOffSetApply == null) {
			return null;
		}
		if (localOffSetApply.getFirm().getFirmID().equals(paramUser.getBelongtoFirm().getFirmID()) == paramBoolean) {
			return localOffSetApply;
		}
		return null;
	}

	public BreachApply getBreachApplyByTrade(Trade paramTrade, User paramUser, boolean paramBoolean) {
		this.logger.debug("-----查出合同下的违约信息----getBreachApplyByTrade-------");
		BreachApply localBreachApply = new BreachApply();
		Object localObject;
		if (paramTrade.getStatus().intValue() == 0) {
			localObject = getReserveByTrade(paramTrade, paramUser, paramBoolean);
			if ((((Reserve) localObject).getBreachApplyID() == null) || (((Reserve) localObject).getBreachApplyID().longValue() < 0L)) {
				return null;
			}
			localBreachApply.setBreachApplyId(((Reserve) localObject).getBreachApplyID());
			localBreachApply = (BreachApply) getService().get(localBreachApply);
			if (localBreachApply.getFirm().getFirmID().equals(paramUser.getBelongtoFirm().getFirmID()) == paramBoolean) {
				return localBreachApply;
			}
			return null;
		}
		if (paramTrade.getStatus().intValue() == 3) {
			localObject = getHoldingByTrade(paramTrade, paramUser, paramBoolean);
			if ((((Holding) localObject).getBreachApplyID() == null) || (((Holding) localObject).getBreachApplyID().longValue() < 0L)) {
				return null;
			}
			localBreachApply.setBreachApplyId(((Holding) localObject).getBreachApplyID());
			localBreachApply = (BreachApply) getService().get(localBreachApply);
			if (localBreachApply.getFirm().getFirmID().equals(paramUser.getBelongtoFirm().getFirmID()) == paramBoolean) {
				return localBreachApply;
			}
			return null;
		}
		return null;
	}

	public String endTradeApplyList() {
		this.logger.debug("查询终止合同申请列表");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		PageRequest localPageRequest = null;
		try {
			localPageRequest = ActionUtil.getPageRequest(this.request);
		} catch (Exception localException) {
			this.logger.error(Tools.getExceptionTrace(localException));
		}
		String str1 = this.request.getParameter("bsFlag");
		if ((str1 == null) || (str1.equals(""))) {
			str1 = "all";
		}
		String str2 = localUser.getBelongtoFirm().getFirmID();
		QueryConditions localQueryConditions = (QueryConditions) localPageRequest.getFilters();
		localQueryConditions.addCondition(" ", " ",
				"primary.tradeNo=primary.trade.tradeNo and (primary.trade.bfirmID='" + str2 + "' or primary.trade.sfirmID='" + str2 + "')");
		this.logger.debug("bsFlag===" + str1);
		Page localPage = getTradePage();
		String str3 = "";
		if ((localPage.getResult() != null) && (localPage.getResult().size() > 0)) {
			Iterator localObject = localPage.getResult().iterator();
			while (((Iterator) localObject).hasNext()) {
				StandardModel localStandardModel = (StandardModel) ((Iterator) localObject).next();
				Trade localTrade = (Trade) localStandardModel;
				str3 = str3 + localTrade.getTradeNo() + ",";
			}
		}
		if (!"".equals(str3)) {
			str3 = str3.substring(0, str3.length() - 1);
			localQueryConditions.addCondition("primary.trade.tradeNo", "in", "(" + str3 + ")");
		}
		if ("B".equals(str1)) {
			localQueryConditions.addCondition("primary.firm.firmID", "<>", str2);
		} else if ("S".equals(str1)) {
			localQueryConditions.addCondition("primary.firm.firmID", "=", str2);
		}
		Object localObject = getService().getPage(localPageRequest, this.entity);
		this.request.setAttribute("bsFlag", str1);
		this.request.setAttribute("pageInfo", localObject);
		this.request.setAttribute("oldParams", ActionUtil.getParametersStartingWith(this.request, "gnnt_"));
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
