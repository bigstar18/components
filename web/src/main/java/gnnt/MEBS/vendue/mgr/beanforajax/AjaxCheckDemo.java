package gnnt.MEBS.vendue.mgr.beanforajax;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionContext;

import gnnt.MEBS.common.mgr.beanforajax.BaseAjax;
import gnnt.MEBS.common.mgr.common.Page;
import gnnt.MEBS.common.mgr.common.PageRequest;
import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.vendue.mgr.model.MFirm;
import gnnt.MEBS.vendue.mgr.model.firmSet.specialSet.SpecialFee;
import gnnt.MEBS.vendue.mgr.model.firmSet.specialSet.SpecialFeeId;
import gnnt.MEBS.vendue.mgr.model.firmSet.specialSet.SpecialMargin;
import gnnt.MEBS.vendue.mgr.model.firmSet.specialSet.SpecialMarginId;
import gnnt.MEBS.vendue.mgr.model.firmSet.tradeUser.TradeUserModel;
import gnnt.MEBS.vendue.mgr.model.system.flowcontrol.FlowControl;
import gnnt.MEBS.vendue.mgr.model.system.flowcontrol.FlowcontrolId;
import net.sf.json.JSONArray;

@Controller("ajaxCheckDemo")
@Scope("request")
public class AjaxCheckDemo extends BaseAjax {
	private boolean existFirmFirmId(String paramString) {
		boolean bool = false;
		if ((paramString == null) || (paramString.trim().length() <= 0)) {
			return bool;
		}
		PageRequest localPageRequest = new PageRequest(" and primary.firmId='" + paramString + "'");
		Page localPage = getService().getPage(localPageRequest, new MFirm());
		if ((localPage.getResult() != null) && (localPage.getResult().size() > 0)) {
			bool = true;
		}
		return bool;
	}

	public String mouseCheckFirmByFirmId() {
		HttpServletRequest localHttpServletRequest = getRequest();
		String str1 = localHttpServletRequest.getParameter("fieldId");
		String str2 = localHttpServletRequest.getParameter("fieldValue");
		this.jsonValidateReturn = createJSONArray(new Object[] { str1, Boolean.valueOf(existFirmFirmId(str2)) });
		return "success";
	}

	private void formCheckFirmByFirmId(BaseAjax.AjaxJSONArrayResponse paramAjaxJSONArrayResponse) {
		HttpServletRequest localHttpServletRequest = getRequest();
		String str = localHttpServletRequest.getParameter("entity.firm.firmId");
		boolean bool = existFirmFirmId(str);
		if (!bool) {
			paramAjaxJSONArrayResponse.addJSON(new Object[] { createJSONArray(new Object[] { "firm_firmId", Boolean.valueOf(false), "交易商不存在" }) });
		}
	}

	public String formCheckFirm() {
		BaseAjax.AjaxJSONArrayResponse localAjaxJSONArrayResponse = new BaseAjax.AjaxJSONArrayResponse(this, new Object[0]);
		formCheckFirmByFirmId(localAjaxJSONArrayResponse);
		if (localAjaxJSONArrayResponse.size() <= 0) {
			localAjaxJSONArrayResponse.addJSON(new Object[] { createJSONArray(new Object[] { "true" }) });
		}
		this.jsonValidateReturn = localAjaxJSONArrayResponse.toJSONArray();
		return "success";
	}

	private boolean existModelId(Object paramObject, StandardModel paramStandardModel) {
		boolean bool = false;
		List localList = getService().getListByBulk(paramStandardModel, new Object[] { paramObject });
		if ((localList != null) && (localList.size() > 0)) {
			bool = true;
		}
		return bool;
	}

	private JSONArray getJSONArray(Object... paramVarArgs) {
		JSONArray localJSONArray = new JSONArray();
		for (Object localObject : paramVarArgs) {
			localJSONArray.add(localObject);
		}
		return localJSONArray;
	}

	private JSONArray getJSONArrayList(JSONArray... paramVarArgs) {
		JSONArray localJSONArray1 = new JSONArray();
		for (JSONArray localJSONArray2 : paramVarArgs) {
			localJSONArray1.add(localJSONArray2);
		}
		return localJSONArray1;
	}

	public String formCheckFlowControlById() {
		this.logger.debug("enter ajax for check ");
		try {
			ActionContext localActionContext = ActionContext.getContext();
			HttpServletRequest localHttpServletRequest = (HttpServletRequest) localActionContext
					.get("com.opensymphony.xwork2.dispatcher.HttpServletRequest");
			Short localShort = new Short(localHttpServletRequest.getParameter("entity.id.tradepartition"));
			Integer localInteger = new Integer(localHttpServletRequest.getParameter("entity.id.unitid"));
			Byte localByte = new Byte(localHttpServletRequest.getParameter("entity.id.unittype"));
			FlowcontrolId localFlowcontrolId = new FlowcontrolId();
			localFlowcontrolId.setUnitid(localInteger);
			localFlowcontrolId.setUnittype(localByte);
			localFlowcontrolId.setTradepartition(localShort);
			FlowControl localFlowControl = new FlowControl();
			localFlowControl.setId(localFlowcontrolId);
			boolean bool = existModelId(localFlowcontrolId, localFlowControl);
			if (!bool) {
				this.jsonValidateReturn = getJSONArray(new Object[] { "true" });
			} else {
				this.jsonValidateReturn = getJSONArrayList(
						new JSONArray[] { createJSONArray(new Object[] { "unitId", Boolean.valueOf(false), "该交易节编号已存在" }) });
			}
			this.logger.debug(Boolean.valueOf(bool));
		} catch (Exception localException) {
			localException.printStackTrace();
		}
		return "success";
	}

	public String formCheckSpecialFeelById() {
		this.logger.debug("enter ajaxChek_SpecialFeelById");
		ActionContext localActionContext = ActionContext.getContext();
		HttpServletRequest localHttpServletRequest = (HttpServletRequest) localActionContext
				.get("com.opensymphony.xwork2.dispatcher.HttpServletRequest");
		SpecialFeeId localSpecialFeeId = new SpecialFeeId();
		try {
			localSpecialFeeId.setBreedId(new Integer(localHttpServletRequest.getParameter("entity.id.breedId")));
			localSpecialFeeId.setBs_flag(new Byte(localHttpServletRequest.getParameter("entity.id.bs_flag")));
			localSpecialFeeId.setUserCode(localHttpServletRequest.getParameter("entity.id.userCode"));
			SpecialFee localSpecialFee = new SpecialFee();
			localSpecialFee.setId(localSpecialFeeId);
			boolean bool = existModelId(localSpecialFeeId, localSpecialFee);
			if (!bool) {
				this.jsonValidateReturn = getJSONArray(new Object[] { "true" });
			} else {
				this.jsonValidateReturn = getJSONArrayList(
						new JSONArray[] { createJSONArray(new Object[] { "userCode", Boolean.valueOf(false), "已经存在记录！" }) });
			}
		} catch (Exception localException) {
			localException.printStackTrace();
		}
		return "success";
	}

	public String formCheckSpecialMarginById() {
		this.logger.debug("enter ajaxChek_SpecialMarginById");
		ActionContext localActionContext = ActionContext.getContext();
		HttpServletRequest localHttpServletRequest = (HttpServletRequest) localActionContext
				.get("com.opensymphony.xwork2.dispatcher.HttpServletRequest");
		SpecialMarginId localSpecialMarginId = new SpecialMarginId();
		try {
			localSpecialMarginId.setBreedId(new Integer(localHttpServletRequest.getParameter("entity.id.breedId")));
			localSpecialMarginId.setBs_flag(new Byte(localHttpServletRequest.getParameter("entity.id.bs_flag")));
			localSpecialMarginId.setUserCode(localHttpServletRequest.getParameter("entity.id.userCode"));
			SpecialMargin localSpecialMargin = new SpecialMargin();
			localSpecialMargin.setId(localSpecialMarginId);
			boolean bool = existModelId(localSpecialMarginId, localSpecialMargin);
			if (!bool) {
				this.jsonValidateReturn = getJSONArray(new Object[] { "true" });
			} else {
				this.jsonValidateReturn = getJSONArrayList(
						new JSONArray[] { createJSONArray(new Object[] { "userCode", Boolean.valueOf(false), "已经存在记录！" }) });
			}
		} catch (Exception localException) {
			localException.printStackTrace();
		}
		return "success";
	}

	public String mouseCheckUserByUserCode() {
		this.logger.debug("enter ajaxChek_mouseCheckUserByUserCode");
		ActionContext localActionContext = ActionContext.getContext();
		HttpServletRequest localHttpServletRequest = (HttpServletRequest) localActionContext
				.get("com.opensymphony.xwork2.dispatcher.HttpServletRequest");
		String str = localHttpServletRequest.getParameter("userCode");
		TradeUserModel localTradeUserModel = new TradeUserModel();
		localTradeUserModel.setUserCode(str);
		boolean bool = existModelId(str, localTradeUserModel);
		this.logger.debug(Boolean.valueOf(bool));
		if (bool) {
			this.jsonValidateReturn = getJSONArray(new Object[] { "true" });
		} else {
			this.jsonValidateReturn = getJSONArray(new Object[] { "false" });
		}
		return "success";
	}
}
