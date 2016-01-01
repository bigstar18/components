
package gnnt.MEBS.logonService.po;
/**
 * <P>类说明：单点登录配置信息
 * <br/>
 * <br/>
 * </p>
 * 修改记录:
 * <br/>
 * <ul>
 * 
 * <li> 创建类                    |2014-4-18下午01:28:40|金网安泰 </li>
 * 
 * </ul>
 * @author liuzx
 */
public class LogonConfigPO extends Clone{
	/** 登录配置编号 */
	private Integer configID;

	/** 服务 IP 地址 */
	private String hostIP;

	/** 监听端口 */
	private Integer port;

	/** 数据传输端口 */
	private Integer dataPort;

	/** RMI 服务名 */
	private String serviceName;

	/**
	 * 是否互踢<br/>
	 * 1 互踢;2 不互踢
	 */
	private Integer logonMode;

	/**
	 * 系统名称<br/>
	 * 前台：front<br/>
	 * 后台：mgr<br/>
	 * 仓库端：warehouse<br/>
	 * 会员端：broker
	 */
	private String sysname;

	/**
	 * 
	 * 登录配置编号
	 * <br/><br/>
	 * @return
	 */
	public Integer getConfigID() {
		return configID;
	}

	/**
	 * 
	 * 登录配置编号
	 * <br/><br/>
	 * @param configID
	 */
	public void setConfigID(Integer configID) {
		this.configID = configID;
	}

	/**
	 * 
	 * 服务 IP 地址
	 * <br/><br/>
	 * @return
	 */
	public String getHostIP() {
		return hostIP;
	}

	/**
	 * 
	 * 服务 IP 地址
	 * <br/><br/>
	 * @param hostIP
	 */
	public void setHostIP(String hostIP) {
		this.hostIP = hostIP;
	}

	/**
	 * 
	 * 监听端口
	 * <br/><br/>
	 * @return
	 */
	public Integer getPort() {
		return port;
	}

	/**
	 * 
	 * 监听端口
	 * <br/><br/>
	 * @param port
	 */
	public void setPort(Integer port) {
		this.port = port;
	}

	/**
	 * 
	 * 数据传输端口
	 * <br/><br/>
	 * @return
	 */
	public Integer getDataPort() {
		return dataPort;
	}

	/**
	 * 
	 * 数据传输端口
	 * <br/><br/>
	 * @param dataPort
	 */
	public void setDataPort(Integer dataPort) {
		this.dataPort = dataPort;
	}

	/**
	 * 
	 * RMI 服务名
	 * <br/><br/>
	 * @return
	 */
	public String getServiceName() {
		return serviceName;
	}

	/**
	 * 
	 * RMI 服务名
	 * <br/><br/>
	 * @param serviceName
	 */
	public void setServiceName(String serviceName) {
		this.serviceName = serviceName;
	}

	/**
	 * 
	 * 是否互踢<br/>
	 * 1 互踢;2 不互踢
	 * <br/><br/>
	 * @return
	 */
	public Integer getLogonMode() {
		return logonMode;
	}

	/**
	 * 
	 * 是否互踢<br/>
	 * 1 互踢;2 不互踢
	 * <br/><br/>
	 * @param logonMode
	 */
	public void setLogonMode(Integer logonMode) {
		this.logonMode = logonMode;
	}

	/**
	 * 
	 * 系统名称<br/>
	 * 前台：front<br/>
	 * 后台：mgr<br/>
	 * 仓库端：warehouse<br/>
	 * 会员端：broker
	 * <br/><br/>
	 * @return
	 */
	public String getSysname() {
		return sysname;
	}

	/**
	 * 
	 * 系统名称<br/>
	 * 前台：front<br/>
	 * 后台：mgr<br/>
	 * 仓库端：warehouse<br/>
	 * 会员端：broker
	 * <br/><br/>
	 * @param sysname
	 */
	public void setSysname(String sysname) {
		this.sysname = sysname;
	}

}

