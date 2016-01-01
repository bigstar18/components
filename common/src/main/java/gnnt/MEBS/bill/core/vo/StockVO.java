package gnnt.MEBS.bill.core.vo;

import gnnt.MEBS.bill.core.po.GoodsPropertyPO;
import gnnt.MEBS.bill.core.po.StockPO;
import java.util.ArrayList;
import java.util.List;

public class StockVO
  extends ResultVO
{
  private static final long serialVersionUID = -5589801656519651429L;
  private StockPO stock;
  private List<GoodsPropertyPO> stockPropertys;
  
  public StockPO getStock()
  {
    return this.stock;
  }
  
  public void setStock(StockPO paramStockPO)
  {
    this.stock = paramStockPO;
  }
  
  public List<GoodsPropertyPO> getStockPropertys()
  {
    return this.stockPropertys;
  }
  
  public void setStockPropertys(List<GoodsPropertyPO> paramList)
  {
    this.stockPropertys = paramList;
  }
  
  public void addStockProperty(GoodsPropertyPO paramGoodsPropertyPO)
  {
    if (this.stockPropertys == null) {
      synchronized (this)
      {
        if (this.stockPropertys == null) {
          this.stockPropertys = new ArrayList();
        }
      }
    }
    this.stockPropertys.add(paramGoodsPropertyPO);
  }
}
