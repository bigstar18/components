package gnnt.MEBS.common.front.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import org.hibernate.transform.Transformers;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import gnnt.MEBS.common.front.common.Page;
import gnnt.MEBS.common.front.common.PageRequest;
import gnnt.MEBS.common.front.common.QueryConditions;
import gnnt.MEBS.common.front.model.StandardModel;

public abstract class AbstractDao extends HibernateDaoSupport {
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
			try {
				return (StandardModel) getHibernateTemplate().get(entity.getClass(), entity.fetchPKey().getValue());
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println(e.getMessage());
			}
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

	public void flush() {
		getHibernateTemplate().flush();
	}

	public void evict(StandardModel entity) {
		getHibernateTemplate().evict(entity);
	}

	public Page<StandardModel> queryByHQL(String hql, Object[] params, PageRequest<?> pageRequest, QueryCallback queryCallback) {
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
				AbstractDao.this.logger.debug("findAllByHQL:" + hql);
				Query query = session.createQuery(hql);
				if ((params != null) && (params.length > 0)) {
					for (int i = 0; i < params.length; i++) {
						AbstractDao.this.logger.debug("   params[i]:" + params[i]);
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
				AbstractDao.this.logger.debug("count hql:" + hqlCount);
				Query query = session.createQuery(hqlCount);
				if ((params != null) && (params.length > 0)) {
					for (int i = 0; i < params.length; i++) {
						AbstractDao.this.logger.debug("   params[i]:" + params[i]);
						query.setParameter(i, params[i]);
					}
				}
				AbstractDao.this.logger.debug("--------------------");
				int count = ((Number) query.uniqueResult()).intValue();
				AbstractDao.this.logger.debug("count:" + count);
				return Integer.valueOf(count);
			}
		})).intValue();
	}
}
