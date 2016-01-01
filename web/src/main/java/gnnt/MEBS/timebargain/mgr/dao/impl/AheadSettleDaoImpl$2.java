package gnnt.MEBS.timebargain.mgr.dao.impl;

import java.sql.SQLException;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;

class AheadSettleDaoImpl$2
  implements HibernateCallback
{
  AheadSettleDaoImpl$2(AheadSettleDaoImpl paramAheadSettleDaoImpl) {}
  
  public Object doInHibernate(Session session)
    throws HibernateException, SQLException
  {
    Query query = session.createSQLQuery("select t.customerid from t_customer t");
    return query.list();
  }
}
