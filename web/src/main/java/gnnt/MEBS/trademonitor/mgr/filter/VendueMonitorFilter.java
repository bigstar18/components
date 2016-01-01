package gnnt.MEBS.trademonitor.mgr.filter;

import gnnt.MEBS.common.mgr.common.Global;
import gnnt.MEBS.trademonitor.mgr.filter.thread.VendueMonitorThread;
import java.io.IOException;
import java.util.Map;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

public class VendueMonitorFilter
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
    if (Global.modelContextMap.get(Integer.valueOf(21)) != null)
    {
      String str = OnlineMonitorFilter.time;
      VendueMonitorThread localVendueMonitorThread = new VendueMonitorThread(5000, str);
      localVendueMonitorThread.start();
    }
  }
}
