package gnnt.MEBS.logonService.dao.jdbc;


import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.jdbc.core.support.JdbcDaoSupport;

/**
 * 通用的DAO接口实现，为所有的DAO提供通用的方法.
 * @author xuejt
 *
 */
public class BaseDAOJdbc extends JdbcDaoSupport{
    protected final Log log = LogFactory.getLog(getClass());
    
}

