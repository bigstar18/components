package gnnt.MEBS.espot.mgr.action.parametermanage;

import gnnt.MEBS.common.mgr.action.EcsideAction;
import gnnt.MEBS.common.mgr.common.Page;
import gnnt.MEBS.common.mgr.common.PageRequest;
import gnnt.MEBS.common.mgr.service.StandardService;
import gnnt.MEBS.espot.mgr.model.commoditymanage.Category;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

@Controller("specialFeeOrMarginAction")
@Scope("request")
public class SpecialFeeOrMarginAction
  extends EcsideAction
{
  private static final long serialVersionUID = 1L;
  @Resource(name="sysPropsMap")
  private Map<String, String> sysPropsMap;
  
  public Map<String, String> getSysPropsMap()
  {
    return this.sysPropsMap;
  }
  
  public String forwardAddTradeFee()
  {
    PageRequest localPageRequest = new PageRequest(" and primary.categoryId!=-1 and primary.type='leaf' and primary.status=1 and primary.belongModule like '%23%' order by primary.parentCategory.sortNo, primary.sortNo");
    localPageRequest.setPageSize(10000);
    Page localPage = getService().getPage(localPageRequest, new Category());
    this.request.setAttribute("page", localPage);
    return "success";
  }
}
