package gnnt.MEBS.timebargain.mgr.util;

import java.sql.CallableStatement;
import java.sql.SQLException;
import org.springframework.jdbc.core.CallableStatementCallback;

class DaoHelper$1
  implements CallableStatementCallback
{
  DaoHelper$1(DaoHelper paramDaoHelper) {}
  
  public Object doInCallableStatement(CallableStatement cs)
    throws SQLException
  {
    cs.execute();
    return null;
  }
}
