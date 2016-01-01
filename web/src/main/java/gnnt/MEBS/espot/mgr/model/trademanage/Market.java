package gnnt.MEBS.espot.mgr.model.trademanage;

import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.mgr.model.translate.ClassDiscription;

public class Market
  extends StandardModel
{
  private static final long serialVersionUID = -2484654344527584910L;
  @ClassDiscription(name="市场名称", description="")
  private String marketName;
  @ClassDiscription(name="运行模式", description="运行模式 A：自动开市 M：手动开市")
  private Character runMode;
  @ClassDiscription(name="状态", description="状态 1：交易状态 2：交易暂停状态 3：闭市状态")
  private Integer status;
  @ClassDiscription(name="暂停指定恢复时间", description="")
  private String recoverTime;
  
  public String getMarketName()
  {
    return this.marketName;
  }
  
  public void setMarketName(String paramString)
  {
    this.marketName = paramString;
  }
  
  public Character getRunMode()
  {
    return this.runMode;
  }
  
  public void setRunMode(Character paramCharacter)
  {
    this.runMode = paramCharacter;
  }
  
  public Integer getStatus()
  {
    return this.status;
  }
  
  public void setStatus(Integer paramInteger)
  {
    this.status = paramInteger;
  }
  
  public String getRecoverTime()
  {
    return this.recoverTime;
  }
  
  public void setRecoverTime(String paramString)
  {
    this.recoverTime = paramString;
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return new StandardModel.PrimaryInfo("marketName", this.marketName);
  }
}
