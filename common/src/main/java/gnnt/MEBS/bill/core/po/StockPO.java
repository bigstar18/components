package gnnt.MEBS.bill.core.po;

import gnnt.MEBS.bill.core.util.Tool;
import java.io.Serializable;
import java.util.Date;

public class StockPO
  extends Clone
  implements Serializable
{
  private static final long serialVersionUID = 5520958349945920541L;
  private String stockID;
  private String realStockCode;
  private long breedID;
  private String warehouseID;
  private double quantity;
  private String unit;
  private String ownerFirm;
  private Date lastTime;
  private Date createTime;
  private int stockStatus;
  
  public String getStockID()
  {
    return this.stockID;
  }
  
  public void setStockID(String paramString)
  {
    this.stockID = paramString;
  }
  
  public String getRealStockCode()
  {
    return this.realStockCode;
  }
  
  public void setRealStockCode(String paramString)
  {
    this.realStockCode = paramString;
  }
  
  public long getBreedID()
  {
    return this.breedID;
  }
  
  public void setBreedID(long paramLong)
  {
    this.breedID = paramLong;
  }
  
  public String getWarehouseID()
  {
    return this.warehouseID;
  }
  
  public void setWarehouseID(String paramString)
  {
    this.warehouseID = paramString;
  }
  
  public double getQuantity()
  {
    return this.quantity;
  }
  
  public void setQuantity(double paramDouble)
  {
    this.quantity = paramDouble;
  }
  
  public String getOwnerFirm()
  {
    return this.ownerFirm;
  }
  
  public void setOwnerFirm(String paramString)
  {
    this.ownerFirm = paramString;
  }
  
  public Date getLastTime()
  {
    return this.lastTime;
  }
  
  public void setLastTime(Date paramDate)
  {
    this.lastTime = paramDate;
  }
  
  public Date getCreateTime()
  {
    return this.createTime;
  }
  
  public void setCreateTime(Date paramDate)
  {
    this.createTime = paramDate;
  }
  
  public int getStockStatus()
  {
    return this.stockStatus;
  }
  
  public String getStockStatusMeaning()
  {
    String str = "";
    switch (Tool.strToInt(getStockStatus() + ""))
    {
    case 0: 
      str = "未注册仓单";
      break;
    case 1: 
      str = "注册仓单";
      break;
    case 2: 
      str = "已出库仓单";
      break;
    case 3: 
      str = "已拆仓单";
      break;
    case 4: 
      str = "拆单处理中";
      break;
    case 5: 
      str = "出库申请中";
      break;
    }
    return str;
  }
  
  public void setStockStatus(int paramInt)
  {
    this.stockStatus = paramInt;
  }
  
  public String getUnit()
  {
    return this.unit;
  }
  
  public void setUnit(String paramString)
  {
    this.unit = paramString;
  }
  
  public String toString()
  {
    StringBuffer localStringBuffer = new StringBuffer();
    localStringBuffer.append("[StockPO:\n");
    localStringBuffer.append("[String |").append("stockID|").append(this.stockID).append("]\n");
    localStringBuffer.append("[Long |").append("breedID|").append(this.breedID).append("]\n");
    localStringBuffer.append("[Long |").append("warehouseID|").append(this.warehouseID).append("]\n");
    localStringBuffer.append("[Long |").append("quantity|").append(this.quantity).append("]\n");
    localStringBuffer.append("[String |").append("ownerFirm|").append(this.ownerFirm).append("]\n");
    localStringBuffer.append("[java.util.Date|").append("lastTime|").append(this.lastTime).append("]\n");
    localStringBuffer.append("[java.util.Date|").append("createTime|").append(this.createTime).append("]\n");
    localStringBuffer.append("[int |").append("stockStatus|").append(this.stockStatus).append("]\n");
    localStringBuffer.append("]");
    return localStringBuffer.toString();
  }
}
