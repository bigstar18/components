package gnnt.MEBS.common.front.action;

import java.lang.reflect.Field;
import java.lang.reflect.Type;
import java.util.Collection;
import java.util.LinkedList;

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

import com.opensymphony.xwork2.ActionSupport;

import gnnt.MEBS.common.front.common.Page;
import gnnt.MEBS.common.front.common.PageRequest;
import gnnt.MEBS.common.front.common.QueryConditions;
import gnnt.MEBS.common.front.common.ReturnValue;
import gnnt.MEBS.common.front.model.LogCatalog;
import gnnt.MEBS.common.front.model.OperateLog;
import gnnt.MEBS.common.front.model.StandardModel;
import gnnt.MEBS.common.front.model.integrated.User;
import gnnt.MEBS.common.front.service.AbstractService;
import gnnt.MEBS.common.front.service.QueryService;
import gnnt.MEBS.common.front.service.StandardService;
import gnnt.MEBS.common.front.statictools.ActionUtil;

@Controller("com_standardAction")
@Scope("request")
public class StandardAction extends ActionSupport implements ServletRequestAware, ServletResponseAware {
	private static final long serialVersionUID = -2324265780415999469L;
	protected final transient Log logger = LogFactory.getLog(getClass());
	protected HttpServletRequest request;
	protected HttpServletResponse response;
	protected StandardModel entity;
	@Autowired
	@Qualifier("com_standardService")
	private StandardService com_standardService;
	@Autowired
	@Qualifier("com_queryService")
	private QueryService queryService;
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
				e.printStackTrace();
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
		return this.com_standardService;
	}

	public AbstractService getAbstractService(PageRequest<?> pageRequest) {
		AbstractService service = pageRequest.isQueryDB() ? getQueryService() : getService();
		return service;
	}

	public void setStandardService(StandardService standardService) {
		this.com_standardService = standardService;
	}

	public QueryService getQueryService() {
		return this.queryService;
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

		addReturnValue(1, 9910002L);
		return "success";
	}

	public String viewById() throws Exception {
		this.logger.debug("enter viewById");
		PageRequest<QueryConditions> pageRequest = ActionUtil.getPageRequest(this.request);

		AbstractService service = pageRequest.isQueryDB() ? getQueryService() : getService();
		this.entity = service.get(this.entity);

		return "success";
	}

	public String update() {
		this.logger.debug("enter update");
		getService().update(this.entity);

		addReturnValue(1, 9910003L);
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

		addReturnValue(1, 9910004L);
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

			model = this.com_standardService.get(model);
			if (model != null) {
				standardModelList.add(model);
			}
		}
		getService().deleteBYBulk(standardModelList);

		addReturnValue(1, 9910004L);

		return "success";
	}

	public String list() throws Exception {
		this.logger.debug("enter list");
		PageRequest<QueryConditions> pageRequest = ActionUtil.getPageRequest(this.request);

		AbstractService service = pageRequest.isQueryDB() ? getQueryService() : getService();

		Page<StandardModel> page = service.getPage(pageRequest, this.entity);

		this.request.setAttribute("pageInfo", page);

		this.request.setAttribute("oldParams", ActionUtil.getParametersStartingWith(this.request, "gnnt_"));
		return "success";
	}

	public void addReturnValue(int result, long code) {
		addReturnValue(result, code, null);
	}

	public void addReturnValue(int result, long code, Object[] args) {
		addReturnValue(result, code, args, -1);
	}

	public void addReturnValue(int result, long code, Object[] args, int resultType) {
		ReturnValue returnValue = new ReturnValue();
		returnValue.setResult(result);
		returnValue.setResultType(resultType);
		if (args == null) {
			returnValue.addInfo(code);
		} else {
			returnValue.addInfo(code, args);
		}
		this.request.setAttribute("ReturnValue", returnValue);
	}

	public void writeOperateLog(int operateType, String operateContent, int operateResult, String mark) {
		User user = (User) this.request.getSession().getAttribute("CurrentUser");
		OperateLog operateLog = new OperateLog();
		operateLog.setLogType(Integer.valueOf(2));
		LogCatalog logCatalog = new LogCatalog();
		logCatalog.setCatalogID(Integer.valueOf(operateType));
		operateLog.setLogCatalog(logCatalog);
		operateLog.setOperateContent(operateContent);
		operateLog.setOperateResult(Integer.valueOf(operateResult));
		operateLog.setMark(mark);
		operateLog.setOperator(user.getBelongtoFirm().getFirmID());
		operateLog.setOperateIP(user.getIpAddress());
		getService().add(operateLog);
	}
}
