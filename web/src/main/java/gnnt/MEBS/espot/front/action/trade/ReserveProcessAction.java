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
import gnnt.MEBS.espot.core.kernel.IReserveProcess;
import gnnt.MEBS.espot.core.vo.ResultVO;
import gnnt.MEBS.espot.front.model.trade.Reserve;
import gnnt.MEBS.espot.front.model.trade.ReserveBase;
import gnnt.MEBS.espot.front.model.trade.ReserveHis;
import gnnt.MEBS.espot.front.model.trade.TradeBase;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.commons.logging.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

@Controller("reserveProcessAction")
@Scope("request")
public class ReserveProcessAction
  extends StandardAction
{
  private static final long serialVersionUID = -3485692447102104114L;
  @Autowired
  @Qualifier("reserveProcessService")
  private IReserveProcess reserveProcessService;
  @Resource(name="bsFlagMap")
  Map<String, String> bsFlagMap;
  @Resource(name="reserveStatus")
  Map<String, String> reserveStatus;
  @Resource(name="deliveryType")
  private Map<String, String> deliveryType;
  
  public Map<String, String> getDeliveryType()
  {
    return this.deliveryType;
  }
  
  public Map<String, String> getReserveStatus()
  {
    return this.reserveStatus;
  }
  
  public IReserveProcess getReserveProcessService()
  {
    return this.reserveProcessService;
  }
  
  public Map<String, String> getBsFlagMap()
  {
    return this.bsFlagMap;
  }
  
  public String performBreachAsk()
  {
    String str = "申请对方订单%s违约";
    this.logger.debug("申请对方违约");
    long l = -1000L;
    l = Tools.strToLong(this.request.getParameter("reserveID"), -1000L);
    if (l < 0L)
    {
      addReturnValue(-1, 2310403L);
      str = String.format(str, new Object[] { "" });
      writeOperateLog(2304, str, 0, ApplicationContextInit.getErrorInfo("-5001"));
      return "error";
    }
    str = String.format(str, new Object[] { Long.valueOf(l) });
    ResultVO localResultVO = this.reserveProcessService.performBreachAsk(l);
    if (localResultVO.getResult() < 0L)
    {
      addReturnValue(-1, 2300002L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
      writeOperateLog(2304, str, 0, localResultVO.getErrorInfo().replace("\n", ""));
      return "error";
    }
    addReturnValue(1, 2310401L);
    writeOperateLog(2304, str, 1, "");
    return "success";
  }
  
  public String performWithdrawAsk()
  {
    String str = "撤销订单%s违约申请";
    this.logger.debug("撤销违约申请");
    long l = -1000L;
    l = Tools.strToLong(this.request.getParameter("reserveID"), -1000L);
    if (l < 0L)
    {
      addReturnValue(-1, 2310403L);
      str = String.format(str, new Object[] { "" });
      writeOperateLog(2304, str, 0, ApplicationContextInit.getErrorInfo("-5001"));
      return "error";
    }
    str = String.format(str, new Object[] { Long.valueOf(l) });
    ResultVO localResultVO = this.reserveProcessService.performWithdrawAsk(l);
    if (localResultVO.getResult() < 0L)
    {
      addReturnValue(-1, 2300002L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
      writeOperateLog(2304, str, 0, localResultVO.getErrorInfo().replace("\n", ""));
      return "error";
    }
    addReturnValue(1, 2310402L);
    writeOperateLog(2304, str, 1, "");
    return "success";
  }
  
  public String reserveList()
  {
    this.logger.debug("我的订单列表");
    User localUser = (User)this.request.getSession().getAttribute("CurrentUser");
    PageRequest localPageRequest = null;
    try
    {
      localPageRequest = ActionUtil.getPageRequest(this.request);
    }
    catch (Exception localException)
    {
      this.logger.error(Tools.getExceptionTrace(localException));
    }
    QueryConditions localQueryConditions = (QueryConditions)localPageRequest.getFilters();
    localQueryConditions.addCondition("firmID", "=", localUser.getBelongtoFirm().getFirmID());
    Object localObject = null;
    if ("H".equalsIgnoreCase(this.request.getParameter("isHistory"))) {
      localObject = new ReserveHis();
    } else {
      localObject = new Reserve();
    }
    Page localPage = getService().getPage(localPageRequest, (StandardModel)localObject);
    this.request.setAttribute("isHistory", this.request.getParameter("isHistory"));
    this.request.setAttribute("pageInfo", localPage);
    this.request.setAttribute("oldParams", ActionUtil.getParametersStartingWith(this.request, "gnnt_"));
    return "success";
  }
  
  public String reserveDetails()
  {
    this.logger.debug("订单详情查询");
    long l = Tools.strToLong(this.request.getParameter("reserveID"), -1000L);
    this.logger.debug("request.getParameter('reserveID')" + this.request.getParameter("reserveID"));
    this.logger.debug("reserveID :  " + l);
    if (l > 0L)
    {
      String str = this.request.getParameter("isHistory");
      Object localObject1 = null;
      if ((str != null) && (!str.equals("")))
      {
        localObject1 = new ReserveHis();
        this.request.setAttribute("isHistory", str);
      }
      else
      {
        localObject1 = new Reserve();
      }
      ((ReserveBase)localObject1).setReserveID(Long.valueOf(l));
      localObject1 = (ReserveBase)getService().get((StandardModel)localObject1);
      Object localObject2 = null;
      Object localObject3;
      if ((str != null) && (!str.equals("")))
      {
        localObject3 = (ReserveHis)localObject1;
        localObject2 = ((ReserveHis)localObject3).getBelongtoTrade();
      }
      else
      {
        localObject3 = (Reserve)localObject1;
        localObject2 = ((Reserve)localObject3).getBelongtoTrade();
      }
      this.request.setAttribute("tradePreTime", Tools.dateAddSeconds(((TradeBase)localObject2).getTime(), ((TradeBase)localObject2).getTradePreTime()));
      this.logger.debug("trade.getTradePreTime ===" + Tools.dateAddSeconds(((TradeBase)localObject2).getTime(), ((TradeBase)localObject2).getTradePreTime()));
      this.request.setAttribute("reserve", localObject1);
    }
    return "success";
  }
  
  public String repealReserve()
  {
    String str1 = "撤销订单%s";
    String str2 = this.request.getParameter("reserveID");
    try
    {
      this.logger.debug("撤销订单！ reserveID = " + str2);
      if ((str2 != null) && (str2.length() > 0))
      {
        str1 = String.format(str1, new Object[] { str2 });
        User localUser = (User)this.request.getSession().getAttribute("CurrentUser");
        ResultVO localResultVO = this.reserveProcessService.withdrawReserve(Long.valueOf(str2).longValue(), localUser.getName());
        if (localResultVO.getResult() == 1L)
        {
          addReturnValue(1, 2310613L);
          writeOperateLog(2309, str1, 1, "");
        }
        else
        {
          addReturnValue(-1, 2300002L, new Object[] { localResultVO.getErrorInfo().replace("\n", "") });
          writeOperateLog(2309, str1, 0, localResultVO.getErrorInfo().replace("\n", ""));
          this.logger.debug(localResultVO.getResult() + " :: " + localResultVO.getErrorDetailInfo());
        }
      }
      else
      {
        str1 = String.format(str1, new Object[] { "" });
        writeOperateLog(2309, str1, 0, "传入的订单编号为空");
      }
      return "success";
    }
    catch (Exception localException)
    {
      addReturnValue(1, 9930091L);
      str1 = String.format(str1, new Object[] { "" });
      writeOperateLog(2309, str1, 0, localException.getMessage());
      this.logger.error(Tools.getExceptionTrace(localException));
    }
    return "SysException";
  }
}
