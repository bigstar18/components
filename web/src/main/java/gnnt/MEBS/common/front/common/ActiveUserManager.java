package gnnt.MEBS.common.front.common;

import gnnt.MEBS.checkLogon.check.front.FrontCheck;
import gnnt.MEBS.checkLogon.vo.front.TraderLogonInfo;
import gnnt.MEBS.common.front.callbak.LogonCallbak;
import gnnt.MEBS.common.front.exception.CallbakErrorException;
import gnnt.MEBS.common.front.model.integrated.User;
import gnnt.MEBS.common.front.service.RightService;
import gnnt.MEBS.common.front.service.RoleService;
import gnnt.MEBS.common.front.service.UserService;
import gnnt.MEBS.common.front.statictools.ApplicationContextInit;
import gnnt.MEBS.common.front.statictools.Tools;
import gnnt.MEBS.logonServerUtil.au.LogonActualize;
import gnnt.MEBS.logonService.vo.CheckUserResultVO;
import gnnt.MEBS.logonService.vo.CheckUserVO;
import gnnt.MEBS.logonService.vo.GetUserResultVO;
import gnnt.MEBS.logonService.vo.GetUserVO;
import gnnt.MEBS.logonService.vo.ISLogonResultVO;
import gnnt.MEBS.logonService.vo.ISLogonVO;
import gnnt.MEBS.logonService.vo.LogoffVO;
import java.io.PrintStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class ActiveUserManager
{
  private static final transient Log logger = LogFactory.getLog(ActiveUserManager.class);
  
  public static GetUserResultVO getUser(long sessionID, String logonType, int selfModuleID)
  {
    GetUserResultVO result = null;
    try
    {
      GetUserVO getUserVO = new GetUserVO();
      getUserVO.setSessionID(sessionID);
      getUserVO.setLogonType(logonType);
      getUserVO.setModuleID(Integer.valueOf(selfModuleID));
      result = LogonActualize.getInstance().getUserBySessionID(getUserVO);
    }
    catch (Exception e)
    {
      logger.error("验证SessionID在AU中是否已经登录异常", e);
    }
    return result;
  }
  
  public static TraderLogonInfo logon(String user, String password, int moduleID, String keyCode, String trustKey, String logonIP, int logonUserType, String logonType)
    throws Exception
  {
    return FrontCheck.getInstance().logon(user, password, 
      moduleID, keyCode, trustKey, logonIP, logonUserType, logonType);
  }
  
  public static boolean logon(String traderID, HttpServletRequest request, long sessionID, String logonType, int selfModuleID)
  {
    boolean result = true;
    UserService userService = (UserService)ApplicationContextInit.getBean("com_userService");
    
    User logonUser = userService.getTraderByID(traderID);
    
    User user = (User)logonUser.clone();
    
    user.setSessionId(Long.valueOf(sessionID));
    
    user.setIpAddress(request.getRemoteAddr());
    user.setLogonType(logonType);
    user.setModuleID(Integer.valueOf(selfModuleID));
    
    boolean isSuperAdminRole = false;
    if ("A".equals(user.getType())) {
      isSuperAdminRole = true;
    }
    RoleService roleService = (RoleService)
      ApplicationContextInit.getBean("com_roleService");
    user.setRoleSet(roleService.getAllRole());
    
    RightService rightService = (RightService)
      ApplicationContextInit.getBean("com_rightService");
    user.setRightSet(rightService.getAllRight());
    
    request.getSession().invalidate();
    
    request.getSession()
      .setAttribute("IsSuperAdmin", Boolean.valueOf(isSuperAdminRole));
    
    request.getSession().setAttribute("CurrentUser", user);
    
    request.getSession().setAttribute("sessionID", Long.valueOf(sessionID));
    
    request.getSession().setAttribute("LogonType", logonType);
    
    String sessionExpireTime = 
      ApplicationContextInit.getConfig("SessionExpireTime");
    request.getSession().setMaxInactiveInterval(
      Tools.strToInt(sessionExpireTime, 120) * 60);
    try
    {
      LogonCallbak logonCallbak = null;
      try
      {
        logonCallbak = (LogonCallbak)ApplicationContextInit.getBean("logonCallbak");
      }
      catch (Exception e)
      {
        System.out.println("系统中没有配置登录回调函数。");
      }
      if (logonCallbak != null) {
        logonCallbak.logonSuccessCallbak(user, request);
      }
    }
    catch (CallbakErrorException e)
    {
      request.getSession().invalidate();
      result = false;
      logger.error("Action logon 方法进行登录后，执行登录回调，抛出自定义异常：", e);
    }
    catch (Exception e)
    {
      request.getSession().invalidate();
      result = false;
      logger.error("Action logon 方法进行登录后，执行登录回调，异常：", e);
    }
    return result;
  }
  
  public static int changePassowrd(String userID, String oldPassword, String newPassword, String logonIP)
  {
    return FrontCheck.getInstance().changePassowrd(
      userID, oldPassword, newPassword, logonIP);
  }
  
  public static void logoff(HttpServletRequest request)
    throws Exception
  {
    User user = (User)request.getSession().getAttribute("CurrentUser");
    
    request.getSession().invalidate();
    if (user != null)
    {
      LogoffVO logoffVO = new LogoffVO();
      logoffVO.setSessionID(user.getSessionId().longValue());
      logoffVO.setUserID(user.getTraderID());
      
      logoffVO.setLogonType(user.getLogonType());
      logoffVO.setModuleID(user.getModuleID().intValue());
      LogonActualize.getInstance().logoff(logoffVO);
    }
  }
  
  public static ISLogonResultVO isLogon(String userID, long sessionID, String logonType, int selfModuleID)
    throws Exception
  {
    ISLogonVO iSLogonVO = new ISLogonVO();
    iSLogonVO.setUserID(userID);
    iSLogonVO.setModuleID(Integer.valueOf(selfModuleID));
    iSLogonVO.setSessionID(sessionID);
    iSLogonVO.setLogonType(logonType);
    ISLogonResultVO iSLogonResultVO = LogonActualize.getInstance().isLogon(iSLogonVO);
    
    return iSLogonResultVO;
  }
  
  public static boolean checkModuleRight(String userID)
  {
    return FrontCheck.getInstance().checkModuleRight(userID, Global.getSelfModuleID());
  }
  
  public static CheckUserResultVO checkUser(String userID, long sessionID, int fromModuleID, String selfLogonType, String fromLogonType, int selfModuleID)
  {
    CheckUserResultVO checkUserResultVO = new CheckUserResultVO();
    CheckUserVO checkUserVO = new CheckUserVO();
    checkUserVO.setUserID(userID);
    checkUserVO.setSessionID(sessionID);
    checkUserVO.setToModuleID(selfModuleID);
    checkUserVO.setLogonType(selfLogonType);
    checkUserResultVO = LogonActualize.getInstance().checkUser(checkUserVO, fromModuleID, fromLogonType);
    return checkUserResultVO;
  }
}
