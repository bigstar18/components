package gnnt.MEBS.common.broker.webframe.securitycheck;

import gnnt.MEBS.common.broker.model.User;
import java.util.List;

public class UrlCheck
{
  private List<IUrlCheck> urlCheckList;
  
  public List<IUrlCheck> getUrlCheckList()
  {
    return this.urlCheckList;
  }
  
  public void setUrlCheckList(List<IUrlCheck> urlCheckList)
  {
    this.urlCheckList = urlCheckList;
  }
  
  public UrlCheckResult check(String url, User user)
  {
    UrlCheckResult urlCheckResult = UrlCheckResult.SUCCESS;
    if ((this.urlCheckList != null) && (this.urlCheckList.size() > 0)) {
      for (IUrlCheck urlCheck : this.urlCheckList)
      {
        urlCheckResult = urlCheck.check(url, user);
        if (urlCheckResult != UrlCheckResult.SUCCESS) {
          break;
        }
      }
    }
    return urlCheckResult;
  }
}
