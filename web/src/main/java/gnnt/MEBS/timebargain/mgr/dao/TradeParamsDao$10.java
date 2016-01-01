package gnnt.MEBS.timebargain.mgr.dao;

import java.sql.SQLException;
import org.apache.commons.logging.Log;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;

class TradeParamsDao$10
  implements HibernateCallback<Object>
{
  TradeParamsDao$10(TradeParamsDao paramTradeParamsDao, String paramString, Object[] paramArrayOfObject) {}
  
  public Object doInHibernate(Session session)
    throws HibernateException, SQLException
  {
    TradeParamsDao.access$0(this.this$0).debug("count sql:" + this.val$sqlCount);
    Query query = session.createSQLQuery(this.val$sqlCount);
    if ((this.val$params != null) && (this.val$params.length > 0)) {
      for (int i = 0; i < this.val$params.length; i++)
      {
        TradeParamsDao.access$0(this.this$0).debug("   params[i]:" + this.val$params[i]);
        query.setParameter(i, this.val$params[i]);
      }
    }
    TradeParamsDao.access$0(this.this$0).debug("--------------------" + query.uniqueResult());
    int count = ((Number)query.uniqueResult()).intValue();
    TradeParamsDao.access$0(this.this$0).debug("count:" + count);
    return Integer.valueOf(count);
  }
}
