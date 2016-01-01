package gnnt.MEBS.logonService.dao;

import gnnt.MEBS.logonService.client.front.ErrorLoginLog;
import gnnt.MEBS.logonService.client.front.Trader;
import gnnt.MEBS.logonService.client.front.TraderModule;
import gnnt.MEBS.logonService.model.LogonManagerInfo;

/**
 * 前台用户登录DAO
 * 
 * @author xuejt
 * 
 */
public interface FrontLogonDAO extends DAO {

	/**
	 * 获取交易商状态
	 * 
	 * @param firmID
	 *            交易商代码
	 * @return N：正常 Normal D：禁用 Disable E：删除 Erase
	 */
	public String getFirmStatus(String firmID);

	/**
	 * 通过系统名称获取登录配置信息
	 * 
	 * @param sysName
	 *            系统名称
	 * @return 登录配置信息
	 */
	public LogonManagerInfo getLogonManagerInfoBySysName(String sysName);

	/**
	 * 删除交易员以前的错误登录日志
	 * 
	 * @param traderID
	 *            交易员代码
	 */
	public void deleteErrorLogonLogByTraderID(String traderID);

	/**
	 * 获取交易员当天登录错误次数
	 * 
	 * @param traderID
	 *            交易员代码
	 * @return 当天登录错误次数
	 */
	public int getErrorLoginErrorNum(String traderID);

	/**
	 * 通过交易员代码获取交易员信息
	 * 
	 * @param traderId
	 *            交易员代码
	 * @return 交易员信息
	 */
	public Trader getTraderByID(String traderId);

	/**
	 * 通过用户名获取交易员代码
	 * 
	 * @param userId
	 *            用户名
	 * @return 交易员代码
	 */
	public String getTraderIDByUserID(String userId);

	/**
	 * 根据模块号和交易员代码获取模块可用性
	 * 
	 * @param moduleId
	 *            模块号
	 * @param traderId
	 *            交易员代码
	 * @return 模块可用性
	 */
	public TraderModule getTraderModule(int moduleId, String traderId);

	/**
	 * 插入密码错误登录日志
	 * 
	 * @param errorLoginLog
	 *            错误日志
	 */
	public void insertErrorLoginlog(ErrorLoginLog errorLoginLog);

	/**
	 * 更新交易员登录信息；更新内容有信任key；最后登录时间，最后登录ip地址
	 * 
	 * @param trader
	 *            交易员信息
	 */
	public void updateTraderLogonInfo(Trader trader);

	/**
	 * 修改密码
	 * 
	 * @param userId
	 *            交易员代码
	 * @param password
	 *            密码
	 */
	public void changePassowrd(String traderID, String password);

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