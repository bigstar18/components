
package gnnt.MEBS.bill.core.po;

import java.io.Serializable;
import java.util.Date;

/**
 * <P>类说明：
 * <br/>
 * <br/>
 * </p>
 * 修改记录:
 * <br/>
 * <ul>
 * 
 * <li> 创建类                    |2014-1-2下午01:49:56|金网安泰 </li>
 * 
 * </ul>
 * @author liuzx
 */
public class OutStockPO extends Clone implements Serializable{
	/** 序列编号 */
	private static final long serialVersionUID = -4848377573354299414L;

	/** 出库编号 */
	private long outStockID;

	/** 仓单号 */
	private String stockID;

	/** 出库密钥 */
	private String key;

	/** 提货人 */
	private String deliveryPerson;

	/** 提货人身份证号 */
	private String idnumber;

	/**
	 * 状态<br/>
	 * 0 出库申请 1 撤销出库申请 2 出库完成
	 */
	private int status;

	/** 创建时间 */
	private Date createTime;

	/** 处理时间 */
	private Date processTime;

	/**
	 * 
	 * 出库编号
	 * <br/><br/>
	 * @return
	 */
	public long getOutStockID() {
		return outStockID;
	}

	/**
	 * 
	 * 出库编号
	 * <br/><br/>
	 * @param outStockID
	 */
	public void setOutStockID(long outStockID) {
		this.outStockID = outStockID;
	}

	/**
	 * 
	 * 仓单号
	 * <br/><br/>
	 * @return
	 */
	public String getStockID() {
		return stockID;
	}

	/**
	 * 
	 * 仓单号
	 * <br/><br/>
	 * @param stockID
	 */
	public void setStockID(String stockID) {
		this.stockID = stockID;
	}

	/**
	 * 
	 * 出库密钥
	 * <br/><br/>
	 * @return
	 */
	public String getKey() {
		return key;
	}

	/**
	 * 
	 * 出库密钥
	 * <br/><br/>
	 * @param key
	 */
	public void setKey(String key) {
		this.key = key;
	}

	/**
	 * 
	 * 提货人
	 * <br/><br/>
	 * @return
	 */
	public String getDeliveryPerson() {
		return deliveryPerson;
	}

	/**
	 * 
	 * 提货人
	 * <br/><br/>
	 * @param deliveryPerson
	 */
	public void setDeliveryPerson(String deliveryPerson) {
		this.deliveryPerson = deliveryPerson;
	}

	/**
	 * 
	 * 提货人身份证号
	 * <br/><br/>
	 * @return
	 */
	public String getIdnumber() {
		return idnumber;
	}

	/**
	 * 
	 * 提货人身份证号
	 * <br/><br/>
	 * @param idnumber
	 */
	public void setIdnumber(String idnumber) {
		this.idnumber = idnumber;
	}

	/**
	 * 
	 * 状态<br/>
	 * 0 出库申请 1 撤销出库申请 2 出库完成
	 * <br/><br/>
	 * @return
	 */
	public int getStatus() {
		return status;
	}

	/**
	 * 
	 * 状态<br/>
	 * 0 出库申请 1 撤销出库申请 2 出库完成
	 * <br/><br/>
	 * @param status
	 */
	public void setStatus(int status) {
		this.status = status;
	}

	/**
	 * 
	 * 创建时间
	 * <br/><br/>
	 * @return
	 */
	public Date getCreateTime() {
		return createTime;
	}

	/**
	 * 
	 * 创建时间
	 * <br/><br/>
	 * @param createTime
	 */
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	/**
	 * 
	 * 处理时间
	 * <br/><br/>
	 * @return
	 */
	public Date getProcessTime() {
		return processTime;
	}

	/**
	 * 
	 * 处理时间
	 * <br/><br/>
	 * @param processTime
	 */
	public void setProcessTime(Date processTime) {
		this.processTime = processTime;
	}

}

