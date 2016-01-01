package gnnt.MEBS.finance.front.action;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import gnnt.MEBS.common.front.action.StandardAction;
import gnnt.MEBS.common.front.common.Page;
import gnnt.MEBS.common.front.common.PageRequest;
import gnnt.MEBS.common.front.common.QueryConditions;
import gnnt.MEBS.common.front.model.integrated.User;
import gnnt.MEBS.common.front.statictools.ActionUtil;
import gnnt.MEBS.common.front.statictools.Tools;
import gnnt.MEBS.finance.front.model.FundFlowF;
import gnnt.MEBS.finance.front.model.FundFlowHisF;
import gnnt.MEBS.finance.front.model.SummaryF;
import gnnt.MEBS.finance.front.model.SystemModule;

@Controller("firmFundFlowAction")
@Scope("request")
public class FirmFundFlowAction extends StandardAction {
	private static final long serialVersionUID = -6968862613594888662L;

	public String fundFlowList() throws Exception {
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		this.logger.debug("交易员代码firmid=[" + localUser.getBelongtoFirm().getFirmID() + "]");
		String str1 = this.request.getParameter("type");
		if ((str1 != null) && (str1.equals("H"))) {
			this.entity = new FundFlowHisF();
			str1 = "H";
		} else {
			this.entity = new FundFlowF();
			str1 = "D";
		}
		this.request.setAttribute("type", str1);
		PageRequest localPageRequest1 = null;
		try {
			localPageRequest1 = ActionUtil.getPageRequest(this.request);
			((QueryConditions) localPageRequest1.getFilters()).addCondition("firmId", "=", localUser.getBelongtoFirm().getFirmID());
		} catch (Exception localException) {
			this.logger.error(Tools.getExceptionTrace(localException));
		}
		String str2 = this.request.getParameter("balance");
		if ((str2 != null) && (!str2.equals(""))) {
			String str3 = "=";
			if (str2.equals("B")) {
				str3 = ">";
			} else if (str2.equals("S")) {
				str3 = "<";
			}
			this.request.setAttribute("balance", str2);
			((QueryConditions) localPageRequest1.getFilters()).addCondition("balance", str3, Double.valueOf(Double.parseDouble("0")));
		}
		String str3 = this.request.getParameter("amount");
		if ((str3 != null) && (!str3.equals(""))) {
			this.request.setAttribute("amount", str3);
			((QueryConditions) localPageRequest1.getFilters()).addCondition("balance", "=", Double.valueOf(Double.parseDouble(str3)));
		}
		Page localPage1 = getService().getPage(localPageRequest1, this.entity);
		this.request.setAttribute("pageInfo", localPage1);
		this.request.setAttribute("oldParams", ActionUtil.getParametersStartingWith(this.request, "gnnt_"));
		PageRequest localPageRequest2 = new PageRequest(" ");
		Page localPage2 = getService().getPage(localPageRequest2, new SystemModule());
		PageRequest localPageRequest3 = new PageRequest(" ");
		localPageRequest3.setPageSize(1000);
		Page localPage3 = getService().getPage(localPageRequest3, new SummaryF());
		this.request.setAttribute("summaryList", localPage3.getResult());
		this.request.setAttribute("moduleList", localPage2.getResult());
		return "success";
	}
}
