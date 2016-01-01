package gnnt.MEBS.common.broker.action;

import java.lang.reflect.Field;
import java.lang.reflect.Type;
import java.util.Collection;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.Map;
import java.util.TreeMap;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.util.Assert;

import com.opensymphony.xwork2.ActionSupport;

import gnnt.MEBS.common.broker.common.Page;
import gnnt.MEBS.common.broker.common.PageRequest;
import gnnt.MEBS.common.broker.common.QueryConditions;
import gnnt.MEBS.common.broker.common.ReturnValue;
import gnnt.MEBS.common.broker.model.LogCatalog;
import gnnt.MEBS.common.broker.model.OperateLog;
import gnnt.MEBS.common.broker.model.StandardModel;
import gnnt.MEBS.common.broker.model.User;
import gnnt.MEBS.common.broker.service.StandardService;
import gnnt.MEBS.common.broker.statictools.Tools;

@Controller("com_standardAction")
@Scope("request")
public class StandardAction extends ActionSupport implements ServletRequestAware, ServletResponseAware {
	private static final long serialVersionUID = -2324265780415999469L;
	protected final transient Log logger = LogFactory.getLog(getClass());
	public static final String PARAMETERPREFIX = "gnnt_";
	public static final String PAGESIZE = "pageSize";
	public static final String PAGENUMBER = "pageNo";
	public static final String SORTCOLUMNS = "sortColumns";
	public static final String PAGEINFO = "pageInfo";
	public static final String OLDPARAMETER = "oldParams";
	protected HttpServletRequest request;
	protected HttpServletResponse response;
	protected StandardModel entity;
	@Autowired
	@Qualifier("com_standardService")
	private StandardService standardService;
	private String auditType;

	public void setEntityName(String entityName) {
		if ((entityName == null) || (entityName.length() == 0)) {
			throw new IllegalArgumentException("业务对象实体类名称不允许为null!");
		}
		if (this.entity == null) {
			try {
				this.entity = ((StandardModel) Class.forName(entityName).newInstance());
			} catch (Exception e) {
				this.logger.error("实例化" + entityName + "发生错误，错误信息：" + e.getMessage());
				this.logger.error(Tools.getExceptionTrace(e));
				throw new IllegalArgumentException("无法实例化" + entityName + "!");
			}
		}
	}

	public void setServletRequest(HttpServletRequest request) {
		this.request = request;
	}

	public void setServletResponse(HttpServletResponse response) {
		this.response = response;
	}

	public StandardService getService() {
		return this.standardService;
	}

	public void setStandardService(StandardService standardService) {
		this.standardService = standardService;
	}

	public void setEntity(StandardModel entity) {
		this.entity = entity;
	}

	public StandardModel getEntity() {
		return this.entity;
	}

	public void setAuditType(String auditType) {
		this.auditType = auditType;
	}

	public String getAuditType() {
		return this.auditType;
	}

	public String forwardAdd() {
		return "success";
	}

	public String add() {
		this.logger.debug("enter add");
		getService().add(this.entity);

		addReturnValue(1, 119901L);
		return "success";
	}

	public String viewById() {
		this.logger.debug("enter viewById");
		this.entity = getService().get(this.entity);

		return "success";
	}

	public String update() {
		this.logger.debug("enter update");
		getService().update(this.entity);

		addReturnValue(1, 119902L);
		return "success";
	}

	public String delete() throws SecurityException, NoSuchFieldException {
		this.logger.debug("enter delete");
		String[] ids = this.request.getParameterValues("ids");
		if ((ids == null) || (ids.length == 0)) {
			throw new IllegalArgumentException("删除主键数组不能为空！");
		}
		if (this.entity == null) {
			throw new IllegalArgumentException("业务对象为空，所以操作表未知，不允许通过主键数组批量删除！");
		}
		if ((this.entity.fetchPKey() == null) || (this.entity.fetchPKey().getKey() == null) || (this.entity.fetchPKey().getKey().length() == 0)) {
			throw new IllegalArgumentException("业务对象未设置主键，不允许通过主键数组批量删除！");
		}
		Type keyType = this.entity.getClass().getDeclaredField(this.entity.fetchPKey().getKey()).getType();
		Object[] objIds;
		if (keyType.equals(Long.class)) {
			objIds = new Long[ids.length];
			for (int i = 0; i < ids.length; i++) {
				objIds[i] = Long.valueOf(ids[i]);
			}
		} else if (keyType.equals(Integer.class)) {
			objIds = new Integer[ids.length];
			for (int i = 0; i < ids.length; i++) {
				objIds[i] = Integer.valueOf(ids[i]);
			}
		} else {
			objIds = ids;
		}
		getService().deleteBYBulk(this.entity, objIds);

		addReturnValue(1, 119903L);
		return "success";
	}

	public String deleteCollection() throws SecurityException, NoSuchFieldException, InstantiationException, IllegalAccessException {
		this.logger.debug("enter delete");
		String[] ids = this.request.getParameterValues("ids");
		if ((ids == null) || (ids.length == 0)) {
			throw new IllegalArgumentException("删除主键数组不能为空！");
		}
		if (this.entity == null) {
			throw new IllegalArgumentException("业务对象为空，所以操作表未知，不允许集合 批量删除数据！");
		}
		if ((this.entity.fetchPKey() == null) || (this.entity.fetchPKey().getKey() == null) || (this.entity.fetchPKey().getKey().length() == 0)) {
			throw new IllegalArgumentException("业务对象未设置主键，不允许通过集合 批量删除数据！");
		}
		Type keyType = this.entity.getClass().getDeclaredField(this.entity.fetchPKey().getKey()).getType();
		Object[] objIds;
		if (keyType.equals(Long.class)) {
			objIds = new Long[ids.length];
			for (int i = 0; i < ids.length; i++) {
				objIds[i] = Long.valueOf(ids[i]);
			}
		} else if (keyType.equals(Integer.class)) {
			objIds = new Integer[ids.length];
			for (int i = 0; i < ids.length; i++) {
				objIds[i] = Integer.valueOf(ids[i]);
			}
		} else {
			objIds = ids;
		}
		Collection<StandardModel> standardModelList = new LinkedList();
		Object[] arrayOfObject1;
		int j = (arrayOfObject1 = objIds).length;
		for (int i = 0; i < j; i++) {
			Object object = arrayOfObject1[i];

			StandardModel model = (StandardModel) this.entity.getClass().newInstance();

			String key = model.fetchPKey().getKey();

			Field filed = model.getClass().getDeclaredField(key);
			if (!filed.isAccessible()) {
				filed.setAccessible(true);
			}
			filed.set(model, object);

			model = this.standardService.get(model);
			if (model != null) {
				standardModelList.add(model);
			}
		}
		getService().deleteBYBulk(standardModelList);

		addReturnValue(1, 119903L);

		return "success";
	}

	public String list() throws Exception {
		this.logger.debug("enter list");
		PageRequest<QueryConditions> pageRequest = getPageRequest(this.request);
		Page<StandardModel> page = getService().getPage(pageRequest, this.entity);
		this.request.setAttribute("pageInfo", page);

		this.request.setAttribute("oldParams", getParametersStartingWith(this.request, "gnnt_"));
		return "success";
	}

	public void addReturnValue(int result, long code) {
		addReturnValue(result, code, null);
	}

	public void addReturnValue(int result, long code, Object[] args) {
		ReturnValue returnValue = new ReturnValue();
		returnValue.setResult(result);
		if (args == null) {
			returnValue.addInfo(code);
		} else {
			returnValue.addInfo(code, args);
		}
		this.request.setAttribute("ReturnValue", returnValue);
	}

	public void writeOperateLog(int catalogID, String content, int operateResult, String mark) {
		OperateLog operateLog = new OperateLog();

		User user = (User) this.request.getSession().getAttribute("CurrentUser");

		operateLog.setOperator(user.getUserId());
		operateLog.setOperateIp(user.getIpAddress());
		try {
			operateLog.setOperateTime(getService().getSysDate());
		} catch (Exception e) {
			this.logger.error(Tools.getExceptionTrace(e));
		}
		LogCatalog lCatalog = new LogCatalog();
		lCatalog.setCatalogID(Integer.valueOf(catalogID));
		operateLog.setLogCatalog(lCatalog);
		operateLog.setOperateContent(content);
		operateLog.setOperateResult(Integer.valueOf(operateResult));
		operateLog.setMark(mark);
		getService().add(operateLog);
	}

	protected PageRequest<QueryConditions> getPageRequest(HttpServletRequest request) throws Exception {
		PageRequest<QueryConditions> pageRequest = new PageRequest();

		pageRequest.setPageNumber(Tools.strToInt(request.getParameter("pageNo"), 1));

		pageRequest.setPageSize(Tools.strToInt(request.getParameter("pageSize"), 1000));

		pageRequest.setSortColumns(request.getParameter("sortColumns"));

		pageRequest.setFilters(getQueryConditionsFromRequest(request));

		return pageRequest;
	}

	protected QueryConditions getQueryConditionsFromRequest(HttpServletRequest request) throws Exception {
		QueryConditions qc = new QueryConditions();

		this.logger.debug("enter getQueryConditionsFromReq...");

		Map<String, Object> mapForParameters = getParametersStartingWith(request, "gnnt_");

		Map<String, String> mapForAttribute = getAttributeStartingWith(request, "gnnt_");

		mapForParameters.putAll(mapForAttribute);
		if ((mapForParameters != null) && (mapForParameters.size() > 0)) {
			this.logger.debug("parameter size:" + mapForParameters.size());

			Pattern pOperatorDatatype = Pattern.compile("(.+?)\\[(.+)]\\[(.+)]");

			Pattern pOperator = Pattern.compile("(.+?)\\[(.+)]");
			for (Iterator<String> it = mapForParameters.keySet().iterator(); it.hasNext();) {
				String key = (String) it.next();
				Object value = mapForParameters.get(key);
				this.logger.debug("parameter:" + key);
				Matcher m = pOperatorDatatype.matcher(key);
				String type;
				String param;
				String op;
				if (m.matches()) {
					param = m.group(1);
					op = m.group(2);
					type = m.group(3);
				} else {
					m = pOperator.matcher(key);
					if (m.matches()) {
						param = m.group(1);
						op = m.group(2);
						type = null;
					} else {
						param = null;
						op = null;
						type = null;
					}
				}
				if ((param != null) && (value != null) && (((String) value).trim().length() > 0)) {
					if ((value instanceof String)) {
						value = value.toString().trim();
					}
					if (qc == null) {
						qc = new QueryConditions();
					}
					if (type != null) {
						value = Tools.convert(value, type);
						if ((type.equals("simpledate")) && (op.equals("="))) {
							param = "trunc(" + param + ")";
						}
					}
					this.logger.debug("field:" + param);
					this.logger.debug("operator:" + op);
					this.logger.debug("datatype:" + type);
					this.logger.debug("value:" + value);
					qc.addCondition(param, op, value);
				}
			}
		}
		return qc;
	}

	protected Map<String, Object> getParametersStartingWith(ServletRequest request, String prefix) {
		Assert.notNull(request, "Request must not be null");
		Enumeration<?> paramNames = request.getParameterNames();
		Map<String, Object> params = new TreeMap();
		if (prefix == null) {
			prefix = "";
		}
		while ((paramNames != null) && (paramNames.hasMoreElements())) {
			String paramName = (String) paramNames.nextElement();
			if (("".equals(prefix)) || (paramName.startsWith(prefix))) {
				String unprefixed = paramName.substring(prefix.length());
				String[] values = request.getParameterValues(paramName);
				if ((values != null) && (values.length != 0)) {
					if (values.length > 1) {
						params.put(unprefixed, values);
					} else {
						params.put(unprefixed, values[0]);
					}
				}
			}
		}
		return params;
	}

	protected Map<String, String> getAttributeStartingWith(ServletRequest request, String prefix) {
		Enumeration<?> namesEnumeration = request.getAttributeNames();
		Map<String, String> params = new TreeMap();
		if (prefix == null) {
			prefix = "";
		}
		while ((namesEnumeration != null) && (namesEnumeration.hasMoreElements())) {
			String paramName = (String) namesEnumeration.nextElement();
			if (("".equals(prefix)) || (paramName.startsWith(prefix))) {
				String unprefixed = paramName.substring(prefix.length());

				String value = (String) request.getAttribute(paramName);
				if (value != null) {
					params.put(unprefixed, value.trim());
				}
			}
		}
		return params;
	}
}
