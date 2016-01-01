package gnnt.MEBS.logonService.dao.jdbc;

import gnnt.MEBS.logonService.client.mgr.User;
import gnnt.MEBS.logonService.dao.MgrLogonDAO;
import gnnt.MEBS.logonService.model.LogonManagerInfo;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.List;

import org.springframework.jdbc.core.RowMapper;

/**
 * 后台登陆jdbc 实现
 * 
 * @author xuejt
 * 
 */
public class MgrLogonDAOJdbc extends BaseDAOJdbc implements MgrLogonDAO {
	@Override
	public LogonManagerInfo getLogonManagerInfoBySysName(String sysName) {
		String sql = "select sysName, hostip, hostport,logonTable,logonUserIDCol,allowLogonError "
				+ " from l_logonConfig where hostip is not null "
				+ " and hostport is not null "
				+ " and logonTable is not null "
				+ " and logonUserIDCol is not null " + " and sysName=?";
		log.debug("sql: " + sql);
		Object[] params = new Object[] { sysName };

		for (int i = 0; i < params.length; i++)
			log.debug("params[" + i + "]: " + params[i]);

		List<LogonManagerInfo> list = getJdbcTemplate().query(sql,
				new LogonManagerInfoRowMapper(), params);
		if (list != null && list.size() > 0) {
			return list.get(0);
		} else {
			return null;
		}
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
			logonManagerInfo.setAllowLogonError(rs.getInt("allowLogonError"));
			return logonManagerInfo;
		}
	}

	@Override
	public User getUserByID(String userId) {
		String sql = "select * from c_user t  where t.id=? ";
		log.debug("sql: " + sql);
		Object[] params = new Object[] { userId };

		for (int i = 0; i < params.length; i++)
			log.debug("params[" + i + "]: " + params[i]);

		List<User> list = getJdbcTemplate().query(sql, new UserRowMapper(),
				params);
		if (list != null && list.size() > 0) {
			return list.get(0);
		} else {
			return null;
		}
	}

	private class UserRowMapper implements RowMapper<User> {
		public User mapRow(ResultSet rs, int rowNum) throws SQLException {
			User user = new User();
			user.setDescription(rs.getString("description"));
			user.setIsForbid(rs.getString("isForbid"));
			user.setKeyCode(rs.getString("keyCode"));
			user.setName(rs.getString("name"));
			user.setPassword(rs.getString("password"));
			user.setType(rs.getString("type"));
			user.setUserId(rs.getString("id"));
			return user;
		}
	}

	@Override
	public void changePassowrd(String userId, String password) {
		String sql = "update c_user set password=? where Id=? ";
		Object[] params = new Object[] { password, userId };

		int[] dataTypes = new int[] { Types.VARCHAR, Types.VARCHAR };

		log.debug("sql=" + sql);
		for (int i = 0; i < params.length; i++)
			logger.debug("params[" + i + "]: " + params[i]);

		getJdbcTemplate().update(sql, params, dataTypes);

	}

	/**
	 * 添加全局日志
	 * 
	 * @param operator
	 *            操作人
	 * @param operatorIP
	 *            操作人IP
	 * @param operatorType
	 *            操作类型
	 * @param operatorContent
	 *            操作内容
	 * @param operatorResult
	 *            操作结果
	 */
	@Override
	public void addGlobalLog(String operator, String operatorIP,
			int operatorType, String operatorContent, int operatorResult) {
		String sql = "insert into c_globallog_all(id,operator,operatetime,operatetype,operateip,operatecontent,operateresult) "
				+ " values(SEQ_C_GLOBALLOG.Nextval,?, sysdate,?,?,?,?)";
		Object[] params = new Object[] { operator, operatorType, operatorIP,
				operatorContent, operatorResult };
		int[] types = new int[] { Types.VARCHAR, Types.INTEGER, Types.VARCHAR,
				Types.VARCHAR, Types.INTEGER };
		log.debug("sql: " + sql);
		for (int i = 0; i < params.length; i++)
			log.debug("params[" + i + "]: " + params[i]);
		getJdbcTemplate().update(sql, params, types);
	}
}
