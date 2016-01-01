package gnnt.MEBS.activeUserListener.actualize;

import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import gnnt.MEBS.activeUserListener.dao.SelfLogonManagerDAO;
import gnnt.MEBS.activeUserListener.thread.GetAllLogonUserThread;
import gnnt.MEBS.activeUserListener.thread.GetLogonOrLogoffUserThread;
import gnnt.MEBS.logonService.dao.LogonManagerDAO;
import gnnt.MEBS.logonService.po.LogonConfigPO;
import gnnt.MEBS.logonService.util.GnntBeanFactory;
import gnnt.MEBS.logonService.util.Tool;
import gnnt.MEBS.logonService.vo.CompulsoryLogoffVO;
import gnnt.MEBS.logonService.vo.RemoteLogonServerVO;
import gnnt.MEBS.logonService.vo.UserManageVO;

public class LogonUserActualize {
	private final transient Log logger = LogFactory.getLog(getClass());
	private static transient Map<String, LogonUserActualize> instatceMap = new HashMap();
	private Map<Integer, Map<String, Map<String, List<UserManageVO>>>> logonUserMap = new HashMap();
	private LogonManagerDAO logonManagerDAO;
	private SelfLogonManagerDAO selfLogonManagerDAO;
	private Map<Integer, RemoteLogonServerVO> logonManagerMap = new HashMap();
	private int clearRMITimes;
	private GetAllLogonUserThread getAllLogonUserThread;
	private GetLogonOrLogoffUserThread getLogonOrLogoffUserThread;
	private String sysname;

	private LogonUserActualize(DataSource paramDataSource, String paramString, int paramInt) {
		this.sysname = paramString;
		this.clearRMITimes = paramInt;
		this.logonManagerDAO = ((LogonManagerDAO) GnntBeanFactory.getBean("logonManagerDAO"));
		this.selfLogonManagerDAO = ((SelfLogonManagerDAO) GnntBeanFactory.getBean("selfLogonManagerDAO"));
		this.logger.info("获取数据库中配置的[" + paramString + "] AU 配置信息集合");
		List localList = this.logonManagerDAO.getLogonConfigList(paramString);
		if ((localList == null) || (localList.size() <= 0)) {
			throw new IllegalArgumentException("查询系统[" + paramString + "] AU 配置信息失败");
		}
		Iterator localIterator = localList.iterator();
		while (localIterator.hasNext()) {
			LogonConfigPO localLogonConfigPO = (LogonConfigPO) localIterator.next();
			RemoteLogonServerVO localRemoteLogonServerVO = new RemoteLogonServerVO();
			localRemoteLogonServerVO.setLogonConfigPO(localLogonConfigPO);
			this.logger.info("记录连接[" + localLogonConfigPO.getConfigID() + "]AU 连接：rim:\\" + localLogonConfigPO.getHostIP() + ":"
					+ localLogonConfigPO.getPort() + "/" + localLogonConfigPO.getServiceName() + "LogonService");
			this.logonManagerMap.put(localLogonConfigPO.getConfigID(), localRemoteLogonServerVO);
		}
	}

	private void startThread() {
		this.getAllLogonUserThread = new GetAllLogonUserThread(this.sysname);
		this.getAllLogonUserThread.start();
		this.getLogonOrLogoffUserThread = new GetLogonOrLogoffUserThread(this.sysname);
		this.getLogonOrLogoffUserThread.start();
	}

	public static LogonUserActualize createInstance(DataSource paramDataSource, String paramString, int paramInt) {
		if (instatceMap.get(paramString) == null) {
			synchronized (LogonUserActualize.class) {
				if (instatceMap.get(paramString) == null) {
					LogonUserActualize localLogonUserActualize = new LogonUserActualize(paramDataSource, paramString, paramInt);
					instatceMap.put(paramString, localLogonUserActualize);
					localLogonUserActualize.startThread();
				}
			}
		}
		return (LogonUserActualize) instatceMap.get(paramString);
	}

	public static LogonUserActualize getInstance(String paramString) {
		return (LogonUserActualize) instatceMap.get(paramString);
	}

	public Map<Integer, Map<String, Map<String, List<UserManageVO>>>> getLogonUserMap() {
		return this.logonUserMap;
	}

	public int getClearRMITimes() {
		return this.clearRMITimes;
	}

	public Map<Integer, RemoteLogonServerVO> getLogonManagerMap() {
		return this.logonManagerMap;
	}

	public LogonManagerDAO getLogonManagerDAO() {
		return this.logonManagerDAO;
	}

	public SelfLogonManagerDAO getSelfLogonManagerDAO() {
		return this.selfLogonManagerDAO;
	}

	public List getOnLineUserList(Integer integer, String s, String s1) {
		ArrayList arraylist = new ArrayList();
		HashMap hashmap = new HashMap();
		synchronized (logonUserMap) {
			for (Iterator iterator1 = logonUserMap.keySet().iterator(); iterator1.hasNext();) {
				Integer integer1 = (Integer) iterator1.next();
				if (integer == null || integer.intValue() == integer1.intValue()) {
					Map map1 = (Map) logonUserMap.get(integer1);
					Iterator iterator2 = map1.keySet().iterator();
					while (iterator2.hasNext()) {
						String s2 = (String) iterator2.next();
						if (s == null || s.trim().length() <= 0 || s.equals(s2)) {
							Map map2 = (Map) map1.get(s2);
							Iterator iterator3 = map2.keySet().iterator();
							while (iterator3.hasNext()) {
								String s3 = (String) iterator3.next();
								if (s1 == null || s1.trim().length() <= 0 || s1.equals(s3)) {
									List list = (List) map2.get(s3);
									UserManageVO usermanagevo1 = (UserManageVO) list.get(0);
									hashmap.put(usermanagevo1.getUserID(), usermanagevo1);
								}
							}
						}
					}
				}
			}

		}
		UserManageVO usermanagevo;
		for (Iterator iterator = hashmap.values().iterator(); iterator.hasNext(); arraylist.add((new StringBuilder()).append(usermanagevo.getUserID())
				.append(",").append(usermanagevo.getLogonIp()).append(",").append(Tool.fmtTime(usermanagevo.getLogonTime())).toString()))
			usermanagevo = (UserManageVO) iterator.next();

		System.out.println((new StringBuilder()).append("result: ").append(arraylist).toString());
		return arraylist;
	}

	public int compulsoryLogoff(CompulsoryLogoffVO compulsorylogoffvo) {
		int i = 1;
		synchronized (logonUserMap) {
			for (Iterator iterator1 = logonUserMap.keySet().iterator(); iterator1.hasNext();) {
				Integer integer1 = (Integer) iterator1.next();
				Map map1 = (Map) logonUserMap.get(integer1);
				Iterator iterator2 = map1.keySet().iterator();
				while (iterator2.hasNext()) {
					String s = (String) iterator2.next();
					Map map2 = (Map) map1.get(s);
					Iterator iterator3 = compulsorylogoffvo.getUserIDList().iterator();
					while (iterator3.hasNext()) {
						String s1 = (String) iterator3.next();
						map2.remove(s1);
					}
				}
			}

		}
		Iterator iterator = logonManagerMap.keySet().iterator();
		do {
			if (!iterator.hasNext())
				break;
			Integer integer = (Integer) iterator.next();
			RemoteLogonServerVO remotelogonservervo = (RemoteLogonServerVO) logonManagerMap.get(integer);
			System.out.println(integer);
			try {
				remotelogonservervo.getRmiService().compulsoryLogoff(compulsorylogoffvo);
			} catch (RemoteException remoteexception) {
				int j = remotelogonservervo.clearRMI();
				try {
					remotelogonservervo.getRmiService().compulsoryLogoff(compulsorylogoffvo);
				} catch (RemoteException remoteexception1) {
					logger.error(
							(new StringBuilder()).append("连接 RMI 服务：rmi:\\").append(remotelogonservervo.getLogonConfigPO().getHostIP()).append(":")
									.append(remotelogonservervo.getLogonConfigPO().getPort()).append("/")
									.append(remotelogonservervo.getLogonConfigPO().getServiceName()).append("LogonService").append(" 异常").toString(),
							remoteexception);
					if (clearRMITimes > 0 && j > clearRMITimes) {
						LogonConfigPO logonconfigpo = logonManagerDAO
								.getLogonConfigByID(remotelogonservervo.getLogonConfigPO().getConfigID().intValue());
						if (logonconfigpo != null)
							remotelogonservervo.setLogonConfigPO(logonconfigpo);
					}
					if (i == 1)
						i = -1;
				} catch (Exception exception1) {
					logger.error((new StringBuilder()).append("调用 RMI[").append(integer).append("]强制退出用户异常").toString(), remoteexception);
					if (i != -2)
						i = -2;
				}
			} catch (Exception exception) {
				logger.error((new StringBuilder()).append("调用 RMI[").append(integer).append("]强制退出用户异常").toString(), exception);
				if (i != -2)
					i = -2;
			}
		} while (true);
		return i;
	}
}
