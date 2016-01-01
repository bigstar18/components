package gnnt.MEBS.bill.core.po;

import java.io.Serializable;

public class GoodsPropertyPO
  extends Clone
  implements Serializable
{
  private static final long serialVersionUID = 623120016429374249L;
  private String stockID;
  private String propertyName;
  private String propertyValue;
  private long propertyTypeID;
  
  public String getStockID()
  {
    return this.stockID;
  }
  
  public void setStockID(String paramString)
  {
    this.stockID = paramString;
  }
  
  public String getPropertyName()
  {
    return this.propertyName;
  }
  
  public void setPropertyName(String paramString)
  {
    this.propertyName = paramString;
  }
  
  public String getPropertyValue()
  {
    return this.propertyValue;
  }
  
  public void setPropertyValue(String paramString)
  {
    this.propertyValue = paramString;
  }
  
  public long getPropertyTypeID()
  {
    return this.propertyTypeID;
  }
  
  public void setPropertyTypeID(long paramLong)
  {
    this.propertyTypeID = paramLong;
  }
  
  public String toString()
  {
    StringBuffer localStringBuffer = new StringBuffer();
    localStringBuffer.append("[W_GoodsPropertyPO:\n");
    localStringBuffer.append("[long |").append("stockID|").append(this.stockID).append("]\n");
    localStringBuffer.append("[String |").append("propertyName|").append(this.propertyName).append("]\n");
    localStringBuffer.append("[String |").append("propertyValue|").append(this.propertyValue).append("]\n");
    localStringBuffer.append("[long |").append("propertyTypeID|").append(this.propertyTypeID).append("]\n");
    localStringBuffer.append("]");
    return localStringBuffer.toString();
  }
}
