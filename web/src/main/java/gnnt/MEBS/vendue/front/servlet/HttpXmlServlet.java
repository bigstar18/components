package gnnt.MEBS.vendue.front.servlet;

import gnnt.MEBS.priceranking.server.model.Commodity;
import gnnt.MEBS.priceranking.server.model.CommodityOrder;
import gnnt.MEBS.priceranking.server.rmi.ServerRMI;
import gnnt.MEBS.priceranking.server.rmi.TradeRMI;
import gnnt.MEBS.vendue.front.init.InitLoad;
import gnnt.MEBS.vendue.front.model.QuantionMap;
import gnnt.MEBS.vendue.front.model.ResponseResult;
import gnnt.MEBS.vendue.front.service.TradeService;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.rmi.RemoteException;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class HttpXmlServlet
  extends HttpServlet
{
  private final Log log = LogFactory.getLog(HttpXmlServlet.class);
  private TradeRMI tradeRMI = null;
  private ServerRMI serverRMI = null;
  private TradeService tradeService = null;
  
  public void init()
    throws ServletException
  {
    initRMI();
  }
  
  public void doGet(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse)
    throws ServletException
  {
    execute(paramHttpServletRequest, paramHttpServletResponse);
  }
  
  public void doPost(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse)
    throws ServletException
  {
    execute(paramHttpServletRequest, paramHttpServletResponse);
  }
  
  public void execute(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse)
    throws ServletException
  {
    ResponseResult localResponseResult = new ResponseResult();
    String str1 = null;
    String str2 = null;
    try
    {
      str2 = paramHttpServletRequest.getParameter("xml");
      str1 = getReqNameByXml(str2);
    }
    catch (Exception localException)
    {
      this.log.error("Servlet出错:" + localException);
      errorException(localException);
      localException.printStackTrace();
      localResponseResult.setRetCode(65333);
      localResponseResult.setMessage("未知异常！");
    }
    if (str1 == null) {
      str1 = "";
    }
    localResponseResult.setName(str1);
    if (str1.equals("aqt"))
    {
      quotationsAdd(paramHttpServletRequest, paramHttpServletResponse, str2, localResponseResult);
    }
    else if (str1.equals("quotations"))
    {
      quotations(paramHttpServletRequest, paramHttpServletResponse, str2, localResponseResult);
    }
    else
    {
      if ((localResponseResult.getMessage() == null) || (localResponseResult.getMessage().equals("")))
      {
        localResponseResult.setRetCode(65333);
        localResponseResult.setMessage("未知包名！");
      }
      renderXML(paramHttpServletResponse, ResponseXml.responseXml("", localResponseResult.getRetCode(), localResponseResult.getMessage()));
    }
  }
  
  protected void quotationsAdd(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse, String paramString, ResponseResult paramResponseResult)
  {
    if (this.log.isDebugEnabled()) {}
    long l1 = 0L;
    String str1 = "";
    short s = 0;
    long l2 = -1L;
    long l3 = -1L;
    int i = 0;
    long l4 = -1L;
    String str2 = "";
    StringBuffer localStringBuffer = new StringBuffer("");
    try
    {
      if ((getValueByTagName(paramString, "P") == null) || ((getValueByTagName(paramString, "CNT") == null) && (getValueByTagName(paramString, "ID") == null)))
      {
        l1 = -1L;
        str1 = "获取提交包数据失败！";
      }
      else
      {
        s = Short.parseShort(getValueByTagName(paramString, "P"));
        l2 = Long.parseLong(getValueByTagName(paramString, "CNT"));
        str2 = getValueByTagName(paramString, "ID");
        QuantionMap localQuantionMap = QuantionMap.getInit();
        l3 = localQuantionMap.getHqCount(s);
        String[] arrayOfString = null;
        if ((str2 != null) && (!str2.equals(""))) {
          arrayOfString = str2.split(",");
        }
        if (l2 < l3)
        {
          HashMap localHashMap = new HashMap();
          Map localMap = localQuantionMap.getHqMap(s);
          Set localSet = localMap.keySet();
          Iterator localIterator = localSet.iterator();
          CommodityOrder localCommodityOrder;
          int j;
          while (localIterator.hasNext())
          {
            localCommodityOrder = (CommodityOrder)localMap.get(localIterator.next().toString());
            j = 0;
            if (arrayOfString != null)
            {
              j = 1;
              for (int k = 0; k < arrayOfString.length; k++) {
                if (localCommodityOrder.getCommodity().getCode().equals(arrayOfString[k]))
                {
                  j = 0;
                  break;
                }
              }
            }
            if (localCommodityOrder.getInitCount() > l2) {
              i = 1;
            }
            if ((j == 0) && (localCommodityOrder.getHqCount() > l2)) {
              localHashMap.put(localCommodityOrder.getCommodity().getCode(), localCommodityOrder);
            }
          }
          if ((localHashMap != null) && (localHashMap.size() > 0))
          {
            localStringBuffer.append("<LI>");
            localIterator = localHashMap.values().iterator();
            while (localIterator.hasNext())
            {
              localCommodityOrder = (CommodityOrder)localIterator.next();
              localStringBuffer.append("<HQ>").append("<ID>").append(localCommodityOrder.getCommodity().getCode()).append("</ID>").append("<YQ>").append(localCommodityOrder.getTradeAmount()).append("</YQ>").append("<P>").append(localCommodityOrder.getNewPrice()).append("</P>");
              j = localCommodityOrder.getCountdownFlag();
              l4 = -1L;
              if (j == 1) {
                try
                {
                  l4 = this.tradeRMI.getRightNowCountdown(s, localCommodityOrder.getCommodity().getCode());
                }
                catch (RemoteException localRemoteException)
                {
                  localRemoteException.printStackTrace();
                }
              }
              localStringBuffer.append("<CT>").append(l4).append("</CT>").append("</HQ>");
            }
            localStringBuffer.append("</LI>");
          }
        }
      }
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
      this.log.error("logon error:" + localException);
      errorException(localException);
      l1 = -203L;
      str1 = "未知异常！";
    }
    paramResponseResult.setLongRetCode(l1);
    paramResponseResult.setMessage(str1);
    renderXML(paramHttpServletResponse, ResponseXml.quotationsAdd(paramResponseResult, l3, localStringBuffer.toString(), i));
  }
  
  protected void quotations(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse, String paramString, ResponseResult paramResponseResult)
  {
    if (this.log.isDebugEnabled()) {}
    int i = 0;
    String str1 = "";
    short s = 0;
    String str2 = "";
    long l1 = -1L;
    long l2 = -1L;
    long l3 = -1L;
    try
    {
      if ((getValueByTagName(paramString, "P_ID") == null) || (getValueByTagName(paramString, "CODE") == null) || (getValueByTagName(paramString, "CNT") == null))
      {
        i = -1;
        str1 = "获取提交包数据失败！";
      }
      else
      {
        s = Short.parseShort(getValueByTagName(paramString, "P_ID"));
        l1 = Long.parseLong(getValueByTagName(paramString, "CNT"));
        str2 = getValueByTagName(paramString, "CODE");
        QuantionMap localQuantionMap = QuantionMap.getInit();
        l2 = ((CommodityOrder)localQuantionMap.getHqMap(s).get(str2)).getHqCount();
        int j = ((CommodityOrder)localQuantionMap.getHqMap(s).get(str2)).getCountdownFlag();
        if (l1 < l2)
        {
          if (j == 1) {
            try
            {
              l3 = this.tradeRMI.getRightNowCountdown(s, str2);
            }
            catch (RemoteException localRemoteException)
            {
              localRemoteException.printStackTrace();
            }
          }
          List localList = localQuantionMap.getAloneHq(s, str2);
          paramResponseResult.setResultList(localList);
        }
      }
    }
    catch (Exception localException)
    {
      this.log.error("quotations error:" + localException);
      errorException(localException);
      i = 65333;
      str1 = "未知异常！";
    }
    paramResponseResult.setLongRetCode(i);
    paramResponseResult.setMessage(str1);
    renderXML(paramHttpServletResponse, ResponseXml.quotations(paramResponseResult, l2, str2, l3));
  }
  
  protected void renderXML(HttpServletResponse paramHttpServletResponse, String paramString)
  {
    try
    {
      paramHttpServletResponse.setContentType("text/xml;charset=GBK");
      paramHttpServletResponse.getWriter().print(paramString);
    }
    catch (IOException localIOException)
    {
      this.log.error(localIOException.getMessage(), localIOException);
    }
  }
  
  protected String readXMLFromRequestBody(HttpServletRequest paramHttpServletRequest)
    throws Exception
  {
    StringBuffer localStringBuffer = new StringBuffer();
    BufferedReader localBufferedReader = paramHttpServletRequest.getReader();
    String str = null;
    while ((str = localBufferedReader.readLine()) != null) {
      localStringBuffer.append(str);
    }
    return localStringBuffer.toString();
  }
  
  public void errorException(Exception paramException)
  {
    StackTraceElement[] arrayOfStackTraceElement = paramException.getStackTrace();
    this.log.error(paramException.getMessage());
    for (int i = 0; i < arrayOfStackTraceElement.length; i++) {
      this.log.error(arrayOfStackTraceElement[i].toString());
    }
  }
  
  public void initRMI()
  {
    this.tradeService = ((TradeService)InitLoad.getTradeObject("tradeService"));
    this.tradeRMI = this.tradeService.getTradeRMI();
    this.serverRMI = this.tradeService.getServerRMI();
  }
  
  protected String getReqNameByXml(String paramString)
  {
    String str1 = "";
    String str2 = paramString.toUpperCase();
    int i = str2.indexOf("NAME=");
    if (i < 0) {
      return str1;
    }
    int j = str2.indexOf(">", i);
    if (j < 0) {
      return str1;
    }
    String str3 = str2.substring(i + 5, j);
    str3 = str3.replaceAll("'", "");
    str3 = str3.replaceAll("\"", "");
    str3 = str3.trim();
    str1 = str3.toLowerCase();
    return str1;
  }
  
  private String getValueByTagName(String paramString1, String paramString2)
  {
    String str1 = "";
    String str2 = paramString1.replaceAll("</", "<");
    String[] arrayOfString = str2.split("<" + paramString2 + ">");
    if (arrayOfString.length > 1) {
      str1 = arrayOfString[1];
    }
    if (("COMMODITY_ID".equals(paramString2)) && (str1 != null) && (str1.length() > 2)) {
      str1 = str1.substring(2);
    }
    return str1;
  }
  
  private long parseLong(String paramString)
  {
    try
    {
      return Long.parseLong(paramString);
    }
    catch (NumberFormatException localNumberFormatException) {}
    return 0L;
  }
}
