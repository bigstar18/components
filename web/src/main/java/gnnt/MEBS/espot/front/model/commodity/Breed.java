package gnnt.MEBS.espot.front.model.commodity;

import gnnt.MEBS.common.front.model.StandardModel;
import gnnt.MEBS.common.front.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.front.model.translate.ClassDiscription;
import java.util.Set;

public class Breed
  extends StandardModel
{
  private static final long serialVersionUID = -1472062461799896422L;
  @ClassDiscription(name="品名ID", description="")
  private Long breedID;
  @ClassDiscription(name="品名", description="")
  private String breedName;
  @ClassDiscription(name="单位", description="")
  private String unit;
  @ClassDiscription(name="所属商品分类", description="对应商品分类号")
  private Category belongtoCategory;
  @ClassDiscription(name="交易模式", description="交易模式   1：诚信保障金模式 2：保证金模式")
  private Integer tradeMode;
  @ClassDiscription(name="状态", description="状态    1：正常 2：已删除")
  private Integer status;
  @ClassDiscription(name="所属模块", description="")
  private String belongModule;
  @ClassDiscription(name="排序号", description="")
  private Integer sortNo;
  @ClassDiscription(name="所有属性值", description="")
  private Set<BreedProps> containBreedProps;
  @ClassDiscription(name="图片", description="")
  private byte[] picture;
  
  public Long getBreedID()
  {
    return this.breedID;
  }
  
  public void setBreedID(Long paramLong)
  {
    this.breedID = paramLong;
  }
  
  public String getBreedName()
  {
    return this.breedName;
  }
  
  public void setBreedName(String paramString)
  {
    this.breedName = paramString;
  }
  
  public String getUnit()
  {
    return this.unit;
  }
  
  public void setUnit(String paramString)
  {
    this.unit = paramString;
  }
  
  public Category getBelongtoCategory()
  {
    return this.belongtoCategory;
  }
  
  public Integer getTradeMode()
  {
    return this.tradeMode;
  }
  
  public void setTradeMode(Integer paramInteger)
  {
    this.tradeMode = paramInteger;
  }
  
  public Integer getStatus()
  {
    return this.status;
  }
  
  public void setStatus(Integer paramInteger)
  {
    this.status = paramInteger;
  }
  
  public void setBelongtoCategory(Category paramCategory)
  {
    this.belongtoCategory = paramCategory;
  }
  
  public Set<BreedProps> getContainBreedProps()
  {
    return this.containBreedProps;
  }
  
  public void setContainBreedProps(Set<BreedProps> paramSet)
  {
    this.containBreedProps = paramSet;
  }
  
  public byte[] getPicture()
  {
    return this.picture;
  }
  
  public void setPicture(byte[] paramArrayOfByte)
  {
    this.picture = paramArrayOfByte;
  }
  
  public String getBelongModule()
  {
    return this.belongModule;
  }
  
  public void setBelongModule(String paramString)
  {
    this.belongModule = paramString;
  }
  
  public Integer getSortNo()
  {
    return this.sortNo;
  }
  
  public void setSortNo(Integer paramInteger)
  {
    this.sortNo = paramInteger;
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return new StandardModel.PrimaryInfo("breedID", this.breedID);
  }
}
