package gnnt.MEBS.logonService.manage;

import gnnt.MEBS.logonService.model.ActiveUser;

import java.rmi.Remote;
import java.rmi.RemoteException;

/**
 * 登录管理rmi接口
 * 
 * @author xuejt
 * 
 */
public interface ILogonManager extends Remote {
	
	
	/**
	 * 检查用户名密码
	 * 
	 * @param userId
	 *            用户名
	 * @param password
	 *            密码
	 * @return 成功返回0；-1：交易员代码不存在；-2：口令不正确
	 */
	public Long checkPWD(String userId, String password) throws RemoteException;
	
	/**
	 * 登录
	 * 
	 * @param userId
	 *            用户名
	 * @param password
	 *            密码
	 * @param logonIP
	 *            用户登录IP
	 * @return 成功返回sessionID；-1：交易员代码不存在；-2：口令不正确
	 */
	public Long logon(String userId, String password, String logonIP) throws RemoteException;
	
	/**
	 * 注销指定的用户登录状态
	 * 
	 * @param userId
	 *            用户代码
	 */
	public void logoff(String userId) throws RemoteException;

	/**
	 * 注销指定sessionID对应的登录状态
	 * 
	 * @param sessionID
	 *            要注销的sessionID
	 */
	public void logoff(long sessionID) throws RemoteException;
	
	/**
	 * 验证是否登录
	 * 
	 * @param userId
	 *            用户代码
	 * @param sessionId
	 *            sessionID
	 * @return true 已登录；false 未登录；
	 */
	public boolean isLogon(String userId, long sessionId) throws RemoteException;
	
	/**
	 * 得到指定sessionID所对应的用户ID
	 * 
	 * @param sessionId
	 * @return 返回相应的用户 如果返回为null,则表示此sessionID为无效。
	 */
	public ActiveUser getUser(long sessionId) throws RemoteException;
	
	/**
	 * 获得所有登录用户
	 * 
	 * @return 返回一个字符串数组,数组中的每一个元素代表一个用户登录连接,内容是用户ID和登录的时间以及Ip地址用","加以分隔。
	 */
	public String[] getAllUsers() throws RemoteException;
	
	/**
	 * 获取用户为UserID的所有登录用户信息
	 * 
	 * @param userId
	 *            要查找的userId
	 * @return 返回一个字符串数组,数组中的每一个元素代表一个用户登录连接,内容是用户ID和登录的时间用","加以分隔；如果没有登录返回空
	 */
	public String[] getAllUsersById(String userId) throws RemoteException;
}
