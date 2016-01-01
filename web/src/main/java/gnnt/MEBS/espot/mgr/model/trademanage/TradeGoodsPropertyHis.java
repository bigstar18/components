package gnnt.MEBS.espot.mgr.model.trademanage;

import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.mgr.model.translate.ClassDiscription;

public class TradeGoodsPropertyHis
  extends StandardModel
{
  private static final long serialVersionUID = -570616859827151621L;
  @ClassDiscription(name="商品属性名称", description="")
  private String propertyName;
  @ClassDiscription(name="关联合同", description="对应合同号")
  private TradeContractHis tradeContract;
  @ClassDiscription(name="商品属性值", description="")
  private String propertyValue;
  @ClassDiscription(name="类型编号", description="")
  private Long propertyTypeID;
  
  public String getPropertyName()
  {
    return this.propertyName;
  }
  
  public void setPropertyName(String paramString)
  {
    this.propertyName = paramString;
  }
  
  public TradeContractHis getTradeContract()
  {
    return this.tradeContract;
  }
  
  public void setTradeContract(TradeContractHis paramTradeContractHis)
  {
    this.tradeContract = paramTradeContractHis;
  }
  
  public String getPropertyValue()
  {
    return this.propertyValue;
  }
  
  public void setPropertyValue(String paramString)
  {
    this.propertyValue = paramString;
  }
  
  public Long getPropertyTypeID()
  {
    return this.propertyTypeID;
  }
  
  public void setPropertyTypeID(Long paramLong)
  {
    this.propertyTypeID = paramLong;
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return null;
  }
}
