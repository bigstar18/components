package gnnt.MEBS.trademonitor.mgr.service;

import gnnt.MEBS.activeUserListener.kernel.ILogonService;
import gnnt.MEBS.common.mgr.dao.StandardDao;
import gnnt.MEBS.trademonitor.mgr.common.Global;
import java.net.MalformedURLException;
import java.rmi.NotBoundException;
import java.rmi.RemoteException;
import java.util.List;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

@Service("tm_onlineMonitorService")
public class OnlineMonitorService
  extends StandardDao
{
  protected final transient Log logger = LogFactory.getLog(getClass());
  
  public void addOnlineNumMonitor()
  {
    int i = 0;
    List localList = null;
    try
    {
      localList = Global.getLogonService().getOnLineUserList("front", null, "", "");
    }
    catch (Exception localException1)
    {
      try
      {
        Global.clearLogonService();
        localList = Global.getLogonService().getOnLineUserList("front", null, "", "");
      }
      catch (MalformedURLException localMalformedURLException)
      {
        this.logger.error("远程调用协议错误" + localException1.getMessage());
      }
      catch (NotBoundException localNotBoundException)
      {
        this.logger.error("远程调用无服务" + localException1.getMessage());
      }
      catch (RemoteException localRemoteException)
      {
        this.logger.error("退出用户时连接RMI失败" + localException1.getMessage());
      }
      catch (Exception localException2)
      {
        this.logger.error("调用远程服务异常" + localException1.getMessage());
      }
    }
    if (localList != null) {
      i = localList.size();
    }
    String str = "insert into tm_trademonitor(id,moduleId,type,num,datetime,categoryType)   values(SEQ_tm_trademonitor.nextval,11,'online', " + i + ", sysdate,'')";
    executeUpdateBySql(str);
  }
}
