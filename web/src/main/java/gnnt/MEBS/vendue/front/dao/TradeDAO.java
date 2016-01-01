package gnnt.MEBS.vendue.front.dao;

import gnnt.MEBS.priceranking.server.model.Commodity;
import gnnt.MEBS.priceranking.server.model.SystemStatus;
import gnnt.MEBS.priceranking.server.rmi.ServerRMI;
import gnnt.MEBS.priceranking.server.rmi.TradeRMI;
import gnnt.MEBS.vendue.front.model.BreedProperty;
import gnnt.MEBS.vendue.front.model.BroadcastVO;
import gnnt.MEBS.vendue.front.model.Commodityparams;
import gnnt.MEBS.vendue.front.model.CurSubmitVO;
import gnnt.MEBS.vendue.front.model.QuantionPage;
import gnnt.MEBS.vendue.front.model.SectionAttribute;
import gnnt.MEBS.vendue.front.model.SettleParams;
import gnnt.MEBS.vendue.front.model.SysPartition;
import gnnt.MEBS.vendue.front.model.TradeUser;
import java.util.List;
import java.util.Map;

public abstract interface TradeDAO
{
  public abstract CurSubmitVO[] getCurSubmitList(String paramString);
  
  public abstract double getFrozenFundsByMID(String paramString);
  
  public abstract double getBalance(String paramString);
  
  public abstract BroadcastVO getBroadcast(long paramLong);
  
  public abstract BroadcastVO[] getBroadcastList(String paramString);
  
  public abstract Map getRMIUrl();
  
  public abstract TradeRMI getTradeRMI();
  
  public abstract ServerRMI getServerRMI();
  
  public abstract int cancelCode(String paramString1, int paramInt, String paramString2);
  
  public abstract int addCode(String paramString1, int paramInt, String paramString2);
  
  public abstract String getChoiceCode(int paramInt, String paramString);
  
  public abstract List getCodeNums(String paramString);
  
  public abstract List<SysPartition> getSysPartitions(String paramString, Object[] paramArrayOfObject);
  
  public abstract List<SectionAttribute> getSectionAttribute(int paramInt);
  
  public abstract SystemStatus getSystemStatus(int paramInt);
  
  public abstract TradeUser getTradeUserInfo(String paramString);
  
  public abstract List<String> getCodeAuth(String paramString);
  
  public abstract Commodity getCode(String paramString);
  
  public abstract String getSysdate();
  
  public abstract Map<Long, String> getBreeds();
  
  public abstract Commodityparams getCommodityParams(int paramInt, Long paramLong);
  
  public abstract List<BreedProperty> getBreedProperty(String paramString);
  
  public abstract int addCodeApply(Commodity paramCommodity);
  
  public abstract int addSettleParams(SettleParams paramSettleParams);
  
  public abstract QuantionPage getQuotations(short paramShort, String paramString);
  
  public abstract QuantionPage getPageQuotations(short paramShort, String paramString1, String paramString2, String paramString3);
}
