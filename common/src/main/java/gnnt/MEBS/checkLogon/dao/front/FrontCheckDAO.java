package gnnt.MEBS.checkLogon.dao.front;

import gnnt.MEBS.checkLogon.dao.BaseDAOJdbc;
import gnnt.MEBS.checkLogon.dao.ObjectRowMapper;
import gnnt.MEBS.checkLogon.po.front.DictionaryPO;
import gnnt.MEBS.checkLogon.po.front.TraderPO;
import java.util.List;
import java.util.Map;
import org.apache.commons.logging.Log;
import org.springframework.jdbc.core.JdbcTemplate;

public class FrontCheckDAO
  extends BaseDAOJdbc
{
  public DictionaryPO getDictionaryByKey(String key)
  {
    String sql = "select * from L_Dictionary where key=?";
    Object[] params = { key };
    
    this.logger.debug("sql:" + sql);
    for (int i = 0; i < params.length; i++) {
      this.logger.debug("params[" + i + "]:" + params[i]);
    }
    List<DictionaryPO> list = getJdbcTemplate().query(sql, params, new ObjectRowMapper(new DictionaryPO()));
    if ((list != null) && (list.size() > 0)) {
      return (DictionaryPO)list.get(0);
    }
    return null;
  }
  
  public void addGlobalLog(String operator, String operatorIP, int operatorType, String operatorContent, int operatorResult)
  {
    String sql = "insert into c_globallog_all(id,operator,operatetime,operatetype,operateip,operatecontent,operateresult)  values(SEQ_C_GLOBALLOG.Nextval,?, sysdate,?,?,?,?)";
    
    Object[] params = { operator, Integer.valueOf(operatorType), operatorIP, 
      operatorContent, Integer.valueOf(operatorResult) };
    int[] types = { 12, 4, 12, 
      12, 4 };
    
    this.logger.debug("sql: " + sql);
    for (int i = 0; i < params.length; i++) {
      this.logger.debug("params[" + i + "]: " + params[i]);
    }
    getJdbcTemplate().update(sql, params, types);
  }
  
  public String getTraderIDByUserID(String userID)
  {
    String sql = "select traderID from M_Trader t  where t.userID=? ";
    Object[] params = { userID };
    
    this.logger.debug("sql: " + sql);
    for (int i = 0; i < params.length; i++) {
      this.logger.debug("params[" + i + "]: " + params[i]);
    }
    List<Map<String, Object>> list = getJdbcTemplate().queryForList(sql, params);
    if ((list != null) && (list.size() > 0)) {
      return (String)((Map)list.get(0)).get("traderID");
    }
    return null;
  }
  
  public TraderPO getTraderByID(String traderID)
  {
    String sql = "select t.*,m.name as firmName from m_trader t,m_firm m where t.firmid=m.firmid and t.traderid=? ";
    Object[] params = { traderID };
    
    this.logger.debug("sql: " + sql);
    for (int i = 0; i < params.length; i++) {
      this.logger.debug("params[" + i + "]: " + params[i]);
    }
    List<TraderPO> list = getJdbcTemplate().query(sql, new ObjectRowMapper(new TraderPO()), 
      params);
    if ((list != null) && (list.size() > 0)) {
      return (TraderPO)list.get(0);
    }
    return null;
  }
  
  public String getFirmStatus(String firmID)
  {
    String sql = "select Status from M_Firm t  where t.FirmID=? ";
    Object[] params = { firmID };
    
    this.logger.debug("sql: " + sql);
    for (int i = 0; i < params.length; i++) {
      this.logger.debug("params[" + i + "]: " + params[i]);
    }
    List<Map<String, Object>> list = getJdbcTemplate().queryForList(sql, params);
    if ((list != null) && (list.size() > 0)) {
      return (String)((Map)list.get(0)).get("Status");
    }
    return null;
  }
  
  public String getTraderModuleEnable(String traderID, int moduleID)
  {
    String sql = "select Enabled from M_TraderModule m where  m.traderid=? and m.moduleid=?";
    Object[] params = { traderID, Integer.valueOf(moduleID) };
    
    this.logger.debug("sql: " + sql);
    for (int i = 0; i < params.length; i++) {
      this.logger.debug("params[" + i + "]: " + params[i]);
    }
    List<Map<String, Object>> list = getJdbcTemplate().queryForList(sql, params);
    if ((list != null) && (list.size() > 0)) {
      return (String)((Map)list.get(0)).get("Enabled");
    }
    return null;
  }
  
  public void updateTraderLogonInfo(String trustKey, String lastIP, String traderID)
  {
    String sql = "update m_trader set trustkey=?,lastip=?,lasttime = sysdate where traderid = ?";
    Object[] params = { trustKey, lastIP, traderID };
    int[] types = { 12, 12, 12 };
    
    this.logger.debug("sql: " + sql);
    for (int i = 0; i < params.length; i++) {
      this.logger.debug("params[" + i + "]: " + params[i]);
    }
    getJdbcTemplate().update(sql, params, types);
  }
  
  public void updateTraderPassword(String traderID, String password)
  {
    String sql = "update m_trader set password=?,forceChangePwd=0 where traderid = ?";
    Object[] params = { password, traderID };
    int[] types = { 12, 12 };
    
    this.logger.debug("sql: " + sql);
    for (int i = 0; i < params.length; i++) {
      this.logger.debug("params[" + i + "]: " + params[i]);
    }
    getJdbcTemplate().update(sql, params, types);
  }
  
  public void insertErrorLoginlog(String traderID, int moduleID, String logonIP)
  {
    String sql = "insert into M_ErrorLoginLog(moduleid,logindate,traderId,ip) values(?,sysdate,?,?)";
    Object[] params = { Integer.valueOf(moduleID), traderID, logonIP };
    int[] types = { 2, 12, 12 };
    
    this.logger.debug("sql: " + sql);
    for (int i = 0; i < params.length; i++) {
      this.logger.debug("params[" + i + "]: " + params[i]);
    }
    getJdbcTemplate().update(sql, params, types);
  }
  
  public int getErrorLoginErrorNum(String traderID)
  {
    String sql = "select count(*) from M_ErrorLoginLog e where e.TraderID=? and trunc(e.loginDate)=trunc(sysdate)";
    Object[] params = { traderID };
    
    this.logger.debug("sql:" + sql);
    for (int i = 0; i < params.length; i++) {
      this.logger.debug("params[" + i + "]:" + params[i]);
    }
    return getJdbcTemplate().queryForInt(sql, params);
  }
  
  public void clearErrorLogonLog(String traderID)
  {
    String sql = "delete from M_ErrorLoginLog where TraderID=? or trunc(loginDate)<trunc(sysdate)";
    Object[] params = { traderID };
    int[] types = { 12 };
    
    this.logger.debug("sql:" + sql);
    for (int i = 0; i < params.length; i++) {
      this.logger.debug("params[" + i + "]:" + params[i]);
    }
    getJdbcTemplate().update(sql, params, types);
  }
}
