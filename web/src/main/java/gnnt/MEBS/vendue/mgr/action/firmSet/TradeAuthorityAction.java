package gnnt.MEBS.vendue.mgr.action.firmSet;

import gnnt.MEBS.common.mgr.action.EcsideAction;
import gnnt.MEBS.common.mgr.common.Page;
import gnnt.MEBS.common.mgr.common.PageRequest;
import gnnt.MEBS.common.mgr.service.StandardService;
import gnnt.MEBS.vendue.mgr.service.firmSet.tradeAuthority.TradeAuthorityService;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

@Controller("tradeAuthorityAction")
@Scope("request")
public class TradeAuthorityAction
  extends EcsideAction
{
  private static final long serialVersionUID = 1L;
  @Resource(name="tradeAuthority_Authorization")
  private Map<Byte, String> tradeAuthority_Authorization;
  @Autowired
  @Qualifier("tradeAuthorityService")
  private TradeAuthorityService tradeAuthorityService;
  
  public Map<Byte, String> getTradeAuthority_Authorization()
  {
    return this.tradeAuthority_Authorization;
  }
  
  public void setTradeAuthority_Authorization(Map<Byte, String> paramMap)
  {
    this.tradeAuthority_Authorization = paramMap;
  }
  
  public TradeAuthorityService getTradeAuthorityService()
  {
    return this.tradeAuthorityService;
  }
  
  public void setTradeAuthorityService(TradeAuthorityService paramTradeAuthorityService)
  {
    this.tradeAuthorityService = paramTradeAuthorityService;
  }
  
  public String getTradeAuthorityList()
    throws Exception
  {
    PageRequest localPageRequest = super.getPageRequest(this.request);
    String str1 = trim(this.request.getParameter("gnnt_vt.code"));
    String str2 = trim(this.request.getParameter("gnnt_commodityid"));
    String str3 = trim(this.request.getParameter("gnnt_usercode"));
    String str4 = trim(this.request.getParameter("gnnt_authorization"));
    String str5 = "select vt.code,vt.usercode,vc.commodityid,vc.authorization from v_TradeAuthority vt,  v_commodity vc where vc.code = vt.code";
    if ((!"".equals(str1)) && (str1 != null)) {
      str5 = str5 + " AND vt.code like '%" + str1 + "%'";
    }
    if ((!"".equals(str2)) && (str2 != null)) {
      str5 = str5 + " AND vc.commodityid like '%" + str2 + "%'";
    }
    if ((!"".equals(str3)) && (str3 != null)) {
      str5 = str5 + " AND vt.usercode like '%" + str3 + "%'";
    }
    if ((!"".equals(str4)) && (str4 != null)) {
      str5 = str5 + " AND vc.authorization = " + str4;
    }
    List localList = getService().getListBySql(str5);
    Page localPage = new Page(localPageRequest.getPageNumber(), localPageRequest.getPageSize(), localList.size(), localList);
    this.request.setAttribute("pageInfo", localPage);
    this.request.setAttribute("oldParams", getParametersStartingWith(this.request, "gnnt_"));
    return "success";
  }
  
  public String addTradeAuthorityforward()
  {
    return "success";
  }
  
  public String addTradeAuthority()
  {
    int i = -1;
    String str1 = trim(this.request.getParameter("gnnt_authorization"));
    if (str1 != null) {
      i = Integer.parseInt(str1);
    }
    String str2 = trim(this.request.getParameter("gnnt_code"));
    String str3 = trim(this.request.getParameter("gnnt_userCode"));
    String[] arrayOfString = str3.split(",");
    try
    {
      this.tradeAuthorityService.addTradeAuthority(str2, i, arrayOfString);
      writeOperateLog(2104, "交易权限添加成功", 1, "");
      addReturnValue(1, 119901L);
    }
    catch (Exception localException)
    {
      writeOperateLog(2104, "交易权限添加失败", 0, "");
      localException.printStackTrace();
    }
    return "success";
  }
  
  public String delateTradeAuthority()
  {
    String[] arrayOfString = this.request.getParameterValues("ids");
    if ((arrayOfString != null) && (arrayOfString.length != 0)) {
      try
      {
        this.tradeAuthorityService.delateTradeAuthority(arrayOfString);
        writeOperateLog(2104, "交易权限删除成功", 1, "");
      }
      catch (Exception localException)
      {
        writeOperateLog(2104, "交易权限删除失败", 0, "");
        localException.printStackTrace();
      }
    }
    return "success";
  }
  
  private String trim(String paramString)
  {
    if (paramString == null) {
      return null;
    }
    return paramString.replaceAll("\\s", "");
  }
}
