package gnnt.MEBS.common.broker.dao;

import java.sql.SQLException;
import java.sql.Types;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.hibernate.transform.Transformers;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import org.springframework.stereotype.Repository;

import gnnt.MEBS.common.broker.common.Page;
import gnnt.MEBS.common.broker.common.PageRequest;
import gnnt.MEBS.common.broker.common.QueryConditions;
import gnnt.MEBS.common.broker.model.StandardModel;

@Repository("com_standardDao")
public class StandardDao extends HibernateDaoSupport {
	protected final transient Log logger = LogFactory.getLog(getClass());

	@Resource(name = "sessionFactory")
	public void setSuperSessionFactory(SessionFactory sessionFactory) {
		super.setSessionFactory(sessionFactory);
	}

	public void add(StandardModel entity) {
		this.logger.debug("enter add");
		getHibernateTemplate().save(entity);
	}

	public void update(StandardModel entity) {
		this.logger.debug("enter update");
		getHibernateTemplate().update(entity);
	}

	public void delete(StandardModel entity) {
		this.logger.debug("enter delete");
		getHibernateTemplate().delete(entity);
	}

	public void deleteBYBulk(Collection<StandardModel> entities) {
		this.logger.debug("enter deleteBYBulk by getHibernateTemplate().deleteAll");
		getHibernateTemplate().deleteAll(entities);
	}

	public void deleteBYBulk(StandardModel entity, final Object[] ids) {
		this.logger.debug("enter deleteBYBulk");
		final String queryString = "delete " + entity.getClass().getName() + " where " + entity.fetchPKey().getKey() + " in (:ids) ";
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException, SQLException {
				Query query = session.createQuery(queryString);
				query.setParameterList("ids", ids);
				return Integer.valueOf(query.executeUpdate());
			}
		});
	}

	public void updateBYBulk(StandardModel entity, String columnAssignSql, final Object[] ids) {
		this.logger.debug("enter updateBYBulk");
		final String queryString = "update " + entity.getClass().getName() + " set " + columnAssignSql + " where " + entity.fetchPKey().getKey()
				+ " in (:ids) ";
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException, SQLException {
				Query query = session.createQuery(queryString);
				query.setParameterList("ids", ids);
				return Integer.valueOf(query.executeUpdate());
			}
		});
	}

	public void executeUpdateBySql(final String sql) {
		this.logger.debug("enter executeUpdateBySql");
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException, SQLException {
				Query query = session.createSQLQuery(sql);
				return Integer.valueOf(query.executeUpdate());
			}
		});
	}

	public List<StandardModel> getListByBulk(StandardModel entity, final Object[] ids) {
		this.logger.debug("enter getListByBulk");
		if (entity == null) {
			throw new IllegalArgumentException("业务对象为空，所以操作表未知，不允许通过主键数组批量查询！");
		}
		if ((entity.fetchPKey() == null) || (entity.fetchPKey().getKey() == null) || (entity.fetchPKey().getKey().length() == 0)) {
			throw new IllegalArgumentException("业务对象未设置主键，不允许通过主键数组批量查询！");
		}
		final StandardModel model = entity.clone();
		return getHibernateTemplate().executeFind(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException, SQLException {
				return

				session.createCriteria(model.getClass()).add(Restrictions.in(model.fetchPKey().getKey(), ids)).list();
			}
		});
	}

	public StandardModel get(StandardModel entity) {
		this.logger.debug("enter get");
		if (entity.fetchPKey() != null) {
			return (StandardModel) getHibernateTemplate().get(entity.getClass(), entity.fetchPKey().getValue());
		}
		return (StandardModel) getHibernateTemplate().get(entity.getClass(), entity);
	}

	public Page<StandardModel> getPage(PageRequest<?> pageRequest, StandardModel entity) {
		this.logger.debug("enter getPage");
		if (pageRequest == null) {
			throw new IllegalArgumentException("pageRequest 不允许为空");
		}
		if (entity == null) {
			throw new IllegalArgumentException("entity 不允许为空");
		}
		String hql = " from " + entity.getClass().getName() + " as primary where 1=1 ";

		Object[] params = (Object[]) null;
		if ((pageRequest.getFilters() instanceof String)) {
			String filter = (String) pageRequest.getFilters();
			hql = hql + filter;
		} else if ((pageRequest.getFilters() instanceof QueryConditions)) {
			QueryConditions conditions = (QueryConditions) pageRequest.getFilters();
			if ((conditions != null) && (conditions.getFieldsSqlClause() != null)) {
				params = conditions.getValueArray();
				hql = hql + " and " + conditions.getFieldsSqlClause();
			}
		}
		return queryByHQL(hql, params, pageRequest, null);
	}

	public List<StandardModel> queryBySql(final String sql, final StandardModel entity) {
		List list = (List) getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException, SQLException {
				Query query = session.createSQLQuery(sql).addEntity(entity.getClass());
				return query.list();
			}
		});
		return list;
	}

	public List<Map<Object, Object>> queryBySql(final String sql) {
		List list = (List) getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException, SQLException {
				Query query = session.createSQLQuery(sql).setResultTransformer(Transformers.ALIAS_TO_ENTITY_MAP);
				return query.list();
			}
		});
		return list;
	}

	public int executeProcedure(final String procedureName, final Map<String, Object> map) {
		return ((Integer) getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException, SQLException {
				Query query = session.getNamedQuery(procedureName);
				for (String key : map.keySet()) {
					query.setParameter(key, map.get(key));
				}
				int count = ((Number) query.uniqueResult()).intValue();
				return Integer.valueOf(count);
			}
		})).intValue();
	}

	public Object executeProcedure(final String procedureSql, final Object params[]) throws Exception {
		return getHibernateTemplate().execute(new HibernateCallback<Object>() {
			@SuppressWarnings("deprecation")
			public Object doInHibernate(Session session) throws HibernateException, SQLException {
				java.sql.Connection conn = null;
				java.sql.CallableStatement call = null;
				Object rval = null;
				try {

					logger.debug("procedureSql=" + procedureSql);

					for (int i = 0; i < params.length; i++)
						logger.debug("params[" + i + "]: " + params[i]);

					conn = session.connection();
					call = conn.prepareCall(procedureSql);
					call.registerOutParameter(1, Types.NUMERIC);

					int i = 0;
					for (int j = 2; i < params.length; j++) {
						call.setObject(j, params[i]);
						i++;
					}

					if (!call.execute()) {
						rval = call.getObject(1);
					}
				} catch (Exception e) {
					logger.debug("Failed executing procedureSql:" + procedureSql);
					logger.error("Error Message:" + e.getMessage());
					// throw e;
				} finally {
					try {
						call.close();
					} catch (Exception e) {
					}
					try {
						conn.close();
					} catch (Exception e) {
					}
				}
				return rval;
			}
		});
	}

	public void flush() {
		getHibernateTemplate().flush();
	}

	public void evict(StandardModel entity) {
		getHibernateTemplate().evict(entity);
	}

	private Page<StandardModel> queryByHQL(String hql, Object[] params, PageRequest<?> pageRequest, QueryCallback queryCallback) {
		this.logger.debug("enter queryByHQL!");
		int totalRecords = totalRow(hql, params);

		int startCount = (pageRequest.getPageNumber() - 1) * pageRequest.getPageSize();

		hql = hql + pageRequest.getSortColumns();

		int pageSize = pageRequest.getPageSize();

		List<StandardModel> list = findAllByHQL(startCount, pageSize, hql, params, queryCallback);

		Page<StandardModel> page = new Page(pageRequest.getPageNumber(), pageRequest.getPageSize(), totalRecords, list);
		return page;
	}

	private List<StandardModel> findAllByHQL(final int startCount, final int pageSize, final String hql, final Object[] params,
			final QueryCallback queryCallback) {
		return getHibernateTemplate().executeFind(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException, SQLException {
				StandardDao.this.logger.debug("findAllByHQL:" + hql);
				Query query = session.createQuery(hql);
				if ((params != null) && (params.length > 0)) {
					for (int i = 0; i < params.length; i++) {
						StandardDao.this.logger.debug("   params[i]:" + params[i]);
						query.setParameter(i, params[i]);
					}
				}
				query.setFirstResult(startCount);
				query.setMaxResults(pageSize);
				if (queryCallback != null) {
					queryCallback.doInQuery(query);
				}
				return query.list();
			}
		});
	}

	private int totalRow(String hql, final Object[] params) {
		if (!hql.trim().startsWith("from")) {
			throw new IllegalArgumentException("hql必须以from开头");
		}
		final String hqlCount = "select count(*) " + hql;

		return ((Integer) getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException, SQLException {
				StandardDao.this.logger.debug("count hql:" + hqlCount);
				Query query = session.createQuery(hqlCount);
				if ((params != null) && (params.length > 0)) {
					for (int i = 0; i < params.length; i++) {
						StandardDao.this.logger.debug("   params[i]:" + params[i]);
						query.setParameter(i, params[i]);
					}
				}
				StandardDao.this.logger.debug("--------------------" + query.uniqueResult());
				int count = ((Number) query.uniqueResult()).intValue();
				StandardDao.this.logger.debug("count:" + count);
				return Integer.valueOf(count);
			}
		})).intValue();
	}
}
