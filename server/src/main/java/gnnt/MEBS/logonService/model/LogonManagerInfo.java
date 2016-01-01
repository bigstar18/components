package gnnt.MEBS.logonService.model;

import java.io.Serializable;

public class LogonManagerInfo implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -2109151655095098174L;
	private String ip;
	private Integer port;
	private String logonTable;
	private String logonUserIDCol;
	private int allowLogonError;

	/**
	 * rmi IP地址
	 * 
	 * @return
	 */
	public String getIp() {
		return ip;
	}

	/**
	 * rmi IP地址
	 * 
	 * @param ip
	 */
	public void setIp(String ip) {
		this.ip = ip;
	}

	/**
	 * rmi 端口
	 * 
	 * @return
	 */
	public Integer getPort() {
		return port;
	}

	/**
	 * rmi 端口
	 * 
	 * @param port
	 */
	public void setPort(Integer port) {
		this.port = port;
	}

	/**
	 * 登录表名
	 * 
	 * @return
	 */
	public String getLogonTable() {
		return logonTable;
	}

	/**
	 * 登录表名
	 * 
	 * @param logonTable
	 */
	public void setLogonTable(String logonTable) {
		this.logonTable = logonTable;
	}

	/**
	 * 登录表中存放用户代码的列名
	 * 
	 * @return
	 */
	public String getLogonUserIDCol() {
		return logonUserIDCol;
	}

	/**
	 * 登录表中存放用户代码的列名
	 * 
	 * @param logonUserIDCol
	 */
	public void setLogonUserIDCol(String logonUserIDCol) {
		this.logonUserIDCol = logonUserIDCol;
	}

	/**
	 * @return 允许错误登录次数
	 */
	public int getAllowLogonError() {
		return allowLogonError;
	}

	/**
	 * @param 允许错误登录次数
	 */
	public void setAllowLogonError(int allowLogonError) {
		this.allowLogonError = allowLogonError;
	}

	
}
