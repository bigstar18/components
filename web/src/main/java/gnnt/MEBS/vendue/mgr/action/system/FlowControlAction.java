package gnnt.MEBS.vendue.mgr.action.system;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import gnnt.MEBS.common.mgr.action.EcsideAction;
import gnnt.MEBS.common.mgr.common.Page;
import gnnt.MEBS.common.mgr.common.PageRequest;
import gnnt.MEBS.common.mgr.common.QueryConditions;
import gnnt.MEBS.vendue.mgr.model.system.flowcontrol.FlowControl;
import gnnt.MEBS.vendue.mgr.model.system.flowcontrol.FlowcontrolId;
import gnnt.MEBS.vendue.mgr.model.system.sysPartition.VSyspartition;
import gnnt.MEBS.vendue.mgr.service.system.flowcontrol.FlowControlService;

@Controller("flowControlAction")
@Scope("request")
public class FlowControlAction extends EcsideAction {
	private static final long serialVersionUID = -1350190498190265845L;
	@Autowired
	@Qualifier("flowControlService")
	private FlowControlService flowControlService;
	@Resource(name = "flow_isMarginCountMap")
	private Map<Byte, String> flow_isMarginCountMap;
	@Resource(name = "flow_unitTypeMap")
	private Map<Byte, String> flow_unitTypeMap;
	@Resource(name = "flow_startTypeMap")
	private Map<Byte, String> flow_startTypeMap;

	public Map<Byte, String> getFlow_isMarginCountMap() {
		return this.flow_isMarginCountMap;
	}

	public void setFlow_isMarginCountMap(Map<Byte, String> paramMap) {
		this.flow_isMarginCountMap = paramMap;
	}

	public Map<Byte, String> getFlow_unitTypeMap() {
		return this.flow_unitTypeMap;
	}

	public void setFlow_unitTypeMap(Map<Byte, String> paramMap) {
		this.flow_unitTypeMap = paramMap;
	}

	public Map<Byte, String> getFlow_startTypeMap() {
		return this.flow_startTypeMap;
	}

	public void setFlow_startTypeMap(Map<Byte, String> paramMap) {
		this.flow_startTypeMap = paramMap;
	}

	public String listFlowControl() {
		this.logger.debug("enter listFlowControl");
		Short localShort1 = Short.valueOf(Short.parseShort(this.request.getParameter("partitionid")));
		Short localShort2 = Short.valueOf(Short.parseShort(this.request.getParameter("trademode")));
		this.request.setAttribute("trademode", localShort2);
		this.request.setAttribute("partitionid", localShort1);
		VSyspartition localVSyspartition = new VSyspartition();
		localVSyspartition.setPartitionid(localShort1);
		localVSyspartition = (VSyspartition) getService().get(localVSyspartition);
		this.request.setAttribute("partition", localVSyspartition);
		try {
			String str = this.flowControlService.viewPartitionname(localShort1);
			Integer localInteger = this.flowControlService.viewCountModeById(localShort1);
			PageRequest localPageRequest = getPageRequest(this.request);
			QueryConditions localQueryConditions = (QueryConditions) localPageRequest.getFilters();
			localQueryConditions.addCondition("tradepartition", "=", localShort1);
			Page localPage = getService().getPage(localPageRequest, new FlowControl());
			this.request.setAttribute("pageInfo", localPage);
			this.request.setAttribute("partitionname", str);
			this.request.setAttribute("countmode", localInteger);
			this.logger.debug("=====================>>>countmode =" + localInteger);
		} catch (Exception localException) {
			localException.printStackTrace();
		}
		return "success";
	}

	public String forwardAdd() {
		Short localShort1 = Short.valueOf(Short.parseShort(this.request.getParameter("partitionid")));
		Short localShort2 = Short.valueOf(Short.parseShort(this.request.getParameter("trademode")));
		this.request.setAttribute("partitionid", localShort1);
		this.request.setAttribute("trademode", localShort2);
		Integer localInteger1 = this.flowControlService.viewMaxShowQtyById(localShort1);
		Integer localInteger2 = this.flowControlService.viewCountModeById(localShort1);
		List localList = this.flowControlService.listBreed();
		this.request.setAttribute("maxshowqty", localInteger1);
		this.request.setAttribute("breedList", localList);
		this.request.setAttribute("countmode", localInteger2);
		return "success";
	}

	public String addFlow() {
		this.logger.debug("enter addFlowAction");
		String str = this.request.getParameter("propertyListForAdd");
		FlowControl localFlowControl = (FlowControl) this.entity;
		Integer localInteger = this.flowControlService.addFlow(localFlowControl, str);
		if (localInteger.intValue() == 1) {
			addReturnValue(1, 211001L);
			writeOperateLog(2103, "添加交易节成功", 1, "");
		} else {
			addReturnValue(-1, 213004L);
			writeOperateLog(2103, "添加交易节失败", 0, "");
		}
		return "success";
	}

	public String forwardUpdate() {
		Short localShort1 = Short.valueOf(Short.parseShort(this.request.getParameter("partitionid")));
		Short localShort2 = Short.valueOf(Short.parseShort(this.request.getParameter("trademode")));
		Integer localInteger1 = this.flowControlService.viewMaxShowQtyById(localShort1);
		Integer localInteger2 = this.flowControlService.viewCountModeById(localShort1);
		Byte localByte = new Byte(this.request.getParameter("unittype"));
		Integer localInteger3 = new Integer(this.request.getParameter("unitid"));
		this.entity = getService().get(new FlowControl(new FlowcontrolId(localShort1, localByte, localInteger3)));
		if (localByte.byteValue() == 1) {
			String localObject = this.flowControlService.listProperty(localShort1, localInteger3);
			this.request.setAttribute("propertyList", localObject);
		}
		Object localObject = this.flowControlService.listBreed();
		this.request.setAttribute("maxshowqty", localInteger1);
		this.request.setAttribute("partitionid", localShort1);
		this.request.setAttribute("trademode", localShort2);
		this.request.setAttribute("breedList", localObject);
		this.request.setAttribute("countmode", localInteger2);
		return "success";
	}

	public String updateFlow() {
		this.logger.debug("enter updateFlow");
		String str = this.request.getParameter("propertyListForAdd");
		FlowControl localFlowControl = (FlowControl) this.entity;
		Integer localInteger1 = new Integer(this.request.getParameter("old_unitid"));
		Byte localByte = new Byte(this.request.getParameter("old_unittype"));
		Integer localInteger2 = this.flowControlService.updateFlow(localFlowControl, str, localInteger1, localByte);
		if (localInteger2.intValue() == 1) {
			addReturnValue(1, 211000L);
			writeOperateLog(2103, "修改交易节成功", 1, "");
		} else {
			addReturnValue(-1, 213000L);
			writeOperateLog(2103, "修改交易节失败", 0, "");
		}
		return "success";
	}

	public String deleteFlow() {
		this.logger.debug("enter deleteFlow");
		String[] arrayOfString = this.request.getParameterValues("ids");
		Integer localInteger = this.flowControlService.deleteFlow(arrayOfString);
		if (localInteger.intValue() == 1) {
			addReturnValue(1, 211002L);
			writeOperateLog(2103, "删除交易节成功", 1, "");
		} else {
			addReturnValue(-1, 213005L);
			writeOperateLog(2103, "删除交易节失败", 0, "");
		}
		return "success";
	}
}
