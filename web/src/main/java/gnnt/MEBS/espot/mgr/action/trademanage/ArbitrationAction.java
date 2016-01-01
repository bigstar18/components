package gnnt.MEBS.espot.mgr.action.trademanage;

import gnnt.MEBS.common.mgr.action.EcsideAction;
import gnnt.MEBS.common.mgr.common.PageRequest;
import gnnt.MEBS.common.mgr.common.QueryConditions;
import gnnt.MEBS.common.mgr.model.User;
import gnnt.MEBS.common.mgr.service.StandardService;
import gnnt.MEBS.espot.mgr.model.trademanage.Arbitration;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.commons.logging.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

@Component("arbitrationAction")
@Scope("request")
public class ArbitrationAction
  extends EcsideAction
{
  private static final long serialVersionUID = 6363528969642839435L;
  @Autowired
  @Resource(name="arbitrationTypeMap")
  protected Map<Integer, String> arbitrationTypeMap;
  @Autowired
  @Resource(name="arbitrationResultMap")
  protected Map<Integer, String> arbitrationResultMap;
  
  public Map<Integer, String> getArbitrationTypeMap()
  {
    return this.arbitrationTypeMap;
  }
  
  public Map<Integer, String> getArbitrationResultMap()
  {
    return this.arbitrationResultMap;
  }
  
  public String refundArbitrationList()
    throws Exception
  {
    getPage(2);
    this.logger.debug("list returnedGoodsList");
    return "success";
  }
  
  public String returnArbitrationList()
    throws Exception
  {
    getPage(1);
    this.logger.debug("list refundList");
    return "success";
  }
  
  public String complainArbitrationList()
    throws Exception
  {
    getPage(3);
    this.logger.debug("list complaintList");
    return "success";
  }
  
  public void getPage(int paramInt)
    throws Exception
  {
    PageRequest localPageRequest = super.getPageRequest(this.request);
    QueryConditions localQueryConditions = super.getQueryConditionsFromRequest(this.request);
    localQueryConditions.addCondition("primary.type", "=", Integer.valueOf(paramInt));
    localPageRequest.setFilters(localQueryConditions);
    localPageRequest.getFilters();
    listByLimit(localPageRequest);
  }
  
  public String disposeArbitration()
    throws Exception
  {
    Arbitration localArbitration = (Arbitration)this.entity;
    User localUser = (User)this.request.getSession().getAttribute("CurrentUser");
    localArbitration.setProcessUser(localUser.getUserId());
    localArbitration.setProcessTime(getService().getSysDate());
    getService().update(localArbitration);
    addReturnValue(1, 230000L);
    String str = "把仲裁ID为:" + localArbitration.getArbitrationId() + "处理为(" + (String)this.arbitrationTypeMap.get(localArbitration.getResult()) + ")";
    writeOperateLog(6401, str, 1, "");
    return "success";
  }
}
