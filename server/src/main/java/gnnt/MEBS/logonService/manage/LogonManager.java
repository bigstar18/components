package gnnt.MEBS.logonService.manage;

import gnnt.MEBS.logonService.activeUser.ActiveUserManager;
import gnnt.MEBS.logonService.activeUser.LogonMode;
import gnnt.MEBS.logonService.activeUser.TimeoutCallback;
import gnnt.MEBS.logonService.dao.jdbc.LogonManagerDAOJdbc;
import gnnt.MEBS.logonService.model.ActiveUser;
import gnnt.MEBS.logonService.model.LogonManagerInfo;
import gnnt.MEBS.logonService.util.GnntBeanFactory;
import gnnt.MEBS.logonService.util.MD5;

import java.rmi.Naming;
import java.rmi.RMISecurityManager;
import java.rmi.RemoteException;
import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;
import java.rmi.server.UnicastRemoteObject;
import java.util.Map;

import javax.sql.DataSource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * 登录管理
 * <p>
 * 使用此类需要有一个m_logonConfig表；该表存放rmi主机地址端口 登录用户所在表；用户代码对应的列名等信息；表结构如下
 * <ul>
 * -- Create table create table M_LOGONCONFIG ( SYSNAME VARCHAR2(50) not null,
 * HOSTIP VARCHAR2(20) not null, HOSTPORT NUMBER(10) not null, LOGONTABLE
 * VARCHAR2(30) not null, LOGONUSERIDCOL VARCHAR2(30) not null, ALLOWLOGONERROR
 * NUMBER(2) not null ) tablespace USERS pctfree 10 initrans 1 maxtrans 255
 * storage ( initial 64K minextents 1 maxextents unlimited ); -- Create/Recreate
 * primary, unique and foreign key constraints alter table M_LOGONCONFIG add
 * constraint PK_M_LOGONCONFIG primary key (SYSNAME) using index tablespace
 * USERS pctfree 10 initrans 2 maxtrans 255 storage ( initial 64K minextents 1
 * maxextents unlimited );
 * 
 * 
 * @author xuejt
 * 
 */
public class LogonManager extends UnicastRemoteObject implements ILogonManager {

	protected LogonManager() throws RemoteException {
		super();
	}

	private static final long serialVersionUID = -5814636821276785489L;

	private transient final Log logger = LogFactory.getLog(LogonManager.class);

	private volatile static LogonManager logonManager;

	private static ActiveUserManager activeUserManager;

	private LogonManagerInfo logonManagerInfo;

	private LogonManagerDAOJdbc logonManagerDAO;

	/**
	 * 创建一个实例;
	 * <p>
	 * 默认登录模式为单一模式；线程扫描时间30秒；超时时间60分钟；超时没有回调
	 * 
	 * @param sysName
	 *            系统名称
	 * @param ds
	 *            数据源
	 * @return 登录管理对象
	 * @throws Exception
	 */
	public static LogonManager getInstance(String sysName, DataSource ds)
			throws Exception {
		return getInstance(sysName, ds, ActiveUserManager.space,
				ActiveUserManager.expireTime, LogonMode.SINGLE_MODE, null);
	}

	/**
	 * 创建一个实例;
	 * <p>
	 * 默认登录模式为单一模式；线程扫描时间30秒；超时没有回调
	 * 
	 * @param sysName
	 *            系统名称
	 * @param ds
	 *            数据源
	 * @param expireTime
	 *            超时时间
	 * @return 登录管理对象
	 * @throws Exception
	 */
	public static LogonManager getInstance(String sysName, DataSource ds,
			int expireTime) throws Exception {
		return getInstance(sysName, ds, ActiveUserManager.space, expireTime,
				LogonMode.SINGLE_MODE, null);
	}

	/**
	 * 创建一个实例;
	 * <p>
	 * 默认线程扫描时间30秒；超时时间60分钟；超时没有回调
	 * 
	 * @param sysName
	 *            系统名称
	 * @param ds
	 *            数据源
	 * @param mode
	 *            登录模式
	 * @return 登录管理对象
	 * @throws Exception
	 */
	public static LogonManager getInstance(String sysName, DataSource ds,
			LogonMode mode) throws Exception {
		return getInstance(sysName, ds, ActiveUserManager.space,
				ActiveUserManager.expireTime, mode, null);
	}

	/**
	 * 创建一个实例;
	 * <p>
	 * 线程扫描时间30秒；
	 * 
	 * @param sysName
	 *            系统名称
	 * @param ds
	 *            数据源
	 * @param expireTime
	 *            超时时间
	 * @param mode
	 *            登录模式
	 * @param timeoutCallback
	 *            超时回调
	 * @return 登录管理对象
	 * @throws Exception
	 */
	public static LogonManager getInstance(String sysName, DataSource ds,
			int expireTime, LogonMode mode, TimeoutCallback timeoutCallback)
			throws Exception {
		return getInstance(sysName, ds, ActiveUserManager.space, expireTime,
				mode, timeoutCallback);
	}

	/**
	 * 创建一个实例;
	 * <p>
	 * 线程扫描时间30秒；
	 * 
	 * @param sysName
	 *            系统名称
	 * @param ds
	 *            数据源
	 * @param space
	 *            线程扫描时间
	 * @param expireTime
	 *            超时时间
	 * @param mode
	 *            登录模式
	 * @param timeoutCallback
	 *            超时回调
	 * @return 登录管理对象
	 * @throws Exception
	 */
	public static LogonManager getInstance(String sysName, DataSource ds,
			int space, int expireTime, LogonMode mode,
			TimeoutCallback timeoutCallback) throws Exception {
		if (logonManager == null) {
			synchronized (LogonManager.class) {
				if (logonManager == null) {
					logonManager = new LogonManager();
					logonManager.init(sysName, ds);
					logonManager.initActiveUserManager(space, expireTime, mode,
							timeoutCallback);
				}
			}
		}
		return logonManager;
	}

	/**
	 * 创建Au实例
	 * 
	 * @param space
	 *            线程扫面时间
	 * @param expireTime
	 *            超时时间
	 * @param mode
	 *            登录模式
	 * @param timeoutCallback
	 *            超时回调
	 */
	private void initActiveUserManager(int space, int expireTime,
			LogonMode mode, TimeoutCallback timeoutCallback) {
		activeUserManager = ActiveUserManager.getInstance(space, expireTime,
				mode, timeoutCallback);
	}

	// /**
	// * ActiveUserManager对象
	// *
	// * @return
	// */
	// public ActiveUserManager getActiveUserManager() {
	// return activeUserManager;
	// }

	/**
	 *初始化
	 * 
	 * @param sysName
	 *            系统名称
	 * @param ds
	 * @throws Exception
	 */
	private void init(String sysName, DataSource ds) throws Exception {
		logonManagerDAO = new LogonManagerDAOJdbc();
		logonManagerDAO.setDataSource(ds);
		logonManagerInfo = logonManagerDAO
				.getLogonManagerInfoBySysName(sysName);
		if (logonManagerInfo == null) {
			throw new Exception("登录管理初始化失败；没有找到系统名称为" + sysName + "登录信息");
		}
		logger.info("初始化登录管理");

		if (System.getSecurityManager() != null) {
			System.setSecurityManager(new RMISecurityManager());
		}

		try {
			Registry r = LocateRegistry.getRegistry(logonManagerInfo.getPort());
			if (r != null)
				r = LocateRegistry.createRegistry(logonManagerInfo.getPort());

			ILogonManager rmi = this;
			String name = "rmi://" + logonManagerInfo.getIp() + ":"
					+ logonManagerInfo.getPort() + "/" + sysName
					+ "LogonService";
			logger.info("LogonManager rmi bind:" + name);
			Naming.rebind(name, rmi);

			logger.info("==============>LogonManager RMI服务启动成功。");
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.toString());
		}

	}

	/**
	 * 得到指定sessionID所对应的用户ID
	 * 
	 * @param sessionId
	 * @return 返回相应的用户 如果返回为null,则表示此sessionID为无效。
	 */
	public ActiveUser getUser(long sessionId) {
		return activeUserManager.getUserID(sessionId);
	}

	/**
	 * 获得所有登录用户
	 * 
	 * @return 返回一个字符串数组,数组中的每一个元素代表一个用户登录连接,内容是用户ID和登录的时间以及Ip地址用","加以分隔。
	 */
	public String[] getAllUsers() {
		return activeUserManager.getAllUsers();
	}

	/**
	 * 登录
	 * 
	 * @param userId
	 *            用户名
	 * @param password
	 *            密码
	 * @param logonIP
	 *            用户登录IP
	 * @return 返回sessionID
	 */
	public Long logon(String userId, String password, String logonIP) {
		this.logger.debug("Entering 'logon' method");
		// long sessionId = checkPWD(userId, password);
		//
		// if (sessionId == 0) {
		// sessionId = activeUserManager.logon(userId, logonIP);
		// }
		// return sessionId;

		return activeUserManager.logon(userId, logonIP);
	}

	/**
	 * 检查用户名密码
	 * 
	 * @param userId
	 *            用户名
	 * @param password
	 *            密码
	 * @return 成功返回0；-1：交易员代码不存在；-2：口令不正确
	 */
	public Long checkPWD(String userId, String password) {
		this.logger.debug("Entering 'checkPWD' method");
		long result = -100;

		String sql = "select t." + logonManagerInfo.getLogonUserIDCol()
				+ ",password from " + logonManagerInfo.getLogonTable()
				+ " t where  t." + logonManagerInfo.getLogonUserIDCol() + "= '"
				+ userId + "'";

		Map<String, Object> map = this.logonManagerDAO.getMapBySql(sql);

		if (map != null && map.size() > 0) {
			String pwd = (String) map.get("password");
			if (pwd.equals(MD5.getMD5(userId, password))) {
				result = 0;
			} else {
				result = -2L;
			}

		} else {// 交易员不存在
			result = -1L;
		}
		return result;
	}

	/**
	 * 注销指定的用户登录状态
	 * 
	 * @param userId
	 *            用户代码
	 */
	public void logoff(String userId) {
		activeUserManager.logoffUser(userId);
	}

	/**
	 * 获取用户为UserID的所有登录用户信息
	 * 
	 * @param userId
	 *            要查找的userId
	 * @return 返回一个字符串数组,数组中的每一个元素代表一个用户登录连接,内容是用户ID和登录的时间用","加以分隔；如果没有登录返回空
	 */
	public String[] getAllUsersById(String userId) {
		return activeUserManager.getAllUsersById(userId);
	}

	/**
	 * 注销指定sessionID对应的登录状态
	 * 
	 * @param sessionID
	 *            要注销的sessionID
	 */
	public void logoff(long sessionID) {
		activeUserManager.logoff(sessionID);
	}

	/**
	 * 验证是否登录
	 * 
	 * @param userId
	 *            用户代码
	 * @param sessionId
	 *            sessionID
	 * @return true 已登录；false 未登录；
	 */
	public boolean isLogon(String userId, long sessionId) {
		ActiveUser user = activeUserManager.getUserID(sessionId);
		if (user != null && user.getUserId().equals(userId)) {
			return true;
		} else {
			return false;
		}
	}

	public static void main(String[] args) {
		Log logger = LogFactory.getLog(LogonManager.class);

		logger.info("正在启动登录管理．．．");
		try {
			if (args == null || args.length < 1) {
				throw new Exception("请输入要启动登录管理的系统名称");
			}
			LogonManager.getInstance(args[0], (DataSource) GnntBeanFactory
					.getBean("dataSource"));
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("获取登录管理实例失败！");
			System.exit(0);
		}
	}
}
