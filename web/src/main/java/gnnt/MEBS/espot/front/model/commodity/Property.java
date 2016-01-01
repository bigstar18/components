package gnnt.MEBS.espot.front.model.commodity;

import gnnt.MEBS.common.front.model.StandardModel;
import gnnt.MEBS.common.front.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.front.model.translate.ClassDiscription;
import java.util.Set;

public class Property
  extends StandardModel
{
  private static final long serialVersionUID = -6520965211009349083L;
  @ClassDiscription(name="商品属性ID", description="")
  private Long propertyID;
  @ClassDiscription(name="商品分类", description="")
  private Category belongtoCategory;
  @ClassDiscription(name="属性名称", description="")
  private String propertyName;
  @ClassDiscription(name="是否有字典值", description="是否有字典值 Y：有值字典  N：无值字典")
  private String hasValueDict;
  @ClassDiscription(name="是否用于匹配仓单时检查", description="是否用于匹配仓单时检查 Y：检查  N：不检查")
  private String stockCheck;
  @ClassDiscription(name="是否用于检索", description="是否用于检索 Y：用于列表搜索 N：不用于搜索")
  private String searchable;
  @ClassDiscription(name="排序号", description="")
  private Long sortNo;
  @ClassDiscription(name="所有商品属性值", description="")
  private Set<BreedProps> containBreedProps;
  @ClassDiscription(name="是不是必填项", description="是不是必填项 Y：必填 N：选填")
  private String isNecessary;
  @ClassDiscription(name="支持输入的格式 ", description="支持输入的格式 0:字符串  1：数字")
  private Integer fieldType;
  @ClassDiscription(name="类型编号", description="")
  private Long propertyTypeID;
  
  public String getIsNecessary()
  {
    return this.isNecessary;
  }
  
  public void setIsNecessary(String paramString)
  {
    this.isNecessary = paramString;
  }
  
  public Integer getFieldType()
  {
    return this.fieldType;
  }
  
  public void setFieldType(Integer paramInteger)
  {
    this.fieldType = paramInteger;
  }
  
  public Long getPropertyID()
  {
    return this.propertyID;
  }
  
  public void setPropertyID(Long paramLong)
  {
    this.propertyID = paramLong;
  }
  
  public Category getBelongtoCategory()
  {
    return this.belongtoCategory;
  }
  
  public void setBelongtoCategory(Category paramCategory)
  {
    this.belongtoCategory = paramCategory;
  }
  
  public String getPropertyName()
  {
    return this.propertyName;
  }
  
  public void setPropertyName(String paramString)
  {
    this.propertyName = paramString;
  }
  
  public String getHasValueDict()
  {
    return this.hasValueDict;
  }
  
  public void setHasValueDict(String paramString)
  {
    this.hasValueDict = paramString;
  }
  
  public String getStockCheck()
  {
    return this.stockCheck;
  }
  
  public void setStockCheck(String paramString)
  {
    this.stockCheck = paramString;
  }
  
  public String getSearchable()
  {
    return this.searchable;
  }
  
  public void setSearchable(String paramString)
  {
    this.searchable = paramString;
  }
  
  public Long getSortNo()
  {
    return this.sortNo;
  }
  
  public void setSortNo(Long paramLong)
  {
    this.sortNo = paramLong;
  }
  
  public Set<BreedProps> getContainBreedProps()
  {
    return this.containBreedProps;
  }
  
  public void setContainBreedProps(Set<BreedProps> paramSet)
  {
    this.containBreedProps = paramSet;
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
    return new StandardModel.PrimaryInfo("propertyID", this.propertyID);
  }
}
