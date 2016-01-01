package gnnt.MEBS.espot.front.model.warehousestock;

import gnnt.MEBS.common.front.model.StandardModel;
import gnnt.MEBS.common.front.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.front.model.translate.ClassDiscription;

public class StockOperation
  extends StandardModel
{
  private static final long serialVersionUID = -4222269074254229744L;
  @ClassDiscription(name="所属仓单", description="对应仓单号")
  private Stock belongtoStock;
  @ClassDiscription(name="业务号", description="业务号 0：拆单 1：融资2：卖仓单 3：交收")
  private Integer operationID;
  
  public Stock getBelongtoStock()
  {
    return this.belongtoStock;
  }
  
  public void setBelongtoStock(Stock paramStock)
  {
    this.belongtoStock = paramStock;
  }
  
  public Integer getOperationID()
  {
    return this.operationID;
  }
  
  public void setOperationID(Integer paramInteger)
  {
    this.operationID = paramInteger;
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return null;
  }
}
