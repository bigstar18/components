package gnnt.MEBS.common.front.model.translate;

import java.lang.reflect.Field;

public class GetNameByFieldFromThis
  implements IGetNameByField
{
  public String getName(Field field)
  {
    return field.getName();
  }
}
