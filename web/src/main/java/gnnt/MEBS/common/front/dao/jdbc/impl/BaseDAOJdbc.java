package gnnt.MEBS.common.front.dao.jdbc.impl;

import gnnt.MEBS.common.front.common.Page;
import gnnt.MEBS.common.front.common.PageRequest;
import gnnt.MEBS.common.front.common.QueryConditions;
import gnnt.MEBS.common.front.dao.jdbc.DAO;
import java.util.ArrayList;
import java.util.List;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.support.JdbcDaoSupport;

public class BaseDAOJdbc
  extends JdbcDaoSupport
  implements DAO
{
  protected final Log log = LogFactory.getLog(getClass());
  
  public Page<?> getPage(String sql, PageRequest<?> pageRequest, RowMapper<?> rowMapper)
  {
    Object[] params = (Object[])null;
    if (pageRequest != null) {
      if ((pageRequest.getFilters() instanceof String))
      {
        String filter = (String)pageRequest.getFilters();
        sql = sql + filter;
      }
      else if ((pageRequest.getFilters() instanceof QueryConditions))
      {
        QueryConditions conditions = 
          (QueryConditions)pageRequest.getFilters();
        if ((conditions != null) && 
          (conditions.getFieldsSqlClause() != null))
        {
          params = conditions.getValueArray();
          sql = sql + " and " + conditions.getFieldsSqlClause();
        }
      }
    }
    return queryBySQL(sql, params, pageRequest, rowMapper);
  }
  
  public Page<?> queryBySQL(String sql, Object[] params, PageRequest<?> pageRequest, RowMapper<?> rowMapper)
  {
    this.logger.debug("Query Start!");
    int totalRecords = 0;
    
    this.logger.debug("select count(*) cnt from (" + sql + ") t");
    if (params != null) {
      totalRecords = getJdbcTemplate().queryForInt(
        "select count(*) cnt from (" + sql + ") t", params);
    } else {
      totalRecords = getJdbcTemplate().queryForInt(
        "select count(*) cnt from (" + sql + ") t");
    }
    if (pageRequest != null)
    {
      boolean isPageQuery = pageRequest.getPageSize() > 0;
      
      String orderByStr = " ";
      if ((pageRequest.getSortColumns() != null) && 
        (pageRequest.getSortColumns().length() > 0)) {
        orderByStr = " " + pageRequest.getSortColumns();
      }
      int startCount = (pageRequest.getPageNumber() - 1) * 
        pageRequest.getPageSize() + 1;
      int endCount = pageRequest.getPageNumber() * 
        pageRequest.getPageSize();
      if (isPageQuery)
      {
        String pageSql = "select * from (select rownum num,t.* from ( select * from (" + 
          sql + 
          ") " + 
          orderByStr + 
          ") t ) " + 
          "where num between " + 
          startCount + 
          " and " + 
          endCount;
        sql = pageSql;
      }
      else
      {
        sql = sql + orderByStr;
      }
    }
    List<?> resultList = null;
    if ((pageRequest != null) && (totalRecords == 0))
    {
      resultList = new ArrayList();
    }
    else
    {
      if (params != null)
      {
        if (rowMapper != null) {
          resultList = getJdbcTemplate().query(sql, params, 
            rowMapper);
        } else {
          resultList = getJdbcTemplate().queryForList(sql, 
            params);
        }
      }
      else if (rowMapper != null) {
        resultList = getJdbcTemplate().query(sql, rowMapper);
      } else {
        resultList = getJdbcTemplate().queryForList(sql);
      }
      this.logger.debug(sql);
    }
    Page<?> page = new Page(pageRequest
      .getPageNumber(), pageRequest.getPageSize(), totalRecords, resultList);
    
    return page;
  }
}
