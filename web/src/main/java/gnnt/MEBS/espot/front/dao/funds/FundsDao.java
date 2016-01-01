package gnnt.MEBS.espot.front.dao.funds;

import gnnt.MEBS.common.front.dao.StandardDao;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import org.apache.commons.logging.Log;
import org.springframework.stereotype.Repository;

@Repository("fundsDao")
public class FundsDao
  extends StandardDao
{
  public Map<String, Double> getFirmScription(String paramString)
  {
    this.logger.debug("查询交易商" + paramString + "诚信保障金信息");
    HashMap localHashMap = new HashMap();
    String str = " select f.subscription,s.runtimevalue,FN_E_CanOutSubscription('" + paramString + "',0) as canoutsubscription,FN_F_GetRealFunds('" + paramString + "',0) as getrealfunds from e_funds f,e_systemprops s where f.firmid='" + paramString + "' and s.key='LeastSubscription' ";
    List localList = queryBySql(str);
    if ((localList != null) && (localList.size() > 0))
    {
      Iterator localIterator1 = localList.iterator();
      while (localIterator1.hasNext())
      {
        Map localMap = (Map)localIterator1.next();
        if ((localMap != null) && (localMap.size() > 0))
        {
          Iterator localIterator2 = localMap.keySet().iterator();
          while (localIterator2.hasNext())
          {
            Object localObject = localIterator2.next();
            try
            {
              localHashMap.put(localObject.toString(), Double.valueOf(localMap.get(localObject).toString()));
            }
            catch (Exception localException)
            {
              localException.printStackTrace();
            }
          }
        }
      }
    }
    return localHashMap;
  }
  
  public double inmoneymodel(String paramString, double paramDouble)
    throws Exception
  {
    String str1 = "103";
    String str2 = new Date().getTime() + "";
    String str3 = "10201";
    Object[] arrayOfObject = { paramString, str1, Double.valueOf(paramDouble), str2, str3 };
    Object localObject = executeProcedure("{?=call FN_F_UpdateFundsFull(?,?,?,?,?,null,null)}", arrayOfObject);
    double d = new Double(localObject.toString()).doubleValue();
    return d;
  }
}
