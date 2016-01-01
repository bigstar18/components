package gnnt.MEBS.vendue.front.model;

import java.util.List;

public class BreedProperty
{
  private Long propertyid;
  private String propertyname;
  private String hasvaluedict;
  private String isnecessary;
  private Byte fieldtype;
  private List values;
  
  public List getValues()
  {
    return this.values;
  }
  
  public void setValues(List paramList)
  {
    this.values = paramList;
  }
  
  public Long getPropertyid()
  {
    return this.propertyid;
  }
  
  public void setPropertyid(Long paramLong)
  {
    this.propertyid = paramLong;
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
}
