package gnnt.MEBS.vendue.front.manager;

import gnnt.MEBS.vendue.front.model.BreedProperty;
import gnnt.MEBS.vendue.front.model.Commodityparams;
import gnnt.MEBS.vendue.front.service.TradeService;
import java.util.List;

public class BreedPropertyManager
{
  TradeService tradeService = null;
  
  public List<BreedProperty> getBreedProperty(String paramString)
  {
    return this.tradeService.getBreedProperty(paramString);
  }
  
  public Commodityparams getCommodityParams(int paramInt, String paramString)
  {
    return this.tradeService.getCommodityParams(paramInt, Long.valueOf(Long.parseLong(paramString)));
  }
}
