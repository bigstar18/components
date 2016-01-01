package gnnt.MEBS.common.broker.webframe.securitycheck;

import gnnt.MEBS.common.broker.common.Page;
import gnnt.MEBS.common.broker.common.PageRequest;
import gnnt.MEBS.common.broker.model.Right;
import gnnt.MEBS.common.broker.model.StandardModel;
import gnnt.MEBS.common.broker.model.User;
import gnnt.MEBS.common.broker.service.StandardService;
import gnnt.MEBS.common.broker.statictools.ApplicationContextInit;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class UrlCheckNeedlessCheck
  implements IUrlCheck
{
  private final transient Log logger = LogFactory.getLog(UrlCheckNeedlessCheck.class);
  private List<String> noKeywordList = null;
  private List<String> needlessCheckDirList = null;
  private static Map<String, Right> needlessCheckUrl;
  
  public UrlCheckResult check(String url, User user)
  {
    String[] noKeywords;
    if (this.noKeywordList == null)
    {
      this.noKeywordList = new ArrayList();
      
      String noKeyword = ApplicationContextInit.getConfig("NoKeyWords");
      if ((noKeyword != null) && (noKeyword.length() > 0))
      {
        noKeywords = noKeyword.split(",");
        for (int i = 0; i < noKeywords.length; i++) {
          this.noKeywordList.add(noKeywords[i]);
        }
      }
    }
    for (String key : this.noKeywordList) {
      if ((key != null) && (url.endsWith(key))) {
        return UrlCheckResult.NEEDLESSCHECK;
      }
    }
    String[] needlessCheckDirs;
    if (this.needlessCheckDirList == null)
    {
      this.needlessCheckDirList = new ArrayList();
      
      String needlessCheckDir = ApplicationContextInit.getConfig("NeedlessCheckDir");
      if ((needlessCheckDir != null) && (needlessCheckDir.length() > 0))
      {
        needlessCheckDirs = needlessCheckDir.split(",");
        for (int i = 0; i < needlessCheckDirs.length; i++) {
          this.needlessCheckDirList.add(needlessCheckDirs[i]);
        }
      }
    }
    for (String key : this.needlessCheckDirList) {
      if (url.startsWith(key)) {
        return UrlCheckResult.NEEDLESSCHECK;
      }
    }
    if (needlessCheckUrl == null)
    {
      needlessCheckUrl = new HashMap();
      
      StandardService standardService = (StandardService)
        ApplicationContextInit.getBean("com_standardService");
      
      PageRequest<String> pageRequest = new PageRequest(
        " and type=-2 ");
      
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
            this.logger.debug("url:" + right.getUrl() + "       id: " + 
              right.getId());
            needlessCheckUrl.put(right.getUrl(), right);
          }
        }
      }
    }
    Right right = (Right)needlessCheckUrl.get(url);
    if (right != null) {
      return UrlCheckResult.NEEDLESSCHECK;
    }
    return UrlCheckResult.SUCCESS;
  }
}
