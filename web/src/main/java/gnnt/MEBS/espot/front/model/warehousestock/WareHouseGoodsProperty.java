package gnnt.MEBS.espot.front.model.warehousestock;

import gnnt.MEBS.common.front.model.StandardModel;
import gnnt.MEBS.common.front.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.front.model.translate.ClassDiscription;

public class WareHouseGoodsProperty
  extends StandardModel
{
  private static final long serialVersionUID = -8935243406545684872L;
  @ClassDiscription(name="所属仓单", description="对应仓单号")
  private Stock belongtoStock;
  @ClassDiscription(name="商品属性名", description="")
  private String propertyName;
  @ClassDiscription(name="商品属性值", description="")
  private String propertyValue;
  @ClassDiscription(name="类型编号", description="")
  private Long propertyTypeID;
  
  public Stock getBelongtoStock()
  {
    return this.belongtoStock;
  }
  
  public void setBelongtoStock(Stock paramStock)
  {
    this.belongtoStock = paramStock;
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
