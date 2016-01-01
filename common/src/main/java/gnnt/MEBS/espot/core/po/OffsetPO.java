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
 * [E_OFFSET]. 损益申请对象
 * 
 * @author : xuejt
 * @version 1.0
 */
public class OffsetPO extends Clone implements Serializable {

	private static final long serialVersionUID = 8240429774067831383L;
	private long offsetID;
	private long tradeNO;
	private String firmID;
	private double offset;
	private long status;
	private java.util.Date applyTime;
	private java.util.Date processTime;

	/** 普通构造函数,注意:所有的属性都为NULL. */
	public OffsetPO() {
	}

	/**
	 * 损益申请代码
	 * 
	 * @return
	 */
	public long getOffsetID() {
		return offsetID;
	}

	/**
	 * 损益申请代码
	 * 
	 * @param offsetID
	 */
	public void setOffsetID(long offsetID) {
		this.offsetID = offsetID;
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
	 * 损益额度
	 * 
	 * @return
	 */
	public double getOffset() {
		return offset;
	}

	/**
	 * 损益额度
	 * 
	 * @param offset
	 */
	public void setOffset(double offset) {
		this.offset = offset;
	}

	/**
	 * 状态 0：未处理 1：已撤销 2：已处理
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
			sta="已处理";
			break;
		default:
			break;
		}
		return sta;
	}
	/**
	 * 状态 0：未处理 1：已撤销 2：已处理
	 * 
	 * @param status
	 */
	public void setStatus(long status) {
		this.status = status;
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
	 * @param askTime
	 */
	public void setApplyTime(java.util.Date applyTime) {
		this.applyTime = applyTime;
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
	 * 返回值对象调试信息字符串.
	 * 
	 * @return 值对象的调试信息
	 */
	public String toString() {
		StringBuffer sb = new StringBuffer();
		sb.append("[OffsetPO:\n");

		sb.append("[Long |").append("offsetID|").append(this.offsetID).append(
				"]\n");
		sb.append("[Long |").append("tradeNO|").append(this.tradeNO).append(
				"]\n");
		sb.append("[String |").append("firmID|").append(this.firmID).append(
				"]\n");
		sb.append("[double |").append("offset|").append(this.offset)
				.append("]\n");
		sb.append("[Long |").append("status|").append(this.status)
				.append("]\n");
		sb.append("[java.util.Date|").append("askTime|").append(this.applyTime)
				.append("]\n");
		sb.append("[java.util.Date|").append("processTime|").append(
				this.processTime).append("]\n");
		sb.append("]");
		return sb.toString();
	}
}