package gnnt.MEBS.vendue.mgr.action.system;

import gnnt.MEBS.common.mgr.action.StandardAction;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

@Controller("errorHandingAction")
@Scope("request")
public class ErrorHandingAction
  extends StandardAction
{
  private static final long serialVersionUID = 1L;
  
  public String refreshCurCommodityBuy()
  {
    return "success";
  }
  
  public String refreshCurCommoditySell()
  {
    return "success";
  }
  
  public String refreshTradeAuth()
  {
    return "success";
  }
  
  public String refreshSysPartitionid()
  {
    return "success";
  }
  
  public String refeshPartitionAuthAndTradeMaxCount()
  {
    return "success";
  }
}
