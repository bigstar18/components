package gnnt.MEBS.espot.core.vo;

import gnnt.MEBS.espot.core.po.OrderPO;
import gnnt.MEBS.espot.core.po.SubOrderPO;

/**
 * 摘牌返回处理结果
 * 
 * @author xuejt
 * 
 */
public class PickoffResultVO extends ResultVO {

	private static final long serialVersionUID = -3811195698663348555L;

	/**
	 * 合同号
	 */
	private long tradeNO = -1;

	/**
	 * 委托信息
	 */
	private OrderPO orderPO = null;

	private SubOrderPO subOrderPO = null;
	
	private boolean withDrawOrder=false;


	/**
	 * 委托信息
	 */
	public OrderPO getOrderPO() {
		return orderPO;
	}

	/**
	 * 委托信息
	 */
	public void setOrderPO(OrderPO orderPO) {
		this.orderPO = orderPO;
	}

	/**
	 * @return 议价委托
	 */
	public SubOrderPO getSubOrderPO() {
		return subOrderPO;
	}

	/**
	 * @param 议价委托
	 */
	public void setSubOrderPO(SubOrderPO subOrderPO) {
		this.subOrderPO = subOrderPO;
	}
	
	

	/**
	 * @return 摘牌后是否撤销委托
	 */
	public boolean isWithDrawOrder() {
		return withDrawOrder;
	}

	/**
	 * @param 摘牌后是否撤销委托
	 */
	public void setWithDrawOrder(boolean withDrawOrder) {
		this.withDrawOrder = withDrawOrder;
	}

	/**
	 * 合同号
	 */
	public long getTradeNO() {
		return tradeNO;
	}

	/**
	 * 合同号
	 */
	public void setTradeNO(long tradeNO) {
		this.tradeNO = tradeNO;
	}
}
