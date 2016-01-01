package gnnt.MEBS.vendue.mgr.service.firmSet.tradeAuthority;

import java.util.List;

public abstract interface TradeAuthorityService
{
  public abstract void addTradeAuthority(String paramString, int paramInt, String[] paramArrayOfString);
  
  public abstract void delateTradeAuthority(String[] paramArrayOfString);
  
  public abstract String checkTradeUserByIds(String paramString);
  
  public abstract String checkTradeAuth(String paramString1, String paramString2);
  
  public abstract List getCommodityListByAuth(int paramInt);
}
