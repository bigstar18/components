package gnnt.MEBS.logonService.client.front;

import gnnt.MEBS.logonService.activeUser.LogonMode;
import gnnt.MEBS.logonService.dao.jdbc.FrontLogonDAOJdbc;
import gnnt.MEBS.logonService.manage.ILogonManager;
import gnnt.MEBS.logonService.manage.LogonManager;
import gnnt.MEBS.logonService.model.ActiveUser;
import gnnt.MEBS.logonService.model.LogonManagerInfo;
import gnnt.MEBS.logonService.util.GnntBeanFactory;
import gnnt.MEBS.logonService.util.MD5;

import java.rmi.Naming;
import java.rmi.RemoteException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.sql.DataSource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * 标准前台登录实现类
 * <p>
 * 
 * @author xuejt
 * 
 */
public class FrontLogonActualize {

	/**
	 * 公用系统模块号
	 */
	private static final int COMMONMODULEID = 99;

	private transient final Log logger = LogFactory
			.getLog(FrontLogonActualize.class);

	private volatile static FrontLogonActualize instance;

	private FrontLogonDAOJdbc frontLogonDAOJdbc;

	private String sysName;

	private ILogonManager logonManager;

	private LogonManagerInfo logonManagerInfo;

	/**
	 * 24 模块号 2401 登录 退出
	 */
	private int LOG_MANAGE_OPERATORTYPR = 2401;

	/**
	 * 24 模块号 2402 修改密码
	 */
	private int PWD_MANAGE_OPERATORTYPR = 2402;

	/**
	 * 访问模式 0：rmi访问登录管理 1：本地访问登录管理
	 */
	private short callMode = 0;

	/**
	 * 登录模式 只有在访问模式等于1时生效
	 */
	LogonMode logonMode = LogonMode.SINGLE_MODE;

	/**
	 * au超时时间 单位分钟 只有在访问模式等于1时生效
	 */
	int expireTime;

	/**
	 * 创建一个前台登陆实例;
	 * 
	 * @param sysName
	 *            系统名称
	 * @param callMode
	 *            0：rmi访问登录管理 1：本地访问登录管理 默认为rmi访问
	 * @param logonMode
	 *            登录模式 只有在访问模式callMode等于1的情况下生效
	 * @see LogonMode
	 * @param expireTime
	 *            au超时时间 单位分钟 只有在访问模式等于1时生效
	 * @param ds
	 *            数据源
	 * @return
	 */
	public static FrontLogonActualize createInstance(String sysName,
			short callMode, LogonMode logonMode, int expireTime, DataSource ds) {
		if (instance == null) {
			synchronized (FrontLogonActualize.class) {
				if (instance == null) {
					instance = new FrontLogonActualize(sysName, callMode,
							logonMode, expireTime, ds);
				}
			}
		}
		return instance;
	}

	/**
	 * 获取实例；在获取前应该先调用createInstance创建实例；创建实例是单一模式创建一次即可
	 * 
	 * @return
	 */
	public static FrontLogonActualize getInstance() {
		if (instance == null) {
			throw new IllegalArgumentException("请调用方法createInstance创建实例");
		}
		return instance;
	}

	/**
	 * 构造方法;
	 * 
	 * @param sysName
	 *            系统名称
	 * @param callMode
	 *            0：rmi访问登录管理 1：本地访问登录管理 默认为rmi访问
	 * @param logonMode
	 *            只有登录模式 在callMode等于1的情况下生效
	 * 
	 * @see LogonMode
	 * @param expireTime
	 *            au超时时间 单位分钟 只有在访问模式等于1时生效
	 * @param ds
	 *            数据源
	 * @return
	 */
	public FrontLogonActualize(String sysName, short callMode,
			LogonMode logonMode, int expireTime, DataSource ds) {
		if (callMode != 0 && callMode != 1) {
			throw new IllegalArgumentException("输入参数" + callMode
					+ "不合法，callMode只能为0或者1； 0：rmi访问登录管理 1：本地访问登录管理 默认为rmi访问");
		}

		this.sysName = sysName;
		this.callMode = callMode;
		this.expireTime = expireTime;
		if (logonMode != null)
			this.logonMode = logonMode;
		frontLogonDAOJdbc = new FrontLogonDAOJdbc();
		frontLogonDAOJdbc.setDataSource(ds);
		this.logonManagerInfo = frontLogonDAOJdbc
				.getLogonManagerInfoBySysName(sysName);
		try {
			this.getLogonManager();
		} catch (Exception e) {
			if (callMode == 1) {
				logger.error(e.getMessage());
				e.printStackTrace();
			} else {
				logger.warn("前台远程RMI还没有启动!!!");
			}
		}
	}

	/**
	 * 获取登录管理对象
	 * 
	 * @return
	 * @throws Exception
	 */
	private synchronized ILogonManager getLogonManager() throws Exception {
		if (logonManager != null) {
			return logonManager;
		}

		if (callMode == 1) {
			try {
				logonManager = LogonManager.getInstance(sysName,
						frontLogonDAOJdbc.getDataSource(), expireTime,
						logonMode, null);
			} catch (Exception e) {
				throw new Exception("获取登录管理对象失败；异常信息" + e);
			}
		} else {
			if (logonManagerInfo == null) {
				throw new Exception("获取登录管理对象失败；没有找到系统名称为" + sysName + "登录信息");
			}

			logonManager = (ILogonManager) Naming.lookup("rmi://"
					+ logonManagerInfo.getIp() + ":"
					+ logonManagerInfo.getPort() + "/" + sysName
					+ "LogonService");
		}
		return logonManager;
	}

	/**
	 * 登录
	 * 
	 * @param userId
	 *            交易员代码
	 * @param password
	 *            密码
	 * @param moduleid
	 *            模块号
	 * @param userIdType
	 *            用户名类型 0 交易员代码登录 1 用户名登录
	 * @return 返回
	 *         交易员信息；成功交易员信息中sessionId为sessionID；-1：交易员代码不存在；-2：口令不正确；-3：禁止登录；
	 *         -4：Key盘验证错误；-5：交易板块被禁止 -6：其他异常
	 * @throws Exception
	 */
	public TraderLogonInfo logon(String userId, String password, int moduleId,
			int userIdType) throws Exception {
		return logon(userId, password, moduleId, null, null, null, userIdType);
	}

	/**
	 * 登录
	 * 
	 * @param userId
	 *            交易员代码
	 * @param password
	 *            密码
	 * @param moduleId
	 *            模块号
	 * @param key
	 *            交易员key
	 * @param trustKey
	 *            信任key；如果客户端传入的key与服务端一致则不进行登录错误次数验证
	 * @param logonIP
	 *            用户登录IP
	 * @param userIdType
	 *            用户名类型 0 交易员代码登录 1 用户名登录
	 * @return 成功返回sessionID；-1：交易员代码不存在；-2：口令不正确；-3：禁止登录；-4：Key盘验证错误；-5：交易板块被禁止
	 *         -6：其他异常
	 * @throws Exception
	 */
	public TraderLogonInfo logon(String userId, String password, int moduleId,
			String key, String trustKey, String logonIP, int userIdType)
			throws Exception {

		try {
			this.logger.debug("Entering 'logon' method");
			logger.info("用户" + userId + "登录,模块号为" + moduleId + "登录ip地址"
					+ logonIP + "用户名类型为" + userIdType);

			// 登录信息
			String logonInfo = "";

			TraderLogonInfo traderLogonInfo = new TraderLogonInfo();

			// 交易员代码
			String traderID = "";

			// 如果是用户名登录，则从数据库中根据用户名查询交易员代码
			if (userIdType == 1) {
				traderID = frontLogonDAOJdbc.getTraderIDByUserID(userId);
			} else {
				traderID = userId;
			}

			frontLogonDAOJdbc.deleteErrorLogonLogByTraderID(traderID);

			Trader trader = frontLogonDAOJdbc.getTraderByID(traderID);
			if (trader == null) {
				traderLogonInfo.setSessionId(-1);
				logonInfo = "登录失败；交易员不存在";
				frontLogonDAOJdbc.addGlobalLog(traderID, logonIP,
						LOG_MANAGE_OPERATORTYPR, logonInfo, 0);
				logger.info("用户" + traderID + "登录返回信息" + logonInfo);
				return traderLogonInfo;
			}

			if (moduleId != COMMONMODULEID) {
				TraderModule traderModule = frontLogonDAOJdbc.getTraderModule(
						moduleId, traderID);
				if (traderModule == null) {
					traderLogonInfo.setSessionId(-5);
					logonInfo = "登录失败；没有此模块权限";
					frontLogonDAOJdbc.addGlobalLog(traderID, logonIP,
							LOG_MANAGE_OPERATORTYPR, logonInfo, 0);
					logger.info("用户" + traderID + "登录返回信息" + logonInfo);
					return traderLogonInfo;
				}

				if ("N".equals(traderModule.getEnabled())) { // 交易员的交易板块被禁止
					traderLogonInfo.setSessionId(-5);
					logonInfo = "登录失败；交易板块被禁止";
					frontLogonDAOJdbc.addGlobalLog(traderID, logonIP,
							LOG_MANAGE_OPERATORTYPR, logonInfo, 0);
					logger.info("用户" + traderID + "登录返回信息" + logonInfo);
					return traderLogonInfo;
				}
			}

			if ("D".equals(trader.getStatus())) {// 交易员状态被禁止
				traderLogonInfo.setSessionId(-3);
				logonInfo = "登录失败；禁止登录";
				frontLogonDAOJdbc.addGlobalLog(traderID, logonIP,
						LOG_MANAGE_OPERATORTYPR, logonInfo, 0);
				logger.info("用户" + traderID + "登录返回信息" + logonInfo);
				return traderLogonInfo;
			}

			String firmStatus = frontLogonDAOJdbc.getFirmStatus(trader
					.getFirmID());
			if (!"N".equals(firmStatus)) {// 交易商状态被禁止
				traderLogonInfo.setSessionId(-3);
				logonInfo = "登录失败；禁止登录";
				frontLogonDAOJdbc.addGlobalLog(traderID, logonIP,
						LOG_MANAGE_OPERATORTYPR, logonInfo, 0);
				logger.info("用户" + traderID + "登录返回信息" + logonInfo);
				return traderLogonInfo;
			}

			if ("Y".equals(trader.getEnableKey())
					&& !trader.getKeyCode().equals(key)) {// key不一致
				traderLogonInfo.setSessionId(-4);
				logonInfo = "登录失败；key盘数据不正确";
				frontLogonDAOJdbc.addGlobalLog(traderID, logonIP,
						LOG_MANAGE_OPERATORTYPR, logonInfo, 0);
				logger.info("用户" + traderID + "登录返回信息" + logonInfo);
				return traderLogonInfo;
			}

			if ((trader.getTrustKey() == null
					|| trader.getTrustKey().trim().length() == 0 || !trader
					.getTrustKey().equals(trustKey))
					&& frontLogonDAOJdbc.getErrorLoginErrorNum(traderID) >= logonManagerInfo
							.getAllowLogonError()) { // 检查登录错误次数
				traderLogonInfo.setSessionId(-3);
				logonInfo = "登录失败；超过密码输入错误次数";
				frontLogonDAOJdbc.addGlobalLog(traderID, logonIP,
						LOG_MANAGE_OPERATORTYPR, logonInfo, 0);
				logger.info("用户" + traderID + "登录返回信息" + logonInfo);
				return traderLogonInfo;
			}

			// 检查用户名密码
			Long checkPwdResult;

			checkPwdResult = getLogonManager().checkPWD(traderID, password);

			// 交易员不存在
			if (checkPwdResult == -1) {
				traderLogonInfo.setSessionId(-1);
				logonInfo = "登录失败；交易员不存在";
				frontLogonDAOJdbc.addGlobalLog(traderID, logonIP,
						LOG_MANAGE_OPERATORTYPR, logonInfo, 0);
				logger.info("用户" + traderID + "登录返回信息" + logonInfo);
				return traderLogonInfo;
			}

			// 密码不正确
			if (checkPwdResult == -2) {
				traderLogonInfo.setSessionId(-2);
				// 记录密码错误日志
				ErrorLoginLog errorLoginLog = new ErrorLoginLog();
				errorLoginLog.setIp(logonIP);
				errorLoginLog.setModuleId(moduleId);
				errorLoginLog.setTraderId(traderID);
				frontLogonDAOJdbc.insertErrorLoginlog(errorLoginLog);

				logonInfo = "登录失败；密码不正确";
				frontLogonDAOJdbc.addGlobalLog(traderID, logonIP,
						LOG_MANAGE_OPERATORTYPR, logonInfo, 0);
				logger.info("用户" + traderID + "登录返回信息" + logonInfo);
				return traderLogonInfo;
			}

			traderLogonInfo.setLastIP(trader.getLastIP());
			traderLogonInfo.setLastTime(trader.getLastTime());
			traderLogonInfo.setSessionId(getLogonManager().logon(traderID,
					password, logonIP));

			traderLogonInfo.setFirmId(trader.getFirmID());
			traderLogonInfo.setFirmName(trader.getFirmName());
			traderLogonInfo.setTraderId(trader.getTraderID());
			traderLogonInfo.setTraderName(trader.getName());
			traderLogonInfo.setType(trader.getType());
			traderLogonInfo.setForceChangePwd(trader.getForceChangePwd());

			SimpleDateFormat spdf = new SimpleDateFormat("yyyyMMddHHmmssSS");
			String date = spdf.format(new Date());
			String randomKey = date + traderID
					+ String.valueOf((Math.random() * 100000.0D));

			traderLogonInfo.setTrustKey(randomKey);

			trader.setTrustKey(randomKey);
			trader.setLastIP(logonIP);
			frontLogonDAOJdbc.updateTraderLogonInfo(trader);
			logonInfo = "登录成功";
			frontLogonDAOJdbc.addGlobalLog(traderID, logonIP,
					LOG_MANAGE_OPERATORTYPR, logonInfo, 1);
			logger.info("用户" + traderID + "登录返回信息" + logonInfo);

			return traderLogonInfo;
		} catch (RemoteException e) {
			logonManager = null;
			throw e;
		} catch (Exception e) {
			throw e;
		}
	}

	/**
	 * 修改密码
	 * 
	 * @param userId
	 *            交易员代码
	 * @param passwordOld
	 *            旧密码
	 * @param password
	 *            密码
	 * @param logonIP
	 *            ip地址
	 * @return 成功返回0；-1：原口令不正确
	 */
	public int changePassowrd(String userId, String passwordOld,
			String password, String logonIP) {
		logger.info("用户" + userId + "修改密码");

		Trader trader = this.frontLogonDAOJdbc.getTraderByID(userId);
		if (!trader.getPassword().equals(MD5.getMD5(userId, passwordOld))) {
			logger.info("用户" + userId + "输入的旧密码不正确");
			return -1;
		}

		frontLogonDAOJdbc.changePassowrd(userId, MD5.getMD5(userId, password));

		frontLogonDAOJdbc.addGlobalLog(userId, logonIP,
				PWD_MANAGE_OPERATORTYPR, "修改密码", 1);

		logger.info("用户" + userId + "修改密码成功");
		return 0;
	}

	/**
	 * 注销指定的用户登录状态
	 * 
	 * @param operator
	 *            操作人
	 * 
	 * @param userId
	 *            用户代码
	 * @param logonIP
	 * @throws Exception
	 */
	public void logoff(String operator, String userId, String logonIP)
			throws Exception {
		try {
			String[] allUser = getLogonManager().getAllUsersById(userId);
			if (allUser != null && allUser.length > 0) {
				getLogonManager().logoff(userId);
				frontLogonDAOJdbc.addGlobalLog(operator, logonIP,
						LOG_MANAGE_OPERATORTYPR, "通过用户名强制退出" + userId, 1);
				logger.info("用户" + userId + "被" + operator + "通过用户名强制退出,操作人IP"
						+ logonIP);
			}
		} catch (RemoteException e) {
			logonManager = null;
			throw e;
		} catch (Exception e) {
			throw e;
		}
	}

	/**
	 * 注销指定sessionID对应的登录状态
	 * 
	 * @param sessionID
	 *            要注销的sessionID
	 * @throws Exception
	 */
	public void logoff(long sessionID) throws Exception {
		try {
			ActiveUser user = getLogonManager().getUser(sessionID);
			if (user != null) {
				getLogonManager().logoff(sessionID);
				frontLogonDAOJdbc.addGlobalLog(user.getUserId(), user.getIP(),
						LOG_MANAGE_OPERATORTYPR, "退出登录", 1);
				logger.info("用户" + user.getUserId() + "退出登录");
			}
		} catch (RemoteException e) {
			logonManager = null;
			throw e;
		} catch (Exception e) {
			throw e;
		}
	}

	/**
	 * 验证是否登录
	 * 
	 * @param userId
	 *            用户代码
	 * @param sessionId
	 *            sessionID
	 * @param moduleId
	 *            模块号
	 * @return true 已登录；false 未登录；
	 * @throws Exception
	 */
	public boolean isLogon(String userId, long sessionId, int moduleId)
			throws Exception {
		logger
				.info("用户" + userId + "验证sessionId是否可以在模块号为" + moduleId
						+ "的模块登录");
		try {
			if (moduleId != COMMONMODULEID) {// 所有用户都是有公用系统权限的
				TraderModule traderModule = frontLogonDAOJdbc.getTraderModule(
						moduleId, userId);

				// 验证模块权限
				if (traderModule == null
						|| "N".equals(traderModule.getEnabled())) {
					return false;
				}
			}

			return getLogonManager().isLogon(userId, sessionId);
		} catch (RemoteException e) {
			logonManager = null;
			throw e;
		} catch (Exception e) {
			throw e;
		}
	}

	/**
	 * @param userId
	 * @return 成功返回TraderLogonInfo null 没有此用户
	 */
	public TraderLogonInfo getTraderInfo(String userId) {
		Trader trader = frontLogonDAOJdbc.getTraderByID(userId);
		if (trader == null) {
			return null;
		}

		TraderLogonInfo traderLogonInfo = new TraderLogonInfo();
		traderLogonInfo.setLastIP(trader.getLastIP());
		traderLogonInfo.setLastTime(trader.getLastTime());

		traderLogonInfo.setFirmId(trader.getFirmID());
		traderLogonInfo.setFirmName(trader.getFirmName());
		traderLogonInfo.setTraderId(trader.getTraderID());
		traderLogonInfo.setTraderName(trader.getName());
		traderLogonInfo.setType(trader.getType());
		traderLogonInfo.setForceChangePwd(trader.getForceChangePwd());
		traderLogonInfo.setTrustKey(trader.getTrustKey());

		return traderLogonInfo;
	}

	/**
	 * 得到指定sessionID所对应的用户ID
	 * 
	 * @param sessionId
	 * @return 返回相应的用户 如果返回为null,则表示此sessionID为无效。
	 * @throws Exception
	 */
	public ActiveUser getUser(long sessionId) throws Exception {
		try {
			return getLogonManager().getUser(sessionId);
		} catch (RemoteException e) {
			logonManager = null;
			throw e;
		} catch (Exception e) {
			throw e;
		}
	}

	/**
	 * 获得所有登录用户
	 * 
	 * @return 返回一个字符串数组,数组中的每一个元素代表一个用户登录连接,内容是用户ID和登录的时间以及Ip地址用","加以分隔。
	 * @throws Exception
	 */
	public String[] getAllUsers() throws Exception {
		try {
			return getLogonManager().getAllUsers();
		} catch (RemoteException e) {
			logonManager = null;
			throw e;
		} catch (Exception e) {
			throw e;
		}
	}

	/**
	 * 获取用户为UserID的所有登录用户信息
	 * 
	 * @param userId
	 *            要查找的userId
	 * @return 返回一个字符串数组,数组中的每一个元素代表一个用户登录连接,内容是用户ID和登录的时间用","加以分隔；如果没有登录返回空
	 */
	public String[] getAllUsersById(String userId) throws Exception {
		try {
			return getLogonManager().getAllUsersById(userId);
		} catch (RemoteException e) {
			logonManager = null;
			throw e;
		} catch (Exception e) {
			throw e;
		}
	}

	public static void main(String[] args) {
		Log logger = LogFactory.getLog(FrontLogonActualize.class);

		logger.info("正在启动测试．．．");
		try {
			FrontLogonActualize.createInstance("front", (short) 1, null, 5,
					(DataSource) GnntBeanFactory.getBean("dataSource"));
			FrontLogonActualize frontLogonActualize = FrontLogonActualize
					.getInstance();
			TraderLogonInfo logonInfo = frontLogonActualize.logon("liuzx01",
					"111111", 10, "1111", "111", "1111", 0);
			if (logonInfo.getSessionId() < 0) {
				System.out.println("登录失败；失败原因=" + logonInfo.getSessionId());
			} else {
				System.out.println("登录验证"
						+ frontLogonActualize.isLogon(logonInfo.getTraderId(),
								logonInfo.getSessionId(), 1));

				System.out.println("登录验证"
						+ frontLogonActualize.isLogon(logonInfo.getTraderId(),
								111L, 1));

				System.out.println("修改密码结果"
						+ frontLogonActualize.changePassowrd(logonInfo
								.getTraderId(), "111111", "111111", "logonIP"));
				System.out.println("修改密码结果"
						+ frontLogonActualize.changePassowrd(logonInfo
								.getTraderId(), "11111", "111111", "logonIP"));
				System.out.println(frontLogonActualize.getAllUsers()[0]);

				System.out.println(frontLogonActualize.getTraderInfo(
						logonInfo.getTraderId()).getFirmName());

				System.out.println(frontLogonActualize.getUser(
						logonInfo.getSessionId()).getLastTime());

				 frontLogonActualize.logoff(logonInfo.getSessionId());
				//
				// frontLogonActualize.logoff("operator",
				// logonInfo.getTraderId(),
				// "ip");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
