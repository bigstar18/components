package gnnt.MEBS.espot.front.action.funds;

import java.math.BigDecimal;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

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
import gnnt.MEBS.common.front.model.integrated.User;
import gnnt.MEBS.common.front.statictools.ActionUtil;
import gnnt.MEBS.common.front.statictools.ApplicationContextInit;
import gnnt.MEBS.common.front.statictools.Tools;
import gnnt.MEBS.espot.core.kernel.IFundsProcess;
import gnnt.MEBS.espot.core.vo.ResultVO;
import gnnt.MEBS.espot.front.model.funds.FirmFunds;
import gnnt.MEBS.espot.front.model.funds.FundFlow;
import gnnt.MEBS.espot.front.model.funds.FundFlowHis;
import gnnt.MEBS.espot.front.model.funds.Funds;
import gnnt.MEBS.espot.front.model.funds.SubscriptionFlow;
import gnnt.MEBS.espot.front.service.funds.FundsService;
import net.sf.json.JSONArray;

@Controller("fundsProcessAction")
@Scope("request")
public class FundsProcessAction extends StandardAction {
	private static final long serialVersionUID = -1669778025919409807L;
	@Autowired
	@Qualifier("processService")
	private IFundsProcess processService;
	@Autowired
	@Qualifier("fundsService")
	private FundsService fundsService;
	@Resource(name = "oprcodeMap")
	protected Map<Integer, String> oprcodeMap;
	@Resource(name = "summaryMap")
	private Map<String, String> summaryMap;
	private JSONArray jsonReturn;

	public IFundsProcess getProcessService() {
		return this.processService;
	}

	public Map<String, String> getSummaryMap() {
		return this.summaryMap;
	}

	public Map<Integer, String> getOprcodeMap() {
		return this.oprcodeMap;
	}

	public FundsService getFundsService() {
		return this.fundsService;
	}

	public String paymentReserve() {
		String str = "为订单%s转入履约保证金";
		this.logger.debug(str);
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		long l = -1000L;
		l = Tools.strToLong(this.request.getParameter("tradeNO"), -1000L);
		if (l < 0L) {
			addReturnValue(-1, -7004L);
			str = String.format(str, new Object[] { "" });
			writeOperateLog(2305, str, 0, ApplicationContextInit.getErrorInfo("-7004"));
			return "error";
		}
		str = String.format(str, new Object[] { Long.valueOf(l) });
		double d = -1000.0D;
		d = Tools.strToDouble(this.request.getParameter("money"), -1000.0D);
		if (d < 0.0D) {
			addReturnValue(-1, -7001L);
			writeOperateLog(2305, str, 0, ApplicationContextInit.getErrorInfo("-7001"));
			return "error";
		}
		ResultVO localResultVO = this.processService.paymentReserve(localUser.getBelongtoFirm().getFirmID(), l, d);
		if (localResultVO.getResult() < 0L) {
			addReturnValue(-1, -10002L, new Object[] { localResultVO.getErrorInfo() });
			writeOperateLog(2305, str, 0, localResultVO.getErrorInfo());
			return "error";
		}
		addReturnValue(1, 7000L, new Object[] { Long.valueOf(l) });
		writeOperateLog(2305, str, 1, "");
		return "success";
	}

	public String paymentSubscription() {
		String str1 = "转入诚信保障金";
		this.logger.debug(str1);
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		if (localUser != null) {
			String str2 = this.request.getParameter("inputAmount");
			try {
				ResultVO localResultVO = null;
				if (!"".equals(str2)) {
					localResultVO = this.processService.paymentSubscription(localUser.getBelongtoFirm().getFirmID(), Tools.strToDouble(str2, 0.0D));
				}
				if (localResultVO.getResult() < 0L) {
					addReturnValue(-1, 2300002L, new Object[] { localResultVO.getErrorInfo() });
					writeOperateLog(2305, str1, 0, localResultVO.getErrorInfo());
				} else if (localResultVO.getResult() == 0L) {
					addReturnValue(-1, 2300003L, new Object[] { localResultVO.getErrorInfo() });
					writeOperateLog(2305, str1, 0, localResultVO.getErrorInfo());
				} else {
					addReturnValue(1, 2350201L);
					writeOperateLog(2305, str1, 1, "");
				}
			} catch (Exception localException) {
				addReturnValue(-1, 2300004L, new Object[] { "转入诚信保障金操作" });
				writeOperateLog(2305, str1, 0, localException.getMessage());
				this.logger.error(Tools.getExceptionTrace(localException));
			}
		}
		return "success";
	}

	public String refundmentSubscription() {
		String str1 = "转出诚信保障金";
		this.logger.debug(str1);
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		if (localUser != null) {
			String str2 = this.request.getParameter("inputAmount");
			try {
				ResultVO localResultVO = null;
				if (!"".equals(str2)) {
					localResultVO = this.processService.refundmentSubscription(localUser.getBelongtoFirm().getFirmID(),
							Tools.strToDouble(str2, 0.0D));
				}
				if (localResultVO.getResult() < 0L) {
					addReturnValue(-1, 2300002L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2305, str1, 0, localResultVO.getErrorInfo());
				} else if (localResultVO.getResult() == 0L) {
					addReturnValue(-1, 2300003L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2305, str1, 0, localResultVO.getErrorInfo());
				} else {
					addReturnValue(1, 2350202L);
					writeOperateLog(2305, str1, 1, "");
				}
			} catch (Exception localException) {
				addReturnValue(-1, 2300004L, new Object[] { "转出诚信保障金操作" });
				writeOperateLog(2305, str1, 0, localException.getMessage());
				this.logger.error(Tools.getExceptionTrace(localException));
			}
		}
		return "success";
	}

	public String paymentGoodsMoney() {
		String str = "为持仓%s转入货款";
		this.logger.debug("转入货款");
		long l = -1000L;
		l = Tools.strToLong(this.request.getParameter("holdingID"), -1000L);
		if (l < 0L) {
			addReturnValue(-1, -7003L);
			str = String.format(str, new Object[] { "" });
			writeOperateLog(2305, str, 0, ApplicationContextInit.getErrorInfo("-7003"));
			return "error";
		}
		str = String.format(str, new Object[] { Long.valueOf(l) });
		ResultVO localResultVO = this.processService.paymentGoodsMoney(l);
		if (localResultVO.getResult() < 0L) {
			addReturnValue(-1, -10002L, new Object[] { localResultVO.getErrorInfo() });
			writeOperateLog(2305, str, 0, localResultVO.getErrorInfo());
			return "error";
		}
		addReturnValue(1, 7300L);
		writeOperateLog(2305, str, 1, "");
		return "success";
	}

	public String paymentMoneyToSell() {
		String str1 = "为持仓%s支付首款给卖方";
		this.logger.debug("支付首款给卖方");
		long l = -1000L;
		l = Tools.strToLong(this.request.getParameter("holdingID"), -1000L);
		if (l < 0L) {
			addReturnValue(-1, -7003L);
			str1 = String.format(str1, new Object[] { "" });
			writeOperateLog(2305, str1, 0, ApplicationContextInit.getErrorInfo("-7003"));
			return "error";
		}
		str1 = String.format(str1, new Object[] { Long.valueOf(l) });
		String str2 = "select t.runtimevalue from X_SYSTEMPROPS t where t.key = 'FirstPaymentRate'";
		List localList = getService().getDao().queryBySql(str2);
		double d = Double.valueOf((String) ((Map) localList.get(0)).get("RUNTIMEVALUE")).doubleValue();
		ResultVO localResultVO = this.processService.paymentFirstMoneyToSell(l, d);
		if (localResultVO.getResult() < 0L) {
			addReturnValue(-1, -10002L, new Object[] { localResultVO.getErrorInfo() });
			writeOperateLog(2305, str1, 0, localResultVO.getErrorInfo());
			return "error";
		}
		addReturnValue(1, 7400L);
		writeOperateLog(2305, str1, 1, "");
		return "success";
	}

	public String paymentBalanceToSell() {
		String str = "为仓单%s支付尾款给卖方";
		this.logger.debug("支付尾款给卖方");
		long l = -1000L;
		l = Tools.strToLong(this.request.getParameter("holdingID"), -1000L);
		if (l < 0L) {
			addReturnValue(-1, -7003L);
			str = String.format(str, new Object[] { "" });
			writeOperateLog(2305, str, 0, ApplicationContextInit.getErrorInfo("-7003"));
			return "error";
		}
		str = String.format(str, new Object[] { Long.valueOf(l) });
		ResultVO localResultVO = this.processService.paymentBalanceToSell(l);
		if (localResultVO.getResult() < 0L) {
			addReturnValue(-1, -10002L, new Object[] { localResultVO.getErrorInfo() });
			writeOperateLog(2305, str, 0, localResultVO.getErrorInfo());
			return "error";
		}
		addReturnValue(1, 7500L);
		writeOperateLog(2305, str, 1, "");
		return "success";
	}

	public String fundsDetails() throws Exception {
		this.logger.debug("交易商当前资金信息查询");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		FirmFunds localFirmFunds = (FirmFunds) this.entity;
		localFirmFunds.setFirmID(localUser.getBelongtoFirm().getFirmID());
		this.entity = getService().get(this.entity);
		Funds localFunds = new Funds();
		localFunds.setFirmID(localUser.getBelongtoFirm().getFirmID());
		localFunds = (Funds) getService().get(localFunds);
		BigDecimal localBigDecimal = (BigDecimal) getService().executeProcedure("{?=call FN_F_GetRealFunds(?,?) }",
				new Object[] { localUser.getBelongtoFirm().getFirmID(), Integer.valueOf(0) });
		this.request.setAttribute("realFunds", localBigDecimal);
		this.request.setAttribute("funds", localFunds);
		this.request.setAttribute("firmFunds", this.entity);
		return "success";
	}

	public JSONArray getJsonReturn() {
		return this.jsonReturn;
	}

	public String subscriptionView() {
		this.logger.debug("交易商诚信保障金信息查询");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		Map localMap = this.fundsService.getFirmScription(localUser.getBelongtoFirm().getFirmID());
		if ((localMap != null) && (localMap.size() > 0)) {
			Iterator localObject = localMap.keySet().iterator();
			while (((Iterator) localObject).hasNext()) {
				String str = (String) ((Iterator) localObject).next();
				this.request.setAttribute(str, localMap.get(str));
			}
		}
		Object localObject = null;
		try {
			localObject = ActionUtil.getPageRequest(this.request);
		} catch (Exception localException) {
			localException.printStackTrace();
		}
		QueryConditions localQueryConditions = (QueryConditions) ((PageRequest) localObject).getFilters();
		localQueryConditions.addCondition(" primary.belongtoFirm.firmID", "=", localUser.getBelongtoFirm().getFirmID());
		Page localPage = getService().getPage((PageRequest) localObject, new SubscriptionFlow());
		this.request.setAttribute("pageInfo", localPage);
		this.request.setAttribute("oldParams", ActionUtil.getParametersStartingWith(this.request, "gnnt_"));
		return "success";
	}

	public String subscriptionForJSON() {
		this.logger.debug("交易商诚信保障金信息查询ajax");
		this.jsonReturn = new JSONArray();
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		Map localMap = this.fundsService.getFirmScription(localUser.getBelongtoFirm().getFirmID());
		this.jsonReturn.add(localMap);
		return "success";
	}

	public String changeSubscriptionView() {
		String str1 = "%s诚信保障金";
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		if (localUser != null) {
			String str2 = this.request.getParameter("type");
			String str3 = this.request.getParameter("inputAmount");
			try {
				ResultVO localResultVO = null;
				if (("1".equals(str2)) && (!"".equals(str3))) {
					str1 = String.format(str1, new Object[] { "转入" });
					localResultVO = this.processService.paymentSubscription(localUser.getBelongtoFirm().getFirmID(), Tools.strToDouble(str3, 0.0D));
				} else if (("2".equals(str2)) && (!"".equals(str3))) {
					str1 = String.format(str1, new Object[] { "转出" });
					localResultVO = this.processService.refundmentSubscription(localUser.getBelongtoFirm().getFirmID(),
							Tools.strToDouble(str3, 0.0D));
				}
				if (localResultVO.getResult() < 0L) {
					addReturnValue(-1, 2300002L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2305, str1, 0, localResultVO.getErrorInfo());
				} else if (localResultVO.getResult() == 0L) {
					addReturnValue(-1, 2300003L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
					writeOperateLog(2305, str1, 0, localResultVO.getErrorInfo());
				} else {
					addReturnValue(1, 9910003L);
					writeOperateLog(2305, str1, 1, "");
				}
			} catch (Exception localException) {
				addReturnValue(-1, 9930091L, new Object[] { "诚信保障金划转" });
				writeOperateLog(2305, str1, 0, String.format(ApplicationContextInit.getErrorInfo("9930091"), new Object[] { "诚信保障金划转" }));
				this.logger.error(Tools.getExceptionTrace(localException));
			}
		}
		return "success";
	}

	public String inmoneymodel() throws Exception {
		String str = "模拟转入资金";
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		double d1 = Tools.strToDouble(this.request.getParameter("money"), 10000.0D);
		if ((localUser != null) && (d1 > 0.0D)) {
			double d2 = this.fundsService.inmoneymodel(localUser.getBelongtoFirm().getFirmID(), d1);
			if (d2 < 0.0D) {
				addReturnValue(-1, 2300002L, new Object[] { "入金操作失败" });
				writeOperateLog(2305, str, 0, String.format(ApplicationContextInit.getErrorInfo("2300002"), new Object[] { "入金操作失败" }));
			} else {
				addReturnValue(1, 2300003L, new Object[] { "入金：" + Tools.fmtDouble2(d1) + " 成功，您的当前余额为：" + Tools.fmtDouble2(d2) });
				writeOperateLog(2305, str, 1, "");
			}
		} else {
			addReturnValue(-1, 2300002L, new Object[] { "输入资金值为" + d1 });
			writeOperateLog(2305, str, 0, String.format(ApplicationContextInit.getErrorInfo("2300002"), new Object[] { "入金操作失败" }));
		}
		return "success";
	}

	public String fundsList() {
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		PageRequest localPageRequest = null;
		try {
			localPageRequest = ActionUtil.getPageRequest(this.request);
		} catch (Exception localException) {
			localException.printStackTrace();
		}
		QueryConditions localQueryConditions = (QueryConditions) localPageRequest.getFilters();
		localQueryConditions.addCondition("belongtoFirm.firmID", "=", localUser.getBelongtoFirm().getFirmID());
		localQueryConditions.addCondition("belongtoSummary.summaryNo", "like", "23");
		Object localObject = null;
		if ("H".equalsIgnoreCase(this.request.getParameter("isHistory"))) {
			localObject = new FundFlowHis();
		} else {
			localObject = new FundFlow();
		}
		Page localPage = getService().getPage(localPageRequest, (StandardModel) localObject);
		this.request.setAttribute("isHistory", this.request.getParameter("isHistory"));
		this.request.setAttribute("pageInfo", localPage);
		this.request.setAttribute("oldParams", ActionUtil.getParametersStartingWith(this.request, "gnnt_"));
		return "success";
	}
}
