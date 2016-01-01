package gnnt.MEBS.common.front.dao;

import gnnt.MEBS.common.front.model.front.Right;
import java.util.List;
import org.hibernate.Filter;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Repository;

@Repository("com_rightDao")
public class RightDao
  extends StandardDao
{
  public Right getRightBySubFilter(long id, int type1, int type2)
  {
    String queryString = "from Right as model where model.id= ?";
    
    getHibernateTemplate().enableFilter("rightFilter").setParameter(
      "type1", Integer.valueOf(type1)).setParameter("type2", Integer.valueOf(type2));
    
    List list = getHibernateTemplate().find(queryString, Long.valueOf(id));
    if (list.size() > 0) {
      return (Right)list.get(0);
    }
    return null;
  }
  
  public Right loadRightTree(long id, int type, int visible)
  {
    String queryString = "from Right as model where model.id= ?";
    
    getHibernateTemplate().enableFilter("rightTreeFilter").setParameter(
      "type", Integer.valueOf(type)).setParameter("visible", Integer.valueOf(visible));
    
    List list = getHibernateTemplate().find(queryString, Long.valueOf(id));
    if (list.size() > 0) {
      return (Right)list.get(0);
    }
    return null;
  }
}
