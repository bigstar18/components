package gnnt.MEBS.bill.mgr.action.stockmanage.interceptor;

import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;

import gnnt.MEBS.bill.mgr.model.usermanage.MFirm;
import gnnt.MEBS.common.mgr.common.Page;
import gnnt.MEBS.common.mgr.common.PageRequest;
import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.service.StandardService;

public class WarehouseIdInterceptor extends AbstractInterceptor {
	private static final long serialVersionUID = 1L;
	private final transient Log logger = LogFactory.getLog(WarehouseIdInterceptor.class);
	@Autowired
	@Qualifier("standardService")
	private StandardService standardService;

	public StandardService getStandardService() {
		return this.standardService;
	}

	public String intercept(ActionInvocation actioninvocation) throws Exception {
		logger.debug("enter   TradeRightInterceptor");
		ActionContext actioncontext = actioninvocation.getInvocationContext();
		HttpServletRequest httpservletrequest = (HttpServletRequest) actioncontext.get("com.opensymphony.xwork2.dispatcher.HttpServletRequest");
		PageRequest pagerequest = new PageRequest(" order by primary.firmId");
		pagerequest.setPageSize(0x186a0);
		Page page = standardService.getPage(pagerequest, new MFirm());
		String s = "";
		if (page.getResult() != null && page.getResult().size() > 0) {
			for (Iterator iterator = page.getResult().iterator(); iterator.hasNext();) {
				StandardModel standardmodel = (StandardModel) iterator.next();
				MFirm mfirm = (MFirm) standardmodel;
				s = (new StringBuilder()).append(s).append("\"").append(mfirm.getFirmId()).append("\",").toString();
			}

			s = (new StringBuilder()).append("[").append(s.substring(0, s.length() - 1)).append("]").toString();
		}
		httpservletrequest.setAttribute("json", s);
		String s1 = actioninvocation.invoke();
		return s1;

	}
}
