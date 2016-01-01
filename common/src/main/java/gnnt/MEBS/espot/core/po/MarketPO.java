package gnnt.MEBS.espot.core.po;

import java.io.Serializable;
import java.util.Date;

/**
 * 市场参数对象.
 * 
 * @author xuejt
 */
public class MarketPO extends Clone implements Serializable {
	private static final long serialVersionUID = 3690197650654049813L;

	private String marketName;

	private int status;

	private String recoverTime;

	private String runMode;
	
	private Date tradeDate;

	/**
	 * @return 市场名称
	 */
	public String getMarketName() {
		return marketName;
	}

	/**
	 * @param 市场名称
	 */
	public void setMarketName(String marketName) {
		this.marketName = marketName;
	}

	/**
	 * @return 系统状态
	 */
	public int getStatus() {
		return status;
	}

	/**
	 * @param 系统状态
	 */
	public void setStatus(int status) {
		this.status = status;
	}

	/**
	 * @return 暂停后恢复时间
	 */
	public String getRecoverTime() {
		return recoverTime;
	}

	/**
	 * @param 暂停后恢复时间
	 */
	public void setRecoverTime(String recoverTime) {
		this.recoverTime = recoverTime;
	}

	/**
	 * @return 运行模式 A 自动 M 手动
	 */
	public String getRunMode() {
		return runMode;
	}

	/**
	 * @param 运行模式 A 自动 M 手动
	 */
	public void setRunMode(String runMode) {
		this.runMode = runMode;
	}

	/**
	 * @return 交易日期
	 */
	public Date getTradeDate() {
		return tradeDate;
	}

	/**
	 * @param 交易日期
	 */
	public void setTradeDate(Date tradeDate) {
		this.tradeDate = tradeDate;
	}

	public String toString() {
		StringBuffer sb = new StringBuffer();
		sb.append("[MarketPO:\n");

		sb.append("[String |").append("marketName|").append(this.marketName)
				.append("]\n");
		sb.append("[int |").append("status|").append(this.status).append("]\n");
		sb.append("[String |").append("recoverTime|").append(this.recoverTime)
				.append("]\n");
		sb.append("[String |").append("runMode|").append(this.runMode)
				.append("]\n");
		sb.append("[Date |").append("tradeDate|").append(this.tradeDate)
		.append("]\n");
		sb.append("]");
		return sb.toString();
	}
}
