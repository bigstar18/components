package gnnt.MEBS.vendue.mgr.model.system.flowcontrol;

import gnnt.MEBS.common.mgr.model.translate.ClassDiscription;
import java.io.Serializable;

public class FlowcontrolId
  implements Serializable
{
  private static final long serialVersionUID = -3528303833863166769L;
  @ClassDiscription(name="交易板块", description="")
  private Short tradepartition;
  @ClassDiscription(name="流程单元类型", description="")
  private Byte unittype;
  @ClassDiscription(name="流程单元编号", description="")
  private Integer unitid;
  
  public FlowcontrolId() {}
  
  public FlowcontrolId(Short paramShort, Byte paramByte, Integer paramInteger)
  {
    this.tradepartition = paramShort;
    this.unittype = paramByte;
    this.unitid = paramInteger;
  }
  
  public Short getTradepartition()
  {
    return this.tradepartition;
  }
  
  public void setTradepartition(Short paramShort)
  {
    this.tradepartition = paramShort;
  }
  
  public Byte getUnittype()
  {
    return this.unittype;
  }
  
  public void setUnittype(Byte paramByte)
  {
    this.unittype = paramByte;
  }
  
  public Integer getUnitid()
  {
    return this.unitid;
  }
  
  public void setUnitid(Integer paramInteger)
  {
    this.unitid = paramInteger;
  }
  
  public String toString()
  {
    return "FlowcontrolId [tradepartition=" + this.tradepartition + ", unitid=" + this.unitid + ", unittype=" + this.unittype + "]";
  }
}
