package gnnt.MEBS.espot.core.kernel;

import gnnt.MEBS.espot.core.po.ReservePO;
import gnnt.MEBS.espot.core.vo.ResultVO;

/**
 * 
 * 交易资金处理接口
 * 
 * 
 * @author xuejt
 * 
 */
public interface IFundsProcess {

	/**
	 * 转入诚信保障金
	 * 
	 * @param firmID
	 *            交易商代码
	 * @param money
	 *            转入金额
	 * @return
	 */
	public ResultVO paymentSubscription(String firmID, double money);

	/**
	 * 退还诚信保障金
	 * 
	 * @param firmID
	 *            交易商代码
	 * @param money
	 *            退还金额
	 * @return
	 */
	public ResultVO refundmentSubscription(String firmID, double money);

	/**
	 * 为订单转入履约保证金
	 * 
	 * @param reservePO
	 *            订单
	 * @param money
	 *            转入金额
	 * @return
	 */
	public ResultVO paymentReserve(ReservePO reservePO, double money);

	/**
	 * 为订单转入履约保证金
	 * 
	 * @param userID
	 *            用户ID
	 * @param tradeID
	 *            合同号
	 * @param money
	 *            转入金额
	 * @return
	 */
	public ResultVO paymentReserve(String userID, long tradeID, double money);

	/**
	 * 转入货款
	 * 
	 * @param holdingID
	 *            持仓单号
	 * @return
	 */
	public ResultVO paymentGoodsMoney(long holdingID);

	/**
	 * 转入货款
	 * 
	 * @param holdingID
	 *            持仓单号
	 * @param money
	 *            货款金额
	 * 
	 * @param lastPayment
	 *            是否最后一次转入；当转入的金额在溢长溢短范围内时判断是否完成付款
	 * 
	 * @return
	 */
	public ResultVO paymentGoodsMoney(long holdingID, double money,
			boolean lastPayment);

	/**
	 * 支付货款给卖方
	 * 
	 * @param holdingID
	 *            持仓单号
	 * @param money
	 *            支付金额
	 * @return
	 */
	public ResultVO paymentMoneyToSell(long holdingID, double money);

	/**
	 * 支付首款给卖方
	 * 
	 * @param holdingID
	 *            持仓单号
	 * @param percent
	 *            货款比例
	 * @return
	 */
	public ResultVO paymentFirstMoneyToSell(long holdingID, double percent);

	/**
	 * 支付第二次货款给卖方
	 * 
	 * @param holdingID
	 *            持仓单号
	 * @param percent
	 *            货款比例
	 * @return
	 */
	public ResultVO paymentSecondMoneyToSell(long holdingID, double percent);

	/**
	 * 支付尾款给卖方
	 * 
	 * @param holdingID
	 *            持仓单号
	 * @return
	 */
	public ResultVO paymentBalanceToSell(long holdingID);

}
