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
 * [E_SUBORDER].子委托
 * 
 * @author : xuejt
 * @version 1.0
 */
public class SubOrderPO extends Clone implements Serializable {

	private static final long serialVersionUID = -577303843155063429L;
	private long suborderID;
	private long orderID;
	private String subFirmID;
	private double quantity;
	private double price;
	private String warehouseID;
	private long tradePreTime;
	private double deliveryMargin_b;
	private double deliveryMargin_s;
	private double frozenMargin;
	private String remark;
	private long status;

	private Date createTime;
	private String reply;
	private Date replyTime;
	private String withdrawer;
	private Date withdrawTime;
	private Integer deliveryDayType;
	private Date deliveryDay;
	private long deliveryPreTime;

	/** 普通构造函数,注意:所有的属性都为NULL. */
	public SubOrderPO() {
	}

	/**
	 * 子委托号
	 * 
	 * @return
	 */
	public long getSuborderID() {
		return suborderID;
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
	 * 委托号
	 * 
	 * @param orderID
	 */
	public void setOrderID(long orderID) {
		this.orderID = orderID;
	}

	/**
	 * 提出议价的交易商代码
	 * 
	 * @return
	 */
	public String getSubFirmID() {
		return subFirmID;
	}

	/**
	 * 提出议价的交易商代码
	 * 
	 * @param subFirmID
	 */
	public void setSubFirmID(String subFirmID) {
		this.subFirmID = subFirmID;
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
	 * 价格
	 * 
	 * @return
	 */
	public double getPrice() {
		return price;
	}

	/**
	 * 价格
	 * 
	 * @param price
	 */
	public void setPrice(double price) {
		this.price = price;
	}

	/**
	 * 交割仓库
	 * 
	 * @return
	 */
	public String getWarehouseID() {
		return warehouseID;
	}

	/**
	 * 价格仓库
	 * 
	 * @param warehouseID
	 */
	public void setWarehouseID(String warehouseID) {
		this.warehouseID = warehouseID;
	}

	/**
	 * 交易准备时间 单位秒
	 * 
	 * @return
	 */
	public long getTradePreTime() {
		return tradePreTime;
	}

	/**
	 * 交易准备时间 单位秒
	 * 
	 * @param tradePreTime
	 */
	public void setTradePreTime(long tradePreTime) {
		this.tradePreTime = tradePreTime;
	}

	/**
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
	 * 卖方履约保证金
	 * 
	 * @return
	 */
	public double getDeliveryMargin_s() {
		return deliveryMargin_s;
	}

	/**
	 * 卖方履约保证金
	 * 
	 * @param deliveryMargin_s
	 */
	public void setDeliveryMargin_s(double deliveryMargin_s) {
		this.deliveryMargin_s = deliveryMargin_s;
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
	 * 交收日类型
	 * @return
	 */
	public Integer getDeliveryDayType() {
		return deliveryDayType;
	}
	/**
	 * 交收日类型
	 * @param deliveryDayType
	 */
	public void setDeliveryDayType(Integer deliveryDayType) {
		this.deliveryDayType = deliveryDayType;
	}
	/**
	 * 交收日期
	 * @return
	 */
	public Date getDeliveryDay() {
		return deliveryDay;
	}
	/**
	 * 交收日期
	 * @param deliveryDay
	 */
	public void setDeliveryDay(Date deliveryDay) {
		this.deliveryDay = deliveryDay;
	}

	/**
	 * 交收准备期限
	 * @return
	 */
	public long getDeliveryPreTime() {
		return deliveryPreTime;
	}
	/**
	 * 交收准备期限
	 * @param deliveryPreTime
	 */
	public void setDeliveryPreTime(long deliveryPreTime) {
		this.deliveryPreTime = deliveryPreTime;
	}

	/**
	 * 0：等待挂牌方答复 1：挂牌方接受 2：挂牌方拒绝 3：摘牌方撤单 4：系统自动撤单 5：管理员撤单
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
			sta="等待挂牌方答复";
			break;
		case 1:
			sta="挂牌方接受";
			break;
		case 2:
			sta="挂牌方拒绝";
			break;
		case 3:
			sta="摘牌方撤单";
			break;
		case 4:
			sta="系统自动撤单";
			break;
		case 5:
			sta="管理员撤单";
			break;
		default:
			break;
		}
		return sta;
	}

	/**
	 * 0：等待挂牌方答复 1：挂牌方接受 2：挂牌方拒绝 3：摘牌方撤单 4：系统自动撤单 5：管理员撤单
	 * 
	 * @param status
	 */
	public void setStatus(long status) {
		this.status = status;
	}

	/**
	 * 答复
	 * 
	 * @return
	 */
	public String getReply() {
		return reply;
	}

	/**
	 * 答复
	 * 
	 * @param reply
	 */
	public void setReply(String reply) {
		this.reply = reply;
	}

	/**
	 * 创建时间
	 * 
	 * @return
	 */
	public Date getCreateTime() {
		return createTime;
	}

	/**
	 * 答复时间
	 * 
	 * @return
	 */
	public Date getReplyTime() {
		return replyTime;
	}

	/**
	 * @return the 撤单人
	 */
	public String getWithdrawer() {
		return withdrawer;
	}

	/**
	 * @param 设置撤单人
	 */
	public void setWithdrawer(String withdrawer) {
		this.withdrawer = withdrawer;
	}

	/**
	 * @return 撤单时间
	 */
	public Date getWithdrawTime() {
		return withdrawTime;
	}

	/**
	 * @param 设置撤单时间
	 */
	public void setWithdrawTime(Date withdrawTime) {
		this.withdrawTime = withdrawTime;
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
}