package gnnt.MEBS.vendue.front.init;

import gnnt.MEBS.base.util.SysData;
import gnnt.MEBS.vendue.front.dao.TradeDAO;
import gnnt.MEBS.vendue.front.service.TradeService;
import java.util.Hashtable;

public class InitLoad
{
  private static Hashtable<String, Object> SUBMITACTIONTABLE = new Hashtable();
  private static boolean LOADFLAG = false;
  
  public static synchronized void loadContainer()
  {
    if (!LOADFLAG)
    {
      TradeDAO localTradeDAO = (TradeDAO)SysData.getBean("tradeDAO");
      TradeService localTradeService = (TradeService)SysData.getBean("tradeService");
      SUBMITACTIONTABLE.put("tradeDAO", localTradeDAO);
      SUBMITACTIONTABLE.put("tradeService", localTradeService);
    }
  }
  
  public static Object getTradeObject(String paramString)
  {
    return SUBMITACTIONTABLE.get(paramString);
  }
}
