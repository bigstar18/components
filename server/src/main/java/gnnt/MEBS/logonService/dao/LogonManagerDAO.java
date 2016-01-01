
package gnnt.MEBS.logonService.dao;

import gnnt.MEBS.logonService.po.LogonConfigPO;
import gnnt.MEBS.logonService.po.ModuleAndAUPO;

import java.util.List;


/**
 * <P>类说明：登录业务 DAO
 * <br/>
 * <br/>
 * </p>
 * 修改记录:
 * <br/>
 * <ul>
 * 
 * <li> 创建类                    |2014-4-18下午02:15:24|金网安泰 </li>
 * 
 * </ul>
 * @author liuzx
 */
public class LogonManagerDAO extends BaseDAOJdbc{

	/**
	 * 
	 * 通过编号查询 AU 配置信息
	 * <br/><br/>
	 * @param configID
	 * @return
	 */
	public LogonConfigPO getLogonConfigByID(int configID){
		String sql = "select * from L_AUConfig where configID=?";
		Object[] params = new Object[]{configID};

		logger.debug("sql:"+sql);
		for(int i=0;i<params.length;i++){
			logger.debug("params["+i+"]"+params[i]);
		}

		List<LogonConfigPO> list = getJdbcTemplate().query(sql, params,new ObjectRowMapper<LogonConfigPO>(new LogonConfigPO()));
		if(list != null && list.size() > 0){
			return list.get(0);
		}

		return null;
	}
	/**
	 * 通过系统名称获取系统 AU
	 * @param sysname
	 * @return
	 */
	public List<LogonConfigPO> getLogonConfigList(String sysname){
		String sql = "select * from L_AUConfig where Sysname=? and HostIP is not null";
		Object[] params = new Object[]{sysname};

		logger.debug("sql:"+sql);
		for(int i=0;i<params.length;i++){
			logger.debug("params["+i+"]"+params[i]);
		}

		return getJdbcTemplate().query(sql, params,new ObjectRowMapper<LogonConfigPO>(new LogonConfigPO()));
	}

	/**
	 * 
	 * 通过AU 类型查询跟本 AU 同一端的所有模块、 AU 对应关系
	 * <br/><br/>
	 * @param sysname
	 * @return
	 */
	public List<ModuleAndAUPO> getModuleAndAUList(String sysname){
		String sql = "select m.* from L_AUConfig a,L_ModuleAndAU m where m.ConfigID=a.ConfigID and a.Sysname=? order by m.ModuleID,m.ConfigID";
		Object[] params = new Object[]{sysname};

		logger.debug("sql:"+sql);
		for(int i=0;i<params.length;i++){
			logger.debug("params["+i+"]"+params[i]);
		}

		return getJdbcTemplate().query(sql, params,new ObjectRowMapper<ModuleAndAUPO>(new ModuleAndAUPO()));
	}

	/**
	 * 
	 * 通过模块编号和AU类型查询跟本 AU 同一端的所有模块、 AU 对应关系
	 * <br/><br/>
	 * @param moduleID
	 * @param sysname
	 * @return
	 */
	public List<ModuleAndAUPO> getModuleAndAUList(int moduleID,String sysname){
		String sql = "select m.* from L_AUConfig a,L_ModuleAndAU m where m.ConfigID=a.ConfigID and a.Sysname=? and m.ModuleID=? order by m.ConfigID";
		Object[] params = new Object[]{sysname,moduleID};

		logger.debug("sql:"+sql);
		for(int i=0;i<params.length;i++){
			logger.debug("params["+i+"]"+params[i]);
		}

		return getJdbcTemplate().query(sql, params,new ObjectRowMapper<ModuleAndAUPO>(new ModuleAndAUPO()));
	}
}

