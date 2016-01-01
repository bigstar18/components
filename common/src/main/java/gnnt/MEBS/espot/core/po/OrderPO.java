/**
 * ===========================================================================
 * Title:  javaBean
 * Description:  XHTRADE, Version 1.0
 * Copyright (c) 2010-12.  All rights reserved. 
 * ============================================================================
 * Author:xuejt.
 */
package gnnt.MEBS.espot.core.po;

import gnnt.MEBS.espot.core.util.Tool;

import java.io.Serializable;
import java.util.Date;

/**
 * [E_Order].委托
 * 
 * @author : xuejt
 * @version 1.0
 */
public class OrderPO extends Clone implements Serializable {
	private static final long serialVersionUID = -4976835950963350623L;
	private long orderID;
	private long categoryID;
	private long breedID;
	private String orderTitle;
	private String bsFlag;
	private String firmID;
	private String traderID;
	private double price;
	private double quantity;
	private String unit;
	private long tradePreTime;
	private double tradeMargin_b;
	private double tradeMargin_s;
	private long deliveryDayType;
	private int deliveryType;
	private String deliveryAddress;
	private long deliveryPreTime;
	private Date deliveryDay;
	private double deliveryMargin_b;
	private double deliveryMargin_s;
	private String warehouseID;
	private String stockID;

	private long status = 0;// 状态只读属性 默认为0 未成交状态
	private double tradedQty = 0;// 成交数量只读属性 默认为0

	private long validTime;
	private Date orderTime;
	private Date effectOfTime;
	private Date withdrawTime;
	private String withdrawTraderID;
	private String remark;
	private int pledgeFlag;//
	private double minTradeQty;
	private double tradeUnit;
	private String isPickoff;
	private String isSuborder;
	private String isPayMargin = "N";
	private double frozenMargin;
	/**
	 * 交收类型
	 * 0： 协议交收 1：自主交收 
	 */
	private int tradeType;
	/**
	 * 付款类型(当自主交收时本字段有效)
	 * 0： 先款后货 1： 先货后款 2：不限制
	 */
	private int payType;

	/** 普通构造函数,注意:所有的属性都为NULL. */
	public OrderPO() {
	}

	/**
	 * 委托号
	 * 
	 * @return
	 */
	public long getOrderID() {
		return orderID;
	}

	/**
	 * 商品名称
	 * 
	 * @return
	 */
	public String getOrderTitle() {
		return orderTitle;
	}

	/**
	 * 商品名称
	 * 
	 * @param orderTitle
	 */
	public void setOrderTitle(String orderTitle) {
		this.orderTitle = orderTitle;
	}

	/**
	 * 买卖方向
	 * 
	 * @return
	 */
	public String getBSFlag() {
		return bsFlag;
	}

	/**
	 * 买卖方向
	 * 
	 * @param bsFlag
	 */
	public void setBSFlag(String bsFlag) {
		this.bsFlag = bsFlag;
	}

	/**
	 * @return 品名代码
	 */
	public long getBreedID() {
		return breedID;
	}

	/**
	 * @param 品名代码
	 */
	public void setBreedID(long breedID) {
		this.breedID = breedID;
	}

	/**
	 * 交易商代码
	 * 
	 * @return
	 */
	public String getFirmID() {
		return firmID;
	}

	/**
	 * 交易商代码
	 * 
	 * @param firmID
	 */
	public void setFirmID(String firmID) {
		this.firmID = firmID;
	}

	/**
	 * 单位价格
	 * 
	 * @return
	 */
	public double getPrice() {
		return price;
	}

	/**
	 * 单位价格
	 * 
	 * @param price
	 */
	public void setPrice(double price) {
		this.price = price;
	}

	/**
	 * 数量
	 * 
	 * @return
	 */
	public double getQuantity() {
		return quantity;
	}

	/**
	 * 数量
	 * 
	 * @param quantity
	 */
	public void setQuantity(double quantity) {
		this.quantity = quantity;
	}

	/**
	 * 商品单位
	 * 
	 * @return
	 */
	public String getUnit() {
		return unit;
	}

	/**
	 * 商品单位
	 * 
	 * @param unit
	 */
	public void setUnit(String unit) {
		this.unit = unit;
	}

	/**
	 * 交易准备时间 单位 秒
	 * 
	 * @return
	 */
	public long getTradePreTime() {
		return tradePreTime;
	}

	/**
	 * 交易准备天数
	 * 
	 * @param tradePreDays
	 */
	public void setTradePreTime(long tradePreTime) {
		this.tradePreTime = tradePreTime;
	}

	/**
	 *买方诚信保障金
	 * 
	 * @return
	 */
	public double getTradeMargin_b() {
		return tradeMargin_b;
	}

	/**
	 * 买方诚信保障金
	 * 
	 * @param tradeMargin_b
	 */
	public void setTradeMargin_b(double tradeMargin_b) {
		this.tradeMargin_b = tradeMargin_b;
	}

	/**
	 * 卖方诚信保障金
	 * 
	 * @return
	 */
	public double getTradeMargin_s() {
		return tradeMargin_s;
	}

	/**
	 * 卖方诚信保障金
	 * 
	 * @param tradeMargin_s
	 */
	public void setTradeMargin_s(double tradeMargin_s) {
		this.tradeMargin_s = tradeMargin_s;
	}

	/**
	 * 交割日类型 0：指定准备天数 1：指定最后交割日
	 * 
	 * @return
	 */
	public long getDeliveryDayType() {
		return deliveryDayType;
	}

	/**
	 * 交割日类型 0：指定准备天数 1：指定最后交割日
	 * 
	 * @param deliveryType
	 */
	public void setDeliveryDayType(long deliveryDayType) {
		this.deliveryDayType = deliveryDayType;
	}

	/**
	 * 交收地类型 1 指定仓库 2 指定交收地
	 * 
	 * @return
	 */
	public int getDeliveryType() {
		return deliveryType;
	}

	/**
	 * 交收地类型 1 指定仓库 2 指定交收地
	 * 
	 * @param deliveryType
	 */
	public void setDeliveryType(int deliveryType) {
		this.deliveryType = deliveryType;
	}

	/**
	 * 交割地
	 * 
	 * @return
	 */
	public String getDeliveryAddress() {
		return deliveryAddress;
	}

	/**
	 * 交割地
	 * 
	 * @param deliveryAddress
	 */
	public void setDeliveryAddress(String deliveryAddress) {
		this.deliveryAddress = deliveryAddress;
	}

	/**
	 * 交割准备时间 单位秒
	 * 
	 * @return
	 */
	public long getDeliveryPreTime() {
		return deliveryPreTime;
	}

	/**
	 * 交割准备时间 单位秒
	 * 
	 * @param deliveryPreDays
	 */
	public void setDeliveryPreTime(long deliveryPreTime) {
		this.deliveryPreTime = deliveryPreTime;
	}

	/**
	 * 交割日
	 * 
	 * @return
	 */
	public Date getDeliveryDay() {
		return deliveryDay;
	}

	/**
	 * 交割日
	 * 
	 * @param deliveryDay
	 */
	public void setDeliveryDay(Date deliveryDay) {
		this.deliveryDay = deliveryDay;
	}

	/**
	 * 买方交割保证金
	 * 
	 * @return
	 */
	public double getDeliveryMargin_b() {
		return deliveryMargin_b;
	}

	/**
	 * 买方交割保证金
	 * 
	 * @param deliveryMargin_b
	 */
	public void setDeliveryMargin_b(double deliveryMargin_b) {
		this.deliveryMargin_b = deliveryMargin_b;
	}

	/**
	 * 卖方交割保证金
	 * 
	 * @return
	 */
	public double getDeliveryMargin_s() {
		return deliveryMargin_s;
	}

	/**
	 * 卖方交割保证金
	 * 
	 * @param deliveryMargin_s
	 */
	public void setDeliveryMargin_s(double deliveryMargin_s) {
		this.deliveryMargin_s = deliveryMargin_s;
	}

	/**
	 * 交割仓库号
	 * 
	 * @return
	 */
	public String getWarehouseID() {
		return warehouseID;
	}

	/**
	 * 交割仓库号
	 * 
	 * @param warehouseID
	 */
	public void setWarehouseID(String warehouseID) {
		this.warehouseID = warehouseID;
	}

	/**
	 * 委托状态0：未成交 1：部分成交 2：全部成交 3：已下架 11：待审核
	 * 
	 * @return
	 */
	public long getStatus() {
		return status;
	}
	
	/**
	 * 根据数字状态转换中文意思用于提示信息的展示
	 * @return
	 */
	public String getStatusMeaning(){
		String sta="";
		switch (Tool.strToInt(this.getStatus()+"")) {
		case 0:
			sta="未成交";
			break;
		case 1:
			sta="部分成交";
			break;
		case 2:
			sta="全部成交";
			break;
		case 3:
			sta="已下架";
			break;
		case 4:
			sta="待审核";
			break;
		default:
			break;
		}
		return sta;
	}

	/**
	 * @param 委托状态0
	 *            ：未成交 1：部分成交 2：全部成交 3：已下架 11：待审核
	 */
	public void setStatus(long status) {
		this.status = status;
	}

	/**
	 * 已成交数量
	 * 
	 * @return
	 */
	public double getTradedQty() {
		return tradedQty;
	}

	/**
	 * 备注
	 * 
	 * @return
	 */
	public String getRemark() {
		return remark;
	}

	/**
	 * 备注
	 * 
	 * @param remark
	 */
	public void setRemark(String remark) {
		this.remark = remark;
	}

	/**
	 * 叶子节点分类号
	 * 
	 * @return
	 */
	public long getCategoryID() {
		return categoryID;
	}

	/**
	 * 叶子节点分类号
	 * 
	 * @param categoryID
	 */
	public void setCategoryID(long categoryID) {
		this.categoryID = categoryID;
	}

	/**
	 * 交易员代码
	 * 
	 * @return
	 */
	public String getTraderID() {
		return traderID;
	}

	/**
	 * 交易员代码
	 * 
	 * @param traderID
	 */
	public void setTraderID(String traderID) {
		this.traderID = traderID;
	}

	/**
	 * 撤单人
	 * 
	 * @return
	 */
	public String getWithdrawTraderID() {
		return withdrawTraderID;
	}

	/**
	 * 撤单人
	 * 
	 * @param withdrawTraderID
	 */
	public void setWithdrawTraderID(String withdrawTraderID) {
		this.withdrawTraderID = withdrawTraderID;
	}

	/**
	 * 委托时间
	 * 
	 * @return
	 */
	public Date getOrderTime() {
		return orderTime;
	}

	/**
	 * 
	 * 委托挂出时间
	 * <br/><br/>
	 * @return
	 */
	public Date getEffectOfTime() {
		return effectOfTime;
	}

	/**
	 * 扯撤单时间
	 * 
	 * @return
	 */
	public Date getWithdrawTime() {
		return withdrawTime;
	}

	/**
	 * @return 委托有效时间 单位秒
	 */
	public long getValidTime() {
		return validTime;
	}

	/**
	 * @param 委托有效时间
	 *            单位秒
	 */
	public void setValidTime(int validTime) {
		this.validTime = validTime;
	}

	/**
	 * @return 卖仓单标志：0 否 1 是
	 */
	public int getPledgeFlag() {
		return pledgeFlag;
	}

	/**
	 * @param 卖仓单标志
	 *            ：0 否 1 是
	 */
	public void setPledgeFlag(int pledgeFlag) {
		this.pledgeFlag = pledgeFlag;
	}

	/**
	 * @return 最小交易数量
	 */
	public double getMinTradeQty() {
		return minTradeQty;
	}

	/**
	 * @param 最小交易数量
	 */
	public void setMinTradeQty(double minTradeQty) {
		this.minTradeQty = minTradeQty;
	}

	/**
	 * @return 交易单位 即摘牌时候可摘牌的最小单位。如5；则摘牌数量必须为5的倍数；
	 */
	public double getTradeUnit() {
		return tradeUnit;
	}

	/**
	 * @param 交易单位
	 *            即摘牌时候可摘牌的最小单位。如5；则摘牌数量必须为5的倍数；
	 */
	public void setTradeUnit(double tradeUnit) {
		this.tradeUnit = tradeUnit;
	}

	/**
	 * @return 是否允许摘牌 Y 是 N 否
	 */
	public String getIsPickoff() {
		return isPickoff;
	}

	/**
	 * @param 是否允许摘牌
	 *            Y 是 N 否
	 */
	public void setIsPickoff(String isPickoff) {
		this.isPickoff = isPickoff;
	}

	/**
	 * @return 是否允许议价 Y 是 N 否
	 */
	public String getIsSuborder() {
		return isSuborder;
	}

	/**
	 * @param 是否允许议价
	 *            Y 是 N 否
	 */
	public void setIsSuborder(String isSuborder) {
		this.isSuborder = isSuborder;
	}

	/**
	 * @return 是否已经支付保证金 Y 是 N 否
	 */
	public String getIsPayMargin() {
		return isPayMargin;
	}

	/**
	 * @param 是否已经支付保证金
	 *            Y 是 N 否
	 */
	public void setIsPayMargin(String isPayMargin) {
		this.isPayMargin = isPayMargin;
	}

	/**
	 * @return 冻结保证金
	 */
	public double getFrozenMargin() {
		return frozenMargin;
	}

	/**
	 * @param 冻结保证金
	 */
	public void setFrozenMargin(double frozenMargin) {
		this.frozenMargin = frozenMargin;
	}

	/**
	 * 交易类型 0： 协议交收 1：自主交收
	 * @return int
	 */
	public int getTradeType() {
		return tradeType;
	}

	/**
	 * 交收类型 0： 协议交收 1：自主交收
	 * @param tradeType
	 */
	public void setTradeType(int tradeType) {
		this.tradeType = tradeType;
	}

	/**
	 * 交收类型(当自主交收时本字段有效) 0： 先款后货 1： 先货后款 2：不限制
	 * @return int
	 */
	public int getPayType() {
		return payType;
	}

	/**
	 * 付款类型(当自主交收时本字段有效) 0： 先款后货 1： 先货后款 2：不限制
	 * @param payType
	 */
	public void setPayType(int payType) {
		this.payType = payType;
	}
	/**
	 * 仓单号
	 * @return
	 */
	public String getStockID() {
		return stockID;
	}
	/**
	 * 仓单号
	 * @param stockID
	 */
	public void setStockID(String stockID) {
		this.stockID = stockID;
	}
	
}
