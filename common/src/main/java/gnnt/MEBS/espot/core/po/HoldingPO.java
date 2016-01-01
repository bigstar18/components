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
 * [E_HOLDING].持仓对象
 * 
 * @author : xuejt
 * @version 1.0
 */
public class HoldingPO extends Clone implements Serializable {
	private static final long serialVersionUID = 1105812495463052903L;
	private long holdingID;
	private long tradeNO;
	private String firmID;
	private String bsFlag;
	private double realMoney;
	private double payMargin;
	private double payGoodsMoney;
	private double payoff;
	private double receive;
	private double transferMoney;
	private long status;
	private long breachApplyID=-1;
	private long offsetID=-1;

	/** 普通构造函数,注意:所有的属性都为NULL. */
	public HoldingPO() {
	}

	/**
	 * 
	 * 持仓号
	 * @return
	 */
	public long getHoldingID() {
		return holdingID;
	}

	/**
	 * 持仓号
	 * 
	 * @param holdingID
	 */
	public void setHoldingID(long holdingID) {
		this.holdingID = holdingID;
	}

	/**
	 * 合同号
	 * 
	 * @return
	 */
	public long getTradeNO() {
		return tradeNO;
	}

	/**
	 * 合同号
	 * 
	 * @param tradeNO
	 */
	public void setTradeNO(long tradeNO) {
		this.tradeNO = tradeNO;
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
	 * 买卖方向
	 * 
	 * @return B:买 S:卖
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
	public void setRealMoney(double realMoney) {
		this.realMoney = realMoney;
	}

	/**
	 * 履约保证金
	 * 
	 * @return
	 */
	public double getPayMargin() {
		return payMargin;
	}

	/**
	 * 履约保证金
	 * 
	 * @param payMargin
	 */
	public void setPayMargin(double payMargin) {
		this.payMargin = payMargin;
	}

	
	/**
	 * 转入货/款 如果是买方则为转入货款 如果是买方则为转入货物数量
	 * 
	 * @return
	 */
	public double getPayGoodsMoney() {
		return payGoodsMoney;
	}

	/**
	 * 转入货/款 如果是买方则为转入货款 如果是买方则为转入货物数量
	 * 
	 * @param payGoodsMoney
	 */
	public void setPayGoodsMoney(double payGoodsMoney) {
		this.payGoodsMoney = payGoodsMoney;
	}

	/**
	 * 已付货/款 如果是买方则为已支付给卖方的货款 如果是卖方则为卖方已支付给买方的货物数量
	 * 
	 * @return
	 */
	public double getPayoff() {
		return payoff;
	}

	/**
	 * 已付货/款 如果是买方则为已支付给卖方的货款 如果是卖方则为卖方已支付给买方的货物数量
	 * 
	 * @param payoff
	 */
	public void setPayoff(double payoff) {
		this.payoff = payoff;
	}
	
	

	/**
	 * @return 收到的货/款 如果是买方则为买方收到的货物数量 如果是卖方则为收到的货款
	 */
	public double getReceive() {
		return receive;
	}

	/**
	 * @param 收到的货/款 如果是买方则为买方收到的货物数量 如果是卖方则为收到的货款
	 */
	public void setReceive(double receive) {
		this.receive = receive;
	}

	/**
	 * 转出货款
	 * 
	 * @return
	 */
	public double getTransferMoney() {
		return transferMoney;
	}

	/**
	 * 转出货款
	 * 
	 * @param transferMoney
	 */
	public void setTransferMoney(double transferMoney) {
		this.transferMoney = transferMoney;
	}

	

	/**
	 * 持仓状态： 1:正常 2：或款到或者货到 3：交割   4:自己违约 5 对方违约
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
		case 1:
			sta="正常";
			break;
		case 2:
			sta="货到或款到";
			break;
		case 3:
			sta="交割";
			break;
		case 4:
			sta="自己违约";
			break;
		case 5:
			sta="对方违约";
			break;
		default:
			break;
		}
		return sta;
	}

	/**
	 * 持仓状态：1:正常 2：或款到或者货到 3：交割   4:自己违约 5 对方违约
	 * 
	 * @param status
	 */
	public void setStatus(long status) {
		this.status = status;
	}

	/**
	 * 
	 * 违约申请号
	 * @return
	 */
	public long getBreachApplyID() {
		return breachApplyID;
	}

	/**
	 * 
	 * 违约申请号
	 * @param breachApplyID
	 */
	public void setBreachApplyID(long breachApplyID) {
		this.breachApplyID = breachApplyID;
	}

	/**
	 * 损益申请号
	 * 
	 * @return
	 */
	public long getOffsetID() {
		return offsetID;
	}

	/**
	 * 损益申请号
	 * 
	 * @param offsetID
	 */
	public void setOffsetID(long offsetID) {
		this.offsetID = offsetID;
	}

	/**
	 * 返回值对象调试信息字符串.
	 * 
	 * @return 值对象的调试信息
	 */
	public String toString() {
		StringBuffer sb = new StringBuffer();
		sb.append("[HoldingPO:\n");

		sb.append("[Long |").append("holdingID|").append(this.holdingID)
				.append("]\n");
		sb.append("[Long |").append("tradeNO|").append(this.tradeNO).append(
				"]\n");
		sb.append("[String |").append("firmID|").append(this.firmID).append(
				"]\n");
		sb.append("[String |").append("bsFlag|").append(this.bsFlag).append(
				"]\n");
		sb.append("[Long |").append("receive|").append(this.receive)
				.append("]\n");
		sb.append("[Double |").append("realMoney|").append(this.realMoney)
				.append("]\n");
		sb.append("[Double |").append("payMargin|").append(this.payMargin)
				.append("]\n");
		sb.append("[Double |").append("payGoodsMoney|")
				.append(this.payGoodsMoney).append("]\n");
		sb.append("[Double |").append("payoff|").append(this.payoff)
				.append("]\n");
		sb.append("[Double |").append("transferMoney|")
				.append(this.transferMoney).append("]\n");
		sb.append("[Long |").append("status|").append(this.status)
				.append("]\n");
		sb.append("[Long |").append("breachApplyID|")
				.append(this.breachApplyID).append("]\n");
		sb.append("[Long |").append("offsetID|").append(this.offsetID).append(
				"]\n");
		sb.append("]");
		return sb.toString();
	}
}