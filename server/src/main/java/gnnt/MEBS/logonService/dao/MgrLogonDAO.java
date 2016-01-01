package gnnt.MEBS.logonService.dao;

import gnnt.MEBS.logonService.client.mgr.User;
import gnnt.MEBS.logonService.model.LogonManagerInfo;

/**
 * 后台用户登录DAO
 * 
 * @author xuejt
 * 
 */
public interface MgrLogonDAO extends DAO {
	/**
	 * 通过系统名称获取登录配置信息
	 * 
	 * @param sysName
	 *            系统名称
	 * @return 登录配置信息
	 */
	public LogonManagerInfo getLogonManagerInfoBySysName(String sysName);

	/**
	 * 通过用户代码获取用户信息
	 * 
	 * @param userId
	 *            用户代码
	 * 
	 * @return 用户信息
	 * @see User
	 */
	public User getUserByID(String userId);
	
	/**
	 * 修改密码
	 * 
	 * @param userId
	 *            交易商代码
	 * @param password
	 *            密码
	 */
	public void changePassowrd(String userId, String password);

	/**
	 * 添加全局日志
	 * 
	 * @param operator
	 *            操作人
	 * @param operatorIP
	 *            操作人IP
	 * @param operatorType
	 *            操作类型
	 * @param operatorContent
	 *            操作内容
	 * @param operatorResult
	 *            操作结果
	 */
	public void addGlobalLog(String operator, String operatorIP,
			int operatorType, String operatorContent, int operatorResult);
}
