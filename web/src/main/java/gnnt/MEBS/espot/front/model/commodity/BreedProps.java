package gnnt.MEBS.espot.front.model.commodity;

import gnnt.MEBS.common.front.model.StandardModel;
import gnnt.MEBS.common.front.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.front.model.translate.ClassDiscription;

public class BreedProps
  extends StandardModel
{
  private static final long serialVersionUID = -6939402859566132646L;
  @ClassDiscription(name="品名", description="商品属性所对应的品名")
  private Breed belongtoBreed;
  @ClassDiscription(name="商品属性", description="")
  private Property belongtoProperty;
  @ClassDiscription(name="商品属性值", description="")
  private String propertyValue;
  @ClassDiscription(name="排序号", description="")
  private Long sortNo;
  
  public Long getSortNo()
  {
    return this.sortNo;
  }
  
  public void setSortNo(Long paramLong)
  {
    this.sortNo = paramLong;
  }
  
  public Breed getBelongtoBreed()
  {
    return this.belongtoBreed;
  }
  
  public void setBelongtoBreed(Breed paramBreed)
  {
    this.belongtoBreed = paramBreed;
  }
  
  public Property getBelongtoProperty()
  {
    return this.belongtoProperty;
  }
  
  public void setBelongtoProperty(Property paramProperty)
  {
    this.belongtoProperty = paramProperty;
  }
  
  public String getPropertyValue()
  {
    return this.propertyValue;
  }
  
  public void setPropertyValue(String paramString)
  {
    this.propertyValue = paramString;
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return null;
  }
}
