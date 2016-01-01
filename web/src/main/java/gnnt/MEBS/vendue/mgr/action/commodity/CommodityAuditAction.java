package gnnt.MEBS.vendue.mgr.action.commodity;

import gnnt.MEBS.common.mgr.action.EcsideAction;
import gnnt.MEBS.common.mgr.common.Page;
import gnnt.MEBS.common.mgr.common.PageRequest;
import gnnt.MEBS.common.mgr.common.QueryConditions;
import gnnt.MEBS.common.mgr.model.User;
import gnnt.MEBS.common.mgr.service.StandardService;
import gnnt.MEBS.vendue.mgr.model.commodity.commodities.VCommodity;
import gnnt.MEBS.vendue.mgr.service.system.syspartition.SysPartitionService;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.commons.logging.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.util.WebUtils;

@Controller("commodityAuditAction")
@Scope("request")
public class CommodityAuditAction
  extends EcsideAction
{
  private static final long serialVersionUID = -6773389997252044774L;
  @Autowired
  @Qualifier("sysPartitionService")
  private SysPartitionService sysPartitionService;
  @Resource(name="commodity_statusMap")
  private Map<Byte, String> commodity_statusMap;
  @Resource(name="commodity_marginAlgrMap")
  private Map<Byte, String> commodity_marginAlgrMap;
  @Resource(name="commodity_feeAlgrMap")
  private Map<Byte, String> commodity_feeAlgrMap;
  @Resource(name="commodity_flowAmountAlgrMap")
  private Map<Byte, String> commodity_flowAmountAlgrMap;
  @Resource(name="commodity_isorderMap")
  private Map<Byte, String> commodity_isorderMap;
  @Resource(name="commodity_authorizationMap")
  private Map<Byte, String> commodity_authorizationMap;
  @Resource(name="commodity_auditstatusMap")
  private Map<Byte, String> commodity_auditstatusMap;
  @Resource(name="commodity_bsflagMap")
  private Map<Byte, String> commodity_bsflagMap;
  private Map partitions;
  private Map breeds;
  private String partitionid;
  private String trademode;
  
  public Map<Byte, String> getCommodity_statusMap()
  {
    return this.commodity_statusMap;
  }
  
  public Map<Byte, String> getCommodity_marginAlgrMap()
  {
    return this.commodity_marginAlgrMap;
  }
  
  public Map<Byte, String> getCommodity_feeAlgrMap()
  {
    return this.commodity_feeAlgrMap;
  }
  
  public Map<Byte, String> getCommodity_flowAmountAlgrMap()
  {
    return this.commodity_flowAmountAlgrMap;
  }
  
  public Map<Byte, String> getCommodity_isorderMap()
  {
    return this.commodity_isorderMap;
  }
  
  public Map<Byte, String> getCommodity_authorizationMap()
  {
    return this.commodity_authorizationMap;
  }
  
  public Map<Byte, String> getCommodity_auditstatusMap()
  {
    return this.commodity_auditstatusMap;
  }
  
  public Map<Byte, String> getCommodity_bsflagMap()
  {
    return this.commodity_bsflagMap;
  }
  
  public Map getPartitions()
  {
    return this.sysPartitionService.getPartitionsMap();
  }
  
  public Map getBreeds()
  {
    String str = "select b.breedid id, b.breedname name from m_breed b where b.belongmodule like '%21%' and b.status = '1'";
    List localList = getService().getListBySql(str);
    HashMap localHashMap = new HashMap();
    Iterator localIterator = localList.iterator();
    while (localIterator.hasNext())
    {
      Map localMap = (Map)localIterator.next();
      localHashMap.put(Long.valueOf(Long.parseLong(localMap.get("ID").toString())), localMap.get("NAME").toString());
    }
    return localHashMap;
  }
  
  public String getPartitionid()
  {
    return this.partitionid;
  }
  
  public void setPartitionid(String paramString)
  {
    this.partitionid = paramString;
  }
  
  public String getTrademode()
  {
    return this.trademode;
  }
  
  public void setTrademode(String paramString)
  {
    this.trademode = paramString;
  }
  
  public String list()
  {
    this.logger.debug("========== list 商品审核 ==========");
    try
    {
      PageRequest localPageRequest = getPageRequest(this.request);
      QueryConditions localQueryConditions = (QueryConditions)localPageRequest.getFilters();
      localQueryConditions.addCondition("tradepartition", "=", Short.valueOf(Short.parseShort(this.partitionid)));
      String str1 = this.request.getParameter("gnnt_code[=]");
      String str2 = this.request.getParameter("gnnt_authorization[=]");
      String str3 = this.request.getParameter("gnnt_auditstatus[in]");
      if ((str3 == null) || (str3.equals("")))
      {
        localQueryConditions.removeCondition("auditstatus");
        localQueryConditions.addCondition("auditstatus", "in", "(0)");
      }
      if ((str1 != null) && (!str1.equals("")))
      {
        localQueryConditions.removeCondition("code");
        localQueryConditions.addCondition("code", "=", Integer.valueOf(Integer.parseInt(str1)));
      }
      if ((str2 != null) && (!str2.equals("")))
      {
        localQueryConditions.removeCondition("authorization");
        localQueryConditions.addCondition("authorization", "=", Byte.valueOf(Byte.parseByte(str2)));
      }
      Page localPage = getService().getPage(localPageRequest, new VCommodity());
      this.request.setAttribute("pageInfo", localPage);
      Map localMap = WebUtils.getParametersStartingWith(this.request, "gnnt_");
      this.request.setAttribute("oldParams", localMap);
    }
    catch (Exception localException)
    {
      this.logger.debug("商品列表查询失败");
      addReturnValue(-1, 213006L);
      localException.printStackTrace();
    }
    return "success";
  }
  
  public String viewById()
  {
    this.logger.debug("========== viewById 商品审核 ==========");
    VCommodity localVCommodity = (VCommodity)this.entity;
    localVCommodity = (VCommodity)getService().get(localVCommodity);
    this.request.setAttribute("entity", localVCommodity);
    String str = "select t.*,rownum from v_commext t where t.code = '" + localVCommodity.getCode() + "'";
    List localList = getService().getListBySql(str);
    this.request.setAttribute("commext", localList);
    return "success";
  }
  
  public String update()
  {
    this.logger.debug("========== update 商品审核 ==========");
    VCommodity localVCommodity = (VCommodity)this.entity;
    User localUser = (User)this.request.getSession().getAttribute("CurrentUser");
    localVCommodity.setAudituser(localUser.getUserId());
    localVCommodity.setAudittime(new Date());
    try
    {
      getService().update(localVCommodity);
      addReturnValue(1, 211003L);
      writeOperateLog(2105, "商品审核状态修改成功", 1, "");
    }
    catch (Exception localException)
    {
      this.logger.error("审核出现异常");
      addReturnValue(-1, 213010L);
      writeOperateLog(2105, "商品审核状态修改失败", 0, "");
      localException.printStackTrace();
    }
    return "success";
  }
  
  public String deleteRemove()
  {
    this.logger.debug("========== deleteRemove 删除商品 ==========");
    try
    {
      String[] arrayOfString = this.request.getParameterValues("codes");
      this.sysPartitionService.deleteList(arrayOfString);
      addReturnValue(1, 211002L);
      this.logger.debug("删除成功");
      writeOperateLog(2105, "商品删除成功", 1, "");
    }
    catch (Exception localException)
    {
      addReturnValue(-1, 213005L);
      this.logger.debug("删除失败");
      writeOperateLog(2105, "商品删除失败", 0, "");
      localException.printStackTrace();
    }
    return "success";
  }
}
