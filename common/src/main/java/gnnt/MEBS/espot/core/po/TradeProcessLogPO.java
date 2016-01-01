package gnnt.MEBS.espot.core.po;

import java.io.Serializable;
import java.util.Date;
/**
 * 合同处理日志
 * @author xuejt
 *
 */
public class TradeProcessLogPO extends Clone implements Serializable{

	private static final long serialVersionUID = 8996873062633471514L;
	private long logID;
	private long tradeNO;
	private String firmID;
	private String operator;
	private String processInfo;
	private Date processTime;
	/**
	 * @return the logID
	 */
	public long getLogID() {
		return logID;
	}
	/**
	 * @param logID the logID to set
	 */
	public void setLogID(long logID) {
		this.logID = logID;
	}
	/**
	 * @return 合同号
	 */
	public long getTradeNO() {
		return tradeNO;
	}
	/**
	 * @param 合同号
	 */
	public void setTradeNO(long tradeNO) {
		this.tradeNO = tradeNO;
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
	 * @return 操作人
	 */
	public String getOperator() {
		return operator;
	}
	/**
	 * @param 操作人
	 */
	public void setOperator(String operator) {
		this.operator = operator;
	}
	/**
	 * @return 处理信息
	 */
	public String getProcessInfo() {
		return processInfo;
	}
	/**
	 * @param 处理信息
	 */
	public void setProcessInfo(String processInfo) {
		this.processInfo = processInfo;
	}
	/**
	 * @return 处理时间
	 */
	public Date getProcessTime() {
		return processTime;
	}
	/**
	 * @param 处理时间
	 */
	public void setProcessTime(Date processTime) {
		this.processTime = processTime;
	}
	
	
}
