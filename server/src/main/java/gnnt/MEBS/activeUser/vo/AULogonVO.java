
package gnnt.MEBS.activeUser.vo;

import java.util.Date;


/**
 * <P>类说明：用户登录时，传入的 VO 对象
 * <br/>
 * <br/>
 * </p>
 * 修改记录:
 * <br/>
 * <ul>
 * 
 * <li> 创建类                    |2014-4-21下午01:49:35|金网安泰 </li>
 * 
 * </ul>
 * @author liuzx
 */
public class AULogonVO extends AUBaseVO{
	/** 序列编号 */
	private static final long serialVersionUID = 7741736096020219428L;

	/** 用户编号 */
	private String userID;

	/** 模块编号 */
	private int moduleID;

	/**
	 * 登录类型<br/>
	 * web web服务登录<br/>
	 * pc 电脑客户端登录<br/>
	 * mobile 手机客户端登录<br/>
	 */
	private String logonType;
	/**
	 * 登录时间
	 */
	private Date logonTime = null;
	/**
	 * 登录Ip地址
	 */
	private String logonIp = null;
	
	public AULogonVO(){
		logonTime = new Date();
	}

	/**
	 * 
	 * 用户编号
	 * <br/><br/>
	 * @return
	 */
	public String getUserID() {
		return userID;
	}

	/**
	 * 
	 * 用户编号
	 * <br/><br/>
	 * @param userID
	 */
	public void setUserID(String userID) {
		this.userID = userID;
	}

	/**
	 * 
	 * 模块编号
	 * <br/><br/>
	 * @return
	 */
	public int getModuleID() {
		return moduleID;
	}

	/**
	 * 
	 * 模块编号
	 * <br/><br/>
	 * @param moduleID
	 */
	public void setModuleID(int moduleID) {
		this.moduleID = moduleID;
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
	 * 登录Ip地址
	 */
	public String getLogonIp() {
		return logonIp;
	}
	/**
	 * 登录Ip地址
	 */
	public void setLogonIp(String logonIp) {
		this.logonIp = logonIp;
	}
	
	

}

