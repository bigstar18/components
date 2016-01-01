package gnnt.MEBS.timebargain.mgr.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.lob.LobHandler;

class ApplyAndCheckDao$1
  implements RowMapper
{
  ApplyAndCheckDao$1(ApplyAndCheckDao paramApplyAndCheckDao) {}
  
  public Object mapRow(ResultSet rs, int rowNum)
    throws SQLException
  {
    String content = ApplyAndCheckDao.access$0(this.this$0).getClobAsString(rs, 1);
    return content;
  }
}
