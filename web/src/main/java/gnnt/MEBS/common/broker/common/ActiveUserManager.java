package gnnt.MEBS.common.broker.common;

import gnnt.MEBS.checkLogon.check.broker.BrokerAgeCheck;
import gnnt.MEBS.checkLogon.check.broker.BrokerCheck;
import gnnt.MEBS.checkLogon.vo.broker.BrokerAgeLogonResultVO;
import gnnt.MEBS.checkLogon.vo.broker.BrokerLogonResultVO;
import gnnt.MEBS.common.broker.model.Broker;
import gnnt.MEBS.common.broker.model.BrokerAge;
import gnnt.MEBS.common.broker.model.User;
import gnnt.MEBS.common.broker.service.BrokerAgeService;
import gnnt.MEBS.common.broker.service.BrokerService;
import gnnt.MEBS.common.broker.statictools.ApplicationContextInit;
import gnnt.MEBS.common.broker.statictools.Tools;
import gnnt.MEBS.logonServerUtil.au.LogonActualize;
import gnnt.MEBS.logonService.vo.CheckUserResultVO;
import gnnt.MEBS.logonService.vo.CheckUserVO;
import gnnt.MEBS.logonService.vo.GetUserResultVO;
import gnnt.MEBS.logonService.vo.GetUserVO;
import gnnt.MEBS.logonService.vo.ISLogonResultVO;
import gnnt.MEBS.logonService.vo.ISLogonVO;
import gnnt.MEBS.logonService.vo.LogoffVO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class ActiveUserManager
{
  private static final transient Log logger = LogFactory.getLog(ActiveUserManager.class);
  
  public static GetUserResultVO getUser(long sessionID, String logonType)
  {
    GetUserResultVO result = null;
    GetUserVO userVO = new GetUserVO();
    userVO.setLogonType(logonType);
    userVO.setModuleID(Integer.valueOf(Global.getSelfModuleID()));
    userVO.setSessionID(sessionID);
    try
    {
      result = LogonActualize.getInstance().getUserBySessionID(userVO);
    }
    catch (Exception e)
    {
      logger.error("验证SessionID在AU中是否已经登录异常", e);
    }
    return result;
  }
  
  public static BrokerLogonResultVO brokerLogon(String userID, String password, String logonIP, int selfModuleID, String logonType)
    throws Exception
  {
    return BrokerCheck.getInstance().logon(userID, password, logonIP, selfModuleID, logonType);
  }
  
  public static BrokerAgeLogonResultVO brokerAgeLogon(String userID, String password, String logonIP, int selfModuleID, String logonType)
    throws Exception
  {
    return BrokerAgeCheck.getInstance().logon(userID, password, logonIP, selfModuleID, logonType);
  }
  
  public static boolean brokerLogonSuccess(String userId, HttpServletRequest request, long sessionID, String logonType)
  {
    boolean result = false;
    
    BrokerService brokerService = (BrokerService)ApplicationContextInit.getBean("com_brokerService");
    
    Broker broker = (Broker)brokerService.getBrokerByID(userId).clone();
    if (broker == null) {
      return result;
    }
    String sql = "select firmId from br_firmandbroker where brokerId = '" + userId + "'";
    
    broker.setSessionId(sessionID);
    
    broker.setIpAddress(request.getRemoteAddr());
    
    User user = new User();
    user.setUserId(userId);
    user.setLogonType(logonType);
    
    user.setBroker(broker);
    
    user.setSql(sql);
    user.setType("0");
    user.setSessionId(sessionID);
    
    request.getSession().invalidate();
    
    request.getSession().setAttribute("CurrentUserType", Integer.valueOf(0));
    
    request.getSession().setAttribute("CurrentUser", user);
    
    request.getSession().setAttribute("sessionID", Long.valueOf(sessionID));
    
    request.getSession().setAttribute("LogonType", logonType);
    
    request.getSession().setAttribute("LOGONIP", user.getIpAddress());
    
    String sessionExpireTime = ApplicationContextInit.getConfig("SessionExpireTime");
    request.getSession().setMaxInactiveInterval(Tools.strToInt(sessionExpireTime, 120) * 60);
    
    result = true;
    
    return result;
  }
  
  public static boolean brokerAgeLogonSuccess(String userId, HttpServletRequest request, long sessionID, String logonType)
  {
    boolean result = false;
    
    BrokerAgeService brokerAgeService = (BrokerAgeService)ApplicationContextInit.getBean("com_brokerAgeService");
    
    BrokerAge brokerAge = (BrokerAge)brokerAgeService.getBrokerAgeByID(userId).clone();
    if (brokerAge == null) {
      return result;
    }
    String sql = "select firmId from br_brokerageandfirm  where brokerageid = '" + userId + "'";
    
    brokerAge.setSessionId(sessionID);
    
    brokerAge.setIpAddress(request.getRemoteAddr());
    
    User user = new User();
    user.setUserId(userId);
    user.setLogonType(logonType);
    
    user.setBrokerAge(brokerAge);
    user.setSql(sql);
    user.setType("4");
    user.setSessionId(sessionID);
    
    request.getSession().invalidate();
    
    request.getSession().setAttribute("CurrentUserType", Integer.valueOf(0));
    
    request.getSession().setAttribute("CurrentUser", user);
    
    request.getSession().setAttribute("sessionID", Long.valueOf(sessionID));
    
    request.getSession().setAttribute("LogonType", logonType);
    
    request.getSession().setAttribute("LOGONIP", user.getIpAddress());
    
    String sessionExpireTime = ApplicationContextInit.getConfig("SessionExpireTime");
    request.getSession().setMaxInactiveInterval(Tools.strToInt(sessionExpireTime, 120) * 60);
    
    result = true;
    
    return result;
  }
  
  public static int BrokerAgeChangePassword(String userID, String oldPassword, String newPassword, String logonIP)
  {
    return BrokerAgeCheck.getInstance().changePassword(
      userID, oldPassword, newPassword, logonIP);
  }
  
  public static int BrokerChangePassword(String userID, String oldPassword, String newPassword, String logonIP)
  {
    return BrokerCheck.getInstance().changePassowrd(
      userID, oldPassword, newPassword, logonIP);
  }
  
  public static void logoff(HttpServletRequest request)
    throws Exception
  {
    User user = (User)request.getSession().getAttribute("CurrentUser");
    
    request.getSession().invalidate();
    if (user != null)
    {
      LogoffVO vo = new LogoffVO();
      vo.setUserID(user.getUserId());
      vo.setSessionID(user.getSessionId());
      vo.setLogonType(user.getLogonType());
      LogonActualize.getInstance().logoff(vo);
    }
  }
  
  public static ISLogonResultVO isLogon(String userID, long sessionID, int moduleID, String logonType)
    throws Exception
  {
    ISLogonVO isLogonVO = new ISLogonVO();
    isLogonVO.setUserID(userID);
    isLogonVO.setModuleID(Integer.valueOf(moduleID));
    isLogonVO.setSessionID(sessionID);
    isLogonVO.setLogonType(logonType);
    return LogonActualize.getInstance().isLogon(isLogonVO);
  }
  
  public static CheckUserResultVO checkUser(CheckUserVO checkUserVO, int fromModuleID, String fromLogonType)
  {
    return LogonActualize.getInstance().checkUser(checkUserVO, fromModuleID, fromLogonType);
  }
}
