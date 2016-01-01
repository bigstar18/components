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


/**
 * [E_RESERVE]. 订单对象
 * 
 * @author : xuejt
 * @version 1.0
 */
public class ReservePO extends Clone implements Serializable {

	private static final long serialVersionUID = -4029817936409303758L;
	private long reserveID;
	private long tradeNO;
	private String firmID;
	private double realMoney;
	private String bsFlag;
	private double payableReserve;
	private double payReserve;
	private double backReserve;
	private double goodsQuantity;
	private long status;
	private long breachApplyID;

	/** 普通构造函数,注意:所有的属性都为NULL. */
	public ReservePO() {
	}

	/**
	 * 
	 * 订单号
	 * @return
	 */
	public long getReserveID() {
		return reserveID;
	}

	/**
	 * 
	 * 订单号
	 * @param reserveID
	 */
	public void setReserveID(long reserveID) {
		this.reserveID = reserveID;
	}

	/**
	 * 
	 * 合同号
	 * @return
	 */
	public long getTradeNO() {
		return tradeNO;
	}

	/**
	 * 
	 * 合同号
	 * @param tradeNO
	 */
	public void setTradeNO(long tradeNO) {
		this.tradeNO = tradeNO;
	}

	/**
	 * 
	 * 交易商代码
	 * @return
	 */
	public String getFirmID() {
		return firmID;
	}

	/**
	 * 
	 * 交易商代码
	 * @param firmID
	 */
	public void setFirmID(String firmID) {
		this.firmID = firmID;
	}

	/**
	 * 实际占用资金	
	 * 
	 * @return
	 */
	public double getRealMoney() {
		return realMoney;
	}

	/**
	 * 实际占用资金
	 * 
	 * @param realMoney
	 */
	public void setRealMoney(double  realMoney) {
		this.realMoney = realMoney;
	}

	/**
	 * 
	 * 买卖方向
	 * @return
	 */
	public String getBSFlag() {
		return bsFlag;
	}

	/**
	 * 
	 * 买卖方向
	 * @param bsFlag
	 */
	public void setBSFlag(String bsFlag) {
		this.bsFlag = bsFlag;
	}

	/**
	 * 应付履约保证金
	 * 
	 * @return
	 */
	public double getPayableReserve() {
		return payableReserve;
	}

	/**
	 * 应付履约保证金
	 * 
	 * @param payableReserve
	 */
	public void setPayableReserve(double payableReserve) {
		this.payableReserve = payableReserve;
	}

	/**
	 * 已付履约保证金
	 * 
	 * @return
	 */
	public double getPayReserve() {
		return payReserve;
	}

	/**
	 * 已付履约保证金
	 * 
	 * @param payReserve
	 */
	public void setPayReserve(double payReserve) {
		this.payReserve = payReserve;
	}

	/**
	 * 清退履约保证金
	 * 
	 * @return
	 */
	public double getBackReserve() {
		return backReserve;
	}

	/**
	 * 清退履约保证金
	 * 
	 * @param backReserve
	 */
	public void setBackReserve(double backReserve) {
		this.backReserve = backReserve;
	}

	/**
	 * 
	 * 仓单对应货物数量
	 * @return
	 */
	public double getGoodsQuantity() {
		return goodsQuantity;
	}

	/**
	 * 
	 * 仓单对应货物数量
	 * @param goodsQuantity
	 */
	public void setGoodsQuantity(double goodsQuantity) {
		this.goodsQuantity = goodsQuantity;
	}

	/**
	 * 
	 * 0：正常 1：货到或款到 2：已成交3：自己违约 4：对方违约
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
			sta="正常";
			break;
		case 1:
			sta="货到或款到";
			break;
		case 2:
			sta="已成交";
			break;
		case 3:
			sta="自己违约";
			break;
		case 4:
			sta="对方违约";
			break;
		default:
			break;
		}
		return sta;
	}
	/**
	 * 0：正常 1：货到或款到 2：已成交3：自己违约 4：对方违约
	 * 
	 * @param status
	 */
	public void setStatus(long status) {
		this.status = status;
	}

	/**
	 * 违约申请号
	 * 
	 * @return
	 */
	public long getBreachApplyID() {
		return breachApplyID;
	}

	/**
	 * 违约申请号
	 * 
	 * @param breachApplyID
	 */
	public void setBreachApplyID(long breachApplyID) {
		this.breachApplyID = breachApplyID;
	}

	/**
	 * 返回值对象调试信息字符串.
	 * 
	 * @return 值对象的调试信息
	 */
	public String toString() {
		StringBuffer sb = new StringBuffer();
		sb.append("[ReservePO:\n");

		sb.append("[Long |").append("reserveID|").append(this.reserveID)
				.append("]\n");
		sb.append("[Long |").append("tradeNO|").append(this.tradeNO).append(
				"]\n");
		sb.append("[String |").append("firmID|").append(this.firmID).append(
				"]\n");
		sb.append("[Double |").append("realMoney|").append(this.realMoney)
				.append("]\n");
		sb.append("[String |").append("bsFlag|").append(this.bsFlag).append(
				"]\n");
		sb.append("[Double |").append("payableReserve|").append(
				this.payableReserve).append("]\n");
		sb.append("[Double |").append("payReserve|").append(this.payReserve)
				.append("]\n");
		sb.append("[Double |").append("backReserve|").append(this.backReserve)
				.append("]\n");
		sb.append("[Long |").append("goodsQuantity|")
				.append(this.goodsQuantity).append("]\n");
		sb.append("[Long |").append("status|").append(this.status)
				.append("]\n");
		sb.append("[Long |").append("breachApplyID|")
				.append(this.breachApplyID).append("]\n");
		sb.append("]");
		return sb.toString();
	}
}