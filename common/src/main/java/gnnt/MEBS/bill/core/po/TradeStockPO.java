package gnnt.MEBS.bill.core.po;

import gnnt.MEBS.bill.core.util.Tool;
import java.io.Serializable;
import java.util.Date;

public class TradeStockPO
  extends Clone
  implements Serializable
{
  private static final long serialVersionUID = 2268559476332236098L;
  private long tradestockID;
  private String stockID;
  private int moduleid;
  private String tradeNO;
  private Date createTime;
  private Date releaseTime;
  private long status;
  
  public long getTradestockID()
  {
    return this.tradestockID;
  }
  
  public String getStockID()
  {
    return this.stockID;
  }
  
  public void setStockID(String paramString)
  {
    this.stockID = paramString;
  }
  
  public int getModuleid()
  {
    return this.moduleid;
  }
  
  public void setModuleid(int paramInt)
  {
    this.moduleid = paramInt;
  }
  
  public String getTradeNO()
  {
    return this.tradeNO;
  }
  
  public void setTradeNO(String paramString)
  {
    this.tradeNO = paramString;
  }
  
  public Date getCreateTime()
  {
    return this.createTime;
  }
  
  public Date getReleaseTime()
  {
    return this.releaseTime;
  }
  
  public void setReleaseTime(Date paramDate)
  {
    this.releaseTime = paramDate;
  }
  
  public long getStatus()
  {
    return this.status;
  }
  
  public String getStatusMeaning()
  {
    String str = "";
    switch (Tool.strToInt(getStatus() + ""))
    {
    case 0: 
      str = "仓单使用中";
      break;
    case 1: 
      str = "交易成功仓单释放状态";
      break;
    }
    return str;
  }
  
  public void setStatus(long paramLong)
  {
    this.status = paramLong;
  }
  
  public String toString()
  {
    StringBuffer localStringBuffer = new StringBuffer();
    localStringBuffer.append("[W_TradeStockPO:\n");
    localStringBuffer.append("[Long |").append("tradestockID|").append(this.tradestockID).append("]\n");
    localStringBuffer.append("[String |").append("stockID|").append(this.stockID).append("]\n");
    localStringBuffer.append("[Long |").append("tradeNO|").append(this.tradeNO).append("]\n");
    localStringBuffer.append("[java.util.Date|").append("createTime|").append(this.createTime).append("]\n");
    localStringBuffer.append("[java.util.Date|").append("releaseTime|").append(this.releaseTime).append("]\n");
    localStringBuffer.append("[Long |").append("status|").append(this.status).append("]\n");
    localStringBuffer.append("]");
    return localStringBuffer.toString();
  }
}
