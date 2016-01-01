package gnnt.MEBS.vendue.front.servlet;

import gnnt.MEBS.common.front.model.integrated.User;
import gnnt.MEBS.priceranking.server.rmi.TradeRMI;
import gnnt.MEBS.vendue.front.init.InitLoad;
import gnnt.MEBS.vendue.front.service.TradeService;
import java.io.BufferedOutputStream;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class GetOrderXML
  extends HttpServlet
{
  private static final long serialVersionUID = 1000L;
  private TradeRMI tradeRMI = null;
  private TradeService tradeService = null;
  
  public void destroy()
  {
    super.destroy();
  }
  
  public void doGet(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse)
    throws ServletException, IOException
  {
    long l = -1000L;
    User localUser = (User)paramHttpServletRequest.getSession().getAttribute("CurrentUser");
    try
    {
      Long localLong = (Long)paramHttpServletRequest.getSession().getAttribute("LOGINID");
      if (localLong != null) {
        l = localLong.longValue();
      }
    }
    catch (Exception localException1)
    {
      localException1.printStackTrace();
    }
    String str1 = "";
    try
    {
      str1 = this.tradeRMI.getUserID(l, 21, localUser.getLogonType());
    }
    catch (Exception localException2)
    {
      localException2.printStackTrace();
    }
    String str2 = paramHttpServletRequest.getParameter("lastTime");
    int i = Integer.parseInt(paramHttpServletRequest.getParameter("partitionID"));
    String str3 = "";
    try
    {
      str3 = this.tradeService.getLastXML(str1, str2, i);
    }
    catch (Exception localException3)
    {
      localException3.printStackTrace();
    }
    ServletOutputStream localServletOutputStream = paramHttpServletResponse.getOutputStream();
    paramHttpServletResponse.setHeader("Content-Type", "text/xml");
    BufferedOutputStream localBufferedOutputStream = null;
    localBufferedOutputStream = new BufferedOutputStream(localServletOutputStream);
    localBufferedOutputStream.write(str3.getBytes());
    localBufferedOutputStream.flush();
    localBufferedOutputStream.close();
  }
  
  public void doPost(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse)
    throws ServletException, IOException
  {
    doGet(paramHttpServletRequest, paramHttpServletResponse);
  }
  
  public void initRMI()
  {
    this.tradeService = ((TradeService)InitLoad.getTradeObject("tradeService"));
    this.tradeRMI = this.tradeService.getTradeRMI();
  }
  
  public void init()
    throws ServletException
  {
    initRMI();
  }
}
