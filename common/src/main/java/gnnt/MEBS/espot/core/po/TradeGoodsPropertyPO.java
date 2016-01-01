package gnnt.MEBS.espot.core.po;

import java.io.Serializable;

/**
 * 委托对应的商品属性
 * 
 * @author xuejt
 * 
 */
public class TradeGoodsPropertyPO implements Serializable {

	private static final long serialVersionUID = 8086406995463541020L;
	private long tradeNO;
	private String propertyName;
	private String propertyValue;
	private long propertyTypeID;

	/** 普通构造函数,注意:所有的属性都为NULL. */
	public TradeGoodsPropertyPO() {
	}


	/**
	 * @return 合同号
	 */
	public long getTradeNO() {
		return tradeNO;
	}


	/**
	 * @param tradeNO 合同号
	 */
	public void setTradeNO(long tradeNO) {
		this.tradeNO = tradeNO;
	}





	/**
	 * 商品属性名
	 * 
	 * @return
	 */
	public java.lang.String getPropertyName() {
		return propertyName;
	}

	/**
	 * 商品属性名
	 * 
	 * @param propertyname
	 */
	public void setPropertyName(String propertyName) {
		this.propertyName = propertyName;
	}

	/**
	 * 商品属性值
	 * 
	 * @return
	 */
	public java.lang.String getPropertyValue() {
		return propertyValue;
	}

	/**
	 * 商品属性值
	 * 
	 * @param propertyvalue
	 */
	public void setPropertyValue(String propertyValue) {
		this.propertyValue = propertyValue;
	}

	/**
	 * 
	 * 商品类型编号
	 * <br/><br/>
	 * @return
	 */
	public long getPropertyTypeID() {
		return propertyTypeID;
	}

	/**
	 * 
	 * 商品类型编号
	 * <br/><br/>
	 * @param propertyTypeID
	 */
	public void setPropertyTypeID(long propertyTypeID) {
		this.propertyTypeID = propertyTypeID;
	}

	/**
	 * 返回值对象调试信息字符串.
	 * 
	 * @return 值对象的调试信息
	 */
	public String toString() {
		StringBuffer sb = new StringBuffer();
		sb.append("[GoodsPropertyPO:\n");

		sb.append("[long |").append("tradeNO|").append(this.tradeNO).append(
				"]\n");
		sb.append("[String |").append("propertyname|")
				.append(this.propertyName).append("]\n");
		sb.append("[String |").append("propertyvalue|").append(
				this.propertyValue).append("]\n");
		sb.append("]");
		return sb.toString();
	}
}
