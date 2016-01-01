package gnnt.MEBS.timebargain.mgr.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import org.hibernate.jdbc.Work;

class TradeParamsDao$8$1
  implements Work
{
  TradeParamsDao$8$1(TradeParamsDao.8 param8, String paramString) {}
  
  public void execute(Connection connection)
    throws SQLException
  {
    CallableStatement cs = connection.prepareCall("{ call SP_F_SynchCommodity(?) }");
    cs.setString(1, this.val$commodityID);
    cs.executeUpdate();
  }
}
