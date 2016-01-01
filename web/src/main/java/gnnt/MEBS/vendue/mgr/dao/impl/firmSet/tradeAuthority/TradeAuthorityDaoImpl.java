package gnnt.MEBS.vendue.mgr.dao.impl.firmSet.tradeAuthority;

import gnnt.MEBS.common.mgr.dao.StandardDao;
import gnnt.MEBS.vendue.mgr.dao.firmSet.tradeAuthority.TradeAuthorityDao;
import gnnt.MEBS.vendue.mgr.model.firmSet.tradeAuthority.TradeAuthority;
import gnnt.MEBS.vendue.mgr.model.firmSet.tradeAuthority.TradeAuthorityKey;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Repository;

@Repository("tradeAuthorityDao")
public class TradeAuthorityDaoImpl
  extends StandardDao
  implements TradeAuthorityDao
{
  public void updateCommodity(String paramString, int paramInt)
  {
    String str = "update v_commodity set Authorization = " + paramInt + " where Code = '" + paramString + "'";
    executeUpdateBySql(str);
  }
  
  public void addTradeAuthority(String paramString, String[] paramArrayOfString)
  {
    ArrayList localArrayList = new ArrayList();
    for (int i = 0; i < paramArrayOfString.length; i++)
    {
      TradeAuthority localTradeAuthority = new TradeAuthority();
      TradeAuthorityKey localTradeAuthorityKey = new TradeAuthorityKey();
      localTradeAuthorityKey.setCode(paramString);
      localTradeAuthorityKey.setUserCode(paramArrayOfString[i]);
      localTradeAuthority.setKey(localTradeAuthorityKey);
      localArrayList.add(localTradeAuthority);
    }
    if (localArrayList.size() > 0) {
      getHibernateTemplate().saveOrUpdateAll(localArrayList);
    }
  }
  
  public void delateTradeAuthority(String[] paramArrayOfString)
  {
    ArrayList localArrayList = new ArrayList();
    for (int i = 0; i < paramArrayOfString.length; i++)
    {
      String str = paramArrayOfString[i];
      String[] arrayOfString = str.split("&");
      if ((arrayOfString != null) && (arrayOfString.length == 2))
      {
        TradeAuthority localTradeAuthority = new TradeAuthority();
        TradeAuthorityKey localTradeAuthorityKey = new TradeAuthorityKey();
        localTradeAuthorityKey.setCode(arrayOfString[0]);
        localTradeAuthorityKey.setUserCode(arrayOfString[1]);
        localTradeAuthority.setKey(localTradeAuthorityKey);
        localArrayList.add(localTradeAuthority);
      }
    }
    if (localArrayList.size() > 0) {
      getHibernateTemplate().deleteAll(localArrayList);
    }
  }
  
  public String checkTradeUserByIds(String paramString)
  {
    String str = paramString.replace("，", ",");
    String[] arrayOfString = str.split(",");
    int i = arrayOfString.length;
    StringBuffer localStringBuffer = new StringBuffer("");
    for (int j = 0; j < i; j++) {
      if (!checkTradeUserById(arrayOfString[j])) {
        localStringBuffer.append("(" + arrayOfString[j] + ")");
      }
    }
    return localStringBuffer.toString();
  }
  
  public boolean checkTradeUserById(String paramString)
  {
    StringBuffer localStringBuffer = new StringBuffer("select count(*) count from v_tradeUser where userCode =").append("'" + paramString + "'");
    List localList = queryBySql(localStringBuffer.toString());
    Map localMap = (Map)localList.get(0);
    return Integer.parseInt(localMap.get("COUNT").toString()) > 0;
  }
  
  public String checkTradeAuth(String paramString1, String paramString2)
  {
    String str = paramString2.replace("，", ",");
    String[] arrayOfString = str.split(",");
    int i = arrayOfString.length;
    StringBuffer localStringBuffer = new StringBuffer("");
    for (int j = 0; j < i; j++) {
      if (checkTradeAuthById(paramString1, arrayOfString[j])) {
        localStringBuffer.append("(" + arrayOfString[j] + ")");
      }
    }
    return localStringBuffer.toString();
  }
  
  public boolean checkTradeAuthById(String paramString1, String paramString2)
  {
    StringBuffer localStringBuffer = new StringBuffer("select count(*) count from v_TradeAuthority where Code =").append("'" + paramString1 + "' and userCode = ").append("'" + paramString2 + "'");
    List localList = queryBySql(localStringBuffer.toString());
    Map localMap = (Map)localList.get(0);
    return Integer.parseInt(localMap.get("COUNT").toString()) > 0;
  }
  
  public List getCommodityListByAuth(int paramInt)
  {
    StringBuffer localStringBuffer = new StringBuffer("select cur.code from v_commodity com, v_curCommodity cur").append(" where com.code = cur.code and com.Authorization=").append(paramInt);
    return queryBySql(localStringBuffer.toString());
  }
}
