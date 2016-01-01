/**
 * ===========================================================================
 * Title:  javaBean
 * Description:  XHTRADE, Version 1.0
 * Copyright (c) 2010-12.  All rights reserved. 
 * ============================================================================
 * Author:xuejt.
 */

package gnnt.MEBS.bill.core.po;

import java.io.Serializable;


/**
 * [BI_GOODSPROPERTY]. 仓单系统 仓单属性
 * 
 * @author : xuejt
 * @version 1.0
 */
public class GoodsPropertyPO extends Clone implements Serializable {
	private static final long serialVersionUID = 623120016429374249L;

	private String stockID;
	private String propertyName;
	private String propertyValue;

	/** 普通构造函数,注意:所有的属性都为NULL. */
	public GoodsPropertyPO() {
	}


	/**
	 * 仓单号
	 * 
	 * @return
	 */
	public String getStockID() {
		return stockID;
	}

	/**
	 * 仓单号
	 * 
	 * @param stockID
	 */
	public void setStockID(String stockID) {
		this.stockID = stockID;
	}

	
	/**
	 * 商品属性名
	 * 
	 * @return
	 */
	public String getPropertyName() {
		return propertyName;
	}

	/**
	 * 商品属性名
	 * 
	 * @param propertyName
	 */
	public void setPropertyName(String propertyName) {
		this.propertyName = propertyName;
	}

	/**
	 * 商品属性值
	 * 
	 * @return
	 */
	public String getPropertyValue() {
		return propertyValue;
	}

	/**
	 * 商品属性值
	 * 
	 * @param propertyValue
	 */
	public void setPropertyValue(String propertyValue) {
		this.propertyValue = propertyValue;
	}

	/**
	 * 返回值对象调试信息字符串.
	 * 
	 * @return 值对象的调试信息
	 */
	public String toString() {
		StringBuffer sb = new StringBuffer();
		sb.append("[W_GoodsPropertyPO:\n");

		sb.append("[long |").append("stockID|").append(this.stockID).append(
				"]\n");
		sb.append("[String |").append("propertyName|")
				.append(this.propertyName).append("]\n");
		sb.append("[String |").append("propertyValue|").append(
				this.propertyValue).append("]\n");
		sb.append("]");
		return sb.toString();
	}
}