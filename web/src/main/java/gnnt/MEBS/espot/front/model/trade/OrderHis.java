package gnnt.MEBS.espot.front.model.trade;

import gnnt.MEBS.common.front.model.translate.ClassDiscription;
import java.util.HashSet;
import java.util.Set;

public class OrderHis
  extends OrderBase
{
  private static final long serialVersionUID = -2709866672062886771L;
  @ClassDiscription(name="商品属性", description="")
  private Set<GoodsPropertyHis> containGoodsProperty;
  @ClassDiscription(name="委托议价", description="")
  private Set<SubOrderHis> containSubOrder;
  
  public Set<GoodsPropertyHis> getContainGoodsProperty()
  {
    return this.containGoodsProperty;
  }
  
  public void setContainGoodsProperty(Set<GoodsPropertyHis> paramSet)
  {
    this.containGoodsProperty = paramSet;
  }
  
  public Set<SubOrderHis> getContainSubOrder()
  {
    return this.containSubOrder;
  }
  
  public void setContainSubOrder(Set<SubOrderHis> paramSet)
  {
    this.containSubOrder = paramSet;
  }
  
  public void addGoodsProperty(GoodsPropertyHis paramGoodsPropertyHis)
  {
    if (this.containGoodsProperty == null) {
      synchronized (this)
      {
        if (this.containGoodsProperty == null) {
          this.containGoodsProperty = new HashSet();
        }
      }
    }
    this.containGoodsProperty.add(paramGoodsPropertyHis);
  }
}
