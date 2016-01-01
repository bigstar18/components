package gnnt.MEBS.trademonitor.mgr.service;

import gnnt.MEBS.common.mgr.dao.StandardDao;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

@Service("tm_seriesspotMonitorService")
public class SeriesspotMonitorService
  extends StandardDao
{
  protected final transient Log logger = LogFactory.getLog(getClass());
  
  public Map<Integer, String> addOrderNumMonitor(Map<Integer, String> paramMap, int paramInt)
  {
    String str1 = (String)paramMap.get(Integer.valueOf(-1));
    String str2 = "select round(count(*)/5,1) as num,o.commodityId as commodityId,sysdate from t_orders o,dual where o.ordertime >= to_date('" + str1 + "','yyyy-MM-dd HH24:mi:ss') group by o.commodityId ";
    List localList1 = queryBySql(str2);
    Timestamp localTimestamp = new Timestamp(new Date().getTime());
    SimpleDateFormat localSimpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    if ((localList1 != null) && (localList1.size() > 0))
    {
      for (int i = 0; i < localList1.size(); i++)
      {
        BigDecimal localBigDecimal = (BigDecimal)((Map)localList1.get(i)).get("NUM");
        int k = Double.valueOf(Math.ceil(localBigDecimal.doubleValue())).intValue();
        String str4 = (String)((Map)localList1.get(i)).get("COMMODITYID");
        paramMap.put(Integer.valueOf(i), str4);
        localTimestamp = (Timestamp)((Map)localList1.get(i)).get("SYSDATE");
        str1 = localSimpleDateFormat.format(localTimestamp);
        executeUpdateBySql(addSql(15, "order", k, str1, str4));
      }
    }
    else
    {
      List localList2 = queryBySql("select sysdate from dual");
      localTimestamp = (Timestamp)((Map)localList2.get(0)).get("SYSDATE");
      str1 = localSimpleDateFormat.format(localTimestamp);
      for (int j = 0; j < paramMap.size() - 1; j++)
      {
        String str3 = (String)paramMap.get(Integer.valueOf(j));
        executeUpdateBySql(addSql(15, "order", 0, str1, str3));
      }
    }
    paramMap.put(Integer.valueOf(-1), str1);
    return paramMap;
  }
  
  public Map<Integer, String> addTradeNumMonitor(Map<Integer, String> paramMap, int paramInt)
  {
    String str1 = (String)paramMap.get(Integer.valueOf(-1));
    String str2 = "select round(count(*)/5,1) as num,o.commodityId as commodityId,sysdate from T_Trade o,dual where o.tradetime >= to_date('" + str1 + "','yyyy-MM-dd HH24:mi:ss') group by o.commodityId ";
    List localList1 = queryBySql(str2);
    Timestamp localTimestamp = new Timestamp(new Date().getTime());
    SimpleDateFormat localSimpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    if ((localList1 != null) && (localList1.size() > 0))
    {
      for (int i = 0; i < localList1.size(); i++)
      {
        BigDecimal localBigDecimal = (BigDecimal)((Map)localList1.get(i)).get("NUM");
        int k = Double.valueOf(Math.ceil(localBigDecimal.doubleValue())).intValue();
        String str4 = (String)((Map)localList1.get(i)).get("COMMODITYID");
        paramMap.put(Integer.valueOf(i), str4);
        localTimestamp = (Timestamp)((Map)localList1.get(i)).get("SYSDATE");
        str1 = localSimpleDateFormat.format(localTimestamp);
        executeUpdateBySql(addSql(15, "trade", k, str1, str4));
      }
    }
    else
    {
      List localList2 = queryBySql("select sysdate from dual");
      localTimestamp = (Timestamp)((Map)localList2.get(0)).get("SYSDATE");
      str1 = localSimpleDateFormat.format(localTimestamp);
      for (int j = 0; j < paramMap.size() - 1; j++)
      {
        String str3 = (String)paramMap.get(Integer.valueOf(j));
        executeUpdateBySql(addSql(15, "trade", 0, str1, str3));
      }
    }
    paramMap.put(Integer.valueOf(-1), str1);
    return paramMap;
  }
  
  public Map<Integer, String> addHoldNumMonitor(Map<Integer, String> paramMap)
  {
    SimpleDateFormat localSimpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    Timestamp localTimestamp = new Timestamp(new Date().getTime());
    String str1 = localSimpleDateFormat.format(localTimestamp);
    String str2 = "select sum(t.holdqty) as holdqty,t.commodityid,sysdate from t_FirmHoldSum  t ,dual group by commodityid";
    List localList1 = queryBySql(str2);
    if ((localList1 != null) && (localList1.size() > 0))
    {
      for (int i = 0; i < localList1.size(); i++)
      {
        BigDecimal localBigDecimal = (BigDecimal)((Map)localList1.get(i)).get("HOLDQTY");
        int k = Double.valueOf(Math.ceil(localBigDecimal.doubleValue())).intValue();
        String str4 = (String)((Map)localList1.get(i)).get("COMMODITYID");
        paramMap.put(Integer.valueOf(i), str4);
        localTimestamp = (Timestamp)((Map)localList1.get(i)).get("SYSDATE");
        str1 = localSimpleDateFormat.format(localTimestamp);
        executeUpdateBySql(addSql(15, "hold", k, str1, str4));
      }
    }
    else
    {
      List localList2 = queryBySql("select sysdate from dual");
      localTimestamp = (Timestamp)((Map)localList2.get(0)).get("SYSDATE");
      str1 = localSimpleDateFormat.format(localTimestamp);
      for (int j = 0; j < paramMap.size() - 1; j++)
      {
        String str3 = (String)paramMap.get(Integer.valueOf(j));
        executeUpdateBySql(addSql(15, "hold", 0, str1, str3));
      }
    }
    paramMap.put(Integer.valueOf(-1), str1);
    return paramMap;
  }
  
  private String addSql(int paramInt1, String paramString1, int paramInt2, String paramString2, String paramString3)
  {
    String str = "insert into tm_trademonitor(id,moduleId,type,num,datetime,categoryType)   values(SEQ_tm_trademonitor.nextval," + paramInt1 + ",'" + paramString1 + "', " + paramInt2 + ", to_date('" + paramString2 + "', 'yyyy-MM-dd HH24:mi:ss'),'" + paramString3 + "')";
    return str;
  }
}
