package gnnt.MEBS.trademonitor.mgr.filter.thread;

import gnnt.MEBS.common.mgr.statictools.ApplicationContextInit;
import gnnt.MEBS.trademonitor.mgr.service.VendueMonitorService;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class VendueMonitorThread
  extends Thread
{
  protected final transient Log logger = LogFactory.getLog(VendueMonitorThread.class);
  private int sleepTime;
  private String time;
  private VendueMonitorService vendueMonitorService = (VendueMonitorService)ApplicationContextInit.getBean("tm_vendueMonitorService");
  
  public VendueMonitorThread(int paramInt, String paramString)
  {
    this.sleepTime = paramInt;
    this.time = paramString;
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
      this.time = this.vendueMonitorService.addOrderNumMonitor(this.time, this.sleepTime);
    }
  }
}
