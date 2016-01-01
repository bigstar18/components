package gnnt.MEBS.espot.front.action.trade;

import gnnt.MEBS.common.front.action.StandardAction;
import gnnt.MEBS.common.front.common.Page;
import gnnt.MEBS.common.front.common.PageRequest;
import gnnt.MEBS.common.front.common.QueryConditions;
import gnnt.MEBS.common.front.model.integrated.MFirm;
import gnnt.MEBS.common.front.model.integrated.User;
import gnnt.MEBS.common.front.service.QueryService;
import gnnt.MEBS.espot.front.dao.jdbc.UserDAO;
import gnnt.MEBS.espot.front.model.trade.Order;
import gnnt.MEBS.espot.front.model.trade.SubOrder;
import gnnt.MEBS.espot.front.model.trade.Trade;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.commons.logging.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

@Controller("homeAction")
@Scope("request")
public class HomeAction
  extends StandardAction
{
  private static final long serialVersionUID = -3624125532664601049L;
  @Autowired
  @Qualifier("userDAO")
  private UserDAO userDAO;
  @Resource(name="bsFlagMap")
  Map<String, String> bsFlagMap;
  @Resource(name="orderStatus")
  Map<String, String> orderStatus;
  @Resource(name="tradeStatus")
  Map<String, String> tradeStatus;
  @Resource(name="suborderStatus")
  Map<String, String> suborderStatus;
  
  public Map<String, String> getBsFlagMap()
  {
    return this.bsFlagMap;
  }
  
  public Map<String, String> getOrderStatus()
  {
    return this.orderStatus;
  }
  
  public Map<String, String> getTradeStatus()
  {
    return this.tradeStatus;
  }
  
  public Map<String, String> getSuborderStatus()
  {
    return this.suborderStatus;
  }
  
  public String homepage()
  {
    this.logger.debug("goto home page");
    User localUser = (User)this.request.getSession().getAttribute("CurrentUser");
    Map localMap = this.userDAO.getTradeSize(localUser.getBelongtoFirm().getFirmID());
    this.request.setAttribute("countMap", localMap);
    PageRequest localPageRequest1 = new PageRequest();
    localPageRequest1.setPageSize(5);
    localPageRequest1.setPageNumber(1);
    QueryConditions localQueryConditions = new QueryConditions();
    localQueryConditions.addCondition(" ", " ", "(status=0 or status=1)");
    localQueryConditions.addCondition("firmid", "=", localUser.getBelongtoFirm().getFirmID());
    localPageRequest1.setFilters(localQueryConditions);
    if ("".equals(localPageRequest1.getSortColumns())) {
      localPageRequest1.setSortColumns(" order by orderID desc");
    }
    Page localPage1 = getQueryService().getPage(localPageRequest1, new Order());
    this.request.setAttribute("orderList", localPage1.getResult());
    PageRequest localPageRequest2 = new PageRequest();
    localPageRequest2.setPageSize(5);
    localPageRequest2.setPageNumber(1);
    localQueryConditions = new QueryConditions();
    localQueryConditions = new QueryConditions();
    localQueryConditions.addCondition(" ", " ", " (bfirmID='" + localUser.getBelongtoFirm().getFirmID() + "' or sfirmID='" + localUser.getBelongtoFirm().getFirmID() + "')");
    localQueryConditions.addCondition(" ", " ", " (status=0 or status=3 or status=5 or status=6 or status=7 or status=8)");
    localPageRequest2.setFilters(localQueryConditions);
    if ("".equals(localPageRequest2.getSortColumns())) {
      localPageRequest2.setSortColumns(" order by time desc");
    }
    Page localPage2 = getQueryService().getPage(localPageRequest2, new Trade());
    this.request.setAttribute("tradeList", localPage2.getResult());
    PageRequest localPageRequest3 = new PageRequest();
    localPageRequest3.setPageSize(5);
    localPageRequest3.setPageNumber(1);
    localQueryConditions = new QueryConditions();
    localQueryConditions.addCondition("status", "=", Integer.valueOf(0));
    localQueryConditions.addCondition("belongtoFirm.firmID", "=", localUser.getBelongtoFirm().getFirmID());
    localPageRequest3.setFilters(localQueryConditions);
    if ("".equals(localPageRequest3.getSortColumns())) {
      localPageRequest3.setSortColumns(" order by createTime desc");
    }
    Page localPage3 = getQueryService().getPage(localPageRequest3, new SubOrder());
    this.request.setAttribute("suborderList", localPage3.getResult());
    return "success";
  }
}
