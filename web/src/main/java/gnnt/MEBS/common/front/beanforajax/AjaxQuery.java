package gnnt.MEBS.common.front.beanforajax;

import gnnt.MEBS.common.front.common.Page;
import gnnt.MEBS.common.front.common.PageRequest;
import gnnt.MEBS.common.front.common.QueryConditions;
import gnnt.MEBS.common.front.model.StandardModel;
import gnnt.MEBS.common.front.model.integrated.User;
import gnnt.MEBS.common.front.service.StandardService;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

@Controller("com_ajaxQuery")
@Scope("request")
public class AjaxQuery
  extends BaseAjax
{
  private User getTraderUserID(String userID)
  {
    QueryConditions qc = new QueryConditions();
    qc.addCondition("userID", "=", userID);
    PageRequest<QueryConditions> pageRequest = new PageRequest(1, 2, qc, "");
    
    Page<StandardModel> page = getService().getPage(pageRequest, new User());
    if ((page != null) && (page.getResult() != null) && (page.getResult().size() > 0)) {
      return (User)page.getResult().get(0);
    }
    return null;
  }
  
  public String getTraderIDByUserID()
  {
    HttpServletRequest request = getRequest();
    String userID = request.getParameter("userID");
    if (userID != null)
    {
      User user = getTraderUserID(userID);
      if (user != null) {
        this.jsonValidateReturn = createJSONArray(new Object[] { user.getTraderID() });
      }
    }
    return "success";
  }
}
