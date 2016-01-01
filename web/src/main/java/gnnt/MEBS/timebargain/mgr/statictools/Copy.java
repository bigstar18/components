package gnnt.MEBS.timebargain.mgr.statictools;

import gnnt.MEBS.common.mgr.model.StandardModel;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

public class Copy
{
  public static StandardModel copy(StandardModel fromObject, StandardModel toObject)
  {
    Method[] fromMethods = fromObject.getClass().getMethods();
    Method[] methods = toObject.getClass().getMethods();
    if ((methods != null) && (methods.length > 0))
    {
      Map<String, Method> methodsMap = new HashMap();
      
      List<Method> toMethods = new ArrayList();
      Method[] arrayOfMethod1;
      int j = (arrayOfMethod1 = methods).length;
      for (int i = 0; i < j; i++)
      {
        Method method = arrayOfMethod1[i];
        methodsMap.put(method.getName(), method);
        if (method.getName().startsWith("get")) {
          toMethods.add(method);
        }
      }
      int m;
      int k;
      for (Iterator localIterator = toMethods.iterator(); localIterator.hasNext(); k < m)
      {
        Method method = (Method)localIterator.next();
        String name = method.getName();
        Method[] arrayOfMethod2;
        m = (arrayOfMethod2 = fromMethods).length;k = 0; continue;Method method1 = arrayOfMethod2[k];
        if ((name.equals(method1.getName())) && (!name.contains("TradeTime"))) {
          try
          {
            Object object = method1.invoke(fromObject, new Object[0]);
            
            Method target = (Method)methodsMap.get("set" + name.substring(3, name.length()));
            if (target != null) {
              target.invoke(toObject, new Object[] { object });
            }
          }
          catch (Exception e)
          {
            e.printStackTrace();
          }
        }
        k++;
      }
    }
    return toObject;
  }
}
