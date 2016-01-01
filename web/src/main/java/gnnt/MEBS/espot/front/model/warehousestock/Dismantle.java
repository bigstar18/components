package gnnt.MEBS.espot.front.model.warehousestock;

import gnnt.MEBS.common.front.model.StandardModel;
import gnnt.MEBS.common.front.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.front.model.translate.ClassDiscription;
import java.util.Date;

public class Dismantle
  extends StandardModel
{
  private static final long serialVersionUID = -4838831648408471486L;
  @ClassDiscription(name="拆单表编号", description="")
  private Long dismantleID;
  @ClassDiscription(name="关联仓单", description="对应仓单号")
  private Stock belongtoStock;
  @ClassDiscription(name="新仓单号", description="")
  private Long newStockID;
  @ClassDiscription(name="新仓库仓单号", description="")
  private String realStockCode;
  @ClassDiscription(name="数量", description="")
  private Double amount;
  @ClassDiscription(name="申请时间", description="")
  private Date applyTime;
  @ClassDiscription(name="处理时间", description="")
  private Date processTime;
  @ClassDiscription(name="状态", description="状态 0：申请中 1：拆单成功 2：拆单失败")
  private String status;
  
  public Long getDismantleID()
  {
    return this.dismantleID;
  }
  
  public void setDismantleID(Long paramLong)
  {
    this.dismantleID = paramLong;
  }
  
  public Stock getBelongtoStock()
  {
    return this.belongtoStock;
  }
  
  public void setBelongtoStock(Stock paramStock)
  {
    this.belongtoStock = paramStock;
  }
  
  public Long getNewStockID()
  {
    return this.newStockID;
  }
  
  public void setNewStockID(Long paramLong)
  {
    this.newStockID = paramLong;
  }
  
  public String getRealStockCode()
  {
    return this.realStockCode;
  }
  
  public void setRealStockCode(String paramString)
  {
    this.realStockCode = paramString;
  }
  
  public Double getAmount()
  {
    return this.amount;
  }
  
  public void setAmount(Double paramDouble)
  {
    this.amount = paramDouble;
  }
  
  public Date getApplyTime()
  {
    return this.applyTime;
  }
  
  public void setApplyTime(Date paramDate)
  {
    this.applyTime = paramDate;
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
  
  public void setStatus(String paramString)
  {
    this.status = paramString;
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return new StandardModel.PrimaryInfo("dismantleID", this.dismantleID);
  }
}
