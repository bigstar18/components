package gnnt.MEBS.common.broker.model;

import java.util.Date;

public class OperateLogBase
  extends StandardModel
{
  private static final long serialVersionUID = 2313125464095942060L;
  private Long id;
  private String operator;
  private Date operateTime;
  private String operateIp;
  private String operatorType;
  private String mark;
  private String operateContent;
  private String currentValue;
  private Integer operateResult;
  private LogCatalog logCatalog;
  
  public Long getId()
  {
    return this.id;
  }
  
  public void setId(long id)
  {
    this.id = Long.valueOf(id);
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
  
  public String getOperateIp()
  {
    return this.operateIp;
  }
  
  public void setOperateIp(String operateIp)
  {
    this.operateIp = operateIp;
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
  
  public LogCatalog getLogCatalog()
  {
    return this.logCatalog;
  }
  
  public void setLogCatalog(LogCatalog logCatalog)
  {
    this.logCatalog = logCatalog;
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return new StandardModel.PrimaryInfo(  "id", this.id);
  }
}
