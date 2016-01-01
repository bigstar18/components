package gnnt.MEBS.espot.front.model.trade;

import gnnt.MEBS.common.front.model.translate.ClassDiscription;

public class GoodsProperty
  extends GoodsPropertyBase
{
  private static final long serialVersionUID = 8185059694024913916L;
  @ClassDiscription(name="所属委托", description="对应委托号")
  private Order belongtoOrder;
  
  public Order getBelongtoOrder()
  {
    return this.belongtoOrder;
  }
  
  public void setBelongtoOrder(Order paramOrder)
  {
    this.belongtoOrder = paramOrder;
  }
}
