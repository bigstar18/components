package gnnt.MEBS.vendue.mgr.model.system.sysPartition;

import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.mgr.model.translate.ClassDiscription;

public class VTrademodeparams
  extends StandardModel
{
  private static final long serialVersionUID = -8436466284903800477L;
  @ClassDiscription(name="交易模式ID", description="")
  private Long id;
  @ClassDiscription(name="交易模式名称", description="")
  private String name;
  
  public VTrademodeparams() {}
  
  public VTrademodeparams(Long paramLong, String paramString)
  {
    this.id = paramLong;
    this.name = paramString;
  }
  
  public Long getId()
  {
    return this.id;
  }
  
  public void setId(Long paramLong)
  {
    this.id = paramLong;
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
