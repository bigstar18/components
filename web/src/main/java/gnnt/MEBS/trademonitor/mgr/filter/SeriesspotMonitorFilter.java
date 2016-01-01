package gnnt.MEBS.trademonitor.mgr.filter;

import gnnt.MEBS.common.mgr.common.Global;
import gnnt.MEBS.common.mgr.service.StandardService;
import gnnt.MEBS.common.mgr.statictools.ApplicationContextInit;
import gnnt.MEBS.trademonitor.mgr.filter.thread.SeriesspotMonitorThread;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

public class SeriesspotMonitorFilter
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
    if (Global.modelContextMap.get(Integer.valueOf(15)) != null)
    {
      StandardService localStandardService = (StandardService)ApplicationContextInit.getBean("com_standardService");
      String str1 = "select commodityId from t_commodity";
      List localList = localStandardService.getListBySql(str1);
      HashMap localHashMap1 = new HashMap();
      HashMap localHashMap2 = new HashMap();
      HashMap localHashMap3 = new HashMap();
      if ((localList != null) && (localList.size() > 0)) {
        for (int i = 0; i < localList.size(); i++)
        {
          localObject = (String)((Map)localList.get(i)).get("COMMODITYID");
          localHashMap1.put(Integer.valueOf(i), localObject);
          localHashMap2.put(Integer.valueOf(i), localObject);
          localHashMap3.put(Integer.valueOf(i), localObject);
        }
      }
      String str2 = OnlineMonitorFilter.time;
      localHashMap1.put(Integer.valueOf(-1), str2);
      localHashMap2.put(Integer.valueOf(-1), str2);
      localHashMap3.put(Integer.valueOf(-1), str2);
      Object localObject = new SeriesspotMonitorThread(5000, localHashMap1, "order");
      ((SeriesspotMonitorThread)localObject).start();
      SeriesspotMonitorThread localSeriesspotMonitorThread1 = new SeriesspotMonitorThread(5000, localHashMap2, "trade");
      localSeriesspotMonitorThread1.start();
      SeriesspotMonitorThread localSeriesspotMonitorThread2 = new SeriesspotMonitorThread(5000, localHashMap3, "hold");
      localSeriesspotMonitorThread2.start();
    }
  }
}
