package gnnt.MEBS.espot.front.model.trade;

import gnnt.MEBS.common.front.model.translate.ClassDiscription;

public class Holding
  extends HoldingBase
{
  private static final long serialVersionUID = 5825356498842704749L;
  @ClassDiscription(name="关联合同", description="对应合同号")
  private Trade belongtoTrade;
  
  public Trade getBelongtoTrade()
  {
    return this.belongtoTrade;
  }
  
  public void setBelongtoTrade(Trade paramTrade)
  {
    this.belongtoTrade = paramTrade;
  }
}
