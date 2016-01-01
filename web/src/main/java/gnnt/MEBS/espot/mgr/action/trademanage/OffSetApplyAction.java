package gnnt.MEBS.espot.mgr.action.trademanage;

import gnnt.MEBS.common.mgr.action.EcsideAction;
import java.util.Map;
import javax.annotation.Resource;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

@Controller("offSetApplyAction")
@Scope("request")
public class OffSetApplyAction
  extends EcsideAction
{
  private static final long serialVersionUID = 4024558621252699662L;
  @Resource(name="offSetStatus")
  protected Map<Integer, String> offSetStatus;
  
  public Map<Integer, String> getOffSetStatus()
  {
    return this.offSetStatus;
  }
  
  public void setOffSetStatus(Map<Integer, String> paramMap)
  {
    this.offSetStatus = paramMap;
  }
}
