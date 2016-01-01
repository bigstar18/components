package gnnt.MEBS.espot.mgr.beanforajax;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionContext;

import gnnt.MEBS.common.mgr.common.Global;
import gnnt.MEBS.common.mgr.common.Page;
import gnnt.MEBS.common.mgr.common.PageRequest;
import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.service.StandardService;
import gnnt.MEBS.common.mgr.statictools.Tools;
import gnnt.MEBS.espot.mgr.model.commoditymanage.BreedProps;
import gnnt.MEBS.espot.mgr.model.commoditymanage.Category;
import gnnt.MEBS.espot.mgr.model.commoditymanage.CategoryProperty;
import gnnt.MEBS.espot.mgr.model.firmmanage.MFirm;
import gnnt.MEBS.espot.mgr.model.parametermanage.DeliveryFee;
import gnnt.MEBS.espot.mgr.model.parametermanage.DeliveryMargin;
import gnnt.MEBS.espot.mgr.model.parametermanage.TradeFee;
import gnnt.MEBS.espot.mgr.model.parametermanage.TradeRight;
import gnnt.MEBS.espot.mgr.model.shopmanage.RecommendShop;
import gnnt.MEBS.espot.mgr.model.shopmanage.Shop;
import net.sf.json.JSONArray;

@Controller("ajaxCheckDemo")
@Scope("request")
public class AjaxCheckDemo {
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

	public boolean exitCateorySortNo(String paramString1, String paramString2, String paramString3) {
		boolean bool = false;
		if (!"".equals(paramString1)) {
			if (paramString1.equals(paramString2)) {
				bool = false;
			} else {
				PageRequest localPageRequest = new PageRequest(" and primary.sortNo=" + Tools.strToLong(paramString1)
						+ " and primary.parentCategory.categoryId=" + Tools.strToInt(paramString3) + " and primary.status=1");
				Page localPage = getService().getPage(localPageRequest, new Category());
				if ((localPage.getResult() != null) && (localPage.getResult().size() > 0)) {
					bool = true;
				}
			}
		}
		return bool;
	}

	public String checkCategoryBySortNo() {
		ActionContext localActionContext = ActionContext.getContext();
		HttpServletRequest localHttpServletRequest = (HttpServletRequest) localActionContext
				.get("com.opensymphony.xwork2.dispatcher.HttpServletRequest");
		String str1 = localHttpServletRequest.getParameter("fieldId");
		String str2 = localHttpServletRequest.getParameter("fieldValue");
		String str3 = localHttpServletRequest.getParameter("oldSortNo");
		String str4 = localHttpServletRequest.getParameter("parentCategoryId");
		AjaxValidationFieldResponse localAjaxValidationFieldResponse = new AjaxValidationFieldResponse(str1,
				Boolean.valueOf(!exitCateorySortNo(str2, str3, str4)));
		this.jsonValidateReturn = localAjaxValidationFieldResponse.toJSONArray();
		return "success";
	}

	public String checkCategoryForm() {
		ActionContext localActionContext = ActionContext.getContext();
		HttpServletRequest localHttpServletRequest = (HttpServletRequest) localActionContext
				.get("com.opensymphony.xwork2.dispatcher.HttpServletRequest");
		ArrayList localArrayList = new ArrayList();
		String str1 = localHttpServletRequest.getParameter("entity.sortNo");
		String str2 = localHttpServletRequest.getParameter("oldSortNo");
		String str3 = localHttpServletRequest.getParameter("entity.parentCategory.categoryId");
		if (exitCateorySortNo(str1, str2, str3)) {
			localArrayList.add(new AjaxValidationFormResponse("sortNo", Boolean.valueOf(false), "输入的排序号已存在"));
		}
		if (localArrayList.size() != 0) {
			this.jsonValidateReturn = genJSON(localArrayList);
		} else {
			this.jsonValidateReturn = new JSONArray();
			this.jsonValidateReturn.add("true");
		}
		return "success";
	}

	public boolean existCategoryPropName(String paramString1, String paramString2, String paramString3) {
		PageRequest localPageRequest;
		Page localPage;
		if ((!"".equals(paramString3)) && (!"".equals(paramString1))) {
			localPageRequest = new PageRequest(
					" and primary.propertyName='" + paramString1 + "'  and  primary.propertyId=" + Long.parseLong(paramString3));
			localPage = getService().getPage(localPageRequest, new CategoryProperty());
			if ((localPage.getResult() != null) && (localPage.getResult().size() > 0)) {
				return false;
			}
		}
		if ((!"".equals(paramString1)) && (!"".equals(paramString2))) {
			localPageRequest = new PageRequest(
					" and primary.propertyName='" + paramString1 + "' and primary.category.categoryId=" + Long.parseLong(paramString2));
			localPage = getService().getPage(localPageRequest, new CategoryProperty());
			if ((localPage.getResult() != null) && (localPage.getResult().size() > 0)) {
				return true;
			}
		}
		return false;
	}

	public String checkCategoryPropName() {
		ActionContext localActionContext = ActionContext.getContext();
		HttpServletRequest localHttpServletRequest = (HttpServletRequest) localActionContext
				.get("com.opensymphony.xwork2.dispatcher.HttpServletRequest");
		String str1 = localHttpServletRequest.getParameter("fieldId");
		String str2 = localHttpServletRequest.getParameter("fieldValue").trim();
		String str3 = localHttpServletRequest.getParameter("categoryId");
		String str4 = localHttpServletRequest.getParameter("propertyId");
		AjaxValidationFieldResponse localAjaxValidationFieldResponse = new AjaxValidationFieldResponse(str1,
				Boolean.valueOf(!existCategoryPropName(str2, str3, str4)));
		this.jsonValidateReturn = localAjaxValidationFieldResponse.toJSONArray();
		return "success";
	}

	public boolean existCategoryPropBySortNo(String paramString1, String paramString2, String paramString3) {
		if ((!"".equals(paramString1)) && (!"".equals(paramString3))) {
			if (paramString1.equals(paramString2)) {
				return false;
			}
			PageRequest localPageRequest = new PageRequest(
					" and primary.sortNo=" + Long.parseLong(paramString1) + " and primary.category.categoryId=" + Long.parseLong(paramString3));
			Page localPage = getService().getPage(localPageRequest, new CategoryProperty());
			if ((localPage.getResult() != null) && (localPage.getResult().size() > 0)) {
				return true;
			}
		}
		return false;
	}

	public String checkCategoryPropBySortNo() {
		ActionContext localActionContext = ActionContext.getContext();
		HttpServletRequest localHttpServletRequest = (HttpServletRequest) localActionContext
				.get("com.opensymphony.xwork2.dispatcher.HttpServletRequest");
		String str1 = localHttpServletRequest.getParameter("fieldId");
		String str2 = localHttpServletRequest.getParameter("fieldValue");
		String str3 = localHttpServletRequest.getParameter("oldSortNo");
		String str4 = localHttpServletRequest.getParameter("categoryId");
		AjaxValidationFieldResponse localAjaxValidationFieldResponse = new AjaxValidationFieldResponse(str1,
				Boolean.valueOf(!existCategoryPropBySortNo(str2, str3, str4)));
		this.jsonValidateReturn = localAjaxValidationFieldResponse.toJSONArray();
		return "success";
	}

	public String checkCategoryPropForm() {
		ActionContext localActionContext = ActionContext.getContext();
		HttpServletRequest localHttpServletRequest = (HttpServletRequest) localActionContext
				.get("com.opensymphony.xwork2.dispatcher.HttpServletRequest");
		ArrayList localArrayList = new ArrayList();
		String str1 = localHttpServletRequest.getParameter("entity.sortNo");
		String str2 = localHttpServletRequest.getParameter("oldSortNo");
		String str3 = localHttpServletRequest.getParameter("entity.propertyName");
		String str4 = localHttpServletRequest.getParameter("categoryId");
		String str5 = localHttpServletRequest.getParameter("entity.propertyId");
		if (existCategoryPropBySortNo(str1, str2, str4)) {
			localArrayList.add(new AjaxValidationFormResponse("sortNo", Boolean.valueOf(false), "输入的排序号已存在"));
		}
		if (existCategoryPropName(str3, str4, str5)) {
			localArrayList.add(new AjaxValidationFormResponse("name", Boolean.valueOf(false), "输入的属性名称已存在"));
		}
		if (localArrayList.size() != 0) {
			this.jsonValidateReturn = genJSON(localArrayList);
		} else {
			this.jsonValidateReturn = new JSONArray();
			this.jsonValidateReturn.add("true");
		}
		return "success";
	}

	public boolean exitBreedPropsSortNo(String paramString1, String paramString2, String paramString3, String paramString4) {
		boolean bool = false;
		if (!"".equals(paramString1)) {
			if (paramString1.equals(paramString2)) {
				bool = false;
			} else {
				PageRequest localPageRequest = new PageRequest(
						" and primary.sortNo=" + Tools.strToLong(paramString1) + " and primary.categoryProperty.propertyId="
								+ Tools.strToInt(paramString4) + " and primary.breed.breedId= " + Tools.strToInt(paramString3));
				Page localPage = getService().getPage(localPageRequest, new BreedProps());
				if ((localPage.getResult() != null) && (localPage.getResult().size() > 0)) {
					bool = true;
				}
			}
		}
		return bool;
	}

	public String checkBreedPropsBySortNo() {
		ActionContext localActionContext = ActionContext.getContext();
		HttpServletRequest localHttpServletRequest = (HttpServletRequest) localActionContext
				.get("com.opensymphony.xwork2.dispatcher.HttpServletRequest");
		String str1 = localHttpServletRequest.getParameter("fieldId");
		String str2 = localHttpServletRequest.getParameter("fieldValue");
		String str3 = localHttpServletRequest.getParameter("oldSortNo");
		String str4 = localHttpServletRequest.getParameter("breedId");
		String str5 = localHttpServletRequest.getParameter("propertyId");
		AjaxValidationFieldResponse localAjaxValidationFieldResponse = new AjaxValidationFieldResponse(str1,
				Boolean.valueOf(!exitBreedPropsSortNo(str2, str3, str4, str5)));
		this.jsonValidateReturn = localAjaxValidationFieldResponse.toJSONArray();
		return "success";
	}

	private boolean existFirmFirmId(String paramString1, String paramString2) {
		boolean bool = false;
		if (!"".equals(paramString1)) {
			if (paramString1.equals(paramString2)) {
				bool = false;
			} else {
				PageRequest localPageRequest = new PageRequest(" and primary.firmId='" + paramString1 + "'");
				Page localPage = getService().getPage(localPageRequest, new MFirm());
				if ((localPage.getResult() != null) && (localPage.getResult().size() > 0)) {
					bool = true;
				}
			}
		}
		return bool;
	}

	public String checkFirmByFirmId() {
		ActionContext localActionContext = ActionContext.getContext();
		HttpServletRequest localHttpServletRequest = (HttpServletRequest) localActionContext
				.get("com.opensymphony.xwork2.dispatcher.HttpServletRequest");
		String str1 = localHttpServletRequest.getParameter("fieldId");
		String str2 = localHttpServletRequest.getParameter("fieldValue");
		String str3 = localHttpServletRequest.getParameter("oldFirmId");
		AjaxValidationFieldResponse localAjaxValidationFieldResponse = new AjaxValidationFieldResponse(str1,
				Boolean.valueOf(!existFirmFirmId(str2, str3)));
		this.jsonValidateReturn = localAjaxValidationFieldResponse.toJSONArray();
		return "success";
	}

	public String checkFirmForm() {
		ActionContext localActionContext = ActionContext.getContext();
		HttpServletRequest localHttpServletRequest = (HttpServletRequest) localActionContext
				.get("com.opensymphony.xwork2.dispatcher.HttpServletRequest");
		ArrayList localArrayList = new ArrayList();
		String str1 = localHttpServletRequest.getParameter("entity.firmId");
		String str2 = localHttpServletRequest.getParameter("oldFirmId");
		if (existFirmFirmId(str1, str2)) {
			localArrayList.add(new AjaxValidationFormResponse("id", Boolean.valueOf(false), "输入的交易商代码已存在"));
		}
		String str3 = "^[a-zA-Z0-9|_]+$";
		Pattern localPattern = Pattern.compile(str3);
		Matcher localMatcher = localPattern.matcher(str1);
		if (!localMatcher.find()) {
			localArrayList.add(new AjaxValidationFormResponse("id", Boolean.valueOf(false), "交易商代码由字母数字下划线组成"));
		}
		if (localArrayList.size() != 0) {
			this.jsonValidateReturn = genJSON(localArrayList);
		} else {
			this.jsonValidateReturn = new JSONArray();
			this.jsonValidateReturn.add("true");
		}
		return "success";
	}

	private boolean existBreedPropByValue(String paramString1, String paramString2, String paramString3, String paramString4) {
		boolean bool = false;
		if ((!"".equals(paramString1)) && (!paramString1.equals(paramString2))) {
			PageRequest localPageRequest = new PageRequest(
					" and primary.propertyValue='" + paramString1 + "' and primary.categoryProperty.propertyId=" + Tools.strToInt(paramString3)
							+ " and primary.breed.breedId=" + Tools.strToLong(paramString4));
			Page localPage = getService().getPage(localPageRequest, new BreedProps());
			if ((localPage.getResult() != null) && (localPage.getResult().size() > 0)) {
				bool = true;
			}
		}
		return bool;
	}

	public String checkBreedPropByValue() {
		ActionContext localActionContext = ActionContext.getContext();
		HttpServletRequest localHttpServletRequest = (HttpServletRequest) localActionContext
				.get("com.opensymphony.xwork2.dispatcher.HttpServletRequest");
		String str1 = localHttpServletRequest.getParameter("fieldId");
		String str2 = localHttpServletRequest.getParameter("fieldValue");
		String str3 = localHttpServletRequest.getParameter("oldPropValue");
		String str4 = localHttpServletRequest.getParameter("breedId");
		String str5 = localHttpServletRequest.getParameter("propertyId");
		AjaxValidationFieldResponse localAjaxValidationFieldResponse = new AjaxValidationFieldResponse(str1,
				Boolean.valueOf(!existBreedPropByValue(str2, str3, str5, str4)));
		this.jsonValidateReturn = localAjaxValidationFieldResponse.toJSONArray();
		return "success";
	}

	public String checkPropertyPropForm() {
		ActionContext localActionContext = ActionContext.getContext();
		HttpServletRequest localHttpServletRequest = (HttpServletRequest) localActionContext
				.get("com.opensymphony.xwork2.dispatcher.HttpServletRequest");
		ArrayList localArrayList = new ArrayList();
		String str1 = localHttpServletRequest.getParameter("entity.propertyValue");
		String str2 = localHttpServletRequest.getParameter("oldPropValue");
		String str3 = localHttpServletRequest.getParameter("entity.breed.breedId");
		String str4 = localHttpServletRequest.getParameter("checkValue");
		String str5 = localHttpServletRequest.getParameter("entity.categoryProperty.propertyId");
		String str6 = localHttpServletRequest.getParameter("entity.sortNo");
		String str7 = localHttpServletRequest.getParameter("oldSortNo");
		if ((str4 == null) && (existBreedPropByValue(str1, str2, str5, str3))) {
			localArrayList.add(new AjaxValidationFormResponse("propertyValue", Boolean.valueOf(false), "输入的属性值已存在"));
		} else if (("true".equals(str4)) && (existBreedPropByValue(str1, str2, str5, str3))) {
			localArrayList.add(new AjaxValidationFormResponse("propertyValue", Boolean.valueOf(false), "输入的属性值已存在"));
		}
		if (exitBreedPropsSortNo(str6, str7, str3, str5)) {
			localArrayList.add(new AjaxValidationFormResponse("sortNo", Boolean.valueOf(false), "输入的排序号已存在"));
		}
		if (localArrayList.size() != 0) {
			this.jsonValidateReturn = genJSON(localArrayList);
		} else {
			this.jsonValidateReturn = new JSONArray();
			this.jsonValidateReturn.add("true");
		}
		return "success";
	}

	private boolean existSortNoByRecommendShop(String paramString) {
		boolean bool = true;
		if (!"".equals(paramString)) {
			PageRequest localPageRequest = new PageRequest(" and primary.num=" + Tools.strToInt(paramString));
			Page localPage = getService().getPage(localPageRequest, new RecommendShop());
			if ((localPage.getResult() != null) && (localPage.getResult().size() > 0)) {
				bool = false;
			}
		}
		return bool;
	}

	public String chekSortNoByRecommendShop() {
		ActionContext localActionContext = ActionContext.getContext();
		HttpServletRequest localHttpServletRequest = (HttpServletRequest) localActionContext
				.get("com.opensymphony.xwork2.dispatcher.HttpServletRequest");
		String str = localHttpServletRequest.getParameter("fieldValue");
		boolean bool = existSortNoByRecommendShop(str);
		AjaxValidationFieldResponse localAjaxValidationFieldResponse = new AjaxValidationFieldResponse(
				localHttpServletRequest.getParameter("fieldId"), Boolean.valueOf(bool));
		this.jsonValidateReturn = localAjaxValidationFieldResponse.toJSONArray();
		return "success";
	}

	public String chekRecommendShopByFirmId() {
		ActionContext localActionContext = ActionContext.getContext();
		HttpServletRequest localHttpServletRequest = (HttpServletRequest) localActionContext
				.get("com.opensymphony.xwork2.dispatcher.HttpServletRequest");
		String str1 = localHttpServletRequest.getParameter("fieldValue");
		MFirm localMFirm = new MFirm();
		localMFirm.setFirmId(str1);
		localMFirm = (MFirm) getService().get(localMFirm);
		AjaxValidationFieldResponse localAjaxValidationFieldResponse = new AjaxValidationFieldResponse(
				localHttpServletRequest.getParameter("fieldId"), Boolean.valueOf(false));
		if (localMFirm != null) {
			String str2 = localMFirm.getStatus();
			boolean bool1 = checkShopByFirmId(str1).booleanValue();
			boolean bool2 = checkByModelKey(str1, new RecommendShop()).booleanValue();
			localAjaxValidationFieldResponse = new AjaxValidationFieldResponse(localHttpServletRequest.getParameter("fieldId"),
					Boolean.valueOf((bool1) && (!bool2) && (!"E".equals(str2))));
		}
		this.jsonValidateReturn = localAjaxValidationFieldResponse.toJSONArray();
		return "success";
	}

	public String checkRecommendShopForm() {
		ActionContext localActionContext = ActionContext.getContext();
		HttpServletRequest localHttpServletRequest = (HttpServletRequest) localActionContext
				.get("com.opensymphony.xwork2.dispatcher.HttpServletRequest");
		ArrayList localArrayList = new ArrayList();
		String str1 = localHttpServletRequest.getParameter("entity.firmId");
		MFirm localMFirm = new MFirm();
		localMFirm.setFirmId(str1);
		localMFirm = (MFirm) getService().get(localMFirm);
		boolean bool1 = false;
		boolean bool2 = false;
		String str2 = "";
		if (localMFirm != null) {
			str2 = localMFirm.getStatus();
			bool1 = checkShopByFirmId(str1).booleanValue();
			bool2 = checkByModelKey(str1, new RecommendShop()).booleanValue();
			if ((!bool1) && (!bool2)) {
				localArrayList.add(new AjaxValidationFormResponse("firmId", Boolean.valueOf(false), "此交易商店铺不存在或已推荐或此交易商状态为注销状态"));
			} else if ((bool1) && (bool2) && (!"E".equals(str2))) {
				localArrayList.add(new AjaxValidationFormResponse("firmId", Boolean.valueOf(false), "此交易商店铺不存在或已推荐或此交易商状态为注销状态"));
			} else if ((bool1) && (!bool2) && ("E".equals(str2))) {
				localArrayList.add(new AjaxValidationFormResponse("firmId", Boolean.valueOf(false), "此交易商店铺不存在或已推荐或此交易商状态为注销状态"));
			}
		} else {
			localArrayList.add(new AjaxValidationFormResponse("firmId", Boolean.valueOf(false), "此交易商店铺不存在或已推荐或此交易商状态为注销状态"));
		}
		boolean bool3 = existSortNoByRecommendShop(localHttpServletRequest.getParameter("entity.num"));
		if (!bool3) {
			localArrayList.add(new AjaxValidationFormResponse("num", Boolean.valueOf(false), "排序号已存在"));
		}
		if (localArrayList.size() != 0) {
			this.jsonValidateReturn = genJSON(localArrayList);
		} else {
			this.jsonValidateReturn = new JSONArray();
			this.jsonValidateReturn.add("true");
		}
		return "success";
	}

	private Boolean checkShopByFirmId(String paramString) {
		boolean bool = false;
		if (!"".equals(paramString)) {
			PageRequest localPageRequest = new PageRequest(
					" and (select count(m.firmId) from primary.firm.firmModules as m where m.moduleID=23 and m.enabled='Y')>0  and   primary.firm.status !='E' and primary.firmId='"
							+ paramString + "'");
			Page localPage = getService().getPage(localPageRequest, new Shop());
			if ((localPage.getResult() != null) && (localPage.getResult().size() > 0)) {
				bool = true;
			}
		}
		return Boolean.valueOf(bool);
	}

	private Boolean checkByModelKey(String paramString, StandardModel paramStandardModel) {
		boolean bool = false;
		if (!"".equals(paramString)) {
			PageRequest localPageRequest = new PageRequest(" and " + paramStandardModel.fetchPKey().getKey() + "='" + paramString + "'");
			Page localPage = getService().getPage(localPageRequest, paramStandardModel);
			if ((localPage.getResult() != null) && (localPage.getResult().size() > 0)) {
				bool = true;
			}
		}
		return Boolean.valueOf(bool);
	}

	public boolean existMFirmByFirmId(String paramString) {
		if ("".equals(paramString)) {
			return true;
		}
		PageRequest localPageRequest = new PageRequest(" and primary.status!='E' and primary.firmId='" + paramString
				+ "'  and (select count(t.firmId) from primary.firmModules as t where t.moduleID=" + Global.getSelfModuleID()
				+ " and t.enabled='Y')>0 order by primary.firmId");
		Page localPage = getService().getPage(localPageRequest, new MFirm());
		return (localPage != null) && (localPage.getResult().size() > 0);
	}

	public boolean existTradeFeeByFirmAndCategory(String paramString1, String paramString2, String paramString3) {
		String str = " and primary.firm.firmId='" + paramString1 + "' and primary.category.categoryId=" + Tools.strToLong(paramString2);
		if ("".equals(paramString1)) {
			str = " and primary.firm.firmId is null and primary.category.categoryId=" + Tools.strToLong(paramString2);
		}
		PageRequest localPageRequest = new PageRequest(str);
		Page localPage = null;
		if ("tradeFee".equals(paramString3)) {
			localPage = getService().getPage(localPageRequest, new TradeFee());
		} else if ("deliveryMargin".equals(paramString3)) {
			localPage = getService().getPage(localPageRequest, new DeliveryMargin());
		} else if ("deliveryFee".equals(paramString3)) {
			localPage = getService().getPage(localPageRequest, new DeliveryFee());
		}
		return (localPage == null) || (localPage.getResult().size() <= 0);
	}

	public String checkMFirmByFirmId() throws Exception {
		ActionContext localActionContext = ActionContext.getContext();
		HttpServletRequest localHttpServletRequest = (HttpServletRequest) localActionContext
				.get("com.opensymphony.xwork2.dispatcher.HttpServletRequest");
		String str1 = localHttpServletRequest.getParameter("fieldId");
		String str2 = localHttpServletRequest.getParameter("fieldValue");
		AjaxValidationFieldResponse localAjaxValidationFieldResponse = new AjaxValidationFieldResponse(str1,
				Boolean.valueOf(existMFirmByFirmId(str2)));
		this.jsonValidateReturn = localAjaxValidationFieldResponse.toJSONArray();
		return "success";
	}

	public String checkTradeFeeForm() throws Exception {
		ActionContext localActionContext = ActionContext.getContext();
		HttpServletRequest localHttpServletRequest = (HttpServletRequest) localActionContext
				.get("com.opensymphony.xwork2.dispatcher.HttpServletRequest");
		ArrayList localArrayList = new ArrayList();
		String str1 = localHttpServletRequest.getParameter("entity.firm.firmId");
		String str2 = localHttpServletRequest.getParameter("entity.category.categoryId");
		String str3 = localHttpServletRequest.getParameter("type");
		String str4 = "";
		String str5 = "";
		if ("tradeFee".equals(str3)) {
			str4 = "此特殊交易手续费不可用";
		} else if ("deliveryMargin".equals(str3)) {
			str4 = "此特殊履约保证金不可用";
		} else if ("deliveryFee".equals(str3)) {
			str4 = "此特殊交收手续费不可用";
		} else {
			str4 = "此最低特殊诚信保障金不可用";
		}
		if ("tradeFee".equals(str3)) {
			str5 = "此特殊交易手续费可用";
		} else if ("deliveryMargin".equals(str3)) {
			str5 = "此特殊履约保证金可用";
		} else if ("deliveryFee".equals(str3)) {
			str5 = "此特殊交收手续费可用";
		}
		if (existMFirmByFirmId(str1)) {
			if (!existTradeFeeByFirmAndCategory(str1, str2, str3)) {
				localArrayList.add(new AjaxValidationFormResponse("firmId", Boolean.valueOf(false), str4));
			} else {
				localArrayList.add(new AjaxValidationFormResponse("firmId", Boolean.valueOf(true), str5));
			}
		} else {
			localArrayList.add(new AjaxValidationFormResponse("firmId", Boolean.valueOf(existMFirmByFirmId(str1)), "此交易商不存在或没有系统权限"));
		}
		if (localArrayList.size() != 0) {
			this.jsonValidateReturn = genJSON(localArrayList);
		} else {
			this.jsonValidateReturn = new JSONArray();
			this.jsonValidateReturn.add("true");
		}
		return "success";
	}

	private boolean existTradeRightIdByFirmId(String paramString1, String paramString2) {
		boolean bool = false;
		if (!"".equals(paramString1)) {
			if (paramString1.equals(paramString2)) {
				bool = false;
			} else {
				PageRequest localPageRequest1 = new PageRequest(" and primary.firmId='" + paramString1 + "'");
				Page localPage1 = getService().getPage(localPageRequest1, new MFirm());
				if ((localPage1.getResult() != null) && (localPage1.getResult().size() > 0)) {
					PageRequest localPageRequest2 = new PageRequest(" order by primary.tradeRightId");
					Page localPage2 = getService().getPage(localPageRequest2, new TradeRight());
					if ((localPage2.getResult() != null) && (localPage2.getResult().size() > 0)) {
						Iterator localIterator = localPage2.getResult().iterator();
						while (localIterator.hasNext()) {
							StandardModel localStandardModel = (StandardModel) localIterator.next();
							TradeRight localTradeRight = (TradeRight) localStandardModel;
							if (paramString1.equals(localTradeRight.getFirm().getFirmId())) {
								bool = true;
							}
						}
					}
				} else {
					bool = true;
				}
			}
		} else {
			bool = true;
		}
		return bool;
	}

	public String checkTradeRightByFirmId() {
		ActionContext localActionContext = ActionContext.getContext();
		HttpServletRequest localHttpServletRequest = (HttpServletRequest) localActionContext
				.get("com.opensymphony.xwork2.dispatcher.HttpServletRequest");
		String str1 = localHttpServletRequest.getParameter("fieldId");
		String str2 = localHttpServletRequest.getParameter("fieldValue");
		String str3 = localHttpServletRequest.getParameter("oldFirmId");
		AjaxValidationFieldResponse localAjaxValidationFieldResponse = new AjaxValidationFieldResponse(str1,
				Boolean.valueOf(!existTradeRightIdByFirmId(str2, str3)));
		this.jsonValidateReturn = localAjaxValidationFieldResponse.toJSONArray();
		return "success";
	}

	public String checkTradeRightForm() {
		ActionContext localActionContext = ActionContext.getContext();
		HttpServletRequest localHttpServletRequest = (HttpServletRequest) localActionContext
				.get("com.opensymphony.xwork2.dispatcher.HttpServletRequest");
		ArrayList localArrayList = new ArrayList();
		String str1 = localHttpServletRequest.getParameter("entity.firm.firmId");
		String str2 = localHttpServletRequest.getParameter("oldFirmId");
		if (existTradeRightIdByFirmId(str1, str2)) {
			localArrayList.add(new AjaxValidationFormResponse("firmId", Boolean.valueOf(false), "此交易商已被使用或不存在"));
		}
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
