package gnnt.MEBS.timebargain.mgr.dao.impl;

import java.sql.SQLException;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;

class BillDaoImpl$3
  implements HibernateCallback
{
  BillDaoImpl$3(BillDaoImpl paramBillDaoImpl) {}
  
  public Object doInHibernate(Session session)
    throws HibernateException, SQLException
  {
    Query query = session.createSQLQuery("select f.firmId from t_firm f");
    return query.list();
  }
}
