package gnnt.MEBS.espot.front.model.warehousestock;

import gnnt.MEBS.common.front.model.StandardModel;
import gnnt.MEBS.common.front.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.front.model.integrated.MFirm;
import gnnt.MEBS.common.front.model.translate.ClassDiscription;
import gnnt.MEBS.espot.front.model.commodity.Breed;
import java.util.Date;
import java.util.Set;

public class Stock
  extends StandardModel
{
  private static final long serialVersionUID = -4894220129122561840L;
  @ClassDiscription(name="仓单号", description="")
  private String stockID;
  @ClassDiscription(name="仓库仓单号", description="")
  private String realStockCode;
  @ClassDiscription(name="品名", description="对应品名ID")
  private Breed belongtoBreed;
  @ClassDiscription(name="仓库编号", description="")
  private String warehouseID;
  @ClassDiscription(name="商品数量", description="")
  private Double quantity;
  @ClassDiscription(name="商品单位", description="")
  private String unit;
  @ClassDiscription(name="仓单所属交易商", description="对应交易商代码")
  private MFirm belongtoFirm;
  @ClassDiscription(name="最后变更时间", description="")
  private Date lastTime;
  @ClassDiscription(name="创建时间", description="")
  private Date createTime;
  @ClassDiscription(name="仓单状态", description="仓单状态 0:未注册仓单  1：注册仓单  2：已出库仓单  3：已拆单 4：拆仓单处理中")
  private Integer status;
  @ClassDiscription(name="属性信息", description="")
  private Set<WareHouseGoodsProperty> containProperty;
  @ClassDiscription(name="仓单使用业务", description="")
  private Set<StockOperation> containOperation;
  @ClassDiscription(name="拆单数", description="")
  private int dismantleCount;
  
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
  
  public Breed getBelongtoBreed()
  {
    return this.belongtoBreed;
  }
  
  public void setBelongtoBreed(Breed paramBreed)
  {
    this.belongtoBreed = paramBreed;
  }
  
  public String getWarehouseID()
  {
    return this.warehouseID;
  }
  
  public void setWarehouseID(String paramString)
  {
    this.warehouseID = paramString;
  }
  
  public Double getQuantity()
  {
    return this.quantity;
  }
  
  public void setQuantity(Double paramDouble)
  {
    this.quantity = paramDouble;
  }
  
  public String getUnit()
  {
    return this.unit;
  }
  
  public void setUnit(String paramString)
  {
    this.unit = paramString;
  }
  
  public MFirm getBelongtoFirm()
  {
    return this.belongtoFirm;
  }
  
  public void setBelongtoFirm(MFirm paramMFirm)
  {
    this.belongtoFirm = paramMFirm;
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
  
  public Integer getStatus()
  {
    return this.status;
  }
  
  public void setStatus(Integer paramInteger)
  {
    this.status = paramInteger;
  }
  
  public Set<WareHouseGoodsProperty> getContainProperty()
  {
    return this.containProperty;
  }
  
  public void setContainProperty(Set<WareHouseGoodsProperty> paramSet)
  {
    this.containProperty = paramSet;
  }
  
  public Set<StockOperation> getContainOperation()
  {
    return this.containOperation;
  }
  
  public void setContainOperation(Set<StockOperation> paramSet)
  {
    this.containOperation = paramSet;
  }
  
  public int getDismantleCount()
  {
    return this.dismantleCount;
  }
  
  public void setDismantleCount(int paramInt)
  {
    this.dismantleCount = paramInt;
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return new StandardModel.PrimaryInfo("stockID", this.stockID);
  }
}
