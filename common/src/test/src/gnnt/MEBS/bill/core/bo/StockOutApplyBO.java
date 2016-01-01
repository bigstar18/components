
package gnnt.MEBS.bill.core.bo;
/**
 * <P>类说明：仓单出库申请BO
 * <br/>
 * <br/>
 * </p>
 * 修改记录:
 * <br/>
 * <ul>
 * 
 * <li> 创建类                    |2013-12-23上午11:40:51|金网安泰 </li>
 * 
 * </ul>
 * @author liuzx
 */
public class StockOutApplyBO extends BaseBO{
	/** 序列编号 */
	private static final long serialVersionUID = -4656133476939960187L;

	/** 仓单编号 */
	private String stockID;

	/** 提货人 */
	private String deliveryPerson;

	/** 提货人身份证号 */
	private String idnumber;

	/**
	 * 
	 * 仓单编号
	 * <br/><br/>
	 * @return
	 */
	public String getStockID() {
		return stockID;
	}

	/**
	 * 
	 * 仓单编号
	 * <br/><br/>
	 * @param stockID
	 */
	public void setStockID(String stockID) {
		this.stockID = stockID;
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

}

