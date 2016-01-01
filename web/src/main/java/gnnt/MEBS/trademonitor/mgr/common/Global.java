package gnnt.MEBS.trademonitor.mgr.common;

import gnnt.MEBS.activeUserListener.kernel.ILogonService;
import gnnt.MEBS.common.mgr.service.StandardService;
import gnnt.MEBS.common.mgr.statictools.ApplicationContextInit;
import java.net.MalformedURLException;
import java.rmi.Naming;
import java.rmi.NotBoundException;
import java.rmi.RemoteException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class Global
  implements ServletContextListener
{
  protected final transient Log logger = LogFactory.getLog(getClass());
  private static ILogonService logonService;
  private static Map<String, String> rmiMap = new HashMap();
  
  public void contextDestroyed(ServletContextEvent paramServletContextEvent) {}
  
  public void contextInitialized(ServletContextEvent paramServletContextEvent)
  {
    StandardService localStandardService = (StandardService)ApplicationContextInit.getBean("com_standardService");
    List localList1 = localStandardService.getListBySql("select * from l_dictionary l where l.key='getLogonUser_ip'");
    if ((localList1 != null) && (localList1.size() > 0)) {
      rmiMap.put("ip", ((Map)localList1.get(0)).get("VALUE").toString());
    }
    List localList2 = localStandardService.getListBySql("select * from l_dictionary l where l.key='getLogonUser_port'");
    if ((localList2 != null) && (localList2.size() > 0)) {
      rmiMap.put("port", ((Map)localList2.get(0)).get("VALUE").toString());
    }
    List localList3 = localStandardService.getListBySql("select * from l_dictionary l where l.key='getLogonUser_dataPort'");
    if ((localList3 != null) && (localList3.size() > 0)) {
      rmiMap.put("dataPort", ((Map)localList3.get(0)).get("VALUE").toString());
    }
    this.logger.info("-----rmiMap----------" + rmiMap);
    try
    {
      logonService = (ILogonService)Naming.lookup("rmi://" + (String)rmiMap.get("ip") + ":" + (String)rmiMap.get("port") + "/logonService");
    }
    catch (MalformedURLException localMalformedURLException)
    {
      localMalformedURLException.printStackTrace();
    }
    catch (RemoteException localRemoteException)
    {
      localRemoteException.printStackTrace();
    }
    catch (NotBoundException localNotBoundException)
    {
      localNotBoundException.printStackTrace();
    }
  }
  
  public static ILogonService getLogonService()
  {
    return logonService;
  }
  
  public static void clearLogonService()
    throws MalformedURLException, RemoteException, NotBoundException
  {
    logonService = (ILogonService)Naming.lookup("rmi://" + (String)rmiMap.get("ip") + ":" + (String)rmiMap.get("port") + "/" + (String)rmiMap.get("serverName"));
  }
}
