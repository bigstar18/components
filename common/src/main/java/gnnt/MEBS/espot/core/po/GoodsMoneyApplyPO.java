/**
 * ===========================================================================
 * Title:  javaBean
 * Description:  XHTRADE, Version 1.0
 * Copyright (c) 2012-7.  All rights reserved. 
 * ============================================================================
 * Author:xuejt.
 */

package gnnt.MEBS.espot.core.po;

import gnnt.MEBS.espot.core.util.Tool;

import java.io.Serializable;

/**
 * [E_LastGoodsMoneyApplyPO]. 尾款追缴申请对象
 * 
 * @author : xuejt
 * @version 1.0
 */
public class GoodsMoneyApplyPO extends Clone implements Serializable {
	private static final long serialVersionUID = -5790023882743436155L;
	private long ID;
	private long tradeNO;
	private int status;
	private int type;
	private java.util.Date createTime;
	private java.util.Date processTime;

	/** 普通构造函数,注意:所有的属性都为NULL. */
	public GoodsMoneyApplyPO() {
	}

	/**
	 * 申请代码
	 * 
	 * @return
	 */
	public long getID() {
		return ID;
	}

	/**
	 * 申请代码
	 * 
	 * @param offsetID
	 */
	public void setID(long ID) {
		this.ID = ID;
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
	 * 状态 0 卖方申请，1 卖方撤销，2 管理员撤销，3 系统撤销 4 已处理
	 * 
	 * @return
	 */
	public int getStatus() {
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
			sta="卖方申请";
			break;
		case 1:
			sta="卖方撤销";
			break;
		case 2:
			sta="管理员撤销";
			break;
		case 3:
			sta="系统撤销";
			break;
		case 4:
			sta="已处理";
			break;
		default:
			break;
		}
		return sta;
	}

	/**
	 * 状态 0 卖方申请，1 卖方撤销，2 管理员撤销，3 系统撤销 4 已处理
	 * 
	 * @param status
	 */
	public void setStatus(int status) {
		this.status = status;
	}

	/**
	 * @return 0 首款追缴 1 第二笔货款追缴 2 尾款追缴
	 */
	public int getType() {
		return type;
	}

	/**
	 * @param 0 首款追缴 1 第二笔货款追缴 2 尾款追缴
	 */
	public void setType(int type) {
		this.type = type;
	}

	/**
	 * 申请时间
	 * 
	 * @return
	 */
	public java.util.Date getCreateTime() {
		return createTime;
	}

	/**
	 * 申请时间
	 * 
	 * @param askTime
	 */
	public void setCreateTime(java.util.Date createTime) {
		this.createTime = createTime;
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

}