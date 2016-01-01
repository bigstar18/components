package gnnt.MEBS.trademonitor.mgr.action;

import gnnt.MEBS.common.mgr.action.StandardAction;
import gnnt.MEBS.common.mgr.common.Page;
import gnnt.MEBS.common.mgr.common.PageRequest;
import gnnt.MEBS.common.mgr.common.QueryConditions;
import gnnt.MEBS.common.mgr.service.StandardService;
import gnnt.MEBS.trademonitor.mgr.model.TradeMonitor;
import java.util.Date;
import java.util.List;
import net.sf.json.JSONArray;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

@Controller("tm_onlineMonitorAction")
@Scope("request")
public class OnlineMonitorAction
  extends StandardAction
{
  private static final long serialVersionUID = 1122779313585879008L;
  private JSONArray json = new JSONArray();
  
  public JSONArray getJson()
  {
    return this.json;
  }
  
  public String getOnlineList()
  {
    PageRequest localPageRequest = new PageRequest();
    localPageRequest.setSortColumns("order by dateTime desc");
    QueryConditions localQueryConditions = new QueryConditions();
    localQueryConditions.addCondition("moduleId", "=", Integer.valueOf(11));
    localQueryConditions.addCondition("type", "=", "online");
    localPageRequest.setFilters(localQueryConditions);
    localPageRequest.setPageSize(240);
    localPageRequest.setPageNumber(1);
    Page localPage = getService().getPage(localPageRequest, new TradeMonitor());
    String str = "";
    if ((localPage.getResult() != null) && (localPage.getResult().size() > 0)) {
      for (int i = localPage.getResult().size() - 1; i >= 0; i--)
      {
        TradeMonitor localTradeMonitor = (TradeMonitor)localPage.getResult().get(i);
        str = "[" + localTradeMonitor.getDateTime().getTime() + "," + localTradeMonitor.getNum() + "]";
        this.json.add(str);
      }
    }
    return "success";
  }
}
