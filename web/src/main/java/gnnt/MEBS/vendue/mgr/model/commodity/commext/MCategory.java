package gnnt.MEBS.vendue.mgr.model.commodity.commext;

import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.model.StandardModel.PrimaryInfo;
import java.util.HashSet;
import java.util.Set;

public class MCategory
  extends StandardModel
{
  private static final long serialVersionUID = -468409492146240060L;
  private Long categoryid;
  private String categoryname;
  private String note;
  private String type;
  private Long sortno;
  private Long parentcategoryid;
  private Boolean status;
  private String isoffset;
  private Double offsetrate;
  private String belongmodule;
  private Set MProperties = new HashSet(0);
  private Set MBreeds = new HashSet(0);
  
  public MCategory() {}
  
  public MCategory(Long paramLong1, String paramString1, String paramString2, Long paramLong2, String paramString3, Double paramDouble)
  {
    this.categoryid = paramLong1;
    this.categoryname = paramString1;
    this.type = paramString2;
    this.sortno = paramLong2;
    this.isoffset = paramString3;
    this.offsetrate = paramDouble;
  }
  
  public MCategory(Long paramLong1, String paramString1, String paramString2, String paramString3, Long paramLong2, Long paramLong3, Boolean paramBoolean, String paramString4, Double paramDouble, String paramString5, Set paramSet1, Set paramSet2)
  {
    this.categoryid = paramLong1;
    this.categoryname = paramString1;
    this.note = paramString2;
    this.type = paramString3;
    this.sortno = paramLong2;
    this.parentcategoryid = paramLong3;
    this.status = paramBoolean;
    this.isoffset = paramString4;
    this.offsetrate = paramDouble;
    this.belongmodule = paramString5;
    this.MProperties = paramSet1;
    this.MBreeds = paramSet2;
  }
  
  public Long getCategoryid()
  {
    return this.categoryid;
  }
  
  public void setCategoryid(Long paramLong)
  {
    this.categoryid = paramLong;
  }
  
  public String getCategoryname()
  {
    return this.categoryname;
  }
  
  public void setCategoryname(String paramString)
  {
    this.categoryname = paramString;
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
  
  public Long getSortno()
  {
    return this.sortno;
  }
  
  public void setSortno(Long paramLong)
  {
    this.sortno = paramLong;
  }
  
  public Long getParentcategoryid()
  {
    return this.parentcategoryid;
  }
  
  public void setParentcategoryid(Long paramLong)
  {
    this.parentcategoryid = paramLong;
  }
  
  public Boolean getStatus()
  {
    return this.status;
  }
  
  public void setStatus(Boolean paramBoolean)
  {
    this.status = paramBoolean;
  }
  
  public String getIsoffset()
  {
    return this.isoffset;
  }
  
  public void setIsoffset(String paramString)
  {
    this.isoffset = paramString;
  }
  
  public Double getOffsetrate()
  {
    return this.offsetrate;
  }
  
  public void setOffsetrate(Double paramDouble)
  {
    this.offsetrate = paramDouble;
  }
  
  public String getBelongmodule()
  {
    return this.belongmodule;
  }
  
  public void setBelongmodule(String paramString)
  {
    this.belongmodule = paramString;
  }
  
  public Set getMProperties()
  {
    return this.MProperties;
  }
  
  public void setMProperties(Set paramSet)
  {
    this.MProperties = paramSet;
  }
  
  public Set getMBreeds()
  {
    return this.MBreeds;
  }
  
  public void setMBreeds(Set paramSet)
  {
    this.MBreeds = paramSet;
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return new StandardModel.PrimaryInfo("categoryid", this.categoryid);
  }
}
