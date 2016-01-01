package gnnt.MEBS.timebargain.mgr.dao;

import java.sql.SQLException;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;

class TradeParamsDao$4
  implements HibernateCallback<Object>
{
  TradeParamsDao$4(TradeParamsDao paramTradeParamsDao, String paramString) {}
  
  public Object doInHibernate(Session session)
    throws HibernateException, SQLException
  {
    Query query = session.createQuery(this.val$sql);
    
    return Integer.valueOf(query.executeUpdate());
  }
}
