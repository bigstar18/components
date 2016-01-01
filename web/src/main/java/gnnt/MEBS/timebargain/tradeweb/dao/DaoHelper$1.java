package gnnt.MEBS.timebargain.tradeweb.dao;

import java.sql.CallableStatement;
import java.sql.SQLException;
import org.springframework.jdbc.core.CallableStatementCallback;

final class DaoHelper$1
  implements CallableStatementCallback
{
  DaoHelper$1(DaoHelper paramDaoHelper) {}
  
  public Object doInCallableStatement(CallableStatement paramCallableStatement)
    throws SQLException
  {
    paramCallableStatement.execute();
    return null;
  }
}
