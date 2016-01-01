package gnnt.MEBS.common.broker.webframe.securitycheck;

import gnnt.MEBS.common.broker.common.Page;
import gnnt.MEBS.common.broker.common.PageRequest;
import gnnt.MEBS.common.broker.model.Right;
import gnnt.MEBS.common.broker.model.StandardModel;
import gnnt.MEBS.common.broker.model.User;
import gnnt.MEBS.common.broker.service.StandardService;
import gnnt.MEBS.common.broker.statictools.ApplicationContextInit;
import java.util.HashMap;
import java.util.Map;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class UrlCheckSession
  implements IUrlCheck
{
  private final transient Log logger = LogFactory.getLog(UrlCheckSession.class);
  private static Map<String, Right> needlessCheckRightUrl;
  
  public UrlCheckResult check(String url, User user)
  {
    if (user == null) {
      return UrlCheckResult.USERISNULL;
    }
    if (needlessCheckRightUrl == null)
    {
      needlessCheckRightUrl = new HashMap();
      
      StandardService standardService = (StandardService)
        ApplicationContextInit.getBean("com_standardService");
      
      PageRequest<String> pageRequest = new PageRequest(
        " and type=-3 ");
      
      pageRequest.setPageSize(100);
      
      Page<StandardModel> page = standardService.getPage(pageRequest, 
        new Right());
      if (page.getResult() != null) {
        for (StandardModel model : page.getResult())
        {
          Right right = (Right)model;
          if ((right.getUrl() != null) && 
            (right.getUrl().trim().length() > 0))
          {
            this.logger.debug("url:" + right.getUrl() + 
              "       id: " + right.getId());
            needlessCheckRightUrl.put(right.getUrl(), right);
          }
        }
      }
    }
    Right right = (Right)needlessCheckRightUrl.get(url);
    if (right != null) {
      return UrlCheckResult.NEEDLESSCHECKRIGHT;
    }
    return UrlCheckResult.SUCCESS;
  }
}
