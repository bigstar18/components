
package gnnt.MEBS.activeUser.vo;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * <P>类说明：登录用户信息 VO
 * <br/>
 * <br/>
 * </p>
 * 修改记录:
 * <br/>
 * <ul>
 * 
 * <li> 创建类                    |2014-4-21下午01:11:45|金网安泰 </li>
 * 
 * </ul>
 * @author liuzx
 */
public class AUUserManageVO extends AUBaseVO{
	/** 序列编号 */
	private static final long serialVersionUID = 4463624248939431921L;

	/** AU SessionID */
	private long sessionID;

	/** 用户代码 */
	private String userID;

	/** 模块编号集合 */
	private List<Integer> moduleIDList = new ArrayList<Integer>();

	/**
	 * 登录类型<br/>
	 * web web服务登录<br/>
	 * pc 电脑客户端登录<br/>
	 * mobile 手机客户端登录<br/>
	 */
	private String logonType;

	/** 最后访问时间 */
	private long lastTime = 0;
	/**
	 * 登录时间
	 */
	private Date logonTime = null;
	/**
	 * 登录IP地址
	 */
	private String logonIp;
	
	public AUUserManageVO(){
		lastTime = System.currentTimeMillis();
		logonTime = new Date();
	}
	/**
	 * 
	 * AU SessionID
	 * <br/><br/>
	 * @return
	 */
	public long getSessionID() {
		return sessionID;
	}

	/**
	 * 
	 * AU SessionID
	 * <br/><br/>
	 * @param sessionID
	 */
	public void setSessionID(long sessionID) {
		this.sessionID = sessionID;
	}

	/**
	 * 
	 * 用户代码
	 * <br/><br/>
	 * @return
	 */
	public String getUserID() {
		return userID;
	}

	/**
	 * 
	 * 用户代码
	 * <br/><br/>
	 * @param userID
	 */
	public void setUserID(String userID) {
		this.userID = userID;
	}

	/**
	 * 
	 * 模块编号集合
	 * <br/><br/>
	 * @return
	 */
	public List<Integer> getModuleIDList() {
		return moduleIDList;
	}

	/**
	 * 
	 * 模块编号集合
	 * <br/><br/>
	 * @param moduleIDList
	 */
	public void setModuleIDList(List<Integer> moduleIDList) {
		this.moduleIDList = moduleIDList;
	}

	/**
	 * 
	 * 登录类型<br/>
	 * web web服务登录<br/>
	 * pc 电脑客户端登录<br/>
	 * mobile 手机客户端登录<br/>
	 * <br/><br/>
	 * @return
	 */
	public String getLogonType() {
		return logonType;
	}

	/**
	 * 
	 * 登录类型<br/>
	 * web web服务登录<br/>
	 * pc 电脑客户端登录<br/>
	 * mobile 手机客户端登录<br/>
	 * <br/><br/>
	 * @param logonType
	 */
	public void setLogonType(String logonType) {
		this.logonType = logonType;
	}

	/**
	 * 
	 * 最后访问时间
	 * <br/><br/>
	 * @return
	 */
	public long getLastTime() {
		return lastTime;
	}

	/**
	 * 
	 * 最后访问时间
	 * <br/><br/>
	 * @param lastTime
	 */
	public void setLastTime(long lastTime) {
		this.lastTime = lastTime;
	}
	/**
	 * 登录时间
	 */
	public Date getLogonTime() {
		return logonTime;
	}
	/**
	 * 登录时间
	 */
	public void setLogonTime(Date logonTime) {
		this.logonTime = logonTime;
	}
	/**
	 * 登录IP地址
	 */
	public void setLogonIp(String logonIp) {
		this.logonIp = logonIp;
	}
	/**
	 * 登录IP地址
	 */
	public String getLogonIp() {
		return logonIp;
	}
	
	
	
	

}

