package gnnt.MEBS.timebargain.front.action;

import java.math.BigDecimal;
import java.rmi.RemoteException;
import java.util.ArrayList;
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
import gnnt.MEBS.common.front.statictools.Tools;
import gnnt.MEBS.timebargain.front.model.DelayOrderHistory;
import gnnt.MEBS.timebargain.front.service.DelayTradeService;
import gnnt.MEBS.timebargain.server.model.DelayOrder;
import gnnt.MEBS.timebargain.server.rmi.DelayRMI;

@Controller("delayTradeAction")
@Scope("request")
public class DelayTradeAction extends StandardAction {
	private static final long serialVersionUID = -7980403952928739624L;
	@Autowired
	@Qualifier("delayTradeService")
	private DelayTradeService delayTradeService;
	@Resource(name = "com_buySellFlag")
	private Map<String, String> buySellFlag;
	@Resource(name = "delay_delayOrderTypes")
	private Map<String, String> delayOrderTypes;
	@Resource(name = "delay_status")
	private Map<String, String> status;
	@Resource(name = "delay_withdrawType")
	private Map<String, String> withdrawType;
	private List<Map<Object, Object>> resultData = new ArrayList();
	private String resultMsg = "";
	@Autowired
	@Qualifier("DelayRMI")
	private DelayRMI delayRMI;

	public String getResultMsg() {
		return this.resultMsg;
	}

	public void setResultMsg(String resultMsg) {
		this.resultMsg = resultMsg;
	}

	public DelayTradeService getDelayTradeService() {
		return this.delayTradeService;
	}

	public void setDelayTradeService(DelayTradeService delayTradeService) {
		this.delayTradeService = delayTradeService;
	}

	public List<Map<Object, Object>> getResultData() {
		return this.resultData;
	}

	public void setResultData(List<Map<Object, Object>> resultData) {
		this.resultData = resultData;
	}

	public Map<String, String> getBuySellFlag() {
		return this.buySellFlag;
	}

	public void setBuySellFlag(Map<String, String> buySellFlag) {
		this.buySellFlag = buySellFlag;
	}

	public Map<String, String> getDelayOrderTypes() {
		return this.delayOrderTypes;
	}

	public void setDelayOrderTypes(Map<String, String> delayOrderTypes) {
		this.delayOrderTypes = delayOrderTypes;
	}

	public Map<String, String> getStatus() {
		return this.status;
	}

	public void setStatus(Map<String, String> status) {
		this.status = status;
	}

	public Map<String, String> getWithdrawType() {
		return this.withdrawType;
	}

	public void setWithdrawType(Map<String, String> withdrawType) {
		this.withdrawType = withdrawType;
	}

	public void setDelayRMI(DelayRMI delayRMI) {
		this.delayRMI = delayRMI;
	}

	public String delayTrade() {
		List<Map<Object, Object>> commodityIdList = comdtyCodeListQuery();
		Map<Object, Object> marketinfo = queryMarketInfo();
		this.resultData = delayQuotation_query();

		this.request.setAttribute("marketinfo", marketinfo);
		this.request.setAttribute("commodityIdList", commodityIdList);
		return "success";
	}

	public String delayRealTimeInfo() {
		this.resultData = delayQuotation_query();
		return "success";
	}

	public String delayOrderQuery() {
		User user = (User) this.request.getSession().getAttribute("CurrentUser");
		String commodityId = this.request.getParameter("commodityId");

		this.resultData = this.delayTradeService.delayOrderQuery(user.getBelongtoFirm().getFirmID(), commodityId);
		return "success";
	}

	public String cancelDelayOrder() {
		User user = (User) this.request.getSession().getAttribute("CurrentUser");
		Long sessionId = user.getSessionId();
		String[] orderNos = this.request.getParameterValues("orderNos[]");
		for (int i = 0; i < orderNos.length; i++) {
			DelayOrder delayOrder = this.delayTradeService.getDelayOrderById(orderNos[i]);
			if ((delayOrder.getStatus().shortValue() == 1) || (delayOrder.getStatus().shortValue() == 2)) {
				delayOrder.setWithdrawID(Long.valueOf(Long.parseLong(orderNos[i])));
				delayOrder.setDelayOrderType(new Short("4"));
				String msg = submitDelayOrder(sessionId.longValue(), delayOrder);
				this.logger.info("request checkBox:" + orderNos[i] + ",msg=" + this.resultMsg);
				this.resultMsg = (this.resultMsg + "委托号:" + orderNos[i] + "，处理结果：" + ("".equals(msg) ? "成功" : msg) + "\r\n");
			} else {
				this.resultMsg = (this.resultMsg + "委托号:" + orderNos[i] + "，处理结果：状态不符，撤销失败\r\n");
			}
		}
		return "success";
	}

	public String capitalQuery() {
		User user = (User) this.request.getSession().getAttribute("CurrentUser");
		String sql = "select (a.balance - a.frozenfunds) usefulFund,  a.frozenfunds from F_FIRMFUNDS  a where firmid = '"
				+ user.getBelongtoFirm().getFirmID() + "'";
		this.resultData = getService().getListBySql(sql);
		return "success";
	}

	public String delayCommodityHoldingQuery() {
		User user = (User) this.request.getSession().getAttribute("CurrentUser");
		String commodityId = this.request.getParameter("commodityId");

		this.resultData = this.delayTradeService.delayCommodityHoldingQuery(user.getBelongtoFirm().getFirmID(), commodityId);

		return "success";
	}

	public String delayOrder() {
		String commodityId = this.request.getParameter("commodityId");
		String delayOrderType = this.request.getParameter("delayOrderType");
		String bsFlag = this.request.getParameter("bsFlag");
		String quantity = this.request.getParameter("quantity");
		if (Short.valueOf(delayOrderType).shortValue() == 2) {
			bsFlag = this.delayTradeService.getNeutralSideById(commodityId);
		}
		User user = (User) this.request.getSession().getAttribute("CurrentUser");
		DelayOrder delayOrder = new DelayOrder();
		delayOrder.setCommodityID(commodityId);
		delayOrder.setDelayOrderType(Short.valueOf(delayOrderType));
		delayOrder.setBuyOrSell(Short.valueOf(bsFlag));
		delayOrder.setTraderID(user.getTraderID());
		delayOrder.setCustomerID(user.getBelongtoFirm().getFirmID() + "00");
		delayOrder.setQuantity(Long.valueOf(quantity));
		delayOrder.setFirmID(user.getBelongtoFirm().getFirmID());

		Long sessionId = user.getSessionId();

		boolean result = checkSettlePrivilege(delayOrder.getBuyOrSell(), delayOrder.getFirmID(), delayOrder.getDelayOrderType(),
				delayOrder.getCommodityID());
		if (result) {
			if (checkNeutralQty(delayOrder)) {
				this.resultMsg = submitDelayOrder(sessionId.longValue(), delayOrder);
				if ("".equals(this.resultMsg)) {
					this.resultMsg = "申报成功！";
				}
				// } else {
				// this.resultMsg = "超过'中立仓申报剩余量'";
			}
		} else {
			this.resultMsg = ("没有" + (delayOrder.getDelayOrderType().shortValue() == 1 ? "卖" : delayOrder.getBuyOrSell().shortValue() == 1 ? "买" : "")
					+ (delayOrder.getDelayOrderType().shortValue() == 1 ? "交收申报" : "中立仓申报") + "权限！");
		}
		return "success";
	}

	public String delayOrderHistory() {
		this.logger.debug("历史委托查询");
		User user = (User) this.request.getSession().getAttribute("CurrentUser");
		PageRequest<QueryConditions> pageRequest = null;
		try {
			pageRequest = ActionUtil.getPageRequest(this.request);
		} catch (Exception e) {
			this.logger.error(Tools.getExceptionTrace(e));
		}
		((QueryConditions) pageRequest.getFilters()).addCondition("traderID", "=", user.getTraderID());
		Page<StandardModel> page = getService().getPage(pageRequest, new DelayOrderHistory());
		this.request.setAttribute("pageInfo", page);
		this.request.setAttribute("oldParams", ActionUtil.getParametersStartingWith(this.request, "gnnt_"));

		return "success";
	}

	private boolean checkNeutralQty(DelayOrder delayOrder) {
		if (delayOrder.getDelayOrderType().shortValue() != 2) {
			return true;
		}
		String sql = "SELECT d.BuySettleQty, d.SellSettleQty, d.BuyNeutralQty, d.SellNeutralQty  from T_DelayQuotation d where d.CommodityID = '"
				+ delayOrder.getCommodityID() + "'";
		List<Map<Object, Object>> delayQuotationList = getService().getListBySql(sql);
		if ((delayQuotationList == null) || (delayQuotationList.size() == 0)) {
			throw new RuntimeException("商品 [" + delayOrder.getCommodityID() + "] 在递延交收行情表中未找到记录!");
		}
		Map<Object, Object> delayQuotationMap = (Map) delayQuotationList.get(0);
		int bsq = ((BigDecimal) delayQuotationMap.get("BUYSETTLEQTY")).intValue();
		int ssq = ((BigDecimal) delayQuotationMap.get("SELLSETTLEQTY")).intValue();
		int bnq = ((BigDecimal) delayQuotationMap.get("BUYNEUTRALQTY")).intValue();
		int snq = ((BigDecimal) delayQuotationMap.get("SELLNEUTRALQTY")).intValue();
		int bs_sq = bsq + bnq - (ssq + snq) < 0 ? ssq + snq - (bsq + bnq) : bsq + bnq - (ssq + snq);
		if (delayOrder.getQuantity().longValue() > bs_sq) {
			return false;
		}
		return true;
	}

	private boolean checkSettlePrivilege(Short buyOrSell, String firmID, Short delayorderType, String commodityID) {
		String sql = "select a.PrivilegeCode_B, a.PrivilegeCode_S From t_a_SettlePrivilege a Where a.Kind = 2 and a.Type='1' and a.typeID = '" +

		firmID + "' and KindID = '" + commodityID + "'";

		List<Map<Object, Object>> settlePrivilegList = getService().getListBySql(sql);
		if ((settlePrivilegList == null) || (settlePrivilegList.size() == 0)) {
			return false;
		}
		Iterator localIterator = settlePrivilegList.iterator();
		if (localIterator.hasNext()) {
			Map<Object, Object> settlePrivilegMap = (Map) localIterator.next();
			if (1 == buyOrSell.shortValue()) {
				String buyPrivilegeCode = String.valueOf(settlePrivilegMap.get("PRIVILEGECODE_B"));
				if ("101".equals(buyPrivilegeCode)) {
					return true;
				}
				if (("102".equals(buyPrivilegeCode)) && (1 == Short.valueOf(delayorderType.shortValue()).shortValue())) {
					return true;
				}
				if (("103".equals(buyPrivilegeCode)) && (2 == Short.valueOf(delayorderType.shortValue()).shortValue())) {
					return true;
				}
				return false;
			}
			String sellPrivilegeCode = String.valueOf(settlePrivilegMap.get("PRIVILEGECODE_S"));
			if ("101".equals(sellPrivilegeCode)) {
				return true;
			}
			if (("102".equals(sellPrivilegeCode)) && (1 == Short.valueOf(delayorderType.shortValue()).shortValue())) {
				return true;
			}
			if (("103".equals(sellPrivilegeCode)) && (2 == Short.valueOf(delayorderType.shortValue()).shortValue())) {
				return true;
			}
			return false;
		}
		return false;
	}

	public List<Map<Object, Object>> comdtyCodeListQuery() {
		String sql = "select CommodityID from T_Commodity where SettleWay = 1";
		return getService().getListBySql(sql);
	}

	public Map<Object, Object> queryMarketInfo() {
		String sql = "select * from T_a_market";
		return (Map) getService().getListBySql(sql).get(0);
	}

	public List<Map<Object, Object>> delayQuotation_query() {
		return this.delayTradeService.delayQuotation_query();
	}

	private String submitDelayOrder(long sessionID, DelayOrder ov) {
		int ret = 65286;
		String message = "";
		try {
			this.logger.info("------------>ready for submitDelayOrder.......");
			ret = this.delayRMI.order(sessionID, ov, "web");
			this.logger.info("------------>submitDelayOrder over....ret=" + ret);
		} catch (RemoteException e) {
			e.printStackTrace();
			message = "RemoteException : " + e.getMessage();
		} catch (Exception e) {
			e.printStackTrace();
			message = "Remot Application Error : " + e.getMessage();
		}
		switch (ret) {
		case 0:
			break;
		case 1:
			message = "身份不合法！";
			break;
		case 2:
			message = "市场未启用！";
			break;
		case 3:
			message = "现在不是交易时间！";
			break;
		case 4:
			message = "不是代为委托员交易时间！";
			break;
		case 5:
			message = "交易员和代为委托员不能同时存在！";
			break;
		case 10:
			message = "商品处于禁止交易状态！";
			break;
		case 11:
			message = "商品不属于当前交易节！";
			break;
		case 12:
			message = "委托价格超出涨幅上限！";
			break;
		case 13:
			message = "委托价格低于跌幅下限！";
			break;
		case 14:
			message = "委托价格不在此商品最小价位变动范围内！";
			break;
		case 15:
			message = "不存在此商品！";
			break;
		case 16:
			message = "委托数量不在此商品最小交收变动数量范围内！";
			break;
		case 17:
			message = "委托数量少于商品最小交收数量！";
			break;
		case 30:
			message = "此交易员不存在！";
			break;
		case 31:
			message = "此交易员没有操作该客户的权限！";
			break;
		case 32:
			message = "此交易客户不存在！";
			break;
		case 33:
			message = "此交易客户为禁止交易状态！";
			break;
		case 34:
			message = "此交易商不存在！";
			break;
		case 35:
			message = "此交易商为禁止交易状态！";
			break;
		case 37:
			message = "此代为委托员没有操作该交易商的权限！";
			break;
		case 38:
			message = "此代为委托员不存在！";
			break;
		case 40:
			message = "计算交易保证金错误！";
			break;
		case 41:
			message = "计算交易手续费错误！";
			break;
		case 42:
			message = "此委托已成交或已撤单！";
			break;
		case 50:
			message = "不是交收申报时间！";
			break;
		case 51:
			message = "不是中立仓申报时间！";
			break;
		case 52:
			message = "此商品不允许下中立仓！";
			break;
		case 53:
			message = "中立仓申报方向不对！";
			break;
		case 54:
			message = "未知被撤委托类型！";
			break;
		case 55:
			message = "该商品禁止交收申报！";
			break;
		case 56:
			message = "该商品禁止中立仓申报！";
			break;
		case 200:
			message = "代码异常而失败！";
			break;
		case -1:
			message = "持仓不足！";
			break;
		case -2:
			message = "资金余额不足！";
			break;
		case -7:
			message = "超过单笔最大委托量!";
			break;
		case -31:
			message = "持仓不足！";
			break;
		case -32:
			message = "仓单数量不足！";
			break;
		case -99:
			message = "执行存储时未找到相关数据！";
			break;
		case -100:
			message = "执行存储失败！";
			break;
		case -204:
			message = "交易服务器已关闭！";
			break;
		case -206:
			message = "委托信息不能为空！";
			break;
		default:
			ret = 65333;
			message = "未知异常！";
		}
		return message;
	}
}
