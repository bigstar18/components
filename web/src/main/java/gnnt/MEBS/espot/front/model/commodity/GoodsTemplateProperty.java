package gnnt.MEBS.espot.front.model.commodity;

import gnnt.MEBS.common.front.model.StandardModel;
import gnnt.MEBS.common.front.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.front.model.translate.ClassDiscription;

public class GoodsTemplateProperty
  extends StandardModel
{
  private static final long serialVersionUID = -3996680539246007489L;
  @ClassDiscription(name="属性名称", description="")
  private String propertyName;
  @ClassDiscription(name="所属模板", description="")
  private GoodsTemplate template;
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
  
  public GoodsTemplate getTemplate()
  {
    return this.template;
  }
  
  public void setTemplate(GoodsTemplate paramGoodsTemplate)
  {
    this.template = paramGoodsTemplate;
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
