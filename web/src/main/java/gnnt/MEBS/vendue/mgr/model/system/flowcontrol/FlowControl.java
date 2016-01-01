package gnnt.MEBS.vendue.mgr.model.system.flowcontrol;

import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.mgr.model.translate.ClassDiscription;

public class FlowControl
  extends StandardModel
{
  private static final long serialVersionUID = 4911281049176863324L;
  @ClassDiscription(name="交易节主键", description="")
  private FlowcontrolId id;
  @ClassDiscription(name="品种ID", description="")
  private Long breedid;
  @ClassDiscription(name="交易节开始模式", description="")
  private Byte startmode;
  @ClassDiscription(name="交易节开始时间", description="")
  private String starttime;
  @ClassDiscription(name="持续时间", description="")
  private Integer durativetime;
  @ClassDiscription(name="倒计时时间", description="")
  private String countdownstart;
  @ClassDiscription(name="顺延时间", description="")
  private String countdowntime;
  @ClassDiscription(name="节间休息", description="")
  private Integer quartertime;
  @ClassDiscription(name="交易节强制结束时间", description="")
  private String forcedendtime;
  @ClassDiscription(name="是否启用无余量倒计时", description="是否启用无余量倒计0：不启用 1：启用")
  private Byte ismargincount;
  
  public FlowControl(FlowcontrolId paramFlowcontrolId)
  {
    this.id = paramFlowcontrolId;
  }
  
  public FlowcontrolId getId()
  {
    return this.id;
  }
  
  public void setId(FlowcontrolId paramFlowcontrolId)
  {
    this.id = paramFlowcontrolId;
  }
  
  public Long getBreedid()
  {
    return this.breedid;
  }
  
  public void setBreedid(Long paramLong)
  {
    this.breedid = paramLong;
  }
  
  public Byte getStartmode()
  {
    return this.startmode;
  }
  
  public void setStartmode(Byte paramByte)
  {
    this.startmode = paramByte;
  }
  
  public String getStarttime()
  {
    return this.starttime;
  }
  
  public void setStarttime(String paramString)
  {
    this.starttime = paramString;
  }
  
  public Integer getDurativetime()
  {
    return this.durativetime;
  }
  
  public void setDurativetime(Integer paramInteger)
  {
    this.durativetime = paramInteger;
  }
  
  public String getCountdownstart()
  {
    return this.countdownstart;
  }
  
  public void setCountdownstart(String paramString)
  {
    this.countdownstart = paramString;
  }
  
  public String getCountdowntime()
  {
    return this.countdowntime;
  }
  
  public void setCountdowntime(String paramString)
  {
    this.countdowntime = paramString;
  }
  
  public Integer getQuartertime()
  {
    return this.quartertime;
  }
  
  public void setQuartertime(Integer paramInteger)
  {
    this.quartertime = paramInteger;
  }
  
  public String getForcedendtime()
  {
    return this.forcedendtime;
  }
  
  public void setForcedendtime(String paramString)
  {
    this.forcedendtime = paramString;
  }
  
  public Byte getIsmargincount()
  {
    return this.ismargincount;
  }
  
  public void setIsmargincount(Byte paramByte)
  {
    this.ismargincount = paramByte;
  }
  
  public FlowControl() {}
  
  public String toString()
  {
    return "FlowControl [breedid=" + this.breedid + ", countdownstart=" + this.countdownstart + ", countdowntime=" + this.countdowntime + ", durativetime=" + this.durativetime + ", forcedendtime=" + this.forcedendtime + ", id=" + this.id.toString() + ", ismargincount=" + this.ismargincount + ", quartertime=" + this.quartertime + ", startmode=" + this.startmode + ", starttime=" + this.starttime + "]";
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return new StandardModel.PrimaryInfo("id", this.id);
  }
}
