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
 * [E_TRADE].合同记录对象
 * 
 * @author : xuejt
 * @version 1.0
 */
public class TradePO extends Clone implements Serializable {

	private static final long serialVersionUID = 8146553341060862605L;
	private long tradeNO;
	private long breedID;
	private String orderTitle;
	private String bFirmID;
	private String sFirmID;
	private double price;
	private double quantity;
	private String unit;
	private int deliveryType;
	private String deliveryAddress;
	private java.util.Date deliveryDay;
	private double tradeMargin_b;
	private double tradeMargin_s;
	private long tradePreTime;
	private double deliveryMargin_b;
	private double deliveryMargin_s;
	private String warehouseID;
	private Date time;
	private String remark;
	private long status;
	private long orderID;
	private double buyTradeFee;
	private double buyPayTradeFee;
	private double buyDeliveryFee;
	private double buyPayDeliveryFee;
	private double sellTradeFee;
	private double sellPayTradeFee;
	private double sellDeliveryFee;
	private double sellPayDeliveryFee;
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
	public TradePO() {
	}

	/**
	 * 
	 * 合同号
	 * 
	 * @return
	 */
	public long getTradeNO() {
		return tradeNO;
	}

	/**
	 * 
	 * 合同号
	 * 
	 * @param tradeNO
	 */
	public void setTradeNO(long tradeNO) {
		this.tradeNO = tradeNO;
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
	 * 
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
	 * 
	 * 买方交易商代码
	 * 
	 * @return
	 */
	public String getBFirmID() {
		return bFirmID;
	}

	/**
	 * 买方交易商代码
	 * 
	 * @param bFirmID
	 */
	public void setBFirmID(String bFirmID) {
		this.bFirmID = bFirmID;
	}

	/**
	 * 
	 * 卖方交易商代码
	 * 
	 * @return
	 */
	public String getSFirmID() {
		return sFirmID;
	}

	/**
	 * 
	 * 卖方交易商代码
	 * 
	 * @param sFirmID
	 */
	public void setSFirmID(String sFirmID) {
		this.sFirmID = sFirmID;
	}

	/**
	 * 
	 * 成交价（单位价格）
	 * 
	 * @return
	 */
	public double getPrice() {
		return price;
	}

	/**
	 * 
	 * 成交价（单位价格）
	 * 
	 * @param price
	 */
	public void setPrice(double price) {
		this.price = price;
	}

	/**
	 * 成交量
	 * 
	 * @return
	 */
	public double getQuantity() {
		return quantity;
	}

	/**
	 * 成交量
	 * 
	 * @param quantity
	 */
	public void setQuantity(double quantity) {
		this.quantity = quantity;
	}

	/**
	 * 
	 * 商品单位
	 * 
	 * @return
	 */
	public String getUnit() {
		return unit;
	}

	/**
	 * 
	 * 商品单位
	 * 
	 * @param unit
	 */
	public void setUnit(String unit) {
		this.unit = unit;
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
	 * 交割日
	 * 
	 * @return
	 */
	public java.util.Date getDeliveryDay() {
		return deliveryDay;
	}

	/**
	 * 交割日
	 * 
	 * @param deliveryDay
	 */
	public void setDeliveryDay(java.util.Date deliveryDay) {
		this.deliveryDay = deliveryDay;
	}

	/**
	 * 
	 * 买方诚信保障金
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
	 * 
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
	 * 
	 * 交易准备时间 单位秒
	 * 
	 * @return
	 */
	public long getTradePreTime() {
		return tradePreTime;
	}

	/**
	 * 
	 * 交易准备时间 单位秒
	 * 
	 * @param tradePreTime
	 */
	public void setTradePreTime(long tradePreTime) {
		this.tradePreTime = tradePreTime;
	}

	/**
	 * 
	 * 买方履约保证金
	 * 
	 * @return
	 */
	public double getDeliveryMargin_b() {
		return deliveryMargin_b;
	}

	/**
	 * 买方履约保证金
	 * 
	 * @param deliveryMargin_b
	 */
	public void setDeliveryMargin_b(double deliveryMargin_b) {
		this.deliveryMargin_b = deliveryMargin_b;
	}

	/**
	 * 
	 * 卖方履约保证金
	 * 
	 * @return
	 */
	public double getDeliveryMargin_s() {
		return deliveryMargin_s;
	}

	/**
	 * 
	 * 卖方履约保证金
	 * 
	 * @param deliveryMargin_s
	 */
	public void setDeliveryMargin_s(double deliveryMargin_s) {
		this.deliveryMargin_s = deliveryMargin_s;
	}

	/**
	 * 
	 * 交割仓库
	 * 
	 * @return
	 */
	public String getWarehouseID() {
		return warehouseID;
	}

	/**
	 * 
	 * 交割仓库
	 * 
	 * @param warehouseID
	 */
	public void setWarehouseID(String warehouseID) {
		this.warehouseID = warehouseID;
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
	 * 合同签订时间
	 * 
	 * @return
	 */
	public Date getTime() {
		return time;
	}

	/**
	 * 合同签订时间
	 * 
	 * @param time
	 */
	public void setTime(Date time) {
		this.time = time;
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
	 * 合同状态 0：订单状态 1：订单阶段违约 2：订单阶段系统撤销 3：成交阶段 4：成交阶段违约 5：货、款到位 6：支付首款 
	 * 7:支付第二笔货款 8:支付尾款 21：待违约处理（买方违约） 22:待违约处理（卖方违约）
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
		if(this.getStatus()==0){
			sta="订单状态";
		}else if(this.getStatus()==1){
			sta="订单阶段违约";
		}else if(this.getStatus()==2){
			sta="订单阶段系统撤销";
		}else if(this.getStatus()==3){
			sta="成交阶段";
		}else if(this.getStatus()==4){
			sta="成交阶段违约";
		}else if(this.getStatus()==5){
			sta="货、款到位";
		}else if(this.getStatus()==6){
			sta="支付首款";
		}else if(this.getStatus()==7){
			sta="支付第二笔货款";
		}else if(this.getStatus()==8){
			sta="支付尾款";
		}else if(this.getStatus()==21){
			sta="待违约处理（买方违约）";
		}else if(this.getStatus()==22){
			sta="待违约处理（卖方违约）";
		}
		switch (Tool.strToInt(this.getStatus()+"")) {
		case 0:
			sta="订单状态";
			break;
		case 1:
			sta="订单阶段违约";
			break;
		case 2:
			sta="订单阶段系统撤销";
			break;
		case 3:
			sta="成交阶段";
			break;
		case 4:
			sta="成交阶段违约";
		case 5:
			sta="货、款到位";
			break;
		case 6:
			sta="支付首款";
			break;
		case 7:
			sta="支付第二笔货款";
			break;
		case 8:
			sta="支付尾款";
			break;
		case 21:
			sta="待违约处理（买方违约）";
			break;
		case 22:
			sta="待违约处理（卖方违约）";
			break;
		default:
			break;
		}
		return sta;
	}

	/**
	 * 合同状态 0：订单状态 1：订单阶段违约 2：订单阶段系统撤销 3：成交阶段 4：成交阶段违约 5：货、款到位 6：支付首款 
	 * 7:支付第二笔货款 8:支付尾款21：待违约处理（买方违约） 22:待违约处理（卖方违约）
	 * 
	 * @param status
	 */
	public void setStatus(long status) {
		this.status = status;
	}

	/**
	 * 
	 * 委托号
	 * 
	 * @return
	 */
	public long getOrderID() {
		return orderID;
	}

	/**
	 * 委托号
	 * 
	 * @param orderID
	 */
	public void setOrderID(long orderID) {
		this.orderID = orderID;
	}

	/**
	 * @return 买方交易手续费
	 */
	public double getBuyTradeFee() {
		return buyTradeFee;
	}

	/**
	 * @param 买方交易手续费
	 */
	public void setBuyTradeFee(double buyTradeFee) {
		this.buyTradeFee = buyTradeFee;
	}

	/**
	 * @return 买方已付交易手续费
	 */
	public double getBuyPayTradeFee() {
		return buyPayTradeFee;
	}

	/**
	 * @param 买方已付交易手续费
	 */
	public void setBuyPayTradeFee(double buyPayTradeFee) {
		this.buyPayTradeFee = buyPayTradeFee;
	}

	/**
	 * @return 买方交收手续费
	 */
	public double getBuyDeliveryFee() {
		return buyDeliveryFee;
	}

	/**
	 * @param 买方交收手续费
	 */
	public void setBuyDeliveryFee(double buyDeliveryFee) {
		this.buyDeliveryFee = buyDeliveryFee;
	}

	/**
	 * @return 买方已付交收手续费
	 */
	public double getBuyPayDeliveryFee() {
		return buyPayDeliveryFee;
	}

	/**
	 * @param 买方已付交收手续费
	 */
	public void setBuyPayDeliveryFee(double buyPayDeliveryFee) {
		this.buyPayDeliveryFee = buyPayDeliveryFee;
	}

	/**
	 * @return 卖方交易手续费
	 */
	public double getSellTradeFee() {
		return sellTradeFee;
	}

	/**
	 * @param 卖方交易手续费
	 */
	public void setSellTradeFee(double sellTradeFee) {
		this.sellTradeFee = sellTradeFee;
	}

	/**
	 * @return 卖方已付交易手续费
	 */
	public double getSellPayTradeFee() {
		return sellPayTradeFee;
	}

	/**
	 * @param 卖方已付交易手续费
	 */
	public void setSellPayTradeFee(double sellPayTradeFee) {
		this.sellPayTradeFee = sellPayTradeFee;
	}

	/**
	 * @return 卖方交收手续费
	 */
	public double getSellDeliveryFee() {
		return sellDeliveryFee;
	}

	/**
	 * @param 卖方交收手续费
	 */
	public void setSellDeliveryFee(double sellDeliveryFee) {
		this.sellDeliveryFee = sellDeliveryFee;
	}

	/**
	 * @return 卖方已付交收手续费
	 */
	public double getSellPayDeliveryFee() {
		return sellPayDeliveryFee;
	}

	/**
	 * @param 卖方交收手续费
	 */
	public void setSellPayDeliveryFee(double sellPayDeliveryFee) {
		this.sellPayDeliveryFee = sellPayDeliveryFee;
	}

	/**
	 * 交收类型 0： 协议交收 1：自主交收
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
	 * 付款类型(当自主交收时本字段有效) 0： 先款后货 1： 先货后款 2：不限制
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
}
