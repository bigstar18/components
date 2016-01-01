package gnnt.MEBS.bill.core.po;

import gnnt.MEBS.bill.core.util.Tool;
import java.io.Serializable;
import java.util.Date;

public class DismantlePO
  extends Clone
  implements Serializable
{
  private static final long serialVersionUID = 639299049429913317L;
  private long dismantleID;
  private String realStockCode;
  private double amount;
  private String newstockID;
  private Date askTime;
  private Date processTime;
  private String status;
  private String stockID;
  
  public long getDismantleID()
  {
    return this.dismantleID;
  }
  
  public void setDismantleID(long paramLong)
  {
    this.dismantleID = paramLong;
  }
  
  public String getRealStockCode()
  {
    return this.realStockCode;
  }
  
  public void setRealStockCode(String paramString)
  {
    this.realStockCode = paramString;
  }
  
  public double getAmount()
  {
    return this.amount;
  }
  
  public void setAmount(double paramDouble)
  {
    this.amount = paramDouble;
  }
  
  public String getNewstockID()
  {
    return this.newstockID;
  }
  
  public void setNewstockID(String paramString)
  {
    this.newstockID = paramString;
  }
  
  public Date getAskTime()
  {
    return this.askTime;
  }
  
  public void setAskTime(Date paramDate)
  {
    this.askTime = paramDate;
  }
  
  public Date getProcessTime()
  {
    return this.processTime;
  }
  
  public void setProcessTime(Date paramDate)
  {
    this.processTime = paramDate;
  }
  
  public String getStatus()
  {
    return this.status;
  }
  
  public String getStatusMeaning()
  {
    String str = "";
    switch (Tool.strToInt(getStatus() + ""))
    {
    case 0: 
      str = "申请中";
      break;
    case 1: 
      str = "拆单成功";
      break;
    case 2: 
      str = "拆单失败";
      break;
    }
    return str;
  }
  
  public void setStatus(String paramString)
  {
    this.status = paramString;
  }
  
  public String getStockID()
  {
    return this.stockID;
  }
  
  public void setStockID(String paramString)
  {
    this.stockID = paramString;
  }
  
  public String toString()
  {
    StringBuffer localStringBuffer = new StringBuffer();
    localStringBuffer.append("[W_DismantlePO:\n");
    localStringBuffer.append("[Long |").append("dismantleID|").append(this.dismantleID).append("]\n");
    localStringBuffer.append("[Long |").append("amount|").append(this.amount).append("]\n");
    localStringBuffer.append("[Long |").append("newstockID|").append(this.newstockID).append("]\n");
    localStringBuffer.append("[java.util.Date|").append("askTime|").append(this.askTime).append("]\n");
    localStringBuffer.append("[java.util.Date|").append("processTime|").append(this.processTime).append("]\n");
    localStringBuffer.append("[String |").append("status|").append(this.status).append("]\n");
    localStringBuffer.append("[String |").append("stockID|").append(this.stockID).append("]\n");
    localStringBuffer.append("]");
    return localStringBuffer.toString();
  }
}
