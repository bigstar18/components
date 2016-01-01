package gnnt.MEBS.trademonitor.mgr.action;

import gnnt.MEBS.common.mgr.action.StandardAction;
import gnnt.MEBS.common.mgr.common.Page;
import gnnt.MEBS.common.mgr.common.PageRequest;
import gnnt.MEBS.common.mgr.common.QueryConditions;
import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.service.StandardService;
import gnnt.MEBS.trademonitor.mgr.model.SeriesCommodity;
import gnnt.MEBS.trademonitor.mgr.model.TradeMonitor;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import net.sf.json.JSONArray;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

@Controller("tm_seriesspotMonitorAction")
@Scope("request")
public class SeriesspotMonitorAction
  extends StandardAction
{
  private static final long serialVersionUID = 1122779313585879008L;
  private List<StandardModel> commodityList = new LinkedList();
  private Map<String, JSONArray> jsonMap = new HashMap();
  
  public List<StandardModel> getCommodityList()
  {
    return this.commodityList;
  }
  
  public Map<String, JSONArray> getJsonMap()
  {
    return this.jsonMap;
  }
  
  public String getOrderList()
  {
    PageRequest localPageRequest1 = new PageRequest(" and status=0 ");
    localPageRequest1.setPageSize(1000);
    localPageRequest1.setSortColumns("order by marketDate,commodityId desc");
    Page localPage1 = getService().getPage(localPageRequest1, new SeriesCommodity());
    this.commodityList = localPage1.getResult();
    PageRequest localPageRequest2 = new PageRequest();
    localPageRequest2.setSortColumns("order by dateTime desc");
    QueryConditions localQueryConditions = new QueryConditions();
    localQueryConditions.addCondition("moduleId", "=", Integer.valueOf(15));
    localQueryConditions.addCondition("type", "=", "order");
    localPageRequest2.setFilters(localQueryConditions);
    localPageRequest2.setPageSize(240 * this.commodityList.size());
    localPageRequest2.setPageNumber(1);
    Page localPage2 = getService().getPage(localPageRequest2, new TradeMonitor());
    String str = "";
    if ((localPage2.getResult() != null) && (localPage2.getResult().size() > 0)) {
      for (int i = localPage2.getResult().size() - 1; i >= 0; i--)
      {
        TradeMonitor localTradeMonitor = (TradeMonitor)localPage2.getResult().get(i);
        if ((this.commodityList != null) && (this.commodityList.size() > 0))
        {
          Iterator localIterator = this.commodityList.iterator();
          while (localIterator.hasNext())
          {
            StandardModel localStandardModel = (StandardModel)localIterator.next();
            SeriesCommodity localSeriesCommodity = (SeriesCommodity)localStandardModel;
            JSONArray localJSONArray = (JSONArray)this.jsonMap.get(localSeriesCommodity.getCommodityId());
            if (localJSONArray == null) {
              localJSONArray = new JSONArray();
            }
            if (localSeriesCommodity.getCommodityId().equals(localTradeMonitor.getCategoryType()))
            {
              str = "[" + localTradeMonitor.getDateTime().getTime() + "," + localTradeMonitor.getNum() + "]";
              localJSONArray.add(str);
              this.jsonMap.put(localSeriesCommodity.getCommodityId(), localJSONArray);
            }
          }
        }
      }
    }
    return "success";
  }
  
  public String getTradeList()
  {
    PageRequest localPageRequest1 = new PageRequest(" and status=0 ");
    localPageRequest1.setPageSize(1000);
    localPageRequest1.setSortColumns("order by marketDate,commodityId desc");
    Page localPage1 = getService().getPage(localPageRequest1, new SeriesCommodity());
    this.commodityList = localPage1.getResult();
    PageRequest localPageRequest2 = new PageRequest();
    localPageRequest2.setSortColumns("order by dateTime desc");
    QueryConditions localQueryConditions = new QueryConditions();
    localQueryConditions.addCondition("moduleId", "=", Integer.valueOf(15));
    localQueryConditions.addCondition("type", "=", "trade");
    localPageRequest2.setFilters(localQueryConditions);
    localPageRequest2.setPageSize(240 * this.commodityList.size());
    localPageRequest2.setPageNumber(1);
    Page localPage2 = getService().getPage(localPageRequest2, new TradeMonitor());
    String str = "";
    if ((localPage2.getResult() != null) && (localPage2.getResult().size() > 0)) {
      for (int i = localPage2.getResult().size() - 1; i >= 0; i--)
      {
        TradeMonitor localTradeMonitor = (TradeMonitor)localPage2.getResult().get(i);
        if ((this.commodityList != null) && (this.commodityList.size() > 0))
        {
          Iterator localIterator = this.commodityList.iterator();
          while (localIterator.hasNext())
          {
            StandardModel localStandardModel = (StandardModel)localIterator.next();
            SeriesCommodity localSeriesCommodity = (SeriesCommodity)localStandardModel;
            JSONArray localJSONArray = (JSONArray)this.jsonMap.get(localSeriesCommodity.getCommodityId());
            if (localJSONArray == null) {
              localJSONArray = new JSONArray();
            }
            if (localSeriesCommodity.getCommodityId().equals(localTradeMonitor.getCategoryType()))
            {
              str = "[" + localTradeMonitor.getDateTime().getTime() + "," + localTradeMonitor.getNum() + "]";
              localJSONArray.add(str);
              this.jsonMap.put(localSeriesCommodity.getCommodityId(), localJSONArray);
            }
          }
        }
      }
    }
    return "success";
  }
  
  public String getHoldList()
  {
    PageRequest localPageRequest1 = new PageRequest(" and status=0 ");
    localPageRequest1.setPageSize(1000);
    localPageRequest1.setSortColumns("order by marketDate,commodityId desc");
    Page localPage1 = getService().getPage(localPageRequest1, new SeriesCommodity());
    this.commodityList = localPage1.getResult();
    PageRequest localPageRequest2 = new PageRequest();
    localPageRequest2.setSortColumns("order by dateTime desc");
    QueryConditions localQueryConditions = new QueryConditions();
    localQueryConditions.addCondition("moduleId", "=", Integer.valueOf(15));
    localQueryConditions.addCondition("type", "=", "hold");
    localPageRequest2.setFilters(localQueryConditions);
    localPageRequest2.setPageSize(240 * this.commodityList.size());
    localPageRequest2.setPageNumber(1);
    Page localPage2 = getService().getPage(localPageRequest2, new TradeMonitor());
    String str = "";
    if ((localPage2.getResult() != null) && (localPage2.getResult().size() > 0)) {
      for (int i = localPage2.getResult().size() - 1; i >= 0; i--)
      {
        TradeMonitor localTradeMonitor = (TradeMonitor)localPage2.getResult().get(i);
        if ((this.commodityList != null) && (this.commodityList.size() > 0))
        {
          Iterator localIterator = this.commodityList.iterator();
          while (localIterator.hasNext())
          {
            StandardModel localStandardModel = (StandardModel)localIterator.next();
            SeriesCommodity localSeriesCommodity = (SeriesCommodity)localStandardModel;
            JSONArray localJSONArray = (JSONArray)this.jsonMap.get(localSeriesCommodity.getCommodityId());
            if (localJSONArray == null) {
              localJSONArray = new JSONArray();
            }
            if (localSeriesCommodity.getCommodityId().equals(localTradeMonitor.getCategoryType()))
            {
              str = "[" + localTradeMonitor.getDateTime().getTime() + "," + localTradeMonitor.getNum() + "]";
              localJSONArray.add(str);
              this.jsonMap.put(localSeriesCommodity.getCommodityId(), localJSONArray);
            }
          }
        }
      }
    }
    return "success";
  }
}
