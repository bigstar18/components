package gnnt.MEBS.common.front.servlet;

import gnnt.MEBS.common.front.service.StandardService;
import gnnt.MEBS.common.front.statictools.ApplicationContextInit;
import java.io.PrintStream;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import org.apache.activemq.web.AjaxServlet;

public class GNNTJmsAjaxServlet
  extends AjaxServlet
{
  private static final long serialVersionUID = 2538638263012152495L;
  
  public void init()
    throws ServletException
  {
    resetBrokerURL();
    super.init();
  }
  
  private void resetBrokerURL()
  {
    String parameterName = "org.apache.activemq.brokerURL";
    String factoryName = "org.apache.activemq.connectionFactory";
    ServletContext servletContext = getServletContext();
    if (servletContext.getAttribute(factoryName) == null) {
      try
      {
        Field contextField = servletContext.getClass().getDeclaredField("context");
        contextField.setAccessible(true);
        Object context = contextField.get(servletContext);
        
        Method setInitParameterMethod = context.getClass().getDeclaredMethod("setInitParameter", new Class[] { String.class, String.class });
        setInitParameterMethod.invoke(context, new Object[] { parameterName, getBrokerURLFromDB(servletContext, parameterName) });
      }
      catch (Exception e)
      {
        e.printStackTrace();
      }
    }
    System.out.println(servletContext.getInitParameter(parameterName));
  }
  
  private String getBrokerURLFromDB(ServletContext servletContext, String parameterName)
  {
    String brokerURL = servletContext.getInitParameter(parameterName);
    StandardService standardService = (StandardService)ApplicationContextInit.getBean("com_standardService");
    List<Map<Object, Object>> list = standardService.getListBySql("select INFOVALUE from C_MARKETINFO where INFONAME='JMSBrokerURL'");
    if ((list != null) && (list.size() > 0))
    {
      Map<Object, Object> map = (Map)list.get(0);
      if ((map != null) && (map.get("INFOVALUE") != null)) {
        brokerURL = map.get("INFOVALUE").toString();
      }
    }
    return brokerURL;
  }
}
