package gnnt.MEBS.espot.front.model.commodity;

import gnnt.MEBS.common.front.model.StandardModel;
import gnnt.MEBS.common.front.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.front.model.translate.ClassDiscription;
import java.util.Set;

public class Category
  extends StandardModel
{
  private static final long serialVersionUID = 8694234228879505665L;
  @ClassDiscription(name="商品分类ID", description="")
  private Long categoryID;
  @ClassDiscription(name="商品分类名称", description="")
  private String categoryName;
  @ClassDiscription(name="商品分类说明", description="")
  private String note;
  @ClassDiscription(name="类型", description="类型：(leaf 叶子节点 category 中间件节点)")
  private String type;
  @ClassDiscription(name="排序号", description="")
  private Long sortNo;
  @ClassDiscription(name="父商品分类号", description="")
  private Category parentCategory;
  @ClassDiscription(name="状态", description="状态    1：正常 2：已删除")
  private Integer status;
  @ClassDiscription(name="是否允许溢短货款申请", description="是否允许溢短货款申请 Y:可申请溢短货款 N:不可申请溢短货款")
  private String isOffset;
  @ClassDiscription(name="所属模块", description="")
  private String belongModule;
  @ClassDiscription(name="最大溢短货款申请比率", description="")
  private Double offsetRate;
  @ClassDiscription(name="子商品分类号", description="")
  private Set<Category> childCategory;
  @ClassDiscription(name="包含商品", description="")
  private Set<Breed> containBreed;
  @ClassDiscription(name="包含属性", description="")
  private Set<Property> containProperty;
  
  public Long getCategoryID()
  {
    return this.categoryID;
  }
  
  public void setCategoryID(Long paramLong)
  {
    this.categoryID = paramLong;
  }
  
  public String getCategoryName()
  {
    return this.categoryName;
  }
  
  public void setCategoryName(String paramString)
  {
    this.categoryName = paramString;
  }
  
  public String getNote()
  {
    return this.note;
  }
  
  public void setNote(String paramString)
  {
    this.note = paramString;
  }
  
  public String getType()
  {
    return this.type;
  }
  
  public void setType(String paramString)
  {
    this.type = paramString;
  }
  
  public Long getSortNo()
  {
    return this.sortNo;
  }
  
  public void setSortNo(Long paramLong)
  {
    this.sortNo = paramLong;
  }
  
  public Category getParentCategory()
  {
    return this.parentCategory;
  }
  
  public void setParentCategory(Category paramCategory)
  {
    this.parentCategory = paramCategory;
  }
  
  public Integer getStatus()
  {
    return this.status;
  }
  
  public void setStatus(Integer paramInteger)
  {
    this.status = paramInteger;
  }
  
  public String getIsOffset()
  {
    return this.isOffset;
  }
  
  public void setIsOffset(String paramString)
  {
    this.isOffset = paramString;
  }
  
  public Double getOffsetRate()
  {
    return this.offsetRate;
  }
  
  public void setOffsetRate(Double paramDouble)
  {
    this.offsetRate = paramDouble;
  }
  
  public String getBelongModule()
  {
    return this.belongModule;
  }
  
  public void setBelongModule(String paramString)
  {
    this.belongModule = paramString;
  }
  
  public Set<Category> getChildCategory()
  {
    return this.childCategory;
  }
  
  public void setChildCategory(Set<Category> paramSet)
  {
    this.childCategory = paramSet;
  }
  
  public Set<Breed> getContainBreed()
  {
    return this.containBreed;
  }
  
  public void setContainBreed(Set<Breed> paramSet)
  {
    this.containBreed = paramSet;
  }
  
  public Set<Property> getContainProperty()
  {
    return this.containProperty;
  }
  
  public void setContainProperty(Set<Property> paramSet)
  {
    this.containProperty = paramSet;
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return new StandardModel.PrimaryInfo("categoryID", this.categoryID);
  }
}
