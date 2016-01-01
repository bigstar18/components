package gnnt.MEBS.timebargain.mgr.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.jdbc.Work;
import org.springframework.orm.hibernate3.HibernateCallback;

class TradeParamsDao$7
  implements HibernateCallback<Object>
{
  TradeParamsDao$7(TradeParamsDao paramTradeParamsDao, String paramString) {}
  
  public Object doInHibernate(Session session)
    throws HibernateException, SQLException
  {
    Work work = new Work()
    {
      public void execute(Connection connection)
        throws SQLException
      {
        CallableStatement cs = connection.prepareCall("{ call SP_F_SynchCommodity(?) }");
        cs.setString(1, this.val$commodityID);
        cs.executeUpdate();
      }
    };
    session.doWork(work);
    
    return null;
  }
}
