package gnnt.MEBS.logonService.client.front;

import java.util.Date;

/**
 * 密码错误登录日志
 * 
 * @author xuejt
 * 
 */
public class ErrorLoginLog {
	private String traderId;
	private Date loginDate;
	private int moduleId;
	private String ip;

	/**
	 * @return 交易员代码
	 */
	public String getTraderId() {
		return traderId;
	}

	/**
	 * @param 交易员代码
	 */
	public void setTraderId(String traderId) {
		this.traderId = traderId;
	}

	/**
	 * @return 登录日期
	 */
	public Date getLoginDate() {
		return loginDate;
	}

	/**
	 * @param 登录日期
	 */
	public void setLoginDate(Date loginDate) {
		this.loginDate = loginDate;
	}

	/**
	 * @return 模块号
	 */
	public int getModuleId() {
		return moduleId;
	}

	/**
	 * @param 模块号
	 */
	public void setModuleId(int moduleId) {
		this.moduleId = moduleId;
	}

	/**
	 * @return the ip
	 */
	public String getIp() {
		return ip;
	}

	/**
	 * @param ip
	 *            the ip to set
	 */
	public void setIp(String ip) {
		this.ip = ip;
	}

}
