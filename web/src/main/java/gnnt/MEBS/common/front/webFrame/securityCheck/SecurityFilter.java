package gnnt.MEBS.common.front.webFrame.securityCheck;

import gnnt.MEBS.common.front.common.ActiveUserManager;
import gnnt.MEBS.common.front.common.Global;
import gnnt.MEBS.common.front.model.integrated.User;
import gnnt.MEBS.common.front.statictools.ApplicationContextInit;
import gnnt.MEBS.common.front.statictools.Tools;
import gnnt.MEBS.logonService.vo.CheckUserResultVO;
import gnnt.MEBS.logonService.vo.UserManageVO;
import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class SecurityFilter
  implements Filter
{
  private static Object syncObject = new Object();
  
  public void destroy() {}
  
  public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
    throws IOException, ServletException
  {
    HttpServletRequest request = (HttpServletRequest)req;
    HttpServletResponse response = (HttpServletResponse)res;
    if ((request.getHeader("X-Requested-With") != null) && 
      (request.getHeader("X-Requested-With").equalsIgnoreCase(
      "XMLHttpRequest"))) {
      request.setCharacterEncoding("UTF-8");
    } else {
      request.setCharacterEncoding("GBK");
    }
    request.getParameter("");
    
    String contextPath = request.getContextPath();
    
    String url = request.getServletPath();
    
    String loginURL = ApplicationContextInit.getConfig("LoginURL");
    
    String noRightURL = ApplicationContextInit.getConfig("NoRightURL");
    
    String noModuleRightURL = ApplicationContextInit.getConfig("NoModuleRightURL");
    
    UrlCheck urlCheck = (UrlCheck)
      ApplicationContextInit.getBean("urlCheck");
    
    User user = (User)request.getSession()
      .getAttribute("CurrentUser");
    if (user != null)
    {
      String par_v = request.getParameter("sessionID");
      if (par_v != null)
      {
        Long sessionID = Long.valueOf(Tools.strToLong(par_v));
        if (!sessionID.equals(user.getSessionId())) {
          synchronized (syncObject)
          {
            user = (User)request.getSession()
              .getAttribute("CurrentUser");
            if ((user != null) && (!sessionID.equals(user.getSessionId())))
            {
              user = null;
              request.getSession().invalidate();
            }
          }
        }
      }
    }
    if (user == null) {
      synchronized (syncObject)
      {
        long sessionID = Tools.strToLong(request.getParameter("sessionID"), -1L);
        int fromModuleID = Tools.strToInt(request.getParameter("FromModuleID"), -1);
        String userID = request.getParameter("userID");
        if ((sessionID > 0L) && (fromModuleID > 0))
        {
          String fromLogonType = request.getParameter("FromLogonType");
          String selfLogonType = request.getParameter("LogonType");
          if ((selfLogonType == null) || (selfLogonType.trim().length() == 0)) {
            selfLogonType = Global.getSelfLogonType();
          }
          int selfModuleID = Tools.strToInt(request.getParameter("ModuleID"), Global.getSelfModuleID());
          CheckUserResultVO au = ActiveUserManager.checkUser(userID, sessionID, fromModuleID, selfLogonType, fromLogonType, selfModuleID);
          if (au.getUserManageVO() != null)
          {
            boolean logonSuccess = ActiveUserManager.logon(au.getUserManageVO().getUserID(), request, au.getUserManageVO().getSessionID(), selfLogonType, selfModuleID);
            if (logonSuccess) {
              user = (User)request.getSession().getAttribute("CurrentUser");
            }
          }
        }
      }
    }
    request.setAttribute("currenturl", url);
    
    UrlCheckResult urlCheckResult = urlCheck.check(url, user);
    
    String preUrl = (String)request.getSession().getAttribute("currentRealPath");
    switch (urlCheckResult)
    {
    case AUOVERTIME: 
    case AUUSERKICK: 
      if ((user == null) && (preUrl != null))
      {
        String msg = request.getParameter("errorMsg");
        if ((msg != null) && (!msg.equals(""))) {
          request.setAttribute("msg", msg);
        }
      }
      chain.doFilter(req, res);
      break;
    case NEEDLESSCHECK: 
      response.sendRedirect(contextPath + loginURL + "?" + 
        "reason" + "=" + urlCheckResult + "&" + 
        "preUrl" + "=" + preUrl);
      
      break;
    case NEEDLESSCHECKRIGHT: 
      response.sendRedirect(contextPath + loginURL + "?" + 
        "reason" + "=" + urlCheckResult + "&" + 
        "preUrl" + "=" + preUrl);
      break;
    case NOMODULEPURVIEW: 
      response.sendRedirect(contextPath + loginURL + "?" + 
        "reason" + "=" + urlCheckResult + "&" + 
        "preUrl" + "=" + preUrl);
      break;
    case NOPURVIEW: 
      request.getRequestDispatcher(noRightURL).forward(req, res);
      break;
    case USERISNULL: 
      request.getRequestDispatcher(noModuleRightURL).forward(req, res);
      break;
    case SUCCESS: 
      chain.doFilter(req, res);
      break;
    default: 
      response.sendRedirect(contextPath + loginURL + "?" + 
        "reason" + "=" + urlCheckResult);
    }
  }
  
  public void init(FilterConfig filterConfig)
    throws ServletException
  {}
}
