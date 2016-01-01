package gnnt.MEBS.common.front.beanforajax;

import gnnt.MEBS.common.front.common.ActiveUserManager;
import gnnt.MEBS.common.front.common.Global;
import gnnt.MEBS.common.front.model.integrated.User;
import gnnt.MEBS.common.front.service.StandardService;
import gnnt.MEBS.common.front.statictools.Tools;
import gnnt.MEBS.logonService.vo.CheckUserResultVO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.commons.logging.Log;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

@Controller("com_ajaxForCommunications")
@Scope("request")
public class AjaxForCommunications
  extends BaseAjax
{
  public String changeStyle()
  {
    HttpServletRequest request = getRequest();
    
    User user = (User)request.getSession().getAttribute(
      "CurrentUser");
    if (user != null)
    {
      User user2 = (User)getService().get(user);
      if ((user2 != null) && (user2.getSkin() != null)) {
        user.setSkin(user2.getSkin());
      }
      request.getSession().setAttribute("CurrentUser", user);
    }
    this.jsonValidateReturn = createJSONArray(new Object[] { Boolean.valueOf(true) });
    
    return result();
  }
  
  public String logout()
  {
    try
    {
      ActiveUserManager.logoff(getRequest());
    }
    catch (Exception localException) {}
    this.jsonValidateReturn = createJSONArray(new Object[] { Boolean.valueOf(true) });
    
    return result();
  }
  
  public String sessionGetUser()
  {
    HttpServletRequest request = getRequest();
    
    User user = (User)request.getSession().getAttribute(
      "CurrentUser");
    if (user == null)
    {
      this.jsonValidateReturn = createJSONArray(new Object[] { Boolean.valueOf(false), "用户信息为空，并且未重新加载" });
      this.logger.error("用户信息为空，并且未重新加载");
    }
    else
    {
      int fromModuleID = Tools.strToInt(request.getParameter("FromModuleID"), -1);
      if (fromModuleID > 0)
      {
        String fromLogonType = request.getParameter("FromLogonType");
        String selfLogonType = request.getParameter("LogonType");
        if ((selfLogonType == null) || (selfLogonType.trim().length() <= 0)) {
          selfLogonType = Global.getSelfLogonType();
        }
        CheckUserResultVO checkUserResultVO = 
          ActiveUserManager.checkUser(user.getTraderID(), user.getSessionId().longValue(), fromModuleID, selfLogonType, fromLogonType, user.getModuleID().intValue());
        if (checkUserResultVO.getUserManageVO() != null)
        {
          this.jsonValidateReturn = createJSONArray(new Object[] { Boolean.valueOf(true) });
          return result();
        }
      }
      this.jsonValidateReturn = createJSONArray(new Object[] { Boolean.valueOf(false), "来源au编号或者登录类型为空" });
      this.logger.error("来源au编号或者登录类型为空");
    }
    return result();
  }
}
