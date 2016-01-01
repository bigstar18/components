package gnnt.MEBS.common.broker.action;

import gnnt.MEBS.checkLogon.vo.broker.BrokerAgeLogonResultVO;
import gnnt.MEBS.checkLogon.vo.broker.BrokerLogonResultVO;
import gnnt.MEBS.common.broker.common.ActiveUserManager;
import gnnt.MEBS.common.broker.common.Global;
import gnnt.MEBS.common.broker.common.ReturnValue;
import gnnt.MEBS.common.broker.model.Broker;
import gnnt.MEBS.common.broker.model.BrokerAge;
import gnnt.MEBS.common.broker.model.User;
import gnnt.MEBS.common.broker.service.BrokerAgeService;
import gnnt.MEBS.common.broker.service.BrokerService;
import gnnt.MEBS.common.broker.service.StandardService;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.commons.logging.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

@Controller("com_userAction")
@Scope("request")
public class UserAction
  extends EcsideAction
{
  private static final long serialVersionUID = -5214089712349011935L;
  @Autowired
  @Qualifier("com_brokerService")
  private BrokerService brokerService;
  @Autowired
  @Qualifier("com_brokerAgeService")
  private BrokerAgeService brokerAgeService;
  
  public void setEntityName(String entityName) {}
  
  public StandardService getBrokerService()
  {
    return this.brokerService;
  }
  
  public StandardService getBrokerAgeService()
  {
    return this.brokerAgeService;
  }
  
  public String logon()
    throws Exception
  {
    String randNumSys = (String)this.request.getSession().getAttribute(
      "RANDOMICITYNUM");
    
    String randNumInput = this.request.getParameter("randNumInput");
    
    String userId = this.request.getParameter("userId");
    
    String password = this.request.getParameter("password");
    if (randNumInput == null)
    {
      addReturnValue(-1, 131201L);
      return "error";
    }
    if ((randNumSys == null) || (
      (randNumSys != null) && (!randNumSys.toUpperCase().equals(
      randNumInput.toUpperCase()))))
    {
      addReturnValue(-1, 131202L);
      return "error";
    }
    Broker broker = null;
    BrokerAge brokerAge = null;
    String sql = "";
    String type = "";
    
    long sessionId = 0L;
    String logonType = Global.getSelfLogonType();
    if ((logonType == null) || (logonType.length() <= 0)) {
      logonType = Global.getSelfLogonType();
    }
    BrokerLogonResultVO vo = ActiveUserManager.brokerLogon(userId, password, this.request.getRemoteAddr(), Global.getSelfModuleID(), logonType);
    sessionId = vo.getSessionID();
    
    int result = vo.getResult();
    if (result != -1)
    {
      ActiveUserManager.brokerLogonSuccess(userId, this.request, sessionId, logonType);
    }
    else
    {
      BrokerAgeLogonResultVO bavo = ActiveUserManager.brokerAgeLogon(userId, password, this.request.getRemoteAddr(), Global.getSelfModuleID(), logonType);
      sessionId = bavo.getSessionID();
      
      result = bavo.getResult();
      if (result != -1) {
        ActiveUserManager.brokerAgeLogonSuccess(userId, this.request, sessionId, logonType);
      }
    }
    if (result == -1)
    {
      String recode = vo.getRecode().trim();
      if (("-1".equals(recode)) || ("-2".equals(recode))) {
        addReturnValue(-1, 131203L);
      } else if ("-3".equals(recode)) {
        addReturnValue(-1, 131205L);
      } else if ("-4".equals(recode)) {
        addReturnValue(-1, 131204L);
      } else if ("-6".equals(recode)) {
        addReturnValue(-1, 131207L);
      } else {
        addReturnValue(-1, 131206L, new Object[] { Long.valueOf(sessionId) });
      }
      return "error";
    }
    addReturnValue(1, 111201L);
    return "success";
  }
  
  public String updatePasswordSelfSave()
  {
    this.logger.debug("enter passwordSelfSave");
    String oldPassword = this.request.getParameter("oldPassword");
    String newPassword = this.request.getParameter("password");
    
    int result = -1;
    User user = (User)this.request.getSession().getAttribute(
      "CurrentUser");
    if (newPassword.equals(oldPassword))
    {
      addReturnValue(-1, 131301L);
      return "success";
    }
    if (user.getType().equals("0"))
    {
      Broker broker = user.getBroker();
      result = ActiveUserManager.BrokerChangePassword(
        broker.getBrokerId(), oldPassword, newPassword, 
        this.request.getRemoteAddr());
    }
    else
    {
      BrokerAge brokerAge = user.getBrokerAge();
      result = ActiveUserManager.BrokerAgeChangePassword(
        brokerAge.getBrokerAgeId(), oldPassword, newPassword, 
        this.request.getRemoteAddr());
    }
    if (result != 0) {
      addReturnValue(-1, 131302L);
    } else {
      addReturnValue(1, 111301L);
    }
    ReturnValue returnValue = (ReturnValue)this.request.getAttribute("ReturnValue");
    if (returnValue != null) {
      if (returnValue.getResult() == 1)
      {
        if (user.getType().equals("0")) {
          writeOperateLog(9901, "会员" + 
            user.getBroker().getBrokerId() + "修改密码", 1, "");
        } else {
          writeOperateLog(9901, "居间商" + 
            user.getBrokerAge().getBrokerAgeId() + "修改密码", 1, "");
        }
      }
      else if (user.getType().equals("0")) {
        writeOperateLog(9901, "会员" + 
          user.getBroker().getBrokerId() + "修改密码", 0, returnValue.getInfo());
      } else {
        writeOperateLog(9901, "居间商" + 
          user.getBrokerAge().getBrokerAgeId() + "修改密码", 0, returnValue.getInfo());
      }
    }
    return "success";
  }
  
  public String logout()
    throws Exception
  {
    User user = (User)this.request.getSession().getAttribute(
      "CurrentUser");
    if (user != null)
    {
      String type = "4".equals(user.getType()) ? "居间商" : "会员";
      if (user != null) {
        writeOperateLog(9901, type + 
          user.getUserId() + "退出", 1, "");
      }
      ActiveUserManager.logoff(this.request);
    }
    this.request.getSession().invalidate();
    return "success";
  }
  
  public String saveShinStyle()
  {
    this.logger.debug("enter modShinStyle");
    
    return "success";
  }
}
