package gnnt.MEBS.logonService.model;

import java.io.Serializable;
import java.util.Date;

/**
 * 活动的登录用户信息
 * 
 * @author xuejt
 * 
 */
public class ActiveUser implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -5976025383796247508L;
	/**
	 * 用户代码
	 */
	private String userId = null;
	/**
	 * 最后活动时间
	 */
	private long lastTime = 0;
	/**
	 * 登录时间
	 */
	private Date logonTime = null;
	/**
	 * 登录Ip地址
	 */
	private String IP = null;
	/**
	 * 用户sessionID
	 */
	private long sessionId;
	
	public ActiveUser() {
		lastTime = System.currentTimeMillis();
		logonTime = new Date();
	}

	/**
	 * 设置用户代码
	 * @param userId
	 */
	public void setUserId(String userId) {
		this.userId = userId;
	}

	/**
	 * 设置用户代码
	 * @return
	 */
	public String getUserId() {
		return this.userId;
	}
	
	/**
	 * 设置用户登录Ip地址
	 * @param ip
	 */
	public void setIP(String ip) {
		this.IP = ip;
	}

	/**
	 * 获取用户登录ip地址
	 * @return
	 */
	public String getIP() {
		return this.IP;
	}
	
	
	/**
	 * 设置用户最后活动时间
	 * @param lastTime
	 */
	public void setLastTime(long lastTime) {
		this.lastTime = lastTime;
	}

	/**
	 * 获取用户最后活动时间
	 * @return
	 */
	public long getLastTime() {
		return lastTime;
	}

	/**
	 * 获取用户登录时间
	 * @return
	 */
	public Date getLogonTime() {
		return logonTime;

	}
	
	/**
	 * 获取用户sessionID
	 */
	public long getSessionId() {
		return sessionId;
	}

	/**
	 *  设置用户sessionID
	 * @param sessionId
	 */
	public void setSessionId(long sessionId) {
		this.sessionId = sessionId;
	}

	

	


	
}
