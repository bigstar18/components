
package gnnt.MEBS.logonService.kernel.impl;

import gnnt.MEBS.activeUser.operation.ActiveUserManage;
import gnnt.MEBS.activeUser.util.LogonMode;
import gnnt.MEBS.activeUser.vo.AULogonTimeOutThreadVO;
import gnnt.MEBS.logonService.dao.LogonManagerDAO;
import gnnt.MEBS.logonService.po.LogonConfigPO;
import gnnt.MEBS.logonService.po.ModuleAndAUPO;
import gnnt.MEBS.logonService.vo.LogonTimeOutThreadVO;
import gnnt.MEBS.logonService.vo.RemoteLogonServerVO;

import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * <P>类说明：登录相关 RMI 父类
 * <br/>
 * <br/>
 * </p>
 * 修改记录:
 * <br/>
 * <ul>
 * 
 * <li> 创建类                    |2014-4-24下午03:24:16|金网安泰 </li>
 * 
 * </ul>
 * @author liuzx
 */
public class LogonServiceBase extends UnicastRemoteObject{
	/** 序列编号 */
	private static final long serialVersionUID = -3808685203518790727L;

	/** 日志属性 */
	protected transient final Log logger = LogFactory.getLog(this.getClass());

	/** 数据库查询 */
	private LogonManagerDAO logonManagerDAO;

	/** 多少次重新连接 RMI 服务失败后，则重新获取连接 */
	protected int clearRMITimes;

	/** 本 RMI 信息 */
	private LogonConfigPO selfLogonConfigPO;

	/**
	 * 同本系统名称一致的所有 AU 非本 RMI 服务 Map集合<br/>
	 * key AU 编号;value AU 连接信息
	 */
	protected Map<Integer,RemoteLogonServerVO> logonManagerMap = new HashMap<Integer,RemoteLogonServerVO>();

	/**
	 * 同本系统名称一致的所有模块对应 AU 编号的 Map 集合<br/>
	 * key 模块编号;value AU 编号
	 */
	protected Map<Integer,Integer> moduleAndAUMap = new HashMap<Integer,Integer>();

	/**
	 * 
	 * 构造方法
	 * <br/><br/>
	 * @throws RemoteException
	 */
	protected LogonServiceBase() throws RemoteException {
		super();
	}

	/**
	 * 
	 * 初始化服务
	 * <br/><br/>
	 * @param selfConfigID 本 AU 编号
	 * @param clearRMITimes 重置 RMI 连接次数后重新到数据库中获取连接地址的次数
	 * @param logonTimeOutThreadVO 登录超时扫描线程信息
	 * @param dataSource 数据源
	 */
	public void init(int selfConfigID,int clearRMITimes,LogonTimeOutThreadVO logonTimeOutThreadVO,DataSource dataSource){
		this.clearRMITimes = clearRMITimes;

		logonManagerDAO = new LogonManagerDAO();
		logonManagerDAO.setDataSource(dataSource);

		//初始化本 AU 信息
		this.initSelfLogonConfig(selfConfigID);

		//初始化本 AU 同组 AU 信息
		this.initLogonManagerMap();

		//初始化 模块和 AU 对应关系 Map
		initModuleAndAUMap();

		//初始化本 AU 互踢模式
		this.initLogonMode();

		//启动登录超时线程
		this.startLogonTimeOutThread(logonTimeOutThreadVO);
	}

	/**
	 * 
	 * 通过模块编号获取 AU 编号
	 * <br/><br/>
	 * @param moduleID 模块编号
	 * @return int AU 编号 (-1 表示没有对应关系)
	 */
	public int getConfigID(int moduleID){
		//如果 AU 中已经加载了对应关系，则直接返回对应的 AU 编号
		if(moduleAndAUMap.get(moduleID) != null){
			return moduleAndAUMap.get(moduleID);
		}

		//通过模块编号和系统类型获取对应关系
		List<ModuleAndAUPO> list = logonManagerDAO.getModuleAndAUList(moduleID,selfLogonConfigPO.getSysname());
		if(list == null || list.size() <= 0){
			logger.error("系统中没有配置模块["+moduleID+"]在["+selfLogonConfigPO.getSysname()+"]类型 AU 中的对应关系");
			return -1;
		}

		if(list.size() > 1){
			String aus = "";
			for(ModuleAndAUPO moduleAndAUPO : list){
				if(aus.trim().length() > 0){
					aus += ",";
				}
				aus += moduleAndAUPO.getConfigID();
			}
			logger.error("系统中找到模块["+moduleID+"]对应["+aus+"]多个 AU 系统将从中找到第一个可用的 AU 作为对应连接");
		}

		for(ModuleAndAUPO moduleAndAUPO : list){
			//配置的 AU 编号
			int configID = moduleAndAUPO.getConfigID();

			//如果对应的 AU 已经在配置中，则直接返回对应的 AU 编号
			if(logonManagerMap.get(configID) != null){
				moduleAndAUMap.put(moduleID, configID);
				return configID;
			}

			//通过 AU 编号获取AU信息
			LogonConfigPO logonConfigPO = logonManagerDAO.getLogonConfigByID(configID);

			//如果没有查到 AU 则继续下一循环
			if(logonConfigPO == null){
				continue;
			}

			//如果 AU IP 地址为空，则继续下一循环
			if(logonConfigPO.getHostIP() == null || logonConfigPO.getHostIP().trim().length() <= 0){
				continue;
			}

			RemoteLogonServerVO logonManagerVO = new RemoteLogonServerVO();
			logonManagerVO.setLogonConfigPO(logonConfigPO);
			logonManagerMap.put(logonConfigPO.getConfigID(), logonManagerVO);
			logger.info("加载 "+logonConfigPO.getConfigID()+"AU ：rmi://"+logonConfigPO.getHostIP()+":"+logonConfigPO.getPort()+"/"+logonConfigPO.getServiceName()+RemoteLogonServerVO.serviceEnd);

			moduleAndAUMap.put(moduleID, configID);

			return configID;
		}

		logger.error("模块["+moduleID+"]对应的 AU 不可用，请调整");

		return -1;
	}

	/**
	 * 
	 * 初始化本 AU 数据库配置信息
	 * <br/><br/>
	 * @param selfConfigID
	 * @param logonManagerDAO
	 */
	private void initSelfLogonConfig(int selfConfigID){
		logger.info("加载本 AU 信息......");
		selfLogonConfigPO = logonManagerDAO.getLogonConfigByID(selfConfigID);
		if(selfLogonConfigPO == null){
			throw new IllegalArgumentException("通过编号 "+selfConfigID+"未查询到 AU 配置信息");
		}
	}

	/**
	 * 
	 * 初始化同本 AU 同组的其他 AU 连接
	 * <br/><br/>
	 * @param logonManagerDAO
	 */
	private void initLogonManagerMap(){
		logger.info("加载除本 AU 外的其他同组 AU 信息 ......");
		List<LogonConfigPO> list = logonManagerDAO.getLogonConfigList(selfLogonConfigPO.getSysname());
		if(list != null && list.size() > 0){
			for(LogonConfigPO logonConfigPO : list){//遍历同组连接
				if(logonConfigPO.getConfigID() == selfLogonConfigPO.getConfigID()){
					continue;//不需要加载自己 AU 信息
				}
				if(logonConfigPO.getHostIP() == null || logonConfigPO.getHostIP().trim().length() <= 0){
					continue;//不加载没有配置 IP 地址的 AU 信息
				}
				RemoteLogonServerVO logonManagerVO = new RemoteLogonServerVO();
				logonManagerVO.setLogonConfigPO(logonConfigPO);
				logonManagerMap.put(logonConfigPO.getConfigID(), logonManagerVO);
				logger.info("加载 "+logonConfigPO.getConfigID()+"AU ：rmi://"+logonConfigPO.getHostIP()+":"+logonConfigPO.getPort()+"/"+logonConfigPO.getServiceName()+RemoteLogonServerVO.serviceEnd);
			}
		}
	}

	/**
	 * 
	 * 初始化 模块和 AU 对应关系 Map
	 * <br/><br/>
	 */
	private void initModuleAndAUMap(){
		logger.info("加载各个模块对应 AU 编号信息......");
		List<ModuleAndAUPO> moduleAndAUList = logonManagerDAO.getModuleAndAUList(selfLogonConfigPO.getSysname());

		if(moduleAndAUList == null || moduleAndAUList.size() <= 0){
			logger.error("没有模块用到类型为 "+selfLogonConfigPO.getSysname()+" 的  AU ，无需启动 ......");
			throw new IllegalArgumentException("没有模块用到类型为 "+selfLogonConfigPO.getSysname()+" 的  AU ，无需启动 ......");
		}

		Map<Integer,StringBuilder> noAUMap = new HashMap<Integer,StringBuilder>();
		for(ModuleAndAUPO moduleAndAUPO : moduleAndAUList){
			if(logonManagerMap.get(moduleAndAUPO.getConfigID()) == null && moduleAndAUPO.getConfigID() != selfLogonConfigPO.getConfigID()){
				StringBuilder sb = noAUMap.get(moduleAndAUPO.getConfigID());
				if(sb == null){
					sb = new StringBuilder();
					noAUMap.put(moduleAndAUPO.getConfigID(), sb);
				}else{
					sb.append(",");
				}
				sb.append(moduleAndAUPO.getModuleID());
				continue;
			}
			moduleAndAUMap.put(moduleAndAUPO.getModuleID(), moduleAndAUPO.getConfigID());
		}
		if(noAUMap.size() > 0){
			for(Integer key : noAUMap.keySet()){
				StringBuilder sb = noAUMap.get(key);
				logger.info("有模块["+sb.toString()+"]对应着AU["+key+"]但 AU 无法连接。");
			}
		}
	}

	/**
	 * 
	 * 设置本 AU 是否互踢
	 * <br/><br/>
	 */
	private void initLogonMode(){
		logger.info("初始化本 AU 的互踢模式......");
		if(selfLogonConfigPO.getLogonMode() != null && selfLogonConfigPO.getLogonMode().intValue() == 2){
			ActiveUserManage.getInstance().setLogonMode(LogonMode.MULTI_MODE);
			logger.info("AU 当前设置为不互踢模式。");
		}else{
			ActiveUserManage.getInstance().setLogonMode(LogonMode.SINGLE_MODE);
			logger.info("AU 当前设置为互踢模式。");
		}
	}

	/**
	 * 
	 * 启动超时线程
	 * <br/><br/>
	 * @param logonTimeOutThreadVO
	 */
	private void startLogonTimeOutThread(LogonTimeOutThreadVO logonTimeOutThreadVO){
		logger.info("启动 AU 超时自动退出线程......");

		AULogonTimeOutThreadVO auLogonTimeOutThreadVO = new AULogonTimeOutThreadVO();
		auLogonTimeOutThreadVO.setAuExpireTimeMap(logonTimeOutThreadVO.getAuExpireTimeMap());
		auLogonTimeOutThreadVO.setTimeSpace(logonTimeOutThreadVO.getTimeSpace());

		ActiveUserManage.getInstance().startLogonTimeOutThread(auLogonTimeOutThreadVO);
	}

	/**
	 * 
	 * 通过配置编号获取 AU 配置信息
	 * <br/><br/>
	 * @param configID AU 配置编号
	 * @return
	 */
	protected LogonConfigPO getLogonConfigByID(int configID){
		LogonConfigPO result = logonManagerDAO.getLogonConfigByID(configID);
		return result;
	}

	/**
	 * 
	 * 获取本 AU 数据库配置
	 * <br/><br/>
	 * @return
	 */
	public LogonConfigPO getSelfLogonConfigPO(){
		return selfLogonConfigPO;
	}
}

