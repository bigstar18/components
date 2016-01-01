/**
 * ===========================================================================
 * Title:  javaBean
 * Description:  XHTRADE, Version 1.0
 * Copyright (c) 2010-12.  All rights reserved. 
 * ============================================================================
 * Author:xuejt.
 */

package gnnt.MEBS.espot.core.po;

import java.io.Serializable;

/**
 * [E_BREACHAPPLY]. 违约申请对象
 * 
 * @author : xuejt
 * @version 1.0
 */
public class SubscriptionFlowPO extends Clone implements Serializable {
	private static final long serialVersionUID = -8180758308465506834L;
	private long flowID;
	private int oprCode;
	private String firmID;
	private double amount;
	private double banlance;
	private java.util.Date creatTime;

	/** 普通构造函数,注意:所有的属性都为NULL. */
	public SubscriptionFlowPO() {
	}

	/**
	 * @return 流水号
	 */
	public long getFlowID() {
		return flowID;
	}

	/**
	 * @param 流水号
	 */
	public void setFlowID(long flowID) {
		this.flowID = flowID;
	}

	/**
	 * @return 操作码 1 入金 2 出金 3 扣款
	 */
	public int getOprCode() {
		return oprCode;
	}

	/**
	 * @param 操作码
	 *            1 入金 2 出金 3 扣款
	 */
	public void setOprCode(int oprCode) {
		this.oprCode = oprCode;
	}

	/**
	 * @return 交易商代码
	 */
	public String getFirmID() {
		return firmID;
	}

	/**
	 * @param 交易商代码
	 */
	public void setFirmID(String firmID) {
		this.firmID = firmID;
	}

	/**
	 * @return 发生额
	 */
	public double getAmount() {
		return amount;
	}

	/**
	 * @param 发生额
	 */
	public void setAmount(double amount) {
		this.amount = amount;
	}

	/**
	 * @return 余额
	 */
	public double getBanlance() {
		return banlance;
	}

	/**
	 * @param 余额
	 */
	public void setBanlance(double banlance) {
		this.banlance = banlance;
	}

	/**
	 * @return 发生时间
	 */
	public java.util.Date getCreatTime() {
		return creatTime;
	}

	/**
	 * @param 发生时间
	 */
	public void setCreatTime(java.util.Date creatTime) {
		this.creatTime = creatTime;
	}
}