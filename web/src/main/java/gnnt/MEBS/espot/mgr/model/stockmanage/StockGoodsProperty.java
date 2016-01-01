package gnnt.MEBS.espot.mgr.model.stockmanage;

import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.mgr.model.translate.ClassDiscription;

public class StockGoodsProperty
  extends StandardModel
{
  private static final long serialVersionUID = 1L;
  @ClassDiscription(name="所属的仓单", description="对应仓单号")
  private Stock stock;
  @ClassDiscription(name="商品属性名", description="")
  private String propertyName;
  @ClassDiscription(name="商品属性值", description="")
  private String propertyValue;
  @ClassDiscription(name="类型编号", description="")
  private Long propertyTypeID;
  
  public Stock getStock()
  {
    return this.stock;
  }
  
  public void setStock(Stock paramStock)
  {
    this.stock = paramStock;
  }
  
  public String getPropertyName()
  {
    return this.propertyName;
  }
  
  public void setPropertyName(String paramString)
  {
    this.propertyName = paramString;
  }
  
  public String getPropertyValue()
  {
    return this.propertyValue;
  }
  
  public void setPropertyValue(String paramString)
  {
    this.propertyValue = paramString;
  }
  
  public Long getPropertyTypeID()
  {
    return this.propertyTypeID;
  }
  
  public void setPropertyTypeID(Long paramLong)
  {
    this.propertyTypeID = paramLong;
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return null;
  }
}
