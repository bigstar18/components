package gnnt.MEBS.vendue.mgr.action.system;

import gnnt.MEBS.common.mgr.action.EcsideAction;
import gnnt.MEBS.common.mgr.common.Page;
import gnnt.MEBS.common.mgr.common.PageRequest;
import gnnt.MEBS.common.mgr.common.QueryConditions;
import gnnt.MEBS.common.mgr.service.StandardService;
import gnnt.MEBS.vendue.mgr.model.system.flowcontrol.SysFlowControl;
import gnnt.MEBS.vendue.mgr.service.system.flowcontrol.SysFlowControlService;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.logging.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

@Controller("sysFlowControlAction")
@Scope("request")
public class SysFlowControlAction
  extends EcsideAction
{
  private static final long serialVersionUID = -3327116825360887297L;
  @Autowired
  @Qualifier("sysFlowControlService")
  private SysFlowControlService sysFlowControlService;
  
  public String listSysFlowControl()
  {
    this.logger.debug("enter listSysFlowControl");
    Short localShort1 = Short.valueOf(Short.parseShort(this.request.getParameter("partitionid")));
    Short localShort2 = Short.valueOf(Short.parseShort(this.request.getParameter("trademode")));
    try
    {
      String str = this.sysFlowControlService.viewPartitionname(localShort1);
      PageRequest localPageRequest = getPageRequest(this.request);
      QueryConditions localQueryConditions = (QueryConditions)localPageRequest.getFilters();
      localQueryConditions.addCondition("tradepartition", "=", localShort1);
      Page localPage = getService().getPage(localPageRequest, new SysFlowControl());
      this.request.setAttribute("pageInfo", localPage);
      this.request.setAttribute("trademode", localShort2);
      this.request.setAttribute("partitionid", localShort1);
      this.request.setAttribute("partitionname", str);
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
    }
    return "success";
  }
  
  public String forwardSysUpdate()
  {
    Short localShort1 = Short.valueOf(Short.parseShort(this.request.getParameter("partitionid")));
    Short localShort2 = Short.valueOf(Short.parseShort(this.request.getParameter("trademode")));
    Integer localInteger = this.sysFlowControlService.viewMaxShowQtyById(localShort1);
    String str = this.sysFlowControlService.listProperty(localShort1, -1);
    this.request.setAttribute("propertyList", str);
    this.entity = getService().get(new SysFlowControl(localShort1));
    List localList = this.sysFlowControlService.listBreed();
    this.request.setAttribute("maxshowqty", localInteger);
    this.request.setAttribute("partitionid", localShort1);
    this.request.setAttribute("trademode", localShort2);
    this.request.setAttribute("breedList", localList);
    return "success";
  }
  
  public String updateSysFlow()
  {
    this.logger.debug("enter updateFlow");
    String str = this.request.getParameter("propertyListForAdd");
    SysFlowControl localSysFlowControl = (SysFlowControl)this.entity;
    Integer localInteger = this.sysFlowControlService.updateSysFlow(localSysFlowControl, str);
    if (localInteger.intValue() == 1)
    {
      addReturnValue(1, 211000L);
      writeOperateLog(2103, "修改默认交易节成功", 1, "");
    }
    else
    {
      addReturnValue(-1, 213000L);
      writeOperateLog(2103, "修改默认交易节失败", 0, "");
    }
    return "success";
  }
}
