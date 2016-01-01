package gnnt.MEBS.vendue.front.service.impl;

import gnnt.MEBS.common.front.callbak.LogonCallbak;
import gnnt.MEBS.common.front.exception.CallbakErrorException;
import gnnt.MEBS.common.front.model.integrated.MFirm;
import gnnt.MEBS.common.front.model.integrated.User;
import gnnt.MEBS.priceranking.server.rmi.TradeRMI;
import gnnt.MEBS.vendue.front.init.InitLoad;
import gnnt.MEBS.vendue.front.model.OrderParams;
import gnnt.MEBS.vendue.front.model.TradeUser;
import gnnt.MEBS.vendue.front.service.TradeService;
import java.io.PrintStream;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class LogonCallbakImpl
  implements LogonCallbak
{
  TradeRMI tradeRMI = null;
  TradeService tradeService = null;
  
  public void logonSuccessCallbak(User user, HttpServletRequest request)
    throws CallbakErrorException
  {
    this.tradeService = ((TradeService)InitLoad.getTradeObject("tradeService"));
    this.tradeRMI = this.tradeService.getTradeRMI();
    
    String firmId = user.getBelongtoFirm().getFirmID();
    String tradeId = user.getTraderID();
    String tradeName = user.getName();
    TradeUser tradeUser = this.tradeService.getTradeUserInfo(firmId);
    List<String> authList = this.tradeService.getCodeAuth(firmId);
    request.getSession().setAttribute("FIRMID", firmId);
    request.getSession().setAttribute("TRADERID", tradeId);
    request.getSession().setAttribute("LOGINID", user.getSessionId());
    request.getSession().setAttribute("username", tradeName);
    request.getSession().setMaxInactiveInterval(60000);
    request.getSession().setAttribute("tradeUser", tradeUser);
    request.getSession().setAttribute("authList", authList);
    request.getSession().setAttribute("orderParams", new OrderParams());
    try
    {
      this.tradeRMI.loadLoginUserInfoByTraderID(tradeId);
    }
    catch (Exception e)
    {
      System.out.println("登陆回调核心加载交易商失败！");
      throw new CallbakErrorException("rmi调用失败");
    }
  }
}
