package gnnt.MEBS.espot.mgr.action.trademanage;

import gnnt.MEBS.common.mgr.action.EcsideAction;
import java.util.Map;
import javax.annotation.Resource;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

@Controller("breachApplyAction")
@Scope("request")
public class BreachApplyAction
  extends EcsideAction
{
  private static final long serialVersionUID = 4024558621252699662L;
  @Resource(name="breachStatus")
  protected Map<Integer, String> breachStatus;
  
  public Map<Integer, String> getBreachStatus()
  {
    return this.breachStatus;
  }
  
  public void setBreachStatus(Map<Integer, String> paramMap)
  {
    this.breachStatus = paramMap;
  }
}
