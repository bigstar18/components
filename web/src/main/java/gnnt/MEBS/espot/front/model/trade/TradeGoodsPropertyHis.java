package gnnt.MEBS.espot.front.model.trade;

import gnnt.MEBS.common.front.model.translate.ClassDiscription;

public class TradeGoodsPropertyHis
  extends GoodsPropertyBase
{
  private static final long serialVersionUID = 3662942727805999645L;
  @ClassDiscription(name="所属合同", description="对应合同号")
  private TradeHis trade;
  
  public TradeHis getTrade()
  {
    return this.trade;
  }
  
  public void setTrade(TradeHis paramTradeHis)
  {
    this.trade = paramTradeHis;
  }
}
