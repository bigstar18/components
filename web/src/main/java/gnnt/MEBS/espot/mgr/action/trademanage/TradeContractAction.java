package gnnt.MEBS.espot.mgr.action.trademanage;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import gnnt.MEBS.common.mgr.action.EcsideAction;
import gnnt.MEBS.common.mgr.common.Page;
import gnnt.MEBS.common.mgr.common.PageRequest;
import gnnt.MEBS.common.mgr.common.QueryConditions;
import gnnt.MEBS.common.mgr.model.User;
import gnnt.MEBS.common.mgr.statictools.Tools;
import gnnt.MEBS.espot.core.kernel.ITradeProcess;
import gnnt.MEBS.espot.core.vo.ResultVO;
import gnnt.MEBS.espot.mgr.model.commoditymanage.PropertyType;
import gnnt.MEBS.espot.mgr.model.parametermanage.SystemProps;
import gnnt.MEBS.espot.mgr.model.trademanage.TradeContract;
import gnnt.MEBS.espot.mgr.model.trademanage.TradeGoodsProperty;

@Controller("tradeContractAction")
@Scope("request")
public class TradeContractAction extends EcsideAction {
	private static final long serialVersionUID = -8937777138382137754L;
	@Autowired
	@Qualifier("tradeProcessService")
	private ITradeProcess tradeProcessService;
	@Resource(name = "tradeContractStatusMap")
	protected Map<String, String> tradeContractStatusMap;
	@Resource(name = "tradeAutoContractStatusMap")
	protected Map<String, String> tradeAutoContractStatusMap;
	@Resource(name = "tradeTypeMap")
	protected Map<String, String> tradeTypeMap;

	public Map<String, String> getTradeContractStatusMap() {
		return this.tradeContractStatusMap;
	}

	public Map<String, String> getTradeAutoContractStatusMap() {
		return this.tradeAutoContractStatusMap;
	}

	public Map<String, String> getTradeTypeMap() {
		return this.tradeTypeMap;
	}

	public ITradeProcess getTradeProcessService() {
		return this.tradeProcessService;
	}

	public void setTradeProcessService(ITradeProcess paramITradeProcess) {
		this.tradeProcessService = paramITradeProcess;
	}

	public String tradeList() throws Exception {
		this.logger.debug("enter tradeList");
		PageRequest localPageRequest = super.getPageRequest(this.request);
		QueryConditions localQueryConditions = (QueryConditions) localPageRequest.getFilters();
		localQueryConditions.addCondition("primary.tradeType", "=", Integer.valueOf(0));
		listByLimit(localPageRequest);
		SystemProps localSystemProps = new SystemProps();
		localSystemProps.setPropsKey("PayTimes");
		localSystemProps = (SystemProps) getService().get(localSystemProps);
		this.request.setAttribute("PayTimes", Integer.valueOf(Tools.strToInt(localSystemProps.getRunTimeValue())));
		return "success";
	}

	public String autoTradeList() throws Exception {
		this.logger.debug("enter autoTradeList");
		PageRequest localPageRequest = super.getPageRequest(this.request);
		QueryConditions localQueryConditions = (QueryConditions) localPageRequest.getFilters();
		localQueryConditions.addCondition("primary.tradeType", "=", Integer.valueOf(1));
		listByLimit(localPageRequest);
		return "success";
	}

	public String listAudit() throws Exception {
		this.logger.debug("enter listAudit");
		PageRequest localPageRequest = getPageRequest(this.request);
		QueryConditions localQueryConditions = (QueryConditions) localPageRequest.getFilters();
		localQueryConditions.addCondition("status", "in", "(21,22)");
		listByLimit(localPageRequest);
		return "success";
	}

	public String getTradeByTradeNO() {
		this.logger.debug("enter getTradeByTradeNO");
		this.entity = getService().get(this.entity);
		TradeContract localTradeContract = (TradeContract) this.entity;
		Calendar localCalendar = Calendar.getInstance();
		localCalendar.setTime(localTradeContract.getTime());
		localCalendar.add(13, localTradeContract.getTradePreTime().intValue());
		this.request.setAttribute("tradePreTime", localCalendar.getTime());
		putResourcePropertys(localTradeContract.getTradeGoodsProperties());
		return "success";
	}

	public String breachProcess() {
		this.logger.debug("enter breachProcess");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		try {
			ResultVO localResultVO = this.tradeProcessService.performBreachingTrade(((Long) this.entity.fetchPKey().getValue()).longValue(),
					localUser.getUserId());
			if (localResultVO.getResult() <= 0L) {
				addReturnValue(-1, 230003L, new Object[] { localResultVO.getErrorInfo() });
				writeOperateLog(2309, "合同号为：" + this.entity.fetchPKey().getValue() + "的异常合同处理", 0, localResultVO.getErrorInfo());
			} else {
				addReturnValue(1, 230000L);
				writeOperateLog(2309, "合同号为：" + this.entity.fetchPKey().getValue() + "的异常合同处理", 1, "");
			}
		} catch (Exception localException) {
			localException.printStackTrace();
			addReturnValue(-1, 230006L, new Object[] { "处理待违约处理的合同操作" });
			writeOperateLog(2309, "合同号为：" + this.entity.fetchPKey().getValue() + "的异常合同处理", 0, localException.getMessage());
		}
		return "success";
	}

	public String breachPerform() {
		this.logger.debug("enter breachPerform");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		try {
			ResultVO localResultVO = this.tradeProcessService.performRecoverTrade(((Long) this.entity.fetchPKey().getValue()).longValue(),
					localUser.getUserId());
			if (localResultVO.getResult() <= 0L) {
				addReturnValue(-1, 230003L, new Object[] { localResultVO.getErrorInfo() });
				writeOperateLog(2309, "恢复合同号为：" + this.entity.fetchPKey().getValue() + "的异常合同", 0, localResultVO.getErrorInfo());
			} else {
				addReturnValue(1, 230000L);
				writeOperateLog(2309, "恢复合同号为：" + this.entity.fetchPKey().getValue() + "的异常合同", 1, "");
			}
		} catch (Exception localException) {
			localException.printStackTrace();
			addReturnValue(-1, 230006L, new Object[] { "恢复待违约处理的合同操作" });
			writeOperateLog(2309, "恢复合同号为：" + this.entity.fetchPKey().getValue() + "的异常合同", 0, localException.getMessage());
		}
		return "success";
	}

	private void putResourcePropertys(Set<TradeGoodsProperty> paramSet) {
		if ((paramSet != null) && (paramSet.size() > 0)) {
			LinkedHashMap localLinkedHashMap = new LinkedHashMap();
			QueryConditions localQueryConditions = new QueryConditions();
			localQueryConditions.addCondition("status", "=", Integer.valueOf(0));
			PageRequest localPageRequest = new PageRequest(1, 100, localQueryConditions, " order by sortNo ");
			Page localPage = getService().getPage(localPageRequest, new PropertyType());
			if ((localPage != null) && (localPage.getResult() != null)) {
				for (int i = 0; i < localPage.getResult().size(); i++) {
					PropertyType localObject1 = (PropertyType) localPage.getResult().get(i);
					localLinkedHashMap.put(localObject1, new ArrayList());
				}
			}
			ArrayList localArrayList = new ArrayList();
			Object localObject1 = paramSet.iterator();
			Object localObject3;
			while (((Iterator) localObject1).hasNext()) {
				TradeGoodsProperty localObject2 = (TradeGoodsProperty) ((Iterator) localObject1).next();
				localObject3 = null;
				Iterator localIterator = localLinkedHashMap.keySet().iterator();
				while (localIterator.hasNext()) {
					PropertyType localPropertyType = (PropertyType) localIterator.next();
					if ((((TradeGoodsProperty) localObject2).getPropertyTypeID() != null)
							&& (((TradeGoodsProperty) localObject2).getPropertyTypeID().equals(localPropertyType.getPropertyTypeID()))) {
						localObject3 = (List) localLinkedHashMap.get(localPropertyType);
					}
				}
				if (localObject3 == null) {
					localObject3 = localArrayList;
				}
				((List) localObject3).add(localObject2);
			}
			localObject1 = new LinkedHashMap();
			Object localObject2 = localLinkedHashMap.keySet().iterator();
			while (((Iterator) localObject2).hasNext()) {
				localObject3 = (PropertyType) ((Iterator) localObject2).next();
				if (((List) localLinkedHashMap.get(localObject3)).size() > 0) {
					((Map) localObject1).put(localObject3, localLinkedHashMap.get(localObject3));
				}
			}
			if (localArrayList.size() > 0) {
				localObject2 = new PropertyType();
				((PropertyType) localObject2).setName("其它属性");
				((PropertyType) localObject2).setPropertyTypeID(Long.valueOf(-1L));
				((Map) localObject1).put(localObject2, localArrayList);
			}
			this.request.setAttribute("tpmap", localObject1);
		}
	}
}
