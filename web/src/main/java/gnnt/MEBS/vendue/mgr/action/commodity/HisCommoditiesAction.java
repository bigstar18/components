package gnnt.MEBS.vendue.mgr.action.commodity;

import gnnt.MEBS.common.mgr.action.EcsideAction;
import gnnt.MEBS.common.mgr.common.PageRequest;
import gnnt.MEBS.common.mgr.common.QueryConditions;
import gnnt.MEBS.vendue.mgr.model.commodity.hisCommodities.VHiscommodity;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

@Controller("hisCommoditiesAction")
@Scope("request")
public class HisCommoditiesAction
  extends EcsideAction
{
  private static final long serialVersionUID = 1L;
  @Resource(name="hisCommodity_bargainTypeMap")
  private Map<Byte, String> hisCommodity_bargainTypeMap;
  
  public Map<Byte, String> getHisCommodity_bargainTypeMap()
  {
    return this.hisCommodity_bargainTypeMap;
  }
  
  public void setHisCommodity_bargainTypeMap(Map<Byte, String> paramMap)
  {
    this.hisCommodity_bargainTypeMap = paramMap;
  }
  
  public String getHisCommodityList()
    throws Exception
  {
    VHiscommodity localVHiscommodity = (VHiscommodity)this.entity;
    String str1 = this.request.getParameter("tradepartition");
    if ((str1 != null) && (str1.length() > 0))
    {
      short s = Short.parseShort(str1);
      PageRequest localPageRequest = super.getPageRequest(this.request);
      QueryConditions localQueryConditions = (QueryConditions)localPageRequest.getFilters();
      localQueryConditions.addCondition("primary.tradepartition", "=", Short.valueOf(s));
      listByLimit(localPageRequest);
    }
    String str2 = this.request.getParameter("trademode");
    this.request.setAttribute("tradepartition", str1);
    this.request.setAttribute("trademode", str2);
    return "success";
  }
}
