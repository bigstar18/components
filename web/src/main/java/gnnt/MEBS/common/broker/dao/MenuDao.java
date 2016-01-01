package gnnt.MEBS.common.broker.dao;

import gnnt.MEBS.common.broker.model.Menu;
import java.util.List;
import org.hibernate.Filter;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Repository;

@Repository("com_menuDao")
public class MenuDao
  extends StandardDao
{
  public List<Menu> getMenuBySubFilter(int type1, int type2, int visible)
  {
    String queryString = "from Menu as model where model.parentID!=-1 order by model.moduleId,model.seq ";
    
    getHibernateTemplate().enableFilter("menuFilter").setParameter("type1", 
      Integer.valueOf(type1)).setParameter("type2", Integer.valueOf(type2)).setParameter("visible", 
      Integer.valueOf(visible)).setParameter("m1", Integer.valueOf(0)).setParameter("m2", Integer.valueOf(6));
    
    return getHibernateTemplate().find(queryString);
  }
  
  public Menu getMenuById(long id, int type1, int type2, int visible, List<Integer> moduleList)
  {
    String queryString = "from Menu as model where model.id= ? order by seq ";
    
    getHibernateTemplate().enableFilter("menuFilter").setParameter("type1", 
      Integer.valueOf(type1)).setParameter("type2", Integer.valueOf(type2)).setParameter("visible", 
      Integer.valueOf(visible)).setParameterList("moduleID", moduleList);
    List list = getHibernateTemplate().find(queryString, Long.valueOf(id));
    if (list.size() > 0) {
      return (Menu)list.get(0);
    }
    return null;
  }
}
