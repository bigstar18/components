package gnnt.MEBS.vendue.mgr.beanforajax;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import gnnt.MEBS.common.mgr.beanforajax.BaseAjax;

@Controller("ajaxCheckTenderSubmitAction")
@Scope("request")
public class AjaxCheckTenderSubmitAction extends BaseAjax {
	public String formCheckTenderSubmit() {
		HttpServletRequest localHttpServletRequest = getRequest();
		String str1 = localHttpServletRequest.getParameter("sum");
		String str2 = localHttpServletRequest.getParameter("code");
		String str3 = localHttpServletRequest.getParameter("partitionid");
		if ((str1 != null) && (str1.length() > 0) && (str2 != null) && (str2.length() > 0) && (str3 != null) && (str3.length() > 0)) {
			long l1 = Long.parseLong(str1);
			int i = Integer.parseInt(str3);
			List localList1 = getService().getListBySql("select Amount from v_commodity where code=" + str2 + "and tradePartition=" + i);
			if ((localList1 != null) && (localList1.size() > 0)) {
				Map localMap1 = (Map) localList1.get(0);
				Object localObject1 = localMap1.get("AMOUNT");
				if (localObject1 != null) {
					long l2 = Long.parseLong(localObject1.toString());
					long l3 = 0L;
					long l4 = 0L;
					List localList2 = getService()
							.getListBySql("select ConfirmAmount from v_curSubmitTenderPlan where Code=" + str2 + "and tradePartition=" + i);
					if ((localList2 != null) && (localList2.size() > 0)) {
						Iterator localObject2 = localList2.iterator();
						while (((Iterator) localObject2).hasNext()) {
							Map localMap2 = (Map) ((Iterator) localObject2).next();
							Object localObject3 = localMap2.get("CONFIRMAMOUNT");
							if (localObject3 != null) {
								l3 = Long.parseLong(localObject3.toString());
								l4 += l3;
							}
						}
					}
					Object localObject2 = new HashMap();
					if (l4 + l1 > l2) {
						((Map) localObject2).put("resault", Boolean.valueOf(false));
					} else {
						((Map) localObject2).put("resault", Boolean.valueOf(true));
					}
					this.jsonValidateReturn = createJSONArray(new Object[] { localObject2 });
				}
			}
		}
		return "success";
	}
}
