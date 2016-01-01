package gnnt.MEBS.common.broker.model.translate;

import java.lang.reflect.Field;

public class GetNameByFieldFromThis
  implements IGetNameByField
{
  public String getName(Field field)
  {
    return field.getName();
  }
}
