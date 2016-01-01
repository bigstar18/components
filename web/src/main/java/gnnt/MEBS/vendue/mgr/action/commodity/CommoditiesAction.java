package gnnt.MEBS.vendue.mgr.action.commodity;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.util.WebUtils;

import gnnt.MEBS.common.mgr.action.EcsideAction;
import gnnt.MEBS.common.mgr.common.Page;
import gnnt.MEBS.common.mgr.common.PageRequest;
import gnnt.MEBS.common.mgr.common.QueryConditions;
import gnnt.MEBS.vendue.mgr.model.commodity.commext.VCommext;
import gnnt.MEBS.vendue.mgr.model.commodity.commodities.VCommodity;
import gnnt.MEBS.vendue.mgr.service.commodity.commdities.CommodityService;
import gnnt.MEBS.vendue.mgr.service.system.syspartition.SysPartitionService;
import gnnt.MEBS.vendue.mgr.util.DateUtils;

@Controller("commoditiesAction")
@Scope("request")
public class CommoditiesAction extends EcsideAction {
	private static final long serialVersionUID = 8952164374698310829L;
	@Autowired
	@Qualifier("sysPartitionService")
	private SysPartitionService sysPartitionService;
	@Autowired
	@Qualifier("commodityService")
	private CommodityService commodityService;
	@Resource(name = "commodity_statusMap")
	private Map<Byte, String> commodity_statusMap;
	@Resource(name = "commodity_marginAlgrMap")
	private Map<Byte, String> commodity_marginAlgrMap;
	@Resource(name = "commodity_feeAlgrMap")
	private Map<Byte, String> commodity_feeAlgrMap;
	@Resource(name = "commodity_flowAmountAlgrMap")
	private Map<Byte, String> commodity_flowAmountAlgrMap;
	@Resource(name = "commodity_isorderMap")
	private Map<Byte, String> commodity_isorderMap;
	@Resource(name = "commodity_authorizationMap")
	private Map<Byte, String> commodity_authorizationMap;
	@Resource(name = "commodity_auditstatusMap")
	private Map<Byte, String> commodity_auditstatusMap;
	@Resource(name = "commodity_tendertradeconfirmMap")
	private Map<Byte, String> commodity_tendertradeconfirmMap;
	@Resource(name = "commodity_bsflagMap")
	private Map<Byte, String> commodity_bsflagMap;
	private Map partitions;
	private Map breeds;
	private String partitionid;
	private String trademode;

	public Map<Byte, String> getCommodity_statusMap() {
		return this.commodity_statusMap;
	}

	public Map<Byte, String> getCommodity_marginAlgrMap() {
		return this.commodity_marginAlgrMap;
	}

	public Map<Byte, String> getCommodity_feeAlgrMap() {
		return this.commodity_feeAlgrMap;
	}

	public Map<Byte, String> getCommodity_flowAmountAlgrMap() {
		return this.commodity_flowAmountAlgrMap;
	}

	public Map<Byte, String> getCommodity_isorderMap() {
		return this.commodity_isorderMap;
	}

	public Map<Byte, String> getCommodity_authorizationMap() {
		return this.commodity_authorizationMap;
	}

	public Map<Byte, String> getCommodity_auditstatusMap() {
		return this.commodity_auditstatusMap;
	}

	public Map<Byte, String> getCommodity_tendertradeconfirmMap() {
		return this.commodity_tendertradeconfirmMap;
	}

	public Map<Byte, String> getCommodity_bsflagMap() {
		return this.commodity_bsflagMap;
	}

	public Map getPartitions() {
		return this.sysPartitionService.getPartitionsMap();
	}

	public Map getBreeds() {
		String str = "select b.breedid id, b.breedname name from m_breed b where b.belongmodule like '%21%' and b.status = '1'";
		List localList = getService().getListBySql(str);
		HashMap localHashMap = new HashMap();
		Iterator localIterator = localList.iterator();
		while (localIterator.hasNext()) {
			Map localMap = (Map) localIterator.next();
			localHashMap.put(Long.valueOf(Long.parseLong(localMap.get("ID").toString())), localMap.get("NAME").toString());
		}
		return localHashMap;
	}

	public String getPartitionid() {
		return this.partitionid;
	}

	public void setPartitionid(String paramString) {
		this.partitionid = paramString;
	}

	public String getTrademode() {
		return this.trademode;
	}

	public void setTrademode(String paramString) {
		this.trademode = paramString;
	}

	public String list() {
		this.logger.debug("========== list 所有商品 ==========");
		try {
			PageRequest localPageRequest = getPageRequest(this.request);
			QueryConditions localQueryConditions = (QueryConditions) localPageRequest.getFilters();
			localQueryConditions.addCondition("tradepartition", "=", Short.valueOf(Short.parseShort(this.partitionid)));
			String str1 = this.request.getParameter("gnnt_status[=]");
			if ((str1 != null) && (!str1.equals(""))) {
				localQueryConditions.removeCondition("status");
				localQueryConditions.addCondition("status", "=", Short.valueOf(Short.parseShort(str1)));
			} else {
				String str2 = this.request.getParameter("gnnt_status[in]");
				if ((str2 == null) || (str2.equals(""))) {
					localQueryConditions.addCondition("status", "in", "(1,2,7,8)");
				}
			}
			String str2 = this.request.getParameter("gnnt_authorization[=]");
			if ((str2 != null) && (!str2.equals(""))) {
				localQueryConditions.removeCondition("authorization");
				localQueryConditions.addCondition("authorization", "=", Byte.valueOf(Byte.parseByte(str2)));
			}
			localQueryConditions.addCondition("auditstatus", "=", Byte.valueOf((byte) 1));
			String str3 = this.request.getParameter("gnnt_createtime[>=][simpledate]");
			String str4 = this.request.getParameter("gnnt_enddate");
			if ((str3 == null) || (str4 == null) || (str3.equals("")) || (str4.equals(""))) {
				localQueryConditions.removeCondition("createtime");
				localQueryConditions.addCondition("createtime", ">=", DateUtils.parseDate(DateUtils.formatDate(new Date())));
			} else {
				localQueryConditions.addCondition("createtime", "<=", DateUtils.tomorrow(str4));
			}
			Page localPage = getService().getPage(localPageRequest, new VCommodity());
			this.request.setAttribute("pageInfo", localPage);
			Map localMap = WebUtils.getParametersStartingWith(this.request, "gnnt_");
			this.request.setAttribute("oldParams", localMap);
		} catch (Exception localException) {
			this.logger.debug("商品列表查询失败");
			addReturnValue(-1, 213006L);
			localException.printStackTrace();
		}
		return "success";
	}

	public String forwardAdd() {
		this.logger.debug("========== forwardAdd 商品添加跳转 ==========");
		return "success";
	}

	public String add() {
		this.logger.debug("========== add 添加商品 ==========");
		VCommodity localVCommodity = (VCommodity) this.entity;
		localVCommodity.setFirsttime(new Date());
		localVCommodity.setCreatetime(new Date());
		localVCommodity.setStatus(Short.valueOf((short) 2));
		localVCommodity.setSplitid("0");
		localVCommodity.setMaxstepprice(Double.valueOf(0.0D));
		localVCommodity.setAuditstatus(Byte.valueOf((byte) 0));
		ArrayList localArrayList = new ArrayList();
		Integer localInteger = Integer.valueOf(Integer.parseInt(this.request.getParameter("propamount")));
		for (int i = 0; i < (localInteger == null ? 0 : localInteger.intValue()); i++) {
			String str1 = this.request.getParameter("propid_" + i);
			String str2 = this.request.getParameter("propname_" + i);
			String str3 = this.request.getParameter("propvalue_" + i);
			VCommext localVCommext = new VCommext();
			localVCommext.setAttributeid(Long.valueOf(Long.parseLong(str1)));
			localVCommext.setAttribute(str2);
			localVCommext.setValue(str3);
			localArrayList.add(localVCommext);
		}
		try {
			int i = this.commodityService.add(localVCommodity, localArrayList);
			addReturnValue(1, 211004L);
			writeOperateLog(2105, "商品添加成功", 1, "");
		} catch (Exception localException) {
			this.logger.error("商品添加失败");
			addReturnValue(-1, 213011L);
			writeOperateLog(2105, "商品添加失败", 0, "");
			localException.printStackTrace();
		}
		return "success";
	}

	public String viewById() {
		this.logger.debug("========== viewById 商品修改跳转 ==========");
		this.request.setAttribute("entity", getService().get((VCommodity) this.entity));
		return "success";
	}

	public String viewByIdForDetail() {
		this.logger.debug("========== viewByIdForDetail 商品详情跳转 ==========");
		VCommodity localVCommodity = (VCommodity) this.entity;
		localVCommodity = (VCommodity) getService().get(localVCommodity);
		this.request.setAttribute("entity", localVCommodity);
		String str = "select t.*,rownum from v_commext t where t.code = '" + localVCommodity.getCode() + "'";
		List localList = getService().getListBySql(str);
		this.request.setAttribute("commext", localList);
		return "success";
	}

	public String update() {
		this.logger.debug("========== update 修改商品 ==========");
		VCommodity localVCommodity = (VCommodity) this.entity;
		ArrayList localArrayList = new ArrayList();
		Integer localInteger = Integer.valueOf(Integer.parseInt(this.request.getParameter("propamount")));
		for (int i = 0; i < (localInteger == null ? 0 : localInteger.intValue()); i++) {
			String str1 = this.request.getParameter("propid_" + i);
			String str2 = this.request.getParameter("propname_" + i);
			String str3 = this.request.getParameter("propvalue_" + i);
			VCommext localVCommext = new VCommext();
			localVCommext.setAttributeid(Long.valueOf(Long.parseLong(str1)));
			localVCommext.setAttribute(str2);
			localVCommext.setValue(str3);
			localArrayList.add(localVCommext);
		}
		try {
			int i = this.commodityService.update(localVCommodity, localArrayList);
			if (i == 1) {
				this.logger.debug("商品修改成功");
				addReturnValue(1, 211000L);
				writeOperateLog(2105, "商品修改成功", 1, "");
			} else {
				this.logger.error("商品修改失败");
				addReturnValue(1, 213019L);
				writeOperateLog(2105, "商品修改失败", 0, "");
			}
		} catch (Exception localException) {
			this.logger.error("商品修改出现异常");
			addReturnValue(1, 213000L);
			writeOperateLog(2105, "商品修改失败", 0, "");
			localException.printStackTrace();
		}
		return "success";
	}

	public String delete() {
		this.logger.debug("========== delete 删除商品 ==========");
		return "success";
	}

	public String deleteList() {
		this.logger.debug("========== deleteList 批量废除商品 ==========");
		try {
			String[] arrayOfString = this.request.getParameterValues("ids");
			int i = this.commodityService.deleteList(arrayOfString);
			if (i == 1) {
				addReturnValue(1, 211014L);
				this.logger.debug("废除成功");
				writeOperateLog(2105, "商品废除成功", 1, "");
			} else {
				addReturnValue(-1, 213018L);
				this.logger.debug("废除失败");
				writeOperateLog(2105, "商品废除失败", 0, "");
			}
		} catch (Exception localException) {
			addReturnValue(-1, 213018L);
			this.logger.debug("废除失败");
			writeOperateLog(2105, "商品废除失败", 0, "");
			localException.printStackTrace();
		}
		return "success";
	}

	public String addToCur() {
		this.logger.debug("========== 添加到当前商品列表 ==========");
		List localList = null;
		String str1 = null;
		try {
			String[] arrayOfString = this.request.getParameterValues("ids");
			localList = this.commodityService.addToCur(arrayOfString);
			if (localList.size() == 0) {
				str1 = "添加成功";
				this.logger.debug("添加成功");
				writeOperateLog(2105, "商品添加到当前交易商品成功", 1, "");
			} else {
				String str2 = localList.toString();
				str2 = str2.substring(1, str2.length() - 1);
				str1 = "以下标的号添加失败：\\n\\n";
				str1 = str1 + str2 + "\\n\\n";
				str1 = str1 + "原因可能如下：\\n";
				str1 = str1 + "1、商品已经在当前商品列表中\\n";
				str1 = str1 + "2、商品还未通过审核\\n";
				str1 = str1 + "3、商品不在“未成交”或“已流拍”状态\\n";
				str1 = str1 + "4、交易商资金不足\\n";
				this.logger.debug("添加失败");
				writeOperateLog(2105, "商品添加到当前交易商品，部分失败", 0, "");
			}
			this.request.setAttribute("alertStr", str1);
		} catch (Exception localException) {
			addReturnValue(-1, 213004L);
			this.logger.debug("添加失败");
			writeOperateLog(2105, "商品添加到当前交易商品失败", 0, "");
			localException.printStackTrace();
		} finally {
			this.request.removeAttribute("ids");
		}
		return "success";
	}
}
