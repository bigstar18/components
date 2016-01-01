package gnnt.MEBS.vendue.mgr.service.impl.firmSet.tradeAuthority;

import gnnt.MEBS.common.mgr.service.StandardService;
import gnnt.MEBS.vendue.mgr.dao.firmSet.tradeAuthority.TradeAuthorityDao;
import gnnt.MEBS.vendue.mgr.service.firmSet.tradeAuthority.TradeAuthorityService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service("tradeAuthorityService")
@Transactional(propagation=Propagation.REQUIRED, readOnly=false)
public class TradeAuthorityServiceImpl
  extends StandardService
  implements TradeAuthorityService
{
  @Autowired
  @Qualifier("tradeAuthorityDao")
  private TradeAuthorityDao tradeAuthorityDao;
  
  public TradeAuthorityDao getTradeAuthorityDao()
  {
    return this.tradeAuthorityDao;
  }
  
  public void setTradeAuthorityDao(TradeAuthorityDao paramTradeAuthorityDao)
  {
    this.tradeAuthorityDao = paramTradeAuthorityDao;
  }
  
  public void addTradeAuthority(String paramString, int paramInt, String[] paramArrayOfString)
  {
    this.tradeAuthorityDao.addTradeAuthority(paramString, paramArrayOfString);
  }
  
  public void delateTradeAuthority(String[] paramArrayOfString)
  {
    this.tradeAuthorityDao.delateTradeAuthority(paramArrayOfString);
  }
  
  public String checkTradeUserByIds(String paramString)
  {
    String str = this.tradeAuthorityDao.checkTradeUserByIds(paramString);
    return str;
  }
  
  public String checkTradeAuth(String paramString1, String paramString2)
  {
    String str = this.tradeAuthorityDao.checkTradeAuth(paramString1, paramString2);
    return str;
  }
  
  public List getCommodityListByAuth(int paramInt)
  {
    List localList = this.tradeAuthorityDao.getCommodityListByAuth(paramInt);
    return localList;
  }
}
