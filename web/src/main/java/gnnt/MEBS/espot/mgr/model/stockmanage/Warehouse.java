package gnnt.MEBS.espot.mgr.model.stockmanage;

import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.mgr.model.translate.ClassDiscription;

public class Warehouse
  extends StandardModel
{
  private static final long serialVersionUID = -5013524004976711064L;
  @ClassDiscription(name="主键编号", description="")
  private Long id;
  @ClassDiscription(name="仓库编号", description="")
  private String warehouseId;
  @ClassDiscription(name="仓库名称", description="")
  private String warehouseName;
  @ClassDiscription(name="仓库状态", description="0 可用 1 不可用")
  private Integer status;
  
  public Long getId()
  {
    return this.id;
  }
  
  public void setId(Long paramLong)
  {
    this.id = paramLong;
  }
  
  public String getWarehouseId()
  {
    return this.warehouseId;
  }
  
  public void setWarehouseId(String paramString)
  {
    this.warehouseId = paramString;
  }
  
  public String getWarehouseName()
  {
    return this.warehouseName;
  }
  
  public void setWarehouseName(String paramString)
  {
    this.warehouseName = paramString;
  }
  
  public Integer getStatus()
  {
    return this.status;
  }
  
  public void setStatus(Integer paramInteger)
  {
    this.status = paramInteger;
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return new StandardModel.PrimaryInfo("id", this.id);
  }
}
