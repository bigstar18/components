package gnnt.MEBS.espot.front.model.trade;

import gnnt.MEBS.common.front.model.translate.ClassDiscription;
import java.util.Map;
import java.util.Set;

public class TradeHis
  extends TradeBase
{
  private static final long serialVersionUID = 6368337255162937149L;
  @ClassDiscription(name="合同对应商品属性", description="")
  private Set<TradeGoodsPropertyHis> tradeGoodsPropertys;
  @ClassDiscription(name="订单表", description="")
  private Set<ReserveHis> containReserve;
  @ClassDiscription(name="持仓表", description="")
  private Set<HoldingHis> containHolding;
  @ClassDiscription(name="合同的操作按钮权限", description="")
  private Map<String, Boolean> buttonMap;
  
  public Map<String, Boolean> getButtonMap()
  {
    return this.buttonMap;
  }
  
  public void setButtonMap(Map<String, Boolean> paramMap)
  {
    this.buttonMap = paramMap;
  }
  
  public Set<TradeGoodsPropertyHis> getTradeGoodsPropertys()
  {
    return this.tradeGoodsPropertys;
  }
  
  public void setTradeGoodsPropertys(Set<TradeGoodsPropertyHis> paramSet)
  {
    this.tradeGoodsPropertys = paramSet;
  }
  
  public Set<ReserveHis> getContainReserve()
  {
    return this.containReserve;
  }
  
  public void setContainReserve(Set<ReserveHis> paramSet)
  {
    this.containReserve = paramSet;
  }
  
  public Set<HoldingHis> getContainHolding()
  {
    return this.containHolding;
  }
  
  public void setContainHolding(Set<HoldingHis> paramSet)
  {
    this.containHolding = paramSet;
  }
}
