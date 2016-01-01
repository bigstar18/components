package gnnt.MEBS.common.front.beanforajax;

import gnnt.MEBS.common.front.common.Page;
import gnnt.MEBS.common.front.common.PageRequest;
import gnnt.MEBS.common.front.common.QueryConditions;
import gnnt.MEBS.common.front.model.StandardModel;
import gnnt.MEBS.common.front.model.integrated.MFirmApply;
import gnnt.MEBS.common.front.model.integrated.User;
import gnnt.MEBS.common.front.service.StandardService;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

@Controller("com_ajaxCheck")
@Scope("request")
public class AjaxCheck
  extends BaseAjax
{
  private boolean getTraderUserID(String userID)
  {
    QueryConditions qc = new QueryConditions();
    qc.addCondition("userID", "=", userID);
    PageRequest<QueryConditions> pageRequest = new PageRequest(1, 2, qc, "");
    
    Page<StandardModel> page = getService().getPage(pageRequest, new User());
    if ((page != null) && (page.getResult() != null) && (page.getResult().size() > 0)) {
      return true;
    }
    return false;
  }
  
  private boolean getFirmApplyUserID(String userID)
  {
    QueryConditions qc = new QueryConditions();
    qc.addCondition("userID", "=", userID);
    qc.addCondition("status", "<>", Integer.valueOf(2));
    PageRequest<QueryConditions> pageRequest = new PageRequest(1, 2, qc, "");
    
    Page<StandardModel> page = getService().getPage(pageRequest, new MFirmApply());
    if ((page != null) && (page.getResult() != null) && (page.getResult().size() > 0)) {
      return true;
    }
    return false;
  }
  
  public String checkTraderUserID()
  {
    HttpServletRequest request = getRequest();
    
    String fieldId = request.getParameter("fieldId");
    String fieldValue = request.getParameter("fieldValue");
    if (getTraderUserID(fieldValue)) {
      this.jsonValidateReturn = createJSONArray(new Object[] { fieldId, Boolean.valueOf(false), "用户名已被占用" });
    } else if (getFirmApplyUserID(fieldValue)) {
      this.jsonValidateReturn = createJSONArray(new Object[] { fieldId, Boolean.valueOf(false), "用户名已经有人申请" });
    } else {
      this.jsonValidateReturn = createJSONArray(new Object[] { fieldId, Boolean.valueOf(true), "用户名可以使用" });
    }
    return "success";
  }
  
  public String checkFirmApplyForm()
  {
    HttpServletRequest request = getRequest();
    
    String userID = request.getParameter("entity.userID");
    BaseAjax.AjaxJSONArrayResponse response = new BaseAjax.AjaxJSONArrayResponse(this, new Object[0]);
    if (getTraderUserID(userID)) {
      response.addJSON(new Object[] { createJSONArray(new Object[] { "userID", Boolean.valueOf(false), "用户名已被其他交易员使用" }) });
    } else if (getFirmApplyUserID(userID)) {
      response.addJSON(new Object[] { createJSONArray(new Object[] { "userID", Boolean.valueOf(false), "用户名已经有人申请" }) });
    } else {
      response.addJSON(new Object[] { createJSONArray(new Object[] { "userID", Boolean.valueOf(true), "用户名可以使用" }) });
    }
    this.jsonValidateReturn = response.toJSONArray();
    
    return "success";
  }
}
