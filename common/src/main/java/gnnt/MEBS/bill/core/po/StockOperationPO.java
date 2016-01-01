package gnnt.MEBS.bill.core.po;

import java.io.Serializable;

public class StockOperationPO
  extends Clone
  implements Serializable
{
  private static final long serialVersionUID = 167262291082320389L;
  private String stockID;
  private int operationID;
  
  public String getStockID()
  {
    return this.stockID;
  }
  
  public void setStockID(String paramString)
  {
    this.stockID = paramString;
  }
  
  public int getOperationID()
  {
    return this.operationID;
  }
  
  public void setOperationID(int paramInt)
  {
    this.operationID = paramInt;
  }
  
  public String toString()
  {
    StringBuffer localStringBuffer = new StringBuffer();
    localStringBuffer.append("[W_StockOperation:\n");
    localStringBuffer.append("[String |").append("stockID|").append(this.stockID).append("]\n");
    localStringBuffer.append("[Long |").append("operationID|").append(this.operationID).append("]\n");
    localStringBuffer.append("]");
    return localStringBuffer.toString();
  }
}
