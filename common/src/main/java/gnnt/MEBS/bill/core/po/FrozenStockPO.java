package gnnt.MEBS.bill.core.po;

import java.io.Serializable;
import java.util.Date;

public class FrozenStockPO
  extends Clone
  implements Serializable
{
  private static final long serialVersionUID = 5977107191707281657L;
  private long frozenStockID;
  private String stockID;
  private int moduleID;
  private int status;
  private Date createTime;
  private Date releaseTime;
  
  public long getFrozenStockID()
  {
    return this.frozenStockID;
  }
  
  public void setFrozenStockID(long paramLong)
  {
    this.frozenStockID = paramLong;
  }
  
  public String getStockID()
  {
    return this.stockID;
  }
  
  public void setStockID(String paramString)
  {
    this.stockID = paramString;
  }
  
  public int getModuleID()
  {
    return this.moduleID;
  }
  
  public void setModuleID(int paramInt)
  {
    this.moduleID = paramInt;
  }
  
  public int getStatus()
  {
    return this.status;
  }
  
  public void setStatus(int paramInt)
  {
    this.status = paramInt;
  }
  
  public Date getCreateTime()
  {
    return this.createTime;
  }
  
  public void setCreateTime(Date paramDate)
  {
    this.createTime = paramDate;
  }
  
  public Date getReleaseTime()
  {
    return this.releaseTime;
  }
  
  public void setReleaseTime(Date paramDate)
  {
    this.releaseTime = paramDate;
  }
}
