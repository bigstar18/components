package gnnt.MEBS.espot.front.model.trade;

import gnnt.MEBS.common.front.model.translate.ClassDiscription;

public class ReserveHis
  extends ReserveBase
{
  private static final long serialVersionUID = 4236326122092043217L;
  @ClassDiscription(name="关联合同", description="对应合同号")
  private TradeHis belongtoTrade;
  
  public TradeHis getBelongtoTrade()
  {
    return this.belongtoTrade;
  }
  
  public void setBelongtoTrade(TradeHis paramTradeHis)
  {
    this.belongtoTrade = paramTradeHis;
  }
}
