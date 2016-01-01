package gnnt.MEBS.finance.front.action;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import gnnt.MEBS.common.front.action.StandardAction;
import gnnt.MEBS.common.front.common.Page;
import gnnt.MEBS.common.front.common.PageRequest;
import gnnt.MEBS.common.front.common.QueryConditions;
import gnnt.MEBS.common.front.model.integrated.User;
import gnnt.MEBS.common.front.statictools.ActionUtil;
import gnnt.MEBS.common.front.statictools.Tools;
import gnnt.MEBS.finance.front.model.LedgerField;
import gnnt.MEBS.finance.front.model.SystemModule;

@Controller("clientLedgerAction")
@Scope("request")
public class ClientLedgerAction extends StandardAction {
	private static final long serialVersionUID = 2008642717200489838L;

	public String fundLedger() {
		this.logger.debug("enter fundLedger");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		PageRequest localPageRequest1 = null;
		try {
			localPageRequest1 = ActionUtil.getPageRequest(this.request);
		} catch (Exception localException) {
			localException.printStackTrace();
		}
		((QueryConditions) localPageRequest1.getFilters()).addCondition("firmId", "=", localUser.getBelongtoFirm().getFirmID());
		String str1 = this.request.getParameter("beginDate");
		String str2 = this.request.getParameter("endDate");
		if ((str1 != null) && (!str1.equals(""))) {
			Date localObject = Tools.strToDate(new SimpleDateFormat("yyyy-MM-dd"), str1);
			((QueryConditions) localPageRequest1.getFilters()).addCondition("b_Date", ">=", localObject);
		}
		if ((str2 != null) && (!str2.equals(""))) {
			Date localObject = Tools.strToDate(new SimpleDateFormat("yyyy-MM-dd"), str2);
			((QueryConditions) localPageRequest1.getFilters()).addCondition("b_Date", "<=", localObject);
		}
		if (((str1 == null) || (str1.equals(""))) && ((str2 == null) || (str2.equals("")))) {
			str1 = str2 = Tools.fmtDate(new Date());
			((QueryConditions) localPageRequest1.getFilters()).addCondition("primary.b_Date", ">=",
					Tools.strToDate(new SimpleDateFormat("yyyy-MM-dd"), str1));
			((QueryConditions) localPageRequest1.getFilters()).addCondition("primary.b_Date", "<=",
					Tools.strToDate(new SimpleDateFormat("yyyy-MM-dd"), str2));
		}
		Object localObject = getService().getPage(localPageRequest1, this.entity);
		this.request.setAttribute("pageInfo", localObject);
		this.request.setAttribute("oldParams", ActionUtil.getParametersStartingWith(this.request, "gnnt_"));
		String str3 = "";
		String str4 = this.request.getParameter("moduleId");
		if ((str4 != null) && (!"".equals(str4))) {
			str3 = " and moduleId=" + str4;
		}
		String str5 = "select t.* from f_ledgerfield t where 1=1 " + str3 + " order by t.ordernum";
		List localList = getService().getListBySql(str5, new LedgerField());
		this.logger.debug("大小:" + localList.size());
		this.request.setAttribute("fieldList", localList);
		PageRequest localPageRequest2 = new PageRequest(" ");
		Page localPage = getService().getPage(localPageRequest2, new SystemModule());
		this.request.setAttribute("moduleList", localPage.getResult());
		this.request.setAttribute("moduleId", str4);
		this.request.setAttribute("beginDate", str1);
		this.request.setAttribute("endDate", str2);
		return "success";
	}
}
