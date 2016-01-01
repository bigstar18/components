package gnnt.MEBS.vendue.mgr.beanforajax;

import com.opensymphony.xwork2.ActionContext;
import gnnt.MEBS.common.mgr.beanforajax.BaseAjax;
import gnnt.MEBS.common.mgr.service.StandardService;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.logging.Log;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

@Controller("ajaxCheckCurCommodity")
@Scope("request")
public class AjaxCheckCurCommodity
  extends BaseAjax
{
  public String formCheckSection()
  {
    this.logger.debug("enter ajax for check--------------------section----------------------- ");
    try
    {
      ActionContext localActionContext = ActionContext.getContext();
      HttpServletRequest localHttpServletRequest = (HttpServletRequest)localActionContext.get("com.opensymphony.xwork2.dispatcher.HttpServletRequest");
      Short localShort = new Short(localHttpServletRequest.getParameter("partitionid"));
      Integer localInteger = new Integer(localHttpServletRequest.getParameter("section"));
      boolean bool = false;
      String str = "select v.section section from v_syscurstatus v where v.status in (2,3,4,9) and v.tradepartition = '" + localShort + "'";
      List localList = getService().getListBySql(str);
      if (localList.size() != 0)
      {
        if (localInteger.intValue() > Integer.parseInt(((Map)localList.get(0)).get("SECTION").toString())) {
          bool = true;
        }
      }
      else {
        bool = true;
      }
      this.logger.debug(Integer.valueOf(localList.size()));
      this.jsonValidateReturn = createJSONArray(new Object[] { Boolean.valueOf(bool) });
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
    }
    return "success";
  }
}
