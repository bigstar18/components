package gnnt.MEBS.common.front.dao;

import gnnt.MEBS.common.front.model.front.Menu;
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
      Integer.valueOf(visible));
    
    return getHibernateTemplate().find(queryString);
  }
  
  public Menu getMenuById(long id, List<Integer> moduleIds, int type1, int type2, int visible)
  {
    String queryString = "from Menu as model where model.id= ? order by seq ";
    
    getHibernateTemplate().enableFilter("menuFilter").setParameter("type1", 
      Integer.valueOf(type1)).setParameter("type2", Integer.valueOf(type2)).setParameterList("type3", moduleIds).setParameter("visible", 
      Integer.valueOf(visible));
    List list = getHibernateTemplate().find(queryString, Long.valueOf(id));
    if (list.size() > 0) {
      return (Menu)list.get(0);
    }
    return null;
  }
}
