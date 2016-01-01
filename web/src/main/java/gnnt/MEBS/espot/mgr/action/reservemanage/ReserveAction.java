package gnnt.MEBS.espot.mgr.action.reservemanage;

import gnnt.MEBS.common.mgr.action.EcsideAction;
import gnnt.MEBS.common.mgr.common.PageRequest;
import gnnt.MEBS.common.mgr.common.QueryConditions;
import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.mgr.model.User;
import gnnt.MEBS.espot.core.kernel.IReserveProcess;
import gnnt.MEBS.espot.core.vo.ResultVO;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.commons.logging.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

@Controller("reserveAction")
@Scope("request")
public class ReserveAction
  extends EcsideAction
{
  private static final long serialVersionUID = 1L;
  @Autowired
  @Qualifier("reserveProcessService")
  private IReserveProcess reserveProcessService;
  @Resource(name="bsFlagMap")
  protected Map<String, String> bsFlagMap;
  @Resource(name="reserveTypeMap")
  protected Map<String, String> reserveTypeMap;
  
  public Map<String, String> getReserveTypeMap()
  {
    return this.reserveTypeMap;
  }
  
  public Map<String, String> getBsFlagMap()
  {
    return this.bsFlagMap;
  }
  
  public IReserveProcess getReserveProcessService()
  {
    return this.reserveProcessService;
  }
  
  public void setReserveProcessService(IReserveProcess paramIReserveProcess)
  {
    this.reserveProcessService = paramIReserveProcess;
  }
  
  public String reserveListRevocable()
    throws Exception
  {
    this.logger.debug("enter reserveListRevocable");
    PageRequest localPageRequest = getPageRequest(this.request);
    QueryConditions localQueryConditions = (QueryConditions)localPageRequest.getFilters();
    localQueryConditions.addCondition("status", "=", Integer.valueOf(0));
    localPageRequest.setSortColumns("order by reserveId desc");
    listByLimit(localPageRequest);
    return "success";
  }
  
  public String withdrawReserve()
  {
    this.logger.debug("enter withdrawReserve");
    User localUser = (User)this.request.getSession().getAttribute("CurrentUser");
    try
    {
      ResultVO localResultVO = this.reserveProcessService.withdrawReserve(((Long)this.entity.fetchPKey().getValue()).longValue(), localUser.getUserId());
      if (localResultVO.getResult() <= 0L)
      {
        addReturnValue(-1, 230003L, new Object[] { localResultVO.getErrorInfo() });
        writeOperateLog(2309, "撤销订单号为：" + this.entity.fetchPKey().getValue() + "的订单", 0, localResultVO.getErrorInfo());
      }
      else
      {
        addReturnValue(1, 233101L);
        writeOperateLog(2309, "撤销订单号为：" + this.entity.fetchPKey().getValue() + "的订单", 1, "");
      }
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
      addReturnValue(-1, 230006L, new Object[] { "拆单操作" });
      writeOperateLog(2309, "撤销订单号为：" + this.entity.fetchPKey().getValue() + "的订单", 0, localException.getMessage());
    }
    return "success";
  }
}
