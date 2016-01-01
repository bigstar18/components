package gnnt.MEBS.vendue.mgr.beanforajax;

import com.opensymphony.xwork2.ActionContext;
import gnnt.MEBS.common.mgr.beanforajax.BaseAjax;
import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.service.StandardService;
import gnnt.MEBS.vendue.mgr.model.firmSet.specialSet.SpecialFee;
import gnnt.MEBS.vendue.mgr.model.firmSet.specialSet.SpecialFeeId;
import gnnt.MEBS.vendue.mgr.model.firmSet.specialSet.SpecialMargin;
import gnnt.MEBS.vendue.mgr.model.firmSet.specialSet.SpecialMarginId;
import gnnt.MEBS.vendue.mgr.model.firmSet.tradeUser.TradeUserModel;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import net.sf.json.JSONArray;
import org.apache.commons.logging.Log;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

@Controller("ajaxCheckSpecialSet")
@Scope("request")
public class AjaxCheckSpecialSet
  extends BaseAjax
{
  public String mouseCheckUserByUserCode()
  {
    this.logger.debug("enter ajaxChek_mouseCheckUserByUserCode");
    ActionContext localActionContext = ActionContext.getContext();
    HttpServletRequest localHttpServletRequest = (HttpServletRequest)localActionContext.get("com.opensymphony.xwork2.dispatcher.HttpServletRequest");
    String str = localHttpServletRequest.getParameter("userCode");
    TradeUserModel localTradeUserModel = new TradeUserModel();
    localTradeUserModel.setUserCode(str);
    boolean bool = existModelId(str, localTradeUserModel);
    if (bool) {
      this.jsonValidateReturn = createJSONArray(new Object[] { "true" });
    } else {
      this.jsonValidateReturn = createJSONArray(new Object[] { "false" });
    }
    return "success";
  }
  
  public String formCheckSpecialFeeById()
  {
    this.logger.debug("enter ajaxChek_SpecialFeelById");
    ActionContext localActionContext = ActionContext.getContext();
    HttpServletRequest localHttpServletRequest = (HttpServletRequest)localActionContext.get("com.opensymphony.xwork2.dispatcher.HttpServletRequest");
    SpecialFeeId localSpecialFeeId = new SpecialFeeId();
    try
    {
      localSpecialFeeId.setBreedId(new Integer(localHttpServletRequest.getParameter("entity.id.breedId")));
      localSpecialFeeId.setBs_flag(new Byte(localHttpServletRequest.getParameter("entity.id.bs_flag")));
      localSpecialFeeId.setUserCode(localHttpServletRequest.getParameter("entity.id.userCode"));
      SpecialFee localSpecialFee = new SpecialFee();
      localSpecialFee.setId(localSpecialFeeId);
      boolean bool = existModelId(localSpecialFeeId, localSpecialFee);
      if (!bool) {
        this.jsonValidateReturn = getJSONArray(new Object[] { "true" });
      } else {
        this.jsonValidateReturn = getJSONArrayList(new JSONArray[] { createJSONArray(new Object[] { "userCode", Boolean.valueOf(false), "已经存在记录！" }) });
      }
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
    }
    return "success";
  }
  
  public String formCheckSpecialMarginById()
  {
    this.logger.debug("enter ajaxChek_SpecialFeelById");
    ActionContext localActionContext = ActionContext.getContext();
    HttpServletRequest localHttpServletRequest = (HttpServletRequest)localActionContext.get("com.opensymphony.xwork2.dispatcher.HttpServletRequest");
    SpecialMarginId localSpecialMarginId = new SpecialMarginId();
    try
    {
      localSpecialMarginId.setBreedId(new Integer(localHttpServletRequest.getParameter("entity.id.breedId")));
      localSpecialMarginId.setBs_flag(new Byte(localHttpServletRequest.getParameter("entity.id.bs_flag")));
      localSpecialMarginId.setUserCode(localHttpServletRequest.getParameter("entity.id.userCode"));
      SpecialMargin localSpecialMargin = new SpecialMargin();
      localSpecialMargin.setId(localSpecialMarginId);
      boolean bool = existModelId(localSpecialMarginId, localSpecialMargin);
      if (!bool) {
        this.jsonValidateReturn = getJSONArray(new Object[] { "true" });
      } else {
        this.jsonValidateReturn = getJSONArrayList(new JSONArray[] { createJSONArray(new Object[] { "userCode", Boolean.valueOf(false), "已经存在记录！" }) });
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
  
  private boolean existModelId(Object paramObject, StandardModel paramStandardModel)
  {
    boolean bool = false;
    List localList = getService().getListByBulk(paramStandardModel, new Object[] { paramObject });
    if ((localList != null) && (localList.size() > 0)) {
      bool = true;
    }
    return bool;
  }
}
