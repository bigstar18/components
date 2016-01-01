package gnnt.MEBS.espot.front.action.trade;

import gnnt.MEBS.common.front.action.StandardAction;
import gnnt.MEBS.common.front.common.Page;
import gnnt.MEBS.common.front.common.PageRequest;
import gnnt.MEBS.common.front.common.QueryConditions;
import gnnt.MEBS.common.front.model.StandardModel;
import gnnt.MEBS.common.front.model.integrated.MFirm;
import gnnt.MEBS.common.front.model.integrated.User;
import gnnt.MEBS.common.front.service.StandardService;
import gnnt.MEBS.common.front.statictools.ActionUtil;
import gnnt.MEBS.espot.front.model.trade.GoodsMoneyApply;
import gnnt.MEBS.espot.front.model.trade.GoodsMoneyApplyHis;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

@Controller("goodsMoneyApplyAction")
@Scope("request")
public class GoodsMoneyApplyAction
  extends StandardAction
{
  private static final long serialVersionUID = 4024558621252699662L;
  @Resource(name="goodsMoneyApplyMap")
  protected Map<Integer, String> goodsMoneyApplyMap;
  @Resource(name="goodsMoneyTypeMap")
  protected Map<Integer, String> goodsMoneyTypeMap;
  
  public Map<Integer, String> getGoodsMoneyApplyMap()
  {
    return this.goodsMoneyApplyMap;
  }
  
  public Map<Integer, String> getGoodsMoneyTypeMap()
  {
    return this.goodsMoneyTypeMap;
  }
  
  public String goodsMoneyApplyList()
    throws Exception
  {
    User localUser = (User)this.request.getSession().getAttribute("CurrentUser");
    PageRequest localPageRequest = ActionUtil.getPageRequest(this.request);
    QueryConditions localQueryConditions = (QueryConditions)localPageRequest.getFilters();
    String str = this.request.getParameter("loss");
    if ("S".equals(str)) {
      localQueryConditions.addCondition("primary.tradeContract.sfirmID", "=", localUser.getBelongtoFirm().getFirmID());
    } else if ("R".equals(str)) {
      localQueryConditions.addCondition("primary.tradeContract.bfirmID", "=", localUser.getBelongtoFirm().getFirmID());
    } else {
      localQueryConditions.addCondition(" ", " ", " (primary.tradeContract.sfirmID='" + localUser.getBelongtoFirm().getFirmID() + "' or primary.tradeContract.bfirmID='" + localUser.getBelongtoFirm().getFirmID() + "')");
    }
    Object localObject = null;
    if ("H".equalsIgnoreCase(this.request.getParameter("isHistory"))) {
      localObject = new GoodsMoneyApplyHis();
    } else {
      localObject = new GoodsMoneyApply();
    }
    Page localPage = getService().getPage(localPageRequest, (StandardModel)localObject);
    this.request.setAttribute("isHistory", this.request.getParameter("isHistory"));
    this.request.setAttribute("pageInfo", localPage);
    this.request.setAttribute("loss", str);
    this.request.setAttribute("oldParams", ActionUtil.getParametersStartingWith(this.request, "gnnt_"));
    return "success";
  }
}
