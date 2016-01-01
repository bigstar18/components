package gnnt.MEBS.espot.mgr.model.trademanage;

import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.mgr.model.translate.ClassDiscription;

public class TradeTime
  extends StandardModel
{
  private static final long serialVersionUID = 9183738541894012718L;
  @ClassDiscription(name="交易节ID", description="")
  private Long id;
  @ClassDiscription(name="每周非交易时间", description="星期日：1，星期一：2，星期二：3，星期三：4，星期四：5，星期五：6，星期六：7")
  private String restWeekday;
  @ClassDiscription(name="指定非交易日", description="日期之间以逗号分割")
  private String holiday;
  @ClassDiscription(name="交易开始时间", description="")
  private String tradeStartTime;
  @ClassDiscription(name="交易结束时间", description="")
  private String tradeEndTime;
  
  public Long getId()
  {
    return this.id;
  }
  
  public void setId(Long paramLong)
  {
    this.id = paramLong;
  }
  
  public String getRestWeekday()
  {
    return this.restWeekday;
  }
  
  public void setRestWeekday(String paramString)
  {
    this.restWeekday = paramString;
  }
  
  public String getHoliday()
  {
    return this.holiday;
  }
  
  public void setHoliday(String paramString)
  {
    this.holiday = paramString;
  }
  
  public String getTradeStartTime()
  {
    return this.tradeStartTime;
  }
  
  public void setTradeStartTime(String paramString)
  {
    this.tradeStartTime = paramString;
  }
  
  public String getTradeEndTime()
  {
    return this.tradeEndTime;
  }
  
  public void setTradeEndTime(String paramString)
  {
    this.tradeEndTime = paramString;
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return new StandardModel.PrimaryInfo("id", this.id);
  }
}
