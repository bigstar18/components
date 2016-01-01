package gnnt.MEBS.logonService.kernel.impl;

import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import gnnt.MEBS.activeUser.operation.ActiveUserManage;
import gnnt.MEBS.activeUser.util.LogonMode;
import gnnt.MEBS.activeUser.vo.AULogonTimeOutThreadVO;
import gnnt.MEBS.logonService.dao.LogonManagerDAO;
import gnnt.MEBS.logonService.po.LogonConfigPO;
import gnnt.MEBS.logonService.po.ModuleAndAUPO;
import gnnt.MEBS.logonService.vo.LogonTimeOutThreadVO;
import gnnt.MEBS.logonService.vo.RemoteLogonServerVO;

public class LogonServiceBase extends UnicastRemoteObject {
	private static final long serialVersionUID = -3808685203518790727L;
	protected final transient Log logger = LogFactory.getLog(getClass());
	private LogonManagerDAO logonManagerDAO;
	protected int clearRMITimes;
	private LogonConfigPO selfLogonConfigPO;
	protected Map<Integer, RemoteLogonServerVO> logonManagerMap = new HashMap();
	protected Map<Integer, Integer> moduleAndAUMap = new HashMap();

	protected LogonServiceBase() throws RemoteException {
	}

	public void init(LogonConfigPO paramLogonConfigPO, int paramInt, LogonTimeOutThreadVO paramLogonTimeOutThreadVO, DataSource paramDataSource) {
		this.clearRMITimes = paramInt;
		this.logonManagerDAO = new LogonManagerDAO();
		this.logonManagerDAO.setDataSource(paramDataSource);
		this.selfLogonConfigPO = paramLogonConfigPO;
		initLogonManagerMap();
		initModuleAndAUMap();
		initLogonMode();
		startLogonTimeOutThread(paramLogonTimeOutThreadVO);
	}

	public int getConfigID(int i) {
		if (moduleAndAUMap.get(Integer.valueOf(i)) != null)
			return ((Integer) moduleAndAUMap.get(Integer.valueOf(i))).intValue();
		List list = logonManagerDAO.getModuleAndAUList(i, selfLogonConfigPO.getSysname());
		if (list == null || list.size() <= 0) {
			logger.error((new StringBuilder()).append("系统中没有配置模块[").append(i).append("]在[").append(selfLogonConfigPO.getSysname())
					.append("]类型 AU 中的对应关系").toString());
			return -1;
		}
		if (list.size() > 1) {
			String s = "";
			for (Iterator iterator1 = list.iterator(); iterator1.hasNext();) {
				ModuleAndAUPO moduleandaupo1 = (ModuleAndAUPO) iterator1.next();
				if (s.trim().length() > 0)
					s = (new StringBuilder()).append(s).append(",").toString();
				s = (new StringBuilder()).append(s).append(moduleandaupo1.getConfigID()).toString();
			}

			logger.error(
					(new StringBuilder()).append("系统中找到模块[").append(i).append("]对应[").append(s).append("]多个 AU 系统将从中找到第一个可用的 AU 作为对应连接").toString());
		}
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			ModuleAndAUPO moduleandaupo = (ModuleAndAUPO) iterator.next();
			int j = moduleandaupo.getConfigID();
			if (logonManagerMap.get(Integer.valueOf(j)) != null) {
				moduleAndAUMap.put(Integer.valueOf(i), Integer.valueOf(j));
				return j;
			}
			LogonConfigPO logonconfigpo = logonManagerDAO.getLogonConfigByID(j);
			if (logonconfigpo != null && logonconfigpo.getHostIP() != null && logonconfigpo.getHostIP().trim().length() > 0) {
				RemoteLogonServerVO remotelogonservervo = new RemoteLogonServerVO();
				remotelogonservervo.setLogonConfigPO(logonconfigpo);
				logonManagerMap.put(logonconfigpo.getConfigID(), remotelogonservervo);
				logger.info((new StringBuilder()).append("加载 ").append(logonconfigpo.getConfigID()).append("AU ：rmi://")
						.append(logonconfigpo.getHostIP()).append(":").append(logonconfigpo.getPort()).append("/")
						.append(logonconfigpo.getServiceName()).append("LogonService").toString());
				moduleAndAUMap.put(Integer.valueOf(i), Integer.valueOf(j));
				return j;
			}
		}

		logger.error((new StringBuilder()).append("模块[").append(i).append("]对应的 AU 不可用，请调整").toString());
		return -1;
	}

	private void initLogonManagerMap() {
		this.logger.info("加载除本 AU 外的其他同组 AU 信息 ......");
		List localList = this.logonManagerDAO.getLogonConfigList(this.selfLogonConfigPO.getSysname());
		if ((localList != null) && (localList.size() > 0)) {
			Iterator localIterator = localList.iterator();
			while (localIterator.hasNext()) {
				LogonConfigPO localLogonConfigPO = (LogonConfigPO) localIterator.next();
				if ((localLogonConfigPO.getConfigID() != this.selfLogonConfigPO.getConfigID()) && (localLogonConfigPO.getHostIP() != null)
						&& (localLogonConfigPO.getHostIP().trim().length() > 0)) {
					RemoteLogonServerVO localRemoteLogonServerVO = new RemoteLogonServerVO();
					localRemoteLogonServerVO.setLogonConfigPO(localLogonConfigPO);
					this.logonManagerMap.put(localLogonConfigPO.getConfigID(), localRemoteLogonServerVO);
					this.logger.info("加载 " + localLogonConfigPO.getConfigID() + "AU ：rmi://" + localLogonConfigPO.getHostIP() + ":"
							+ localLogonConfigPO.getPort() + "/" + localLogonConfigPO.getServiceName() + "LogonService");
				}
			}
		}
	}

	private void initModuleAndAUMap() {
		this.logger.info("加载各个模块对应 AU 编号信息......");
		List localList = this.logonManagerDAO.getModuleAndAUList(this.selfLogonConfigPO.getSysname());
		if ((localList == null) || (localList.size() <= 0)) {
			this.logger.error("没有模块用到类型为 " + this.selfLogonConfigPO.getSysname() + " 的  AU ，无需启动 ......");
			throw new IllegalArgumentException("没有模块用到类型为 " + this.selfLogonConfigPO.getSysname() + " 的  AU ，无需启动 ......");
		}
		HashMap localHashMap = new HashMap();
		Iterator localIterator = localList.iterator();
		Object localObject;
		StringBuilder localStringBuilder;
		while (localIterator.hasNext()) {
			localObject = (ModuleAndAUPO) localIterator.next();
			if ((this.logonManagerMap.get(Integer.valueOf(((ModuleAndAUPO) localObject).getConfigID())) == null)
					&& (((ModuleAndAUPO) localObject).getConfigID() != this.selfLogonConfigPO.getConfigID().intValue())) {
				localStringBuilder = (StringBuilder) localHashMap.get(Integer.valueOf(((ModuleAndAUPO) localObject).getConfigID()));
				if (localStringBuilder == null) {
					localStringBuilder = new StringBuilder();
					localHashMap.put(Integer.valueOf(((ModuleAndAUPO) localObject).getConfigID()), localStringBuilder);
				} else {
					localStringBuilder.append(",");
				}
				localStringBuilder.append(((ModuleAndAUPO) localObject).getModuleID());
			} else {
				this.moduleAndAUMap.put(Integer.valueOf(((ModuleAndAUPO) localObject).getModuleID()),
						Integer.valueOf(((ModuleAndAUPO) localObject).getConfigID()));
			}
		}
		if (localHashMap.size() > 0) {
			localIterator = localHashMap.keySet().iterator();
			while (localIterator.hasNext()) {
				localObject = (Integer) localIterator.next();
				localStringBuilder = (StringBuilder) localHashMap.get(localObject);
				this.logger.info("有模块[" + localStringBuilder.toString() + "]对应着AU[" + localObject + "]但 AU 无法连接。");
			}
		}
	}

	private void initLogonMode() {
		this.logger.info("初始化本 AU 的互踢模式......");
		if ((this.selfLogonConfigPO.getLogonMode() != null) && (this.selfLogonConfigPO.getLogonMode().intValue() == 2)) {
			ActiveUserManage.getInstance().setLogonMode(LogonMode.MULTI_MODE);
			this.logger.info("AU 当前设置为不互踢模式。");
		} else {
			ActiveUserManage.getInstance().setLogonMode(LogonMode.SINGLE_MODE);
			this.logger.info("AU 当前设置为互踢模式。");
		}
	}

	private void startLogonTimeOutThread(LogonTimeOutThreadVO paramLogonTimeOutThreadVO) {
		this.logger.info("启动 AU 超时自动退出线程......");
		AULogonTimeOutThreadVO localAULogonTimeOutThreadVO = new AULogonTimeOutThreadVO();
		localAULogonTimeOutThreadVO.setAuExpireTimeMap(paramLogonTimeOutThreadVO.getAuExpireTimeMap());
		localAULogonTimeOutThreadVO.setTimeSpace(paramLogonTimeOutThreadVO.getTimeSpace());
		ActiveUserManage.getInstance().startLogonTimeOutThread(localAULogonTimeOutThreadVO);
	}

	protected LogonConfigPO getLogonConfigByID(int paramInt) {
		LogonConfigPO localLogonConfigPO = this.logonManagerDAO.getLogonConfigByID(paramInt);
		return localLogonConfigPO;
	}

	public LogonConfigPO getSelfLogonConfigPO() {
		return this.selfLogonConfigPO;
	}
}
