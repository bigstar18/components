package gnnt.MEBS.vendue.mgr.beanforajax;

import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import gnnt.MEBS.common.mgr.beanforajax.BaseAjax;
import gnnt.MEBS.common.mgr.common.Page;
import gnnt.MEBS.common.mgr.common.PageRequest;
import gnnt.MEBS.common.mgr.common.QueryConditions;
import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.statictools.Tools;
import gnnt.MEBS.vendue.mgr.model.MFirm;

@Controller("ajaxQueryDemo")
@Scope("request")
public class AjaxQueryDemo extends BaseAjax {
	public String getfirmListJson() {
		this.logger.debug("------getfirmListJson------查询交易商代码，将其封装成 json 串返回---------");
		HttpServletRequest localHttpServletRequest = getRequest();
		String str1 = localHttpServletRequest.getParameter("firmId");
		int i = Tools.strToInt(localHttpServletRequest.getParameter("type"), -1);
		String str2 = localHttpServletRequest.getParameter("status");
		QueryConditions localQueryConditions = new QueryConditions();
		if ((str1 != null) && (str1.trim().length() > 0)) {
			localQueryConditions.addCondition("firmId", "like", str1);
		}
		if (i >= 0) {
			localQueryConditions.addCondition("type", "=", Integer.valueOf(i));
		}
		if ((str2 != null) && (str2.trim().length() > 0)) {
			localQueryConditions.addCondition("status", "=", str2);
		}
		PageRequest localPageRequest = new PageRequest(1, 100000, localQueryConditions, " order by primary.firmId ");
		Page localPage = getService().getPage(localPageRequest, new MFirm());
		if ((localPage != null) && (localPage.getResult() != null) && (localPage.getResult().size() > 0)) {
			BaseAjax.AjaxJSONArrayResponse localAjaxJSONArrayResponse = new BaseAjax.AjaxJSONArrayResponse(this, new Object[0]);
			Iterator localIterator = localPage.getResult().iterator();
			while (localIterator.hasNext()) {
				StandardModel localStandardModel = (StandardModel) localIterator.next();
				MFirm localMFirm = (MFirm) localStandardModel;
				localAjaxJSONArrayResponse.addJSON(new Object[] { localMFirm.getFirmId() });
			}
			this.jsonValidateReturn = localAjaxJSONArrayResponse.toJSONArray();
		}
		return "success";
	}

	public String listBreedProperty() {
		this.logger.debug("enter ajaxquery for breedPropertyList");
		try {
			HttpServletRequest localHttpServletRequest = getRequest();
			String str1 = localHttpServletRequest.getParameter("breedId");
			String str2 = "select p.propertyid,p.propertyname from m_breedprops mb,m_property p where mb.breedid = '" + str1
					+ "' and mb.propertyid = p.propertyid " + "group by p.propertyname,p.propertyid order by p.propertyid";
			List localList = getService().getListBySql(str2);
			Map[] arrayOfMap = new Map[localList.size()];
			for (int i = 0; i < localList.size(); i++) {
				arrayOfMap[i] = ((Map) localList.get(i));
			}
			this.jsonValidateReturn = createJSONArray(arrayOfMap);
		} catch (Exception localException) {
			localException.printStackTrace();
		}
		return "success";
	}
}
