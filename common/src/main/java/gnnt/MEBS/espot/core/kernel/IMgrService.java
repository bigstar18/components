package gnnt.MEBS.espot.core.kernel;

import gnnt.MEBS.espot.core.po.MarketPO;

import java.rmi.RemoteException;
import java.util.Date;
import java.util.List;

/**
 * 为后台提供服务的接口
 * 
 * @author xuejt
 * 
 */
public interface IMgrService {

	/**
	 * 设置系统实时生效参数
	 * @param propertys [key 系统参数key值]
	 * @throws Exception
	 */
	public void setProperty(List<String> propertykeys) throws RemoteException;

	/**
	 * 开市
	 */
	public void openTrade() throws RemoteException;;

	/**
	 * 暂停交易
	 * 
	 * @throws RemoteException
	 */
	public void pauseTrade() throws RemoteException;

	/**
	 * 根据时间来恢复暂停后的交易
	 * 
	 * @param recoverTime
	 *            恢复时间 HH:mm:ss表示
	 */
	public void timingRecoverTrade(String recoverTime) throws RemoteException;

	/**
	 * 设置系统运行模式
	 * 
	 * @param runMode
	 */
	public void setRunMode(String runMode) throws RemoteException;

	/**
	 *恢复交易
	 */
	public void recoverTrade() throws RemoteException;;

	/**
	 * 闭市
	 */
	public void closeTrade() throws RemoteException;;

	/**
	 * 获取交易服务器状态
	 * 
	 * @return 交易服务器状态
	 * @throws RemoteException
	 */
	public int getSystemStatus() throws RemoteException;

	/**
	 * 刷新交易时间
	 * 
	 * @throws RemoteException
	 */
	public void refreshTradeTime() throws RemoteException;

	/**
	 * 查询数据库当前日期时间
	 * 
	 * @return sysdate
	 */
	public Date getCurDbDate() throws RemoteException;

	/**
	 * 获取内存中市场参数信息
	 * 
	 * @return
	 */
	public MarketPO getMarketInfo() throws RemoteException;

	/**
	 * 判断当前时间是否属于交易日
	 * 
	 * @return
	 * @throws RemoteException
	 */
	public boolean isTradeDate() throws RemoteException;
}
