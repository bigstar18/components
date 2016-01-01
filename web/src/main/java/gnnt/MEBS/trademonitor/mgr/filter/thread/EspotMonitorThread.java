package gnnt.MEBS.trademonitor.mgr.filter.thread;

import gnnt.MEBS.common.mgr.statictools.ApplicationContextInit;
import gnnt.MEBS.trademonitor.mgr.service.EspotMonitorService;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class EspotMonitorThread
  extends Thread
{
  protected final transient Log logger = LogFactory.getLog(EspotMonitorThread.class);
  private int sleepTime;
  private String time;
  private String type;
  private EspotMonitorService espotMonitorService = (EspotMonitorService)ApplicationContextInit.getBean("tm_espotMonitorService");
  
  public EspotMonitorThread(int paramInt, String paramString1, String paramString2)
  {
    this.sleepTime = paramInt;
    this.time = paramString1;
    this.type = paramString2;
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
        this.time = this.espotMonitorService.addOrderNumMonitor(this.time, this.sleepTime);
      } else if ("trade".equals(this.type)) {
        this.time = this.espotMonitorService.addTradeNumMonitor(this.time, this.sleepTime);
      }
    }
  }
}
