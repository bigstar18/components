package gnnt.MEBS.finance.front.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import gnnt.MEBS.common.front.action.StandardAction;
import gnnt.MEBS.common.front.common.Page;
import gnnt.MEBS.common.front.common.PageRequest;
import gnnt.MEBS.common.front.model.integrated.User;
import gnnt.MEBS.common.front.statictools.ActionUtil;
import gnnt.MEBS.common.front.statictools.Tools;
import gnnt.MEBS.finance.front.model.LedgerField;
import gnnt.MEBS.finance.front.model.SystemModule;

@Controller("clientLedgerSumAction")
@Scope("request")
public class ClientLedgerSumAction extends StandardAction {
	private static final long serialVersionUID = -1580217480584285099L;

	public String clientLedgerSum() throws Exception {
		String str1 = this.request.getParameter("beginDate");
		String str2 = this.request.getParameter("endDate");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		String str3 = localUser.getBelongtoFirm().getFirmID();
		String str4 = this.request.getParameter("gnnt_moduleId");
		String str5 = "";
		String str6 = "where 1=1  and firmId = '" + str3 + "'";
		if ((str1 == null) || ("".equals(str1))) {
			str1 = Tools.fmtDate(new Date());
		}
		this.request.setAttribute("beginDate", str1);
		if ((str2 == null) || ("".equals(str2))) {
			str2 = Tools.fmtDate(new Date());
		}
		this.request.setAttribute("endDate", str2);
		if ((str1 != null) && (!"".equals(str1))) {
			str6 = str6 + " and b_date >=to_date('" + str1 + "','yyyy-MM-dd')";
		}
		if ((str2 != null) && (!"".equals(str2))) {
			str6 = str6 + " and b_date <=to_date('" + str2 + "','yyyy-MM-dd')";
		}
		if ((str4 != null) && (!"".equals(str4))) {
			str5 = " and moduleId=" + str4;
		}
		String str7 = "select t.* from f_ledgerfield t where 1=1 " + str5 + " order by t.ordernum";
		List localList = getService().getListBySql(str7, new LedgerField());
		String[] arrayOfString1 = null;
		String[] arrayOfString2 = null;
		if ((localList != null) && (localList.size() > 0)) {
			arrayOfString2 = new String[localList.size()];
			arrayOfString1 = new String[localList.size()];
			for (int i = 0; i < localList.size(); i++) {
				String localObject2 = ((LedgerField) localList.get(i)).getCode();
				String localObject3 = ((LedgerField) localList.get(i)).getFieldSign().toString();
				arrayOfString2[i] = localObject2;
				arrayOfString1[i] = localObject3;
			}
		}
		Object localObject1 = new ArrayList();
		Object localObject4;
		if (arrayOfString2 != null) {
			String localObject2 = "todayBalance-lastBalance-(";
			String localObject3 = ", sum(decode(code,'e_x_t',value,0)) e_x_t";
			String str8 = "select lastBalance,todayBalance,lastWarranty,todayWarranty,lastData.firmid ";
			String str9;
			for (int k = 0; k < arrayOfString2.length; k++) {
				str9 = arrayOfString2[k];
				str8 = str8 + " ,nvl(ledgerSum." + str9 + ",0) " + str9 + " ";
			}
			str8 = str8 + " from (select lastBalance,lastWarranty,firmId,b_date from f_firmbalance " + str6
					+ ") lastData,(select todayBalance,todayWarranty,firmId,b_date from f_firmbalance " + str6
					+ ") todayData,(select  firmId,max(b_date) maxDate,min(b_date) minDate from f_firmbalance " + str6
					+ " group by firmId) firmDate,(select firmid lfirmid";
			for (int k = 0; k < arrayOfString2.length; k++) {
				str9 = arrayOfString2[k];
				String str10 = arrayOfString1[k];
				String str11 = ((String) localObject3).replaceAll("e_x_t", str9);
				str8 = str8 + str11;
				localObject2 = (String) localObject2 + "+(" + str10 + ")*" + str9;
			}
			str8 = str8 + " from f_clientledger f ";
			str8 = str8 + str6;
			str8 = str8
					+ " group by firmid) ledgerSum where firmDate.firmid=ledgerSum.lfirmid(+)  and lastData.firmId=firmDate.firmId and firmDate.minDate=lastData.b_Date and firmDate.firmId=todayData.Firmid and firmDate.maxDate=todayData.b_Date";
			localObject4 = "select a.*";
			if ((str5 != null) && (!"".equals(str5))) {
				localObject4 = (String) localObject4 + ",(" + (String) localObject2 + ")) other";
			}
			localObject4 = (String) localObject4 + " from (" + str8 + ") a order by firmId";
			this.logger.debug("sql-------" + (String) localObject4);
			localObject1 = getService().getListBySql((String) localObject4);
		}
		Object localObject2 = new PageRequest(" ");
		Object localObject3 = getService().getPage((PageRequest) localObject2, new SystemModule());
		this.request.setAttribute("moduleList", ((Page) localObject3).getResult());
		this.request.setAttribute("listValue",
				(localObject1 != null) && (((List) localObject1).size() > 0) ? (Map) ((List) localObject1).get(0) : new HashMap());
		if ((localList != null) && (localList.size() > 0)) {
			for (int j = 0; j < localList.size(); j++) {
				localObject4 = (LedgerField) localList.get(j);
				((LedgerField) localObject4).setCode(((LedgerField) localObject4).getCode().toUpperCase());
			}
		}
		this.request.setAttribute("fieldList", localList);
		this.request.setAttribute("oldParams", ActionUtil.getParametersStartingWith(this.request, "gnnt_"));
		return "success";
	}
}
