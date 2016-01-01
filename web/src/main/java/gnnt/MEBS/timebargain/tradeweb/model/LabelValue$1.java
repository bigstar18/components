package gnnt.MEBS.timebargain.tradeweb.model;

import java.util.Comparator;

final class LabelValue$1
  implements Comparator
{
  public int compare(Object paramObject1, Object paramObject2)
  {
    String str1 = ((LabelValue)paramObject1).getLabel();
    String str2 = ((LabelValue)paramObject2).getLabel();
    return str1.compareToIgnoreCase(str2);
  }
}
