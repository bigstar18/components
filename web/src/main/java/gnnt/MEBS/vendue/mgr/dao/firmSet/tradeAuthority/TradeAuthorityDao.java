package gnnt.MEBS.vendue.mgr.dao.firmSet.tradeAuthority;

import java.util.List;

public abstract interface TradeAuthorityDao
{
  public abstract void updateCommodity(String paramString, int paramInt);
  
  public abstract void addTradeAuthority(String paramString, String[] paramArrayOfString);
  
  public abstract void delateTradeAuthority(String[] paramArrayOfString);
  
  public abstract String checkTradeUserByIds(String paramString);
  
  public abstract String checkTradeAuth(String paramString1, String paramString2);
  
  public abstract List getCommodityListByAuth(int paramInt);
}
