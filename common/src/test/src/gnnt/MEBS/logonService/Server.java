
package gnnt.MEBS.logonService;

import gnnt.MEBS.logonService.kernel.impl.LogonService_Standard;
import gnnt.MEBS.logonService.po.LogonConfigPO;
import gnnt.MEBS.logonService.util.GnntBeanFactory;
import gnnt.MEBS.logonService.util.Tool;
import gnnt.MEBS.logonService.vo.LogonTimeOutThreadVO;
import gnnt.MEBS.logonService.vo.RemoteLogonServerVO;

import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.rmi.Naming;
import java.rmi.RMISecurityManager;
import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;
import java.rmi.server.RMISocketFactory;
import java.util.Map;

import javax.sql.DataSource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * <P>类说明：AU 服务类
 * <br/>
 * <br/>
 * </p>
 * 修改记录:
 * <br/>
 * <ul>
 * 
 * <li> 创建类                    |2014-4-17下午01:27:36|金网安泰 </li>
 * 
 * </ul>
 * @author liuzx
 */
public class Server {
	/** 日志属性 */
	private transient final Log logger = LogFactory.getLog(this.getClass());

	/** 本身实例对象 */
	private volatile static Server instance;

	/**
	 * 
	 * 构造方法
	 * <br/><br/>
	 */
	private Server(){
	}

	/**
	 * 
	 * 获取本类实例
	 * <br/><br/>
	 * @return
	 */
	public static Server getInstance(){
		if(instance == null){
			synchronized(Server.class){
				if(instance == null){
					instance = (Server) GnntBeanFactory.getBean("server");
				}
			}
		}
		return instance;
	}

	/**
	 * 
	 * 初始化服务
	 * <br/><br/>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public void initServer() throws Exception{
		LogonService_Standard logonService = new LogonService_Standard();

		//本 AU 编号
		int selfConfigID = Tool.strToInt(GnntBeanFactory.getConfig("selfConfigID"),-1000);

		//重连几次后到数据库重新获取连接
		int clearRMITimes = Tool.strToInt(GnntBeanFactory.getConfig("clearRMITimes"),-1);

		LogonTimeOutThreadVO logonTimeOutThreadVO = new LogonTimeOutThreadVO();
		logonTimeOutThreadVO.setTimeSpace(Tool.strToLong(GnntBeanFactory.getConfig("logonTimeOutTime"),200));
		logonTimeOutThreadVO.setAuExpireTimeMap((Map<String,Long>) GnntBeanFactory.getBean("auExpireTimeMap"));

		DataSource dataSource = (DataSource) GnntBeanFactory.getBean("dataSource");

		logonService.init(selfConfigID, clearRMITimes,logonTimeOutThreadVO, dataSource);

		startRMI(logonService);
	}

	/**
	 * 
	 * 启动 RMI 服务
	 * <br/><br/>
	 * @param logonConfigPO
	 * @throws Exception 
	 */
	private void startRMI(LogonService_Standard logonService) throws Exception{
		if(System.getSecurityManager() != null){
			System.setSecurityManager(new RMISecurityManager());
		}

		LogonConfigPO logonConfigPO = logonService.getSelfLogonConfigPO();

		if(logonConfigPO.getDataPort() != null && logonConfigPO.getDataPort() > 0){
			//定义数据传输端口
			RMISocketFactory.setSocketFactory(new SMRMISocket(logonConfigPO.getDataPort()));
		}

		Registry r = LocateRegistry.getRegistry(logonConfigPO.getPort());
		if(r != null){
			r = LocateRegistry.createRegistry(logonConfigPO.getPort());
		}

		StringBuilder sb = new StringBuilder();
		sb.append("rmi://").append(logonConfigPO.getHostIP()).append(":").append(logonConfigPO.getPort()).append("/").append(logonConfigPO.getServiceName()).append(RemoteLogonServerVO.serviceEnd);
		logger.info("启动 RMI 服务："+sb.toString());
		Naming.rebind(sb.toString(), logonService);
	}

	/**
	 * 数据传输端口设置类
	 */
	private class SMRMISocket extends RMISocketFactory{
		/** 数据传输端口 */
		private int dataPort = 1099;

		/**
		 * 
		 * 构造方法
		 * <br/><br/>
		 * @param dataPort 数据传输端口
		 */
		public SMRMISocket(int dataPort){
			this.dataPort = dataPort;
		}

		@Override
		public ServerSocket createServerSocket(int port) throws IOException {
			if(port<=0){
				port = this.dataPort;
			}
			return new ServerSocket(port);
		}

		@Override
		public Socket createSocket(String host, int port) throws IOException {
			return new Socket(host, port);
		}
	}
}

