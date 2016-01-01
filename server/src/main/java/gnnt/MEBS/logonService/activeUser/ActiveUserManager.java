package gnnt.MEBS.logonService.activeUser;

import gnnt.MEBS.logonService.model.ActiveUser;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Hashtable;
import java.util.List;
import java.util.Random;
import java.util.Vector;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * <p>
 * 
 * 此对象负责为各种交易模式的当前登录用户提供管理。
 * 用户登录模式分成SINGLE_MODE和MULTI_MODE两种模。,SINGLE_MODE同一时间只允许用一个用户登录一次
 * ,即同一个用户当他第二次登录时,上一个登录会 自动失效。MULTI_MODE允许同一用户同时多次登录。默认是MULTI_MODE模式。
 * 
 * 版本：1.0.0
 * <p>
 * 
 * 修改记录：
 * <ul>
 * 
 * 
 * </ul>
 */

public class ActiveUserManager {

	private transient final Log logger = LogFactory
			.getLog(ActiveUserManager.class);

	// ActiveUserManager对象实例
	private volatile static ActiveUserManager instance;

	/**
	 * 默认超时线程扫描时间 30秒
	 */
	public final static int space = 30;
	/**
	 * 默认的超时时间是60分钟
	 */
	public final static int expireTime = 60;

	/**
	 * 登录用户超时后回调函数
	 */
	private TimeoutCallback timeoutCallback;

	/**
	 * 默认的用户登录类型是SINGLE_MODE
	 */
	private LogonMode mode;

	/**
	 * 用来存储活动用户的对象
	 */
	private Hashtable<Long, ActiveUser> activeStore = new Hashtable<Long, ActiveUser>(
			600);

	/**
	 * 以userId为主键存贮活动用户;为了方便根据userId进行查找
	 */
	private Hashtable<String, List<ActiveUser>> activeStoreByUserId = new Hashtable<String, List<ActiveUser>>(
			600);

	/**
	 * 用来进行超时扫描监控的内置线程类
	 */
	private AUThread auThread = null;
	/**
	 * 用来生成唯一sessionID的随机对象
	 */
	private Random random = new Random();

	/**
	 * 当前用户数量
	 */
	private int curUserCount = 0;

	/**
	 * 最大用户数量
	 */
	private int maxUserCount = 0;

	/**
	 * 最大用户数量时的时间
	 */
	private Date maxUerTime;

	/**
	 * 数量锁
	 */
	private Object countLock = new Object();

	/**
	 * 获取对象实例 单例模式
	 * <p>
	 * 默认超时默认超时线程扫描时间 30秒；默认的超时时间是60分钟； 默认的用户登录类型是SINGLE_MODE
	 * 
	 * @return
	 */
	public static ActiveUserManager getInstance() {
		return getInstance(ActiveUserManager.space,
				ActiveUserManager.expireTime, LogonMode.SINGLE_MODE, null);
	}

	/**
	 * 获取对象实例 单例模式
	 * 
	 * @param space
	 *            超时扫描的间隔时间;单位秒
	 * @param expireTime
	 *            超时时间；单位分钟
	 * @param mode
	 *            用户登录的管理模式
	 * @param timeoutCallback
	 *            用户登录超时回调
	 * @return
	 */
	public static ActiveUserManager getInstance(int space, int expireTime,
			LogonMode mode, TimeoutCallback timeoutCallback) {
		if (instance == null) {
			synchronized (ActiveUserManager.class) {
				if (instance == null) {
					instance = new ActiveUserManager(space, expireTime, mode,
							timeoutCallback);
				}
			}
		}
		return instance;
	}

	/**
	 * 活动用户管理构造方法
	 * 
	 * @param space
	 *            超时扫描的间隔时间;单位秒
	 * @param expireTime
	 *            超时时间；单位分钟
	 * @param mode
	 *            用户登录的管理模式
	 * @param timeoutCallback
	 *            用户登录超时回调
	 */
	private ActiveUserManager(int space, int expireTime, LogonMode mode,
			TimeoutCallback timeoutCallback) {
		this.mode = mode;
		this.timeoutCallback = timeoutCallback;
		auThread = new AUThread(this, space * 1000, expireTime * 60000);
		auThread.setDaemon(true);
		auThread.start();
	}

	/**
	 * 获取最大在线用户数量
	 * 
	 * @return
	 */
	public int getMaxUserCount() {
		return maxUserCount;
	}

	/**
	 * 最大在线数量清零 重新统计
	 */
	public void clearMaxUserCount() {
		logger.info("清空最大在线数量");
		this.maxUserCount = 0;
	}

	/**
	 * 获取当前在线用户数量
	 * 
	 * @return
	 */
	public int getCurUserCount() {
		return curUserCount;
	}

	/**
	 * 获取最大用户数量时的时间
	 * 
	 * @return
	 */
	public Date getMaxUerTime() {
		return maxUerTime;
	}

	/**
	 * 获取登录用户存储对象
	 * 
	 * @return
	 */
	protected Hashtable<Long, ActiveUser> getActiveStore() {
		return activeStore;
	}

	/**
	 * 获取登录用户超时回调对象
	 * 
	 * @return
	 */
	protected TimeoutCallback getTimeoutCallback() {
		return timeoutCallback;
	}

	/**
	 * 设置登录用户超时回调对象
	 * 
	 * @param timeoutCallback
	 */
	protected void setTimeoutCallback(TimeoutCallback timeoutCallback) {
		this.timeoutCallback = timeoutCallback;
	}

	/**
	 * 将指定用户置为登录状态
	 * 
	 * @param userID
	 *            userID:要登录的用户ID
	 * @return 返回当前用户的sessionID。如果失败返回-1
	 */
	public long logon(String userID) {
		logger.info("用户" + userID + "登录,ip地址为空");
		return logon(userID, null);
	}

	/**
	 * 将指定用户置为登录状态,并记录用户登录的ip地址
	 * 
	 * @param userID
	 *            要登录的用户ID
	 * @param ip
	 *            要登录的用户ip
	 * @return 返回当前用户的sessionID。如果失败返回-1
	 */
	public long logon(String userID, String ip) {
		logger.info("用户" + userID + "登录,ip地址为" + ip);
		// 生成一个此用户对应的ActiveUser 对象
		ActiveUser au = new ActiveUser();
		au.setUserId(userID);
		au.setIP(ip);

		long sessionID;

		// 生成一个新的唯一的sessionID
		sessionID = createSessionID();
		// 如果生成的sessionID已经存在则重新生成
		while (activeStore.containsKey(new Long(sessionID))) {
			sessionID = createSessionID();
		}

		if (mode == LogonMode.SINGLE_MODE) {
			// 如果用户代码为userId的已经登录则删除前面的登录用户
			if (activeStoreByUserId.containsKey(userID)) {
				ActiveUser activeUser = activeStoreByUserId.get(userID).get(0);
				activeStoreByUserId.remove(userID);
				activeStore.remove(activeUser.getSessionId());
				decreaseUserCount();
				logger.info("单一模式下用户已经登录踢出前一登录用户");
			}

			// 将登录用户存储到activeStoreByUserId中
			List<ActiveUser> list = new ArrayList<ActiveUser>();
			list.add(au);
			activeStoreByUserId.put(userID, list);

			// 将登录用户存储到activeStore中
			activeStore.put(new Long(sessionID), au);
		} else if (mode == LogonMode.MULTI_MODE) {
			// 将登录用户存储到activeStoreByUserId中
			List<ActiveUser> list = activeStoreByUserId.get(userID);
			if (list == null) {
				list = new ArrayList<ActiveUser>();
			}
			list.add(au);
			activeStoreByUserId.put(userID, list);

			// 将登录用户存储到activeStore中
			activeStore.put(new Long(sessionID), au);
		} else {
			logger.info("传入的登录模式" + mode + "不正确");
			return -1;
		}
		au.setSessionId(sessionID);
		addUserCount();
		logger.info("用户" + userID + "登录成功");
		return sessionID;
	}

	/**
	 * 注销指定sessionID对应的登录状态
	 * 
	 * @param sessionID
	 *            要注销的sessionID
	 */
	public void logoff(long sessionID) {
		logger.info("sessionID为" + sessionID + "的用户退出");
		ActiveUser activeUser = activeStore.get(sessionID);

		if (activeUser == null) {
			logger.info("不存在sessionID为" + sessionID + "的用户");
			return;
		}

		if (mode == LogonMode.SINGLE_MODE) {
			// 将sessionID为传入的sessionID的登录用户从activeStoreByUserId中移除
			activeStoreByUserId.remove(activeUser.getUserId());
		} else if (mode == LogonMode.MULTI_MODE) {
			// 将sessionID为传入的sessionID的登录用户从activeStoreByUserId中移除
			List<ActiveUser> list = activeStoreByUserId.get(activeUser
					.getUserId());

			if (list != null) {
				for (ActiveUser au : list) {
					if (au.getUserId().equals(activeUser.getUserId())) {
						list.remove(au);
						break;
					}
				}
			}

		}
		// 将sessionID为传入的sessionID的登录用户从activeStore中移除
		activeStore.remove(new Long(sessionID));
		decreaseUserCount();
		logger.info("sessionID为" + sessionID + "的用户为" + activeUser.getUserId()
				+ "退出成功");
	}

	/**
	 * 注销指定userID对应的登录状态。如果是MULTI_MODE模式则注销此用户对应的所有登录会话.
	 * 
	 * @param userID
	 *            要注销的userID
	 * @return 返回注销的登录连接数量
	 */
	public int logoffUser(String userID) {
		logger.info("用户代码为" + userID + "的用户退出");
		// 移除数量
		int n = 0;

		List<ActiveUser> list = activeStoreByUserId.get(userID);

		if (list != null) {
			for (ActiveUser au : list) {
				activeStore.remove(au.getSessionId());
				decreaseUserCount();
				n++;
			}
			activeStoreByUserId.remove(userID);
		}

		logger.info("用户代码为" + userID + "的用户退出成功，登录数量为" + n);
		return n;
	}

	/**
	 * 得到指定sessionID所对应的用户
	 * 
	 * @param sessionID
	 *            要查找的sessionID
	 * @return 返回相应的用户。如果返回为null,则表示此sessionID为无效
	 */
	public ActiveUser getUserID(long sessionID) {
		ActiveUser activeUser = (ActiveUser) activeStore
				.get(new Long(sessionID));
		if (activeUser == null) {
			return null;
		} else {
			activeUser.setLastTime(System.currentTimeMillis());
			return activeUser;
		}
	}

	/**
	 * 返回所有当前有效的登录用户，如果在MUTIL_MODE模式下，同一个用户有多个连接则返回多条记录
	 * 
	 * @return 返回一个字符串数组,数组中的每一个元素代表一个用户登录连接,内容是用户ID和登录的时以及IP地址间用","加以分隔
	 */
	public String[] getAllUsers() {
		if (activeStore.size() == 0) {
			return null;
		}

		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Vector<String> v1 = new Vector<String>();
		StringBuffer tempBuffer = null;
		for (ActiveUser activeUser : activeStore.values()) {
			tempBuffer = new StringBuffer(activeUser.getUserId());
			tempBuffer.append(",");
			tempBuffer.append(formatter.format(activeUser.getLogonTime()));
			tempBuffer.append(",");
			tempBuffer.append(activeUser.getIP());
			v1.addElement(tempBuffer.toString());
		}

		String[] tmp = new String[v1.size()];
		v1.toArray(tmp);
		return tmp;
	}

	/**
	 * 获取用户为UserID的所有登录用户信息
	 * 
	 * @param userId
	 *            要查找的userId
	 * @return 返回一个字符串数组,数组中的每一个元素代表一个用户登录连接,内容是用户ID和登录的时间用","加以分隔；如果没有登录返回空
	 */
	public String[] getAllUsersById(String userId) {
		// 获取登录名为userId的登录列表
		List<ActiveUser> list = activeStoreByUserId.get(userId);
		if (list == null) {
			return null;
		}

		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Vector<String> v1 = new Vector<String>();
		StringBuffer tempBuffer = null;
		for (ActiveUser activeUser : list) {
			tempBuffer = new StringBuffer(activeUser.getUserId());
			tempBuffer.append(",");
			tempBuffer.append(formatter.format(activeUser.getLogonTime()));
			tempBuffer.append(",");
			tempBuffer.append(activeUser.getIP());
			v1.addElement(tempBuffer.toString());
		}
		String[] tmp = new String[v1.size()];
		v1.toArray(tmp);
		return tmp;

	}

	private long createSessionID() {

		long t1 = 0x000000007FFFFFFF & System.currentTimeMillis();

		return ((t1 << 32) | Math.abs(random.nextInt()));
	}

	protected void addUserCount() {
		synchronized (countLock) {
			curUserCount++;
			// 如果当前用户数量大于最大用户数量则重新设置最大用户数量
			if (curUserCount > maxUserCount) {
				maxUserCount = curUserCount;
				maxUerTime = new Date();
			}
		}
	}

	protected void decreaseUserCount() {
		synchronized (countLock) {
			if (curUserCount > 0) {
				curUserCount--;
			}
		}
	}

	/************************** 内嵌类 *************************/

	// 监视线程，用来进行过期检查
	class AUThread extends Thread {
		private boolean isRun = true;
		private ActiveUserManager activeUserManager;
		private Hashtable<Long, ActiveUser> activeStore = null;
		private int space; // 毫秒为单位的间隔时间
		private long expireTime; // 毫秒为单位的超时时间

		public AUThread(ActiveUserManager aum, int space, long expireTime) {
			this.activeUserManager = aum;
			this.space = space;
			this.expireTime = expireTime;
			this.activeStore = aum.getActiveStore();
		}

		public void run() {
			while (isRun) {
				try {
					sleep(space);
					checkExpire();
				} catch (InterruptedException e) {
					System.out.println("AU 监视线程失败");
				} catch (NullPointerException e) {
					System.out.println("checkExire catch NullPointer");
				}
			}
		}

		/**
		 * 遍历存储的登录用户；检查超时的用户并注销此用户
		 */
		private void checkExpire() {
			long curTime = System.currentTimeMillis();
			//超时用户列表
			List<ActiveUser> timeoutActiveUserList = new ArrayList<ActiveUser>();
			
			for (ActiveUser activeUser :  activeStore.values()) {
				if ((curTime - activeUser.getLastTime()) > expireTime) {
					timeoutActiveUserList.add(activeUser);
				}
			}

			for (ActiveUser activeUser :  timeoutActiveUserList) {
				logger.info("用户" + activeUser.getUserId() + "登录超时");
				activeUserManager.logoff(activeUser.getSessionId());
				TimeoutCallback timeoutCallback = activeUserManager
						.getTimeoutCallback();
				if (timeoutCallback != null) {
					timeoutCallback.userTimeout(activeUser);
				}
			}
		}

		public synchronized void wakeup() {
			this.notify();
		}

		/**
		 * 停止线程
		 */
		public void shutdown() {
			isRun = false;
			try {
				this.interrupt();
			} catch (Exception e) {
			}
		}
	}
}