package gnnt.MEBS.vendue.mgr.beanforajax;

import com.opensymphony.xwork2.ActionContext;
import gnnt.MEBS.common.mgr.beanforajax.BaseAjax;
import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.service.StandardService;
import gnnt.MEBS.vendue.mgr.model.system.flowcontrol.FlowControl;
import gnnt.MEBS.vendue.mgr.model.system.flowcontrol.FlowcontrolId;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import net.sf.json.JSONArray;
import org.apache.commons.logging.Log;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

@Controller("ajaxCheckFlowControl")
@Scope("request")
public class AjaxCheckFlowControl
  extends BaseAjax
{
  private boolean existModelId(Object paramObject, StandardModel paramStandardModel)
  {
    boolean bool = false;
    List localList = getService().getListByBulk(paramStandardModel, new Object[] { paramObject });
    if ((localList != null) && (localList.size() > 0)) {
      bool = true;
    }
    return bool;
  }
  
  public String formCheckFlowControlById()
  {
    this.logger.debug("enter ajax for check ");
    try
    {
      ActionContext localActionContext = ActionContext.getContext();
      HttpServletRequest localHttpServletRequest = (HttpServletRequest)localActionContext.get("com.opensymphony.xwork2.dispatcher.HttpServletRequest");
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
        this.jsonValidateReturn = getJSONArrayList(new JSONArray[] { createJSONArray(new Object[] { "unitId", Boolean.valueOf(false), "该交易节编号已存在" }) });
      }
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
    }
    return "success";
  }
  
  private JSONArray getJSONArrayList(JSONArray... paramVarArgs)
  {
    JSONArray localJSONArray1 = new JSONArray();
    for (JSONArray localJSONArray2 : paramVarArgs) {
      localJSONArray1.add(localJSONArray2);
    }
    return localJSONArray1;
  }
  
  private JSONArray getJSONArray(Object... paramVarArgs)
  {
    JSONArray localJSONArray = new JSONArray();
    for (Object localObject : paramVarArgs) {
      localJSONArray.add(localObject);
    }
    return localJSONArray;
  }
}
