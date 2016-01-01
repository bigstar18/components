package gnnt.MEBS.espot.core.po;

import java.io.Serializable;

/***
 * 特殊权限
 * 
 * @author 薛计涛
 * 
 */
public class TradeRightPO extends Clone implements Serializable {

	private static final long serialVersionUID = 4450773780212302343L;
	/** 特殊权限ID */
	private Long tradeRightID;
	/** 交易商代码 */
	private String firmID;

	private int buyOrderAudit;

	private int sellOrderAudit;

	private int sellPledgeAudit;

	/**
	 * @return 交易权限代码
	 */
	public Long getTradeRightID() {
		return tradeRightID;
	}

	/**
	 * @param 交易权限代码
	 */
	public void setTradeRightID(Long tradeRightID) {
		this.tradeRightID = tradeRightID;
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
	 * @return 买委托是否需要审核权限 0：需要审核；1：不需要审核
	 */
	public int getBuyOrderAudit() {
		return buyOrderAudit;
	}

	/**
	 * @param 买委托是否需要审核权限
	 *           0：需要审核；1：不需要审核
	 */
	public void setBuyOrderAudit(int buyOrderAudit) {
		this.buyOrderAudit = buyOrderAudit;
	}

	/**
	 * @return 卖委托是否需要审核权限0：需要审核；1：不需要审核
	 */
	public int getSellOrderAudit() {
		return sellOrderAudit;
	}

	/**
	 * @param 卖委托是否需要审核权限
	 *           0：需要审核；1：不需要审核
	 */
	public void setSellOrderAudit(int sellOrderAudit) {
		this.sellOrderAudit = sellOrderAudit;
	}

	/**
	 * @return 卖仓单是否需要审核权限0：需要审核；1：不需要审核
	 */
	public int getSellPledgeAudit() {
		return sellPledgeAudit;
	}

	/**
	 * @param 卖仓单是否需要审核权限
	 *           0：需要审核；1：不需要审核
	 */
	public void setSellPledgeAudit(int sellPledgeAudit) {
		this.sellPledgeAudit = sellPledgeAudit;
	}
}
