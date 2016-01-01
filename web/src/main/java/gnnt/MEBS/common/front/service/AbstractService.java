package gnnt.MEBS.common.front.service;

import gnnt.MEBS.common.front.common.Page;
import gnnt.MEBS.common.front.common.PageRequest;
import gnnt.MEBS.common.front.dao.AbstractDao;
import gnnt.MEBS.common.front.model.StandardModel;
import gnnt.MEBS.common.front.statictools.Tools;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.orm.hibernate3.HibernateTemplate;

public abstract class AbstractService
{
  protected final transient Log logger = LogFactory.getLog(getClass());
  private AbstractDao abstractDao;
  
  public void setAbstractDao(AbstractDao abstractDao)
  {
    this.abstractDao = abstractDao;
  }
  
  public List<StandardModel> getListByBulk(StandardModel entity, Object[] ids)
  {
    this.logger.debug("enter getListByBulk ids");
    return this.abstractDao.getListByBulk(entity, ids);
  }
  
  public StandardModel get(StandardModel entity)
  {
    this.logger.debug("enter get");
    return this.abstractDao.get(entity);
  }
  
  public Page<StandardModel> getPage(PageRequest<?> pageRequest, StandardModel entity)
  {
    this.logger.debug("enter getPage");
    return this.abstractDao.getPage(pageRequest, entity);
  }
  
  public List<StandardModel> getListBySql(String sql, StandardModel entity)
  {
    this.logger.debug("enter getListBySql getListBySql(final String sql,final StandardModel entity)");
    return this.abstractDao.queryBySql(sql, entity);
  }
  
  public List<Map<Object, Object>> getListBySql(String sql)
  {
    this.logger.debug("enter getListBySql  getListBySql(final String sql) ");
    return this.abstractDao.queryBySql(sql);
  }
  
  private static long retime = 0L;
  private static long lasttime = 0L;
  
  public Date getSysDate()
  {
    Date now = new Date();
    long pasttime = 60000L;
    Date date = new Date();
    if ((now.getTime() - lasttime > pasttime) || (lasttime - now.getTime() > pasttime))
    {
      lasttime = now.getTime();
      this.logger.debug("enter getSysDate  getSysDate() ");
      List<Map<Object, Object>> list = this.abstractDao.queryBySql("select to_char(sysdate,'yyyy-MM-dd HH24:MI:SS') dbtime from dual");
      if ((list != null) && (list.size() > 0))
      {
        Map<Object, Object> map = (Map)list.get(0);
        String strDate = (String)map.get("DBTIME");
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        try
        {
          date = formatDate.parse(strDate);
          retime = date.getTime() - now.getTime();
        }
        catch (ParseException e)
        {
          this.logger.error(Tools.getExceptionTrace(e));
        }
      }
    }
    else
    {
      date = new Date(now.getTime() + retime);
    }
    return date;
  }
  
  public void reload(Object obj)
  {
    this.abstractDao.getHibernateTemplate().flush();
    this.abstractDao.getHibernateTemplate().refresh(obj);
  }
}
