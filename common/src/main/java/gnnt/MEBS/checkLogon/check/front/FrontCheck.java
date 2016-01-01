package gnnt.MEBS.checkLogon.check.front;

import gnnt.MEBS.checkLogon.check.BaseCheck;
import gnnt.MEBS.checkLogon.dao.front.FrontCheckDAO;
import gnnt.MEBS.checkLogon.po.front.DictionaryPO;
import gnnt.MEBS.checkLogon.po.front.TraderPO;
import gnnt.MEBS.checkLogon.util.MD5;
import gnnt.MEBS.checkLogon.util.Tool;
import gnnt.MEBS.checkLogon.vo.front.TraderLogonInfo;
import gnnt.MEBS.logonServerUtil.au.LogonActualize;
import gnnt.MEBS.logonService.vo.LogonResultVO;
import gnnt.MEBS.logonService.vo.LogonVO;
import gnnt.MEBS.logonService.vo.UserManageVO;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.sql.DataSource;
import org.apache.commons.logging.Log;

public class FrontCheck
  extends BaseCheck
{
  private int COMMONMODULEID = 99;
  private int LOG_MANAGE_OPERATORTYPR = 3201;
  private int PWD_MANAGE_OPERATORTYPR = 3202;
  private static volatile FrontCheck instance;
  private FrontCheckDAO frontCheckDAO;
  private int maxErrorLogonTimes = -1;
  
  private FrontCheck(DataSource dataSource)
  {
    this.frontCheckDAO = new FrontCheckDAO();
    this.frontCheckDAO.setDataSource(dataSource);
    
    DictionaryPO maxErrorLogonTimesPO = this.frontCheckDAO.getDictionaryByKey("FrontMaxErrorLogonTimes");
    if (maxErrorLogonTimesPO == null) {
      this.logger.info("字典表中没有配置最大错误登录次数，默认为不限错误登录次数");
    } else {
      this.maxErrorLogonTimes = Tool.strToInt(maxErrorLogonTimesPO.getValue(), -1);
    }
  }
  
  public static FrontCheck createInstance(DataSource dataSource)
  {
    if (instance == null) {
      synchronized (FrontCheck.class)
      {
        if (instance == null) {
          instance = new FrontCheck(dataSource);
        }
      }
    }
    return instance;
  }
  
  public static FrontCheck getInstance()
  {
    return instance;
  }
  
  public TraderLogonInfo logon(String userID, String password, int moduleID, String key, String trustKey, String logonIP, int userIDType, String logonType)
  {
    TraderLogonInfo result = new TraderLogonInfo();
    result.setResult(-1);
    try
    {
      String traderID = userID;
      if (userIDType == 1) {
        traderID = this.frontCheckDAO.getTraderIDByUserID(userID);
      }
      TraderPO trader = this.frontCheckDAO.getTraderByID(traderID);
      if (trader == null)
      {
        result.setRecode("-1");
        result.setMessage("交易员不存在");
        this.logger.info("用户[" + userID + "]交易员代码[" + traderID + "]登录失败，返回信息：" + result.getMessage());
        return result;
      }
      if (("Y".equalsIgnoreCase(trader.getEnableKey())) && (!trader.getKeyCode().equals(key)))
      {
        result.setRecode("-4");
        result.setMessage("key 盘数据不正确");
        this.frontCheckDAO.addGlobalLog(traderID, logonIP, this.LOG_MANAGE_OPERATORTYPR, "登录失败：" + result.getMessage(), 0);
        this.logger.info("用户[" + userID + "]交易员代码[" + traderID + "]登录失败，返回信息：" + result.getMessage());
        return result;
      }
      int errorLogonNum = this.frontCheckDAO.getErrorLoginErrorNum(traderID);
      if ((trader.getTrustKey() == null) || (trader.getTrustKey().trim().length() <= 0) || (!trader.getTrustKey().equals(trustKey))) {
        if ((this.maxErrorLogonTimes > 0) && (errorLogonNum > this.maxErrorLogonTimes))
        {
          result.setRecode("-3");
          result.setMessage("密码输入错误次数过多");
          this.frontCheckDAO.addGlobalLog(traderID, logonIP, this.LOG_MANAGE_OPERATORTYPR, "登录失败：" + result.getMessage(), 0);
          this.logger.info("用户[" + userID + "]交易员代码[" + traderID + "]登录失败，返回信息：" + result.getMessage());
          return result;
        }
      }
      String inputPwd = MD5.getMD5(traderID, password);
      if (!inputPwd.equals(trader.getPassword()))
      {
        result.setRecode("-2");
        result.setMessage("密码不正确");
        this.frontCheckDAO.insertErrorLoginlog(traderID, moduleID, logonIP);
        this.frontCheckDAO.addGlobalLog(traderID, logonIP, this.LOG_MANAGE_OPERATORTYPR, "登录失败：" + result.getMessage(), 0);
        this.logger.info("用户[" + userID + "]交易员代码[" + traderID + "]登录失败，返回信息：" + result.getMessage());
        return result;
      }
      if (!"N".equalsIgnoreCase(trader.getStatus()))
      {
        result.setRecode("-6");
        result.setMessage("交易员当前不可用");
        this.frontCheckDAO.addGlobalLog(traderID, logonIP, this.LOG_MANAGE_OPERATORTYPR, "登录失败：" + result.getMessage(), 0);
        this.logger.info("用户[" + userID + "]交易员代码[" + traderID + "]登录失败，返回信息：" + result.getMessage());
        return result;
      }
      String firmStatus = this.frontCheckDAO.getFirmStatus(trader.getFirmID());
      if (!"N".equalsIgnoreCase(firmStatus))
      {
        result.setRecode("-7");
        result.setMessage("交易商当前不可用");
        this.frontCheckDAO.addGlobalLog(traderID, logonIP, this.LOG_MANAGE_OPERATORTYPR, "登录失败：" + result.getMessage(), 0);
        this.logger.info("用户[" + userID + "]交易员代码[" + traderID + "]登录失败，返回信息：" + result.getMessage());
        return result;
      }
      if (moduleID != this.COMMONMODULEID)
      {
        String traderModule = this.frontCheckDAO.getTraderModuleEnable(traderID, moduleID);
        if (!"Y".equalsIgnoreCase(traderModule))
        {
          result.setRecode("-5");
          result.setMessage("交易员没有模块" + moduleID + "权限");
          this.frontCheckDAO.addGlobalLog(traderID, logonIP, this.LOG_MANAGE_OPERATORTYPR, "登录失败：" + result.getMessage(), 0);
          this.logger.info("用户[" + userID + "]交易员代码[" + traderID + "]登录失败，返回信息：" + result.getMessage());
          return result;
        }
      }
      LogonVO logonVO = new LogonVO();
      logonVO.setLogonType(logonType);
      logonVO.setModuleID(moduleID);
      logonVO.setUserID(traderID);
      logonVO.setLogonIp(logonIP);
      
      LogonResultVO rv = LogonActualize.getInstance().logon(logonVO);
      if (rv.getResult() != 1)
      {
        result.setRecode(rv.getRecode());
        result.setMessage(rv.getMessage());
        this.frontCheckDAO.addGlobalLog(traderID, logonIP, this.LOG_MANAGE_OPERATORTYPR, "登录失败：" + result.getMessage(), 0);
        this.logger.info("用户[" + userID + "]交易员代码[" + traderID + "]登录失败，返回信息：" + result.getMessage());
        return result;
      }
      result.setFirmId(trader.getFirmID());
      result.setFirmName(trader.getFirmName());
      result.setForceChangePwd(trader.getForceChangePwd().intValue());
      result.setLastIP(trader.getLastIP());
      result.setLastTime(trader.getLastTime());
      result.setMessage(null);
      result.setResult(1);
      result.setSessionID(rv.getUserManageVO().getSessionID());
      result.setTraderId(trader.getTraderID());
      result.setTraderName(trader.getName());
      result.setType(trader.getType());
      
      SimpleDateFormat spdf = new SimpleDateFormat("yyyyMMddHHmmssSS");
      String date = spdf.format(new Date());
      String randomKey = date + traderID + String.valueOf(Math.random() * 100000.0D);
      result.setTrustKey(randomKey);
      
      this.frontCheckDAO.updateTraderLogonInfo(randomKey, logonIP, traderID);
      if (errorLogonNum > 0) {
        this.frontCheckDAO.clearErrorLogonLog(traderID);
      }
      this.frontCheckDAO.addGlobalLog(traderID, logonIP, this.LOG_MANAGE_OPERATORTYPR, "登录成功", 1);
    }
    catch (Exception e)
    {
      result.setRecode("-1000");
      result.setMessage("登录失败，请联系管理员");
      this.logger.error("用户[" + userID + "]登录异常：", e);
    }
    return result;
  }
  
  public boolean checkModuleRight(String traderID, int moduleID)
  {
    TraderLogonInfo result = new TraderLogonInfo();
    result.setResult(-1);
    if (moduleID != this.COMMONMODULEID)
    {
      String traderModule = this.frontCheckDAO.getTraderModuleEnable(traderID, moduleID);
      if (!"Y".equalsIgnoreCase(traderModule))
      {
        result.setRecode("-5");
        result.setMessage("交易员没有模块" + moduleID + "权限");
        this.logger.info("交易员[" + traderID + "]没有模块" + moduleID + "权限");
        return false;
      }
    }
    return true;
  }
  
  public int changePassowrd(String traderID, String oldPassword, String newPassword, String logonIP)
  {
    this.logger.info("交易员 " + traderID + " 修改密码，登录 IP 为 " + logonIP);
    
    TraderPO trader = this.frontCheckDAO.getTraderByID(traderID);
    if (trader == null)
    {
      this.logger.info("交易员" + traderID + "修改密码，交易员代码错误");
      return -2;
    }
    if (!trader.getPassword().equals(MD5.getMD5(traderID, oldPassword)))
    {
      this.logger.info("交易员" + traderID + "修改密码，原密码不正确");
      return -1;
    }
    this.frontCheckDAO.updateTraderPassword(traderID, MD5.getMD5(traderID, newPassword));
    
    this.frontCheckDAO.addGlobalLog(traderID, logonIP, this.PWD_MANAGE_OPERATORTYPR, "交易员修改密码成功", 1);
    
    return 1;
  }
}
