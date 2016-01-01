package gnnt.MEBS.espot.core.po;

import java.io.Serializable;

/**
 * 交易时间
 * 
 * @author xuejt
 * 
 */
public class TradeTimePO extends Clone implements Serializable {
	private static final long serialVersionUID = 9096013307464176401L;

	private String restWeekDay;
	private String holiday;
	private String tradeStartTime;
	private String tradeEndTime;


	/**
	 * @return 不参与交易的日期；逗号分隔的星期几，星期日：1，星期一：2，星期二：3，星期三：4，星期四：5，星期五：6，星期六：7
	 */
	public String getRestWeekDay() {
		return restWeekDay;
	}

	/**
	 * @param 不参与交易的日期
	 *            ；逗号分隔的星期几，星期日：1，星期一：2，星期二：3，星期三：4，星期四：5，星期五：6，星期六：7
	 */
	public void setRestWeekDay(String restWeekDay) {
		this.restWeekDay = restWeekDay;
	}

	/**
	 * @return 按逗号分隔，格式yyyy-MM-dd，指定非交易日。
	 */
	public String getHoliday() {
		return holiday;
	}

	/**
	 * @param 按逗号分隔
	 *            ，格式yyyy-MM-dd，指定非交易日。
	 */
	public void setHoliday(String holiday) {
		this.holiday = holiday;
	}

	/**
	 * @return 交易开始时间 hh24:mi:ss
	 */
	public String getTradeStartTime() {
		return tradeStartTime;
	}

	/**
	 * @param 交易开始时间
	 *            hh24:mi:ss
	 */
	public void setTradeStartTime(String tradeStartTime) {
		this.tradeStartTime = tradeStartTime;
	}

	/**
	 * @return 交易结束时间 hh24:mi:ss
	 */
	public String getTradeEndTime() {
		return tradeEndTime;
	}

	/**
	 * @param 交易结束时间
	 *            hh24:mi:ss
	 */
	public void setTradeEndTime(String tradeEndTime) {
		this.tradeEndTime = tradeEndTime;
	}



	/**
	 * 返回值对象调试信息字符串.
	 * 
	 * @return 值对象的调试信息
	 */
	public String toString() {
		StringBuffer sb = new StringBuffer();
		sb.append("[TradeTimePO:\n");

		sb.append("[String |").append("restWeekDay|").append(this.restWeekDay)
				.append("]\n");
		sb.append("[String |").append("holiday|").append(this.holiday).append(
				"]\n");
		sb.append("[String |").append("tradeStartTime|").append(
				this.tradeStartTime).append("]\n");
		sb.append("[String |").append("tradeEndTime|")
				.append(this.tradeEndTime).append("]\n");

		sb.append("]");
		return sb.toString();
	}
}
