package gnnt.MEBS.timebargain.mgr.dao;

import gnnt.MEBS.common.mgr.dao.QueryCallback;
import java.sql.SQLException;
import org.apache.commons.logging.Log;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.transform.Transformers;
import org.springframework.orm.hibernate3.HibernateCallback;

class TradeParamsDao$8
  implements HibernateCallback
{
  TradeParamsDao$8(TradeParamsDao paramTradeParamsDao, String paramString, Object[] paramArrayOfObject, int paramInt1, int paramInt2, QueryCallback paramQueryCallback) {}
  
  public Object doInHibernate(Session session)
    throws HibernateException, SQLException
  {
    TradeParamsDao.access$0(this.this$0).debug("findAllBySQL:" + this.val$sql);
    Query query = session.createSQLQuery("select * " + this.val$sql)
      .setResultTransformer(Transformers.ALIAS_TO_ENTITY_MAP);
    if ((this.val$params != null) && (this.val$params.length > 0)) {
      for (int i = 0; i < this.val$params.length; i++)
      {
        TradeParamsDao.access$0(this.this$0).debug("   params[i]:" + this.val$params[i]);
        query.setParameter(i, this.val$params[i]);
      }
    }
    query.setFirstResult(this.val$startCount);
    query.setMaxResults(this.val$pageSize);
    if (this.val$queryCallback != null) {
      this.val$queryCallback.doInQuery(query);
    }
    return query.list();
  }
}
