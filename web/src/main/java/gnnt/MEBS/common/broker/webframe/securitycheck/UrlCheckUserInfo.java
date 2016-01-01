package gnnt.MEBS.common.broker.webframe.securitycheck;

import gnnt.MEBS.common.broker.common.ActiveUserManager;
import gnnt.MEBS.common.broker.common.Global;
import gnnt.MEBS.common.broker.model.User;
import gnnt.MEBS.logonService.vo.ISLogonResultVO;

public class UrlCheckUserInfo
  implements IUrlCheck
{
  public UrlCheckResult check(String url, User user)
  {
    try
    {
      ISLogonResultVO result = ActiveUserManager.isLogon(user.getUserId(), user.getSessionId(), Global.getSelfModuleID(), user.getLogonType());
      if (result.getResult() == -1)
      {
        if ("-1301".equals(result.getRecode().trim())) {
          return UrlCheckResult.USERISNULL;
        }
        if ("-1302".equals(result.getRecode().trim())) {
          return UrlCheckResult.AUOVERTIME;
        }
        if ("-1303".equals(result.getRecode().trim())) {
          return UrlCheckResult.AUUSERKICK;
        }
        return UrlCheckResult.USERISNULL;
      }
    }
    catch (Exception e)
    {
      e.printStackTrace();
    }
    return UrlCheckResult.SUCCESS;
  }
}
