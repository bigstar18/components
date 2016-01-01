package gnnt.MEBS.logonService.dao.jdbc;

import gnnt.MEBS.logonService.client.front.ErrorLoginLog;
import gnnt.MEBS.logonService.client.front.Trader;
import gnnt.MEBS.logonService.client.front.TraderModule;
import gnnt.MEBS.logonService.dao.FrontLogonDAO;
import gnnt.MEBS.logonService.model.LogonManagerInfo;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.List;
import java.util.Map;

import org.springframework.jdbc.core.RowMapper;

/**
 * 前台登陆jdbc 实现
 * 
 * @author xuejt
 * 
 */
public class FrontLogonDAOJdbc extends BaseDAOJdbc implements FrontLogonDAO {

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
	public void deleteErrorLogonLogByTraderID(String traderID) {
		String sql = "delete from m_errorloginlog e where trunc(e.logindate)<trunc(sysdate) and e.TraderID=?";

		log.debug("sql: " + sql);
		Object[] params = new Object[] { traderID };

		for (int i = 0; i < params.length; i++)
			log.debug("params[" + i + "]: " + params[i]);

		getJdbcTemplate().update(sql, params);
	}

	@Override
	public int getErrorLoginErrorNum(String traderID) {
		// 查询当天错误登录次数
		String err_sql = "select count(*) from M_ErrorLoginLog e where e.TraderID=? and trunc(e.loginDate)=trunc(sysdate)";

		log.debug("sql: " + err_sql);
		Object[] params = new Object[] { traderID };

		for (int i = 0; i < params.length; i++)
			log.debug("params[" + i + "]: " + params[i]);

		return getJdbcTemplate().queryForInt(err_sql, params);
	}

	@Override
	public Trader getTraderByID(String traderId) {
		String sql = "select t.*,m.name as firmName from m_trader t,m_firm m where t.firmid=m.firmid and t.traderid=? ";
		log.debug("sql: " + sql);
		Object[] params = new Object[] { traderId };

		for (int i = 0; i < params.length; i++)
			log.debug("params[" + i + "]: " + params[i]);

		List<Trader> list = getJdbcTemplate().query(sql, new TraderRowMapper(),
				params);
		if (list != null && list.size() > 0) {
			return list.get(0);
		} else {
			return null;
		}
	}

	private class TraderRowMapper implements RowMapper<Trader> {
		public Trader mapRow(ResultSet rs, int rowNum) throws SQLException {
			Trader trader = new Trader();
			trader.setFirmID(rs.getString("firmID"));
			trader.setCreateTime(rs.getDate("CreateTime"));
			trader.setEnableKey(rs.getString("enableKey"));
			trader.setForceChangePwd(rs.getInt("forceChangePwd"));
			trader.setKeyCode(rs.getString("keyCode"));
			trader.setLastIP(rs.getString("lastIP"));
			trader.setLastTime(rs.getString("lastTime"));
			trader.setModifyTime(rs.getDate("modifyTime"));
			trader.setName(rs.getString("name"));
			trader.setPassword(rs.getString("password"));
			trader.setStatus(rs.getString("status"));
			trader.setTraderID(rs.getString("traderID"));
			trader.setTrustKey(rs.getString("trustKey"));
			trader.setType(rs.getString("type"));
			trader.setFirmName(rs.getString("firmName"));
			return trader;
		}
	}

	@Override
	public TraderModule getTraderModule(int moduleId, String traderId) {
		String sql = "select * from M_TraderModule m where  m.traderid=? and m.moduleid=?";
		log.debug("sql: " + sql);
		Object[] params = new Object[] { traderId, moduleId };

		for (int i = 0; i < params.length; i++)
			log.debug("params[" + i + "]: " + params[i]);

		List<TraderModule> list = getJdbcTemplate().query(sql,
				new TraderModuleRowMapper(), params);
		if (list != null && list.size() > 0) {
			return list.get(0);
		} else {
			return null;
		}
	}

	private class TraderModuleRowMapper implements RowMapper<TraderModule> {
		public TraderModule mapRow(ResultSet rs, int rowNum)
				throws SQLException {
			TraderModule traderModule = new TraderModule();
			traderModule.setModuleId(rs.getString("moduleId"));
			traderModule.setTraderId(rs.getString("traderId"));
			traderModule.setEnabled(rs.getString("enabled"));
			return traderModule;
		}
	}

	@Override
	public void insertErrorLoginlog(ErrorLoginLog errorLoginLog) {
		String sql = "insert into M_ErrorLoginLog(moduleid,logindate,traderId,ip) values(?,sysdate,?,?)";

		Object[] params = new Object[] { errorLoginLog.getModuleId(),
				errorLoginLog.getTraderId(), errorLoginLog.getIp() };

		int[] dataTypes = new int[] { Types.VARCHAR, Types.VARCHAR,
				Types.VARCHAR };

		log.debug("sql=" + sql);
		for (int i = 0; i < params.length; i++)
			logger.debug("params[" + i + "]: " + params[i]);

		getJdbcTemplate().update(sql, params, dataTypes);
	}

	@Override
	public void updateTraderLogonInfo(Trader trader) {

		String sql = "update m_trader set trustkey=?,lastip=?,lasttime = sysdate"
				+ " where traderid = ?";

		Object[] params = new Object[] { trader.getTrustKey(),
				trader.getLastIP(), trader.getTraderID() };

		int[] dataTypes = new int[] { Types.VARCHAR, Types.VARCHAR,
				Types.VARCHAR };

		log.debug("sql=" + sql);
		for (int i = 0; i < params.length; i++)
			logger.debug("params[" + i + "]: " + params[i]);

		getJdbcTemplate().update(sql, params, dataTypes);

	}

	@Override
	public void changePassowrd(String traderID, String password) {
		String sql = "update M_trader set password=?,forceChangePwd=0 where traderId=? ";
		Object[] params = new Object[] { password, traderID };

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

	@Override
	public String getFirmStatus(String firmID) {
		String sql = "select * from M_Firm t  where t.FirmID=? ";
		log.debug("sql: " + sql);
		Object[] params = new Object[] { firmID };

		for (int i = 0; i < params.length; i++)
			log.debug("params[" + i + "]: " + params[i]);

		List<Map<String, Object>> list = getJdbcTemplate().queryForList(sql,
				params);
		if (list != null && list.size() > 0) {
			return list.get(0).get("Status").toString();
		} else {
			return null;
		}
	}

	@Override
	public String getTraderIDByUserID(String userId) {
		String sql = "select traderID from M_Trader t  where t.userID=? ";
		log.debug("sql: " + sql);
		Object[] params = new Object[] { userId };

		for (int i = 0; i < params.length; i++)
			log.debug("params[" + i + "]: " + params[i]);
		List<Map<String, Object>> list = getJdbcTemplate().queryForList(sql,
				params);
		if (list != null && list.size() > 0) {
			return (String) list.get(0).get("traderID");
		} else {
			return null;
		}
	}
}