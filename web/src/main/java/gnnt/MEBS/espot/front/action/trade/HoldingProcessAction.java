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
import gnnt.MEBS.common.front.statictools.ApplicationContextInit;
import gnnt.MEBS.common.front.statictools.Tools;
import gnnt.MEBS.espot.core.kernel.ITradeProcess;
import gnnt.MEBS.espot.core.vo.ResultVO;
import gnnt.MEBS.espot.front.model.trade.Holding;
import gnnt.MEBS.espot.front.model.trade.HoldingBase;
import gnnt.MEBS.espot.front.model.trade.HoldingHis;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.commons.logging.Log;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

@Controller("holdingProcessAction")
@Scope("request")
public class HoldingProcessAction
  extends StandardAction
{
  private static final long serialVersionUID = 1159553748437211487L;
  @Resource(name="tradeProcessService")
  private ITradeProcess tradeProcessService;
  @Resource(name="holdingStatus")
  private Map<Integer, String> holdingStatus;
  @Resource(name="bsFlagMap")
  private Map<String, String> bsFlagMap;
  
  public Map<Integer, String> getHoldingStatus()
  {
    return this.holdingStatus;
  }
  
  public Map<String, String> getBsFlagMap()
  {
    return this.bsFlagMap;
  }
  
  public String holdingList()
  {
    this.logger.debug("========  我的成交列表");
    User localUser = (User)this.request.getSession().getAttribute("CurrentUser");
    try
    {
      PageRequest localPageRequest = ActionUtil.getPageRequest(this.request);
      QueryConditions localQueryConditions = (QueryConditions)localPageRequest.getFilters();
      localQueryConditions.addCondition("firmID", "=", localUser.getBelongtoFirm().getFirmID());
      String str = this.request.getParameter("BSFlag");
      if ((null != str) && (str.length() == 1))
      {
        localQueryConditions.addCondition("bsFlag", "=", str);
        this.logger.debug("BSFlag:: " + str);
      }
      Object localObject = null;
      if ("H".equalsIgnoreCase(this.request.getParameter("isHistory"))) {
        localObject = new HoldingHis();
      } else {
        localObject = new Holding();
      }
      Page localPage = super.getService().getPage(localPageRequest, (StandardModel)localObject);
      this.request.setAttribute("isHistory", this.request.getParameter("isHistory"));
      this.request.setAttribute("pageInfo", localPage);
      this.request.setAttribute("oldParams", ActionUtil.getParametersStartingWith(this.request, "gnnt_"));
    }
    catch (Exception localException)
    {
      addReturnValue(-1, -10006L, new Object[] { "成交列表查询" });
      this.logger.error(Tools.getExceptionTrace(localException));
    }
    return "success";
  }
  
  public String holdingDetails()
  {
    this.logger.debug("成交详情查询");
    long l = Tools.strToLong(this.request.getParameter("holdingID"), -1000L);
    this.logger.debug("request.getParameter('holdingID')" + this.request.getParameter("holdingID"));
    this.logger.debug("holdingID :  " + l);
    if (l > 0L)
    {
      String str = this.request.getParameter("isHistory");
      Object localObject = null;
      if ((str != null) && (!str.equals(""))) {
        localObject = new HoldingHis();
      } else {
        localObject = new Holding();
      }
      ((HoldingBase)localObject).setHoldingID(Long.valueOf(l));
      localObject = (HoldingBase)getService().get((StandardModel)localObject);
      this.request.setAttribute("entity", localObject);
      this.request.setAttribute("isHistory", str);
      this.logger.debug("----------" + ((HoldingBase)localObject).getHoldingID());
    }
    return "success";
  }
  
  public String repealHolding()
  {
    String str1 = "撤销持仓号为%s的成交";
    User localUser = (User)this.request.getSession().getAttribute("CurrentUser");
    String str2 = this.request.getParameter("holdingID");
    str1 = String.format(str1, new Object[] { str2 });
    if ((str2 != null) && (str2.length() > 0))
    {
      try
      {
        this.logger.debug("调  撤销成交！！");
        ResultVO localResultVO = this.tradeProcessService.withdrawTrade(Long.valueOf(str2).longValue(), localUser.getName());
        if (localResultVO.getResult() == 1L)
        {
          addReturnValue(1, 9910001L);
          writeOperateLog(2309, str1, 1, "");
        }
        else
        {
          addReturnValue(-1, 2300002L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
          writeOperateLog(2309, str1, 0, localResultVO.getErrorInfo());
        }
        return "success";
      }
      catch (NumberFormatException localNumberFormatException)
      {
        addReturnValue(-1, 2300002L, new Object[] { "持仓号错误！！" });
        writeOperateLog(2309, str1, 0, localNumberFormatException.getMessage());
        this.logger.error(Tools.getExceptionTrace(localNumberFormatException));
      }
    }
    else
    {
      addReturnValue(1, 9930091L);
      writeOperateLog(2309, str1, 0, ApplicationContextInit.getErrorInfo("-10000"));
    }
    return "SysException";
  }
}
