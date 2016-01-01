package gnnt.MEBS.bill.core.po;

import java.io.Serializable;
import java.util.Date;

public class StockChgLogPO
  extends Clone
  implements Serializable
{
  private static final long serialVersionUID = 4125074715401501824L;
  private String id;
  private String stockID;
  private String srcFirm;
  private String tarFirm;
  private Date createTime;
  
  public String getID()
  {
    return this.id;
  }
  
  public void setID(String paramString)
  {
    this.id = paramString;
  }
  
  public String getStockID()
  {
    return this.stockID;
  }
  
  public void setStockID(String paramString)
  {
    this.stockID = paramString;
  }
  
  public String getSrcFirm()
  {
    return this.srcFirm;
  }
  
  public void setSrcFirm(String paramString)
  {
    this.srcFirm = paramString;
  }
  
  public String getTarFirm()
  {
    return this.tarFirm;
  }
  
  public void setTarFirm(String paramString)
  {
    this.tarFirm = paramString;
  }
  
  public Date getcreateTime()
  {
    return this.createTime;
  }
  
  public void setcreateTime(Date paramDate)
  {
    this.createTime = paramDate;
  }
  
  public String toString()
  {
    StringBuffer localStringBuffer = new StringBuffer();
    localStringBuffer.append("[W_StockChgLogPO:\n");
    localStringBuffer.append("[String |").append("id|").append(this.id).append("]\n");
    localStringBuffer.append("[String |").append("stockID|").append(this.stockID).append("]\n");
    localStringBuffer.append("[String |").append("srcFirm|").append(this.srcFirm).append("]\n");
    localStringBuffer.append("[String |").append("tarFirm|").append(this.tarFirm).append("]\n");
    localStringBuffer.append("[java.util.Date|").append("createTime|").append(this.createTime).append("]\n");
    localStringBuffer.append("]");
    return localStringBuffer.toString();
  }
}
