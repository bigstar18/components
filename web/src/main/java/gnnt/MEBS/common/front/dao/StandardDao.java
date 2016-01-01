package gnnt.MEBS.common.front.dao;

import java.sql.SQLException;
import java.sql.Types;
import java.util.Collection;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.stereotype.Repository;

import gnnt.MEBS.common.front.common.ProcedureParameter;
import gnnt.MEBS.common.front.model.StandardModel;

@Repository("com_standardDao")
public class StandardDao extends AbstractDao {
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

	public Object executeProcedure(final String procedureSql, final List<ProcedureParameter> parameterList) throws Exception {
		return getHibernateTemplate().execute(new HibernateCallback<Object>() {
			@SuppressWarnings("deprecation")
			public Object doInHibernate(Session session) throws HibernateException, SQLException {
				java.sql.Connection conn = null;
				java.sql.CallableStatement call = null;
				Map<String, Object> rval = new Hashtable<String, Object>();
				try {

					logger.debug("procedureSql=" + procedureSql);

					// 占位符数量
					int placeholderCount = 0;
					for (int i = 0; i < procedureSql.length(); i++) {
						if (procedureSql.charAt(i) == '?')
							placeholderCount++;
					}

					if (parameterList.size() != placeholderCount) {
						throw new Exception(" parameter  is not equal to placeholderCount ");
					}

					conn = session.connection();
					call = conn.prepareCall(procedureSql);

					for (int i = 0; i < parameterList.size(); i++) {
						ProcedureParameter procedureParameter = parameterList.get(i);
						logger.debug("ParameterType: " + procedureParameter.getParameterType());
						logger.debug("SqlType: " + procedureParameter.getSqlType());
						logger.debug("Value: " + procedureParameter.getValue());
						if (procedureParameter.getParameterType() == ProcedureParameter.INPARAMETER) {
							call.setObject(i + 1, procedureParameter.getValue(), procedureParameter.getSqlType());
						} else {
							call.registerOutParameter(i + 1, procedureParameter.getSqlType());
						}
					}

					if (!call.execute()) {
						// 遍历传入的参数列表，如果为输出类型则将输出值写入到参数对应的Value中
						for (int i = 0; i < parameterList.size(); i++) {
							ProcedureParameter procedureParameter = parameterList.get(i);
							if (procedureParameter.getParameterType() == ProcedureParameter.OUTPARAMETER) {
								if (procedureParameter.getName() != null && procedureParameter.getName().length() > 0) {
									if (!rval.containsKey(procedureParameter.getName())) {
										rval.put(procedureParameter.getName(), call.getObject(i + 1));
									}
								}
							}
						}
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
}
