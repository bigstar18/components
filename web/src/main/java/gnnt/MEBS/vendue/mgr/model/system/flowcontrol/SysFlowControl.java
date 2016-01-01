package gnnt.MEBS.vendue.mgr.model.system.flowcontrol;

import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.mgr.model.translate.ClassDiscription;

public class SysFlowControl
  extends StandardModel
{
  private static final long serialVersionUID = 5967113691265896912L;
  @ClassDiscription(name="板块编号", description="")
  private Short tradePartition;
  @ClassDiscription(name="交易节默认持续时间", description="")
  private Integer durativeTime;
  @ClassDiscription(name="节间休息时间", description="")
  private Integer spaceTime;
  @ClassDiscription(name="倒计时时间", description="")
  private String countdownStart;
  @ClassDiscription(name="倒计时顺延时间", description="")
  private String countdownTime;
  @ClassDiscription(name="品种ID", description="")
  private Integer breedId;
  
  public SysFlowControl() {}
  
  public SysFlowControl(Short paramShort)
  {
    this.tradePartition = paramShort;
  }
  
  public Short getTradePartition()
  {
    return this.tradePartition;
  }
  
  public void setTradePartition(Short paramShort)
  {
    this.tradePartition = paramShort;
  }
  
  public Integer getDurativeTime()
  {
    return this.durativeTime;
  }
  
  public void setDurativeTime(Integer paramInteger)
  {
    this.durativeTime = paramInteger;
  }
  
  public Integer getSpaceTime()
  {
    return this.spaceTime;
  }
  
  public void setSpaceTime(Integer paramInteger)
  {
    this.spaceTime = paramInteger;
  }
  
  public String getCountdownStart()
  {
    return this.countdownStart;
  }
  
  public void setCountdownStart(String paramString)
  {
    this.countdownStart = paramString;
  }
  
  public String getCountdownTime()
  {
    return this.countdownTime;
  }
  
  public void setCountdownTime(String paramString)
  {
    this.countdownTime = paramString;
  }
  
  public Integer getBreedId()
  {
    return this.breedId;
  }
  
  public void setBreedId(Integer paramInteger)
  {
    this.breedId = paramInteger;
  }
  
  public String toString()
  {
    return "SysFlowControl [breedId=" + this.breedId + ", countdownStart=" + this.countdownStart + ", countdownTime=" + this.countdownTime + ", durativeTime=" + this.durativeTime + ", spaceTime=" + this.spaceTime + ", tradePartition=" + this.tradePartition + "]";
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return new StandardModel.PrimaryInfo("tradePartition", this.tradePartition);
  }
}
