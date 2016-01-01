package gnnt.MEBS.espot.front.action.trade;

import gnnt.MEBS.common.front.action.StandardAction;
import gnnt.MEBS.common.front.common.Page;
import gnnt.MEBS.common.front.common.PageRequest;
import gnnt.MEBS.common.front.common.QueryConditions;
import gnnt.MEBS.common.front.model.integrated.MFirm;
import gnnt.MEBS.common.front.model.integrated.User;
import gnnt.MEBS.common.front.service.StandardService;
import gnnt.MEBS.common.front.statictools.ActionUtil;
import gnnt.MEBS.common.front.statictools.Tools;
import gnnt.MEBS.espot.core.kernel.ITradeProcess;
import gnnt.MEBS.espot.core.vo.ResultVO;
import gnnt.MEBS.espot.front.model.trade.Arbitration;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.commons.logging.Log;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

@Controller("arbitrationAction")
@Scope("request")
public class ArbitrationAction
  extends StandardAction
{
  private static final long serialVersionUID = -5955666086648028308L;
  @Resource(name="tradeProcessService")
  private ITradeProcess tradeProcessService;
  @Resource(name="arbitrationResultMap")
  private Map<Integer, String> arbitrationResultMap;
  private Integer type;
  
  public Map<Integer, String> getArbitrationResultMap()
  {
    return this.arbitrationResultMap;
  }
  
  public void setType(Integer paramInteger)
  {
    this.type = paramInteger;
  }
  
  public String arbitrationList()
  {
    if (null == this.type) {
      this.type = Integer.valueOf(1);
    }
    this.logger.debug("仲裁管理:type::" + this.type);
    try
    {
      String str1 = this.request.getParameter("flag");
      if (str1 == null) {
        str1 = "B";
      }
      User localUser = (User)this.request.getSession().getAttribute("CurrentUser");
      PageRequest localPageRequest = ActionUtil.getPageRequest(this.request);
      QueryConditions localQueryConditions = (QueryConditions)localPageRequest.getFilters();
      localQueryConditions.addCondition("type", "=", this.type);
      String str2 = localUser.getBelongtoFirm().getFirmID();
      if (str1.endsWith("B")) {
        localQueryConditions.addCondition("applicant", "=", str2);
      } else {
        localQueryConditions.addCondition("recipient", "=", str2);
      }
      Page localPage = super.getService().getPage(localPageRequest, new Arbitration());
      this.request.setAttribute("pageInfo", localPage);
      this.request.setAttribute("flag", str1);
      this.request.setAttribute("oldParams", ActionUtil.getParametersStartingWith(this.request, "gnnt_"));
    }
    catch (Exception localException)
    {
      addReturnValue(-1, -10006L, new Object[] { "仲裁查询" });
      this.logger.error(Tools.getExceptionTrace(localException));
    }
    return "success";
  }
  
  public String addArbitration()
  {
    String str1 = "对合同%s进行%s仲裁申请";
    String str2 = this.request.getParameter("checkTradeNo");
    String str3 = this.request.getParameter("type");
    if ("1".equals(str3)) {
      str1 = String.format(str1, new Object[] { str2, "退货" });
    } else if ("2".equals(str3)) {
      str1 = String.format(str1, new Object[] { str2, "退款" });
    } else if ("3".equals(str3)) {
      str1 = String.format(str1, new Object[] { str2, "投诉" });
    } else {
      str1 = String.format(str1, new Object[] { str2, "" });
    }
    String str4 = this.request.getParameter("apply");
    this.logger.debug("申请！！！ tradeNo:" + str2 + ",type:" + str3 + ",apply:" + str4);
    User localUser = (User)this.request.getSession().getAttribute("CurrentUser");
    try
    {
      ResultVO localResultVO = this.tradeProcessService.applyArbitration(Long.valueOf(str2).longValue(), Integer.valueOf(str3).intValue(), str4, localUser.getBelongtoFirm().getFirmID());
      if (localResultVO.getResult() == 1L)
      {
        addReturnValue(1, 9910005L);
        writeOperateLog(2304, str1, 1, "");
      }
      else
      {
        addReturnValue(-1, 2300002L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
        writeOperateLog(2304, str1, 0, localResultVO.getErrorInfo());
      }
      this.logger.debug("申请！！！  end");
    }
    catch (Exception localException)
    {
      addReturnValue(-1, 2300004L, new Object[] { "仲裁申请" });
      writeOperateLog(2304, str1, 0, localException.getMessage());
      this.logger.error(Tools.getExceptionTrace(localException));
    }
    return "success";
  }
}
