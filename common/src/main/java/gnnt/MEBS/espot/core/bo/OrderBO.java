package gnnt.MEBS.espot.core.bo;

import gnnt.MEBS.espot.core.po.GoodsPropertyPO;
import gnnt.MEBS.espot.core.po.OrderPO;

import java.io.Serializable;
import java.util.List;

/**
 * 委托 业务对象
 * 
 * @author xuejt
 * 
 */
public class OrderBO implements Serializable {

	private static final long serialVersionUID = 2840485486410934826L;

	/**
	 * 委托对象
	 */
	public OrderPO orderPO;

	/**
	 * 委托对应的商品属性列表
	 */
	public List<GoodsPropertyPO> goodsPropertyPOList;

	/**
	 * 是否立刻支付保证金
	 */
	public boolean isPayMargin;
}
