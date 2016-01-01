package gnnt.MEBS.trademonitor.mgr.filter;

import gnnt.MEBS.common.mgr.common.Global;
import gnnt.MEBS.trademonitor.mgr.filter.thread.EspotMonitorThread;
import java.io.IOException;
import java.util.Map;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

public class EspotMonitorFilter
  implements Filter
{
  public void destroy() {}
  
  public void doFilter(ServletRequest paramServletRequest, ServletResponse paramServletResponse, FilterChain paramFilterChain)
    throws IOException, ServletException
  {
    paramFilterChain.doFilter(paramServletRequest, paramServletResponse);
  }
  
  public void init(FilterConfig paramFilterConfig)
    throws ServletException
  {
    if (Global.modelContextMap.get(Integer.valueOf(23)) != null)
    {
      String str = OnlineMonitorFilter.time;
      EspotMonitorThread localEspotMonitorThread1 = new EspotMonitorThread(10000, str, "order");
      localEspotMonitorThread1.start();
      EspotMonitorThread localEspotMonitorThread2 = new EspotMonitorThread(10000, str, "trade");
      localEspotMonitorThread2.start();
    }
  }
}
