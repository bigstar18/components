package gnnt.MEBS.vendue.mgr.action.common;

import gnnt.MEBS.common.mgr.action.EcsideAction;
import gnnt.MEBS.common.mgr.service.StandardService;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.logging.Log;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

@Controller("commonAction")
@Scope("request")
public class CommonAction
  extends EcsideAction
{
  private static final long serialVersionUID = 5124568190167465621L;
  
  public String getPartitionInfo()
  {
    this.logger.debug("------------取得所有版块名称--------------");
    String str = "select p.partitionID, p.description, p.trademode from v_sysPartition p where validFlag = 1";
    List localList = getService().getListBySql(str);
    this.request.setAttribute("partition", localList);
    return "success";
  }
}
