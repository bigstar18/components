package gnnt.MEBS.vendue.front.beanforajax;

import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import gnnt.MEBS.common.front.beanforajax.BaseAjax;
import gnnt.MEBS.common.front.common.Page;
import gnnt.MEBS.common.front.common.PageRequest;
import gnnt.MEBS.vendue.front.model.Administrator;

@Controller("ajaxCheckDemo")
@Scope("request")
public class AjaxCheckDemo extends BaseAjax {
	private boolean existAdministrator(String paramString) {
		boolean bool = false;
		if ((paramString == null) || (paramString.trim().length() <= 0)) {
			return bool;
		}
		PageRequest localPageRequest = new PageRequest(" and primary.userId='" + paramString + "'");
		Page localPage = getService().getPage(localPageRequest, new Administrator());
		if ((localPage.getResult() != null) && (localPage.getResult().size() > 0)) {
			bool = true;
		}
		return bool;
	}

	public String mouseCheckAdministrator() {
		HttpServletRequest localHttpServletRequest = getRequest();
		String str1 = localHttpServletRequest.getParameter("fieldId");
		String str2 = localHttpServletRequest.getParameter("fieldValue");
		this.jsonValidateReturn = createJSONArray(new Object[] { str1, Boolean.valueOf(existAdministrator(str2)) });
		return "success";
	}

	private void formCheckAdministrator(BaseAjax.AjaxJSONArrayResponse paramAjaxJSONArrayResponse) {
		HttpServletRequest localHttpServletRequest = getRequest();
		String str = localHttpServletRequest.getParameter("entity.user.userId");
		boolean bool = existAdministrator(str);
		if (!bool) {
			paramAjaxJSONArrayResponse.addJSON(new Object[] { createJSONArray(new Object[] { "userId", Boolean.valueOf(false), "管理员不存在" }) });
		}
	}

	public String formCheckCustomerModelAdd() {
		BaseAjax.AjaxJSONArrayResponse localAjaxJSONArrayResponse = new BaseAjax.AjaxJSONArrayResponse(this, new Object[0]);
		formCheckAdministrator(localAjaxJSONArrayResponse);
		if (localAjaxJSONArrayResponse.size() <= 0) {
			localAjaxJSONArrayResponse.addJSON(new Object[] { createJSONArray(new Object[] { "true" }) });
		}
		this.jsonValidateReturn = localAjaxJSONArrayResponse.toJSONArray();
		return "success";
	}
}
