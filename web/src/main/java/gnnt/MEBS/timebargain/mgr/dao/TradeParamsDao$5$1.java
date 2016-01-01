package gnnt.MEBS.timebargain.mgr.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import org.hibernate.jdbc.Work;

class TradeParamsDao$5$1
  implements Work
{
  TradeParamsDao$5$1(TradeParamsDao.5 param5, String paramString) {}
  
  public void execute(Connection connection)
    throws SQLException
  {
    PreparedStatement ps = connection.prepareStatement(this.val$sql);
  }
}
