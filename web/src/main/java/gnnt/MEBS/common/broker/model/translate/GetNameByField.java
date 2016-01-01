package gnnt.MEBS.common.broker.model.translate;

import java.lang.reflect.Field;
import java.util.List;

public class GetNameByField
  implements IGetNameByField
{
  private List<IGetNameByField> getNameByFieldList;
  
  public List<IGetNameByField> getGetNameByFieldList()
  {
    return this.getNameByFieldList;
  }
  
  public void setGetNameByFieldList(List<IGetNameByField> getNameByFieldList)
  {
    this.getNameByFieldList = getNameByFieldList;
  }
  
  public String getName(Field field)
  {
    String name = "";
    if ((this.getNameByFieldList != null) && (this.getNameByFieldList.size() > 0)) {
      for (IGetNameByField getNameByField : this.getNameByFieldList)
      {
        name = getNameByField.getName(field);
        if ((name != null) && (name.length() > 0)) {
          break;
        }
      }
    }
    return name;
  }
}
