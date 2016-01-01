package gnnt.MEBS.integrated.mgr.action.usermanage;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import gnnt.MEBS.checkLogon.util.MD5;
import gnnt.MEBS.common.mgr.action.EcsideAction;
import gnnt.MEBS.common.mgr.common.Page;
import gnnt.MEBS.common.mgr.common.PageRequest;
import gnnt.MEBS.common.mgr.common.QueryConditions;
import gnnt.MEBS.common.mgr.statictools.ApplicationContextInit;
import gnnt.MEBS.common.mgr.statictools.Tools;
import gnnt.MEBS.integrated.mgr.model.usermanage.AgentTrader;
import gnnt.MEBS.integrated.mgr.model.usermanage.MFirm;

@Controller("agentTraderAction")
@Scope("request")
public class AgentTraderAction extends EcsideAction {
	private static final long serialVersionUID = -4628426875505296088L;
	@Autowired
	@Resource(name = "agentTraderStatusMap")
	protected Map<Integer, String> agentTraderStatusMap;
	@Resource(name = "agentTraderTypeMap")
	protected Map<Integer, String> agentTraderTypeMap;

	public Map<Integer, String> getAgentTraderStatusMap() {
		return this.agentTraderStatusMap;
	}

	public Map<Integer, String> getAgentTraderTypeMap() {
		return this.agentTraderTypeMap;
	}

	public String agentTraderList() throws Exception {
		PageRequest localPageRequest = super.getPageRequest(this.request);
		QueryConditions localQueryConditions = (QueryConditions) localPageRequest.getFilters();
		String str1 = ApplicationContextInit.getConfig("unListAgentTrader");
		if ((str1 != null) && (str1.trim().length() > 0)) {
			String[] arrayOfString1 = str1.split(",");
			String str2 = "";
			for (String str3 : arrayOfString1) {
				if ((str3 != null) && (str3.trim().length() > 0)) {
					if (str2.trim().length() > 0) {
						str2 = str2 + ",";
					}
					str2 = str2 + "'" + str3.trim() + "'";
				}
			}
			if (str2.trim().length() > 0) {
				localQueryConditions.addCondition(" ", " ", "agentTraderId not in (" + str2 + ")");
			}
		}
		listByLimit(localPageRequest);
		return "success";
	}

	public String addAgentTrader() {
		this.logger.debug("enter addAgentTrader");
		AgentTrader localAgentTrader = (AgentTrader) this.entity;
		localAgentTrader.setPassword(MD5.getMD5(localAgentTrader.getAgentTraderId(), ((AgentTrader) this.entity).getPassword()));
		getService().add(localAgentTrader);
		addReturnValue(1, 111502L, new Object[] { localAgentTrader.getAgentTraderId() });
		return "success";
	}

	public String updateAgentTraderForward() {
		this.entity = getService().get(this.entity);
		AgentTrader localAgentTrader = (AgentTrader) this.entity.clone();
		this.request.setAttribute("entity", this.entity);
		if (localAgentTrader != null) {
			Object[] localObject1;
			Object localObject2;
			if ((localAgentTrader.getOperateFirm() != null) && (localAgentTrader.getOperateFirm().trim().length() > 0)) {
				localObject1 = localAgentTrader.getOperateFirm().split(",");
				localObject2 = "";
				for (Object localObject4 : localObject1) {
					if (((String) localObject4).trim().length() > 0) {
						if (((String) localObject2).length() > 0) {
							localObject2 = (String) localObject2 + ",";
						}
						localObject2 = (String) localObject2 + "'" + (String) localObject4 + "'";
					}
				}
				QueryConditions conditions = new QueryConditions();
				((QueryConditions) conditions).addCondition("firmId", "in", "(" + (String) localObject2 + ")");
				((QueryConditions) conditions).addCondition("status", "in", "('N')");
				PageRequest localPageRequest1 = new PageRequest(1, 100000, conditions, " order by firmId ");
				Page localPage1 = getService().getPage(localPageRequest1, new MFirm());
				this.request.setAttribute("operateFirm", localPage1.getResult());
				Object localObject4 = new QueryConditions();
				((QueryConditions) localObject4).addCondition("firmId", "not in", "(" + (String) localObject2 + ")");
				((QueryConditions) localObject4).addCondition("status", "in", "('N')");
				PageRequest localPageRequest2 = new PageRequest(1, 100000, localObject4, " order by firmId ");
				Page localPage2 = getService().getPage(localPageRequest2, new MFirm());
				this.request.setAttribute("unoperateFirm", localPage2.getResult());
			} else {
				QueryConditions localObject11 = new QueryConditions();
				((QueryConditions) localObject11).addCondition("status", "in", "('N')");
				localObject2 = new PageRequest(1, 100000, localObject11, " order by firmId ");
				Page page = getService().getPage((PageRequest) localObject2, new MFirm());
				this.request.setAttribute("unoperateFirm", ((Page) page).getResult());
			}
		}
		return "success";
	}

	public String updateAgentTrader() {
		AgentTrader localAgentTrader = (AgentTrader) this.entity;
		try {
			localAgentTrader.setModifyTime(getService().getSysDate());
		} catch (Exception localException) {
			this.logger.debug(Tools.getExceptionTrace(localException));
		}
		getService().update(localAgentTrader);
		addReturnValue(1, 119902L, new Object[] { localAgentTrader.getAgentTraderId() });
		return "success";
	}

	public String updatePassword() {
		String str1 = "修改代为交易员密码";
		this.logger.debug(str1);
		this.logger.debug("enter passwordSelfSave");
		String str2 = this.request.getParameter("password");
		AgentTrader localAgentTrader = (AgentTrader) this.entity;
		localAgentTrader.setPassword(MD5.getMD5(localAgentTrader.getAgentTraderId(), str2));
		getService().update(localAgentTrader);
		addReturnValue(1, 111501L, new Object[] { localAgentTrader.getAgentTraderId() });
		return "success";
	}

	public String deleteAgentTrader() throws SecurityException, NoSuchFieldException {
		this.logger.debug("enter deleteAgentTrader");
		String[] arrayOfString = this.request.getParameterValues("ids");
		System.out.println("ids: " + arrayOfString[0]);
		if (arrayOfString.length <= 1) {
			AgentTrader localAgentTrader = new AgentTrader();
			localAgentTrader.setAgentTraderId(arrayOfString[0]);
			localAgentTrader = (AgentTrader) getService().get(localAgentTrader);
			getService().delete(localAgentTrader);
			addReturnValue(1, 111503L, new Object[] { arrayOfString[0] });
		} else {
			delete();
		}
		return "success";
	}
}
