package gnnt.MEBS.common.broker.statictools;

import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.io.xml.DomDriver;
import gnnt.MEBS.common.broker.model.Broker;
import gnnt.MEBS.common.broker.model.StandardModel;
import gnnt.MEBS.common.broker.webframe.strutsinterceptor.WriteLogInterceptor;
import java.io.PrintStream;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class Serialize
{
  private static final transient Log logger = LogFactory.getLog(WriteLogInterceptor.class);
  
  public static String serializeToXml(StandardModel model)
  {
    XStream xstream = new XStream();
    
    return xstream.toXML(model);
  }
  
  public static StandardModel deSerializeFromXml(String str)
  {
    try
    {
      XStream xs = new XStream(new DomDriver());
      return (StandardModel)xs.fromXML(str);
    }
    catch (Exception e)
    {
      e.printStackTrace();
      logger.warn("str=" + str + ";不能反序列化");
    }
    return null;
  }
  
  public static void main(String[] args)
  {
    Broker broker = new Broker();
    broker.setName("name");
    broker.setIpAddress("ipAddress");
    String str = serializeToXml(broker);
    System.out.println(str);
  }
}
