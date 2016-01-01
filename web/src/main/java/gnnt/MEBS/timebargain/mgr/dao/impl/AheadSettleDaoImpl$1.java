package gnnt.MEBS.timebargain.mgr.dao.impl;

import java.sql.SQLException;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.transform.Transformers;
import org.springframework.orm.hibernate3.HibernateCallback;

class AheadSettleDaoImpl$1
  implements HibernateCallback
{
  AheadSettleDaoImpl$1(AheadSettleDaoImpl paramAheadSettleDaoImpl, String paramString) {}
  
  public Object doInHibernate(Session session)
    throws HibernateException, SQLException
  {
    Query query = session.createSQLQuery(this.val$sql)
      .setResultTransformer(
      Transformers.ALIAS_TO_ENTITY_MAP);
    return query.list();
  }
}
