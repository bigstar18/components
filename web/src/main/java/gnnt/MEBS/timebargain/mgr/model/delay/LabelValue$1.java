package gnnt.MEBS.timebargain.mgr.model.delay;

import java.util.Comparator;

class LabelValue$1
  implements Comparator
{
  public int compare(Object o1, Object o2)
  {
    String label1 = ((LabelValue)o1).getLabel();
    String label2 = ((LabelValue)o2).getLabel();
    return label1.compareToIgnoreCase(label2);
  }
}
