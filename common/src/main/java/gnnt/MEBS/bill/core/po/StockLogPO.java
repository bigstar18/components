package gnnt.MEBS.bill.core.po;

import gnnt.MEBS.bill.core.util.Tool;
import java.io.Serializable;
import java.util.Date;

public class StockLogPO
  extends Clone
  implements Serializable
{
  private static final long serialVersionUID = -3512204580573753268L;
  private long id;
  private long operationID;
  private Date createTime;
  private String remark;
  private String stockID;
  
  public long getId()
  {
    return this.id;
  }
  
  public void setId(long paramLong)
  {
    this.id = paramLong;
  }
  
  public long getOperationID()
  {
    return this.operationID;
  }
  
  public String getOperationIDMeaning()
  {
    String str = "";
    switch (Tool.strToInt(getOperationID() + ""))
    {
    case 1: 
      str = "注册";
      break;
    case 2: 
      str = "解除注册";
      break;
    case 3: 
      str = "出库";
      break;
    case 4: 
      str = "参与交易";
      break;
    case 5: 
      str = "拆单";
      break;
    case 6: 
      str = "融资";
      break;
    }
    return str;
  }
  
  public void setOperationID(long paramLong)
  {
    this.operationID = paramLong;
  }
  
  public Date getCreateTime()
  {
    return this.createTime;
  }
  
  public void setCreateTime(Date paramDate)
  {
    this.createTime = paramDate;
  }
  
  public String getRemark()
  {
    return this.remark;
  }
  
  public void setRemark(String paramString)
  {
    this.remark = paramString;
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
    localStringBuffer.append("[W_StockLogPO:\n");
    localStringBuffer.append("[Long |").append("id|").append(this.id).append("]\n");
    localStringBuffer.append("[Long |").append("operationID|").append(this.operationID).append("]\n");
    localStringBuffer.append("[java.util.Date|").append("createTime|").append(this.createTime).append("]\n");
    localStringBuffer.append("[String |").append("remark|").append(this.remark).append("]\n");
    localStringBuffer.append("[String |").append("stockID|").append(this.stockID).append("]\n");
    localStringBuffer.append("]");
    return localStringBuffer.toString();
  }
}
