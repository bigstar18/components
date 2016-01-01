package gnnt.MEBS.common.broker.statictools;

import java.util.Properties;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.NoSuchBeanDefinitionException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;

public class ApplicationContextInit
  implements ApplicationContextAware
{
  private static Log log = LogFactory.getLog(ApplicationContextInit.class);
  private static ApplicationContext springContext;
  private static Properties props;
  private static Properties errorCodeProps;
  
  public void setApplicationContext(ApplicationContext applicationContext)
    throws BeansException
  {
    springContext = applicationContext;
    props = getProps();
    errorCodeProps = getErrorProps();
  }
  
  public static Object getBean(String beanId)
  {
    Object obj = null;
    if (springContext != null) {
      obj = springContext.getBean(beanId);
    }
    return obj;
  }
  
  private static Properties getErrorProps()
  {
    Properties conf = null;
    try
    {
      if (springContext != null) {
        conf = (Properties)getBean("errorCode");
      }
    }
    catch (NoSuchBeanDefinitionException e)
    {
      log.error("没有找到errorCode的名字！");
    }
    return conf;
  }
  
  private static Properties getProps()
  {
    Properties conf = null;
    try
    {
      if (springContext != null) {
        conf = (Properties)getBean("config");
      }
    }
    catch (NoSuchBeanDefinitionException e)
    {
      log.error("没有找到config的名字！");
    }
    return conf;
  }
  
  public static String getConfig(String name)
  {
    if (props != null) {
      return props.getProperty(name);
    }
    return null;
  }
  
  public static String getErrorInfo(String errorCode)
  {
    if (errorCodeProps != null) {
      return errorCodeProps.getProperty(errorCode);
    }
    return null;
  }
  
  public static ApplicationContext getApplicationContext()
  {
    return springContext;
  }
}
