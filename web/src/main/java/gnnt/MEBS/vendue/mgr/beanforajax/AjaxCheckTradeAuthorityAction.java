package gnnt.MEBS.vendue.mgr.beanforajax;

import gnnt.MEBS.common.mgr.beanforajax.BaseAjax;
import gnnt.MEBS.vendue.mgr.service.firmSet.tradeAuthority.TradeAuthorityService;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

@Controller("ajaxChecktradeAuthorityAction")
@Scope("request")
public class AjaxCheckTradeAuthorityAction
  extends BaseAjax
{
  @Autowired
  @Qualifier("tradeAuthorityService")
  private TradeAuthorityService tradeAuthorityService;
  
  public TradeAuthorityService getTradeAuthorityService()
  {
    return this.tradeAuthorityService;
  }
  
  public void setTradeAuthorityService(TradeAuthorityService paramTradeAuthorityService)
  {
    this.tradeAuthorityService = paramTradeAuthorityService;
  }
  
  public String formCheckTradeUser()
  {
    HashMap localHashMap = new HashMap();
    HttpServletRequest localHttpServletRequest = getRequest();
    String str1 = localHttpServletRequest.getParameter("gnnt_userCode");
    String str2 = localHttpServletRequest.getParameter("gnnt_code");
    if ((str2 == null) || (str2.length() == 0))
    {
      localHashMap.put("res", "code");
      return "success";
    }
    if ((str1 == null) || (str1.length() == 0))
    {
      localHashMap.put("res", "userCode");
      return "success";
    }
    String str3 = this.tradeAuthorityService.checkTradeUserByIds(str1);
    if (!str3.equals("")) {
      localHashMap.put("tradeUser", str3);
    } else {
      localHashMap.put("tradeUser", "#");
    }
    String str4 = this.tradeAuthorityService.checkTradeAuth(str2, str1);
    if (!str4.equals("")) {
      localHashMap.put("tradeAuth", str4);
    } else {
      localHashMap.put("tradeAuth", "#");
    }
    if ((str3.equals("")) && (str4.equals(""))) {
      localHashMap.put("res", "yes");
    } else {
      localHashMap.put("res", "no");
    }
    this.jsonValidateReturn = createJSONArray(new Object[] { localHashMap });
    return "success";
  }
  
  public String getCommodityListJson()
  {
    HttpServletRequest localHttpServletRequest = getRequest();
    String str = localHttpServletRequest.getParameter("gnnt_authorization");
    Map[] arrayOfMap = null;
    if ((str != null) && (str.length() > 0))
    {
      int i = Integer.parseInt(str);
      List localList = this.tradeAuthorityService.getCommodityListByAuth(i);
      arrayOfMap = new Map[localList.size()];
      for (int j = 0; j < localList.size(); j++) {
        arrayOfMap[j] = ((Map)localList.get(j));
      }
    }
    this.jsonValidateReturn = createJSONArray(arrayOfMap);
    return "success";
  }
}
