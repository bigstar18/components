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
import gnnt.MEBS.espot.front.model.commodity.Category;
import gnnt.MEBS.espot.front.model.commodity.Property;
import gnnt.MEBS.espot.front.model.commodity.PropertyType;
import gnnt.MEBS.espot.front.model.trade.BreachApply;
import gnnt.MEBS.espot.front.model.trade.EndTradeApply;
import gnnt.MEBS.espot.front.model.trade.GoodsProperty;
import gnnt.MEBS.espot.front.model.trade.GoodsPropertyBase;
import gnnt.MEBS.espot.front.model.trade.GoodsPropertyHis;
import gnnt.MEBS.espot.front.model.trade.Holding;
import gnnt.MEBS.espot.front.model.trade.OffSetApply;
import gnnt.MEBS.espot.front.model.trade.Order;
import gnnt.MEBS.espot.front.model.trade.OrderHis;
import gnnt.MEBS.espot.front.model.trade.Reserve;
import gnnt.MEBS.espot.front.model.trade.Trade;
import gnnt.MEBS.espot.front.model.trade.TradeBase;
import gnnt.MEBS.espot.front.model.trade.TradeGoodsProperty;
import gnnt.MEBS.espot.front.model.trade.TradeHis;
import gnnt.MEBS.espot.front.model.trade.TradeProcessLog;
import gnnt.MEBS.espot.front.model.trade.TradeProcessLogHis;
import gnnt.MEBS.espot.front.model.warehousestock.Stock;
import gnnt.MEBS.espot.front.model.warehousestock.TradeStock;
import gnnt.MEBS.espot.front.model.warehousestock.WareHouseGoodsProperty;

@Controller("tradeAutonomyAction")
@Scope("request")
public class TradeAutonomyAction extends StandardAction {
	private static final long serialVersionUID = 5271117647909221308L;
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
	@Resource(name = "tradeAutoStatus")
	Map<String, String> tradeAutoStatus;
	@Resource(name = "breachStatus")
	Map<String, String> breachStatus;
	@Resource(name = "offSetStatus")
	Map<String, String> offSetStatus;

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

	public Map<String, String> getBreachStatus() {
		return this.breachStatus;
	}

	public IKernelService getKernelService() {
		return this.kernelService;
	}

	public Map<String, String> getTradeAutoStatus() {
		return this.tradeAutoStatus;
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
		localQueryConditions.addCondition("tradeType", "=", Integer.valueOf(1));
		String str2 = this.request.getParameter("bsFlag");
		if ("B".equals(str2)) {
			localQueryConditions.addCondition(" ", " ", "bfirmID='" + localUser.getBelongtoFirm().getFirmID() + "'");
		} else if ("S".equals(str2)) {
			localQueryConditions.addCondition(" ", " ", "sfirmID='" + localUser.getBelongtoFirm().getFirmID() + "'");
		} else {
			localQueryConditions.addCondition(" ", " ",
					" (bfirmID='" + localUser.getBelongtoFirm().getFirmID() + "' or sfirmID='" + localUser.getBelongtoFirm().getFirmID() + "')");
		}
		Object localObject = null;
		if ((null != str1) && (str1.equals("H"))) {
			localObject = new TradeHis();
		} else {
			localObject = new Trade();
		}
		Page localPage = getService().getPage(localPageRequest, (StandardModel) localObject);
		this.request.setAttribute("isHistory", str1);
		if (((str1 == null) || (!str1.equals("H"))) && (localPage.getResult() != null) && (localPage.getResult().size() > 0)) {
			this.logger.debug("查询出合同条数为：" + localPage.getResult().size());
			Iterator localIterator = localPage.getResult().iterator();
			while (localIterator.hasNext()) {
				StandardModel localStandardModel = (StandardModel) localIterator.next();
				Trade localTrade = (Trade) localStandardModel;
				this.logger.debug("判断合同[" + localTrade.getTradeNo() + "]按钮权限");
				Map localMap = getTradeButtonMap(localTrade);
				localTrade.setButtonMap(localMap);
			}
		}
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
		Object localObject2;
		Object localObject3;
		if (i != 0) {
			localObject1 = new TradeHis();
			((TradeBase) localObject1).setTradeNo((Long) this.entity.fetchPKey().getValue());
			localObject1 = (TradeBase) getService().get((StandardModel) localObject1);
		} else {
			localObject1 = isMyTrade(this.entity, localUser);
			((Trade) localObject1).setButtonMap(getTradeButtonMap((Trade) localObject1));
			localObject2 = getHoldingByTrade((Trade) localObject1, localUser, true);
			localObject3 = getHoldingByTrade((Trade) localObject1, localUser, false);
			if ((((Holding) localObject2).getHoldingID() != null) && (((Holding) localObject3).getHoldingID() != null)) {
				this.request.setAttribute("holding", localObject2);
				this.request.setAttribute("sellHolding", localObject3);
			}
		}
		if (localObject1 == null) {
			addReturnValue(-1, 2310600L);
		} else {
			this.request.setAttribute("tradePreTime",
					Tools.dateAddSeconds(((TradeBase) localObject1).getTime(), ((TradeBase) localObject1).getTradePreTime()));
			this.request.setAttribute("isHistory", str2);
			this.entity = ((StandardModel) localObject1);
			localObject2 = new PageRequest(" and primary.trade.tradeNo=" + ((TradeBase) localObject1).getTradeNo() + " order by processTime");
			((PageRequest) localObject2).setPageSize(1000);
			localObject3 = null;
			if (i != 0) {
				localObject3 = getService().getPage((PageRequest) localObject2, new TradeProcessLogHis());
			} else {
				localObject3 = getService().getPage((PageRequest) localObject2, new TradeProcessLog());
			}
			MFirm localMFirm1 = new MFirm();
			localMFirm1.setFirmID(((TradeBase) localObject1).getBfirmID());
			localMFirm1 = (MFirm) getService().get(localMFirm1);
			MFirm localMFirm2 = new MFirm();
			localMFirm2.setFirmID(((TradeBase) localObject1).getSfirmID());
			localMFirm2 = (MFirm) getService().get(localMFirm2);
			this.request.setAttribute("bfirm", localMFirm1);
			this.request.setAttribute("sfirm", localMFirm2);
			this.request.setAttribute("pageInfo", localObject3);
			LinkedHashSet localLinkedHashSet = new LinkedHashSet();
			Order localOrder = new Order();
			localOrder.setOrderID(((TradeBase) localObject1).getOrderID());
			localOrder = (Order) super.getService().get(localOrder);
			Object localObject4;
			Object localObject5;
			Object localObject6;
			if (localOrder != null) {
				localObject4 = localOrder.getContainGoodsProperty();
				localObject5 = ((Set) localObject4).iterator();
				while (((Iterator) localObject5).hasNext()) {
					localObject6 = (GoodsProperty) ((Iterator) localObject5).next();
					localLinkedHashSet.add(localObject6);
				}
				this.request.setAttribute("goodsPropertys", localObject4);
			} else {
				localObject4 = new OrderHis();
				((OrderHis) localObject4).setOrderID(((TradeBase) localObject1).getOrderID());
				localObject4 = (OrderHis) super.getService().get((StandardModel) localObject4);
				localObject5 = ((OrderHis) localObject4).getContainGoodsProperty();
				localObject6 = ((Set) localObject5).iterator();
				while (((Iterator) localObject6).hasNext()) {
					GoodsPropertyHis localGoodsPropertyHis = (GoodsPropertyHis) ((Iterator) localObject6).next();
					localLinkedHashSet.add(localGoodsPropertyHis);
				}
				this.request.setAttribute("goodsPropertys", localObject5);
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
			boolean bool = appendAutoMagin(localTrade, localUser);
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
		String str1 = "为合同%s转入保证金";
		this.logger.debug("------转入保证金操作 ----paymentReserve---");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		Trade localTrade = isMyTrade(this.entity, localUser);
		if (localTrade == null) {
			addReturnValue(-1, 2310600L);
			str1 = String.format(str1, new Object[] { "" });
			writeOperateLog(2309, str1, 0, ApplicationContextInit.getErrorInfo("2310600"));
		} else {
			str1 = String.format(str1, new Object[] { localTrade.getTradeNo() });
			boolean bool = appendAutoMagin(localTrade, localUser);
			if (bool) {
				String str2 = this.request.getParameter("reserveId");
				BigDecimal localBigDecimal = getRealGoods();
				if ((str2 != null) && (!"".equals(str2)) && (localTrade.getTradeNo() != null)) {
					Reserve localReserve = new Reserve();
					localReserve.setReserveID(Long.valueOf(Tools.strToLong(str2)));
					localReserve = (Reserve) getService().get(localReserve);
					if (localBigDecimal.doubleValue() >= localReserve.getPayableReserve().doubleValue()) {
						ResultVO localResultVO = this.processService.paymentReserve(localUser.getBelongtoFirm().getFirmID(),
								localTrade.getTradeNo().longValue(), localReserve.getPayableReserve().doubleValue());
						if (localResultVO.getResult() < 0L) {
							addReturnValue(-1, 2300002L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
							writeOperateLog(2309, str1, 0, localResultVO.getErrorInfo().replace("\n", ""));
						} else if (localResultVO.getResult() == 0L) {
							addReturnValue(-1, 2300003L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
							writeOperateLog(2309, str1, 0, localResultVO.getErrorInfo().replace("\n", ""));
						} else {
							addReturnValue(1, 2310611L);
							writeOperateLog(2309, str1, 1, null);
						}
					} else {
						addReturnValue(-1, 2310651L);
						writeOperateLog(2309, str1, 0, ApplicationContextInit.getErrorInfo("-6003"));
					}
				} else {
					writeOperateLog(2309, str1, 0, "订单号或合同号为空");
				}
			} else {
				addReturnValue(-1, 2310652L);
				writeOperateLog(2309, str1, 0, ApplicationContextInit.getErrorInfo("-6004"));
			}
		}
		return "success";
	}

	public String withdrawTrade() throws Exception {
		String str = "关闭合同%s";
		this.logger.debug("------关闭交易操作  ----withdrawTrade---");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		Trade localTrade = isMyTrade(this.entity, localUser);
		if (localTrade == null) {
			addReturnValue(-1, 2310600L);
			str = String.format(str, new Object[] { "" });
			writeOperateLog(2309, str, 0, ApplicationContextInit.getErrorInfo("2310600"));
		} else {
			str = String.format(str, new Object[] { localTrade.getTradeNo() });
			boolean bool = closeAutoTrade(localTrade, localUser);
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
					writeOperateLog(2309, str, 0, localResultVO.getErrorInfo().replace("\n", ""));
				} else if (localResultVO.getResult() == 0L) {
					addReturnValue(-1, 2300003L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, str, 0, localResultVO.getErrorInfo().replace("\n", ""));
				} else {
					addReturnValue(1, 2310613L);
					writeOperateLog(2309, str, 1, null);
				}
			} else {
				addReturnValue(-1, 2310654L);
				writeOperateLog(2309, str, 0, ApplicationContextInit.getErrorInfo("-6006"));
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
			boolean bool = appendAutoGoods(localTrade, localUser);
			if (bool) {
				double d1 = Arith.format(Arith.mul(localTrade.getQuantity().doubleValue(), localTrade.getPrice().doubleValue()), 2);
				this.entity = localTrade;
				Set localSet = localTrade.getContainHolding();
				double d2 = 0.0D;
				Iterator localIterator = localSet.iterator();
				while (localIterator.hasNext()) {
					Holding localHolding = (Holding) localIterator.next();
					if (localHolding.getFirmID().equals(localUser.getBelongtoFirm().getFirmID())) {
						d2 = localHolding.getPayGoodsMoney().doubleValue();
						this.request.setAttribute("PayMargin", localHolding.getPayMargin());
						this.request.setAttribute("payOff", localHolding.getPayoff());
					}
				}
				double d3 = localTrade.getBuyTradeFee().doubleValue();
				double d4 = localTrade.getBuyDeliveryFee().doubleValue();
				Double localDouble = localTrade.getBelongtoBreed().getBelongtoCategory().getOffsetRate();
				if ("N".equals(localTrade.getBelongtoBreed().getBelongtoCategory().getIsOffset())) {
					localDouble = Double.valueOf(0.0D);
				}
				double d5 = localTrade.getQuantity().doubleValue();
				double d6 = d5 * (1.0D + localDouble.doubleValue());
				double d7 = d5 * (1.0D - localDouble.doubleValue());
				double d8 = Arith.mul(localTrade.getPrice().doubleValue(), d6);
				double d9 = Arith.format(Arith.sub(d8, d2), 2);
				double d10 = Arith.mul(localTrade.getPrice().doubleValue(), d7);
				double d11 = Arith.format(Arith.sub(d10, d2), 2);
				double d12 = Arith.format(Arith.sub(d1, d2), 2);
				BigDecimal localBigDecimal = getRealGoods();
				this.request.setAttribute("tradeFeeMoney", Double.valueOf(d3));
				this.request.setAttribute("deliveryFeeMoney", Double.valueOf(d4));
				this.request.setAttribute("realFunds", localBigDecimal);
				this.request.setAttribute("goods", Double.valueOf(d1));
				this.request.setAttribute("maxEndGoods", Double.valueOf(d9));
				this.request.setAttribute("payGoodsMoney", Double.valueOf(d2));
				this.request.setAttribute("minEndGoods", Double.valueOf(d11));
				this.request.setAttribute("endGoods", Double.valueOf(d12));
			} else {
				addReturnValue(-1, 2310655L);
			}
		}
		return "success";
	}

	public String paymentGoodsMoney() {
		String str1 = "为合同%s转入货款";
		this.logger.debug("---转入货款操作---------paymentGoodsMoney---------");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		Trade localTrade = isMyTrade(this.entity, localUser);
		if (localTrade == null) {
			addReturnValue(-1, 2310600L);
			writeOperateLog(2309, String.format(str1, new Object[] { "" }), 0, ApplicationContextInit.getErrorInfo("2310600"));
		} else {
			str1 = String.format(str1, new Object[] { localTrade.getTradeNo() });
			boolean bool1 = appendAutoGoods(localTrade, localUser);
			if (bool1) {
				String str2 = this.request.getParameter("lastPayment");
				boolean bool2 = true;
				if (str2.equals("false")) {
					bool2 = false;
				}
				String str3 = this.request.getParameter("payMoney");
				Holding localHolding = getHoldingByTrade(localTrade, localUser, true);
				ResultVO localResultVO = this.processService.paymentGoodsMoney(localHolding.getHoldingID().longValue(), Tools.strToDouble(str3, 0.0D),
						bool2);
				if (localResultVO.getResult() < 0L) {
					addReturnValue(-1, 2300002L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, str1, 0, localResultVO.getErrorInfo().replace("\n", ""));
				} else if (localResultVO.getResult() == 0L) {
					addReturnValue(-1, 2300003L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, str1, 0, localResultVO.getErrorInfo().replace("\n", ""));
				} else {
					addReturnValue(1, 2310614L);
					writeOperateLog(2309, str1, 1, null);
				}
			} else {
				addReturnValue(-1, 2310655L);
				writeOperateLog(2309, str1, 0, ApplicationContextInit.getErrorInfo("-6007"));
			}
		}
		return "success";
	}

	public String forwardTransferGoods() throws Exception {
		this.logger.debug("------转入仓单跳转 ----forwardTransferGoods---");
		this.request.setAttribute("oldParams", ActionUtil.getParametersStartingWith(this.request, "gnnt_"));
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		MFirm localMFirm = localUser.getBelongtoFirm();
		Trade localTrade = isMyTrade(this.entity, localUser);
		if (localTrade == null) {
			addReturnValue(-1, 2310600L);
			this.request.setAttribute("quantity", Integer.valueOf(0));
			this.request.setAttribute("min", Integer.valueOf(0));
			this.request.setAttribute("max", Integer.valueOf(0));
		} else {
			this.entity = localTrade;
			Long localLong = localTrade.getBelongtoBreed().getBreedID();
			boolean bool = appendAutoWarehouse(localTrade, localUser);
			if (bool) {
				PageRequest localPageRequest = ActionUtil.getPageRequest(this.request);
				QueryConditions localQueryConditions = (QueryConditions) localPageRequest.getFilters();
				localQueryConditions.addCondition("primary.belongtoFirm.firmID", "=", localUser.getBelongtoFirm().getFirmID());
				localQueryConditions.addCondition("primary.status", "=", Integer.valueOf(1));
				if (("1".equals(localTrade.getDeliveryType())) && (localTrade.getWarehouseID() != null)) {
					localQueryConditions.addCondition("primary.warehouseID", "=", localTrade.getWarehouseID());
				}
				localQueryConditions.addCondition("primary.belongtoBreed.breedID", "=", localLong);
				localQueryConditions.addCondition(" ", " ", "0=(select count(c.operationID) from primary.containOperation as c)");
				localPageRequest.setPageSize(1000);
				Page localPage = getService().getPage(localPageRequest, new Stock());
				List localList1 = localPage.getResult();
				if ((localList1 == null) || (localList1.size() < 1)) {
					this.request.setAttribute("quantity", Integer.valueOf(0));
					this.request.setAttribute("min", Integer.valueOf(0));
					this.request.setAttribute("max", Integer.valueOf(0));
					return "success";
				}
				ArrayList localArrayList1 = new ArrayList();
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
							((TradeGoodsProperty) localObject4).getPropertyValue());
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
									((WareHouseGoodsProperty) localObject6).getPropertyValue());
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
			boolean bool = appendAutoWarehouse(localTrade, localUser);
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
					writeOperateLog(2309, "为合同" + localTrade.getTradeNo() + "转入仓单", 0, localResultVO.getErrorInfo().replace("\n", ""));
				} else if (localResultVO.getResult() == 0L) {
					addReturnValue(-1, 2300003L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "为合同" + localTrade.getTradeNo() + "转入仓单", 0, localResultVO.getErrorInfo().replace("\n", ""));
				} else {
					addReturnValue(1, 2310612L);
					writeOperateLog(2309, "为合同" + localTrade.getTradeNo() + "转入仓单", 1, null);
				}
			} else {
				addReturnValue(-1, 2310653L);
				writeOperateLog(2309, "为合同" + localTrade.getTradeNo() + "转入仓单", 0, ApplicationContextInit.getErrorInfo("-6005"));
			}
		}
		return "success";
	}

	public String forwardPayGoods() {
		this.logger.debug("------支付货款跳转 ----forwardPayGoods---");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		Trade localTrade = isMyTrade(this.entity, localUser);
		if (localTrade == null) {
			addReturnValue(-1, 2310600L);
		} else {
			boolean bool = payAutoGoods(localTrade, localUser);
			if (bool) {
				this.entity = localTrade;
				Set localSet = localTrade.getContainHolding();
				double d1 = 0.0D;
				double d2 = 0.0D;
				Iterator localIterator = localSet.iterator();
				while (localIterator.hasNext()) {
					Holding localHolding = (Holding) localIterator.next();
					if (localHolding.getFirmID().equals(localUser.getBelongtoFirm().getFirmID())) {
						d1 = localHolding.getPayoff().doubleValue();
						d2 = localHolding.getPayGoodsMoney().doubleValue();
						this.request.setAttribute("PayMargin", localHolding.getPayMargin());
					}
				}
				double d3 = Arith.format(Arith.sub(d2, d1), 2);
				this.request.setAttribute("remainMoney", Double.valueOf(d3));
				this.request.setAttribute("payOff", Double.valueOf(d1));
				this.request.setAttribute("payGoodsMoney", Double.valueOf(d2));
			} else {
				addReturnValue(-1, 2310667L);
			}
		}
		return "success";
	}

	public String payGoods() throws Exception {
		this.logger.debug("------支付货款操作 ----payGoods---");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		Trade localTrade = isMyTrade(this.entity, localUser);
		if (localTrade == null) {
			addReturnValue(-1, 2310600L);
			writeOperateLog(2309, "为合同支付货款", 0, ApplicationContextInit.getErrorInfo("2310600"));
		} else {
			boolean bool = payAutoGoods(localTrade, localUser);
			if (bool) {
				Holding localHolding = getHoldingByTrade(localTrade, localUser, true);
				String str = this.request.getParameter("payMoney");
				ResultVO localResultVO = this.processService.paymentMoneyToSell(localHolding.getHoldingID().longValue(),
						Tools.strToDouble(str, 0.0D));
				if (localResultVO.getResult() < 0L) {
					addReturnValue(-1, 2300002L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "合同号为：" + localTrade.getTradeNo() + "的合同支付货款", 0, localResultVO.getErrorInfo().replace("\n", ""));
				} else if (localResultVO.getResult() == 0L) {
					addReturnValue(-1, 2300003L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "合同号为：" + localTrade.getTradeNo() + "的合同支付货款", 0, localResultVO.getErrorInfo().replace("\n", ""));
				} else {
					addReturnValue(1, 2310626L);
					writeOperateLog(2309, "合同号为：" + localTrade.getTradeNo() + "的合同支付货款", 1, null);
				}
			} else {
				addReturnValue(-1, 2310667L);
				writeOperateLog(2309, "合同号为：" + localTrade.getTradeNo() + "的合同操作", 0, ApplicationContextInit.getErrorInfo("-6023"));
			}
		}
		return "success";
	}

	public String forwardPayWarehouse() {
		this.logger.debug("------支付仓单跳转 ----forwardPayWarehouse---");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		Trade localTrade = isMyTrade(this.entity, localUser);
		if (localTrade == null) {
			addReturnValue(-1, 2310600L);
		} else {
			boolean bool = payAutoWarehouse(localTrade, localUser);
			if (bool) {
				PageRequest localPageRequest = null;
				try {
					localPageRequest = ActionUtil.getPageRequest(this.request);
					QueryConditions localQueryConditions = (QueryConditions) localPageRequest.getFilters();
					localQueryConditions.addCondition("primary.moduleID", "=", Integer.valueOf(23));
					localQueryConditions.addCondition("primary.tradeNo", "=", localTrade.getTradeNo().toString());
					localQueryConditions.addCondition("primary.belongtoStock.belongtoFirm.firmID", "=", localUser.getBelongtoFirm().getFirmID());
				} catch (Exception localException) {
					localException.printStackTrace();
				}
				this.logger.debug(localPageRequest.getFilters() + "------------getFilters");
				Page localPage = getService().getPage(localPageRequest, new TradeStock());
				Object localObject = new ArrayList();
				if ((localPage.getResult() != null) && (localPage.getResult().size() > 0)) {
					localObject = localPage.getResult();
				}
				Holding localHolding = getHoldingByTrade(localTrade, localUser, true);
				this.request.setAttribute("holding", localHolding);
				this.request.setAttribute("tradeStockList", localObject);
				this.request.setAttribute("oldParams", ActionUtil.getParametersStartingWith(this.request, "gnnt_"));
			} else {
				addReturnValue(-1, 2310668L);
			}
		}
		return "success";
	}

	public String payWarehouse() {
		this.logger.debug("------支付仓单操作 ----payWarehouse---");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		Trade localTrade = isMyTrade(this.entity, localUser);
		if (localTrade == null) {
			addReturnValue(-1, 2310600L);
			writeOperateLog(2309, "为合同转入仓单", 0, ApplicationContextInit.getErrorInfo("2310600"));
		} else {
			boolean bool = payAutoWarehouse(localTrade, localUser);
			if (bool) {
				ResultVO localResultVO = new ResultVO();
				localResultVO.setResult(1L);
				String[] arrayOfString = this.request.getParameterValues("cks");
				Holding localHolding = getHoldingByTrade(localTrade, localUser, true);
				localResultVO = this.wareHouseStockService.paymentGoodsTOBuy(localHolding.getHoldingID().longValue(), arrayOfString);
				if (localResultVO.getResult() < 0L) {
					addReturnValue(-1, 2300002L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "合同号为：" + localTrade.getTradeNo() + "的合同支付仓单", 0, localResultVO.getErrorInfo().replace("\n", ""));
				} else if (localResultVO.getResult() == 0L) {
					addReturnValue(-1, 2300003L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "合同号为：" + localTrade.getTradeNo() + "的合同支付仓单", 0, localResultVO.getErrorInfo().replace("\n", ""));
				} else {
					addReturnValue(1, 2310627L);
					writeOperateLog(2309, "合同号为：" + localTrade.getTradeNo() + "的合同支付仓单", 1, null);
				}
			} else {
				addReturnValue(-1, 2310668L);
				writeOperateLog(2309, "合同号为：" + localTrade.getTradeNo() + "的合同支付仓单", 0, ApplicationContextInit.getErrorInfo("-6024"));
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
			writeOperateLog(2309, "对合同进行违约申请", 0, ApplicationContextInit.getErrorInfo("2310600"));
		} else {
			boolean bool = breachAutoApply(localTrade, localUser);
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
					writeOperateLog(2309, "合同号为：" + localTrade.getTradeNo() + "的合同违约申请", 0, localResultVO.getErrorInfo().replace("\n", ""));
				} else if (localResultVO.getResult() == 0L) {
					addReturnValue(-1, 2300003L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "合同号为：" + localTrade.getTradeNo() + "的合同违约申请", 0, localResultVO.getErrorInfo().replace("\n", ""));
				} else {
					addReturnValue(1, 2310401L);
					writeOperateLog(2309, "合同号为：" + localTrade.getTradeNo() + "的合同违约申请", 1, null);
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
			writeOperateLog(2309, "撤销合同违约申请", 0, ApplicationContextInit.getErrorInfo("2310600"));
		} else {
			boolean bool = revocationBreachAutoApply(localTrade, localUser);
			if (bool) {
				Object localObject;
				ResultVO localResultVO;
				if (localTrade.getStatus().intValue() == 0) {
					localObject = getReserveByTrade(localTrade, localUser, true);
					localResultVO = this.reserveProcessService.performWithdrawAsk(((Reserve) localObject).getReserveID().longValue());
					if (localResultVO.getResult() < 0L) {
						addReturnValue(-1, 2300002L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
						writeOperateLog(2309, "合同号为：" + localTrade.getTradeNo() + "的合同撤销违约", 0, localResultVO.getErrorInfo().replace("\n", ""));
					} else if (localResultVO.getResult() == 0L) {
						addReturnValue(-1, 2300003L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
						writeOperateLog(2309, "合同号为：" + localTrade.getTradeNo() + "的合同撤销违约", 0, localResultVO.getErrorInfo().replace("\n", ""));
					} else {
						addReturnValue(1, 2310402L);
						writeOperateLog(2309, "合同号为：" + localTrade.getTradeNo() + "的合同撤销违约", 1, null);
					}
				} else if (localTrade.getStatus().intValue() == 3) {
					localObject = getHoldingByTrade(localTrade, localUser, true);
					localResultVO = this.tradeProcessService.performWithdrawAsk(((Holding) localObject).getHoldingID().longValue());
					if (localResultVO.getResult() < 0L) {
						addReturnValue(-1, 2300002L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
						writeOperateLog(2309, "合同号为：" + localTrade.getTradeNo() + "的合同撤销违约", 0, localResultVO.getErrorInfo().replace("\n", ""));
					} else if (localResultVO.getResult() == 0L) {
						addReturnValue(-1, 2300003L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
						writeOperateLog(2309, "合同号为：" + localTrade.getTradeNo() + "的合同撤销违约", 0, localResultVO.getErrorInfo().replace("\n", ""));
					} else {
						addReturnValue(1, 2310402L);
						writeOperateLog(2309, "合同号为：" + localTrade.getTradeNo() + "的合同撤销违约", 1, null);
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
			boolean bool = disposeBreachAutoApply(localTrade, localUser);
			Double localDouble = null;
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
			writeOperateLog(2309, "处理对方提出的合同违约申请", 0, ApplicationContextInit.getErrorInfo("2310600"));
		} else {
			boolean bool = disposeBreachAutoApply(localTrade, localUser);
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
						writeOperateLog(2309, "合同号为：" + localTrade.getTradeNo() + "的合同处理违约", 0, localResultVO2.getErrorInfo().replace("\n", ""));
					} else if (localResultVO2.getResult() == 0L) {
						addReturnValue(-1, 2300003L, new Object[] { localResultVO2.getErrorInfo().replace("\n", "") });
						writeOperateLog(2309, "合同号为：" + localTrade.getTradeNo() + "的合同处理违约", 0, localResultVO2.getErrorInfo().replace("\n", ""));
					} else {
						addReturnValue(1, 2310629L);
						writeOperateLog(2309, "合同号为：" + localTrade.getTradeNo() + "的合同处理违约", 1, null);
					}
				} else if (localTrade.getStatus().intValue() == 3) {
					ResultVO localResultVO1 = this.tradeProcessService.performTradeBreach(localTrade.getTradeNo().longValue(),
							localUser.getBelongtoFirm().getFirmID());
					if (localResultVO1.getResult() < 0L) {
						addReturnValue(-1, 2300002L, new Object[] { localResultVO1.getErrorInfo().replace("\n", "") });
						writeOperateLog(2309, "合同号为：" + localTrade.getTradeNo() + "的合同处理违约", 0, localResultVO1.getErrorInfo().replace("\n", ""));
					} else if (localResultVO1.getResult() == 0L) {
						addReturnValue(-1, 2300003L, new Object[] { localResultVO1.getErrorInfo().replace("\n", "") });
						writeOperateLog(2309, "合同号为：" + localTrade.getTradeNo() + "的合同处理违约", 0, localResultVO1.getErrorInfo().replace("\n", ""));
					} else {
						addReturnValue(1, 2310629L);
						writeOperateLog(2309, "合同号为：" + localTrade.getTradeNo() + "的合同处理违约", 1, null);
					}
				}
			} else {
				addReturnValue(-1, 2310673L);
				writeOperateLog(2309, "合同号为：" + localTrade.getTradeNo() + "的合同处理违约", 0, ApplicationContextInit.getErrorInfo("-6015"));
			}
		}
		return "success";
	}

	public String toBreachDelay() {
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		Trade localTrade = isMyTrade(this.entity, localUser);
		if (localTrade == null) {
			addReturnValue(-1, 2310600L);
			BreachApply localBreachApply1 = new BreachApply();
			this.request.setAttribute("entity", localBreachApply1);
		} else {
			boolean bool = tradeBreachAutoDelay(localTrade, localUser);
			Object localObject;
			if (bool) {
				localObject = "select * from E_BreachApply b where b.tradeno='" + localTrade.getTradeNo() + "' and b.firmid='"
						+ localUser.getBelongtoFirm().getFirmID() + "' and b.status='0'";
				List localList = super.getService().getListBySql((String) localObject, new BreachApply());
				BreachApply localBreachApply2 = (BreachApply) localList.get(0);
				int i = Tools.strToInt(this.kernelService.getConfigInfo("BufferDate"), 1);
				if (localBreachApply2 != null) {
					Date localDate1 = localBreachApply2.getApplyTime();
					Date localDate2 = new Date(localDate1.getTime() + i * 60 * 60 * 1000);
					this.request.setAttribute("time", localDate2);
				}
				this.request.setAttribute("entity", localList.get(0));
			} else {
				localObject = new BreachApply();
				this.request.setAttribute("entity", localObject);
				addReturnValue(-1, 2310404L);
			}
		}
		return "success";
	}

	public String breachDelay() {
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		BreachApply localBreachApply = (BreachApply) this.entity;
		if (null == localBreachApply) {
			addReturnValue(-1, 2310600L);
			return "success";
		}
		Trade localTrade = new Trade();
		localTrade.setTradeNo(localBreachApply.getTradeNo());
		localTrade = isMyTrade(localTrade, localUser);
		if (localTrade == null) {
			addReturnValue(-1, 2310600L);
			writeOperateLog(2309, "修改合同延时时间", 0, ApplicationContextInit.getErrorInfo("2310600"));
		} else {
			boolean bool = tradeBreachAutoDelay(localTrade, localUser);
			if (bool) {
				localBreachApply.setDelayTime(Long.valueOf(localBreachApply.getDelayTime().longValue() * 60L * 60L));
				getService().update(localBreachApply);
				String str = localTrade.getBfirmID().equals(localUser.getBelongtoFirm().getFirmID()) ? localTrade.getSfirmID()
						: localTrade.getBfirmID();
				try {
					this.kernelService.sendMsgToTrader(str,
							"违约号：" + localBreachApply.getBreachApplyId() + "的违约延期" + localBreachApply.getDelayTime().longValue() / 3600L + "小时！");
					addReturnValue(1, 9910001L);
				} catch (Exception localException) {
					localException.printStackTrace();
				}
				writeOperateLog(2309,
						"违约号：" + localBreachApply.getBreachApplyId() + "的违约延期" + localBreachApply.getDelayTime().longValue() / 3600L + "小时", 1, null);
			} else {
				addReturnValue(-1, 2310669L);
				writeOperateLog(2309, "合同号为：" + localTrade.getTradeNo() + "的合同修改延迟时间", 0, ApplicationContextInit.getErrorInfo("-6015"));
			}
		}
		return "success";
	}

	public String performEndTradeApply() {
		this.logger.debug("-- 结束合同申请操作----------performEndTradeApply----------");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		Trade localTrade = isMyTrade(this.entity, localUser);
		if (localTrade == null) {
			addReturnValue(-1, 2310600L);
			writeOperateLog(2309, "结束合同申请", 0, ApplicationContextInit.getErrorInfo("2310600"));
		} else if ((localTrade.getStatus().intValue() == 3) || (localTrade.getStatus().intValue() == 5)) {
			EndTradeApply localEndTradeApply = getEndTradeApply(localTrade);
			if (localEndTradeApply == null) {
				ResultVO localResultVO = this.tradeProcessService.performApplyEndTrade(localTrade.getTradeNo().longValue(),
						localUser.getBelongtoFirm().getFirmID());
				if (localResultVO.getResult() < 0L) {
					addReturnValue(-1, 2300002L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "合同号为：" + localTrade.getTradeNo() + "结束合同申请", 0, localResultVO.getErrorInfo().replace("\n", ""));
				} else if (localResultVO.getResult() == 0L) {
					addReturnValue(-1, 2300003L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "合同号为：" + localTrade.getTradeNo() + "结束合同申请", 0, localResultVO.getErrorInfo().replace("\n", ""));
				} else {
					addReturnValue(1, 2310623L);
					writeOperateLog(2309, "合同号为：" + localTrade.getTradeNo() + "结束合同申请", 1, null);
				}
			} else {
				addReturnValue(-1, 2310674L, new Object[] { localTrade.getTradeNo() });
				writeOperateLog(2309, "合同号为：" + localTrade.getTradeNo() + "结束合同申请", 0, ApplicationContextInit.getErrorInfo("-6041"));
			}
		} else {
			addReturnValue(-1, 2310664L);
			writeOperateLog(2309, "合同号为：" + localTrade.getTradeNo() + "的合同操作", 0, ApplicationContextInit.getErrorInfo("-6020"));
		}
		return "success";
	}

	public String performRevokeEndTradeApply() throws RemoteException {
		this.logger.debug("-- 撤销结束合同操作----------performRevokeEndTradeApply----------");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		Trade localTrade = isMyTrade(this.entity, localUser);
		if (localTrade == null) {
			addReturnValue(-1, 2310600L);
			writeOperateLog(2309, "撤销结束合同", 0, ApplicationContextInit.getErrorInfo("2310600"));
		} else if ((localTrade.getStatus().intValue() == 3) || (localTrade.getStatus().intValue() == 5)) {
			boolean bool = revokeEndTradeAutoApply(localTrade, localUser);
			if (bool) {
				ResultVO localResultVO = this.tradeProcessService.withdrawApplyEndTrade(localTrade.getTradeNo().longValue(),
						localUser.getBelongtoFirm().getFirmID());
				if (localResultVO.getResult() < 0L) {
					addReturnValue(-1, 2300002L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "合同号为：" + localTrade.getTradeNo() + "撤销结束合同", 0, localResultVO.getErrorInfo().replace("\n", ""));
				} else if (localResultVO.getResult() == 0L) {
					addReturnValue(-1, 2300003L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "合同号为：" + localTrade.getTradeNo() + "撤销结束合同", 0, localResultVO.getErrorInfo().replace("\n", ""));
				} else {
					addReturnValue(1, 2310624L);
					writeOperateLog(2309, "合同号为：" + localTrade.getTradeNo() + "撤销结束合同", 1, null);
				}
			} else {
				addReturnValue(-1, 2310675L, new Object[] { localTrade.getTradeNo() });
			}
		} else {
			addReturnValue(-1, 2310665L);
			writeOperateLog(2309, "合同号为：" + localTrade.getTradeNo() + "的合同操作", 0, ApplicationContextInit.getErrorInfo("-6022"));
		}
		return "success";
	}

	public String performDisposeEndTradeApply() throws RemoteException {
		this.logger.debug("-- 同意结束合同操作----------performDisposeEndTradeApply----------");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		Trade localTrade = isMyTrade(this.entity, localUser);
		if (localTrade == null) {
			addReturnValue(-1, 2310600L);
			writeOperateLog(2309, "同意对方结束合同申请", 0, ApplicationContextInit.getErrorInfo("2310600"));
		} else {
			boolean bool = disposeEndTradeAutoApply(localTrade, localUser);
			if (bool) {
				ResultVO localResultVO = this.tradeProcessService.performEndTrade(localTrade.getTradeNo().longValue(),
						localUser.getBelongtoFirm().getFirmID());
				if (localResultVO.getResult() < 0L) {
					addReturnValue(-1, 2300002L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "同意合同号为：" + localTrade.getTradeNo() + "的合同结束", 0, localResultVO.getErrorInfo().replace("\n", ""));
				} else if (localResultVO.getResult() == 0L) {
					addReturnValue(-1, 2300003L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "同意合同号为：" + localTrade.getTradeNo() + "的合同结束", 0, localResultVO.getErrorInfo().replace("\n", ""));
				} else {
					addReturnValue(1, 2310625L);
					writeOperateLog(2309, "同意合同号为：" + localTrade.getTradeNo() + "的合同结束", 1, null);
				}
			} else {
				addReturnValue(-1, 2310666L);
				writeOperateLog(2309, "同意合同号为：" + localTrade.getTradeNo() + "的合同结束", 0, ApplicationContextInit.getErrorInfo("-6023"));
			}
		}
		return "success";
	}

	public Map<String, Boolean> getTradeButtonMap(Trade paramTrade) {
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		HashMap localHashMap = new HashMap();
		localHashMap.put("appendAutoMagin", Boolean.valueOf(appendAutoMagin(paramTrade, localUser)));
		localHashMap.put("appendAutoGoods", Boolean.valueOf(appendAutoGoods(paramTrade, localUser)));
		localHashMap.put("appendAutoWarehouse", Boolean.valueOf(appendAutoWarehouse(paramTrade, localUser)));
		localHashMap.put("payAutoGoods", Boolean.valueOf(payAutoGoods(paramTrade, localUser)));
		localHashMap.put("payAutoWarehouse", Boolean.valueOf(payAutoWarehouse(paramTrade, localUser)));
		localHashMap.put("breachAutoApply", Boolean.valueOf(breachAutoApply(paramTrade, localUser)));
		localHashMap.put("revocationBreachAutoApply", Boolean.valueOf(revocationBreachAutoApply(paramTrade, localUser)));
		localHashMap.put("disposeBreachAutoApply", Boolean.valueOf(disposeBreachAutoApply(paramTrade, localUser)));
		localHashMap.put("tradeBreachAutoDelay", Boolean.valueOf(tradeBreachAutoDelay(paramTrade, localUser)));
		localHashMap.put("tradeEndAutoApply", Boolean.valueOf(tradeEndAutoApply(paramTrade, localUser)));
		localHashMap.put("revokeEndTradeAutoApply", Boolean.valueOf(revokeEndTradeAutoApply(paramTrade, localUser)));
		localHashMap.put("disposeEndTradeAutoApply", Boolean.valueOf(disposeEndTradeAutoApply(paramTrade, localUser)));
		localHashMap.put("closeAutoTrade", Boolean.valueOf(closeAutoTrade(paramTrade, localUser)));
		this.logger.debug(localHashMap);
		return localHashMap;
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

	public boolean appendAutoMagin(Trade paramTrade, User paramUser) {
		if (paramTrade.getStatus().intValue() == 0) {
			Reserve localReserve = getReserveByTrade(paramTrade, paramUser, true);
			return localReserve.getStatus().intValue() == 0;
		}
		return false;
	}

	public boolean closeAutoTrade(Trade paramTrade, User paramUser) {
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

	public boolean appendAutoGoods(Trade paramTrade, User paramUser) {
		if (!paramTrade.getBfirmID().equals(paramUser.getBelongtoFirm().getFirmID())) {
			return false;
		}
		if (paramTrade.getStatus().intValue() == 3) {
			Holding localHolding = getHoldingByTrade(paramTrade, paramUser, true);
			return localHolding.getStatus().intValue() == 1;
		}
		return false;
	}

	public boolean appendAutoWarehouse(Trade paramTrade, User paramUser) {
		if (!paramTrade.getSfirmID().equals(paramUser.getBelongtoFirm().getFirmID())) {
			return false;
		}
		if (paramTrade.getStatus().intValue() == 3) {
			Holding localHolding = getHoldingByTrade(paramTrade, paramUser, true);
			if (localHolding.getStatus().intValue() == 1) {
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

	public boolean payAutoGoods(Trade paramTrade, User paramUser) {
		if (!paramTrade.getBfirmID().equals(paramUser.getBelongtoFirm().getFirmID())) {
			return false;
		}
		if ((paramTrade.getStatus().intValue() == 3) || (paramTrade.getStatus().intValue() == 5)) {
			Holding localHolding = getHoldingByTrade(paramTrade, paramUser, true);
			double d = localHolding.getPayGoodsMoney().doubleValue() - localHolding.getPayoff().doubleValue();
			return d != 0.0D;
		}
		return false;
	}

	public boolean payAutoWarehouse(Trade paramTrade, User paramUser) {
		if ((paramTrade.getStatus().intValue() != 3) && (paramTrade.getStatus().intValue() != 5)) {
			return false;
		}
		if (!paramTrade.getSfirmID().equals(paramUser.getBelongtoFirm().getFirmID())) {
			return false;
		}
		Holding localHolding = getHoldingByTrade(paramTrade, paramUser, true);
		if (localHolding.getHoldingID() != null) {
			double d = localHolding.getPayGoodsMoney().doubleValue() - localHolding.getPayoff().doubleValue();
			return d != 0.0D;
		}
		return false;
	}

	public boolean breachAutoApply(Trade paramTrade, User paramUser) {
		if ((paramTrade.getStatus().intValue() != 0) && (paramTrade.getStatus().intValue() != 3) && (paramTrade.getStatus().intValue() != 5)) {
			return false;
		}
		boolean bool = revocationBreachAutoApply(paramTrade, paramUser);
		if (bool) {
			return false;
		}
		BreachApply localBreachApply = getBreachApplyByTrade(paramTrade, paramUser, false);
		if (localBreachApply != null) {
			return false;
		}
		long l;
		Object localObject;
		if (paramTrade.getStatus().intValue() == 0) {
			l = getService().getSysDate().getTime() - paramTrade.getTime().getTime();
			if (l / 1000L <= paramTrade.getTradePreTime().intValue()) {
				return false;
			}
			localObject = getReserveByTrade(paramTrade, paramUser, true);
			Reserve localReserve = getReserveByTrade(paramTrade, paramUser, false);
			return (((Reserve) localObject).getStatus().intValue() == 1) && (localReserve.getStatus().intValue() == 0);
		}
		if (paramTrade.getStatus().intValue() == 3) {
			l = getService().getSysDate().getTime() - paramTrade.getDeliveryDay().getTime();
			if (l < 0L) {
				return false;
			}
			localObject = getHoldingByTrade(paramTrade, paramUser, false);
			return ((Holding) localObject).getStatus().intValue() != 2;
		}
		return false;
	}

	public boolean revocationBreachAutoApply(Trade paramTrade, User paramUser) {
		if ((paramTrade.getStatus().intValue() != 0) && (paramTrade.getStatus().intValue() != 3) && (paramTrade.getStatus().intValue() != 5)) {
			return false;
		}
		BreachApply localBreachApply = getBreachApplyByTrade(paramTrade, paramUser, true);
		if (localBreachApply == null) {
			return false;
		}
		return localBreachApply.getStatus().intValue() == 0;
	}

	public boolean disposeBreachAutoApply(Trade paramTrade, User paramUser) {
		if (paramTrade.getStatus().intValue() != 0) {
			return false;
		}
		BreachApply localBreachApply = getBreachApplyByTrade(paramTrade, paramUser, false);
		if (localBreachApply == null) {
			return false;
		}
		return localBreachApply.getStatus().intValue() == 0;
	}

	public boolean tradeBreachAutoDelay(Trade paramTrade, User paramUser) {
		if ((paramTrade.getStatus().intValue() != 3) && (paramTrade.getStatus().intValue() != 0)) {
			return false;
		}
		String str = "select * from E_BreachApply b where b.tradeno='" + paramTrade.getTradeNo() + "' and b.firmid='"
				+ paramUser.getBelongtoFirm().getFirmID() + "' and b.status='0'";
		List localList = getService().getListBySql(str);
		return localList.size() > 0;
	}

	public boolean tradeEndAutoApply(Trade paramTrade, User paramUser) {
		if ((paramTrade.getStatus().intValue() == 3) || (paramTrade.getStatus().intValue() == 5)) {
			EndTradeApply localEndTradeApply = getEndTradeApply(paramTrade);
			if (localEndTradeApply == null) {
				return true;
			}
		}
		return false;
	}

	public boolean disposeEndTradeAutoApply(Trade paramTrade, User paramUser) {
		if ((paramTrade.getStatus().intValue() == 21) || (paramTrade.getStatus().intValue() == 22)) {
			return false;
		}
		EndTradeApply localEndTradeApply = getEndTradeApply(paramTrade);
		if (localEndTradeApply == null) {
			return false;
		}
		return (!localEndTradeApply.getFirm().getFirmID().equals(paramUser.getBelongtoFirm().getFirmID()))
				&& (localEndTradeApply.getStatus().intValue() == 0);
	}

	public boolean revokeEndTradeAutoApply(Trade paramTrade, User paramUser) {
		if ((paramTrade.getStatus().intValue() == 21) || (paramTrade.getStatus().intValue() == 22)) {
			return false;
		}
		EndTradeApply localEndTradeApply = getEndTradeApply(paramTrade);
		if (localEndTradeApply == null) {
			return false;
		}
		return (localEndTradeApply.getFirm().getFirmID().equals(paramUser.getBelongtoFirm().getFirmID()))
				&& (localEndTradeApply.getStatus().intValue() == 0);
	}

	public EndTradeApply getEndTradeApply(Trade paramTrade) {
		EndTradeApply localEndTradeApply = new EndTradeApply();
		PageRequest localPageRequest = new PageRequest(" and primary.tradeNo=" + paramTrade.getTradeNo() + " and primary.status=0");
		Page localPage = getService().getPage(localPageRequest, new EndTradeApply());
		if ((localPage.getResult() != null) && (localPage.getResult().size() > 0)) {
			localEndTradeApply = (EndTradeApply) localPage.getResult().get(0);
			return localEndTradeApply;
		}
		return null;
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
