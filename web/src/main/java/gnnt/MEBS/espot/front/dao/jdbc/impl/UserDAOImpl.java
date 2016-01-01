package gnnt.MEBS.espot.front.dao.jdbc.impl;

import gnnt.MEBS.espot.front.dao.jdbc.UserDAO;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;
import org.apache.commons.logging.Log;
import org.springframework.jdbc.core.JdbcTemplate;

public class UserDAOImpl
  extends BaseDAOJdbc
  implements UserDAO
{
  public Map<String, Integer> getTradeSize(String paramString)
  {
    HashMap localHashMap = new HashMap();
    String str1 = "select sorder.length sorder,border.length border,sendbreach.length sendbreach,savebreach.length savebreach,sendoffset.length sendoffset,saveoffset.length saveoffset,sendar.length sendar,savear.length savear,savesub.length savesub,sendLastMoneyApply.length sendLastMoneyApply,saveLastMoneyApply.length saveLastMoneyApply,endTradeApply.length endTradeApply,sendTradeApply.length sendTradeApply,sendsub.length sendsub from (select count(*) length from e_order t where (status=0 or status=1) and bsflag='S' and firmid='" + paramString + "') sorder, " + "(select count(*) length from e_order t where (status=0 or status=1) and bsflag='B' and firmid='" + paramString + "') border, " + "(select count(*) length from e_breachapply b,e_trade t where t.tradeno=b.tradeno and b.status=0 and (t.bfirmid='" + paramString + "' or t.sfirmid='" + paramString + "') and firmid='" + paramString + "') sendbreach, " + "(select count(*) length from e_breachapply b,e_trade t where t.tradeno=b.tradeno and firmid<>'" + paramString + "' and b.status=0 and (t.bfirmid='" + paramString + "' or t.sfirmid='" + paramString + "')) savebreach, " + "(select count(*) length from e_offset o,e_trade t where t.tradeno=o.tradeno and o.status=0 and (t.bfirmid='" + paramString + "' or t.sfirmid='" + paramString + "') and o.firmid='" + paramString + "') sendoffset, " + "(select count(*) length from e_offset o,e_trade t where t.tradeno=o.tradeno and o.firmid<>'" + paramString + "' and o.status=0 and (t.bfirmid='" + paramString + "' or t.sfirmid='" + paramString + "')) saveoffset, " + "(select count(*) length from e_Arbitration a,e_trade t where a.tradeno=t.tradeno and a.result=0 and (t.bfirmid='" + paramString + "' or t.sfirmid='" + paramString + "') and a.Applicant='" + paramString + "') sendar, " + "(select count(*) length from e_Arbitration a,e_trade t where a.tradeno=t.tradeno and a.Applicant<>'" + paramString + "' and a.result=0 and (t.bfirmid='" + paramString + "' or t.sfirmid='" + paramString + "')) savear, " + "(select count(*) length from e_suborder s,e_order o where o.orderid=s.orderid and s.status=0 and o.firmid='" + paramString + "') savesub, " + "(select count(*) length from e_GoodsMoneyApply t , e_Trade x where x.tradeno = t.tradeno and x.sfirmid='" + paramString + "' and t.status='0') sendLastMoneyApply, " + "(select count(*) length from e_GoodsMoneyApply t , e_Trade x where x.tradeno = t.tradeno and x.bfirmid='" + paramString + "' and t.status='0') saveLastMoneyApply, " + "(select count(*) length from e_Endtradeapply t , e_Trade x where x.tradeno = t.tradeno and t.status=0 and  (x.bfirmid='" + paramString + "' or x.sfirmid='" + paramString + "') and t.firmid<>'" + paramString + "') endTradeApply, " + "(select count(*) length from e_Endtradeapply t , e_Trade x where x.tradeno = t.tradeno and t.status=0 and  (x.bfirmid='" + paramString + "' or x.sfirmid='" + paramString + "') and t.firmid ='" + paramString + "') sendTradeApply, " + "(select count(*) length from e_suborder s,e_order o where o.orderid=s.orderid and s.status=0 and s.subfirmid = '" + paramString + "') sendsub ";
    this.logger.debug("sql:" + str1);
    Map localMap = getJdbcTemplate().queryForMap(str1);
    Iterator localIterator = localMap.keySet().iterator();
    while (localIterator.hasNext())
    {
      String str2 = (String)localIterator.next();
      localHashMap.put(str2, Integer.valueOf(Integer.parseInt(localMap.get(str2).toString())));
    }
    return localHashMap;
  }
}
