package gnnt.MEBS.espot.mgr.action.parametermanage;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import gnnt.MEBS.common.mgr.action.StandardAction;
import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.statictools.Tools;
import gnnt.MEBS.espot.core.kernel.IMgrService;
import gnnt.MEBS.espot.mgr.model.parametermanage.SystemProps;

@Controller("sysPropsAction")
@Scope("request")
public class SysPropsAction extends StandardAction {
	private static final long serialVersionUID = 1L;
	private static final String POUNDAGEMODE = "TradeFeeMode";
	private static final String POUNDAGERATE = "TradeFeeRate";
	private static final String ONETRADEMARGIN = "OneTradeMargin";
	private static final String DELIVERYMARGINMODE = "DeliveryMarginMode";
	private static final String DELIVERYMARGINRATE = "DeliveryMarginRate";
	private static final String DELIVERYFEEMODE = "DeliveryFeeMode";
	private static final String DELIVERYFEERATE = "DeliveryFeeRate";
	private static final String TRADEMARGINMAGNIFICATION = "TradeMarginMagnification";
	private static final String LEASTSUBSCRIPTION = "LeastSubscription";
	private static final String TRADEPREDAYS = "TradePreTime";
	private static final String DELIVERPREDAYS = "DeliveryPreTime";
	private static final String ORDERVALIDDAYS = "OrderValidTime";
	private static final String OFFSET = "Offset";
	private static final String FIRSTPAYMENTRATE = "FirstPaymentRate";
	private static final String SECONDPAYMENTRATE = "SecondPaymentRate";
	private static final String BUYORDERAUDIT = "BuyOrderAudit";
	private static final String SELLORDERAUDIT = "SellOrderAudit";
	private static final String SELLPLEDGEAUDIT = "SellPledgeAudit";
	@Autowired
	@Qualifier("mgrService")
	private IMgrService mgrService;
	@Resource(name = "sysPropsMap")
	private Map<String, String> sysPropsMap;
	@Resource(name = "orderPropsAuditMap")
	private Map<String, String> orderPropsAuditMap;

	public Map<String, String> getOrderPropsAuditMap() {
		return this.orderPropsAuditMap;
	}

	public void setOrderPropsAuditMap(Map<String, String> paramMap) {
		this.orderPropsAuditMap = paramMap;
	}

	public Map<String, String> getSysPropsMap() {
		return this.sysPropsMap;
	}

	public IMgrService getMgrService() {
		return this.mgrService;
	}

	public void setMgrService(IMgrService paramIMgrService) {
		this.mgrService = paramIMgrService;
	}

	public String getPoundage() {
		getParameter("TradeFeeMode", "TradeFeeRate");
		return "success";
	}

	public String updatePoundage() {
		updateParameter("默认交易手续费");
		addReturnValue(1, 119902L);
		return "success";
	}

	public String updateSpendPoundage() {
		updateSpendParameter("默认交易手续费");
		return "success";
	}

	public String getDeliveryMargin() {
		getParameter("DeliveryMarginMode", "DeliveryMarginRate");
		return "success";
	}

	public String updateDeliveryMargin() {
		updateParameter("默认履约保证金");
		addReturnValue(1, 119902L);
		return "success";
	}

	public String updateSpendDeliveryMargin() {
		updateSpendParameter("默认履约保证金");
		return "success";
	}

	public String getDeliveryFee() {
		getParameter("DeliveryFeeMode", "DeliveryFeeRate");
		return "success";
	}

	public String updateDeliveryFee() {
		updateParameter("默认交收手续费");
		addReturnValue(1, 119902L);
		return "success";
	}

	public String updateSpendDeliveryFee() {
		updateSpendParameter("默认交收手续费");
		return "success";
	}

	public String getPayment() {
		SystemProps localSystemProps1 = new SystemProps();
		localSystemProps1.setPropsKey("FirstPaymentRate");
		localSystemProps1 = (SystemProps) getService().get(localSystemProps1);
		getService().getDao().evict(localSystemProps1);
		localSystemProps1 = (SystemProps) getService().get(localSystemProps1).clone();
		String str1 = expendStrNum(localSystemProps1.getPropsValue(), 100);
		localSystemProps1.setPropsValue(str1);
		String str2 = expendStrNum(localSystemProps1.getRunTimeValue(), 100);
		localSystemProps1.setRunTimeValue(str2);
		SystemProps localSystemProps2 = new SystemProps();
		localSystemProps2.setPropsKey("SecondPaymentRate");
		localSystemProps2 = (SystemProps) getService().get(localSystemProps2);
		getService().getDao().evict(localSystemProps2);
		localSystemProps2 = (SystemProps) getService().get(localSystemProps2).clone();
		String str3 = expendStrNum(localSystemProps2.getPropsValue(), 100);
		localSystemProps2.setPropsValue(str3);
		String str4 = expendStrNum(localSystemProps2.getRunTimeValue(), 100);
		localSystemProps2.setRunTimeValue(str4);
		this.entity = localSystemProps1;
		this.request.setAttribute("secondEntity", localSystemProps2);
		SystemProps localSystemProps3 = new SystemProps();
		localSystemProps3.setPropsKey("PayTimes");
		localSystemProps3 = (SystemProps) getService().get(localSystemProps3);
		this.request.setAttribute("PayTimes", Integer.valueOf(Tools.strToInt(localSystemProps3.getRunTimeValue())));
		return "success";
	}

	public String updatePayment() {
		this.logger.debug("enter updatePayment");
		SystemProps localSystemProps1 = (SystemProps) this.entity;
		String str1 = localSystemProps1.getPropsValue();
		localSystemProps1.setPropsValue(narrowStrNum(localSystemProps1.getPropsValue(), 100));
		getService().update(this.entity);
		String str2 = "修改货款支付比例,首款比例为：" + str1 + "%";
		SystemProps localSystemProps2 = new SystemProps();
		localSystemProps2.setPropsKey("PayTimes");
		localSystemProps2 = (SystemProps) getService().get(localSystemProps2);
		if (localSystemProps2.getRunTimeValue().equals("3")) {
			SystemProps localSystemProps3 = new SystemProps();
			localSystemProps3.setPropsKey("SecondPaymentRate");
			localSystemProps3 = (SystemProps) getService().get(localSystemProps3);
			String str3 = this.request.getParameter("secondEntity.propsValue");
			localSystemProps3.setPropsValue(narrowStrNum(str3, 100));
			getService().update(localSystemProps3);
			str2 = str2 + ",第二笔货款比例：" + str3 + "%";
		}
		writeOperateLog(2307, str2, 1, "");
		addReturnValue(1, 119902L);
		return "success";
	}

	public String updateSpendPayment() {
		String str1 = this.request.getParameter("mark");
		if (str1.equals("0")) {
			updatePayment();
		}
		SystemProps localSystemProps1 = (SystemProps) this.entity;
		ArrayList localArrayList = new ArrayList();
		try {
			localArrayList.add(localSystemProps1.getPropsKey());
			SystemProps localSystemProps2 = new SystemProps();
			localSystemProps2.setPropsKey("PayTimes");
			localSystemProps2 = (SystemProps) getService().get(localSystemProps2);
			if ("3".equals(localSystemProps2.getRunTimeValue())) {
				localArrayList.add("SecondPaymentRate");
			}
			this.mgrService.setProperty(localArrayList);
			addReturnValue(1, 119902L);
			localSystemProps1 = (SystemProps) getService().get(localSystemProps1);
			SystemProps localSystemProps3 = new SystemProps();
			localSystemProps3.setPropsKey("SecondPaymentRate");
			localSystemProps3 = (SystemProps) getService().get(localSystemProps3);
			String str2 = expendStrNum(localSystemProps1.getPropsValue(), 100);
			String str3 = expendStrNum(localSystemProps3.getPropsValue(), 100);
			writeOperateLog(2307, "修改货款支付比例(实时生效),首款比例为：" + str2 + "%,第二笔货款比例：" + str3 + "%", 1, "");
		} catch (Exception localException) {
			addReturnValue(-1, 230002L, new Object[] { "实时生效未成功，请您稍后重试" });
			this.logger.error(Tools.getExceptionTrace(localException));
			writeOperateLog(2307, "修改货款支付比例(实时生效)", 0, localException.getMessage());
		}
		return "success";
	}

	public String getOffset() {
		SystemProps localSystemProps = new SystemProps();
		localSystemProps.setPropsKey("Offset");
		localSystemProps = (SystemProps) getService().get(localSystemProps);
		getService().getDao().evict(localSystemProps);
		localSystemProps = (SystemProps) getService().get(localSystemProps).clone();
		String str1 = expendStrNum(localSystemProps.getPropsValue(), 100);
		localSystemProps.setPropsValue(str1);
		String str2 = expendStrNum(localSystemProps.getRunTimeValue(), 100);
		localSystemProps.setRunTimeValue(str2);
		this.entity = localSystemProps;
		return "success";
	}

	public String updateOffset() {
		this.logger.debug("enter updateOffset");
		SystemProps localSystemProps = (SystemProps) this.entity;
		localSystemProps.setPropsValue(narrowStrNum(localSystemProps.getPropsValue(), 100));
		getService().update(this.entity);
		addReturnValue(1, 119902L);
		return "success";
	}

	public String updateSpendOffset() {
		SystemProps localSystemProps = (SystemProps) this.entity;
		ArrayList localArrayList = new ArrayList();
		try {
			localArrayList.add(localSystemProps.getPropsKey());
			this.mgrService.setProperty(localArrayList);
			addReturnValue(1, 119902L);
		} catch (Exception localException) {
			addReturnValue(-1, 230002L, new Object[] { "实时生效未成功，请您稍后重试" });
			this.logger.error(Tools.getExceptionTrace(localException));
		}
		return "success";
	}

	public String getLeastSubscription() {
		getSingleParameter("LeastSubscription");
		return "success";
	}

	public String updateLeastSub() {
		updateSingleParameter("默认最低诚信保障金");
		addReturnValue(1, 119902L);
		return "success";
	}

	public String updateSpendLeastSub() {
		updateSpendSingleParameter("默认最低诚信保障金");
		return "success";
	}

	public String getTradePreDays() {
		getSingleParameter("TradePreTime");
		SystemProps localSystemProps = new SystemProps();
		localSystemProps.setPropsKey("DeliveryPreTime");
		this.request.setAttribute("deliveryPreDays", (SystemProps) getService().get(localSystemProps));
		return "success";
	}

	public String updateTradePreDays() {
		updateSingleParameter("默认保证金支付期限");
		addReturnValue(1, 119902L);
		return "success";
	}

	public String updateSpendTradePreDays() {
		updateSpendSingleParameter("默认保证金支付期限");
		return "success";
	}

	public String getDeliveryPreDays() {
		getSingleParameter("DeliveryPreTime");
		SystemProps localSystemProps = new SystemProps();
		localSystemProps.setPropsKey("TradePreTime");
		this.request.setAttribute("tradePreDays", (SystemProps) getService().get(localSystemProps));
		return "success";
	}

	public String updateDeliveryPreDays() {
		updateSingleParameter("默认备款/备货期限");
		addReturnValue(1, 119902L);
		return "success";
	}

	public String updateSpendDeliveryDays() {
		String str = this.request.getParameter("mark");
		if (str.equals("0")) {
			updateSingleParameter("默认备款/备货期限");
		}
		SystemProps localSystemProps1 = (SystemProps) this.entity;
		ArrayList localArrayList = new ArrayList();
		try {
			SystemProps localSystemProps2 = new SystemProps();
			localSystemProps2.setPropsKey("TradePreTime");
			localSystemProps2 = (SystemProps) getService().get(localSystemProps2);
			localSystemProps1 = (SystemProps) getService().get(localSystemProps1);
			if (Tools.strToFloat(localSystemProps1.getPropsValue()) < Tools.strToFloat(localSystemProps2.getRunTimeValue())) {
				addReturnValue(-1, 233100L);
			} else {
				localArrayList.add(localSystemProps1.getPropsKey());
				this.mgrService.setProperty(localArrayList);
				addReturnValue(1, 119902L);
				writeOperateLog(2307, "修改默认备款备货期限(实时生效)为：" + localSystemProps1.getPropsValue(), 1, "");
			}
		} catch (Exception localException) {
			localException.printStackTrace();
			addReturnValue(-1, 230002L, new Object[] { "实时生效未成功，请您稍后重试" });
			this.logger.error(Tools.getExceptionTrace(localException));
			writeOperateLog(2307, "修改默认备款备货期限(实时生效)为：" + localSystemProps1.getPropsValue(), 0, localException.getMessage());
		}
		return "success";
	}

	public String getOrderValidDays() {
		getSingleParameter("OrderValidTime");
		return "success";
	}

	public String updateOrderValidDays() {
		updateSingleParameter("默认委托有效期");
		addReturnValue(1, 119902L);
		return "success";
	}

	public String updateSpendOrderDays() {
		updateSpendSingleParameter("默认委托有效期");
		return "success";
	}

	public String getOrderPropsAudit() {
		SystemProps localSystemProps1 = new SystemProps();
		localSystemProps1.setPropsKey("BuyOrderAudit");
		localSystemProps1 = (SystemProps) getService().get(localSystemProps1);
		getService().getDao().evict(localSystemProps1);
		localSystemProps1 = (SystemProps) getService().get(localSystemProps1).clone();
		this.entity = localSystemProps1;
		SystemProps localSystemProps2 = new SystemProps();
		localSystemProps2.setPropsKey("SellOrderAudit");
		localSystemProps2 = (SystemProps) getService().get(localSystemProps2);
		getService().getDao().evict(localSystemProps2);
		localSystemProps2 = (SystemProps) getService().get(localSystemProps2).clone();
		SystemProps localSystemProps3 = new SystemProps();
		localSystemProps3.setPropsKey("SellPledgeAudit");
		localSystemProps3 = (SystemProps) getService().get(localSystemProps3);
		getService().getDao().evict(localSystemProps3);
		localSystemProps3 = (SystemProps) getService().get(localSystemProps3).clone();
		this.request.setAttribute("sellOrder", localSystemProps2);
		this.request.setAttribute("sellPledge", localSystemProps3);
		return "success";
	}

	public String updateOrderProps() {
		SystemProps localSystemProps1 = (SystemProps) this.entity;
		getService().update(this.entity);
		String str = "";
		if ("0".equals(localSystemProps1.getPropsValue())) {
			str = str + "修改委托审核,买挂牌设置为：需要;";
		} else {
			str = str + "修改委托审核,买挂牌设置为：不需要;";
		}
		SystemProps localSystemProps2 = new SystemProps();
		localSystemProps2.setPropsKey("SellOrderAudit");
		localSystemProps2.setPropsValue(this.request.getParameter("sellOrderValue"));
		getService().update(localSystemProps2);
		if ("0".equals(localSystemProps2.getPropsValue())) {
			str = str + "卖挂牌设置为：需要;";
		} else {
			str = str + "卖挂牌设置为：不需要;";
		}
		SystemProps localSystemProps3 = new SystemProps();
		localSystemProps3.setPropsKey("SellPledgeAudit");
		localSystemProps3.setPropsValue(this.request.getParameter("sellPledgeValue"));
		getService().update(localSystemProps3);
		if ("0".equals(localSystemProps3.getPropsValue())) {
			str = str + "卖仓单审核设置为：需要";
		} else {
			str = str + "卖仓单审核设置为：不需要";
		}
		addReturnValue(1, 119902L);
		writeOperateLog(2307, str, 1, "");
		return "success";
	}

	public String updateSpendOrderProps() {
		String str1 = this.request.getParameter("mark");
		System.out.println(str1.equals("0"));
		if (str1.equals("0")) {
			updateOrderProps();
		}
		ArrayList localArrayList = new ArrayList();
		try {
			SystemProps localSystemProps1 = new SystemProps();
			localSystemProps1.setPropsKey("BuyOrderAudit");
			localSystemProps1 = (SystemProps) getService().get(localSystemProps1);
			SystemProps localSystemProps2 = new SystemProps();
			localSystemProps2.setPropsKey("SellOrderAudit");
			localSystemProps2 = (SystemProps) getService().get(localSystemProps2);
			SystemProps localSystemProps3 = new SystemProps();
			localSystemProps3.setPropsKey("SellPledgeAudit");
			localSystemProps3 = (SystemProps) getService().get(localSystemProps3);
			localArrayList.add("BuyOrderAudit");
			localArrayList.add("SellOrderAudit");
			localArrayList.add("SellPledgeAudit");
			this.mgrService.setProperty(localArrayList);
			String str2 = "";
			if ("0".equals(localSystemProps1.getPropsValue())) {
				str2 = str2 + "修改委托审核(实时生效),买挂牌设置为：需要;";
			} else {
				str2 = str2 + "修改委托审核(实时生效),买挂牌设置为：不需要;";
			}
			if ("0".equals(localSystemProps2.getPropsValue())) {
				str2 = str2 + "卖挂牌设置为：需要;";
			} else {
				str2 = str2 + "卖挂牌设置为：不需要;";
			}
			if ("0".equals(localSystemProps3.getPropsValue())) {
				str2 = str2 + "卖仓单审核设置为：需要";
			} else {
				str2 = str2 + "卖仓单审核设置为：不需要";
			}
			writeOperateLog(2307, str2, 1, "");
		} catch (Exception localException) {
		}
		addReturnValue(1, 119902L);
		return "success";
	}

	public String getMargin() {
		getSingleParameter("TradeMarginMagnification");
		SystemProps localSystemProps = new SystemProps();
		localSystemProps.setPropsKey("OneTradeMargin");
		localSystemProps = (SystemProps) getService().get(localSystemProps);
		getService().getDao().evict(localSystemProps);
		localSystemProps = (SystemProps) getService().get(localSystemProps);
		this.request.setAttribute("oneTradeMargin", localSystemProps);
		return "success";
	}

	public String updateMargin() {
		SystemProps localSystemProps1 = (SystemProps) this.entity;
		getService().update(localSystemProps1);
		SystemProps localSystemProps2 = new SystemProps();
		localSystemProps2.setPropsKey("OneTradeMargin");
		localSystemProps2 = (SystemProps) getService().get(localSystemProps2);
		String str = this.request.getParameter("marginValue");
		localSystemProps2.setPropsValue(str);
		getService().update(localSystemProps2);
		addReturnValue(1, 119902L);
		writeOperateLog(2307, "修改委托诚信保障金参数中保障金值为：" + str + ";放大倍数为：" + localSystemProps1.getPropsValue() + "倍", 1, "");
		return "success";
	}

	public String updateSpendMargin() {
		String str1 = this.request.getParameter("mark");
		SystemProps localSystemProps = (SystemProps) this.entity;
		String str2 = this.request.getParameter("marginValue");
		if (str1.equals("0")) {
			getService().update(localSystemProps);
			SystemProps localObject = new SystemProps();
			((SystemProps) localObject).setPropsKey("OneTradeMargin");
			localObject = (SystemProps) getService().get((StandardModel) localObject);
			((SystemProps) localObject).setPropsValue(str2);
			getService().update((StandardModel) localObject);
		}
		Object localObject = new ArrayList();
		try {
			((List) localObject).add("OneTradeMargin");
			((List) localObject).add("TradeMarginMagnification");
			this.mgrService.setProperty((List) localObject);
			addReturnValue(1, 119902L);
			writeOperateLog(2307, "修改委托诚信保障金参数(实时生效),诚信保障金值为：" + str2 + ";诚信保障金倍数为：" + localSystemProps.getPropsValue() + "倍", 1, "");
		} catch (Exception localException) {
			addReturnValue(-1, 230002L, new Object[] { "实时生效未成功，请您稍后重试" });
			this.logger.error(Tools.getExceptionTrace(localException));
			writeOperateLog(2307, "修改委托诚信保障金参数(实时生效),诚信保障金值为：" + str2 + ";诚信保障金倍数为：" + localSystemProps.getPropsValue() + "倍", 0,
					localException.getMessage());
		}
		return "success";
	}

	public void getParameter(String paramString1, String paramString2) {
		SystemProps localSystemProps1 = new SystemProps();
		localSystemProps1.setPropsKey(paramString1);
		localSystemProps1 = (SystemProps) getService().get(localSystemProps1);
		SystemProps localSystemProps2 = new SystemProps();
		localSystemProps2.setPropsKey(paramString2);
		localSystemProps2 = (SystemProps) getService().get(localSystemProps2);
		getService().getDao().evict(localSystemProps2);
		localSystemProps2 = (SystemProps) getService().get(localSystemProps2).clone();
		String str;
		if ((localSystemProps2.getPropsValue() != null) && ("2".equals(localSystemProps1.getPropsValue()))) {
			str = expendStrNum(localSystemProps2.getPropsValue(), 100);
			localSystemProps2.setPropsValue(str);
		}
		if ((localSystemProps2.getRunTimeValue() != null) && ("2".equals(localSystemProps1.getRunTimeValue()))) {
			str = expendStrNum(localSystemProps2.getRunTimeValue(), 100);
			localSystemProps2.setRunTimeValue(str);
		}
		this.entity = localSystemProps2;
		this.request.setAttribute("mode", localSystemProps1);
	}

	public void updateParameter(String paramString) {
		SystemProps localSystemProps1 = (SystemProps) this.entity;
		String str1 = localSystemProps1.getPropsValue();
		SystemProps localSystemProps2 = new SystemProps();
		String str2 = this.request.getParameter("modeKey");
		String str3 = this.request.getParameter("modeValue");
		localSystemProps2.setPropsKey(str2);
		localSystemProps2 = (SystemProps) getService().get(localSystemProps2);
		localSystemProps2.setPropsValue(str3);
		if ("2".equals(str3)) {
			localSystemProps1.setPropsValue(narrowStrNum(localSystemProps1.getPropsValue(), 100));
		}
		getService().update(localSystemProps1);
		getService().update(localSystemProps2);
		String str4 = "";
		if ("1".equals(str3)) {
			str4 = str4 + "修改" + paramString + ",算法为：固定值;值为：" + localSystemProps1.getPropsValue() + "元";
		} else {
			str4 = str4 + "修改" + paramString + ",算法为：百分比;值为：" + str1 + "%";
		}
		writeOperateLog(2307, str4, 1, "");
	}

	public void updateSpendParameter(String paramString) {
		String str1 = this.request.getParameter("mark");
		if (str1.equals("0")) {
			updateParameter(paramString);
		}
		SystemProps localSystemProps1 = (SystemProps) this.entity;
		String str2 = this.request.getParameter("modeKey");
		ArrayList localArrayList = new ArrayList();
		try {
			localArrayList.add(str2);
			localArrayList.add(localSystemProps1.getPropsKey());
			this.mgrService.setProperty(localArrayList);
			addReturnValue(1, 119902L);
			SystemProps localSystemProps2 = new SystemProps();
			localSystemProps2.setPropsKey(str2);
			localSystemProps2 = (SystemProps) getService().get(localSystemProps2);
			getService().getDao().evict(localSystemProps2);
			localSystemProps2 = (SystemProps) getService().get(localSystemProps2).clone();
			localSystemProps1 = (SystemProps) getService().get(localSystemProps1);
			getService().getDao().evict(localSystemProps1);
			localSystemProps1 = (SystemProps) getService().get(localSystemProps1).clone();
			String str3 = "";
			if ("1".equals(localSystemProps2.getPropsValue())) {
				str3 = str3 + "修改" + paramString + "(实时生效),算法为：固定值;值为：" + localSystemProps1.getPropsValue() + "元";
			} else {
				String str4 = expendStrNum(localSystemProps1.getPropsValue(), 100);
				str3 = str3 + "修改" + paramString + "(实时生效),算法为：百分比;值为：" + str4 + "%";
			}
			writeOperateLog(2307, str3, 1, "");
		} catch (Exception localException) {
			addReturnValue(-1, 230002L, new Object[] { "实时生效未成功，请您稍后重试" });
			this.logger.error(Tools.getExceptionTrace(localException));
			writeOperateLog(2307, "修改" + paramString + "(实时生效)", 0, localException.getMessage());
		}
	}

	public void getSingleParameter(String paramString) {
		SystemProps localSystemProps = new SystemProps();
		localSystemProps.setPropsKey(paramString);
		localSystemProps = (SystemProps) getService().get(localSystemProps);
		getService().getDao().evict(localSystemProps);
		localSystemProps = (SystemProps) getService().get(localSystemProps);
		this.entity = localSystemProps;
	}

	public void updateSingleParameter(String paramString) {
		SystemProps localSystemProps = (SystemProps) this.entity;
		getService().update(localSystemProps);
		writeOperateLog(2307, "修改" + paramString + "为：" + localSystemProps.getPropsValue(), 1, "");
	}

	public String updateSpendSingleParameter(String paramString) {
		String str = this.request.getParameter("mark");
		if (str.equals("0")) {
			updateSingleParameter(paramString);
		}
		SystemProps localSystemProps = (SystemProps) this.entity;
		ArrayList localArrayList = new ArrayList();
		try {
			localArrayList.add(localSystemProps.getPropsKey());
			this.mgrService.setProperty(localArrayList);
			addReturnValue(1, 119902L);
			writeOperateLog(2307, "修改" + paramString + "(实时生效)为：" + localSystemProps.getPropsValue(), 1, "");
		} catch (Exception localException) {
			addReturnValue(-1, 230002L, new Object[] { "实时生效未成功，请您稍后重试" });
			this.logger.error(Tools.getExceptionTrace(localException));
			writeOperateLog(2307, "修改" + paramString + "(实时生效)为：" + localSystemProps.getPropsValue(), 0, localException.getMessage());
		}
		return "success";
	}

	public String expendStrNum(String paramString, int paramInt) {
		BigDecimal localBigDecimal = new BigDecimal(paramString);
		String str = localBigDecimal.multiply(new BigDecimal(paramInt)).setScale(3, 4).toString();
		return str;
	}

	public String narrowStrNum(String paramString, int paramInt) {
		BigDecimal localBigDecimal = new BigDecimal(paramString);
		String str = localBigDecimal.divide(new BigDecimal(paramInt)).toString();
		return str;
	}
}
