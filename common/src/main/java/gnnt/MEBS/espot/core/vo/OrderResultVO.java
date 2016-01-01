package gnnt.MEBS.espot.core.vo;

/**
 * 委托返回处理结果
 * @author xuejt
 *
 */
public class OrderResultVO extends ResultVO {
	private static final long serialVersionUID = 5214991479154769322L;
	/**
	 * 委托号
	 */
	private long orderID=-1;
	
	/**
	 * 委托号
	 */
	public long getOrderID() {
		return orderID;
	}

	/**
	 * 委托号
	 */
	public void setOrderID(long orderID) {
		this.orderID = orderID;
	}
	
	
}
