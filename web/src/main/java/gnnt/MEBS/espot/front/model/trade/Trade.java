package gnnt.MEBS.espot.front.model.trade;

import gnnt.MEBS.common.front.model.translate.ClassDiscription;
import java.util.Map;
import java.util.Set;

public class Trade
  extends TradeBase
{
  private static final long serialVersionUID = 6368337255162937149L;
  @ClassDiscription(name="合同对应商品属性", description="")
  private Set<TradeGoodsProperty> tradeGoodsPropertys;
  @ClassDiscription(name="订单表", description="")
  private Set<Reserve> containReserve;
  @ClassDiscription(name="持仓表", description="")
  private Set<Holding> containHolding;
  @ClassDiscription(name="合同的操作按钮权限", description="")
  private Map<String, Boolean> buttonMap;
  
  public Set<TradeGoodsProperty> getTradeGoodsPropertys()
  {
    return this.tradeGoodsPropertys;
  }
  
  public void setTradeGoodsPropertys(Set<TradeGoodsProperty> paramSet)
  {
    this.tradeGoodsPropertys = paramSet;
  }
  
  public Map<String, Boolean> getButtonMap()
  {
    return this.buttonMap;
  }
  
  public void setButtonMap(Map<String, Boolean> paramMap)
  {
    this.buttonMap = paramMap;
  }
  
  public Set<Reserve> getContainReserve()
  {
    return this.containReserve;
  }
  
  public void setContainReserve(Set<Reserve> paramSet)
  {
    this.containReserve = paramSet;
  }
  
  public Set<Holding> getContainHolding()
  {
    return this.containHolding;
  }
  
  public void setContainHolding(Set<Holding> paramSet)
  {
    this.containHolding = paramSet;
  }
}
