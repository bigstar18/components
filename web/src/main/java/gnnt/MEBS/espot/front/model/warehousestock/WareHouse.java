package gnnt.MEBS.espot.front.model.warehousestock;

import gnnt.MEBS.common.front.model.StandardModel;
import gnnt.MEBS.common.front.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.front.model.translate.ClassDiscription;

public class WareHouse
  extends StandardModel
{
  private static final long serialVersionUID = 2585445555069042208L;
  @ClassDiscription(name="编号", description="")
  private Long id;
  @ClassDiscription(name="仓库编号", description="")
  private String wareHouseID;
  @ClassDiscription(name="仓库名称", description="")
  private String wareHouseName;
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
  
  public String getWareHouseID()
  {
    return this.wareHouseID;
  }
  
  public void setWareHouseID(String paramString)
  {
    this.wareHouseID = paramString;
  }
  
  public String getWareHouseName()
  {
    return this.wareHouseName;
  }
  
  public void setWareHouseName(String paramString)
  {
    this.wareHouseName = paramString;
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
