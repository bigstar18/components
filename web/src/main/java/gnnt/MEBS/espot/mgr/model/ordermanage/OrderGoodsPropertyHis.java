package gnnt.MEBS.espot.mgr.model.ordermanage;

import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.mgr.model.translate.ClassDiscription;

public class OrderGoodsPropertyHis
  extends StandardModel
{
  private static final long serialVersionUID = -570616859827151621L;
  @ClassDiscription(name="商品属性名称", description="")
  private String propertyName;
  @ClassDiscription(name="关联委托", description="对应委托号")
  private OrderHis order;
  @ClassDiscription(name="商品属性值", description="")
  private String propertyValue;
  @ClassDiscription(name="类型编号", description="")
  private Long propertyTypeID;
  
  public String getPropertyName()
  {
    return this.propertyName;
  }
  
  public void setPropertyName(String paramString)
  {
    this.propertyName = paramString;
  }
  
  public OrderHis getOrder()
  {
    return this.order;
  }
  
  public void setOrder(OrderHis paramOrderHis)
  {
    this.order = paramOrderHis;
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
