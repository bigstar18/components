package gnnt.MEBS.timebargain.mgr.dao;

import java.sql.SQLException;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;

class TradeParamsDao$2
  implements HibernateCallback
{
  TradeParamsDao$2(TradeParamsDao paramTradeParamsDao, String paramString1, String paramString2) {}
  
  public Object doInHibernate(Session session)
    throws HibernateException, SQLException
  {
    List list = session.createQuery(this.val$sql)
      .setString(0, this.val$id)
      .list();
    return list;
  }
}
