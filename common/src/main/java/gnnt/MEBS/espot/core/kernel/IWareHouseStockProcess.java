package gnnt.MEBS.espot.core.kernel;

import gnnt.MEBS.espot.core.vo.ResultVO;

/**
 * 仓单处理接口
 * 
 * @author xuejt
 * 
 */
public interface IWareHouseStockProcess {

	/**
	 * 为订单转入仓单
	 * 
	 * @param reserveID
	 *            订单ID
	 * @param goodsArr
	 *            仓单
	 * 
	 * @param lastTransfer
	 *            是否最后一次转入；当转入的数量在溢长溢短范围内时判断是否完成交货
	 * @return
	 */
	public ResultVO transferGoodsForReserve(long reserveID,
			String[] goodsArr, boolean lastTransfer);

	/**
	 * 转入仓单
	 * 
	 * @param holdingID
	 *            持仓单号
	 * @param goodsArr
	 *            仓单数组
	 * @param lastTransfer
	 *            是否最后一次转入；当转入的数量在溢长溢短范围内时判断是否完成交货
	 * @return
	 */
	public ResultVO transferGoodsForTrade(long holdingID, String[] goodsArr,
			boolean lastTransfer);

	/**
	 * 支付仓单给买方
	 * 
	 * @param holdingID
	 *            持仓单号
	 * @param goodsArr
	 *            仓单数组
	 * @return
	 */
	public ResultVO paymentGoodsTOBuy(long holdingID, String[] goodsArr);
}
