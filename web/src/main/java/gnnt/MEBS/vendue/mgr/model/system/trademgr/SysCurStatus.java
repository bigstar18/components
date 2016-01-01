package gnnt.MEBS.vendue.mgr.model.system.trademgr;

import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.mgr.model.translate.ClassDiscription;
import java.util.Date;

public class SysCurStatus
  extends StandardModel
{
  private static final long serialVersionUID = -8108104980174430994L;
  @ClassDiscription(name="交易板块", description="")
  private Integer tradePartition;
  @ClassDiscription(name="当前系统状态", description="当前系统状态  1：准备开市 2：交易中 3：节间休息 4：休市 5：闭市 6：流程结束状态")
  private Integer status;
  @ClassDiscription(name="当前交易节编号", description="当前交易节编号 对应不同的系统状态此项内容如下：准备开市：第一个交易节的编号（系统不一定从第一个交易节开始）;交易中：当前交易节的编号;节间休息：上一个交易节的编号;休市：上一个交易节的编号;闭市：0 ")
  private Integer section;
  @ClassDiscription(name="最新修改时间", description="")
  private Date modifyTime;
  @ClassDiscription(name="当前节开始时间", description="")
  private Date startTime;
  @ClassDiscription(name="当前节结束时间", description="")
  private Date endTime;
  @ClassDiscription(name="是否闭市处理", description="")
  private Integer isClose;
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return new StandardModel.PrimaryInfo("tradePartition", this.tradePartition);
  }
  
  public Integer getTradePartition()
  {
    return this.tradePartition;
  }
  
  public void setTradePartition(Integer paramInteger)
  {
    this.tradePartition = paramInteger;
  }
  
  public Integer getStatus()
  {
    return this.status;
  }
  
  public void setStatus(Integer paramInteger)
  {
    this.status = paramInteger;
  }
  
  public Integer getSection()
  {
    return this.section;
  }
  
  public void setSection(Integer paramInteger)
  {
    this.section = paramInteger;
  }
  
  public Date getModifyTime()
  {
    return this.modifyTime;
  }
  
  public void setModifyTime(Date paramDate)
  {
    this.modifyTime = paramDate;
  }
  
  public Date getStartTime()
  {
    return this.startTime;
  }
  
  public void setStartTime(Date paramDate)
  {
    this.startTime = paramDate;
  }
  
  public Date getEndTime()
  {
    return this.endTime;
  }
  
  public void setEndTime(Date paramDate)
  {
    this.endTime = paramDate;
  }
  
  public Integer getIsClose()
  {
    return this.isClose;
  }
  
  public void setIsClose(Integer paramInteger)
  {
    this.isClose = paramInteger;
  }
}
