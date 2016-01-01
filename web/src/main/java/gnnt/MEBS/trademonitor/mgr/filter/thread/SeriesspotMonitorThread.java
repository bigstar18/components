package gnnt.MEBS.trademonitor.mgr.filter.thread;

import gnnt.MEBS.common.mgr.statictools.ApplicationContextInit;
import gnnt.MEBS.trademonitor.mgr.service.SeriesspotMonitorService;
import java.util.Map;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class SeriesspotMonitorThread
  extends Thread
{
  protected final transient Log logger = LogFactory.getLog(SeriesspotMonitorThread.class);
  private int sleepTime;
  private String type;
  private Map<Integer, String> commodityMap;
  private SeriesspotMonitorService seriesspotMonitorService = (SeriesspotMonitorService)ApplicationContextInit.getBean("tm_seriesspotMonitorService");
  
  public SeriesspotMonitorThread(int paramInt, Map<Integer, String> paramMap, String paramString)
  {
    this.sleepTime = paramInt;
    this.commodityMap = paramMap;
    this.type = paramString;
  }
  
  public void run()
  {
    for (;;)
    {
      try
      {
        Thread.sleep(this.sleepTime);
      }
      catch (Exception localException) {}
      if ("order".equals(this.type)) {
        this.commodityMap = this.seriesspotMonitorService.addOrderNumMonitor(this.commodityMap, this.sleepTime);
      } else if ("trade".equals(this.type)) {
        this.commodityMap = this.seriesspotMonitorService.addTradeNumMonitor(this.commodityMap, this.sleepTime);
      } else if ("hold".equals(this.type)) {
        this.commodityMap = this.seriesspotMonitorService.addHoldNumMonitor(this.commodityMap);
      }
    }
  }
}
