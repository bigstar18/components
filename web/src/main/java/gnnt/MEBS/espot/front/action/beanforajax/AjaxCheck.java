package gnnt.MEBS.espot.front.action.beanforajax;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionContext;

import gnnt.MEBS.common.front.common.Page;
import gnnt.MEBS.common.front.common.PageRequest;
import gnnt.MEBS.common.front.service.StandardService;
import gnnt.MEBS.espot.front.model.trade.Arbitration;
import gnnt.MEBS.espot.front.model.trade.Trade;
import net.sf.json.JSONArray;

@Controller("ajaxCheckBean")
@Scope("request")
public class AjaxCheck {
	@Autowired
	@Qualifier("com_standardService")
	private StandardService standardService;
	private JSONArray jsonValidateReturn;

	public StandardService getService() {
		return this.standardService;
	}

	public JSONArray getJsonValidateReturn() {
		return this.jsonValidateReturn;
	}

	private int checkTradeNo(String paramString1, String paramString2, String paramString3) {
		String str1 = "and tradeNo=" + Long.valueOf(paramString1);
		PageRequest localPageRequest1 = new PageRequest(str1);
		Page localPage1 = this.standardService.getPage(localPageRequest1, new Trade());
		if ((localPage1.getResult() != null) && (localPage1.getResult().size() > 0)) {
			Trade localTrade = (Trade) localPage1.getResult().get(0);
			if (localTrade.getStatus().intValue() == 8) {
				String str2 = "";
				if (!paramString2.equals("3")) {
					str2 = "and (type='1' or type='2')";
				} else {
					str2 = "and type='3'";
				}
				str2 = str2 + " and tradeNo='" + paramString1 + "' and result=0";
				PageRequest localPageRequest2 = new PageRequest(str2);
				Page localPage2 = getService().getPage(localPageRequest2, new Arbitration());
				if ((localPage2.getResult() != null) && (localPage2.getResult().size() > 0)) {
					if (paramString2.equals("3")) {
						return -2;
					}
					return -4;
				}
				if ((null != paramString2) && (paramString2.equals("3"))) {
					if ((paramString3.equals(localTrade.getBfirmID())) || (paramString3.equals(localTrade.getSfirmID()))) {
						return 1;
					}
					return 0;
				}
				if (paramString3.equals(localTrade.getBfirmID())) {
					return 2;
				}
				return -3;
			}
			return -1;
		}
		return 0;
	}

	public String checkTradeNoForFiled() {
		ActionContext localActionContext = ActionContext.getContext();
		HttpServletRequest localHttpServletRequest = (HttpServletRequest) localActionContext
				.get("com.opensymphony.xwork2.dispatcher.HttpServletRequest");
		String str1 = localHttpServletRequest.getParameter("fieldId");
		String str2 = localHttpServletRequest.getParameter("fieldValue");
		String str3 = localHttpServletRequest.getParameter("type");
		String str4 = localHttpServletRequest.getParameter("firmId");
		int i = checkTradeNo(str2, str3, str4);
		Object localObject;
		if (i == 0) {
			localObject = new AjaxValidationFormResponse(str1, Boolean.valueOf(false), "* 合同不存在或已转历史");
			this.jsonValidateReturn = ((AjaxValidationFormResponse) localObject).toJSONArray();
		} else if (i == -1) {
			localObject = new AjaxValidationFormResponse("checkTradeNo", Boolean.valueOf(false), "* 合同不是结束或支付尾款状态");
			this.jsonValidateReturn = ((AjaxValidationFormResponse) localObject).toJSONArray();
		} else if (i == -2) {
			localObject = new AjaxValidationFormResponse("checkTradeNo", Boolean.valueOf(false), "* 此合同已进行投诉申请");
			this.jsonValidateReturn = ((AjaxValidationFormResponse) localObject).toJSONArray();
		} else if (i == -3) {
			localObject = new AjaxValidationFormResponse("checkTradeNo", Boolean.valueOf(false), "* 此合同您不是买方,不能进行退款/货申请");
			this.jsonValidateReturn = ((AjaxValidationFormResponse) localObject).toJSONArray();
		} else if (i == -4) {
			localObject = new AjaxValidationFormResponse("checkTradeNo", Boolean.valueOf(false), "* 此合同已进行退款/货申请");
			this.jsonValidateReturn = ((AjaxValidationFormResponse) localObject).toJSONArray();
		} else if (i == 1) {
			localObject = new AjaxValidationFieldResponse("checkTradeNo", Boolean.valueOf(true));
			this.jsonValidateReturn = ((AjaxValidationFieldResponse) localObject).toJSONArray();
		} else if (i == 2) {
			localObject = new AjaxValidationFieldResponse("checkTradeNo", Boolean.valueOf(true));
			this.jsonValidateReturn = ((AjaxValidationFieldResponse) localObject).toJSONArray();
		}
		return "success";
	}

	public String checkTradeNoForForm() {
		ActionContext localActionContext = ActionContext.getContext();
		HttpServletRequest localHttpServletRequest = (HttpServletRequest) localActionContext
				.get("com.opensymphony.xwork2.dispatcher.HttpServletRequest");
		ArrayList localArrayList = new ArrayList();
		String str1 = localHttpServletRequest.getParameter("checkTradeNo");
		String str2 = localHttpServletRequest.getParameter("type");
		String str3 = localHttpServletRequest.getParameter("firmId");
		int i = checkTradeNo(str1, str2, str3);
		if (i == 0) {
			localArrayList.add(new AjaxValidationFormResponse("checkTradeNo", Boolean.valueOf(false), "* 合同不存在或已转历史"));
		} else if (i == -1) {
			localArrayList.add(new AjaxValidationFormResponse("checkTradeNo", Boolean.valueOf(false), "* 合同不是结束或支付尾款状态"));
		} else if (i == -2) {
			localArrayList.add(new AjaxValidationFormResponse("checkTradeNo", Boolean.valueOf(false), "* 此合同已进行投诉申请"));
		} else if (i == -3) {
			localArrayList.add(new AjaxValidationFormResponse("checkTradeNo", Boolean.valueOf(false), "* 此合同您不是买方,不能进行退款/货申请"));
		} else if (i == -4) {
			localArrayList.add(new AjaxValidationFormResponse("checkTradeNo", Boolean.valueOf(false), "* 此合同已进行退款/货申请"));
		}
		if (localArrayList.size() != 0) {
			this.jsonValidateReturn = genJSON(localArrayList);
		} else {
			this.jsonValidateReturn = new JSONArray();
			this.jsonValidateReturn.add("true");
		}
		return "success";
	}

	public String checkImageSizeForForm() throws Exception {
		ArrayList localArrayList = new ArrayList();
		if (localArrayList.size() != 0) {
			this.jsonValidateReturn = genJSON(localArrayList);
		} else {
			this.jsonValidateReturn = new JSONArray();
			this.jsonValidateReturn.add("true");
		}
		return "success";
	}

	private JSONArray genJSON(ArrayList<AjaxValidationFormResponse> paramArrayList) {
		JSONArray localJSONArray = new JSONArray();
		for (int i = 0; i < paramArrayList.size(); i++) {
			AjaxValidationFormResponse localAjaxValidationFormResponse = (AjaxValidationFormResponse) paramArrayList.get(i);
			localJSONArray.add(localAjaxValidationFormResponse.toJSONArray());
		}
		return localJSONArray;
	}

	public static String getEncoding(String paramString1, String paramString2) {
		if ((paramString1 == null) || (paramString1.trim().length() <= 0)) {
			return paramString1;
		}
		if ((!"GBK".equalsIgnoreCase(paramString2)) && (!"UTF-8".equalsIgnoreCase(paramString2))) {
			paramString2 = "GBK";
		}
		try {
			return new String(paramString1.getBytes(), "UTF-8");
		} catch (UnsupportedEncodingException localUnsupportedEncodingException) {
		}
		return "";
	}

	public class AjaxValidationFormResponse {
		private String id;
		private Boolean status;
		private String error;

		public AjaxValidationFormResponse(String paramString1, Boolean paramBoolean, String paramString2) {
			this.id = paramString1;
			this.status = paramBoolean;
			this.error = paramString2;
		}

		public JSONArray toJSONArray() {
			JSONArray localJSONArray = new JSONArray();
			localJSONArray.add(this.id);
			localJSONArray.add(this.status);
			localJSONArray.add(this.error);
			return localJSONArray;
		}
	}

	public class AjaxValidationFieldResponse {
		private String id;
		private Boolean status;

		public AjaxValidationFieldResponse(String paramString, Boolean paramBoolean) {
			this.id = paramString;
			this.status = paramBoolean;
		}

		public JSONArray toJSONArray() {
			JSONArray localJSONArray = new JSONArray();
			localJSONArray.add(this.id);
			localJSONArray.add(this.status);
			return localJSONArray;
		}
	}
}
