
package gnnt.MEBS.logonService.vo;

import gnnt.MEBS.logonService.kernel.ILogonService;
import gnnt.MEBS.logonService.po.LogonConfigPO;

import java.rmi.Naming;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * <P>类说明：用户登录信息 AU
 * <br/>
 * <br/>
 * </p>
 * 修改记录:
 * <br/>
 * <ul>
 * 
 * <li> 创建类                    |2014-4-24下午02:56:25|金网安泰 </li>
 * 
 * </ul>
 * @author liuzx
 */
public class RemoteLogonServerVO {
	/** 日志属性 */
	private transient final Log logger = LogFactory.getLog(this.getClass());

	/** 服务名结尾 */
	public static final String serviceEnd = "LogonService";
	
	/** 连接信息实例 */
	private LogonConfigPO logonConfigPO;
	
	/** RMI 连接 */
	private ILogonService rmiService;

	/** 重置 RMI 次数 */
	private int clearTimes = 0;

	/**
	 * 
	 * 连接信息实例
	 * <br/><br/>
	 * @return
	 */
	public LogonConfigPO getLogonConfigPO() {
		return logonConfigPO;
	}

	/**
	 * 
	 * 连接信息实例
	 * <br/><br/>
	 * @param logonConfigPO
	 */
	public void setLogonConfigPO(LogonConfigPO logonConfigPO) {
		clearRMI();//重置连接
		clearTimes = 0;//重置次数清零
		this.logonConfigPO = logonConfigPO;
	}

	/**
	 * 
	 * 获取 RMI 连接
	 * <br/><br/>
	 * @return ILogonService
	 * @throws Exception
	 */
	public ILogonService getRmiService() throws Exception{
		if(rmiService != null){
			return rmiService;
		}

		StringBuilder sb = new StringBuilder();
		sb.append("rmi://").append(logonConfigPO.getHostIP()).append(":").append(logonConfigPO.getPort()).append("/").append(logonConfigPO.getServiceName()).append(serviceEnd);
		logger.info("连接 RMI 服务："+sb.toString());

		rmiService = (ILogonService) Naming.lookup(sb.toString());
		return rmiService;
	}

	/**
	 * 
	 * 设置  RMI 连接
	 * <br/><br/>
	 * @param rmiService
	 */
	public void setRmiService(ILogonService rmiService) {
		this.rmiService = rmiService;
	}

	/**
	 * 
	 * 重置 RMI 连接
	 * <br/><br/>
	 * @return int 重置次数
	 */
	public int clearRMI(){
		clearTimes ++;
		rmiService = null;
		return clearTimes;
	}

}

