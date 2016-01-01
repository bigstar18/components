package gnnt.MEBS.bill.core.service;

import gnnt.MEBS.bill.core.bo.StockOutApplyBO;
import gnnt.MEBS.bill.core.bo.StockOutAuditBO;
import gnnt.MEBS.bill.core.po.GoodsPropertyPO;
import gnnt.MEBS.bill.core.po.StockPO;
import gnnt.MEBS.bill.core.vo.AddStockResultVO;
import gnnt.MEBS.bill.core.vo.ResultVO;
import gnnt.MEBS.bill.core.vo.StockAddVO;
import gnnt.MEBS.bill.core.vo.StockQiantityResultVO;

import java.util.List;
import java.util.Map;

/**
 * 仓单相关核心接口
 * 
 * @author xuejt
 * 
 */
public interface IKernelService {
	/**
	 * 录入仓单 准备条件：交易商将商品存入仓库，仓库系统扣留交易商纸质仓单，此仓单出库只能使用密钥
	 * 
	 * @param stockPO
	 *            仓单
	 * @param propertyList
	 *            仓单属性列表
	 * 
	 * @return
	 */
	public AddStockResultVO addStock(StockPO stockPO,
			List<GoodsPropertyPO> propertyList);

	/**
	 * 注册仓单<br>
	 * 修改仓单状态并且通知仓库系统该仓单已注册将不能出库
	 * 
	 * @param stockID
	 *            仓单号
	 * @return
	 */
	public ResultVO registerStock(String stockID);

	/**
	 * 拆仓单
	 * 
	 * @param stockID
	 *            仓单号
	 * @param amountarr
	 *            拆单后数量数组
	 * @return
	 */
	public ResultVO dismantleStock(String stockID, Double[] amountarr);

	/**
	 * 拆仓单审核
	 * 
	 * @param stockID
	 *            仓单号
	 * @param result
	 *            false 失败 true 成功
	 * @param dismantleMap
	 *            拆单成功后使用 key:拆单编码 value:拆单后仓库仓单号
	 * @return
	 */
	public ResultVO dismantleStock(String stockID, boolean result,
			Map<String, String> dismantleMap);

	/**
	 * 注销仓单
	 * 
	 * @param stockID
	 *            仓单号
	 * @return
	 */
	public ResultVO logoutStock(String stockID);

	/**
	 * 
	 * 仓单出库申请(不在系统内部对接仓库时使用)
	 * <br/><br/>
	 * @param stockOutApplyBO 仓单出库申请信息
	 * @return ResultVO
	 */
	public ResultVO stockOutApply(StockOutApplyBO stockOutApplyBO);

	/**
	 * 
	 * 仓单出库审核 (不在系统内部对接仓库时使用)
	 * <br/><br/>
	 * @param stockOutAuditBO 仓单出库审核信息
	 * @return
	 */
	public ResultVO stockOutAudit(StockOutAuditBO stockOutAuditBO);

	/**
	 * 
	 * 撤销仓单出库申请(不在系统内部对接仓库时使用)
	 * <br/><br/>
	 * @param stockID
	 * @return
	 */
	public ResultVO withdrowStockOutApply(String stockID);

	/**
	 * 开放给仓库系统注册仓单使用的方法(系统内部对接仓库时使用)
	 * 
	 * @param request
	 *            注册仓单仓库传来对象
	 * @return AddStockResultVO
	 */
	public AddStockResultVO addStockForWarehouseServer(StockAddVO stockAddVO);

	/**
	 * 仓单出库 需要向仓库系统发送验证时调用(系统内部对接仓库时使用)
	 * 
	 * @param stockID
	 *            仓单号
	 * @param userID
	 *            仓库系统账户编号
	 * @param userName
	 *            仓库系统账户名
	 * @param password
	 *            仓库系统验证密码
	 * @return ResultVO 结果大于1为仓单密钥
	 */
	public ResultVO stockOut(String stockID, String userID, String userName,
			String password);

	
	/**
	 * 获取交易核心配置信息
	 * 
	 * @param key
	 *            配置信息键值
	 * @return 对应的值 如果传入的键值不存在则返回null
	 */
	public String getConfigInfo(String key);

	/**
	 * 
	 * 方法说明：通过品名编号、属性信息、交易商代码、仓单最大数量获取未使用的已注册仓单
	 * <br/>
	 * <br/>
	 *
	 * @param breedID 品名编号
	 * @param propertys 属性信息
	 * @param firmID 交易商代码
	 * @param quantity 仓单最大数量
	 * @return List<String> 仓单编号集合
	 */
	public List<String> getUnusedStocks(long breedID,
			Map<String,String> propertys,String firmID,double quantity);

	/**
	 * 
	 * 方法说明：通过品名编号、属性信息、交易商代码获取未使用的已注册仓单
	 * <br/>
	 * <br/>
	 *
	 * @param breedID 品名编号
	 * @param propertys 属性信息
	 * @param firmID 交易商代码
	 * @return List<String> 仓单编号集合
	 */
	public List<String> getUnusedStocks(long breedID,
			Map<String,String> propertys,String firmID);

	/**
	 * 
	 * 通过模块编号，交易商代码获取本交易商在当个模块的所有未使用仓单
	 * <br/><br/>
	 * @param moduleid 模块编号
	 * @param firmID 交易商代码
	 * @return List<String> 仓单编号集合
	 */
	public List<String> getUnusedStocks(int moduleid,String firmID);

	/**
	 * 
	 * 方法说明：通过仓单编号集合，获取仓单数量的总和
	 * <br/><br/>
	 *
	 * @param stockIDs 仓单编号集合
	 * @return StockQiantityResultVO
	 */
	public StockQiantityResultVO getQuantityByStockIDs(List<String> stockIDs);
}
