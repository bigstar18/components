package gnnt.MEBS.espot.mgr.action.trademanage;

import gnnt.MEBS.common.mgr.action.StandardAction;
import gnnt.MEBS.espot.core.kernel.IMgrService;
import gnnt.MEBS.espot.core.po.MarketPO;
import java.rmi.RemoteException;
import java.util.Date;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.logging.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

@Component("marketAction")
@Scope("request")
public class MarketAction
  extends StandardAction
{
  private static final long serialVersionUID = -3047794508671011980L;
  @Resource(name="marketStatusMap")
  private Map<Integer, String> marketStatusMap;
  @Resource(name="marketRunModeMap")
  private Map<String, String> marketRunModeMap;
  @Autowired
  @Qualifier("mgrService")
  private IMgrService mgrService;
  
  public Map<Integer, String> getMarketStatusMap()
  {
    return this.marketStatusMap;
  }
  
  public Map<String, String> getMarketRunModeMap()
  {
    return this.marketRunModeMap;
  }
  
  public IMgrService getMgrService()
  {
    return this.mgrService;
  }
  
  public void setMgrService(IMgrService paramIMgrService)
  {
    this.mgrService = paramIMgrService;
  }
  
  public String toMarketStatus()
  {
    try
    {
      MarketPO localMarketPO = this.mgrService.getMarketInfo();
      this.request.setAttribute("market", localMarketPO);
      this.request.setAttribute("dateFlag", Boolean.valueOf(this.mgrService.isTradeDate()));
      this.logger.debug(localMarketPO.getRecoverTime());
      this.logger.debug("=============status=" + localMarketPO.getStatus());
    }
    catch (RemoteException localRemoteException)
    {
      this.logger.error("RMI调用isTradeDate失败！！！");
    }
    return "success";
  }
  
  public String updateMarketStatus()
  {
    String str1 = this.request.getParameter("marketStatus");
    try
    {
      String str2 = "";
      if ((str1 != null) && (str1.length() > 0))
      {
        if (str1.equals("1"))
        {
          this.mgrService.openTrade();
          this.logger.debug("updateMarketStatus ===openTrade");
          str2 = str2 + "修改市场状态-开始";
        }
        else if (str1.equals("2"))
        {
          this.mgrService.pauseTrade();
          this.logger.debug("updateMarketStatus ===pauseTrade");
          str2 = str2 + "修改市场状态-暂停";
        }
        else if (str1.equals("3"))
        {
          this.mgrService.closeTrade();
          this.logger.debug("updateMarketStatus ===closeTrade");
          str2 = str2 + "修改市场状态-闭市";
        }
        addReturnValue(1, 230000L);
        writeOperateLog(2306, str2, 1, "");
        Thread.sleep(200L);
        return "success";
      }
    }
    catch (RemoteException localRemoteException)
    {
      this.logger.error("RMI修改市场状态失败！！！");
    }
    catch (InterruptedException localInterruptedException)
    {
      localInterruptedException.printStackTrace();
      writeOperateLog(2306, "修改市场状态", 0, localInterruptedException.getMessage());
    }
    addReturnValue(-1, 230001L);
    return "SysException";
  }
  
  public String updateMarketRunMode()
  {
    String str = this.request.getParameter("runMode");
    try
    {
      if ((str != null) && (str.length() > 0))
      {
        this.mgrService.setRunMode(str);
        addReturnValue(1, 230000L);
        if ("A".equals(str)) {
          writeOperateLog(2306, "修改系统运行模式-自动", 1, "");
        } else {
          writeOperateLog(2306, "修改系统运行模式-手动", 1, "");
        }
        return "success";
      }
    }
    catch (RemoteException localRemoteException)
    {
      this.logger.error("RMI修改运行模式失败！！！");
      writeOperateLog(2306, "修改系统运行模式", 0, localRemoteException.getMessage());
    }
    addReturnValue(-1, 230001L);
    return "SysException";
  }
  
  public String updateRecoverTime()
  {
    String str = this.request.getParameter("recoverTime");
    this.logger.debug("=============" + str);
    try
    {
      if ((str != null) && (str.length() > 0))
      {
        this.mgrService.timingRecoverTrade(str);
        addReturnValue(1, 230000L);
        writeOperateLog(2306, "修改系统暂停恢复时间,恢复时间为：" + str, 1, "");
        return "success";
      }
    }
    catch (RemoteException localRemoteException)
    {
      this.logger.error("RMI修改暂停恢复时间失败！！！");
      writeOperateLog(2306, "修改系统暂停恢复时间", 0, localRemoteException.getMessage());
    }
    addReturnValue(-1, 230001L);
    return "SysException";
  }
  
  public String querySysTime()
    throws RemoteException
  {
    Date localDate = this.mgrService.getCurDbDate();
    this.logger.debug("-------数据库时间：------------" + localDate);
    this.request.setAttribute("date", localDate);
    return "success";
  }
}
