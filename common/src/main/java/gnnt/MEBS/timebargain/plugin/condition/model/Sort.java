package gnnt.MEBS.timebargain.plugin.condition.model;

import java.util.Comparator;

public class Sort
  implements Comparator
{
  public static final int SORT_BY_PRICE = 1;
  public static final int SORT_BY_BUY1 = 2;
  public static final int SORT_BY_SELL1 = 3;
  private int sortby;
  
  public Sort() {}
  
  public Sort(int sortby)
  {
    this.sortby = sortby;
  }
  
  public int compare(Object o1, Object o2)
  {
    ConditionOrder order1 = (ConditionOrder)o1;
    ConditionOrder order2 = (ConditionOrder)o2;
    return order1.getConditionPrice()
      .compareTo(order2.getConditionPrice());
  }
}
