package gnnt.MEBS.vendue.front.init;

import gnnt.MEBS.priceranking.server.model.SystemPartition;
import gnnt.MEBS.priceranking.server.rmi.ServerRMI;
import gnnt.MEBS.priceranking.server.rmi.TradeRMI;
import gnnt.MEBS.vendue.front.model.QuantionMap;
import gnnt.MEBS.vendue.front.server.QuantionThread;
import gnnt.MEBS.vendue.front.service.TradeService;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import org.apache.log4j.Logger;

public class Init
  extends HttpServlet
{
  private static final long serialVersionUID = 1000L;
  public static Map<Short, SystemPartition> sysPartitions;
  
  public void destroy()
  {
    super.destroy();
  }
  
  public void init()
    throws ServletException
  {
    super.init();
    Logger localLogger = Logger.getLogger("Kernellog");
    localLogger.debug("=========== start to load container ====================================");
    try
    {
      InitLoad.loadContainer();
      localLogger.debug("=========== succeed to load container ==================================");
      TradeService localTradeService = (TradeService)InitLoad.getTradeObject("tradeService");
      TradeRMI localTradeRMI = localTradeService.getTradeRMI();
      ServerRMI localServerRMI = localTradeService.getServerRMI();
      localLogger.debug("=========== 开始加载板块信息 ==================================");
      sysPartitions = localServerRMI.getSystemPartition();
      localLogger.debug("=========== 成功加载板块信息 ==================================");
      QuantionThread localQuantionThread = new QuantionThread();
      QuantionMap localQuantionMap = QuantionMap.getInit();
      localQuantionThread.init(localTradeRMI, localQuantionMap, sysPartitions);
      localQuantionThread.start();
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
      localLogger.debug("=========== fail to load container ====================================");
    }
  }
}
