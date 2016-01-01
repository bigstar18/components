package gnnt.MEBS.espot.core.vo;

/**
 * 支付货物返回包
 * 
 * @author xuejt
 * 
 */
public class PaymentGoodsVO extends ResultVO {

	private static final long serialVersionUID = 2068054575773995706L;
	
	private double quantity;

	/**
	 * 支付的仓单对应的货物数量
	 * 
	 * @return
	 */
	public double getQuantity() {
		return quantity;
	}

	/**
	 * 支付的仓单对应的货物数量
	 * 
	 * @param quantity
	 */
	public void setQuantity(double quantity) {
		this.quantity = quantity;
	}

}
