package gnnt.MEBS.trademonitor.mgr.service;

import gnnt.MEBS.common.mgr.dao.StandardDao;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

@Service("tm_vendueMonitorService")
public class VendueMonitorService
  extends StandardDao
{
  protected final transient Log logger = LogFactory.getLog(getClass());
  
  public String addOrderNumMonitor(String paramString, int paramInt)
  {
    String str = "select round(count(*)/5,1) as num,sysdate from v_cursubmit v,dual where v.submittime >= to_date('" + paramString + "','yyyy-MM-dd HH24:mi:ss')";
    List localList = queryBySql(str);
    BigDecimal localBigDecimal = (BigDecimal)((Map)localList.get(0)).get("NUM");
    int i = Double.valueOf(Math.ceil(localBigDecimal.doubleValue())).intValue();
    SimpleDateFormat localSimpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    Timestamp localTimestamp = (Timestamp)((Map)localList.get(0)).get("SYSDATE");
    paramString = localSimpleDateFormat.format(localTimestamp);
    executeUpdateBySql(addSql(21, "order", i, paramString, ""));
    return paramString;
  }
  
  private String addSql(int paramInt1, String paramString1, int paramInt2, String paramString2, String paramString3)
  {
    String str = "insert into tm_trademonitor(id,moduleId,type,num,datetime,categoryType)   values(SEQ_tm_trademonitor.nextval," + paramInt1 + ",'" + paramString1 + "', " + paramInt2 + ", to_date('" + paramString2 + "', 'yyyy-MM-dd HH24:mi:ss'),'" + paramString3 + "')";
    return str;
  }
}
