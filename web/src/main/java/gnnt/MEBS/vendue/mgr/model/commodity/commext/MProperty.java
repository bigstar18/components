package gnnt.MEBS.vendue.mgr.model.commodity.commext;

import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.model.StandardModel.PrimaryInfo;
import java.util.HashSet;
import java.util.Set;

public class MProperty
  extends StandardModel
{
  private static final long serialVersionUID = -9167111668068191963L;
  private Long propertyid;
  private MCategory MCategory;
  private String propertyname;
  private String hasvaluedict;
  private String stockcheck;
  private String searchable;
  private Long sortno;
  private String isnecessary;
  private Byte fieldtype;
  private Set MBreedpropses = new HashSet(0);
  
  public MProperty() {}
  
  public MProperty(Long paramLong1, MCategory paramMCategory, String paramString1, String paramString2, String paramString3, String paramString4, Long paramLong2, String paramString5, Byte paramByte)
  {
    this.propertyid = paramLong1;
    this.MCategory = paramMCategory;
    this.propertyname = paramString1;
    this.hasvaluedict = paramString2;
    this.stockcheck = paramString3;
    this.searchable = paramString4;
    this.sortno = paramLong2;
    this.isnecessary = paramString5;
    this.fieldtype = paramByte;
  }
  
  public MProperty(Long paramLong1, MCategory paramMCategory, String paramString1, String paramString2, String paramString3, String paramString4, Long paramLong2, String paramString5, Byte paramByte, Set paramSet)
  {
    this.propertyid = paramLong1;
    this.MCategory = paramMCategory;
    this.propertyname = paramString1;
    this.hasvaluedict = paramString2;
    this.stockcheck = paramString3;
    this.searchable = paramString4;
    this.sortno = paramLong2;
    this.isnecessary = paramString5;
    this.fieldtype = paramByte;
    this.MBreedpropses = paramSet;
  }
  
  public Long getPropertyid()
  {
    return this.propertyid;
  }
  
  public void setPropertyid(Long paramLong)
  {
    this.propertyid = paramLong;
  }
  
  public MCategory getMCategory()
  {
    return this.MCategory;
  }
  
  public void setMCategory(MCategory paramMCategory)
  {
    this.MCategory = paramMCategory;
  }
  
  public String getPropertyname()
  {
    return this.propertyname;
  }
  
  public void setPropertyname(String paramString)
  {
    this.propertyname = paramString;
  }
  
  public String getHasvaluedict()
  {
    return this.hasvaluedict;
  }
  
  public void setHasvaluedict(String paramString)
  {
    this.hasvaluedict = paramString;
  }
  
  public String getStockcheck()
  {
    return this.stockcheck;
  }
  
  public void setStockcheck(String paramString)
  {
    this.stockcheck = paramString;
  }
  
  public String getSearchable()
  {
    return this.searchable;
  }
  
  public void setSearchable(String paramString)
  {
    this.searchable = paramString;
  }
  
  public Long getSortno()
  {
    return this.sortno;
  }
  
  public void setSortno(Long paramLong)
  {
    this.sortno = paramLong;
  }
  
  public String getIsnecessary()
  {
    return this.isnecessary;
  }
  
  public void setIsnecessary(String paramString)
  {
    this.isnecessary = paramString;
  }
  
  public Byte getFieldtype()
  {
    return this.fieldtype;
  }
  
  public void setFieldtype(Byte paramByte)
  {
    this.fieldtype = paramByte;
  }
  
  public Set getMBreedpropses()
  {
    return this.MBreedpropses;
  }
  
  public void setMBreedpropses(Set paramSet)
  {
    this.MBreedpropses = paramSet;
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return new StandardModel.PrimaryInfo("propertyid", this.propertyid);
  }
}
