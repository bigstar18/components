package gnnt.MEBS.vendue.front.servlet;

import gnnt.MEBS.priceranking.server.model.Order;
import gnnt.MEBS.vendue.front.model.ResponseResult;
import java.sql.Timestamp;
import java.util.List;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class ResponseXml
{
  private static final Log log = LogFactory.getLog(ResponseXml.class);
  private static final String cmdSuff = "99";
  private static boolean debugcommodity = false;
  
  public static String responseXml(String paramString1, int paramInt, String paramString2)
  {
    StringBuffer localStringBuffer = new StringBuffer("<?xml version=\"1.0\" encoding=\"GBK\"?>");
    localStringBuffer.append("<GNNT>").append("<REP name=\"").append(paramString1).append("\">").append("<RESULT>").append("<RETCODE>").append(paramInt).append("</RETCODE>").append("<MESSAGE>").append(paramString2).append("</MESSAGE>").append("</RESULT>").append("</REP>").append("</GNNT>");
    return localStringBuffer.toString();
  }
  
  public static String responseXml(String paramString1, String paramString2, int paramInt, String paramString3)
  {
    StringBuffer localStringBuffer = new StringBuffer("<?xml version=\"1.0\" encoding=\"GBK\"?>");
    localStringBuffer.append("<GNNT>").append("<REP name=\"").append(paramString2).append("\">").append("<RESULT>").append("<RETCODE>").append(paramInt).append("</RETCODE>").append("<MESSAGE>").append(paramString3).append("</MESSAGE>").append("</RESULT>").append("</REP>").append("</GNNT>");
    return localStringBuffer.toString();
  }
  
  public static String quotationsAdd(ResponseResult paramResponseResult, long paramLong, String paramString, int paramInt)
  {
    StringBuffer localStringBuffer = new StringBuffer("<?xml version=\"1.0\" encoding=\"GBK\"?>");
    List localList = paramResponseResult.getResultList();
    localStringBuffer.append("<MEBS>").append("<REP name=\"").append(paramResponseResult.getName()).append("\">").append("<RES>").append("<RET>").append(paramResponseResult.getLongRetCode()).append("</RET>").append("<MSG>").append(paramResponseResult.getMessage()).append("</MSG>").append("<CNT>").append(paramLong).append("</CNT>").append("<N>").append(paramInt).append("</N>").append("</RES>").append(paramString).append("</REP>").append("</MEBS>");
    return localStringBuffer.toString();
  }
  
  public static String quotations(ResponseResult paramResponseResult, long paramLong1, String paramString, long paramLong2)
  {
    StringBuffer localStringBuffer = new StringBuffer("<?xml version=\"1.0\" encoding=\"GBK\"?>");
    List localList = paramResponseResult.getResultList();
    localStringBuffer.append("<MEBS>").append("<REP name=\"").append(paramResponseResult.getName()).append("\">").append("<RES>").append("<RET>").append(paramResponseResult.getLongRetCode()).append("</RET>").append("<MSG>").append(paramResponseResult.getMessage()).append("</MSG>").append("<CODE>").append(paramString).append("</CODE>").append("<CNT>").append(paramLong1).append("</CNT>").append("<CT>").append(paramLong2).append("</CT>").append("</RES>").append("<LI>");
    if ((localList != null) && (localList.size() > 0)) {
      for (int i = 0; i < localList.size(); i++)
      {
        Order localOrder = (Order)localList.get(i);
        localStringBuffer.append("<HQ>").append("<ID>").append(localOrder.getOrderId()).append("</ID>").append("<YQ>").append(localOrder.getAmount()).append("</YQ>").append("<P>").append(localOrder.getPrice()).append("</P>").append("<TI>").append(new Timestamp(localOrder.getSubmitTime())).append("</TI>").append("<TA>").append(localOrder.getValidAmount()).append("</TA>").append("</HQ>");
      }
    }
    localStringBuffer.append("</LI>").append("</REP>").append("</MEBS>");
    return localStringBuffer.toString();
  }
  
  private static void errorException(Exception paramException)
  {
    StackTraceElement[] arrayOfStackTraceElement = paramException.getStackTrace();
    log.error(paramException.getMessage());
    for (int i = 0; i < arrayOfStackTraceElement.length; i++) {
      log.error(arrayOfStackTraceElement[i].toString());
    }
  }
}
