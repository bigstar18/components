package gnnt.MEBS.priceranking.server.model;

import java.io.Serializable;

public class ResultOrder
  implements Serializable
{
  private static final long serialVersionUID = 2110350811396169348L;
  private int ret;
  private Order order;
  
  public int getRet()
  {
    return this.ret;
  }
  
  public void setRet(int ret)
  {
    this.ret = ret;
  }
  
  public Order getOrder()
  {
    return this.order;
  }
  
  public void setOrder(Order order)
  {
    this.order = order;
  }
}
