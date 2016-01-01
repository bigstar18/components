package gnnt.MEBS.vendue.front.action.vendue;

import gnnt.MEBS.common.front.action.StandardAction;
import gnnt.MEBS.common.front.common.Page;
import gnnt.MEBS.common.front.common.PageRequest;
import gnnt.MEBS.common.front.common.QueryConditions;
import gnnt.MEBS.common.front.model.integrated.MFirm;
import gnnt.MEBS.common.front.model.integrated.User;
import gnnt.MEBS.common.front.service.StandardService;
import gnnt.MEBS.common.front.statictools.ActionUtil;
import gnnt.MEBS.common.front.statictools.Tools;
import gnnt.MEBS.vendue.front.model.Administrator;
import gnnt.MEBS.vendue.front.model.CustomerModel;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.commons.logging.Log;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

@Controller("customerAction")
@Scope("request")
public class CustomerAction
  extends StandardAction
{
  private static final long serialVersionUID = 5124568190167465621L;
  @Resource(name="customer_cardTypeMap")
  private Map<String, String> customer_cardTypeMap;
  @Resource(name="customer_typeMap")
  private Map<Integer, String> customer_typeMap;
  @Resource(name="customer_bankCodeMap")
  private Map<String, String> customer_bankCodeMap;
  @Resource(name="customer_statusMap")
  private Map<String, String> customer_statusMap;
  
  public Map<String, String> getCustomer_cardTypeMap()
  {
    return this.customer_cardTypeMap;
  }
  
  public void setCustomer_cardTypeMap(Map<String, String> paramMap)
  {
    this.customer_cardTypeMap = paramMap;
  }
  
  public Map<Integer, String> getCustomer_typeMap()
  {
    return this.customer_typeMap;
  }
  
  public void setCustomer_typeMap(Map<Integer, String> paramMap)
  {
    this.customer_typeMap = paramMap;
  }
  
  public Map<String, String> getCustomer_bankCodeMap()
  {
    return this.customer_bankCodeMap;
  }
  
  public void setCustomer_bankCodeMap(Map<String, String> paramMap)
  {
    this.customer_bankCodeMap = paramMap;
  }
  
  public Map<String, String> getCustomer_statusMap()
  {
    return this.customer_statusMap;
  }
  
  public void setCustomer_statusMap(Map<String, String> paramMap)
  {
    this.customer_statusMap = paramMap;
  }
  
  public String getCustomerList()
  {
    this.logger.debug("------------getCustomerList 获取客户列表--------------");
    User localUser = (User)this.request.getSession().getAttribute("CurrentUser");
    try
    {
      PageRequest localPageRequest = ActionUtil.getPageRequest(this.request);
      QueryConditions localQueryConditions = (QueryConditions)localPageRequest.getFilters();
      localQueryConditions.addCondition("firm.firmID", "=", localUser.getBelongtoFirm().getFirmID());
      Page localPage = getService().getPage(localPageRequest, this.entity);
      this.request.setAttribute("pageInfo", localPage);
      this.request.setAttribute("oldParams", ActionUtil.getParametersStartingWith(this.request, "gnnt_"));
    }
    catch (Exception localException)
    {
      this.logger.error(Tools.getExceptionTrace(localException));
    }
    return "success";
  }
  
  public String addCustomerForward()
  {
    this.logger.debug("------------addCustomerForward 添加客户信息跳转--------------");
    QueryConditions localQueryConditions = new QueryConditions();
    localQueryConditions.addCondition("isForbid", "=", "N");
    PageRequest localPageRequest = new PageRequest(1, 10, localQueryConditions, "");
    Page localPage = getService().getPage(localPageRequest, new Administrator());
    if (localPage != null) {
      this.request.setAttribute("administrator", localPage.getResult());
    }
    return "success";
  }
  
  public String addCustomer()
  {
    this.logger.debug("------------addCustomer 添加客户信息--------------");
    User localUser = (User)this.request.getSession().getAttribute("CurrentUser");
    CustomerModel localCustomerModel = (CustomerModel)this.entity;
    localCustomerModel.setFirm(localUser.getBelongtoFirm());
    localCustomerModel.setStatus("N");
    getService().add(localCustomerModel);
    addReturnValue(1, 9910002L);
    return "success";
  }
  
  public String updateCustomerForward()
  {
    this.logger.debug("------------updateCustomerForward 修改客户信息跳转--------------");
    QueryConditions localQueryConditions = new QueryConditions();
    localQueryConditions.addCondition("isForbid", "=", "N");
    PageRequest localPageRequest = new PageRequest(1, 10, localQueryConditions, "");
    Page localPage = getService().getPage(localPageRequest, new Administrator());
    if (localPage != null) {
      this.request.setAttribute("administrator", localPage.getResult());
    }
    try
    {
      viewById();
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
    }
    return "success";
  }
}
