package gnnt.MEBS.trademonitor.mgr.filter;

import gnnt.MEBS.common.communicate.IBalanceRMI;
import gnnt.MEBS.common.mgr.service.StandardService;
import gnnt.MEBS.common.mgr.statictools.ApplicationContextInit;
import gnnt.MEBS.trademonitor.mgr.communicate.RMIServer;
import gnnt.MEBS.trademonitor.mgr.filter.thread.OnlineMonitorThread;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class OnlineMonitorFilter
  implements Filter
{
  protected final transient Log logger = LogFactory.getLog(getClass());
  public static String time;
  
  public void destroy() {}
  
  public void doFilter(ServletRequest paramServletRequest, ServletResponse paramServletResponse, FilterChain paramFilterChain)
    throws IOException, ServletException
  {
    paramFilterChain.doFilter(paramServletRequest, paramServletResponse);
  }
  
  public void init(FilterConfig paramFilterConfig)
    throws ServletException
  {
    SimpleDateFormat localSimpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    String str1 = "select sysdate from dual";
    StandardService localStandardService = (StandardService)ApplicationContextInit.getBean("com_standardService");
    List localList1 = localStandardService.getListBySql(str1);
    Timestamp localTimestamp = (Timestamp)((Map)localList1.get(0)).get("SYSDATE");
    time = localSimpleDateFormat.format(localTimestamp);
    OnlineMonitorThread localOnlineMonitorThread = new OnlineMonitorThread(5000);
    localOnlineMonitorThread.start();
    String str2 = "select * from c_trademodule t where t.moduleid=29 ";
    List localList2 = localStandardService.getListBySql(str2);
    String str3 = (String)((Map)localList2.get(0)).get("HOSTIP");
    BigDecimal localBigDecimal1 = (BigDecimal)((Map)localList2.get(0)).get("PORT");
    BigDecimal localBigDecimal2 = (BigDecimal)((Map)localList2.get(0)).get("RMIDATAPORT");
    String str4 = ApplicationContextInit.getConfig("BalanceRMIServiceName");
    if ((str4 == null) || (str4.trim().length() <= 0)) {
      str4 = "balanceRMI";
    }
    RMIServer localRMIServer = new RMIServer();
    IBalanceRMI localIBalanceRMI = (IBalanceRMI)ApplicationContextInit.getBean("balanceRMI");
    try
    {
      localRMIServer.startRMI(str3, localBigDecimal1.intValue(), localBigDecimal2.intValue(), str4.trim(), localIBalanceRMI);
    }
    catch (Exception localException)
    {
      this.logger.error("监控系统启动结算RMI错误", localException);
    }
  }
}
