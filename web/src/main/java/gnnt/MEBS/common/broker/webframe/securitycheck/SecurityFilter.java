package gnnt.MEBS.common.broker.webframe.securitycheck;

import gnnt.MEBS.common.broker.common.ActiveUserManager;
import gnnt.MEBS.common.broker.common.Global;
import gnnt.MEBS.common.broker.model.Broker;
import gnnt.MEBS.common.broker.model.BrokerAge;
import gnnt.MEBS.common.broker.model.User;
import gnnt.MEBS.common.broker.statictools.ApplicationContextInit;
import gnnt.MEBS.common.broker.statictools.Tools;
import gnnt.MEBS.logonService.vo.CheckUserResultVO;
import gnnt.MEBS.logonService.vo.CheckUserVO;
import gnnt.MEBS.logonService.vo.ISLogonResultVO;
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
import org.ecside.util.RequestUtils;

public class SecurityFilter
  implements Filter
{
  private static final long serialVersionUID = -1672503674085645491L;
  private static Object syncObject = new Object();
  
  public void destroy() {}
  
  public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
    throws IOException, ServletException
  {
    HttpServletRequest request = (HttpServletRequest)req;
    HttpServletResponse response = (HttpServletResponse)res;
    if (RequestUtils.isAJAXRequest(request))
    {
      request.setCharacterEncoding("UTF-8");
      
      request.getParameter("");
    }
    if ((request.getHeader("X-Requested-With") != null) && 
      (request.getHeader("X-Requested-With").equalsIgnoreCase(
      "XMLHttpRequest")))
    {
      request.setCharacterEncoding("UTF-8");
      
      request.getParameter("");
    }
    else
    {
      request.setCharacterEncoding("GBK");
    }
    String contextPath = request.getContextPath();
    
    String url = request.getServletPath();
    if ((url.equals("/frameset")) || (url.equals("/output")))
    {
      String statisticsPath = request.getParameter("__report");
      url = statisticsPath;
    }
    String loginURL = ApplicationContextInit.getConfig("LoginURL");
    
    String noRightURL = ApplicationContextInit.getConfig("NoRightURL");
    
    UrlCheck urlCheck = (UrlCheck)
      ApplicationContextInit.getBean("urlCheck");
    
    User user = (User)request.getSession()
      .getAttribute("CurrentUser");
    if (user != null) {
      if (request.getParameter("sessionID") != null)
      {
        Long sessionID = Long.valueOf(Tools.strToLong(request.getParameter("sessionID")));
        if (user.getType().equals("0"))
        {
          if (!sessionID.equals(Long.valueOf(user.getSessionId()))) {
            synchronized (syncObject)
            {
              ISLogonResultVO au = null;
              try
              {
                au = ActiveUserManager.isLogon(user.getUserId(), sessionID.longValue(), Global.getSelfModuleID(), user.getLogonType());
              }
              catch (Exception e)
              {
                e.printStackTrace();
              }
              if ((au != null) && (au.getUserManageVO().getUserID().equals(user.getBroker().getBrokerId())))
              {
                user.setSessionId(sessionID.longValue());
                user.getBroker().setSessionId(sessionID.longValue());
              }
              else
              {
                user = null;
                request.getSession().invalidate();
              }
            }
          }
        }
        else if (!sessionID.equals(Long.valueOf(user.getSessionId()))) {
          synchronized (syncObject)
          {
            ISLogonResultVO au = null;
            try
            {
              au = ActiveUserManager.isLogon(user.getUserId(), sessionID.longValue(), Global.getSelfModuleID(), user.getLogonType());
            }
            catch (Exception e)
            {
              e.printStackTrace();
            }
            if ((au != null) && (au.getUserManageVO().getUserID().equals(user.getBrokerAge().getBrokerAgeId())))
            {
              user.setSessionId(sessionID.longValue());
              user.getBrokerAge().setSessionId(sessionID.longValue());
            }
            else
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
        user = (User)request.getSession()
          .getAttribute("CurrentUser");
        if (user == null)
        {
          Long sessionID = null;
          
          String type = "";
          if (request.getParameter("sessionID") != null) {
            sessionID = Long.valueOf(Tools.strToLong(request
              .getParameter("sessionID")));
          }
          if (request.getParameter("CurrentUserType") != null) {
            type = 
              request.getParameter("CurrentUserType");
          }
          String selflogontype = request.getParameter("LogonType");
          if ((selflogontype == null) || (selflogontype.length() <= 0)) {
            selflogontype = Global.getSelfLogonType();
          }
          if (sessionID != null)
          {
            CheckUserVO checkUserVO = new CheckUserVO();
            checkUserVO.setSessionID(sessionID.longValue());
            checkUserVO.setUserID(request.getParameter("userID"));
            checkUserVO.setToModuleID(Global.getSelfModuleID());
            checkUserVO.setLogonType(selflogontype);
            
            int fromModuleID = Tools.strToInt(request.getParameter("FromModuleID"));
            
            String fromLogonType = request.getParameter("FromLogonType");
            
            CheckUserResultVO au = ActiveUserManager.checkUser(checkUserVO, fromModuleID, fromLogonType);
            if (type.equals("0"))
            {
              if ((au != null) && (au.getResult() == 1))
              {
                ActiveUserManager.brokerLogonSuccess(au.getUserManageVO().getUserID(), request, au.getUserManageVO().getSessionID(), au.getUserManageVO().getLogonType());
                user = (User)request.getSession().getAttribute("CurrentUser");
              }
            }
            else if ((au != null) && (au.getResult() == 1))
            {
              ActiveUserManager.brokerAgeLogonSuccess(au.getUserManageVO().getUserID(), request, au.getUserManageVO().getSessionID(), au.getUserManageVO().getLogonType());
              user = (User)request.getSession().getAttribute("CurrentUser");
            }
          }
        }
      }
    }
    UrlCheckResult urlCheckResult = urlCheck.check(url, user);
    switch (urlCheckResult)
    {
    case AUOVERTIME: 
    case AUUSERKICK: 
      chain.doFilter(req, res);
      break;
    case NEEDLESSCHECK: 
      response.sendRedirect(contextPath + loginURL + "?" + 
        "reason" + "=" + urlCheckResult);
      break;
    case NEEDLESSCHECKRIGHT: 
      response.sendRedirect(contextPath + loginURL + "?" + 
        "reason" + "=" + urlCheckResult);
      break;
    case NOPURVIEW: 
      response.sendRedirect(contextPath + loginURL + "?" + 
        "reason" + "=" + urlCheckResult);
      break;
    case SUCCESS: 
      request.getRequestDispatcher(noRightURL).forward(req, res);
      break;
    case USERISNULL: 
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
