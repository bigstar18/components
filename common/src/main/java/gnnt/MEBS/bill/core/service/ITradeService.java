package gnnt.MEBS.bill.core.service;

import gnnt.MEBS.bill.core.vo.DeliveryVO;
import gnnt.MEBS.bill.core.vo.FinancingApplyVO;
import gnnt.MEBS.bill.core.vo.ResultVO;
import gnnt.MEBS.bill.core.vo.TransferGoodsVO;

public abstract interface ITradeService
{
  public abstract TransferGoodsVO performTransferGoods(int paramInt, String paramString1, String[] paramArrayOfString, String paramString2);
  
  public abstract ResultVO performRealeseGoods(int paramInt, String paramString);
  
  public abstract ResultVO performRealeseGoods(int paramInt, String paramString, String[] paramArrayOfString);
  
  public abstract ResultVO performStockChg(String[] paramArrayOfString, String paramString1, String paramString2);
  
  public abstract DeliveryVO performDelivery(int paramInt, String paramString1, String paramString2, String paramString3);
  
  public abstract DeliveryVO performDelivery(int paramInt, String paramString1, String[] paramArrayOfString, String paramString2, String paramString3);
  
  public abstract ResultVO performSellStock(int paramInt, String paramString1, String paramString2);
  
  public abstract ResultVO performWithdrawSellStock(int paramInt, String paramString);
  
  public abstract void checkStart();
  
  public abstract TransferGoodsVO performSellStockToDelivery(int paramInt, String paramString1, String paramString2, String paramString3);
  
  public abstract long getFinancingStockID();
  
  public abstract FinancingApplyVO performStartFinancing(String paramString, long paramLong);
  
  public abstract ResultVO performEndFinancing(long paramLong);
  
  public abstract ResultVO performRejectFinancing(long paramLong);
  
  public abstract ResultVO frozenStocks(int paramInt, String[] paramArrayOfString);
  
  public abstract ResultVO unFrozenStocks(int paramInt, String[] paramArrayOfString);
}
