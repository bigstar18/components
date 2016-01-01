package gnnt.MEBS.espot.core.po;


import java.io.Serializable;

/**
 * 交易商资金信息
 * 
 * @author xuejt
 * 
 */
public class FirmFundsPO extends Clone implements Serializable {

	private static final long serialVersionUID = -9142035761837151858L;
	private String firmID;
	private double margin;
	private double goodsMoney;
	private double transferLoss;
	private double subscription;

	/** 普通构造函数,注意:所有的属性都为NULL. */
	public FirmFundsPO() {
	}

	/**
	 * 交易商代码
	 * 
	 * @return
	 */
	public java.lang.String getFirmID() {
		return firmID;
	}

	/**
	 * 交易商代码
	 * 
	 * @return
	 */
	public void setFirmid(String firmID) {
		this.firmID = firmID;
	}

	/**
	 * 保证金
	 * 
	 * @return
	 */
	public double getMargin() {
		return margin;
	}

	/**
	 * 保证金
	 * 
	 * @param margin
	 */
	public void setMargin(double margin) {
		this.margin = margin;
	}

	/**
	 * 货款
	 * 
	 * @return
	 */
	public double getGoodsMoney() {
		return goodsMoney;
	}

	/**
	 * 货款
	 * 
	 * @param goodsmoney
	 */
	public void setGoodsMoney(double goodsMoney) {
		this.goodsMoney = goodsMoney;
	}

	/**
	 * 转让盈亏
	 * 
	 * @return
	 */
	public double getTransferLoss() {
		return transferLoss;
	}

	/**
	 * 转让盈亏
	 * 
	 * @param transferloss
	 */
	public void setTransferLoss(double transferLoss) {
		this.transferLoss = transferLoss;
	}

	/**
	 * 订金
	 * 
	 * @return
	 */
	public double getSubscription() {
		return subscription;
	}

	/**
	 * 订金
	 * 
	 * @param subscription
	 */
	public void setSubscription(double subscription) {
		this.subscription = subscription;
	}

	/**
	 * 返回值对象调试信息字符串.
	 * 
	 * @return 值对象的调试信息
	 */
	public String toString() {
		StringBuffer sb = new StringBuffer();
		sb.append("[FirmFundsPO:\n");

		sb.append("[Java.lang.String |").append("firmid|").append(this.firmID).append("]\n");
		sb.append("[double|").append("margin|").append(this.margin).append("]\n");
		sb.append("[double|").append("goodsmoney|").append(this.goodsMoney).append("]\n");
		sb.append("[double|").append("transferloss|").append(this.transferLoss).append("]\n");
		sb.append("[double |").append("subscription|").append(this.subscription).append("]\n");
		sb.append("]");
		return sb.toString();
	}
}
