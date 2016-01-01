package gnnt.MEBS.vendue.mgr.model.commodity.commext;

import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.model.StandardModel.PrimaryInfo;

public class VCommext
  extends StandardModel
{
  private static final long serialVersionUID = 3811245625605983797L;
  private Long id;
  private String code;
  private Long attributeid;
  private String attribute;
  private String value;
  
  public VCommext() {}
  
  public VCommext(Long paramLong1, String paramString1, Long paramLong2, String paramString2, String paramString3)
  {
    this.id = paramLong1;
    this.code = paramString1;
    this.attributeid = paramLong2;
    this.attribute = paramString2;
    this.value = paramString3;
  }
  
  public Long getId()
  {
    return this.id;
  }
  
  public void setId(Long paramLong)
  {
    this.id = paramLong;
  }
  
  public String getCode()
  {
    return this.code;
  }
  
  public void setCode(String paramString)
  {
    this.code = paramString;
  }
  
  public Long getAttributeid()
  {
    return this.attributeid;
  }
  
  public void setAttributeid(Long paramLong)
  {
    this.attributeid = paramLong;
  }
  
  public String getAttribute()
  {
    return this.attribute;
  }
  
  public void setAttribute(String paramString)
  {
    this.attribute = paramString;
  }
  
  public String getValue()
  {
    return this.value;
  }
  
  public void setValue(String paramString)
  {
    this.value = paramString;
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return new StandardModel.PrimaryInfo("id", this.id);
  }
}
