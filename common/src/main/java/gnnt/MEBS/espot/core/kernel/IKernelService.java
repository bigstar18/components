package gnnt.MEBS.espot.core.kernel;

import gnnt.MEBS.espot.core.vo.CoreValueVO;
import gnnt.MEBS.espot.core.vo.FeeComputeArithmeticVO;

import java.rmi.RemoteException;

/**
 * 核心服务
 * 
 * @author xuejt
 * 
 */
public interface IKernelService {
	/**
	 * 关闭服务
	 * 
	 * @return
	 */
	public boolean shutdown();


	/**
	 * 获取交易核心中的值对象
	 * 
	 * @return
	 */
	public CoreValueVO getCoreValueVO();

	/**
	 * 修改商品信息 供后台在修改商品信息后调用
	 */
	public void updateCommdityInfo();


	/**
	 * 获取履约保证金算法
	 * 
	 * @param firmID
	 *            交易商代码
	 * @param categoryID
	 *            产品分类
	 * @return 算法
	 * @throws RemoteException
	 */
	public FeeComputeArithmeticVO getDeliveryMarginArithmetic(String firmID,
			long categoryID) throws RemoteException;

	/**
	 * 获取交易手续费
	 * 
	 * @param firmID
	 *            交易商代码
	 * @param categoryID
	 *            产品分类
	 * @return 算法
	 * @throws RemoteException
	 */
	public FeeComputeArithmeticVO getTradeFeeArithmetic(String firmID,
			long categoryID) throws RemoteException;

	/**
	 * 获取交收手续费
	 * 
	 * @param firmID
	 *            交易商代码
	 * @param categoryID
	 *            产品分类
	 * @return 算法
	 * @throws RemoteException
	 */
	public FeeComputeArithmeticVO getDeliveryFeeArithmetic(String firmID,
			long categoryID) throws RemoteException;

	

	/**
	 * 获取默认履约保证金
	 * 
	 * @return
	 * @throws RemoteException
	 */
	public FeeComputeArithmeticVO getDefaultDeliveryMarginArithmetic()
			throws RemoteException;

	/**
	 * 获取交易核心配置信息
	 * 
	 * @param key
	 *            配置信息键值
	 * @return 对应的值 如果传入的键值不存在则返回null
	 */
	public String getConfigInfo(String key);
	
	/**
	 * 获取单笔委托诚信保障金
	 * 方法说明：<br/>
	 * <br/>
	 *
	 * @return
	 */
	public double getOneTradeMargin();
	
	/**
	 * 给交易员发送消息
	 * 
	 * @param traderID
	 *            交易员代码
	 * @param msg
	 *            消息
	 */
	public void sendMsgToTrader(String traderID, String msg);
}
