package gnnt.MEBS.vendue.mgr.model.system.sysPartition;

import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.model.StandardModel.PrimaryInfo;

public class VTempletclassset
  extends StandardModel
{
  private static final long serialVersionUID = -5908295180340112637L;
  private Long id;
  private String class_;
  private Byte type;
  private String name;
  
  public VTempletclassset() {}
  
  public VTempletclassset(Long paramLong, String paramString1, Byte paramByte, String paramString2)
  {
    this.id = paramLong;
    this.class_ = paramString1;
    this.type = paramByte;
    this.name = paramString2;
  }
  
  public Long getId()
  {
    return this.id;
  }
  
  public void setId(Long paramLong)
  {
    this.id = paramLong;
  }
  
  public String getClass_()
  {
    return this.class_;
  }
  
  public void setClass_(String paramString)
  {
    this.class_ = paramString;
  }
  
  public Byte getType()
  {
    return this.type;
  }
  
  public void setType(Byte paramByte)
  {
    this.type = paramByte;
  }
  
  public String getName()
  {
    return this.name;
  }
  
  public void setName(String paramString)
  {
    this.name = paramString;
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return new StandardModel.PrimaryInfo("id", this.id);
  }
}
