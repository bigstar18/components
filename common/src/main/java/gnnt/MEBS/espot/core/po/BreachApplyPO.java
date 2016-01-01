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
 * [E_BREACHAPPLY]. 违约申请对象
 * 
 * @author : xuejt
 * @version 1.0
 */
public class BreachApplyPO extends Clone implements Serializable {
	private static final long serialVersionUID = -8180758308465506834L;
	private long breachApplyID;
	private long tradeNO;
	private String firmID;
	private java.util.Date applyTime;
	private long delayTime;
	private java.util.Date processTime;
	private long status;

	/** 普通构造函数,注意:所有的属性都为NULL. */
	public BreachApplyPO() {
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
	 * 
	 * 成交号
	 * 
	 * @return
	 */
	public long getTradeNO() {
		return tradeNO;
	}

	/**
	 * 成交号
	 * 
	 * @param tradeNO
	 */
	public void setTradeNO(long tradeNO) {
		this.tradeNO = tradeNO;
	}

	/**
	 * 
	 * 交易员代码
	 * 
	 * @return
	 */
	public String getFirmID() {
		return firmID;
	}

	/**
	 * 交易员代码
	 * 
	 * @param firmID
	 */
	public void setFirmid(String firmID) {
		this.firmID = firmID;
	}

	/**
	 * 申请时间
	 * 
	 * @return
	 */
	public java.util.Date getApplyTime() {
		return applyTime;
	}

	/**
	 * 申请时间
	 * 
	 * @param time
	 */
	public void setApplyTime(java.util.Date applyTime) {
		this.applyTime = applyTime;
	}
	
	

	/**
	 * @return 违约申请一定时间后自动进行违约处理；处理延期时间
	 */
	public long getDelayTime() {
		return delayTime;
	}

	/**
	 * @param 违约申请一定时间后自动进行违约处理；处理延期时间
	 */
	public void setDelayTime(long delayTime) {
		this.delayTime = delayTime;
	}

	/**
	 * 处理时间
	 * 
	 * @return
	 */
	public java.util.Date getProcessTime() {
		return processTime;
	}

	/**
	 * 处理时间
	 * 
	 * @param processTime
	 */
	public void setProcessTime(java.util.Date processTime) {
		this.processTime = processTime;
	}

	/**
	 * 状态 0：未处理 1：已撤销 2：违约方满足条件撤销 3：违约处理
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
			sta="未处理";
			break;
		case 1:
			sta="已撤销";
			break;
		case 2:
			sta="违约方满足条件撤销";
			break;
		case 3:
			sta="违约处理";
			break;
		default:
			break;
		}
		return sta;
	}
	/**
	 * 状态 0：未处理 1：已撤销 2：违约方满足条件撤销 3：违约处理
	 * 
	 * @param status
	 */
	public void setStatus(long status) {
		this.status = status;
	}

	/**
	 * 返回值对象调试信息字符串.
	 * 
	 * @return 值对象的调试信息
	 */
	public String toString() {
		StringBuffer sb = new StringBuffer();
		sb.append("[BreachApplyPO:\n");

		sb.append("[Long |").append("breachapplyid|")
				.append(this.breachApplyID).append("]\n");
		sb.append("[Long |").append("tradeno|").append(this.tradeNO).append(
				"]\n");
		sb.append("[String |").append("firmid|").append(this.firmID).append(
				"]\n");
		sb.append("[java.util.Date|").append("applyTime|").append(this.applyTime).append(
				"]\n");
		sb.append("[java.util.Date|").append("processtime|").append(
				this.processTime).append("]\n");
		sb.append("[Long |").append("status|").append(this.status)
				.append("]\n");
		sb.append("]");
		return sb.toString();
	}
}