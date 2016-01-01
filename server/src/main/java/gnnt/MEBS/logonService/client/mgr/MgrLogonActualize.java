package gnnt.MEBS.logonService.client.mgr;

import gnnt.MEBS.logonService.activeUser.LogonMode;
import gnnt.MEBS.logonService.client.front.FrontLogonActualize;
import gnnt.MEBS.logonService.dao.jdbc.MgrLogonDAOJdbc;
import gnnt.MEBS.logonService.manage.ILogonManager;
import gnnt.MEBS.logonService.manage.LogonManager;
import gnnt.MEBS.logonService.model.ActiveUser;
import gnnt.MEBS.logonService.model.LogonManagerInfo;
import gnnt.MEBS.logonService.util.GnntBeanFactory;
import gnnt.MEBS.logonService.util.MD5;

import java.net.InetAddress;
import java.rmi.Naming;
import java.rmi.RemoteException;

import javax.sql.DataSource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * 后台登录实现类
 * 
 * @author xuejt
 * 
 */
public class MgrLogonActualize {
	private transient final Log logger = LogFactory
			.getLog(MgrLogonActualize.class);

	private volatile static MgrLogonActualize instance;

	private MgrLogonDAOJdbc mgrLogonDAOJdbc;

	private String sysName;

	private ILogonManager logonManager;

	private LogonManagerInfo logonManagerInfo;

	/**
	 * 24模块号 2403后台登录 退出
	 */
	private int LOG_MANAGE_OPERATORTYPR = 2403;

	/**
	 * 24 模块号 2404 后台 修改密码
	 */
	private int PWD_MANAGE_OPERATORTYPR = 2404;

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
	 * 创建一个后台登陆实例;
	 * 
	 * @param sysName
	 *            系统名称
	 * @param callMode
	 *            0：rmi访问登录管理 1：本地访问登录管理 默认为rmi访问
	 * @param logonMode
	 *            登录模式 只有在访问模式callMode等于1的情况下生效
	 * @param expireTime
	 *            au超时时间 单位分钟 只有在访问模式等于1时生效
	 * @see LogonMode
	 * @param ds
	 *            数据源
	 * @return
	 */
	public static MgrLogonActualize createInstance(String sysName,
			short callMode, LogonMode logonMode, int expireTime, DataSource ds) {
		if (instance == null) {
			synchronized (FrontLogonActualize.class) {
				if (instance == null) {
					instance = new MgrLogonActualize(sysName, callMode,
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
	public static MgrLogonActualize getInstance() {
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
	 * @see LogonMode
	 * 
	 * @param expireTime
	 *            au超时时间 单位分钟 只有在访问模式等于1时生效
	 * @param ds
	 *            数据源
	 * @return
	 */
	public MgrLogonActualize(String sysName, short callMode,
			LogonMode logonMode, int expireTime, DataSource ds) {
		if (callMode != 0 && callMode != 1) {
			throw new IllegalArgumentException("输入参数" + callMode
					+ "不合法，callMode只能为0或者1； 0：rmi访问登录管理 1：本地访问登录管理 默认为rmi访问");
		}

		this.sysName = sysName;
		this.callMode = callMode;
		if (logonMode != null)
			this.logonMode = logonMode;
		this.expireTime = expireTime;

		mgrLogonDAOJdbc = new MgrLogonDAOJdbc();
		mgrLogonDAOJdbc.setDataSource(ds);
		this.logonManagerInfo = mgrLogonDAOJdbc
				.getLogonManagerInfoBySysName(sysName);
		try {
			this.getLogonManager();
		} catch (Exception e) {
			if(callMode==1){
				logger.error(e.getMessage());
				e.printStackTrace();
			}else{
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
						mgrLogonDAOJdbc.getDataSource(), expireTime, logonMode,
						null);
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
	 *            管理员代码
	 * @param password
	 *            密码
	 * @return 成功返回 sessinID -1：管理员代码不存在；-2：口令不正确；-3:Key盘验证错误 -4：禁止登录
	 * @throws Exception
	 */
	public long logon(String userId, String password) throws Exception {
		return logon(userId, password, null, null);
	}

	/**
	 * 登录
	 * 
	 * @param userId
	 *            管理员代码
	 * @param password
	 *            密码
	 * @param key
	 *            key盘中的代码
	 * @param logonIP
	 *            用户登录IP
	 * @return 成功返回 sessinID -1：管理员代码不存在；-2：口令不正确；-3:Key盘验证错误 -4：禁止登录
	 * @throws Exception
	 */
	public long logon(String userId, String password, String key, String logonIP)
			throws Exception {

		try {
			this.logger.debug("Entering 'logon' method");
			logger.info("用户" + userId + "登录,登录ip地址" + logonIP);

			// 登录信息
			String logonInfo = "";

			User user = mgrLogonDAOJdbc.getUserByID(userId);

			if (user == null) {
				logonInfo = "登录失败；管理员不存在";
				mgrLogonDAOJdbc.addGlobalLog(userId, logonIP,
						LOG_MANAGE_OPERATORTYPR, logonInfo, 0);
				logger.info("用户" + userId + "登录返回信息" + logonInfo);
				return -1;
			}

			if (user.getKeyCode() != null
					&& !"0123456789ABCDE".equals(user.getKeyCode())
					&& !user.getKeyCode().equals(key)) {// key不一致
				logonInfo = "登录失败；key盘数据不正确";
				mgrLogonDAOJdbc.addGlobalLog(userId, logonIP,
						LOG_MANAGE_OPERATORTYPR, logonInfo, 0);
				logger.info("用户" + userId + "登录返回信息" + logonInfo);
				return -3;
			}

			if ("Y".equals(user.getIsForbid())) {// 交易员状态被禁止
				logonInfo = "登录失败；禁止登录";
				mgrLogonDAOJdbc.addGlobalLog(userId, logonIP,
						LOG_MANAGE_OPERATORTYPR, logonInfo, 0);
				logger.info("用户" + userId + "登录返回信息" + logonInfo);
				return -4;
			}

			// 检查用户名密码
			Long checkPwdResult;

			checkPwdResult = getLogonManager().checkPWD(userId, password);

			// 管理员不存在
			if (checkPwdResult == -1) {
				logonInfo = "登录失败；管理员不存在";
				mgrLogonDAOJdbc.addGlobalLog(userId, logonIP,
						LOG_MANAGE_OPERATORTYPR, logonInfo, 0);
				logger.info("用户" + userId + "登录返回信息" + logonInfo);
				return -1;
			}

			// 密码不正确
			if (checkPwdResult == -2) {
				// 记录密码错误日志
				logonInfo = "登录失败；密码不正确";
				mgrLogonDAOJdbc.addGlobalLog(userId, logonIP,
						LOG_MANAGE_OPERATORTYPR, logonInfo, 0);
				logger.info("用户" + userId + "登录返回信息" + logonInfo);
				return -2;
			}

			logonInfo = "登录成功";
			mgrLogonDAOJdbc.addGlobalLog(userId, logonIP,
					LOG_MANAGE_OPERATORTYPR, logonInfo, 1);
			logger.info("用户" + userId + "登录返回信息" + logonInfo);

			return getLogonManager().logon(userId, password, logonIP);

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
	 * @param password
	 *            密码
	 * @param logonIP
	 *            ip地址
	 * @return 成功返回0；-1：原口令不正确
	 */
	public int changePassowrd(String userId, String passwordOld,
			String password, String logonIP) {
		logger.info("用户" + userId + "修改密码");

		User user = this.mgrLogonDAOJdbc.getUserByID(userId);
		if (!user.getPassword().equals(MD5.getMD5(userId, passwordOld))) {
			logger.info("用户" + userId + "输入的旧密码不正确");
			return -1;
		}

		mgrLogonDAOJdbc.changePassowrd(userId, MD5.getMD5(userId, password));

		mgrLogonDAOJdbc.addGlobalLog(userId, logonIP, PWD_MANAGE_OPERATORTYPR,
				"修改密码", 1);

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
				mgrLogonDAOJdbc.addGlobalLog(operator, logonIP,
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
				mgrLogonDAOJdbc.addGlobalLog(user.getUserId(), user.getIP(),
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
	 * @return true 已登录；false 未登录；
	 * @throws Exception
	 */
	public boolean isLogon(String userId, long sessionId) throws Exception {
		logger.info("用户" + userId + "验证sessionId是否已登录");
		try {
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
	 * @return 成功返回sessionID；-1：au没有此用户
	 */
	public User getUserInfo(String userId) {
		User user = mgrLogonDAOJdbc.getUserByID(userId);
		user.setPassword("");

		return user;
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
		Log logger = LogFactory.getLog(MgrLogonActualize.class);

		logger.info("正在启动测试．．．");
		try {
			MgrLogonActualize.createInstance("mgr", (short) 1, null, 1,
					(DataSource) GnntBeanFactory.getBean("dataSource"));
			MgrLogonActualize mgrLogonActualize = MgrLogonActualize
					.getInstance();

			User user = new User();
			user.setUserId("admin");
			user.setPassword("111111");
			user.setKeyCode("0123456789ABCDE");

			String ip = InetAddress.getLocalHost().getHostAddress();

			long sessionId = mgrLogonActualize.logon(user.getUserId(), user
					.getPassword(), user.getKeyCode(), ip);
			System.out.println("登录返回值=" + sessionId);

			user.setUserId("mengy");
			user.setPassword("111111");
			user.setKeyCode("0123456789ABCDE");

			sessionId = mgrLogonActualize.logon(user.getUserId(), user
					.getPassword(), user.getKeyCode(), ip);
			System.out.println("登录返回值=" + sessionId);

			// System.out.println("登录验证"
			// + mgrLogonActualize.isLogon(user.getUserId(), sessionId));
			//
			// System.out.println("登录验证"
			// + mgrLogonActualize.isLogon(user.getUserId(), 111L));
			//
			// System.out.println("修改密码结果"
			// + mgrLogonActualize.changePassowrd(user.getUserId(),
			// "11111", "111111", ip));
			// System.out.println("修改密码结果"
			// + mgrLogonActualize.changePassowrd(user.getUserId(),
			// "111111", "111111", InetAddress.getLocalHost()
			// .getHostAddress()));
			//
			// System.out.println(mgrLogonActualize.getAllUsers()[0]);
			//
			// System.out.println(mgrLogonActualize.getUserInfo(user.getUserId())
			// .getName());
			//
			// System.out.println(mgrLogonActualize.getUser(sessionId)
			// .getLastTime());
			//
			// mgrLogonActualize.logoff(sessionId);
			//
			// mgrLogonActualize.logoff("operator", user.getUserId(), ip);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
