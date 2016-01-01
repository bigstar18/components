package gnnt.MEBS.priceranking.server.model;

import java.io.Serializable;
import java.util.Map;

public class CommodityQuotation
  implements Serializable
{
  private static final long serialVersionUID = 2110350811396169348L;
  private Map<String, CommodityOrder> commodityOrderMap;
  private long count;
  
  public Map<String, CommodityOrder> getCommodityOrderMap()
  {
    return this.commodityOrderMap;
  }
  
  public void setCommodityOrderMap(Map<String, CommodityOrder> commodityOrderMap)
  {
    this.commodityOrderMap = commodityOrderMap;
  }
  
  public long getCount()
  {
    return this.count;
  }
  
  public void setCount(long count)
  {
    this.count = count;
  }
}
