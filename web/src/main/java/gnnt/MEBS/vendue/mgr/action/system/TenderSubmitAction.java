package gnnt.MEBS.vendue.mgr.action.system;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import gnnt.MEBS.common.mgr.action.EcsideAction;
import gnnt.MEBS.common.mgr.statictools.Tools;
import gnnt.MEBS.vendue.mgr.model.system.tenderSubmit.VCursubmittender;
import gnnt.MEBS.vendue.mgr.model.system.tenderSubmit.VCursubmittenderplan;

@Controller("tenderSubmitAction")
@Scope("request")
public class TenderSubmitAction extends EcsideAction {
	private static final long serialVersionUID = 1L;
	@Resource(name = "tenderSubmit_WithdrawTypeMap")
	private Map<Integer, String> tenderSubmit_WithdrawTypeMap;
	@Resource(name = "batgainCurSubmit_OrderType")
	private Map<Byte, String> batgainCurSubmit_OrderType;

	public Map<Byte, String> getBatgainCurSubmit_OrderType() {
		return this.batgainCurSubmit_OrderType;
	}

	public void setBatgainCurSubmit_OrderType(Map<Byte, String> paramMap) {
		this.batgainCurSubmit_OrderType = paramMap;
	}

	public Map<Integer, String> getTenderSubmit_WithdrawTypeMap() {
		return this.tenderSubmit_WithdrawTypeMap;
	}

	public void setTenderSubmit_WithdrawTypeMap(Map<Integer, String> paramMap) {
		this.tenderSubmit_WithdrawTypeMap = paramMap;
	}

	public String getPartitionInfo() {
		this.logger.debug("------------取得所有版块名称--------------");
		String str = "select p.partitionID, p.description, p.trademode from v_sysPartition p where  TRADEMODE=3 and validFlag = 1";
		List localList = getService().getListBySql(str);
		this.request.setAttribute("partition", localList);
		return "success";
	}

	public String getTenderSubmitList() {
		this.logger.debug("------------获取招标计划委托表--------------");
		String str1 = this.request.getParameter("partitionid");
		String str2 = this.request.getParameter("trademode");
		String str3 = this.request.getParameter("code");
		String str4 = "";
		Object localObject1 = this.request.getAttribute("fromMakeSure");
		if ((localObject1 != null) && (localObject1.toString().equals("yes"))) {
			str3 = null;
		}
		if ((str1 == null) || (str1.length() <= 0) || (str2 == null) || (str2.length() <= 0)) {
			str4 = "没有获取到交易模式号或交易板块号";
			return "success";
		}
		String str5 = "select code from v_commodity where TenderTradeConfirm=0 and status=1 and tradePartition=" + str1;
		List localList1 = getService().getListBySql(str5);
		this.request.setAttribute("codeList", localList1);
		Object localObject2;
		if (((str3 == null) || (str3.length() <= 0)) && (localList1 != null) && (localList1.size() > 0)) {
			localObject2 = ((Map) localList1.get(0)).get("CODE");
			if (localObject2 != null) {
				str3 = localObject2.toString();
			}
		}
		if ((str3 != null) && (str3.length() > 0)) {
			localObject2 = new StringBuffer("select * from v_curSubmitTenderPlan ").append(" where Code=").append(str3).append(" and tradePartition=")
					.append(str1);
			List localList2 = getService().getListBySql(((StringBuffer) localObject2).toString());
			this.request.setAttribute("tenderSubmitList", localList2);
		}
		this.request.setAttribute("msg", str4);
		this.request.setAttribute("code", str3);
		this.request.setAttribute("trademode", str2);
		this.request.setAttribute("partitionid", str1);
		return "success";
	}

	public String deleteTenderSubmitList() {
		this.logger.debug("------------------删除招标委托----------------------");
		try {
			delete();
			writeOperateLog(2103, "批量删除招标委托成功", 1, "");
			this.request.setAttribute("msg", "删除成功");
		} catch (Exception localException) {
			this.request.setAttribute("msg", "删除失败");
			writeOperateLog(2103, "批量删除招标委托失败", 0, "");
			localException.printStackTrace();
		}
		return "success";
	}

	public String addTenderSubmitForward() {
		this.logger.debug("------------------计划招标委托添加跳转-----------------------");
		String str1 = this.request.getParameter("partitionid");
		String str2 = this.request.getParameter("trademode");
		String str3 = this.request.getParameter("code");
		String str4 = "";
		String[] arrayOfString = this.request.getParameterValues("ids");
		if ((str1 != null) && (str1.length() > 0)) {
			if ((str2 != null) && (str2.length() > 0)) {
				if ((str3 != null) && (str3.length() > 0)) {
					StringBuffer localObject = new StringBuffer();
					((StringBuffer) localObject).append("select *").append(" from v_curSubmitTender t1").append(" where t1.tradePartition =")
							.append(str1).append(" and t1.Code =").append(str3).append(" and t1.id not in (select id ")
							.append("                  from v_curSubmitTenderPlan t2").append("                  where t2.tradePartition =")
							.append(str1).append("                  and t2.code =").append(str3).append(")");
					List localList1 = getService().getListBySql(((StringBuffer) localObject).toString());
					this.request.setAttribute("info", localList1);
					StringBuffer localStringBuffer = new StringBuffer();
					localStringBuffer.append(" select vs.isSplitTarget,vc.tradeUnit,vc.minAmount,vc.maxAmount ")
							.append(" from v_sysPartition vs,v_commodity vc ").append(" where vs.partitionID=").append(str1).append(" and vc.code=")
							.append(str3);
					List localList2 = getService().getListBySql(localStringBuffer.toString());
					if ((localList2 != null) && (localList2.size() > 0)) {
						Map localMap = (Map) localList2.get(0);
						double d1 = Double.parseDouble(localMap.get("TRADEUNIT").toString());
						double d2 = Double.parseDouble(localMap.get("MINAMOUNT").toString());
						double d3 = Double.parseDouble(localMap.get("MAXAMOUNT").toString());
						int j = Integer.parseInt(localMap.get("ISSPLITTARGET").toString());
						this.request.setAttribute("tradeUnit", Double.valueOf(d1));
						this.request.setAttribute("minAmount", Double.valueOf(d2));
						this.request.setAttribute("maxAmount", Double.valueOf(d3));
						this.request.setAttribute("isSplitTarget", Integer.valueOf(j));
					}
				} else {
					str4 = "没有获取到标的号";
				}
			} else {
				str4 = "没有获取到交易模式号";
			}
		} else {
			str4 = "没有获取到交易板块号";
		}
		Object localObject = "";
		if (arrayOfString != null) {
			for (int i = 0; i < arrayOfString.length; i++) {
				if (i == arrayOfString.length - 1) {
					localObject = (String) localObject + arrayOfString[i];
				} else {
					localObject = (String) localObject + arrayOfString[i] + ",";
				}
			}
		}
		this.request.setAttribute("ids", localObject);
		this.request.setAttribute("msg", str4);
		this.request.setAttribute("code", str3);
		this.request.setAttribute("trademode", str2);
		this.request.setAttribute("partitionid", str1);
		return "success";
	}

	public String addTenderSubmit() {
		this.logger.debug("------------------计划招标委托添加---------------------");
		String str1 = this.request.getParameter("partitionid");
		String str2 = this.request.getParameter("trademode");
		String str3 = this.request.getParameter("code");
		String str4 = "";
		StringBuffer localStringBuffer = new StringBuffer();
		int i = 0;
		String[] arrayOfString1 = this.request.getParameterValues("ids");
		if ((arrayOfString1 != null) && (arrayOfString1.length > 0)) {
			for (int j = 0; j < arrayOfString1.length; j++) {
				String[] arrayOfString2 = arrayOfString1[j].split("_");
				if (arrayOfString2.length == 3) {
					long l = Long.parseLong(arrayOfString2[0]);
					double d = Double.parseDouble(arrayOfString2[2]);
					VCursubmittender localVCursubmittender = new VCursubmittender();
					localVCursubmittender.setId(Long.valueOf(l));
					localVCursubmittender = (VCursubmittender) getService().get(localVCursubmittender);
					VCursubmittenderplan localVCursubmittenderplan = new VCursubmittenderplan();
					Tools.CopyValue(localVCursubmittender, localVCursubmittenderplan);
					localVCursubmittenderplan.setConfirmamount(Double.valueOf(d));
					localVCursubmittenderplan.setModifytime(new Date());
					try {
						getService().add(localVCursubmittenderplan);
						i++;
						writeOperateLog(2103, "计划招标委托成功，委托号：" + l, 1, "");
					} catch (Exception localException) {
						localStringBuffer.append(l).append(",");
						writeOperateLog(2103, "计划招标委托失败，委托号：" + l, 0, "");
						localException.printStackTrace();
					}
				}
			}
			str4 = "您提交了" + arrayOfString1.length + "条数据，添加成功" + i + "条\\n";
			if (!localStringBuffer.toString().equals("")) {
				str4 = str4 + "添加失败记录的委托号：" + localStringBuffer.toString().substring(0, localStringBuffer.toString().lastIndexOf(","));
			}
		}
		this.request.setAttribute("msg", str4);
		this.request.setAttribute("code", str3);
		this.request.setAttribute("trademode", str2);
		this.request.setAttribute("partitionid", str1);
		return "success";
	}

	public String makeSureTenderSubmit() {
		this.logger.debug("------------------确认成交---------------------");
		String str1 = this.request.getParameter("mscode");
		String str2 = this.request.getParameter("partitionid");
		String str3 = this.request.getParameter("trademode");
		String[] arrayOfString = { str1 };
		Object localObject = null;
		if ((str1 != null) && (str1.length() > 0)) {
			try {
				localObject = getService().executeProcedure("{? = call FN_V_TradeTenderAudit(?)}", arrayOfString);
				if (localObject != null) {
					int i = Integer.parseInt(localObject.toString());
					if (i == 1) {
						writeOperateLog(2103, "确认成交成功", 1, "");
						addReturnValue(1, 211017L);
					} else if (i == -1) {
						writeOperateLog(2103, "确认成交失败", 0, "");
						addReturnValue(-1, 213027L);
					} else if (i == -2) {
						writeOperateLog(2103, "确认成交失败", 0, "");
						addReturnValue(0, 212005L);
					}
				}
			} catch (Exception localException) {
				writeOperateLog(2103, "确认成交失败", 0, "");
				addReturnValue(1, 213028L);
				localException.printStackTrace();
			}
		} else {
			addReturnValue(0, 212006L);
		}
		this.request.setAttribute("fromMakeSure", "yes");
		this.request.setAttribute("trademode", str3);
		this.request.setAttribute("partitionid", str2);
		return "success";
	}
}
