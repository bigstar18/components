
package gnnt.MEBS.espot.core.po;

import java.io.Serializable;

/**
 * <P>类说明：系统模块表映射
 * <br/>
 * <br/>
 * </p>
 * 修改记录:
 * <br/>
 * <ul>
 * 
 * <li> 创建类                    |2013-5-23下午04:07:42|金网安泰 </li>
 * 
 * </ul>
 * @author liuzx
 */
public class TradeModelPO extends Clone implements Serializable {
	/** 序列化编号 */
	private static final long serialVersionUID = -4694713224538328888L;

	/** 模块编号 */
	private int moduleID;

	/** 交易模块中文名称 */
	private String cnName;

	/** 交易模块英文简称 */
	private String enName;

	/** 交易模块简称 */
	private String shortName;

	/** 添加交易商函数 */
	private String addFirmFn;

	/** 修改交易商状态函数 */
	private String updateFirmStatusFn;

	/** 删除交易商函数 */
	private String delFirmFn;

	/** 是否用于交易商设置 */
	private String isFirmSet;

	/** 模块主机IP */
	private String hostIP;

	/** 模块主机端口 */
	private int port;

	/** 模块主机数据传输端口 */
	private int rmiDataPort;

	/** 是否用于结算检查 */
	private String isBalanceCheck;

	/**
	 * 
	 * 模块编号
	 * <br/><br/>
	 * @return
	 */
	public int getModuleID() {
		return moduleID;
	}

	/**
	 * 
	 * 模块编号
	 * <br/><br/>
	 * @param moduleID
	 */
	public void setModuleID(int moduleID) {
		this.moduleID = moduleID;
	}

	/**
	 * 
	 * 交易模块中文名称
	 * <br/><br/>
	 * @return
	 */
	public String getCnName() {
		return cnName;
	}

	/**
	 * 
	 * 交易模块中文名称
	 * <br/><br/>
	 * @param cnName
	 */
	public void setCnName(String cnName) {
		this.cnName = cnName;
	}

	/**
	 * 
	 * 交易模块英文简称
	 * <br/><br/>
	 * @return
	 */
	public String getEnName() {
		return enName;
	}

	/**
	 * 
	 * 交易模块英文简称
	 * <br/><br/>
	 * @param enName
	 */
	public void setEnName(String enName) {
		this.enName = enName;
	}

	/**
	 * 
	 * 交易模块简称
	 * <br/><br/>
	 * @return
	 */
	public String getShortName() {
		return shortName;
	}

	/**
	 * 
	 * 交易模块简称
	 * <br/><br/>
	 * @param shortName
	 */
	public void setShortName(String shortName) {
		this.shortName = shortName;
	}

	/**
	 * 
	 * 添加交易商函数
	 * <br/><br/>
	 * @return
	 */
	public String getAddFirmFn() {
		return addFirmFn;
	}

	/**
	 * 
	 * 添加交易商函数
	 * <br/><br/>
	 * @param addFirmFn
	 */
	public void setAddFirmFn(String addFirmFn) {
		this.addFirmFn = addFirmFn;
	}

	/**
	 * 
	 * 修改交易商状态函数
	 * <br/><br/>
	 * @return
	 */
	public String getUpdateFirmStatusFn() {
		return updateFirmStatusFn;
	}

	/**
	 * 
	 * 修改交易商状态函数
	 * <br/><br/>
	 * @param updateFirmStatusFn
	 */
	public void setUpdateFirmStatusFn(String updateFirmStatusFn) {
		this.updateFirmStatusFn = updateFirmStatusFn;
	}

	/**
	 * 
	 * 删除交易商函数
	 * <br/><br/>
	 * @return
	 */
	public String getDelFirmFn() {
		return delFirmFn;
	}

	/**
	 * 
	 * 删除交易商函数
	 * <br/><br/>
	 * @param delFirmFn
	 */
	public void setDelFirmFn(String delFirmFn) {
		this.delFirmFn = delFirmFn;
	}

	/**
	 * 
	 * 是否用于交易商设置
	 * <br/><br/>
	 * @return
	 */
	public String getIsFirmSet() {
		return isFirmSet;
	}

	/**
	 * 
	 * 是否用于交易商设置
	 * <br/><br/>
	 * @param isFirmSet
	 */
	public void setIsFirmSet(String isFirmSet) {
		this.isFirmSet = isFirmSet;
	}

	/**
	 * 
	 * 模块主机IP 
	 * <br/><br/>
	 * @return
	 */
	public String getHostIP() {
		return hostIP;
	}

	/**
	 * 
	 * 模块主机IP 
	 * <br/><br/>
	 * @param hostIP
	 */
	public void setHostIP(String hostIP) {
		this.hostIP = hostIP;
	}

	/**
	 * 
	 * 模块主机端口
	 * <br/><br/>
	 * @return
	 */
	public int getPort() {
		return port;
	}

	/**
	 * 
	 * 模块主机端口
	 * <br/><br/>
	 * @param port
	 */
	public void setPort(int port) {
		this.port = port;
	}

	/**
	 * 
	 * 模块主机数据传输端口
	 * <br/><br/>
	 * @return
	 */
	public int getRmiDataPort() {
		return rmiDataPort;
	}

	/**
	 * 
	 * 模块主机数据传输端口
	 * <br/><br/>
	 * @param rmiDataPort
	 */
	public void setRmiDataPort(int rmiDataPort) {
		this.rmiDataPort = rmiDataPort;
	}

	/**
	 * 
	 * 是否用于结算检查
	 * <br/><br/>
	 * @return
	 */
	public String getIsBalanceCheck() {
		return isBalanceCheck;
	}

	/**
	 * 
	 * 是否用于结算检查
	 * <br/><br/>
	 * @param isBalanceCheck
	 */
	public void setIsBalanceCheck(String isBalanceCheck) {
		this.isBalanceCheck = isBalanceCheck;
	}
}

