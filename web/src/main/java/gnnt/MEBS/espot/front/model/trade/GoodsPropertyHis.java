package gnnt.MEBS.espot.front.model.trade;

import gnnt.MEBS.common.front.model.translate.ClassDiscription;

public class GoodsPropertyHis
  extends GoodsPropertyBase
{
  private static final long serialVersionUID = 3662942727805999645L;
  @ClassDiscription(name="所属委托", description="对应委托号")
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
