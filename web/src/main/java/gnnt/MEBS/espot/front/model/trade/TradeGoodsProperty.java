package gnnt.MEBS.espot.front.model.trade;

import gnnt.MEBS.common.front.model.translate.ClassDiscription;

public class TradeGoodsProperty
  extends GoodsPropertyBase
{
  private static final long serialVersionUID = 8185059694024913916L;
  @ClassDiscription(name="所属合同", description="对应合同号")
  private Trade trade;
  
  public Trade getTrade()
  {
    return this.trade;
  }
  
  public void setTrade(Trade paramTrade)
  {
    this.trade = paramTrade;
  }
}
