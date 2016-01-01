package gnnt.MEBS.common.front.statictools;

import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.io.xml.DomDriver;
import gnnt.MEBS.common.front.model.StandardModel;
import gnnt.MEBS.common.front.model.front.Role;
import gnnt.MEBS.common.front.model.integrated.User;
import gnnt.MEBS.common.front.webFrame.strutsInterceptor.WriteLogInterceptor;
import java.io.PrintStream;
import java.util.HashSet;
import java.util.Set;
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
    User user = new User();
    user.setName("name");
    Set<Role> roleSet = new HashSet();
    Role role = new Role();
    role.setName("roleName");
    roleSet.add(role);
    user.setRoleSet(roleSet);
    String str = serializeToXml(user);
    System.out.println(str);
  }
}
