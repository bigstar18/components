package gnnt.MEBS.espot.mgr.action.trademanage;

import gnnt.MEBS.common.mgr.action.EcsideAction;
import gnnt.MEBS.common.mgr.common.PageRequest;
import gnnt.MEBS.common.mgr.dao.StandardDao;
import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.mgr.model.User;
import gnnt.MEBS.common.mgr.service.StandardService;
import gnnt.MEBS.espot.core.kernel.ITradeProcess;
import gnnt.MEBS.espot.core.vo.ResultVO;
import gnnt.MEBS.espot.mgr.model.trademanage.EndTradeApply;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.commons.logging.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

@Controller("endTradeApplyAction")
@Scope("request")
public class EndTradeApplyAction
  extends EcsideAction
{
  private static final long serialVersionUID = 5591385449299399330L;
  @Autowired
  @Qualifier("tradeProcessService")
  private ITradeProcess tradeProcessService;
  @Resource(name="endTradeApplyStatusMap")
  protected Map<String, String> endTradeApplyStatusMap;
  
  public ITradeProcess getTradeProcessService()
  {
    return this.tradeProcessService;
  }
  
  public void setTradeProcessService(ITradeProcess paramITradeProcess)
  {
    this.tradeProcessService = paramITradeProcess;
  }
  
  public Map<String, String> getEndTradeApplyStatusMap()
  {
    return this.endTradeApplyStatusMap;
  }
  
  public String queryList()
    throws Exception
  {
    this.logger.debug("enter queryList");
    PageRequest localPageRequest = getPageRequest(this.request);
    listByLimit(localPageRequest);
    return "success";
  }
  
  public String applyProcess()
  {
    this.logger.debug("enter applyProcess");
    User localUser = (User)this.request.getSession().getAttribute("CurrentUser");
    EndTradeApply localEndTradeApply = new EndTradeApply();
    localEndTradeApply.setApplyId((Long)this.entity.fetchPKey().getValue());
    localEndTradeApply = (EndTradeApply)getService().get(localEndTradeApply);
    getService().getDao().evict(localEndTradeApply);
    localEndTradeApply = (EndTradeApply)getService().get(localEndTradeApply);
    ResultVO localResultVO = this.tradeProcessService.performEndTrade(localEndTradeApply.getTradeNo().longValue(), localUser.getUserId());
    try
    {
      if (localResultVO.getResult() <= 0L)
      {
        addReturnValue(-1, 230003L, new Object[] { localResultVO.getErrorInfo() });
        writeOperateLog(2309, "处理申请号为：" + this.entity.fetchPKey().getValue() + "的结束合同申请处理", 0, localResultVO.getErrorInfo());
      }
      else
      {
        addReturnValue(1, 230000L);
        writeOperateLog(2309, "处理申请号为：" + this.entity.fetchPKey().getValue() + "的结束合同申请处理", 1, "");
      }
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
      addReturnValue(-1, 230006L, new Object[] { "终止合同申请处理操作" });
      writeOperateLog(2309, "处理申请号为：" + this.entity.fetchPKey().getValue() + "的结束合同申请处理", 0, localException.getMessage());
    }
    return "success";
  }
  
  public String applyWithdraw()
  {
    User localUser = (User)this.request.getSession().getAttribute("CurrentUser");
    EndTradeApply localEndTradeApply = new EndTradeApply();
    localEndTradeApply.setApplyId((Long)this.entity.fetchPKey().getValue());
    localEndTradeApply = (EndTradeApply)getService().get(localEndTradeApply);
    getService().getDao().evict(localEndTradeApply);
    localEndTradeApply = (EndTradeApply)getService().get(localEndTradeApply);
    ResultVO localResultVO = this.tradeProcessService.withdrawApplyEndTrade(localEndTradeApply.getTradeNo().longValue(), localUser.getUserId());
    try
    {
      if (localResultVO.getResult() <= 0L)
      {
        addReturnValue(-1, 230003L, new Object[] { localResultVO.getErrorInfo() });
        writeOperateLog(2309, "撤销申请号为：" + this.entity.fetchPKey().getValue() + "的结束合同申请", 0, localResultVO.getErrorInfo());
      }
      else
      {
        addReturnValue(1, 233104L);
        writeOperateLog(2309, "撤销申请号为：" + this.entity.fetchPKey().getValue() + "的结束合同申请", 1, "");
      }
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
      addReturnValue(-1, 230006L, new Object[] { "终止合同申请撤销操作" });
      writeOperateLog(2309, "撤销申请号为：" + this.entity.fetchPKey().getValue() + "的结束合同申请", 0, localException.getMessage());
    }
    return "success";
  }
}
