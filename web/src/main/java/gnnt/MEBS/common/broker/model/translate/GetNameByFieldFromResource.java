package gnnt.MEBS.common.broker.model.translate;

import java.lang.reflect.Field;
import java.util.Locale;
import java.util.ResourceBundle;

public class GetNameByFieldFromResource
  implements IGetNameByField
{
  public String getName(Field field)
  {
    Locale locale = Locale.SIMPLIFIED_CHINESE;
    String propertiesName = field.getDeclaringClass().getSimpleName();
    String name = "";
    try
    {
      ResourceBundle resourceBundle = ResourceBundle.getBundle(
        "ApplicationResources", locale);
      
      name = resourceBundle.getString(propertiesName + "." + field.getName());
    }
    catch (Exception e)
    {
      name = "";
    }
    return name;
  }
}
