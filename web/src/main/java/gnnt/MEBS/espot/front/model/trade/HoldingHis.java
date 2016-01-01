package gnnt.MEBS.espot.front.model.trade;

import gnnt.MEBS.common.front.model.translate.ClassDiscription;

public class HoldingHis
  extends HoldingBase
{
  private static final long serialVersionUID = -2500189714836835164L;
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
