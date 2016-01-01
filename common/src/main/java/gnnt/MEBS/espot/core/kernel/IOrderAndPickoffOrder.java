package gnnt.MEBS.espot.core.kernel;

import gnnt.MEBS.espot.core.bo.OrderBO;
import gnnt.MEBS.espot.core.po.OrderPO;
import gnnt.MEBS.espot.core.po.SubOrderPO;
import gnnt.MEBS.espot.core.vo.OrderResultVO;
import gnnt.MEBS.espot.core.vo.PickoffResultVO;
import gnnt.MEBS.espot.core.vo.ResultVO;

/**
 * 挂牌摘牌阶段接口
 * 
 * @author xuejt
 * 
 */
public interface IOrderAndPickoffOrder {

	/**
	 * 完成挂牌处理
	 * 
	 * @param orderBO
	 *            委托业务对象
	 * @return
	 */
	public OrderResultVO performOrder(OrderBO orderBO);

	/**
	 * 完成卖仓单
	 * 
	 * @param orderPO
	 *            委托信息
	 * @param stockID
	 *            仓单号
	 * @return
	 */
	public OrderResultVO performOrderStock(OrderPO orderPO, String stockID);

	/**
	 * 撤销委托
	 * 
	 * @param orderID
	 *            委托号
	 * @param withdrawTraderID
	 *            撤单人
	 * @return
	 */
	public ResultVO withdrawOrder(long orderID, String withdrawTraderID);

	/**
	 * 完成议价处理
	 * 
	 * @param subOrderPO
	 *            子委托对象
	 * @return
	 */
	public ResultVO performSubOrder(SubOrderPO subOrderPO);

	/**
	 * 撤销议价
	 * 
	 * @param orderID
	 *            子委托号
	 * @param withdrawTraderID
	 *            撤单人
	 * @param type
	 *            类型 1 挂牌方撤销 2 议价方撤销 3 管理员撤销
	 * @return
	 */
	public ResultVO withdrawSubOrder(long subOrderID, String withdrawTraderID,
			int type);

	/**
	 * 答复议价
	 * 
	 * @param subOrderID
	 *            子委托号
	 * @param reply
	 *            答复内容
	 * @return
	 */
	public ResultVO replySubOrder(long subOrderID, String reply);

	/**
	 * 判断是否满足摘牌条件
	 * 
	 * @param actionUserID
	 *            摘牌用户ID
	 * @param orderID
	 *            挂牌ID
	 * @param subOrderID
	 *            子挂牌ID
	 * @param quantity
	 *            摘牌数量 如果为0则摘牌数量为委托中未成交的数量
	 * @param 是否直接支付保证金针对诚信保障金模式生效
	 * @return
	 */
	public PickoffResultVO isPickoff(String actionUserID, long orderID,
			long subOrderID, double quantity, boolean isPayMargin);

	/**
	 * 完成摘牌处理
	 * 
	 * @param actionUserID
	 *            摘牌用户
	 * @param orderID
	 *            委托号
	 * @param subOrderID
	 *            子委托号
	 * @param quantity
	 *            摘牌数量
	 * @param 是否直接支付保证金针对诚信保障金模式生效
	 * @return
	 */
	public PickoffResultVO performPickoff(String actionUserID, long orderID,
			long subOrderID, double quantity, boolean isPayMargin);
}
