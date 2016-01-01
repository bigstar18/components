package gnnt.MEBS.timebargain.mgr.dao;

import java.sql.SQLException;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;

class TradeParamsDao$1
  implements HibernateCallback
{
  TradeParamsDao$1(TradeParamsDao paramTradeParamsDao, String paramString) {}
  
  public Object doInHibernate(Session session)
    throws HibernateException, SQLException
  {
    List list = session.getNamedQuery(this.val$sqlName).list();
    return list;
  }
}
