package gnnt.MEBS.common.front.model;

import gnnt.MEBS.common.front.model.translate.ClassDiscription;
import java.util.Date;

public class OperateLogBase
  extends StandardModel
{
  private static final long serialVersionUID = 8416138017634995277L;
  @ClassDiscription(name="编号", description="")
  private Long id;
  @ClassDiscription(name="操作员", description="")
  private String operator;
  @ClassDiscription(name="操作时间", description="")
  private Date operateTime;
  @ClassDiscription(name="对应的日志类别", description="")
  private LogCatalog logCatalog;
  @ClassDiscription(name="操作IP", description="")
  private String operateIP;
  @ClassDiscription(name="操作人种类", description="")
  private String operatorType;
  @ClassDiscription(name="标示", description="")
  private String mark;
  @ClassDiscription(name="操作内容", description="")
  private String operateContent;
  @ClassDiscription(name="当前值", description="")
  private String currentValue;
  @ClassDiscription(name="操作结果", description="操作结果 1：成功 0：失败")
  private Integer operateResult;
  @ClassDiscription(name="日志类型", description="日志类型 0： 其他、1 ：后台、2 ：前台、3： 核心")
  private Integer logType;
  
  public Long getId()
  {
    return this.id;
  }
  
  public void setId(Long id)
  {
    this.id = id;
  }
  
  public String getOperator()
  {
    return this.operator;
  }
  
  public void setOperator(String operator)
  {
    this.operator = operator;
  }
  
  public Date getOperateTime()
  {
    return this.operateTime;
  }
  
  public void setOperateTime(Date operateTime)
  {
    this.operateTime = operateTime;
  }
  
  public LogCatalog getLogCatalog()
  {
    return this.logCatalog;
  }
  
  public void setLogCatalog(LogCatalog logCatalog)
  {
    this.logCatalog = logCatalog;
  }
  
  public String getOperateIP()
  {
    return this.operateIP;
  }
  
  public void setOperateIP(String operateIP)
  {
    this.operateIP = operateIP;
  }
  
  public String getOperatorType()
  {
    return this.operatorType;
  }
  
  public void setOperatorType(String operatorType)
  {
    this.operatorType = operatorType;
  }
  
  public String getMark()
  {
    return this.mark;
  }
  
  public void setMark(String mark)
  {
    this.mark = mark;
  }
  
  public String getOperateContent()
  {
    return this.operateContent;
  }
  
  public void setOperateContent(String operateContent)
  {
    this.operateContent = operateContent;
  }
  
  public String getCurrentValue()
  {
    return this.currentValue;
  }
  
  public void setCurrentValue(String currentValue)
  {
    this.currentValue = currentValue;
  }
  
  public Integer getOperateResult()
  {
    return this.operateResult;
  }
  
  public void setOperateResult(Integer operateResult)
  {
    this.operateResult = operateResult;
  }
  
  public Integer getLogType()
  {
    return this.logType;
  }
  
  public void setLogType(Integer logType)
  {
    this.logType = logType;
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return new StandardModel.PrimaryInfo(  "id", this.id);
  }
}
