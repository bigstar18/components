package gnnt.MEBS.timebargain.mgr.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.jdbc.Work;
import org.springframework.orm.hibernate3.HibernateCallback;

class TradeParamsDao$5
  implements HibernateCallback<Object>
{
  TradeParamsDao$5(TradeParamsDao paramTradeParamsDao, String paramString) {}
  
  public Object doInHibernate(Session session)
    throws HibernateException, SQLException
  {
    Work work = new Work()
    {
      public void execute(Connection connection)
        throws SQLException
      {
        PreparedStatement ps = connection.prepareStatement(this.val$sql);
      }
    };
    session.doWork(work);
    
    return null;
  }
}
