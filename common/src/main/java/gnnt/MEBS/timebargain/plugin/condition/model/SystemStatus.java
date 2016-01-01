package gnnt.MEBS.timebargain.plugin.condition.model;

import java.util.Date;

public class SystemStatus
{
  private Date tradeDate;
  private Integer status;
  
  public Date getTradeDate()
  {
    return this.tradeDate;
  }
  
  public void setTradeDate(Date tradeDate)
  {
    this.tradeDate = tradeDate;
  }
  
  public Integer getStatus()
  {
    return this.status;
  }
  
  public void setStatus(Integer status)
  {
    this.status = status;
  }
  
  public boolean equals(Object obj)
  {
    return (obj != null) && ((obj instanceof SystemStatus)) && (this.status != null) && (this.status.equals(((SystemStatus)obj).getStatus())) && (this.tradeDate != null) && (this.tradeDate.equals(((SystemStatus)obj).getTradeDate()));
  }
}
