package gnnt.MEBS.timebargain.mgr.dao;

import gnnt.MEBS.timebargain.mgr.model.apply.Apply;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.jdbc.Work;
import org.springframework.orm.hibernate3.HibernateCallback;

class TradeParamsDao$6
  implements HibernateCallback<Object>
{
  TradeParamsDao$6(TradeParamsDao paramTradeParamsDao, Apply paramApply) {}
  
  public Object doInHibernate(Session session)
    throws HibernateException, SQLException
  {
    Work work = new Work()
    {
      public void execute(Connection connection)
        throws SQLException
      {
        CallableStatement cs = connection.prepareCall("{ ?=call FN_T_CREATEAPPLY(?, ?, ?, ?) }");
        cs.setString(2, this.val$apply.getContent());
        cs.setInt(3, this.val$apply.getApplyType());
        cs.setInt(4, this.val$apply.getStatus());
        cs.setString(5, this.val$apply.getProposer());
        cs.registerOutParameter(1, 2);
        cs.executeUpdate();
      }
    };
    session.doWork(work);
    
    return null;
  }
}
