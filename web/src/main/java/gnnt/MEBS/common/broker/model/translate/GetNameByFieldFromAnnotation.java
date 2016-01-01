package gnnt.MEBS.common.broker.model.translate;

import java.lang.reflect.Field;

public class GetNameByFieldFromAnnotation
  implements IGetNameByField
{
  public String getName(Field field)
  {
    ClassDiscription classDiscription = (ClassDiscription)field.getAnnotation(ClassDiscription.class);
    String name = "";
    if (classDiscription != null) {
      name = classDiscription.name();
    }
    return name;
  }
}
