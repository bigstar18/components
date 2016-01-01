package gnnt.MEBS.common.broker.service;

import gnnt.MEBS.common.broker.common.Page;
import gnnt.MEBS.common.broker.common.PageRequest;
import gnnt.MEBS.common.broker.dao.StandardDao;
import gnnt.MEBS.common.broker.model.StandardModel;
import gnnt.MEBS.common.broker.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.broker.statictools.Tools;
import java.text.SimpleDateFormat;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.Map;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service("com_standardService")
@Transactional(propagation=Propagation.REQUIRED, readOnly=false, rollbackFor={Exception.class})
public class StandardService
{
  protected final transient Log logger = LogFactory.getLog(getClass());
  @Autowired
  @Qualifier("com_standardDao")
  private StandardDao standardDao;
  
  public StandardDao getDao()
  {
    return this.standardDao;
  }
  
  public void add(StandardModel entity)
  {
    this.logger.debug("enter add");
    this.standardDao.add(entity);
  }
  
  public void update(StandardModel entity)
  {
    this.logger.debug("enter update");
    update(entity, false);
  }
  
  public void update(StandardModel entity, boolean isForceUpdate)
  {
    if (!isForceUpdate)
    {
      StandardModel model = entity.clone();
      
      entity = get(entity);
      if (entity != null) {
        Tools.CombinationValue(model, entity);
      } else {
        entity = model;
      }
    }
    this.standardDao.update(entity);
  }
  
  public void delete(StandardModel entity)
  {
    this.logger.debug("enter delete");
    this.standardDao.delete(entity);
  }
  
  public void deleteBYBulk(Collection<StandardModel> entities)
  {
    this.logger.debug("enter deleteBYBulk entities");
    this.standardDao.deleteBYBulk(entities);
  }
  
  public void deleteBYBulk(StandardModel entity, Object[] ids)
  {
    this.logger.debug("enter deleteBYBulk ids");
    if (ids == null) {
      return;
    }
    if (entity == null) {
      throw new IllegalArgumentException("业务对象为空，所以操作表未知，不允许通过主键数组批量删除！");
    }
    if ((entity.fetchPKey() == null) || (entity.fetchPKey().getKey() == null) || 
      (entity.fetchPKey().getKey().length() == 0)) {
      throw new IllegalArgumentException("业务对象未设置主键，不允许通过主键数组批量删除！");
    }
    this.standardDao.deleteBYBulk(entity, ids);
  }
  
  public void updateBYBulk(StandardModel entity, String columnAssignSql, Object[] ids)
  {
    this.logger.debug("enter updateBYBulk ids");
    if (ids == null) {
      return;
    }
    if ("".equals(columnAssignSql)) {
      throw new IllegalArgumentException("要修改的列以及对应的值未知，不允许通过主键数组批量修改！");
    }
    if (entity == null) {
      throw new IllegalArgumentException("业务对象为空，所以操作表未知，不允许通过主键数组批量修改！");
    }
    if ((entity.fetchPKey() == null) || (entity.fetchPKey().getKey() == null) || 
      (entity.fetchPKey().getKey().length() == 0)) {
      throw new IllegalArgumentException("业务对象未设置主键，不允许通过主键数组批量修改！");
    }
    this.standardDao.updateBYBulk(entity, columnAssignSql, ids);
  }
  
  public void executeUpdateBySql(String sql)
  {
    this.standardDao.executeUpdateBySql(sql);
  }
  
  public List<StandardModel> getListByBulk(StandardModel entity, Object[] ids)
  {
    this.logger.debug("enter getListByBulk ids");
    return this.standardDao.getListByBulk(entity, ids);
  }
  
  public StandardModel get(StandardModel entity)
  {
    this.logger.debug("enter get");
    return this.standardDao.get(entity);
  }
  
  public Object executeProcedure(String procedureName, Object[] params)
    throws Exception
  {
    return this.standardDao.executeProcedure(procedureName, params);
  }
  
  public Page<StandardModel> getPage(PageRequest<?> pageRequest, StandardModel entity)
  {
    this.logger.debug("enter getPage");
    return this.standardDao.getPage(pageRequest, entity);
  }
  
  public void reload(Object obj)
  {
    this.standardDao.getHibernateTemplate().flush();
    this.standardDao.getHibernateTemplate().refresh(obj);
  }
  
  public List<StandardModel> getListBySql(String sql, StandardModel entity)
  {
    this.logger.debug("enter getListBySql getListBySql(final String sql,final StandardModel entity)");
    return this.standardDao.queryBySql(sql, entity);
  }
  
  public List<Map<Object, Object>> getListBySql(String sql)
  {
    this.logger.debug("enter getListBySql  getListBySql(final String sql) ");
    return this.standardDao.queryBySql(sql);
  }
  
  public Date getSysDate()
    throws Exception
  {
    this.logger.debug("enter getSysDate  getSysDate() ");
    List<Map<Object, Object>> list = this.standardDao.queryBySql("select to_char(sysdate,'yyyy-MM-dd HH24:MI:SS') as aa from dual");
    Date date = new Date();
    if ((list != null) && (list.size() > 0))
    {
      Map<Object, Object> map = (Map)list.get(0);
      String strDate = (String)map.get("AA");
      SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
      date = formatDate.parse(strDate);
    }
    return date;
  }
}
