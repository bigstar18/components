package gnnt.MEBS.espot.mgr.action.trademanage;

import java.math.BigDecimal;
import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
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

import gnnt.MEBS.common.mgr.action.EcsideAction;
import gnnt.MEBS.common.mgr.common.Page;
import gnnt.MEBS.common.mgr.common.PageRequest;
import gnnt.MEBS.common.mgr.common.QueryConditions;
import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.model.User;
import gnnt.MEBS.common.mgr.statictools.ApplicationContextInit;
import gnnt.MEBS.common.mgr.statictools.Arith;
import gnnt.MEBS.common.mgr.statictools.Tools;
import gnnt.MEBS.espot.core.kernel.IFundsProcess;
import gnnt.MEBS.espot.core.kernel.IKernelService;
import gnnt.MEBS.espot.core.kernel.IReserveProcess;
import gnnt.MEBS.espot.core.kernel.ITradeProcess;
import gnnt.MEBS.espot.core.kernel.IWareHouseStockProcess;
import gnnt.MEBS.espot.core.vo.ResultVO;
import gnnt.MEBS.espot.mgr.model.commoditymanage.Category;
import gnnt.MEBS.espot.mgr.model.commoditymanage.CategoryProperty;
import gnnt.MEBS.espot.mgr.model.commoditymanage.PropertyType;
import gnnt.MEBS.espot.mgr.model.firmmanage.MFirm;
import gnnt.MEBS.espot.mgr.model.holdingmanage.Holding;
import gnnt.MEBS.espot.mgr.model.ordermanage.Order;
import gnnt.MEBS.espot.mgr.model.ordermanage.OrderHis;
import gnnt.MEBS.espot.mgr.model.parametermanage.SystemProps;
import gnnt.MEBS.espot.mgr.model.reservemanage.Reserve;
import gnnt.MEBS.espot.mgr.model.stockmanage.Stock;
import gnnt.MEBS.espot.mgr.model.stockmanage.StockGoodsProperty;
import gnnt.MEBS.espot.mgr.model.stockmanage.TradeStock;
import gnnt.MEBS.espot.mgr.model.trademanage.BreachApply;
import gnnt.MEBS.espot.mgr.model.trademanage.EndTradeApply;
import gnnt.MEBS.espot.mgr.model.trademanage.GoodsMoneyApply;
import gnnt.MEBS.espot.mgr.model.trademanage.NoOffset;
import gnnt.MEBS.espot.mgr.model.trademanage.OffSetApply;
import gnnt.MEBS.espot.mgr.model.trademanage.TradeContract;
import gnnt.MEBS.espot.mgr.model.trademanage.TradeContractLog;
import gnnt.MEBS.espot.mgr.model.trademanage.TradeGoodsProperty;

@Controller("tradeProcessAction")
@Scope("request")
public class TradeProcessAction extends EcsideAction {
	private static final long serialVersionUID = -8937777138382131754L;
	@Autowired
	@Qualifier("tradeProcessService")
	protected ITradeProcess tradeProcessService;
	@Autowired
	@Qualifier("processService")
	protected IFundsProcess processService;
	@Autowired
	@Qualifier("kernelService")
	protected IKernelService kernelService;
	@Resource(name = "tradeContractStatusMap")
	protected Map<String, String> tradeContractStatusMap;
	@Resource(name = "tradeAutoContractStatusMap")
	protected Map<String, String> tradeAutoContractStatusMap;
	@Resource(name = "tradeTypeMap")
	protected Map<String, String> tradeTypeMap;
	@Autowired
	@Qualifier("wareHouseStockService")
	protected IWareHouseStockProcess wareHouseStockService;
	@Autowired
	@Qualifier("reserveProcessService")
	protected IReserveProcess reserveProcessService;
	protected String tradeNo;

	public IKernelService getKernelService() {
		return this.kernelService;
	}

	public String getTradeNo() {
		return this.tradeNo;
	}

	public void setTradeNo(String paramString) {
		this.tradeNo = paramString;
	}

	public IReserveProcess getReserveProcessService() {
		return this.reserveProcessService;
	}

	public IWareHouseStockProcess getWareHouseStockService() {
		return this.wareHouseStockService;
	}

	public Map<String, String> getTradeContractStatusMap() {
		return this.tradeContractStatusMap;
	}

	public IFundsProcess getProcessService() {
		return this.processService;
	}

	public Map<String, String> getTradeAutoContractStatusMap() {
		return this.tradeAutoContractStatusMap;
	}

	public Map<String, String> getTradeTypeMap() {
		return this.tradeTypeMap;
	}

	public ITradeProcess getTradeProcessService() {
		return this.tradeProcessService;
	}

	public void setTradeProcessService(ITradeProcess paramITradeProcess) {
		this.tradeProcessService = paramITradeProcess;
	}

	public String getTradeByTradeNo() throws Exception {
		String str = this.request.getParameter("tradeNo");
		if ((str == null) || ("".equals(str))) {
			addReturnValue(-1, 230002L, new Object[] { "合同号为空！" });
			return "success";
		}
		TradeContract localTradeContract = new TradeContract();
		localTradeContract.setTradeNo(Long.valueOf(Tools.strToLong(str)));
		localTradeContract = (TradeContract) getService().get(localTradeContract);
		getService().getDao().evict(localTradeContract);
		localTradeContract = (TradeContract) getService().get(localTradeContract).clone();
		if (localTradeContract.getTradeType().intValue() == 0) {
			localTradeContract.setBuyButtonMap(getTradeButtonMap(localTradeContract, localTradeContract.getBFirmId()));
			localTradeContract.setSellButtonMap(getTradeButtonMap(localTradeContract, localTradeContract.getSFirmId()));
		} else {
			localTradeContract.setBuyButtonMap(getTradeAutoButtonMap(localTradeContract, localTradeContract.getBFirmId()));
			localTradeContract.setSellButtonMap(getTradeAutoButtonMap(localTradeContract, localTradeContract.getSFirmId()));
			Holding localObject1 = getHoldingByTrade(localTradeContract, localTradeContract.getBFirmId());
			Holding localObject2 = getHoldingByTrade(localTradeContract, localTradeContract.getSFirmId());
			if ((((Holding) localObject1).getHoldingId() != null) && (((Holding) localObject2).getHoldingId() != null)) {
				this.request.setAttribute("holding", localObject1);
				this.request.setAttribute("sellHolding", localObject2);
			}
		}
		Object localObject1 = Calendar.getInstance();
		((Calendar) localObject1).setTime(localTradeContract.getTime());
		((Calendar) localObject1).add(13, localTradeContract.getTradePreTime().intValue());
		this.request.setAttribute("tradePreTime", ((Calendar) localObject1).getTime());
		this.entity = localTradeContract;
		Object localObject2 = new PageRequest(" and primary.trade.tradeNo=" + localTradeContract.getTradeNo() + " order by processTime");
		((PageRequest) localObject2).setPageSize(1000);
		Page localPage = getService().getPage((PageRequest) localObject2, new TradeContractLog());
		this.request.setAttribute("pageInfo", localPage);
		MFirm localMFirm1 = new MFirm();
		localMFirm1.setFirmId(localTradeContract.getBFirmId());
		localMFirm1 = (MFirm) getService().get(localMFirm1);
		MFirm localMFirm2 = new MFirm();
		localMFirm2.setFirmId(localTradeContract.getSFirmId());
		localMFirm2 = (MFirm) getService().get(localMFirm2);
		this.request.setAttribute("bfirm", localMFirm1);
		this.request.setAttribute("sfirm", localMFirm2);
		this.request.setAttribute("goodsPropertys", localTradeContract.getTradeGoodsProperties());
		putResourcePropertys(localTradeContract.getTradeGoodsProperties());
		SystemProps localSystemProps = new SystemProps();
		localSystemProps.setPropsKey("PayTimes");
		localSystemProps = (SystemProps) getService().get(localSystemProps);
		this.request.setAttribute("PayTimes", Integer.valueOf(Tools.strToInt(localSystemProps.getRunTimeValue())));
		return "success";
	}

	public String forwardPaymentReserve() throws Exception {
		this.logger.debug("------转入保证金 功能跳转----forwardPaymentReserve---");
		String str = this.request.getParameter("firmId");
		if ((str == null) || ("".equals(str))) {
			addReturnValue(-1, 230002L, new Object[] { "交易商不存在！" });
			return "success";
		}
		this.request.setAttribute("firmId", str);
		TradeContract localTradeContract = isMyTrade(this.entity, str);
		this.entity = localTradeContract;
		if (localTradeContract == null) {
			addReturnValue(-1, 236301L);
		} else {
			boolean bool = appendMagin(localTradeContract, str);
			if (bool) {
				BigDecimal localBigDecimal = getRealGoods(str);
				Reserve localReserve = getReserveByTrade(localTradeContract, str);
				this.request.setAttribute("reserve", localReserve);
				this.request.setAttribute("realFunds", localBigDecimal);
			} else {
				addReturnValue(-1, 236302L);
			}
		}
		return "success";
	}

	public String paymentReserve() throws Exception {
		this.logger.debug("------转入保证金操作 ----paymentReserve---");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		String str1 = this.request.getParameter("firmId");
		if ((str1 == null) || ("".equals(str1))) {
			addReturnValue(-1, 230002L, new Object[] { "交易商不存在！" });
			return "success";
		}
		TradeContract localTradeContract = isMyTrade(this.entity, str1);
		if (localTradeContract == null) {
			addReturnValue(-1, 236301L);
		} else {
			boolean bool = appendMagin(localTradeContract, str1);
			if (bool) {
				String str2 = this.request.getParameter("reserveId");
				BigDecimal localBigDecimal = getRealGoods(str1);
				if ((str2 != null) && (!"".equals(str2)) && (localTradeContract.getTradeNo() != null)) {
					Reserve localReserve = new Reserve();
					localReserve.setReserveId(Long.valueOf(Tools.strToLong(str2)));
					localReserve = (Reserve) getService().get(localReserve);
					if (localBigDecimal.doubleValue() >= localReserve.getPayableReserve().doubleValue()) {
						ResultVO localResultVO = this.processService.paymentReserve(str1, localTradeContract.getTradeNo().longValue(),
								localReserve.getPayableReserve().doubleValue());
						if (localResultVO.getResult() < 0L) {
							addReturnValue(-1, 230003L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
							writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str1 + "执行转入保证金操作，订单号为：" + str2 + "的订单转入保证金", 0,
									localResultVO.getErrorInfo().replace("\n", ""));
						} else if (localResultVO.getResult() == 0L) {
							addReturnValue(-1, 230005L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
							writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str1 + "执行转入保证金操作，订单号为：" + str2 + "的订单转入保证金", 0,
									localResultVO.getErrorInfo().replace("\n", ""));
						} else {
							addReturnValue(1, 236200L);
							writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str1 + "执行转入保证金操作，订单号为：" + str2 + "的订单转入保证金", 1, null);
						}
					} else {
						addReturnValue(-1, 236300L);
						writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str1 + "执行转入保证金操作，订单号为：" + str2 + "的订单转入保证金", 0,
								ApplicationContextInit.getErrorInfo("-6003"));
					}
				}
			} else {
				addReturnValue(-1, 236302L);
				writeOperateLog(2309, "合同号为：" + localTradeContract.getTradeNo() + "的合同操作", 0, ApplicationContextInit.getErrorInfo("-6004"));
			}
		}
		return "success";
	}

	public String forwardTransferGoods() throws Exception {
		this.logger.debug("------转入仓单跳转 ----forwardTransferGoods---");
		String str1 = this.request.getParameter("firmId");
		if ((str1 == null) || ("".equals(str1))) {
			addReturnValue(-1, 230002L, new Object[] { "交易商不存在！" });
			return "success";
		}
		this.request.setAttribute("firmId", str1);
		MFirm localMFirm = new MFirm();
		localMFirm.setFirmId(str1);
		localMFirm = (MFirm) getService().get(localMFirm);
		TradeContract localTradeContract = isMyTrade(this.entity, str1);
		if (localTradeContract == null) {
			addReturnValue(-1, 236301L);
			this.request.setAttribute("allMax", Integer.valueOf(0));
			this.request.setAttribute("allMin", Integer.valueOf(0));
			this.request.setAttribute("quantity", Integer.valueOf(0));
			this.request.setAttribute("min", Integer.valueOf(0));
			this.request.setAttribute("max", Integer.valueOf(0));
		} else {
			this.entity = localTradeContract;
			boolean bool = false;
			if (localTradeContract.getTradeType().intValue() == 0) {
				bool = appendWarehouse(localTradeContract, str1);
			} else {
				bool = appendAutoWarehouse(localTradeContract, str1);
			}
			if (bool) {
				Long localLong = localTradeContract.getBreed().getBreedId();
				PageRequest localPageRequest = getPageRequest(this.request);
				QueryConditions localQueryConditions = (QueryConditions) localPageRequest.getFilters();
				localQueryConditions.addCondition("primary.ownerFirm", "=", str1);
				localQueryConditions.addCondition("primary.stockStatus", "=", Integer.valueOf(1));
				if ((localTradeContract.getWarehouseId() != null) && ("1".equals(localTradeContract.getDeliveryType()))) {
					localQueryConditions.addCondition("primary.warehouseId", "=", localTradeContract.getWarehouseId());
				}
				localQueryConditions.addCondition("primary.breed.breedId", "=", localLong);
				localQueryConditions.addCondition(" ", " ", "0=(select count(c.operationId) from primary.operations as c)");
				Page localPage = getService().getPage(localPageRequest, new Stock());
				List localList1 = localPage.getResult();
				Double localDouble = Double.valueOf(0.0D);
				String str2 = "select t.* from M_CATEGORY t,M_BREED tt where tt.breedid='" + localLong
						+ "' and t.categoryid = tt.categoryid and t.isOffSet='Y'";
				this.logger.debug("sql_offset==========" + str2);
				List localList2 = getService().getDao().queryBySql(str2, new Category());
				if ((localList2 != null) && (localList2.size() > 0) && (localList2.get(0) != null)) {
					localDouble = Double.valueOf(((Category) localList2.get(0)).getOffSetRate().doubleValue());
				}
				double d1 = localTradeContract.getQuantity().doubleValue();
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
				if (localTradeContract.getStatus().intValue() == 3) {
					String localObject1 = "select * from E_Holding where TradeNo='" + localTradeContract.getTradeNo() + "' and FirmID='"
							+ localMFirm.getFirmId() + "'";
					List localObject2 = super.getService().getListBySql((String) localObject1, new Holding());
					if (((List) localObject2).size() == 1) {
						Holding localObject3 = (Holding) ((List) localObject2).get(0);
						d3 = Arith.sub(d3, ((Holding) localObject3).getPayGoodsMoney().doubleValue());
						d4 = Arith.sub(d4, ((Holding) localObject3).getPayGoodsMoney().doubleValue());
						d1 = Arith.sub(d1, ((Holding) localObject3).getPayGoodsMoney().doubleValue());
					}
				} else if (localTradeContract.getStatus().intValue() == 0) {
					String localObject1 = "select * from E_Reserve where TradeNo='" + localTradeContract.getTradeNo() + "' and FirmID='"
							+ localMFirm.getFirmId() + "'";
					List localObject2 = super.getService().getListBySql((String) localObject1, new Reserve());
					if (((List) localObject2).size() == 1) {
						Reserve localObject3 = (Reserve) ((List) localObject2).get(0);
						d3 = Arith.sub(d3, ((Reserve) localObject3).getGoodsQuantity().doubleValue());
						d4 = Arith.sub(d4, ((Reserve) localObject3).getGoodsQuantity().doubleValue());
						d1 = Arith.sub(d1, ((Reserve) localObject3).getGoodsQuantity().doubleValue());
					}
				}
				Object localObject1 = localTradeContract.getTradeGoodsProperties();
				Object localObject2 = new HashMap();
				Object localObject3 = ((Set) localObject1).iterator();
				while (((Iterator) localObject3).hasNext()) {
					TradeGoodsProperty localObject4 = (TradeGoodsProperty) ((Iterator) localObject3).next();
					((Map) localObject2).put(((TradeGoodsProperty) localObject4).getPropertyName(),
							Tools.delNull(((TradeGoodsProperty) localObject4).getPropertyValue()));
				}
				localObject3 = "select * from m_Property p where p.categoryid = (select b.categoryid from m_breed b where b.breedid = (select t.breedid from e_Trade t where t.tradeno='"
						+ localTradeContract.getTradeNo() + "'))";
				this.logger.debug("===sql: " + (String) localObject3);
				Object localObject4 = getService().getListBySql((String) localObject3, new CategoryProperty());
				ArrayList localArrayList2 = new ArrayList();
				HashMap localHashMap1 = new HashMap();
				Iterator localIterator1 = ((List) localObject4).iterator();
				StandardModel localStandardModel;
				Object localObject5;
				while (localIterator1.hasNext()) {
					localStandardModel = (StandardModel) localIterator1.next();
					localObject5 = (CategoryProperty) localStandardModel;
					if ((((CategoryProperty) localObject5).getStockCheck() != null)
							&& ("Y".equals(((CategoryProperty) localObject5).getStockCheck().toString()))) {
						localHashMap1.put(((CategoryProperty) localObject5).getPropertyName(), "Y");
						localArrayList2.add(((CategoryProperty) localObject5).getPropertyName());
					} else if ((((CategoryProperty) localObject5).getStockCheck() != null)
							&& ("M".equals(((CategoryProperty) localObject5).getStockCheck().toString()))) {
						localHashMap1.put(((CategoryProperty) localObject5).getPropertyName(), "M");
						localArrayList2.add(((CategoryProperty) localObject5).getPropertyName());
					}
				}
				this.logger.debug("========  offset:  " + localDouble);
				localIterator1 = localList1.iterator();
				while (localIterator1.hasNext()) {
					localStandardModel = (StandardModel) localIterator1.next();
					localObject5 = (Stock) localStandardModel;
					if (((Stock) localObject5).getQuantity().doubleValue() <= Arith.format(d3, 2)) {
						Set localSet = ((Stock) localObject5).getGoodsProperties();
						HashMap localHashMap2 = new HashMap();
						Iterator localIterator2 = localSet.iterator();
						while (localIterator2.hasNext()) {
							StockGoodsProperty localObject6 = (StockGoodsProperty) localIterator2.next();
							localHashMap2.put(((StockGoodsProperty) localObject6).getPropertyName(),
									Tools.delNull(((StockGoodsProperty) localObject6).getPropertyValue()));
						}
						int i = 1;
						Object localObject6 = localArrayList2.iterator();
						while (((Iterator) localObject6).hasNext()) {
							String str3 = (String) ((Iterator) localObject6).next();
							if (((localHashMap2.get(str3) == null)
									&& (((Map) localObject2)
											.get(str3) != null))
									|| ((localHashMap2.get(str3) != null) && (((Map) localObject2).get(str3) == null))
									|| ((localHashMap2.get(str3) != null) && (((Map) localObject2).get(str3) != null)
											&& ((("Y".equals(localHashMap1.get(str3)))
													&& (!((String) localHashMap2.get(str3)).equals(((Map) localObject2).get(str3))))
													|| (("M".equals(localHashMap1.get(str3)))
															&& (!("|" + (String) ((Map) localObject2).get(str3) + "|")
																	.contains("|" + (String) localHashMap2.get(str3) + "|")))))) {
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
				this.request.setAttribute("oldParams", getParametersStartingWith(this.request, "gnnt_"));
			} else {
				addReturnValue(-1, 236303L);
				this.request.setAttribute("allMax", Integer.valueOf(0));
				this.request.setAttribute("allMin", Integer.valueOf(0));
				this.request.setAttribute("quantity", Integer.valueOf(0));
				this.request.setAttribute("min", Integer.valueOf(0));
				this.request.setAttribute("max", Integer.valueOf(0));
			}
		}
		return "success";
	}

	public String transferGoods() {
		this.logger.debug("------转入仓单操作 ----transferGoods---");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		String str1 = this.request.getParameter("firmId");
		if ((str1 == null) || ("".equals(str1))) {
			addReturnValue(-1, 230002L, new Object[] { "交易商不存在！" });
			return "success";
		}
		TradeContract localTradeContract = isMyTrade(this.entity, str1);
		if (localTradeContract == null) {
			addReturnValue(-1, 236301L);
		} else {
			String[] arrayOfString = this.request.getParameterValues("cks");
			String str2 = this.request.getParameter("isLast");
			this.logger.debug("============================= isLast:" + str2);
			boolean bool = false;
			if (localTradeContract.getTradeType().intValue() == 0) {
				bool = appendWarehouse(localTradeContract, str1);
			} else {
				bool = appendAutoWarehouse(localTradeContract, str1);
			}
			if (bool) {
				ResultVO localResultVO = new ResultVO();
				localResultVO.setResult(1L);
				Object localObject;
				if (localTradeContract.getStatus().intValue() == 0) {
					localObject = getReserveByTrade(localTradeContract, str1);
					localResultVO = this.wareHouseStockService.transferGoodsForReserve(((Reserve) localObject).getReserveId().longValue(),
							arrayOfString, Boolean.valueOf(str2).booleanValue());
				} else if (localTradeContract.getStatus().intValue() == 3) {
					localObject = getHoldingByTrade(localTradeContract, str1);
					localResultVO = this.wareHouseStockService.transferGoodsForTrade(((Holding) localObject).getHoldingId().longValue(),
							arrayOfString, Boolean.valueOf(str2).booleanValue());
				}
				if (localResultVO.getResult() < 0L) {
					addReturnValue(-1, 230003L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str1 + "为合同" + localTradeContract.getTradeNo() + "转入仓单", 0,
							localResultVO.getErrorInfo().replace("\n", ""));
				} else if (localResultVO.getResult() == 0L) {
					addReturnValue(-1, 230005L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str1 + "为合同" + localTradeContract.getTradeNo() + "转入仓单", 0,
							localResultVO.getErrorInfo().replace("\n", ""));
				} else {
					addReturnValue(1, 236201L);
					writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str1 + "为合同" + localTradeContract.getTradeNo() + "转入仓单", 1,
							null);
				}
			} else {
				addReturnValue(-1, 236303L);
				writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str1 + "为合同号为：" + localTradeContract.getTradeNo() + "的合同操作", 0,
						ApplicationContextInit.getErrorInfo("-6005"));
			}
		}
		return "success";
	}

	public String forwardPaymentGoodsMoney() throws Exception {
		this.logger.debug("---转入货款跳转---------forwardPaymentGoodsMoney---------");
		String str = this.request.getParameter("firmId");
		if ((str == null) || ("".equals(str))) {
			addReturnValue(-1, 230002L, new Object[] { "交易商不存在！" });
			return "success";
		}
		this.request.setAttribute("firmId", str);
		TradeContract localTradeContract = isMyTrade(this.entity, str);
		if (localTradeContract == null) {
			addReturnValue(-1, 236301L);
		} else {
			boolean bool = false;
			if (localTradeContract.getTradeType().intValue() == 0) {
				bool = appendGoods(localTradeContract, str);
			} else {
				bool = appendAutoGoods(localTradeContract, str);
			}
			if (bool) {
				double d1 = Arith.format(Arith.mul(localTradeContract.getQuantity().doubleValue(), localTradeContract.getPrice().doubleValue()), 2);
				this.entity = localTradeContract;
				Set localSet = localTradeContract.getBelongToHolding();
				Iterator localIterator = localSet.iterator();
				while (localIterator.hasNext()) {
					Holding localHolding = (Holding) localIterator.next();
					if (localHolding.getFirmId().equals(str)) {
						this.request.setAttribute("PayMargin", localHolding.getPayMargin());
					}
				}
				double d2 = localTradeContract.getBuyTradeFee().doubleValue();
				double d3 = localTradeContract.getBuyDeliveryFee().doubleValue();
				BigDecimal localBigDecimal = getRealGoods(str);
				this.request.setAttribute("tradeFeeMoney", Double.valueOf(d2));
				this.request.setAttribute("deliveryFeeMoney", Double.valueOf(d3));
				this.request.setAttribute("realFunds", localBigDecimal);
				this.request.setAttribute("goods", Double.valueOf(d1));
				this.request.setAttribute("deliveryDay", localTradeContract.getDeliveryDay());
			} else {
				addReturnValue(-1, 236304L);
			}
		}
		return "success";
	}

	public String paymentGoodsMoney() {
		this.logger.debug("---转入货款操作---------paymentGoodsMoney---------");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		String str = this.request.getParameter("firmId");
		if ((str == null) || ("".equals(str))) {
			addReturnValue(-1, 230002L, new Object[] { "交易商不存在！" });
			return "success";
		}
		TradeContract localTradeContract = isMyTrade(this.entity, str);
		if (localTradeContract == null) {
			addReturnValue(-1, 236301L);
		} else {
			boolean bool = false;
			if (localTradeContract.getTradeType().intValue() == 0) {
				bool = appendGoods(localTradeContract, str);
			} else {
				bool = appendAutoGoods(localTradeContract, str);
			}
			if (bool) {
				Holding localHolding = getHoldingByTrade(localTradeContract, str);
				ResultVO localResultVO = this.processService.paymentGoodsMoney(localHolding.getHoldingId().longValue());
				if (localResultVO.getResult() < 0L) {
					addReturnValue(-1, 230003L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "为合同" + localTradeContract.getTradeNo() + "转入贷款", 0,
							localResultVO.getErrorInfo().replace("\n", ""));
				} else if (localResultVO.getResult() == 0L) {
					addReturnValue(-1, 230005L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "为合同" + localTradeContract.getTradeNo() + "转入贷款", 0,
							localResultVO.getErrorInfo().replace("\n", ""));
				} else {
					addReturnValue(1, 236202L);
					writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "为合同" + localTradeContract.getTradeNo() + "转入贷款", 1, null);
				}
			} else {
				addReturnValue(-1, 236304L);
				writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "为合同号为：" + localTradeContract.getTradeNo() + "的合同操作", 0,
						ApplicationContextInit.getErrorInfo("-6007"));
			}
		}
		return "success";
	}

	public String withdrawTrade() throws Exception {
		this.logger.debug("------关闭交易操作  ----withdrawTrade---");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		String str = this.request.getParameter("firmId");
		if ((str == null) || ("".equals(str))) {
			addReturnValue(-1, 230002L, new Object[] { "交易商不存在！" });
			return "success";
		}
		TradeContract localTradeContract = isMyTrade(this.entity, str);
		if (localTradeContract == null) {
			addReturnValue(-1, 236301L);
		} else {
			boolean bool = closeTrade(localTradeContract, str);
			if (bool) {
				ResultVO localResultVO = new ResultVO();
				Object localObject;
				if (localTradeContract.getStatus().intValue() == 0) {
					localObject = getReserveByTrade(localTradeContract, str);
					localResultVO = this.reserveProcessService.withdrawReserve(((Reserve) localObject).getReserveId().longValue(), str);
				} else if (localTradeContract.getStatus().intValue() == 3) {
					localObject = getHoldingByTrade(localTradeContract, str);
					localResultVO = this.tradeProcessService.withdrawTrade(((Holding) localObject).getHoldingId().longValue(), str);
				}
				if (localResultVO.getResult() < 0L) {
					addReturnValue(-1, 230003L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "为合同" + localTradeContract.getTradeNo() + "关闭交易", 0,
							localResultVO.getErrorInfo().replace("\n", ""));
				} else if (localResultVO.getResult() == 0L) {
					addReturnValue(-1, 230005L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "为合同" + localTradeContract.getTradeNo() + "关闭交易", 0,
							localResultVO.getErrorInfo().replace("\n", ""));
				} else {
					addReturnValue(1, 236203L);
					writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "为合同" + localTradeContract.getTradeNo() + "关闭交易", 1, null);
				}
			} else {
				addReturnValue(-1, 236305L);
				writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "为合同号为：" + localTradeContract.getTradeNo() + "的合同操作", 0,
						ApplicationContextInit.getErrorInfo("-6006"));
			}
		}
		return "success";
	}

	public String forwardPerformAskOffset() {
		this.logger.debug("-----申请溢短货款跳转----------forwardPerformAskOffset-----");
		String str = this.request.getParameter("firmId");
		if ((str == null) || ("".equals(str))) {
			addReturnValue(-1, 230002L, new Object[] { "交易商不存在！" });
			return "success";
		}
		this.request.setAttribute("firmId", str);
		TradeContract localTradeContract = isMyTrade(this.entity, str);
		if (localTradeContract == null) {
			addReturnValue(-1, 236301L);
		} else {
			boolean bool = offSetApply(localTradeContract, str);
			if (bool) {
				this.entity = localTradeContract;
				Holding localHolding = null;
				localHolding = getHoldingByTrade(localTradeContract, localTradeContract.getBFirmId());
				if (localHolding != null) {
					double d1 = Arith.format(localTradeContract.getPrice().doubleValue() * localTradeContract.getQuantity().doubleValue()
							* localTradeContract.getBreed().getCategory().getOffSetRate().doubleValue(), 2);
					double d2 = Arith.format(localHolding.getPayGoodsMoney().doubleValue() - localHolding.getPayOff().doubleValue()
							- localHolding.getTransferMoney().doubleValue(), 2);
					if (!localTradeContract.getBFirmId().equals(str)) {
						this.request.setAttribute("offSetMax", Double.valueOf(d1));
					} else if (Arith.sub(d1, d2) >= 0.0D) {
						this.request.setAttribute("offSetMax", Double.valueOf(d2));
					} else {
						this.request.setAttribute("offSetMax", Double.valueOf(d1));
					}
				}
			} else {
				addReturnValue(-1, 236306L);
			}
		}
		return "success";
	}

	public String performAskOffset() {
		this.logger.debug("----溢短货款申请操作-----------performAskOffset-----------");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		String str1 = this.request.getParameter("firmId");
		if ((str1 == null) || ("".equals(str1))) {
			addReturnValue(-1, 230002L, new Object[] { "交易商不存在！" });
			return "success";
		}
		TradeContract localTradeContract = isMyTrade(this.entity, str1);
		if (localTradeContract == null) {
			addReturnValue(-1, 236301L);
		} else {
			boolean bool = offSetApply(localTradeContract, str1);
			if (bool) {
				String str2 = this.request.getParameter("money");
				Holding localHolding = getHoldingByTrade(localTradeContract, str1);
				ResultVO localResultVO = this.tradeProcessService.performAskOffset(localHolding.getHoldingId().longValue(), Double.parseDouble(str2));
				if (localResultVO.getResult() < 0L) {
					addReturnValue(-1, 230003L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str1 + "为合同" + localTradeContract.getTradeNo() + "溢短货款申请", 0,
							localResultVO.getErrorInfo().replace("\n", ""));
				} else if (localResultVO.getResult() == 0L) {
					addReturnValue(-1, 230005L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str1 + "为合同" + localTradeContract.getTradeNo() + "溢短货款申请", 0,
							localResultVO.getErrorInfo().replace("\n", ""));
				} else {
					addReturnValue(1, 236204L);
					writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str1 + "为合同" + localTradeContract.getTradeNo() + "溢短货款申请", 1,
							null);
				}
			} else {
				addReturnValue(-1, 236306L);
				writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str1 + "为合同号为：" + localTradeContract.getTradeNo() + "的合同操作", 0,
						ApplicationContextInit.getErrorInfo("-6008"));
			}
		}
		return "success";
	}

	public String performWithdrawOffset() {
		this.logger.debug("----撤销溢短货款操作--performWithdrawOffset---");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		String str = this.request.getParameter("firmId");
		if ((str == null) || ("".equals(str))) {
			addReturnValue(-1, 230002L, new Object[] { "交易商不存在！" });
			return "success";
		}
		TradeContract localTradeContract = isMyTrade(this.entity, str);
		if (localTradeContract == null) {
			addReturnValue(-1, 236301L);
		} else {
			boolean bool = revocationOffSetApply(localTradeContract, str);
			if (bool) {
				Holding localHolding = getHoldingByTrade(localTradeContract, str);
				ResultVO localResultVO = this.tradeProcessService.performWithdrawOffset(localHolding.getHoldingId().longValue());
				if (localResultVO.getResult() < 0L) {
					addReturnValue(-1, 230003L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "为合同" + localTradeContract.getTradeNo() + "撤销溢短贷款", 0,
							localResultVO.getErrorInfo().replace("\n", ""));
				} else if (localResultVO.getResult() == 0L) {
					addReturnValue(-1, 230005L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "为合同" + localTradeContract.getTradeNo() + "撤销溢短贷款", 0,
							localResultVO.getErrorInfo().replace("\n", ""));
				} else {
					addReturnValue(1, 236205L);
					writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "为合同" + localTradeContract.getTradeNo() + "撤销溢短贷款", 1,
							null);
				}
			} else {
				addReturnValue(-1, 236307L);
				writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "为合同号为：" + localTradeContract.getTradeNo() + "的合同操作", 0,
						ApplicationContextInit.getErrorInfo("-6008"));
			}
		}
		return "success";
	}

	public String forwardPerformDisposeOffset() {
		this.logger.debug("-----处理溢短货款跳转---------forwardPerformDisposeOffset---------");
		String str1 = this.request.getParameter("firmId");
		if ((str1 == null) || ("".equals(str1))) {
			addReturnValue(-1, 230002L, new Object[] { "交易商不存在！" });
			return "success";
		}
		this.request.setAttribute("firmId", str1);
		TradeContract localTradeContract = isMyTrade(this.entity, str1);
		if (localTradeContract == null) {
			addReturnValue(-1, 236301L);
		} else {
			boolean bool = disposeOffSetApply(localTradeContract, str1);
			if (bool) {
				String str2 = getOtherFirmId(localTradeContract, str1);
				Holding localHolding = getHoldingByTrade(localTradeContract, str2);
				OffSetApply localOffSetApply = new OffSetApply();
				localOffSetApply.setOffSetId(Long.valueOf(Tools.strToLong(localHolding.getOffSetId() + "")));
				localOffSetApply = (OffSetApply) getService().get(localOffSetApply);
				this.entity = localTradeContract;
				this.request.setAttribute("offSet", localOffSetApply);
			} else {
				addReturnValue(-1, 236308L);
			}
		}
		return "success";
	}

	public String performDisposeOffset() {
		this.logger.debug("-----处理溢短货款操作---------performDisposeOffset---------");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		String str = this.request.getParameter("firmId");
		if ((str == null) || ("".equals(str))) {
			addReturnValue(-1, 230002L, new Object[] { "交易商不存在！" });
			return "success";
		}
		TradeContract localTradeContract = isMyTrade(this.entity, str);
		if (localTradeContract == null) {
			addReturnValue(-1, 236301L);
			writeOperateLog(2309, "处理溢短贷款", 0, ApplicationContextInit.getErrorInfo("-6016"));
		} else {
			boolean bool = disposeOffSetApply(localTradeContract, str);
			if (bool) {
				Holding localHolding = getHoldingByTrade(localTradeContract, str);
				ResultVO localResultVO = this.tradeProcessService.performDisposeOffset(localHolding.getHoldingId().longValue());
				if (localResultVO.getResult() < 0L) {
					addReturnValue(-1, 230003L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "为合同" + localTradeContract.getTradeNo() + "处理溢短贷款", 0,
							localResultVO.getErrorInfo().replace("\n", ""));
				} else if (localResultVO.getResult() == 0L) {
					addReturnValue(-1, 230005L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "为合同" + localTradeContract.getTradeNo() + "处理溢短贷款", 0,
							localResultVO.getErrorInfo().replace("\n", ""));
				} else {
					addReturnValue(1, 236206L);
					writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "为合同" + localTradeContract.getTradeNo() + "处理溢短贷款", 1,
							null);
				}
			} else {
				addReturnValue(-1, 236308L);
				writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "为合同号为：" + localTradeContract.getTradeNo() + "的合同操作", 0,
						ApplicationContextInit.getErrorInfo("-6010"));
			}
		}
		return "success";
	}

	public String noOffSetApply() {
		this.logger.debug("----- 卖方确认无溢短货款申请 ----- noOffSetApply -----");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		String str = this.request.getParameter("firmId");
		if ((str == null) || ("".equals(str))) {
			addReturnValue(-1, 230002L, new Object[] { "交易商不存在！" });
			return "success";
		}
		TradeContract localTradeContract = isMyTrade(this.entity, str);
		if (localTradeContract == null) {
			addReturnValue(-1, 236301L);
		} else {
			boolean bool = noOffSetApply(localTradeContract, str);
			if (bool) {
				Holding localHolding = getHoldingByTrade(localTradeContract, str);
				ResultVO localResultVO = this.tradeProcessService.performWithoutOffset(localHolding.getHoldingId().longValue());
				if (localResultVO.getResult() < 0L) {
					addReturnValue(-1, 230003L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "为合同" + localTradeContract + "卖方确认无溢短货款申请", 0,
							localResultVO.getErrorInfo().replace("\n", ""));
				} else if (localResultVO.getResult() == 0L) {
					addReturnValue(-1, 230005L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "为合同" + localTradeContract.getTradeNo() + "卖方确认无溢短货款申请", 0,
							localResultVO.getErrorInfo().replace("\n", ""));
				} else {
					addReturnValue(1, 236207L);
					writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "为合同" + localTradeContract.getTradeNo() + "卖方确认无溢短货款申请", 1,
							null);
				}
			} else {
				addReturnValue(-1, 236309L);
				writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "为合同号为：" + localTradeContract.getTradeNo() + "的合同操作", 0,
						ApplicationContextInit.getErrorInfo("-6010"));
			}
		}
		return "success";
	}

	public String forwardPaymentMoneyToSell() throws Exception {
		this.logger.debug("-----支付首款跳转---------forwardPaymentMoneyToSell---------");
		String str = this.request.getParameter("firmId");
		if ((str == null) || ("".equals(str))) {
			addReturnValue(-1, 230002L, new Object[] { "交易商不存在！" });
			return "success";
		}
		this.request.setAttribute("firmId", str);
		TradeContract localTradeContract = isMyTrade(this.entity, str);
		if (localTradeContract == null) {
			addReturnValue(-1, 236301L);
		} else {
			boolean bool = payFirstGoods(localTradeContract, str);
			if (bool) {
				PageRequest localPageRequest = new PageRequest(
						" and primary.tradeContract.tradeNo=" + localTradeContract.getTradeNo() + " and primary.bSFlag='B'");
				Page localPage = getService().getPage(localPageRequest, new Holding());
				Holding localHolding = new Holding();
				if ((localPage.getResult() != null) && (localPage.getResult().size() > 0)) {
					localHolding = (Holding) localPage.getResult().get(0);
				}
				double d1 = Arith.format(localHolding.getPayGoodsMoney().doubleValue() - localHolding.getTransferMoney().doubleValue(), 2);
				SystemProps localSystemProps = new SystemProps();
				localSystemProps.setPropsKey("FirstPaymentRate");
				localSystemProps = (SystemProps) getService().get(localSystemProps);
				double d2 = Tools.strToDouble(localSystemProps.getRunTimeValue(), 0.0D);
				this.request.setAttribute("payAllGoods", Double.valueOf(d1));
				this.request.setAttribute("payFirstGoods", Double.valueOf(Arith
						.format(Arith.mul(localTradeContract.getQuantity().doubleValue() * localTradeContract.getPrice().doubleValue(), d2), 2)));
			}
		}
		return "success";
	}

	public String paymentMoneyToSell() {
		this.logger.debug("-----支付首款操作---------paymentMoneyToSell---------");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		String str = this.request.getParameter("firmId");
		if ((str == null) || ("".equals(str))) {
			addReturnValue(-1, 230002L, new Object[] { "交易商不存在！" });
			return "success";
		}
		TradeContract localTradeContract = isMyTrade(this.entity, str);
		if (localTradeContract == null) {
			addReturnValue(-1, 236301L);
		} else {
			boolean bool = payFirstGoods(localTradeContract, str);
			if (bool) {
				Holding localHolding = getHoldingByTrade(localTradeContract, str);
				SystemProps localSystemProps = new SystemProps();
				localSystemProps.setPropsKey("FirstPaymentRate");
				localSystemProps = (SystemProps) getService().get(localSystemProps);
				ResultVO localResultVO = this.processService.paymentFirstMoneyToSell(localHolding.getHoldingId().longValue(),
						Tools.strToDouble(localSystemProps.getRunTimeValue(), 0.0D));
				if (localResultVO.getResult() < 0L) {
					addReturnValue(-1, 230003L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "为合同" + localTradeContract.getTradeNo() + "支付首款", 0,
							localResultVO.getErrorInfo().replace("\n", ""));
				} else if (localResultVO.getResult() == 0L) {
					addReturnValue(-1, 230005L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "为合同" + localTradeContract.getTradeNo() + "支付首款", 0,
							localResultVO.getErrorInfo().replace("\n", ""));
				} else {
					addReturnValue(1, 236208L);
					writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "为合同" + localTradeContract.getTradeNo() + "支付首款", 1, null);
				}
			} else {
				addReturnValue(-1, 236310L);
				writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "为合同号为：" + localTradeContract.getTradeNo() + "的合同操作", 0,
						ApplicationContextInit.getErrorInfo("-6011"));
			}
		}
		return "success";
	}

	public String forwardSecondPaymentMoneyToSell() {
		this.logger.debug("-----支付二次货款跳转---------forwardSecondPaymentMoneyToSell---------");
		String str = this.request.getParameter("firmId");
		if ((str == null) || ("".equals(str))) {
			addReturnValue(-1, 230002L, new Object[] { "交易商不存在！" });
			return "success";
		}
		this.request.setAttribute("firmId", str);
		TradeContract localTradeContract = isMyTrade(this.entity, str);
		if (localTradeContract == null) {
			addReturnValue(-1, 236301L);
		} else {
			boolean bool = paySecondGoods(localTradeContract, str);
			if (bool) {
				PageRequest localPageRequest = new PageRequest(
						" and primary.tradeContract.tradeNo=" + localTradeContract.getTradeNo() + " and primary.bSFlag='B'");
				Page localPage = getService().getPage(localPageRequest, new Holding());
				Holding localHolding = new Holding();
				if ((localPage.getResult() != null) && (localPage.getResult().size() > 0)) {
					localHolding = (Holding) localPage.getResult().get(0);
				}
				double d1 = Arith.format(localHolding.getPayGoodsMoney().doubleValue() - localHolding.getTransferMoney().doubleValue(), 2);
				double d2 = 0.0D;
				OffSetApply localOffSetApply = new OffSetApply();
				localOffSetApply.setOffSetId(Long.valueOf(localHolding.getOffSetId().longValue()));
				localOffSetApply = (OffSetApply) getService().get(localOffSetApply);
				SystemProps localSystemProps1 = new SystemProps();
				localSystemProps1.setPropsKey("SecondPaymentRate");
				localSystemProps1 = (SystemProps) getService().get(localSystemProps1);
				double d3 = Tools.strToDouble(localSystemProps1.getRunTimeValue(), 0.0D);
				SystemProps localSystemProps2 = new SystemProps();
				localSystemProps2.setPropsKey("FirstPaymentRate");
				localSystemProps2 = (SystemProps) getService().get(localSystemProps2);
				double d4 = Tools.strToDouble(localSystemProps2.getRunTimeValue(), 0.0D);
				double d5 = Arith.format(Arith.mul(localTradeContract.getPrice().doubleValue() * localTradeContract.getQuantity().doubleValue(), d3),
						2);
				if (localOffSetApply != null) {
					if (localOffSetApply.getFirm().getFirmId().equals(str)) {
						double d6 = localOffSetApply.getOffSet().doubleValue();
						if (Arith.sub(d6, d5) >= 0.0D) {
							d2 = 0.0D;
							this.request.setAttribute("pay", "Y");
						} else {
							d2 = Arith.sub(d5, d6);
							this.request.setAttribute("pay", "N");
						}
					} else {
						d2 = d5;
					}
				} else {
					d2 = d5;
				}
				this.request.setAttribute("payMoney", Double.valueOf(d2));
				this.request.setAttribute("payAllGoods", Double.valueOf(d1));
				this.request.setAttribute("paySecondGoods", Double.valueOf(Arith
						.format(Arith.mul(localTradeContract.getPrice().doubleValue() * localTradeContract.getQuantity().doubleValue(), d3), 2)));
				this.request.setAttribute("payFirstGoods", Double.valueOf(Arith
						.format(Arith.mul(localTradeContract.getPrice().doubleValue() * localTradeContract.getQuantity().doubleValue(), d4), 2)));
			} else {
				addReturnValue(-1, 236311L);
			}
		}
		return "success";
	}

	public String paySecondGoods() {
		this.logger.debug("----- 支付二次货款操作 ----- paySecondGoods -----");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		String str = this.request.getParameter("firmId");
		if ((str == null) || ("".equals(str))) {
			addReturnValue(-1, 230002L, new Object[] { "交易商不存在！" });
			return "success";
		}
		TradeContract localTradeContract = isMyTrade(this.entity, str);
		if (localTradeContract == null) {
			addReturnValue(-1, 236301L);
		} else {
			boolean bool = paySecondGoods(localTradeContract, str);
			if (bool) {
				Holding localHolding = getHoldingByTrade(localTradeContract, str);
				SystemProps localSystemProps = new SystemProps();
				localSystemProps.setPropsKey("SecondPaymentRate");
				localSystemProps = (SystemProps) getService().get(localSystemProps);
				ResultVO localResultVO = this.processService.paymentSecondMoneyToSell(localHolding.getHoldingId().longValue(),
						Tools.strToDouble(localSystemProps.getRunTimeValue(), 0.0D));
				if (localResultVO.getResult() < 0L) {
					addReturnValue(-1, 230003L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "为合同" + localTradeContract.getTradeNo() + "支付二次货款", 0,
							localResultVO.getErrorInfo().replace("\n", ""));
				} else if (localResultVO.getResult() == 0L) {
					addReturnValue(-1, 230005L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "为合同" + localTradeContract.getTradeNo() + "支付二次货款", 0,
							localResultVO.getErrorInfo().replace("\n", ""));
				} else {
					addReturnValue(1, 236209L);
					writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "为合同" + localTradeContract.getTradeNo() + "支付二次货款", 1,
							null);
				}
			} else {
				addReturnValue(-1, 236311L);
				writeOperateLog(2309, "合同号为：" + localTradeContract.getTradeNo() + "的合同操作", 0, ApplicationContextInit.getErrorInfo("-6011"));
			}
		}
		return "success";
	}

	public String lastGoodsMoneyApply() {
		this.logger.debug("----- 货款申请 ----- lastMoneyPage -----");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		String str = this.request.getParameter("firmId");
		if ((str == null) || ("".equals(str))) {
			addReturnValue(-1, 230002L, new Object[] { "交易商不存在！" });
			return "success";
		}
		TradeContract localTradeContract = isMyTrade(this.entity, str);
		if (localTradeContract == null) {
			addReturnValue(-1, 236301L);
		} else {
			boolean bool = lastGoodsMoneyApply(localTradeContract, str);
			if (bool) {
				ResultVO localResultVO = this.tradeProcessService.performAskGoodsMoney(localTradeContract.getTradeNo().longValue());
				if (localResultVO.getResult() < 0L) {
					addReturnValue(-1, 230003L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "为合同" + localTradeContract.getTradeNo() + "货款申请", 0,
							localResultVO.getErrorInfo().replace("\n", ""));
				} else if (localResultVO.getResult() == 0L) {
					addReturnValue(-1, 230005L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "为合同" + localTradeContract.getTradeNo() + "货款申请", 0,
							localResultVO.getErrorInfo().replace("\n", ""));
				} else {
					addReturnValue(1, 236210L);
					writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "为合同" + localTradeContract.getTradeNo() + "货款申请", 1, null);
				}
			} else {
				addReturnValue(-1, 236312L);
				writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "为合同号为：" + localTradeContract.getTradeNo() + "的合同操作", 0,
						ApplicationContextInit.getErrorInfo("-6018"));
			}
		}
		return "success";
	}

	public String withdrawLastGoodsMoneyApply() {
		this.logger.debug("----- 撤销货款申请 ----- withdrawLastGoodsMoneyApply -----");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		String str = this.request.getParameter("firmId");
		if ((str == null) || ("".equals(str))) {
			addReturnValue(-1, 230002L, new Object[] { "交易商不存在！" });
			return "success";
		}
		TradeContract localTradeContract = isMyTrade(this.entity, str);
		if (localTradeContract == null) {
			addReturnValue(-1, 236301L);
		} else {
			boolean bool = disposelastGoodsMoney(localTradeContract, str);
			if (bool) {
				ResultVO localResultVO = this.tradeProcessService.performWithdrawGoodsMoney(localTradeContract.getTradeNo().longValue(), str);
				if (localResultVO.getResult() < 0L) {
					addReturnValue(-1, 230003L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "为合同" + localTradeContract.getTradeNo() + "撤销货款申请", 0,
							localResultVO.getErrorInfo().replace("\n", ""));
				} else if (localResultVO.getResult() == 0L) {
					addReturnValue(-1, 230005L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "为合同" + localTradeContract.getTradeNo() + "撤销货款申请", 0,
							localResultVO.getErrorInfo().replace("\n", ""));
				} else {
					addReturnValue(1, 236211L);
					writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "为合同" + localTradeContract.getTradeNo() + "撤销货款申请", 1,
							null);
				}
			} else {
				addReturnValue(-1, 236313L);
				writeOperateLog(2309, "合同号为：" + localTradeContract.getTradeNo() + "的合同操作", 0, ApplicationContextInit.getErrorInfo("-6019"));
			}
		}
		return "success";
	}

	public String forwardPaymentBalanceToSell() throws Exception {
		this.logger.debug("-----支付尾款跳转---------forwardPaymentBalanceToSell---------");
		String str = this.request.getParameter("firmId");
		if ((str == null) || ("".equals(str))) {
			addReturnValue(-1, 230002L, new Object[] { "交易商不存在！" });
			return "success";
		}
		this.request.setAttribute("firmId", str);
		TradeContract localTradeContract = isMyTrade(this.entity, str);
		if (localTradeContract == null) {
			addReturnValue(-1, 236301L);
		} else {
			boolean bool = payLeastGoods(localTradeContract, str);
			if (bool) {
				PageRequest localPageRequest = new PageRequest(
						" and primary.tradeContract.tradeNo=" + localTradeContract.getTradeNo() + " and primary.bSFlag='B'");
				Page localPage = getService().getPage(localPageRequest, new Holding());
				Holding localHolding = new Holding();
				if ((localPage.getResult() != null) && (localPage.getResult().size() > 0)) {
					localHolding = (Holding) localPage.getResult().get(0);
				}
				double d1 = Arith.format(localHolding.getPayGoodsMoney().doubleValue() - localHolding.getTransferMoney().doubleValue(), 2);
				double d2 = localHolding.getPayGoodsMoney().doubleValue() - localHolding.getTransferMoney().doubleValue()
						- localHolding.getPayOff().doubleValue();
				this.request.setAttribute("payAllGoods", Double.valueOf(d1));
				this.request.setAttribute("payLeastGoods", Double.valueOf(Arith.format(d2, 2)));
			}
		}
		return "success";
	}

	public String paymentBalanceToSell() {
		this.logger.debug("-----支付尾款操作---------paymentBalanceToSell---------");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		String str = this.request.getParameter("firmId");
		if ((str == null) || ("".equals(str))) {
			addReturnValue(-1, 230002L, new Object[] { "交易商不存在！" });
			return "success";
		}
		TradeContract localTradeContract = isMyTrade(this.entity, str);
		if (localTradeContract == null) {
			addReturnValue(-1, 236301L);
		} else {
			boolean bool = payLeastGoods(localTradeContract, str);
			if (bool) {
				Holding localHolding = getHoldingByTrade(localTradeContract, str);
				ResultVO localResultVO = this.processService.paymentBalanceToSell(localHolding.getHoldingId().longValue());
				if (localResultVO.getResult() < 0L) {
					addReturnValue(-1, 230003L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "为合同" + localTradeContract.getTradeNo() + "支付尾款", 0,
							localResultVO.getErrorInfo().replace("\n", ""));
				} else if (localResultVO.getResult() == 0L) {
					addReturnValue(-1, 230005L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "为合同" + localTradeContract.getTradeNo() + "支付尾款", 0,
							localResultVO.getErrorInfo().replace("\n", ""));
				} else {
					addReturnValue(1, 236212L);
					writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "为合同" + localTradeContract.getTradeNo() + "支付尾款", 1, null);
				}
			} else {
				addReturnValue(-1, 236314L);
				writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "为合同号为：" + localTradeContract.getTradeNo() + "的合同操作", 0,
						ApplicationContextInit.getErrorInfo("-6012"));
			}
		}
		return "success";
	}

	public String performBreachAsk() throws Exception {
		this.logger.debug("--违约申请操作----------performBreachAsk----------");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		String str = this.request.getParameter("firmId");
		if ((str == null) || ("".equals(str))) {
			addReturnValue(-1, 230002L, new Object[] { "交易商不存在！" });
			return "success";
		}
		TradeContract localTradeContract = isMyTrade(this.entity, str);
		if (localTradeContract == null) {
			addReturnValue(-1, 236301L);
		} else {
			boolean bool = false;
			if (localTradeContract.getTradeType().intValue() == 0) {
				bool = breachApply(localTradeContract, str);
			} else {
				bool = breachAutoApply(localTradeContract, str);
			}
			if (bool) {
				ResultVO localResultVO = new ResultVO();
				Object localObject;
				if (localTradeContract.getStatus().intValue() == 0) {
					localObject = getReserveByTrade(localTradeContract, str);
					localResultVO = this.reserveProcessService.performBreachAsk(((Reserve) localObject).getReserveId().longValue());
				} else if (localTradeContract.getStatus().intValue() == 3) {
					localObject = getHoldingByTrade(localTradeContract, str);
					localResultVO = this.tradeProcessService.performBreachAsk(((Holding) localObject).getHoldingId().longValue());
				}
				if (localResultVO.getResult() < 0L) {
					addReturnValue(-1, 230003L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "为合同" + localTradeContract.getTradeNo() + "申请违约", 0,
							localResultVO.getErrorInfo().replace("\n", ""));
				} else if (localResultVO.getResult() == 0L) {
					addReturnValue(-1, 230005L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "为合同" + localTradeContract.getTradeNo() + "申请违约", 0,
							localResultVO.getErrorInfo().replace("\n", ""));
				} else {
					addReturnValue(1, 236213L);
					writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "为合同" + localTradeContract.getTradeNo() + "申请违约", 1, null);
				}
			} else {
				addReturnValue(-1, 236315L);
				writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "为合同号为：" + localTradeContract.getTradeNo() + "的合同操作", 0,
						ApplicationContextInit.getErrorInfo("-6013"));
			}
		}
		return "success";
	}

	public String performWithdrawAsk() throws RemoteException {
		this.logger.debug("-- 撤销违约操作----------performWithdrawAsk----------");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		String str = this.request.getParameter("firmId");
		if ((str == null) || ("".equals(str))) {
			addReturnValue(-1, 230002L, new Object[] { "交易商不存在！" });
			return "success";
		}
		TradeContract localTradeContract = isMyTrade(this.entity, str);
		if (localTradeContract == null) {
			addReturnValue(-1, 236301L);
		} else {
			boolean bool = false;
			if (localTradeContract.getTradeType().intValue() == 0) {
				bool = revocationBreachApply(localTradeContract, str);
			} else {
				bool = revocationBreachAutoApply(localTradeContract, str);
			}
			if (bool) {
				Object localObject;
				ResultVO localResultVO;
				if (localTradeContract.getStatus().intValue() == 0) {
					localObject = getReserveByTrade(localTradeContract, str);
					localResultVO = this.reserveProcessService.performWithdrawAsk(((Reserve) localObject).getReserveId().longValue());
					if (localResultVO.getResult() < 0L) {
						addReturnValue(-1, 230003L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
						writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "为合同" + localTradeContract.getTradeNo() + "撤销违约", 0,
								localResultVO.getErrorInfo().replace("\n", ""));
					} else if (localResultVO.getResult() == 0L) {
						addReturnValue(-1, 230005L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
						writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "为合同" + localTradeContract.getTradeNo() + "撤销违约", 0,
								localResultVO.getErrorInfo().replace("\n", ""));
					} else {
						addReturnValue(1, 236214L);
						writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "为合同" + localTradeContract.getTradeNo() + "撤销违约", 1,
								null);
					}
				} else if (localTradeContract.getStatus().intValue() == 3) {
					localObject = getHoldingByTrade(localTradeContract, str);
					localResultVO = this.tradeProcessService.performWithdrawAsk(((Holding) localObject).getHoldingId().longValue());
					if (localResultVO.getResult() < 0L) {
						addReturnValue(-1, 230003L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
						writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "为合同" + localTradeContract.getTradeNo() + "撤销违约", 0,
								localResultVO.getErrorInfo().replace("\n", ""));
					} else if (localResultVO.getResult() == 0L) {
						addReturnValue(-1, 230005L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
						writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "为合同" + localTradeContract.getTradeNo() + "撤销违约", 0,
								localResultVO.getErrorInfo().replace("\n", ""));
					} else {
						addReturnValue(1, 236214L);
						writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "为合同" + localTradeContract.getTradeNo() + "撤销违约", 1,
								null);
					}
				}
			} else {
				addReturnValue(-1, 236316L);
				writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "为合同号为：" + localTradeContract.getTradeNo() + "的合同操作", 0,
						ApplicationContextInit.getErrorInfo("-6014"));
			}
		}
		return "success";
	}

	public String forwardPerformBreach() {
		this.logger.debug("-- 处理违约跳转---------forwardPerformBreach----------");
		String str1 = this.request.getParameter("firmId");
		if ((str1 == null) || ("".equals(str1))) {
			addReturnValue(-1, 230002L, new Object[] { "交易商不存在！" });
			return "success";
		}
		this.request.setAttribute("firmId", str1);
		TradeContract localTradeContract = isMyTrade(this.entity, str1);
		if (localTradeContract == null) {
			addReturnValue(-1, 236301L);
		} else {
			boolean bool = false;
			if (localTradeContract.getTradeType().intValue() == 0) {
				bool = disposeBreachApply(localTradeContract, str1);
			} else {
				bool = disposeBreachAutoApply(localTradeContract, str1);
			}
			Double localDouble = null;
			if (bool) {
				this.entity = localTradeContract;
				if (localTradeContract.getBFirmId().equals(str1)) {
					if (localTradeContract.getStatus().intValue() == 0) {
						localDouble = localTradeContract.getTradeMargin_B();
					} else if (localTradeContract.getStatus().intValue() == 3) {
						localDouble = localTradeContract.getDeliveryMargin_B();
					}
				} else if (localTradeContract.getStatus().intValue() == 0) {
					localDouble = localTradeContract.getTradeMargin_s();
				} else if (localTradeContract.getStatus().intValue() == 3) {
					localDouble = localTradeContract.getDeliveryMargin_s();
				}
				String str2 = getOtherFirmId(localTradeContract, str1);
				BreachApply localBreachApply = getBreachApplyByTrade(localTradeContract, str2);
				if (localBreachApply != null) {
					int i = Tools.strToInt(this.kernelService.getConfigInfo("BufferDate"), 1);
					Date localDate1 = localBreachApply.getApplyTime();
					Date localDate2 = new Date(localDate1.getTime() + i * 60 * 60 * 1000);
					this.request.setAttribute("time", localDate2);
				}
				this.request.setAttribute("money", localDouble);
			} else {
				addReturnValue(-1, 236317L);
			}
		}
		return "success";
	}

	public String performBreach() throws RemoteException {
		this.logger.debug("-- 处理违约操作----------performBreach----------");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		String str = this.request.getParameter("firmId");
		if ((str == null) || ("".equals(str))) {
			addReturnValue(-1, 230002L, new Object[] { "交易商不存在！" });
			return "success";
		}
		TradeContract localTradeContract = isMyTrade(this.entity, str);
		if (localTradeContract == null) {
			addReturnValue(-1, 236301L);
		} else {
			boolean bool = false;
			if (localTradeContract.getTradeType().intValue() == 0) {
				bool = disposeBreachApply(localTradeContract, str);
			} else {
				bool = disposeBreachAutoApply(localTradeContract, str);
			}
			if (bool) {
				if (localTradeContract.getStatus().intValue() == 0) {
					int i = 0;
					if (localTradeContract.getBFirmId().equals(str)) {
						i = 1;
					} else if (localTradeContract.getSFirmId().equals(str)) {
						i = 2;
					}
					ResultVO localResultVO2 = this.reserveProcessService.performReserveBreach(localTradeContract.getTradeNo().longValue(), i);
					if (localResultVO2.getResult() < 0L) {
						addReturnValue(-1, 230003L, new Object[] { localResultVO2.getErrorInfo().replace("\n", "") });
						writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "为合同" + localTradeContract.getTradeNo() + "处理违约", 0,
								localResultVO2.getErrorInfo().replace("\n", ""));
					} else if (localResultVO2.getResult() == 0L) {
						addReturnValue(-1, 230005L, new Object[] { localResultVO2.getErrorInfo().replace("\n", "") });
						writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "为合同" + localTradeContract.getTradeNo() + "处理违约", 0,
								localResultVO2.getErrorInfo().replace("\n", ""));
					} else {
						addReturnValue(1, 236215L);
						writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "为合同" + localTradeContract.getTradeNo() + "处理违约", 1,
								null);
					}
				} else if (localTradeContract.getStatus().intValue() == 3) {
					ResultVO localResultVO1 = this.tradeProcessService.performTradeBreach(localTradeContract.getTradeNo().longValue(), str);
					if (localResultVO1.getResult() < 0L) {
						addReturnValue(-1, 230003L, new Object[] { localResultVO1.getErrorInfo().replace("\n", "") });
						writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "为合同" + localTradeContract.getTradeNo() + "处理违约", 0,
								localResultVO1.getErrorInfo().replace("\n", ""));
					} else if (localResultVO1.getResult() == 0L) {
						addReturnValue(-1, 230005L, new Object[] { localResultVO1.getErrorInfo().replace("\n", "") });
						writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "为合同" + localTradeContract.getTradeNo() + "处理违约", 0,
								localResultVO1.getErrorInfo().replace("\n", ""));
					} else {
						addReturnValue(1, 236215L);
						writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "为合同" + localTradeContract.getTradeNo() + "处理违约", 1,
								null);
					}
				}
			} else {
				addReturnValue(-1, 236317L);
				writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "为合同号为：" + localTradeContract.getTradeNo() + "的合同操作", 0,
						ApplicationContextInit.getErrorInfo("-6015"));
			}
		}
		return "success";
	}

	public String toBreachDelay() {
		String str1 = this.request.getParameter("firmId");
		if ((str1 == null) || ("".equals(str1))) {
			addReturnValue(-1, 230002L, new Object[] { "交易商不存在！" });
			return "success";
		}
		this.request.setAttribute("firmId", str1);
		String str2 = this.request.getParameter("tradeNo");
		String str3 = "select * from E_BreachApply b where b.tradeno='" + str2 + "' and b.firmid='" + str1 + "' and b.status='0'";
		List localList = super.getService().getListBySql(str3, new BreachApply());
		BreachApply localBreachApply;
		if (localList.size() > 0) {
			this.request.setAttribute("entity", localList.get(0));
			localBreachApply = (BreachApply) localList.get(0);
			int i = Tools.strToInt(this.kernelService.getConfigInfo("BufferDate"), 1);
			Date localDate1 = localBreachApply.getApplyTime();
			Date localDate2 = new Date(localDate1.getTime() + i * 60 * 60 * 1000);
			this.request.setAttribute("time", localDate2);
			String str4 = this.kernelService.getConfigInfo("BufferDate");
			this.request.setAttribute("bufferDate", str4);
			this.request.setAttribute("tradeNo", str2);
		} else {
			localBreachApply = new BreachApply();
			this.request.setAttribute("isBreach", "N");
			this.request.setAttribute("entity", localBreachApply);
			addReturnValue(-1, 236318L);
		}
		return "success";
	}

	public String breachDelay() {
		String str = this.request.getParameter("isBreach");
		if ((str != null) && (!"".equals(str)) && ("N".equals(str))) {
			addReturnValue(-1, 236318L);
			return "success";
		}
		BreachApply localBreachApply1 = (BreachApply) this.entity;
		BreachApply localBreachApply2 = (BreachApply) getService().get(localBreachApply1.clone());
		TradeContract localTradeContract = new TradeContract();
		localTradeContract.setTradeNo(localBreachApply2.getTradeNo());
		localTradeContract = (TradeContract) getService().get(localTradeContract);
		if ((localTradeContract == null) || ((0 != localTradeContract.getStatus().intValue()) && (3 != localTradeContract.getStatus().intValue()))) {
			addReturnValue(-1, 236318L);
			return "success";
		}
		localBreachApply1.setDelayTime(Long.valueOf(localBreachApply1.getDelayTime().longValue() * 60L * 60L));
		getService().update(localBreachApply1);
		addReturnValue(1, 236216L);
		return "success";
	}

	public String forwardPaymentGoodsMoneyAuto() throws Exception {
		this.logger.debug("---转入货款跳转---------forwardPaymentGoodsMoneyAuto---------");
		String str = this.request.getParameter("firmId");
		if ((str == null) || ("".equals(str))) {
			addReturnValue(-1, 230002L, new Object[] { "交易商不存在！" });
			return "success";
		}
		this.request.setAttribute("firmId", str);
		TradeContract localTradeContract = isMyTrade(this.entity, str);
		if (localTradeContract == null) {
			addReturnValue(-1, 236301L);
		} else {
			boolean bool = appendAutoGoods(localTradeContract, str);
			if (bool) {
				double d1 = Arith.format(Arith.mul(localTradeContract.getQuantity().doubleValue(), localTradeContract.getPrice().doubleValue()), 2);
				this.entity = localTradeContract;
				Set localSet = localTradeContract.getBelongToHolding();
				double d2 = 0.0D;
				Iterator localIterator = localSet.iterator();
				while (localIterator.hasNext()) {
					Holding localHolding = (Holding) localIterator.next();
					if (localHolding.getFirmId().equals(str)) {
						d2 = localHolding.getPayGoodsMoney().doubleValue();
						this.request.setAttribute("PayMargin", localHolding.getPayMargin());
						this.request.setAttribute("payOff", localHolding.getPayOff());
					}
				}
				double d3 = localTradeContract.getBuyTradeFee().doubleValue();
				double d4 = localTradeContract.getBuyDeliveryFee().doubleValue();
				Double localDouble = Double.valueOf(localTradeContract.getBreed().getCategory().getOffSetRate().doubleValue());
				if ("N".equals(localTradeContract.getBreed().getCategory().getIsOffSet())) {
					localDouble = Double.valueOf(0.0D);
				}
				double d5 = localTradeContract.getQuantity().doubleValue();
				double d6 = d5 * (1.0D + localDouble.doubleValue());
				double d7 = d5 * (1.0D - localDouble.doubleValue());
				double d8 = Arith.mul(localTradeContract.getPrice().doubleValue(), d6);
				double d9 = Arith.format(Arith.sub(d8, d2), 2);
				double d10 = Arith.mul(localTradeContract.getPrice().doubleValue(), d7);
				double d11 = Arith.format(Arith.sub(d10, d2), 2);
				double d12 = Arith.format(Arith.sub(d1, d2), 2);
				BigDecimal localBigDecimal = getRealGoods(str);
				this.request.setAttribute("tradeFeeMoney", Double.valueOf(d3));
				this.request.setAttribute("deliveryFeeMoney", Double.valueOf(d4));
				this.request.setAttribute("realFunds", localBigDecimal);
				this.request.setAttribute("goods", Double.valueOf(d1));
				this.request.setAttribute("maxEndGoods", Double.valueOf(d9));
				this.request.setAttribute("payGoodsMoney", Double.valueOf(d2));
				this.request.setAttribute("minEndGoods", Double.valueOf(d11));
				this.request.setAttribute("endGoods", Double.valueOf(d12));
			} else {
				addReturnValue(-1, 236304L);
			}
		}
		return "success";
	}

	public String paymentGoodsMoneyAuto() {
		this.logger.debug("---转入货款操作---------paymentGoodsMoney---------");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		String str1 = this.request.getParameter("firmId");
		if ((str1 == null) || ("".equals(str1))) {
			addReturnValue(-1, 230002L, new Object[] { "交易商不存在！" });
			return "success";
		}
		TradeContract localTradeContract = isMyTrade(this.entity, str1);
		String str2 = "管理员：" + localUser.getUserId() + "代交易商：" + str1 + "为合同%s转入货款";
		if (localTradeContract == null) {
			addReturnValue(-1, 236301L);
		} else {
			str2 = String.format(str2, new Object[] { localTradeContract.getTradeNo() });
			boolean bool1 = appendAutoGoods(localTradeContract, str1);
			if (bool1) {
				String str3 = this.request.getParameter("lastPayment");
				boolean bool2 = true;
				if (str3.equals("false")) {
					bool2 = false;
				}
				String str4 = this.request.getParameter("payMoney");
				Holding localHolding = getHoldingByTrade(localTradeContract, str1);
				ResultVO localResultVO = this.processService.paymentGoodsMoney(localHolding.getHoldingId().longValue(), Tools.strToDouble(str4, 0.0D),
						bool2);
				if (localResultVO.getResult() < 0L) {
					addReturnValue(-1, 230003L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, str2, 0, localResultVO.getErrorInfo().replace("\n", ""));
				} else if (localResultVO.getResult() == 0L) {
					addReturnValue(-1, 230005L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, str2, 0, localResultVO.getErrorInfo().replace("\n", ""));
				} else {
					addReturnValue(1, 236202L);
					writeOperateLog(2309, str2, 1, null);
				}
			} else {
				addReturnValue(-1, 236304L);
				writeOperateLog(2309, str2, 0, ApplicationContextInit.getErrorInfo("-6007"));
			}
		}
		return "success";
	}

	public String forwardPayWarehouse() {
		this.logger.debug("------支付仓单跳转 ----forwardPayWarehouse---");
		String str = this.request.getParameter("firmId");
		if ((str == null) || ("".equals(str))) {
			addReturnValue(-1, 230002L, new Object[] { "交易商不存在！" });
			return "success";
		}
		this.request.setAttribute("firmId", str);
		TradeContract localTradeContract = isMyTrade(this.entity, str);
		if (localTradeContract == null) {
			addReturnValue(-1, 236301L);
		} else {
			boolean bool = payAutoWarehouse(localTradeContract, str);
			if (bool) {
				PageRequest localPageRequest = null;
				try {
					localPageRequest = super.getPageRequest(this.request);
					QueryConditions localQueryConditions = (QueryConditions) localPageRequest.getFilters();
					localQueryConditions.addCondition("primary.moduleID", "=", Integer.valueOf(23));
					localQueryConditions.addCondition("primary.tradeNo", "=", localTradeContract.getTradeNo().toString());
					localQueryConditions.addCondition("primary.stock.ownerFirm", "=", str);
				} catch (Exception localException) {
					localException.printStackTrace();
				}
				Page localPage = getService().getPage(localPageRequest, new TradeStock());
				Object localObject = new ArrayList();
				if ((localPage.getResult() != null) && (localPage.getResult().size() > 0)) {
					localObject = localPage.getResult();
				}
				Holding localHolding = getHoldingByTrade(localTradeContract, str);
				this.request.setAttribute("holding", localHolding);
				this.request.setAttribute("tradeStockList", localObject);
			} else {
				addReturnValue(-1, 236319L);
			}
		}
		return "success";
	}

	public String payWarehouse() {
		this.logger.debug("------支付仓单操作 ----payWarehouse---");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		String str = this.request.getParameter("firmId");
		if ((str == null) || ("".equals(str))) {
			addReturnValue(-1, 230002L, new Object[] { "交易商不存在！" });
			return "success";
		}
		TradeContract localTradeContract = isMyTrade(this.entity, str);
		if (localTradeContract == null) {
			addReturnValue(-1, 236301L);
		} else {
			boolean bool = payAutoWarehouse(localTradeContract, str);
			if (bool) {
				ResultVO localResultVO = new ResultVO();
				localResultVO.setResult(1L);
				String[] arrayOfString = this.request.getParameterValues("cks");
				Holding localHolding = getHoldingByTrade(localTradeContract, str);
				localResultVO = this.wareHouseStockService.paymentGoodsTOBuy(localHolding.getHoldingId().longValue(), arrayOfString);
				if (localResultVO.getResult() < 0L) {
					addReturnValue(-1, 230003L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "为合同号为：" + localTradeContract.getTradeNo() + "的合同支付仓单", 0,
							localResultVO.getErrorInfo().replace("\n", ""));
				} else if (localResultVO.getResult() == 0L) {
					addReturnValue(-1, 230005L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "为合同号为：" + localTradeContract.getTradeNo() + "的合同支付仓单", 0,
							localResultVO.getErrorInfo().replace("\n", ""));
				} else {
					addReturnValue(1, 236217L);
					writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "为合同号为：" + localTradeContract.getTradeNo() + "的合同支付仓单", 1,
							null);
				}
			} else {
				addReturnValue(-1, 236319L);
				writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "为合同号为：" + localTradeContract.getTradeNo() + "的合同支付仓单", 0,
						ApplicationContextInit.getErrorInfo("-6024"));
			}
		}
		return "success";
	}

	public String forwardPayGoods() {
		this.logger.debug("------支付货款跳转 ----forwardPayGoods---");
		String str = this.request.getParameter("firmId");
		if ((str == null) || ("".equals(str))) {
			addReturnValue(-1, 230002L, new Object[] { "交易商不存在！" });
			return "success";
		}
		this.request.setAttribute("firmId", str);
		TradeContract localTradeContract = isMyTrade(this.entity, str);
		if (localTradeContract == null) {
			addReturnValue(-1, 236301L);
		} else {
			boolean bool = payAutoGoods(localTradeContract, str);
			if (bool) {
				this.entity = localTradeContract;
				Set localSet = localTradeContract.getBelongToHolding();
				double d1 = 0.0D;
				double d2 = 0.0D;
				Iterator localIterator = localSet.iterator();
				while (localIterator.hasNext()) {
					Holding localHolding = (Holding) localIterator.next();
					if (localHolding.getFirmId().equals(str)) {
						d1 = localHolding.getPayOff().doubleValue();
						d2 = localHolding.getPayGoodsMoney().doubleValue();
						this.request.setAttribute("PayMargin", localHolding.getPayMargin());
					}
				}
				double d3 = Arith.format(Arith.sub(d2, d1), 2);
				this.request.setAttribute("remainMoney", Double.valueOf(d3));
				this.request.setAttribute("payOff", Double.valueOf(d1));
				this.request.setAttribute("payGoodsMoney", Double.valueOf(d2));
			} else {
				addReturnValue(-1, 236320L);
			}
		}
		return "success";
	}

	public String payGoods() throws Exception {
		this.logger.debug("------支付货款操作 ----payGoods---");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		String str1 = this.request.getParameter("firmId");
		if ((str1 == null) || ("".equals(str1))) {
			addReturnValue(-1, 230002L, new Object[] { "交易商不存在！" });
			return "success";
		}
		TradeContract localTradeContract = isMyTrade(this.entity, str1);
		if (localTradeContract == null) {
			addReturnValue(-1, 236301L);
		} else {
			boolean bool = payAutoGoods(localTradeContract, str1);
			if (bool) {
				Holding localHolding = getHoldingByTrade(localTradeContract, str1);
				String str2 = this.request.getParameter("payMoney");
				ResultVO localResultVO = this.processService.paymentMoneyToSell(localHolding.getHoldingId().longValue(),
						Tools.strToDouble(str2, 0.0D));
				if (localResultVO.getResult() < 0L) {
					addReturnValue(-1, 230003L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str1 + "为合同号为：" + localTradeContract.getTradeNo() + "的合同支付贷款", 0,
							localResultVO.getErrorInfo().replace("\n", ""));
				} else if (localResultVO.getResult() == 0L) {
					addReturnValue(-1, 230005L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str1 + "为合同号为：" + localTradeContract.getTradeNo() + "的合同支付贷款", 0,
							localResultVO.getErrorInfo().replace("\n", ""));
				} else {
					addReturnValue(1, 236218L);
					writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str1 + "为合同号为：" + localTradeContract.getTradeNo() + "的合同支付贷款", 1,
							null);
				}
			} else {
				addReturnValue(-1, 236320L);
				writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str1 + "为合同号为：" + localTradeContract.getTradeNo() + "的合同操作", 0,
						ApplicationContextInit.getErrorInfo("-6023"));
			}
		}
		return "success";
	}

	public String performEndTradeApply() {
		this.logger.debug("-- 结束合同申请操作----------performEndTradeApply----------");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		String str = this.request.getParameter("firmId");
		if ((str == null) || ("".equals(str))) {
			addReturnValue(-1, 230002L, new Object[] { "交易商不存在！" });
			return "success";
		}
		TradeContract localTradeContract = isMyTrade(this.entity, str);
		if (localTradeContract == null) {
			addReturnValue(-1, 236301L);
		} else if ((localTradeContract.getStatus().intValue() == 3) || (localTradeContract.getStatus().intValue() == 5)) {
			EndTradeApply localEndTradeApply = getEndTradeApply(localTradeContract);
			if (localEndTradeApply == null) {
				ResultVO localResultVO = this.tradeProcessService.performApplyEndTrade(localTradeContract.getTradeNo().longValue(), str);
				if (localResultVO.getResult() < 0L) {
					addReturnValue(-1, 230003L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "为合同号为：" + localTradeContract.getTradeNo() + "结束合同申请", 0,
							localResultVO.getErrorInfo().replace("\n", ""));
				} else if (localResultVO.getResult() == 0L) {
					addReturnValue(-1, 230005L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "为合同号为：" + localTradeContract.getTradeNo() + "结束合同申请", 0,
							localResultVO.getErrorInfo().replace("\n", ""));
				} else {
					addReturnValue(1, 236219L);
					writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "为合同号为：" + localTradeContract.getTradeNo() + "结束合同申请", 1,
							null);
				}
			} else {
				addReturnValue(-1, 236322L, new Object[] { localTradeContract.getTradeNo() });
				writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "为合同号为：" + localTradeContract.getTradeNo() + "结束合同申请", 0,
						ApplicationContextInit.getErrorInfo("-6041"));
			}
		} else {
			addReturnValue(-1, 236322L);
			writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "为合同号为：" + localTradeContract.getTradeNo() + "的合同操作", 0,
					ApplicationContextInit.getErrorInfo("-6020"));
		}
		return "success";
	}

	public String performRevokeEndTradeApply() throws RemoteException {
		this.logger.debug("-- 撤销结束合同操作----------performRevokeEndTradeApply----------");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		String str = this.request.getParameter("firmId");
		if ((str == null) || ("".equals(str))) {
			addReturnValue(-1, 230002L, new Object[] { "交易商不存在！" });
			return "success";
		}
		TradeContract localTradeContract = isMyTrade(this.entity, str);
		if (localTradeContract == null) {
			addReturnValue(-1, 236301L);
		} else if ((localTradeContract.getStatus().intValue() == 3) || (localTradeContract.getStatus().intValue() == 5)) {
			boolean bool = revokeEndTradeAutoApply(localTradeContract, str);
			if (bool) {
				ResultVO localResultVO = this.tradeProcessService.withdrawApplyEndTrade(localTradeContract.getTradeNo().longValue(), str);
				if (localResultVO.getResult() < 0L) {
					addReturnValue(-1, 230003L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "为合同号为：" + localTradeContract.getTradeNo() + "撤销结束合同", 0,
							localResultVO.getErrorInfo().replace("\n", ""));
				} else if (localResultVO.getResult() == 0L) {
					addReturnValue(-1, 230005L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "为合同号为：" + localTradeContract.getTradeNo() + "撤销结束合同", 0,
							localResultVO.getErrorInfo().replace("\n", ""));
				} else {
					addReturnValue(1, 236220L);
					writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "为合同号为：" + localTradeContract.getTradeNo() + "撤销结束合同", 1,
							null);
				}
			} else {
				addReturnValue(-1, 236323L, new Object[] { localTradeContract.getTradeNo() });
			}
		} else {
			addReturnValue(-1, 236323L);
			writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "为合同号为：" + localTradeContract.getTradeNo() + "的合同操作", 0,
					ApplicationContextInit.getErrorInfo("-6022"));
		}
		return "success";
	}

	public String performDisposeEndTradeApply() throws RemoteException {
		this.logger.debug("-- 同意结束合同操作----------performDisposeEndTradeApply----------");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		String str = this.request.getParameter("firmId");
		if ((str == null) || ("".equals(str))) {
			addReturnValue(-1, 230002L, new Object[] { "交易商不存在！" });
			return "success";
		}
		TradeContract localTradeContract = isMyTrade(this.entity, str);
		if (localTradeContract == null) {
			addReturnValue(-1, 236301L);
		} else {
			boolean bool = disposeEndTradeAutoApply(localTradeContract, str);
			if (bool) {
				ResultVO localResultVO = this.tradeProcessService.performEndTrade(localTradeContract.getTradeNo().longValue(), str);
				if (localResultVO.getResult() < 0L) {
					addReturnValue(-1, 230003L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "同意合同号为：" + localTradeContract.getTradeNo() + "的合同结束", 0,
							localResultVO.getErrorInfo().replace("\n", ""));
				} else if (localResultVO.getResult() == 0L) {
					addReturnValue(-1, 230005L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "同意合同号为：" + localTradeContract.getTradeNo() + "的合同结束", 0,
							localResultVO.getErrorInfo().replace("\n", ""));
				} else {
					addReturnValue(1, 236221L);
					writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "同意合同号为：" + localTradeContract.getTradeNo() + "的合同结束", 1,
							null);
				}
			} else {
				addReturnValue(-1, 236324L);
				writeOperateLog(2309, "管理员：" + localUser.getUserId() + "代交易商：" + str + "同意合同号为：" + localTradeContract.getTradeNo() + "的合同结束", 0,
						ApplicationContextInit.getErrorInfo("-6023"));
			}
		}
		return "success";
	}

	public boolean appendMagin(TradeContract paramTradeContract, String paramString) {
		if (paramTradeContract.getStatus().intValue() == 0) {
			Reserve localReserve = getReserveByTrade(paramTradeContract, paramString);
			return localReserve.getStatus().intValue() == 0;
		}
		return false;
	}

	public boolean appendWarehouse(TradeContract paramTradeContract, String paramString) {
		if (!paramTradeContract.getSFirmId().equals(paramString)) {
			return false;
		}
		Object localObject;
		if (paramTradeContract.getStatus().intValue() == 0) {
			localObject = getReserveByTrade(paramTradeContract, paramString);
			return ((Reserve) localObject).getStatus().intValue() == 0;
		}
		if (paramTradeContract.getStatus().intValue() == 3) {
			localObject = getHoldingByTrade(paramTradeContract, paramString);
			if (((Holding) localObject).getStatus().intValue() == 1) {
				if (paramTradeContract.getOrderId() != null) {
					Order localOrder = new Order();
					localOrder.setOrderId(paramTradeContract.getOrderId());
					localOrder = (Order) getService().get(localOrder);
					if (localOrder == null) {
						OrderHis localOrderHis = new OrderHis();
						localOrderHis.setOrderId(paramTradeContract.getOrderId());
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

	public boolean closeTrade(TradeContract paramTradeContract, String paramString) {
		Object localObject;
		if (paramTradeContract.getStatus().intValue() == 0) {
			localObject = getReserveByTrade(paramTradeContract, paramString);
			return ((Reserve) localObject).getStatus().intValue() != 1;
		}
		if (paramTradeContract.getStatus().intValue() == 3) {
			localObject = getHoldingByTrade(paramTradeContract, paramString);
			return ((Holding) localObject).getStatus().intValue() == 1;
		}
		return false;
	}

	public boolean appendGoods(TradeContract paramTradeContract, String paramString) {
		if (!paramTradeContract.getBFirmId().equals(paramString)) {
			return false;
		}
		if (paramTradeContract.getStatus().intValue() == 3) {
			Holding localHolding = getHoldingByTrade(paramTradeContract, paramString);
			return localHolding.getStatus().intValue() == 1;
		}
		return false;
	}

	public boolean offSetApply(TradeContract paramTradeContract, String paramString) {
		PageRequest localPageRequest1 = new PageRequest(" and primary.categoryId=" + paramTradeContract.getBreed().getCategory().getCategoryId());
		getService().getPage(localPageRequest1, new Category());
		if (paramTradeContract.getStatus().intValue() == 6) {
			if ("N".equalsIgnoreCase(paramTradeContract.getBreed().getCategory().getIsOffSet())) {
				return false;
			}
			if (paramTradeContract.getSFirmId().equals(paramString)) {
				PageRequest localPageRequest2 = new PageRequest(" and tradeNo=" + paramTradeContract.getTradeNo());
				Page localPage = getService().getPage(localPageRequest2, new NoOffset());
				if ((localPage != null) && (localPage.getResult() != null) && (localPage.getResult().size() > 0)) {
					return false;
				}
			}
			PageRequest localPageRequest2 = new PageRequest(" and primary.tradeNo= " + paramTradeContract.getTradeNo() + " and primary.status!=1");
			Page localPage = getService().getPage(localPageRequest2, new OffSetApply());
			return (localPage.getResult() == null) || (localPage.getResult().size() <= 0);
		}
		return false;
	}

	public boolean revocationOffSetApply(TradeContract paramTradeContract, String paramString) {
		if ((paramTradeContract.getStatus().intValue() == 5) || (paramTradeContract.getStatus().intValue() == 6)
				|| (paramTradeContract.getStatus().intValue() == 7)) {
			OffSetApply localOffSetApply = getOffSetApplyByTrade(paramTradeContract, paramString);
			if (localOffSetApply == null) {
				return false;
			}
			return localOffSetApply.getStatus().intValue() == 0;
		}
		return false;
	}

	public boolean disposeOffSetApply(TradeContract paramTradeContract, String paramString) {
		if (paramTradeContract.getStatus().intValue() == 6) {
			String str = getOtherFirmId(paramTradeContract, paramString);
			OffSetApply localOffSetApply = getOffSetApplyByTrade(paramTradeContract, str);
			if (localOffSetApply == null) {
				return false;
			}
			return localOffSetApply.getStatus().intValue() == 0;
		}
		return false;
	}

	public boolean noOffSetApply(TradeContract paramTradeContract, String paramString) {
		PageRequest localPageRequest = new PageRequest(" and primary.categoryId=" + paramTradeContract.getBreed().getCategory().getCategoryId());
		getService().getPage(localPageRequest, new Category());
		if (!paramTradeContract.getSFirmId().equals(paramString)) {
			return false;
		}
		if (paramTradeContract.getStatus().intValue() != 6) {
			return false;
		}
		if ("N".equalsIgnoreCase(paramTradeContract.getBreed().getCategory().getIsOffSet())) {
			return false;
		}
		Holding localHolding = getHoldingByTrade(paramTradeContract, paramTradeContract.getSFirmId());
		if (localHolding.getOffSetId().intValue() < 0) {
			PageRequest localObject = new PageRequest(" and tradeNo=" + paramTradeContract.getTradeNo());
			Page localPage = getService().getPage((PageRequest) localObject, new NoOffset());
			return (localPage == null) || (localPage.getResult() == null) || (localPage.getResult().size() <= 0);
		}
		Object localObject = new OffSetApply();
		((OffSetApply) localObject).setOffSetId(Long.valueOf(Tools.strToLong(localHolding.getOffSetId() + "")));
		localObject = (OffSetApply) getService().get((StandardModel) localObject);
		if (localObject != null) {
			if (((OffSetApply) localObject).getStatus().intValue() == 0) {
				return false;
			}
			return ((OffSetApply) localObject).getStatus().intValue() == 1;
		}
		return false;
	}

	public boolean payFirstGoods(TradeContract paramTradeContract, String paramString) {
		if (!paramTradeContract.getBFirmId().equals(paramString)) {
			return false;
		}
		return paramTradeContract.getStatus().intValue() == 5;
	}

	public boolean paySecondGoods(TradeContract paramTradeContract, String paramString) {
		SystemProps localSystemProps = new SystemProps();
		localSystemProps.setPropsKey("PayTimes");
		localSystemProps = (SystemProps) getService().get(localSystemProps);
		if (localSystemProps.getRunTimeValue().equals("2")) {
			return false;
		}
		PageRequest localPageRequest = new PageRequest(" and primary.categoryId=" + paramTradeContract.getBreed().getCategory().getCategoryId());
		getService().getPage(localPageRequest, new Category());
		if (!paramTradeContract.getBFirmId().equals(paramString)) {
			return false;
		}
		if (paramTradeContract.getStatus().intValue() != 6) {
			return false;
		}
		if ("N".equalsIgnoreCase(paramTradeContract.getBreed().getCategory().getIsOffSet())) {
			return true;
		}
		Holding localHolding = getHoldingByTrade(paramTradeContract, paramTradeContract.getSFirmId());
		if (localHolding.getOffSetId().intValue() < 0) {
			PageRequest localObject1 = new PageRequest(" and tradeNo=" + paramTradeContract.getTradeNo());
			Page localObject2 = getService().getPage((PageRequest) localObject1, new NoOffset());
			return (localObject2 == null) || ((((Page) localObject2).getResult() != null) && (((Page) localObject2).getResult().size() > 0));
		}
		Object localObject1 = new OffSetApply();
		((OffSetApply) localObject1).setOffSetId(Long.valueOf(Tools.strToLong(localHolding.getOffSetId() + "")));
		localObject1 = (OffSetApply) getService().get((StandardModel) localObject1);
		if (localObject1 != null) {
			if (((OffSetApply) localObject1).getStatus().intValue() == 0) {
				return false;
			}
			if (((OffSetApply) localObject1).getStatus().intValue() == 1) {
				PageRequest localObject2 = new PageRequest(" and tradeNo=" + paramTradeContract.getTradeNo());
				Page localPage = getService().getPage((PageRequest) localObject2, new NoOffset());
				return (localPage == null) || ((localPage.getResult() != null) && (localPage.getResult().size() > 0));
			}
			return true;
		}
		Object localObject2 = new PageRequest(" and tradeNo=" + paramTradeContract.getTradeNo());
		Page localPage = getService().getPage((PageRequest) localObject2, new NoOffset());
		return (localPage == null) || ((localPage.getResult() != null) && (localPage.getResult().size() > 0));
	}

	public boolean payLeastGoods(TradeContract paramTradeContract, String paramString) {
		if (!paramTradeContract.getBFirmId().equals(paramString)) {
			return false;
		}
		SystemProps localSystemProps = new SystemProps();
		localSystemProps.setPropsKey("PayTimes");
		localSystemProps = (SystemProps) getService().get(localSystemProps);
		if (localSystemProps.getRunTimeValue().equals("2")) {
			PageRequest localPageRequest = new PageRequest(" and primary.categoryId=" + paramTradeContract.getBreed().getCategory().getCategoryId());
			getService().getPage(localPageRequest, new Category());
			if (!paramTradeContract.getBFirmId().equals(paramString)) {
				return false;
			}
			if (paramTradeContract.getStatus().intValue() != 6) {
				return false;
			}
			if ("N".equalsIgnoreCase(paramTradeContract.getBreed().getCategory().getIsOffSet())) {
				return true;
			}
			Holding localHolding = getHoldingByTrade(paramTradeContract, paramTradeContract.getSFirmId());
			if (localHolding.getOffSetId().intValue() < 0) {
				PageRequest localObject1 = new PageRequest(" and tradeNo=" + paramTradeContract.getTradeNo());
				Page localObject2 = getService().getPage((PageRequest) localObject1, new NoOffset());
				return (localObject2 == null) || ((((Page) localObject2).getResult() != null) && (((Page) localObject2).getResult().size() > 0));
			}
			Object localObject1 = new OffSetApply();
			((OffSetApply) localObject1).setOffSetId(Long.valueOf(Tools.strToLong(localHolding.getOffSetId() + "")));
			localObject1 = (OffSetApply) getService().get((StandardModel) localObject1);
			if (localObject1 != null) {
				if (((OffSetApply) localObject1).getStatus().intValue() == 0) {
					return false;
				}
				if (((OffSetApply) localObject1).getStatus().intValue() == 1) {
					PageRequest localObject2 = new PageRequest(" and tradeNo=" + paramTradeContract.getTradeNo());
					Page localPage = getService().getPage((PageRequest) localObject2, new NoOffset());
					return (localPage == null) || ((localPage.getResult() != null) && (localPage.getResult().size() > 0));
				}
				return true;
			}
			Object localObject2 = new PageRequest(" and tradeNo=" + paramTradeContract.getTradeNo());
			Page localPage = getService().getPage((PageRequest) localObject2, new NoOffset());
			return (localPage == null) || ((localPage.getResult() != null) && (localPage.getResult().size() > 0));
		}
		return paramTradeContract.getStatus().intValue() == 7;
	}

	public boolean lastGoodsMoneyApply(TradeContract paramTradeContract, String paramString) {
		if (!paramTradeContract.getSFirmId().equals(paramString)) {
			return false;
		}
		SystemProps localSystemProps = new SystemProps();
		localSystemProps.setPropsKey("PayTimes");
		localSystemProps = (SystemProps) getService().get(localSystemProps);
		if (((localSystemProps.getRunTimeValue().equals("2")) && (payLeastGoods(paramTradeContract, getOtherFirmId(paramTradeContract, paramString))))
				|| ((localSystemProps.getRunTimeValue().equals("3")) && (paramTradeContract.getStatus().intValue() == 7))
				|| (payFirstGoods(paramTradeContract, paramTradeContract.getBFirmId()))
				|| (paySecondGoods(paramTradeContract, paramTradeContract.getBFirmId()))) {
			QueryConditions localQueryConditions = new QueryConditions();
			localQueryConditions.addCondition("tradeContract.tradeNo", "=", paramTradeContract.getTradeNo());
			localQueryConditions.addCondition("status", "=", Integer.valueOf(0));
			PageRequest localPageRequest = new PageRequest(1, 5, localQueryConditions);
			Page localPage = getService().getPage(localPageRequest, new GoodsMoneyApply());
			return (localPage.getResult() == null) || (localPage.getResult().size() <= 0);
		}
		return false;
	}

	public boolean disposelastGoodsMoney(TradeContract paramTradeContract, String paramString) {
		if (!paramTradeContract.getSFirmId().equals(paramString)) {
			return false;
		}
		SystemProps localSystemProps = new SystemProps();
		localSystemProps.setPropsKey("PayTimes");
		localSystemProps = (SystemProps) getService().get(localSystemProps);
		if (((localSystemProps.getRunTimeValue().equals("2")) && (paramTradeContract.getStatus().intValue() != 6))
				|| ((localSystemProps.getRunTimeValue().equals("3")) && (paramTradeContract.getStatus().intValue() != 7)
						&& (!payFirstGoods(paramTradeContract, paramTradeContract.getBFirmId()))
						&& (!paySecondGoods(paramTradeContract, paramTradeContract.getBFirmId())))) {
			return false;
		}
		QueryConditions localQueryConditions = new QueryConditions();
		localQueryConditions.addCondition("tradeContract.tradeNo", "=", paramTradeContract.getTradeNo());
		localQueryConditions.addCondition("status", "=", Integer.valueOf(0));
		PageRequest localPageRequest = new PageRequest(1, 5, localQueryConditions);
		Page localPage = getService().getPage(localPageRequest, new GoodsMoneyApply());
		return (localPage.getResult() != null) && (localPage.getResult().size() > 0);
	}

	public boolean breachApply(TradeContract paramTradeContract, String paramString) throws Exception {
		if ((paramTradeContract.getStatus().intValue() != 0) && (paramTradeContract.getStatus().intValue() != 3)) {
			return false;
		}
		boolean bool = revocationBreachApply(paramTradeContract, paramString);
		if (bool) {
			return false;
		}
		Object localObject;
		if (paramTradeContract.getStatus().intValue() == 0) {
			long l = getService().getSysDate().getTime() - paramTradeContract.getTime().getTime();
			if (l / 1000L <= paramTradeContract.getTradePreTime().intValue()) {
				return false;
			}
			localObject = getReserveByTrade(paramTradeContract, paramString);
			String str2 = getOtherFirmId(paramTradeContract, paramString);
			Reserve localReserve = getReserveByTrade(paramTradeContract, str2);
			return (((Reserve) localObject).getStatus().intValue() == 1) && (localReserve.getStatus().intValue() == 0);
		}
		if (paramTradeContract.getStatus().intValue() == 3) {
			if (getService().getSysDate().getTime() <= paramTradeContract.getDeliveryDay().getTime()) {
				return false;
			}
			Holding localHolding = getHoldingByTrade(paramTradeContract, paramString);
			String str1 = getOtherFirmId(paramTradeContract, paramString);
			localObject = getHoldingByTrade(paramTradeContract, str1);
			return (localHolding.getStatus().intValue() == 2) && (((Holding) localObject).getStatus().intValue() == 1);
		}
		return false;
	}

	public boolean revocationBreachApply(TradeContract paramTradeContract, String paramString) {
		if ((paramTradeContract.getStatus().intValue() != 0) && (paramTradeContract.getStatus().intValue() != 3)) {
			return false;
		}
		BreachApply localBreachApply = getBreachApplyByTrade(paramTradeContract, paramString);
		if (localBreachApply == null) {
			return false;
		}
		return localBreachApply.getStatus().intValue() == 0;
	}

	public boolean disposeBreachApply(TradeContract paramTradeContract, String paramString) {
		if (paramTradeContract.getStatus().intValue() != 0) {
			return false;
		}
		String str = getOtherFirmId(paramTradeContract, paramString);
		BreachApply localBreachApply = getBreachApplyByTrade(paramTradeContract, str);
		if (localBreachApply == null) {
			return false;
		}
		return localBreachApply.getStatus().intValue() == 0;
	}

	private Boolean tradeBreachDelay(TradeContract paramTradeContract, String paramString) {
		if ((paramTradeContract.getStatus().intValue() != 3) && (paramTradeContract.getStatus().intValue() != 0)) {
			return Boolean.valueOf(false);
		}
		String str = "select * from E_BreachApply b where b.tradeno='" + paramTradeContract.getTradeNo() + "' and b.firmid='" + paramString
				+ "' and b.status='0'";
		List localList = getService().getListBySql(str);
		this.logger.debug("list.size()   " + localList.size() + ":::");
		if (localList.size() > 0) {
			return Boolean.valueOf(true);
		}
		return Boolean.valueOf(false);
	}

	public Map<String, Boolean> getTradeButtonMap(TradeContract paramTradeContract, String paramString) throws Exception {
		HashMap localHashMap = new HashMap();
		localHashMap.put("appendMagin", Boolean.valueOf(appendMagin(paramTradeContract, paramString)));
		localHashMap.put("appendWarehouse", Boolean.valueOf(appendWarehouse(paramTradeContract, paramString)));
		localHashMap.put("closeTrade", Boolean.valueOf(closeTrade(paramTradeContract, paramString)));
		localHashMap.put("appendGoods", Boolean.valueOf(appendGoods(paramTradeContract, paramString)));
		localHashMap.put("offSetApply", Boolean.valueOf(offSetApply(paramTradeContract, paramString)));
		localHashMap.put("revocationOffSetApply", Boolean.valueOf(revocationOffSetApply(paramTradeContract, paramString)));
		localHashMap.put("disposeOffSetApply", Boolean.valueOf(disposeOffSetApply(paramTradeContract, paramString)));
		localHashMap.put("noOffSetApply", Boolean.valueOf(noOffSetApply(paramTradeContract, paramString)));
		localHashMap.put("payFirstGoods", Boolean.valueOf(payFirstGoods(paramTradeContract, paramString)));
		localHashMap.put("paySecondGoods", Boolean.valueOf(paySecondGoods(paramTradeContract, paramString)));
		localHashMap.put("payLeastGoods", Boolean.valueOf(payLeastGoods(paramTradeContract, paramString)));
		localHashMap.put("lastGoodsMoneyApply", Boolean.valueOf(lastGoodsMoneyApply(paramTradeContract, paramString)));
		localHashMap.put("disposelastGoodsMoney", Boolean.valueOf(disposelastGoodsMoney(paramTradeContract, paramString)));
		localHashMap.put("breachApply", Boolean.valueOf(breachApply(paramTradeContract, paramString)));
		localHashMap.put("revocationBreachApply", Boolean.valueOf(revocationBreachApply(paramTradeContract, paramString)));
		localHashMap.put("disposeBreachApply", Boolean.valueOf(disposeBreachApply(paramTradeContract, paramString)));
		localHashMap.put("breachDelay", tradeBreachDelay(paramTradeContract, paramString));
		this.logger.debug(localHashMap);
		return localHashMap;
	}

	public Map<String, Boolean> getTradeAutoButtonMap(TradeContract paramTradeContract, String paramString) throws Exception {
		HashMap localHashMap = new HashMap();
		localHashMap.put("appendMagin", Boolean.valueOf(appendMagin(paramTradeContract, paramString)));
		localHashMap.put("appendAutoWarehouse", Boolean.valueOf(appendAutoWarehouse(paramTradeContract, paramString)));
		localHashMap.put("appendAutoGoods", Boolean.valueOf(appendAutoGoods(paramTradeContract, paramString)));
		localHashMap.put("payAutoGoods", Boolean.valueOf(payAutoGoods(paramTradeContract, paramString)));
		localHashMap.put("payAutoWarehouse", Boolean.valueOf(payAutoWarehouse(paramTradeContract, paramString)));
		localHashMap.put("closeTrade", Boolean.valueOf(closeTrade(paramTradeContract, paramString)));
		localHashMap.put("breachAutoApply", Boolean.valueOf(breachAutoApply(paramTradeContract, paramString)));
		localHashMap.put("revocationAutoBreachApply", Boolean.valueOf(revocationBreachAutoApply(paramTradeContract, paramString)));
		localHashMap.put("disposeBreachAutoApply", Boolean.valueOf(disposeBreachAutoApply(paramTradeContract, paramString)));
		localHashMap.put("breachDelay", tradeBreachDelay(paramTradeContract, paramString));
		localHashMap.put("tradeEndAutoApply", Boolean.valueOf(tradeEndAutoApply(paramTradeContract, paramString)));
		localHashMap.put("disposeEndTradeAutoApply", Boolean.valueOf(disposeEndTradeAutoApply(paramTradeContract, paramString)));
		localHashMap.put("revokeEndTradeAutoApply", Boolean.valueOf(revokeEndTradeAutoApply(paramTradeContract, paramString)));
		this.logger.debug(localHashMap);
		return localHashMap;
	}

	public boolean appendAutoWarehouse(TradeContract paramTradeContract, String paramString) {
		if (!paramTradeContract.getSFirmId().equals(paramString)) {
			return false;
		}
		if (paramTradeContract.getStatus().intValue() == 3) {
			Holding localHolding = getHoldingByTrade(paramTradeContract, paramString);
			if (localHolding.getStatus().intValue() == 1) {
				if (paramTradeContract.getOrderId() != null) {
					Order localOrder = new Order();
					localOrder.setOrderId(paramTradeContract.getOrderId());
					localOrder = (Order) getService().get(localOrder);
					if (localOrder == null) {
						OrderHis localOrderHis = new OrderHis();
						localOrderHis.setOrderId(paramTradeContract.getOrderId());
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

	public boolean appendAutoGoods(TradeContract paramTradeContract, String paramString) {
		if (!paramTradeContract.getBFirmId().equals(paramString)) {
			return false;
		}
		if (paramTradeContract.getStatus().intValue() == 3) {
			Holding localHolding = getHoldingByTrade(paramTradeContract, paramString);
			return localHolding.getStatus().intValue() == 1;
		}
		return false;
	}

	public boolean payAutoGoods(TradeContract paramTradeContract, String paramString) {
		if (!paramTradeContract.getBFirmId().equals(paramString)) {
			return false;
		}
		if ((paramTradeContract.getStatus().intValue() == 3) || (paramTradeContract.getStatus().intValue() == 5)) {
			Holding localHolding = getHoldingByTrade(paramTradeContract, paramString);
			double d = localHolding.getPayGoodsMoney().doubleValue() - localHolding.getPayOff().doubleValue();
			return d != 0.0D;
		}
		return false;
	}

	public boolean payAutoWarehouse(TradeContract paramTradeContract, String paramString) {
		if ((paramTradeContract.getStatus().intValue() != 3) && (paramTradeContract.getStatus().intValue() != 5)) {
			return false;
		}
		if (!paramTradeContract.getSFirmId().equals(paramString)) {
			return false;
		}
		Holding localHolding = getHoldingByTrade(paramTradeContract, paramString);
		if (localHolding.getHoldingId() != null) {
			double d = localHolding.getPayGoodsMoney().doubleValue() - localHolding.getPayOff().doubleValue();
			return d != 0.0D;
		}
		return false;
	}

	public boolean breachAutoApply(TradeContract paramTradeContract, String paramString) throws Exception {
		if ((paramTradeContract.getStatus().intValue() != 0) && (paramTradeContract.getStatus().intValue() != 3)
				&& (paramTradeContract.getStatus().intValue() != 5)) {
			return false;
		}
		boolean bool = revocationBreachAutoApply(paramTradeContract, paramString);
		if (bool) {
			return false;
		}
		String str = getOtherFirmId(paramTradeContract, paramString);
		BreachApply localBreachApply = getBreachApplyByTrade(paramTradeContract, str);
		if (localBreachApply != null) {
			return false;
		}
		long l;
		Object localObject;
		if (paramTradeContract.getStatus().intValue() == 0) {
			l = getService().getSysDate().getTime() - paramTradeContract.getTime().getTime();
			if (l / 1000L <= paramTradeContract.getTradePreTime().intValue()) {
				return false;
			}
			localObject = getReserveByTrade(paramTradeContract, paramString);
			Reserve localReserve = getReserveByTrade(paramTradeContract, str);
			return (((Reserve) localObject).getStatus().intValue() == 1) && (localReserve.getStatus().intValue() == 0);
		}
		if (paramTradeContract.getStatus().intValue() == 3) {
			l = getService().getSysDate().getTime() - paramTradeContract.getDeliveryDay().getTime();
			if (l < 0L) {
				return false;
			}
			localObject = getHoldingByTrade(paramTradeContract, str);
			return ((Holding) localObject).getStatus().intValue() != 2;
		}
		return false;
	}

	public boolean revocationBreachAutoApply(TradeContract paramTradeContract, String paramString) {
		if ((paramTradeContract.getStatus().intValue() != 0) && (paramTradeContract.getStatus().intValue() != 3)
				&& (paramTradeContract.getStatus().intValue() != 5)) {
			return false;
		}
		BreachApply localBreachApply = getBreachApplyByTrade(paramTradeContract, paramString);
		if (localBreachApply == null) {
			return false;
		}
		return localBreachApply.getStatus().intValue() == 0;
	}

	public boolean disposeBreachAutoApply(TradeContract paramTradeContract, String paramString) {
		if (paramTradeContract.getStatus().intValue() != 0) {
			return false;
		}
		String str = getOtherFirmId(paramTradeContract, paramString);
		BreachApply localBreachApply = getBreachApplyByTrade(paramTradeContract, str);
		if (localBreachApply == null) {
			return false;
		}
		return localBreachApply.getStatus().intValue() == 0;
	}

	public boolean tradeEndAutoApply(TradeContract paramTradeContract, String paramString) {
		if ((paramTradeContract.getStatus().intValue() == 3) || (paramTradeContract.getStatus().intValue() == 5)) {
			EndTradeApply localEndTradeApply = getEndTradeApply(paramTradeContract);
			if (localEndTradeApply == null) {
				return true;
			}
		}
		return false;
	}

	public boolean disposeEndTradeAutoApply(TradeContract paramTradeContract, String paramString) {
		if ((paramTradeContract.getStatus().intValue() == 21) || (paramTradeContract.getStatus().intValue() == 22)) {
			return false;
		}
		EndTradeApply localEndTradeApply = getEndTradeApply(paramTradeContract);
		if (localEndTradeApply == null) {
			return false;
		}
		return (!localEndTradeApply.getFirm().getFirmId().equals(paramString)) && (localEndTradeApply.getStatus().intValue() == 0);
	}

	public boolean revokeEndTradeAutoApply(TradeContract paramTradeContract, String paramString) {
		if ((paramTradeContract.getStatus().intValue() == 21) || (paramTradeContract.getStatus().intValue() == 22)) {
			return false;
		}
		EndTradeApply localEndTradeApply = getEndTradeApply(paramTradeContract);
		if (localEndTradeApply == null) {
			return false;
		}
		return (localEndTradeApply.getFirm().getFirmId().equals(paramString)) && (localEndTradeApply.getStatus().intValue() == 0);
	}

	public EndTradeApply getEndTradeApply(TradeContract paramTradeContract) {
		EndTradeApply localEndTradeApply = new EndTradeApply();
		PageRequest localPageRequest = new PageRequest(" and primary.tradeNo=" + paramTradeContract.getTradeNo() + " and primary.status=0");
		Page localPage = getService().getPage(localPageRequest, new EndTradeApply());
		if ((localPage.getResult() != null) && (localPage.getResult().size() > 0)) {
			localEndTradeApply = (EndTradeApply) localPage.getResult().get(0);
			return localEndTradeApply;
		}
		return null;
	}

	public Reserve getReserveByTrade(TradeContract paramTradeContract, String paramString) {
		this.logger.debug("-----查看合同下的用户的订单----getReserveByTrade-------");
		Object localObject = new Reserve();
		Set localSet = paramTradeContract.getBelongToReserve();
		Iterator localIterator = localSet.iterator();
		while (localIterator.hasNext()) {
			Reserve localReserve = (Reserve) localIterator.next();
			if (localReserve.getFirmId().equals(paramString)) {
				localObject = localReserve;
			}
		}
		return (Reserve) localObject;
	}

	public Holding getHoldingByTrade(TradeContract paramTradeContract, String paramString) {
		this.logger.debug("-----查看合同下的用户的持仓----getHoldingByTrade-------");
		Object localObject = new Holding();
		Set localSet = paramTradeContract.getBelongToHolding();
		Iterator localIterator = localSet.iterator();
		while (localIterator.hasNext()) {
			Holding localHolding = (Holding) localIterator.next();
			if (localHolding.getFirmId().equals(paramString)) {
				localObject = localHolding;
			}
		}
		return (Holding) localObject;
	}

	public OffSetApply getOffSetApplyByTrade(TradeContract paramTradeContract, String paramString) {
		this.logger.debug("-----查看合同下的溢短货款信息----getOffSetApplyByTrade-------");
		OffSetApply localOffSetApply = new OffSetApply();
		Holding localHolding = getHoldingByTrade(paramTradeContract, paramString);
		if (localHolding.getOffSetId() == null) {
			return null;
		}
		localOffSetApply.setOffSetId(Long.valueOf(Tools.strToLong(localHolding.getOffSetId() + "")));
		localOffSetApply = (OffSetApply) getService().get(localOffSetApply);
		if (localOffSetApply == null) {
			return null;
		}
		if (localOffSetApply.getFirm().getFirmId().equals(paramString)) {
			return localOffSetApply;
		}
		return null;
	}

	public BreachApply getBreachApplyByTrade(TradeContract paramTradeContract, String paramString) {
		this.logger.debug("-----查出合同下的违约信息----getBreachApplyByTrade-------");
		BreachApply localBreachApply = new BreachApply();
		Object localObject;
		if (paramTradeContract.getStatus().intValue() == 0) {
			localObject = getReserveByTrade(paramTradeContract, paramString);
			if ((((Reserve) localObject).getBreachApplyId() == null) || (((Reserve) localObject).getBreachApplyId().intValue() < 0)) {
				return null;
			}
			localBreachApply.setBreachApplyId(Long.valueOf(Tools.strToLong(((Reserve) localObject).getBreachApplyId() + "")));
			localBreachApply = (BreachApply) getService().get(localBreachApply);
			if (localBreachApply.getFirm().getFirmId().equals(paramString)) {
				return localBreachApply;
			}
			return null;
		}
		if (paramTradeContract.getStatus().intValue() == 3) {
			localObject = getHoldingByTrade(paramTradeContract, paramString);
			if ((((Holding) localObject).getBreachApplyId() == null) || (((Holding) localObject).getBreachApplyId().intValue() < 0)) {
				return null;
			}
			localBreachApply.setBreachApplyId(Long.valueOf(Tools.strToLong(((Holding) localObject).getBreachApplyId() + "")));
			localBreachApply = (BreachApply) getService().get(localBreachApply);
			if (localBreachApply.getFirm().getFirmId().equals(paramString)) {
				return localBreachApply;
			}
			return null;
		}
		return null;
	}

	public String getOtherFirmId(TradeContract paramTradeContract, String paramString) {
		String str = "";
		if (paramTradeContract.getBFirmId().equals(paramString)) {
			str = paramTradeContract.getSFirmId();
		} else {
			str = paramTradeContract.getBFirmId();
		}
		return str;
	}

	public BigDecimal getRealGoods(String paramString) throws Exception {
		BigDecimal localBigDecimal = (BigDecimal) getService().executeProcedure("{?=call FN_F_GetRealFunds(?,?) }",
				new Object[] { paramString, Integer.valueOf(0) });
		return localBigDecimal;
	}

	public TradeContract isMyTrade(StandardModel paramStandardModel, String paramString) {
		if (paramStandardModel.fetchPKey().getValue() == null) {
			return null;
		}
		TradeContract localTradeContract = (TradeContract) getService().get(paramStandardModel);
		if ((localTradeContract.getBFirmId().equals(paramString)) || (localTradeContract.getSFirmId().equals(paramString))) {
			return localTradeContract;
		}
		return null;
	}

	private void putResourcePropertys(Set<TradeGoodsProperty> paramSet) {
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
}
