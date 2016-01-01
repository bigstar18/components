package gnnt.MEBS.bill.core.po;

import java.io.Serializable;
import java.util.Date;

public class FinancingStockPO
  extends Clone
  implements Serializable
{
  private static final long serialVersionUID = 3670139568181159690L;
  private long financingstockID;
  private String stockID;
  private Date createTime;
  private Date releaseTime;
  private String status;
  
  public long getFinancingstockID()
  {
    return this.financingstockID;
  }
  
  public void setFinancingstockID(long paramLong)
  {
    this.financingstockID = paramLong;
  }
  
  public String getStockID()
  {
    return this.stockID;
  }
  
  public void setStockID(String paramString)
  {
    this.stockID = paramString;
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
  
  public String getStatus()
  {
    return this.status;
  }
  
  public String getStatusMeaning()
  {
    String str = "";
    if ("Y".equals(getStatus())) {
      str = "有效";
    } else if ("N".equals(getStatus())) {
      str = "无效";
    }
    return str;
  }
  
  public void setStatus(String paramString)
  {
    this.status = paramString;
  }
  
  public String toString()
  {
    StringBuffer localStringBuffer = new StringBuffer();
    localStringBuffer.append("[W_FinancingStockPO:\n");
    localStringBuffer.append("[Long |").append("financingstockID|").append(this.financingstockID).append("]\n");
    localStringBuffer.append("[String |").append("stockID|").append(this.stockID).append("]\n");
    localStringBuffer.append("[java.util.Date|").append("createTime|").append(this.createTime).append("]\n");
    localStringBuffer.append("[java.util.Date|").append("releaseTime|").append(this.releaseTime).append("]\n");
    localStringBuffer.append("[String |").append("status|").append(this.status).append("]\n");
    localStringBuffer.append("]");
    return localStringBuffer.toString();
  }
}
