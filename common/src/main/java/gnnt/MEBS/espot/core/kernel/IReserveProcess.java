package gnnt.MEBS.espot.core.kernel;

import gnnt.MEBS.espot.core.vo.ResultVO;

/**
 * 订单阶段处理接口
 * 
 * @author xuejt
 * 
 */
public interface IReserveProcess {
	/**
	 * 订单转成交
	 * 
	 * @param tradeNO
	 *            合同号
	 * @return
	 */
	public ResultVO performReserveToTrade(long tradeNO);

	/**
	 * 申请对方违约
	 * 
	 * @param reserveID
	 *            订单ID
	 * @return
	 */
	public ResultVO performBreachAsk(long reserveID);

	/**
	 * 撤销违约申请
	 * 
	 * @param reserveID
	 *            订单ID
	 * @return
	 */
	public ResultVO performWithdrawAsk(long reserveID);

	/**
	 * 处理违约的订单
	 * 
	 * @param tradeNO
	 *            合同号
	 * @param breachType
	 *            违约类型 0:双方违约 1:买方违约 2：卖方违约
	 * @return
	 */
	public ResultVO performReserveBreach(long tradeNO, int breachType);
	
	/**
	 * 撤销订单
	 * 
	 * @param reserveID
	 *            订单号
	 * @param operator
	 *            操作人
	 * 
	 */
	public ResultVO withdrawReserve(long reserveID, String operator);
}
