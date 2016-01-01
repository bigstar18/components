// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi
// Source File Name: LogonTimeOutThread.java

package gnnt.MEBS.activeUser.thread;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import gnnt.MEBS.activeUser.operation.ActiveUserManage;
import gnnt.MEBS.activeUser.vo.AULogoffVO;
import gnnt.MEBS.activeUser.vo.AULogonTimeOutThreadVO;
import gnnt.MEBS.activeUser.vo.AULogonTypeManageVO;
import gnnt.MEBS.activeUser.vo.AUUserManageVO;

// Referenced classes of package gnnt.MEBS.activeUser.thread:
// BaseThread

public class LogonTimeOutThread extends BaseThread {

	private Map auExpireTimeMap;

	public LogonTimeOutThread(AULogonTimeOutThreadVO logonTimeOutThreadVO) {
		timeSpace = logonTimeOutThreadVO.getTimeSpace();
		if (logonTimeOutThreadVO.getAuExpireTimeMap() != null)
			auExpireTimeMap = logonTimeOutThreadVO.getAuExpireTimeMap();
		else
			auExpireTimeMap = new HashMap();
		logger.debug("设置超时时间：");
		String key;
		for (Iterator iterator = auExpireTimeMap.keySet().iterator(); iterator.hasNext(); logger
				.debug((new StringBuilder("[")).append(key).append(":").append(auExpireTimeMap.get(key)).append("]").toString()))
			key = (String) iterator.next();

	}

	public void run() {
		// 设置线程停止标识符为 false
		this.stop = false;
		while (!stop) {
			try {
				logoffTimeOutUser();
			} catch (Exception e) {
				logger.error("执行用户登录超时退出线程异常", e);
			} finally {
				try {
					Thread.sleep(timeSpace);
				} catch (Exception e) {
					logger.debug("执行线程睡眠异常", e);
				}
			}
		}
	}

	private void logoffTimeOutUser() {
		Map map = ActiveUserManage.getInstance().getLogonTypeMap();
		for (Iterator iterator = map.keySet().iterator(); iterator.hasNext();) {
			String logonType = (String) iterator.next();
			AULogonTypeManageVO logonTypeManageVO = (AULogonTypeManageVO) map.get(logonType);
			try {
				long expireTime = getAUExpireTime(logonType);
				logoffLogonTypeMap(logonTypeManageVO, expireTime);
			} catch (Exception e) {
				logger.error((new StringBuilder("退出类型[")).append(logonType).append("]的超时登录异常").toString(), e);
			}
		}

	}

	private void logoffLogonTypeMap(AULogonTypeManageVO logonTypeManageVO, long expireTime) {
		Map map = logonTypeManageVO.getSessionMap();
		List logoutList = new ArrayList();
		for (Iterator iterator = map.keySet().iterator(); iterator.hasNext();) {
			Long key = (Long) iterator.next();
			AUUserManageVO userManageVO = (AUUserManageVO) map.get(key);
			if (System.currentTimeMillis() - userManageVO.getLastTime() > expireTime)
				logoutList.add(userManageVO);
		}

		for (Iterator iterator1 = logoutList.iterator(); iterator1.hasNext();) {
			AUUserManageVO userManageVO = (AUUserManageVO) iterator1.next();
			try {
				logoffUser(userManageVO);
			} catch (Exception e) {
				logger.error((new StringBuilder("登录超时，退出[")).append(userManageVO.getUserID()).append("]在[").append(userManageVO.getLogonType())
						.append("]的登录[").append(userManageVO.getSessionID()).append("]异常").toString(), e);
			}
		}

	}

	private void logoffUser(AUUserManageVO userManageVO) {
		AULogoffVO logoffVO = new AULogoffVO();
		logoffVO.setLogonType(userManageVO.getLogonType());
		logoffVO.setSessionID(userManageVO.getSessionID());
		logoffVO.setUserID(userManageVO.getUserID());
		ActiveUserManage.getInstance().logoff(logoffVO);
	}

	private long getAUExpireTime(String logonType) {
		long result = 0x6ddd00L;
		if (auExpireTimeMap != null && auExpireTimeMap.get(logonType) != null)
			result = ((Long) auExpireTimeMap.get(logonType)).longValue();
		return result;
	}
}
