package gnnt.MEBS.vendue.mgr.model.commodity.commext;

import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.model.StandardModel.PrimaryInfo;
import java.util.HashSet;
import java.util.Set;

public class MBreed
  extends StandardModel
{
  private static final long serialVersionUID = 4707251808465595299L;
  private Long breedid;
  private MCategory MCategory;
  private String breedname;
  private String unit;
  private Boolean trademode;
  private Boolean status;
  private String picture;
  private String belongmodule;
  private Long sortno;
  private Set MBreedpropses = new HashSet(0);
  
  public MBreed() {}
  
  public MBreed(Long paramLong, MCategory paramMCategory, String paramString1, String paramString2, Boolean paramBoolean)
  {
    this.breedid = paramLong;
    this.MCategory = paramMCategory;
    this.breedname = paramString1;
    this.unit = paramString2;
    this.trademode = paramBoolean;
  }
  
  public MBreed(Long paramLong1, MCategory paramMCategory, String paramString1, String paramString2, Boolean paramBoolean1, Boolean paramBoolean2, String paramString3, String paramString4, Long paramLong2, Set paramSet)
  {
    this.breedid = paramLong1;
    this.MCategory = paramMCategory;
    this.breedname = paramString1;
    this.unit = paramString2;
    this.trademode = paramBoolean1;
    this.status = paramBoolean2;
    this.picture = paramString3;
    this.belongmodule = paramString4;
    this.sortno = paramLong2;
    this.MBreedpropses = paramSet;
  }
  
  public Long getBreedid()
  {
    return this.breedid;
  }
  
  public void setBreedid(Long paramLong)
  {
    this.breedid = paramLong;
  }
  
  public MCategory getMCategory()
  {
    return this.MCategory;
  }
  
  public void setMCategory(MCategory paramMCategory)
  {
    this.MCategory = paramMCategory;
  }
  
  public String getBreedname()
  {
    return this.breedname;
  }
  
  public void setBreedname(String paramString)
  {
    this.breedname = paramString;
  }
  
  public String getUnit()
  {
    return this.unit;
  }
  
  public void setUnit(String paramString)
  {
    this.unit = paramString;
  }
  
  public Boolean getTrademode()
  {
    return this.trademode;
  }
  
  public void setTrademode(Boolean paramBoolean)
  {
    this.trademode = paramBoolean;
  }
  
  public Boolean getStatus()
  {
    return this.status;
  }
  
  public void setStatus(Boolean paramBoolean)
  {
    this.status = paramBoolean;
  }
  
  public String getPicture()
  {
    return this.picture;
  }
  
  public void setPicture(String paramString)
  {
    this.picture = paramString;
  }
  
  public String getBelongmodule()
  {
    return this.belongmodule;
  }
  
  public void setBelongmodule(String paramString)
  {
    this.belongmodule = paramString;
  }
  
  public Long getSortno()
  {
    return this.sortno;
  }
  
  public void setSortno(Long paramLong)
  {
    this.sortno = paramLong;
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
    return new StandardModel.PrimaryInfo("breedid", this.breedid);
  }
}
