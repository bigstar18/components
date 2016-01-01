package gnnt.MEBS.espot.core.kernel;

import gnnt.MEBS.espot.core.vo.ResultVO;

import java.rmi.RemoteException;

/**
 * 成交阶段处理接口
 * 
 * @author xuejt
 * 
 */
public interface ITradeProcess {
	/**
	 * 处理违约的成交
	 * 
	 * @param tradeNO
	 *            成交号
	 * @param breachUserID
	 *            违约用户ID
	 * @return
	 */
	public ResultVO performTradeBreach(long tradeNO, String breachUserID);

	/**
	 * 处理待违约处理的合同
	 * 
	 * @param tradeNO
	 *            合同号
	 * @param operator
	 *            操作员
	 * @return
	 */
	public ResultVO performBreachingTrade(long tradeNO, String operator);

	/**
	 * 恢复待违约处理的合同为正常状态
	 * 
	 * @param tradeNO
	 *            合同号
	 * @param operator
	 *            操作员
	 * @return
	 */
	public ResultVO performRecoverTrade(long tradeNO, String operator);

	/**
	 * 申请损益
	 * 
	 * @param holdingID
	 *            持仓单号
	 * @param money
	 *            损益金额
	 * @return
	 */
	public ResultVO performAskOffset(long holdingID, double money);

	/**
	 * 处理损益
	 * 
	 * @param holdingID
	 *            持仓单号
	 * @return
	 */
	public ResultVO performDisposeOffset(long holdingID);

	/**
	 * 撤销损益
	 * 
	 * @param holdingID
	 *            持仓单号
	 * @return
	 */
	public ResultVO performWithdrawOffset(long holdingID);

	/**
	 * 追缴货款申请
	 * 
	 * @param tradeNO
	 *            合同号
	 * @return
	 */
	public ResultVO performAskGoodsMoney(long tradeNO);

	/**
	 * 撤销追缴货款申请
	 * 
	 * @param tradeNO
	 *            合同号
	 * @param operator
	 * @return
	 */
	public ResultVO performWithdrawGoodsMoney(long tradeNO,String operator);

	/**
	 * 申请对方违约
	 * 
	 * @param holdingID
	 *            持仓单号
	 * @return
	 */
	public ResultVO performBreachAsk(long holdingID);

	/**
	 * 撤销违约申请
	 * 
	 * @param holdingID
	 *            持仓单号
	 * @return
	 */
	public ResultVO performWithdrawAsk(long holdingID);

	/**
	 * 撤销合同
	 * 
	 * @param holdingID
	 *            持仓号
	 * 
	 * @param operator
	 *            操作人
	 * 
	 * @throws RemoteException
	 */
	public ResultVO withdrawTrade(long holdingID, String operator);

	/**
	 * 申请仲裁
	 * 
	 * @param tradeNO
	 *            合同号
	 * @param type
	 *            1 退货 2 退款 3 投诉
	 * @param apply
	 *            申请原因
	 * @param firmID
	 *            申请人
	 * @return
	 */
	public ResultVO applyArbitration(long tradeNO, int type, String apply,
			String firmID);

	/**
	 * 无损益处理
	 * 
	 * @param holdingID
	 * @return
	 */
	public ResultVO performWithoutOffset(long holdingID);

	/**
	 * 申请结束合同
	 * @param tradeNO 合同号
	 * @param firmID 交易商代码
	 * @return ResultVO
	 */
	public ResultVO performApplyEndTrade(long tradeNO,String firmID);

	/**
	 * 撤销结束合同申请
	 * @param tradeNO 合同号
	 * @param operator 撤销人
	 * @return ResultVO
	 */
	public ResultVO withdrawApplyEndTrade(long tradeNO,String operator);

	/**
	 * 同意结束合同申请
	 * @param tradeNO 合同号
	 * @param operator 处理人
	 * @return
	 */
	public ResultVO performEndTrade(long tradeNO,String operator);
}
