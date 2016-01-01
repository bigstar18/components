package gnnt.MEBS.vendue.mgr.action.commodity;

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
import gnnt.MEBS.common.mgr.common.PageRequest;
import gnnt.MEBS.common.mgr.common.QueryConditions;
import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.vendue.mgr.model.commodity.commodityparams.VCommodityparams;
import gnnt.MEBS.vendue.mgr.service.commodity.commdityparams.CommodityParamsService;
import gnnt.MEBS.vendue.mgr.service.system.syspartition.SysPartitionService;

@Controller("commodityParamsAction")
@Scope("request")
public class CommodityParamsAction extends EcsideAction {
	private static final long serialVersionUID = 3444465025410002156L;
	@Autowired
	@Qualifier("sysPartitionService")
	private SysPartitionService sysPartitionService;
	@Autowired
	@Qualifier("commodityParamsService")
	private CommodityParamsService commodityParamsService;
	@Resource(name = "commodityParams_marginAlgrMap")
	private Map<Byte, String> commodityParams_marginAlgrMap;
	@Resource(name = "commodityParams_feeAlgrMap")
	private Map<Byte, String> commodityParams_feeAlgrMap;
	@Resource(name = "commodityParams_flowAmountAlgrMap")
	private Map<Byte, String> commodityParams_flowAmountAlgrMap;
	private Map partitions;
	private Map breeds;
	private String partitionid;
	private String trademode;

	public Map<Byte, String> getCommodityParams_marginAlgrMap() {
		return this.commodityParams_marginAlgrMap;
	}

	public Map<Byte, String> getCommodityParams_feeAlgrMap() {
		return this.commodityParams_feeAlgrMap;
	}

	public Map<Byte, String> getCommodityParams_flowAmountAlgrMap() {
		return this.commodityParams_flowAmountAlgrMap;
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
		this.logger.debug("========== list 商品默认设置 ==========");
		try {
			PageRequest localPageRequest = getPageRequest(this.request);
			QueryConditions localQueryConditions = (QueryConditions) localPageRequest.getFilters();
			localQueryConditions.addCondition("tradepartition", "=", Short.valueOf(Short.parseShort(this.partitionid)));
			String str = this.request.getParameter("gnnt_breedname[Like]");
			if ((str != null) && (!str.equals(""))) {
				localQueryConditions.removeCondition("breedname");
				List localObject1 = getService().getListBySql("select breedid from m_breed where breedname like '%" + str + "%'");
				String localObject2 = "     ";
				for (int i = 0; i < ((List) localObject1).size(); i++) {
					localObject2 = (String) localObject2 + ((Map) ((List) localObject1).get(i)).get("BREEDID").toString() + ", ";
				}
				localObject2 = (String) localObject2 + "-1";
				localQueryConditions.addCondition("breedid", "in", "(" + (String) localObject2 + ")");
			}
			Object localObject1 = getService().getPage(localPageRequest, new VCommodityparams());
			this.request.setAttribute("pageInfo", localObject1);
			Object localObject2 = WebUtils.getParametersStartingWith(this.request, "gnnt_");
			this.request.setAttribute("oldParams", localObject2);
		} catch (Exception localException) {
			this.logger.error("读取商品默认设置列表失败");
			addReturnValue(-1, 213003L);
			localException.printStackTrace();
		}
		return "success";
	}

	public String forwardAdd() {
		String str = "select * from v_commodityparams where tradepartition = '" + this.partitionid + "'";
		List localList = getService().getListBySql(str, new VCommodityparams());
		Map localMap = getBreeds();
		Iterator localIterator = localList.iterator();
		while (localIterator.hasNext()) {
			StandardModel localStandardModel = (StandardModel) localIterator.next();
			VCommodityparams localVCommodityparams = (VCommodityparams) localStandardModel;
			localMap.remove(Long.valueOf(Long.parseLong(localVCommodityparams.getBreedid().toString())));
		}
		this.request.setAttribute("breedsToAdd", localMap);
		return "success";
	}

	public String add() {
		this.logger.debug("========== add 商品默认配置 ==========");
		try {
			VCommodityparams localVCommodityparams = (VCommodityparams) this.entity;
			localVCommodityparams.setMaxstepprice("0");
			getService().add(localVCommodityparams);
			addReturnValue(1, 211001L);
			this.logger.debug("添加成功");
			writeOperateLog(2105, "商品默认设置添加成功", 1, "");
		} catch (Exception localException) {
			addReturnValue(-1, 213004L);
			this.logger.debug("添加失败");
			writeOperateLog(2105, "商品默认设置添加失败", 0, "");
			localException.printStackTrace();
		}
		return "success";
	}

	public String deleteList() {
		this.logger.debug("========== deleteList 商品默认配置 ==========");
		try {
			String[] arrayOfString = this.request.getParameterValues("ids");
			this.commodityParamsService.deleteList(this.partitionid, arrayOfString);
			addReturnValue(1, 211002L);
			this.logger.debug("删除成功");
			writeOperateLog(2105, "商品默认设置删除成功", 1, "");
		} catch (Exception localException) {
			addReturnValue(-1, 213005L);
			this.logger.debug("删除失败");
			writeOperateLog(2105, "商品默认设置删除失败", 0, "");
			localException.printStackTrace();
		}
		return "success";
	}

	public String viewById() {
		this.logger.debug("========== viewById 商品默认配置 ==========");
		VCommodityparams localVCommodityparams = new VCommodityparams();
		String str = "select * from v_commodityparams where tradepartition = '" + this.partitionid + "' " + "and breedid = '"
				+ this.request.getParameter("breedid") + "'";
		List localList = getService().getListBySql(str, localVCommodityparams);
		localVCommodityparams = (VCommodityparams) localList.get(0);
		this.request.setAttribute("entity", localVCommodityparams);
		return "success";
	}

	public String update() {
		this.logger.debug("========== update 商品默认配置 ==========");
		try {
			String str = "update v_commodityparams set tradeunit = '" + this.request.getParameter("tradeunit") + "', " + "minamount = '"
					+ this.request.getParameter("minamount") + "', " + "maxamount = '" + this.request.getParameter("maxamount") + "', "
					+ "stepprice = '" + this.request.getParameter("stepprice") + "', " + "maxstepprice = '" + 0 + "', " + "marginalgr = '"
					+ this.request.getParameter("marginalgr") + "', " + "B_Security = '" + this.request.getParameter("BSecurity") + "', "
					+ "S_Security = '" + this.request.getParameter("SSecurity") + "', " + "feealgr = '" + this.request.getParameter("feealgr") + "', "
					+ "B_Fee = '" + this.request.getParameter("BFee") + "', " + "S_Fee = '" + this.request.getParameter("SFee") + "', "
					+ "flowamountalgr = '" + this.request.getParameter("flowamountalgr") + "', " + "flowamount = '"
					+ this.request.getParameter("flowamount") + "' " + "where tradepartition = '" + this.request.getParameter("tradepartition") + "' "
					+ "and breedid = '" + this.request.getParameter("breedid") + "'";
			getService().executeUpdateBySql(str);
			addReturnValue(1, 211000L);
			this.logger.debug("修改成功");
			writeOperateLog(2105, "商品默认设置修改成功", 1, "");
		} catch (Exception localException) {
			addReturnValue(-1, 213000L);
			this.logger.debug("修改失败");
			writeOperateLog(2105, "商品默认设置修改失败", 0, "");
			localException.printStackTrace();
		}
		return "success";
	}
}
