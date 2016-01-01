package gnnt.MEBS.timebargain.mgr.dao.impl;

import java.sql.SQLException;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;

class BillDaoImpl$4
  implements HibernateCallback
{
  BillDaoImpl$4(BillDaoImpl paramBillDaoImpl, String paramString) {}
  
  public Object doInHibernate(Session session)
    throws HibernateException, SQLException
  {
    Query query = session.createSQLQuery(this.val$sql);
    return Integer.valueOf(query.executeUpdate());
  }
}
