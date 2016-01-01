package gnnt.MEBS.trademonitor.mgr.filter.thread;

import gnnt.MEBS.common.mgr.statictools.ApplicationContextInit;
import gnnt.MEBS.trademonitor.mgr.service.OnlineMonitorService;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class OnlineMonitorThread
  extends Thread
{
  protected final transient Log logger = LogFactory.getLog(OnlineMonitorThread.class);
  private int sleepTime;
  private OnlineMonitorService onlineMonitorService = (OnlineMonitorService)ApplicationContextInit.getBean("tm_onlineMonitorService");
  
  public OnlineMonitorThread(int paramInt)
  {
    this.sleepTime = paramInt;
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
      this.onlineMonitorService.addOnlineNumMonitor();
    }
  }
}
