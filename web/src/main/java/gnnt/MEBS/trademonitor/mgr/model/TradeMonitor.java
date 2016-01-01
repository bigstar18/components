package gnnt.MEBS.trademonitor.mgr.model;

import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.model.StandardModel.PrimaryInfo;
import java.util.Date;

public class TradeMonitor
  extends StandardModel
{
  private static final long serialVersionUID = -4617052754380957266L;
  private Long id;
  private Integer moduleId;
  private String type;
  private Double num;
  private Date dateTime;
  private String categoryType;
  
  public Long getId()
  {
    return this.id;
  }
  
  public void setId(Long paramLong)
  {
    this.id = paramLong;
  }
  
  public Integer getModuleId()
  {
    return this.moduleId;
  }
  
  public void setModuleId(Integer paramInteger)
  {
    this.moduleId = paramInteger;
  }
  
  public String getType()
  {
    return this.type;
  }
  
  public void setType(String paramString)
  {
    this.type = paramString;
  }
  
  public Double getNum()
  {
    return this.num;
  }
  
  public void setNum(Double paramDouble)
  {
    this.num = paramDouble;
  }
  
  public Date getDateTime()
  {
    return this.dateTime;
  }
  
  public void setDateTime(Date paramDate)
  {
    this.dateTime = paramDate;
  }
  
  public String getCategoryType()
  {
    return this.categoryType;
  }
  
  public void setCategoryType(String paramString)
  {
    this.categoryType = paramString;
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return new StandardModel.PrimaryInfo(this, "id", this.id);
  }
}
