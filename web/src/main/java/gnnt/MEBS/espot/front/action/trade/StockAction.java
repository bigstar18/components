package gnnt.MEBS.espot.front.action.trade;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import gnnt.MEBS.common.front.action.StandardAction;
import gnnt.MEBS.common.front.common.Page;
import gnnt.MEBS.common.front.common.PageRequest;
import gnnt.MEBS.common.front.common.QueryConditions;
import gnnt.MEBS.common.front.model.StandardModel;
import gnnt.MEBS.common.front.model.integrated.User;
import gnnt.MEBS.common.front.statictools.ActionUtil;
import gnnt.MEBS.common.front.statictools.Tools;
import gnnt.MEBS.espot.core.kernel.IKernelService;
import gnnt.MEBS.espot.core.kernel.IWareHouseStockProcess;
import gnnt.MEBS.espot.front.common.XTradeFrontGlobal;
import gnnt.MEBS.espot.front.model.commodity.Category;
import gnnt.MEBS.espot.front.model.commodity.PropertyType;
import gnnt.MEBS.espot.front.model.warehousestock.Stock;
import gnnt.MEBS.espot.front.model.warehousestock.WareHouseGoodsProperty;
import net.sf.json.JSONArray;

@Controller("stockAction")
@Scope("request")
public class StockAction extends StandardAction {
	private static final long serialVersionUID = 8998786414629350012L;
	@Resource(name = "wareHouseStockService")
	private IWareHouseStockProcess wareHouseStockService;
	private JSONArray jsonReturn;
	@Autowired
	@Qualifier("kernelService")
	private IKernelService kernelService;

	public JSONArray getJsonReturn() {
		return this.jsonReturn;
	}

	public IKernelService getKernelService() {
		return this.kernelService;
	}

	public void setKernelService(IKernelService paramIKernelService) {
		this.kernelService = paramIKernelService;
	}

	public IWareHouseStockProcess getWareHouseStockService() {
		return this.wareHouseStockService;
	}

	public void setWareHouseStockService(IWareHouseStockProcess paramIWareHouseStockProcess) {
		this.wareHouseStockService = paramIWareHouseStockProcess;
	}

	public String getNotUseStock() {
		this.logger.debug("获取当前用户没有使用的仓单信息");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		String str = "from Stock s where  belongtoFirm.firmID='" + localUser.getBelongtoFirm().getFirmID()
				+ "' and status=1 and 0=(select count(c.operationID) from s.containOperation c) " + "and s.belongtoBreed.breedID in("
				+ XTradeFrontGlobal.breedStr + ")";
		System.out.println(XTradeFrontGlobal.breedStr);
		Page localPage = null;
		try {
			localPage = getService().getDao().queryByHQL(str, null, ActionUtil.getPageRequest(this.request), null);
			if ((localPage.getResult() != null) && (localPage.getResult().size() > 0)) {
				Iterator localIterator = localPage.getResult().iterator();
				while (localIterator.hasNext()) {
					StandardModel localStandardModel = (StandardModel) localIterator.next();
					Stock localStock = (Stock) localStandardModel;
					PageRequest localPageRequest = new PageRequest(
							" and primary.categoryID=" + localStock.getBelongtoBreed().getBelongtoCategory().getCategoryID());
					getService().getPage(localPageRequest, new Category());
				}
			}
		} catch (Exception localException) {
			addReturnValue(-1, -10006L, new Object[] { "未使用仓单信息获取" });
			this.logger.error(Tools.getExceptionTrace(localException));
		}
		this.request.setAttribute("pageInfo", localPage);
		return "success";
	}

	public String getStockJson() {
		this.logger.debug("通过仓单编号获取仓单信息，并封装成json对象");
		String str = this.request.getParameter("stockID");
		if ((str != null) && (str.trim().length() > 0)) {
			this.jsonReturn = new JSONArray();
			Stock localStock = new Stock();
			localStock.setStockID(str);
			localStock = (Stock) getService().get(localStock);
			HashMap localHashMap1 = new HashMap();
			localHashMap1.put("tradeMode", localStock.getBelongtoBreed().getTradeMode());
			localHashMap1.put("breedID", "" + localStock.getBelongtoBreed().getBreedID());
			localHashMap1.put("breedName", localStock.getBelongtoBreed().getBreedName());
			localHashMap1.put("categoryID", "" + localStock.getBelongtoBreed().getBelongtoCategory().getCategoryID());
			localHashMap1.put("warehouseID", localStock.getWarehouseID());
			localHashMap1.put("unit", localStock.getUnit());
			localHashMap1.put("quantity", localStock.getQuantity());
			ArrayList localArrayList = new ArrayList();
			QueryConditions localQueryConditions = new QueryConditions();
			localQueryConditions.addCondition("status", "=", Integer.valueOf(0));
			PageRequest localPageRequest = new PageRequest(1, 100, localQueryConditions, " order by sortNo ");
			Page localPage = getService().getPage(localPageRequest, new PropertyType());
			Object localObject2;
			if ((localPage != null) && (localPage.getResult() != null)) {
				for (int i = 0; i < localPage.getResult().size(); i++) {
					PropertyType localObject1 = (PropertyType) localPage.getResult().get(i);
					localObject2 = new HashMap();
					((Map) localObject2).put("name", ((PropertyType) localObject1).getName());
					((Map) localObject2).put("propertyTypeID", ((PropertyType) localObject1).getPropertyTypeID());
					((Map) localObject2).put("property", new JSONArray());
					localArrayList.add(localObject2);
				}
			}
			HashMap localHashMap2 = new HashMap();
			localHashMap2.put("name", "其它属性");
			localHashMap2.put("propertyTypeID", Integer.valueOf(-1));
			localHashMap2.put("property", new JSONArray());
			Object localObject1 = localStock.getContainProperty().iterator();
			JSONArray localJSONArray;
			while (((Iterator) localObject1).hasNext()) {
				localObject2 = (WareHouseGoodsProperty) ((Iterator) localObject1).next();
				localJSONArray = null;
				HashMap localHashMap3 = new HashMap();
				localHashMap3.put("key", ((WareHouseGoodsProperty) localObject2).getPropertyName());
				localHashMap3.put("value", ((WareHouseGoodsProperty) localObject2).getPropertyValue());
				localHashMap3.put("tpid", "" + ((WareHouseGoodsProperty) localObject2).getPropertyTypeID());
				for (int k = 0; k < localArrayList.size(); k++) {
					if (((WareHouseGoodsProperty) localObject2).getPropertyTypeID().equals(((Map) localArrayList.get(k)).get("propertyTypeID"))) {
						localJSONArray = (JSONArray) ((Map) localArrayList.get(k)).get("property");
					}
				}
				if (localJSONArray == null) {
					localJSONArray = (JSONArray) localHashMap2.get("property");
				}
				localJSONArray.add(localHashMap3);
			}
			localObject1 = new ArrayList();
			for (int j = 0; j < localArrayList.size(); j++) {
				localJSONArray = (JSONArray) ((Map) localArrayList.get(j)).get("property");
				if (localJSONArray.size() > 0) {
					((List) localObject1).add(localArrayList.get(j));
				}
			}
			if (((JSONArray) localHashMap2.get("property")).size() > 0) {
				((List) localObject1).add(localHashMap2);
			}
			localHashMap1.put("property", localObject1);
			this.jsonReturn.add(localHashMap1);
		}
		this.logger.debug("---------------[" + this.jsonReturn.toString());
		return "success";
	}
}
