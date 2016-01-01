package gnnt.MEBS.vendue.mgr.beanforajax;

import gnnt.MEBS.common.mgr.beanforajax.BaseAjax;
import gnnt.MEBS.common.mgr.service.StandardService;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.logging.Log;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

@Controller("ajaxQueryFlowControl")
@Scope("request")
public class AjaxQueryFlowControl
  extends BaseAjax
{
  public String listBreedProperty()
  {
    this.logger.debug("enter ajaxquery for breedPropertyList");
    try
    {
      HttpServletRequest localHttpServletRequest = getRequest();
      String str1 = localHttpServletRequest.getParameter("breedId");
      if (str1 != null)
      {
        String str2 = "select p.propertyid,p.propertyname from m_breed m ,m_property p where m.categoryid = p.categoryid and m.breedid = " + str1 + " order by p.propertyid";
        List localList = getService().getListBySql(str2);
        Map[] arrayOfMap = new Map[localList.size()];
        for (int i = 0; i < localList.size(); i++) {
          arrayOfMap[i] = ((Map)localList.get(i));
        }
        this.jsonValidateReturn = createJSONArray(arrayOfMap);
      }
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
    }
    return "success";
  }
}
