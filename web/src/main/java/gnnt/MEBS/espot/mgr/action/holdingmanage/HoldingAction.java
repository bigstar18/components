package gnnt.MEBS.espot.mgr.action.holdingmanage;

import gnnt.MEBS.common.mgr.action.EcsideAction;
import gnnt.MEBS.common.mgr.common.PageRequest;
import gnnt.MEBS.common.mgr.common.QueryConditions;
import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.mgr.model.User;
import gnnt.MEBS.espot.core.kernel.ITradeProcess;
import gnnt.MEBS.espot.core.vo.ResultVO;
import gnnt.MEBS.espot.mgr.model.holdingmanage.Holding;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.commons.logging.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

@Controller("holdingAction")
@Scope("request")
public class HoldingAction
  extends EcsideAction
{
  private static final long serialVersionUID = 1L;
  @Autowired
  @Qualifier("tradeProcessService")
  private ITradeProcess tradeProcessService;
  private Holding hold;
  @Resource(name="bsFlagMap")
  protected Map<String, String> bsFlagMap;
  @Resource(name="holdingTypeMap")
  protected Map<String, String> holdingTypeMap;
  
  public Map<String, String> getHoldingTypeMap()
  {
    return this.holdingTypeMap;
  }
  
  public Map<String, String> getBsFlagMap()
  {
    return this.bsFlagMap;
  }
  
  public Holding getHold()
  {
    return this.hold;
  }
  
  public void setHold(Holding paramHolding)
  {
    this.hold = paramHolding;
  }
  
  public ITradeProcess getTradeProcessService()
  {
    return this.tradeProcessService;
  }
  
  public void setTradeProcessService(ITradeProcess paramITradeProcess)
  {
    this.tradeProcessService = paramITradeProcess;
  }
  
  public String holdingListRevocable()
    throws Exception
  {
    this.logger.debug("enter holdingListRevocable");
    PageRequest localPageRequest = getPageRequest(this.request);
    QueryConditions localQueryConditions = (QueryConditions)localPageRequest.getFilters();
    localQueryConditions.addCondition("status", "=", Integer.valueOf(1));
    localQueryConditions.addCondition("primary.tradeContract.status", "!=", Integer.valueOf(21));
    localQueryConditions.addCondition("primary.tradeContract.status", "!=", Integer.valueOf(22));
    localPageRequest.setSortColumns("order by holdingId desc");
    listByLimit(localPageRequest);
    return "success";
  }
  
  public String withdrawTrade()
    throws Exception
  {
    this.logger.debug("enter withdrawTrade");
    User localUser = (User)this.request.getSession().getAttribute("CurrentUser");
    try
    {
      ResultVO localResultVO = this.tradeProcessService.withdrawTrade(((Long)this.entity.fetchPKey().getValue()).longValue(), localUser.getUserId());
      if (localResultVO.getResult() <= 0L)
      {
        addReturnValue(-1, -230003L, new Object[] { localResultVO.getErrorInfo() });
        writeOperateLog(2309, "撤销成交号为：" + this.entity.fetchPKey().getValue() + "成交信息", 0, localResultVO.getErrorInfo());
      }
      else
      {
        addReturnValue(1, 233101L);
        writeOperateLog(2309, "撤销成交号为：" + this.entity.fetchPKey().getValue() + "成交信息", 1, "");
      }
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
      addReturnValue(-1, -9000L, new Object[] { "关闭交易操作" });
      writeOperateLog(2309, "撤销成交号为：" + this.entity.fetchPKey().getValue() + "成交信息", 0, localException.getMessage());
    }
    return "success";
  }
}
