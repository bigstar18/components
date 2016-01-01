package gnnt.MEBS.logonService.dao.jdbc;

import gnnt.MEBS.logonService.dao.LogonManagerDAO;
import gnnt.MEBS.logonService.model.LogonManagerInfo;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map;

import org.springframework.jdbc.core.RowMapper;

/**
 * 处理用户信息DAO 实现
 * 
 * @author xuejt
 * 
 */
public class LogonManagerDAOJdbc extends BaseDAOJdbc implements LogonManagerDAO {

	@Override
	public LogonManagerInfo getLogonManagerInfoBySysName(String sysName) {
		String sql = "select sysName, hostip, hostport,logonTable,logonUserIDCol "
				+ " from l_logonConfig where hostip is not null "
				+ " and hostport is not null "
				+ " and logonTable is not null "
				+ " and logonUserIDCol is not null " + " and sysName=?";
		log.debug("sql: " + sql);
		Object[] params = new Object[] { sysName };

		for (int i = 0; i < params.length; i++)
			log.debug("params[" + i + "]: " + params[i]);

		return getJdbcTemplate().queryForObject(sql,
				new LogonManagerInfoRowMapper(), params);
	}

	private class LogonManagerInfoRowMapper implements
			RowMapper<LogonManagerInfo> {
		public LogonManagerInfo mapRow(ResultSet rs, int rowNum)
				throws SQLException {
			LogonManagerInfo logonManagerInfo = new LogonManagerInfo();
			logonManagerInfo.setIp(rs.getString("HOSTIP"));
			logonManagerInfo.setPort(rs.getInt("HOSTPORT"));
			logonManagerInfo.setLogonTable(rs.getString("logonTable"));
			logonManagerInfo.setLogonUserIDCol(rs.getString("logonUserIDCol"));

			return logonManagerInfo;
		}
	}

	@Override
	public Map<String, Object> getMapBySql(String sql) {
		log.debug("sql:" + sql);
		return getJdbcTemplate().queryForMap(sql);
	}

}
