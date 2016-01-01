package gnnt.MEBS.common.front.webFrame.strutsInterceptor;

import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;

import gnnt.MEBS.common.front.action.StandardAction;
import gnnt.MEBS.common.front.common.Global;
import gnnt.MEBS.common.front.common.ReturnValue;
import gnnt.MEBS.common.front.model.OperateLog;
import gnnt.MEBS.common.front.model.StandardModel;
import gnnt.MEBS.common.front.model.front.Right;
import gnnt.MEBS.common.front.model.integrated.User;
import gnnt.MEBS.common.front.service.RightService;
import gnnt.MEBS.common.front.service.StandardService;
import gnnt.MEBS.common.front.statictools.ApplicationContextInit;
import gnnt.MEBS.common.front.statictools.GnntBeanFactory;
import gnnt.MEBS.common.front.statictools.Tools;

public class WriteLogInterceptor extends AbstractInterceptor {
	private static final long serialVersionUID = 8669997795536485487L;
	private final transient Log logger = LogFactory.getLog(WriteLogInterceptor.class);

	public String intercept(ActionInvocation invocation) throws Exception {
		ActionContext actionContext = invocation.getInvocationContext();
		HttpServletRequest request = (HttpServletRequest) actionContext.get("com.opensymphony.xwork2.dispatcher.HttpServletRequest");

		String url = request.getServletPath();

		Right right = getRightByUrl(Global.getRightTree(), url);

		StandardAction action = (StandardAction) invocation.getAction();

		StandardModel entity = action.getEntity();

		StandardService service = action.getService();

		OperateLog operateLog = null;
		if ((right != null) && ("Y".equalsIgnoreCase(right.getIsWriteLog())) && (right.getLogCatalog().getCatalogID().intValue() != 0)) {
			operateLog = new OperateLog();
			operateLog.setLogType(Integer.valueOf(2));

			User user = (User) request.getSession().getAttribute("CurrentUser");

			operateLog.setOperator(user.getTraderID());
			operateLog.setOperateIP(user.getIpAddress());
			operateLog.setOperateTime(new Date());
			operateLog.setLogCatalog(right.getLogCatalog());
			operateLog.setOperatorType(user.getType());

			String operateContent = "";

			String method = invocation.getProxy().getMethod();
			if (method.contains("add")) {
				operateContent = getAddLogDescription(entity);
			} else if (method.contains("delete")) {
				operateContent = getDeleteLogDescription(entity, request, service);
			} else if (method.contains("update")) {
				operateContent = getUpdateLogDescription(entity, service);
			} else if (method.contains("viewById")) {
				operateContent = getForUpdateLogDescription(entity);
			} else if (method.contains("forwardAdd")) {
				operateContent = getForAddLogDescription(entity, right);
			} else if (method.contains("list")) {
				operateContent = getListLogDescription(right);
			} else {
				operateContent = "点击菜单" + right.getName();
			}
			operateLog.setOperateContent(operateContent);
			if (entity != null) {
				operateLog.setCurrentValue(entity.serialize());
			}
		}
		request.setAttribute("operateLog", operateLog);

		String result = invocation.invoke();
		if (operateLog != null) {
			if (result.equals("success")) {
				operateLog.setOperateResult(Integer.valueOf(1));
			} else {
				ReturnValue returnValue = (ReturnValue) request.getAttribute("ReturnValue");
				if ((returnValue != null) && (returnValue.getResult() == -1)) {
					operateLog.setMark("失败原因:" + returnValue.getInfo());
				}
			}
			service.add(operateLog);
		}
		return result;
	}

	private String getAddLogDescription(StandardModel entity) {
		return "添加数据：" + entity.translate();
	}

	private String getDeleteLogDescription(StandardModel entity, HttpServletRequest request, StandardService service) {
		String[] ids = request.getParameterValues("ids");
		if ((ids != null) && (ids.length > 0)) {
			Type keyType = String.class.getGenericSuperclass();
			try {
				if ((entity != null) && (entity.fetchPKey() != null) && (entity.fetchPKey().getKey() != null)) {
					keyType = entity.getClass().getDeclaredField(entity.fetchPKey().getKey()).getType();
				} else {
					String result = "删除数据：";
					if (ids != null) {
						result = result + "[";
						for (int i = 0; i < ids.length; i++) {
							if (i > 0) {
								result = result + ",";
							}
							result = result + ids[i];
						}
					}
					return result + "]";
				}
			} catch (SecurityException e) {
				this.logger.error(Tools.getExceptionTrace(e));
			} catch (NoSuchFieldException e) {
				this.logger.error(Tools.getExceptionTrace(e));
			}
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
			List<StandardModel> list = service.getListByBulk(entity, objIds);
			String description = "";
			for (StandardModel standardModel : list) {
				description = description + "删除数据：" + standardModel.translate();
			}
			return description;
		}
		return "删除数据：" + entity.translate();
	}

	private String getUpdateLogDescription(StandardModel entity, StandardService service) {
		if ((entity != null) && (entity.fetchPKey().getValue() != null)) {
			StandardModel model = service.get(entity);
			return "更新数据," + model.compareTranslate(entity);
		}
		return "更新数据，未获取到实体对象";
	}

	private String getForUpdateLogDescription(StandardModel entity) {
		return "为了更新查询数据：" + entity.translate();
	}

	private String getForAddLogDescription(StandardModel entity, Right right) {
		return "打开(" + right.getName() + ")的添加页面";
	}

	private String getListLogDescription(Right right) {
		return "点击菜单" + right.getName() + "获取列表";
	}

	private Right getRightByUrl(Right right, String url) {
		if (right == null) {
			return null;
		}
		if (url.equals(right.getUrl())) {
			return right;
		}
		if ((right.getUrl() != null) && (right.getUrl().endsWith("*"))) {
			if (right.getType().intValue() == 0) {
				if (right.getVisiturl().equals(url)) {
					return right;
				}
			} else {
				String tempUrl = right.getUrl().substring(0, right.getUrl().length() - 1);
				if (url.contains(tempUrl)) {
					return right;
				}
			}
		}
		if ((right.getChildRightSet() != null) && (right.getChildRightSet().size() > 0)) {
			for (Right childRight : right.getChildRightSet()) {
				Right resultRight = getRightByUrl(childRight, url);
				if (resultRight != null) {
					return resultRight;
				}
			}
		}
		return null;
	}

	private Right getRightByUrl(List<Right> rightList, String url) {
		if (rightList == null) {
			return null;
		}
		for (Right right : rightList) {
			if (url.equals(right.getUrl())) {
				return right;
			}
			if ((right.getUrl() != null) && (right.getUrl().endsWith("*"))) {
				if (right.getType().intValue() == 0) {
					if (right.getVisiturl().equals(url)) {
						return right;
					}
				} else {
					Pattern pattern = Pattern.compile(right.getUrl().replaceAll("\\*", ".*"));
					Matcher matcher = pattern.matcher(url);
					if (matcher.find()) {
						return right;
					}
				}
			}
		}
		return null;
	}

	private List<Right> getRightList(Right right) {
		List<Right> rightList = new ArrayList();
		if (right == null) {
			return null;
		}
		rightList.add(right);
		if ((right.getChildRightSet() != null) && (right.getChildRightSet().size() > 0)) {
			for (Right childRight : right.getChildRightSet()) {
				rightList.addAll(getRightList(childRight));
			}
		}
		return rightList;
	}

	public static void main(String[] args) {
		GnntBeanFactory.getBeanFactory();
		RightService rightService = (RightService) ApplicationContextInit.getBean("rightService");
		Right rightTree = rightService.loadRightTree();

		WriteLogInterceptor writeLogInterceptor = new WriteLogInterceptor();

		long startTime = System.currentTimeMillis();
		long times = 100000L;
		for (int i = 0; i < times; i++) {
			writeLogInterceptor.getRightByUrl(rightTree, "/user/update.action");
		}
		System.out.println("使用递归算法计算" + times + "次花费时间：" + (System.currentTimeMillis() - startTime) + "毫秒");

		List<Right> rightList = writeLogInterceptor.getRightList(rightTree);
		startTime = System.currentTimeMillis();
		for (int i = 0; i < times; i++) {
			writeLogInterceptor.getRightByUrl(rightList, "/role/delete.sss");
		}
		System.out.println("使用迭代算法计算" + times + "次花费时间：" + (System.currentTimeMillis() - startTime) + "毫秒");
	}
}
