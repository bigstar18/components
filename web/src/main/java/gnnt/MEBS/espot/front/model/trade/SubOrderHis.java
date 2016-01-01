package gnnt.MEBS.espot.front.model.trade;

import gnnt.MEBS.common.front.model.translate.ClassDiscription;

public class SubOrderHis
  extends SubOrderBase
{
  private static final long serialVersionUID = 5551479262589128419L;
  @ClassDiscription(name="委托号", description="")
  private OrderHis belongtoOrder;
  
  public OrderHis getBelongtoOrder()
  {
    return this.belongtoOrder;
  }
  
  public void setBelongtoOrder(OrderHis paramOrderHis)
  {
    this.belongtoOrder = paramOrderHis;
  }
}
