package gnnt.MEBS.common.front.webFrame.securityCheck;

import gnnt.MEBS.common.front.common.ActiveUserManager;
import gnnt.MEBS.common.front.model.integrated.User;
import gnnt.MEBS.logonService.vo.ISLogonResultVO;

public class UrlCheckUserInfo
  implements IUrlCheck
{
  public UrlCheckResult check(String url, User user)
  {
    ISLogonResultVO isLogonResultVO = null;
    try
    {
      isLogonResultVO = ActiveUserManager.isLogon(user.getTraderID(), user.getSessionId().longValue(), user.getLogonType(), user.getModuleID().intValue());
      
      int result = isLogonResultVO.getResult();
      String recode = isLogonResultVO.getRecode();
      if (result == -1)
      {
        if (recode.equals("-1303")) {
          return UrlCheckResult.AUUSERKICK;
        }
        if (recode.equals("-1302")) {
          return UrlCheckResult.AUOVERTIME;
        }
        return UrlCheckResult.AUOVERTIME;
      }
      if (!ActiveUserManager.checkModuleRight(user.getTraderID())) {
        return UrlCheckResult.NOMODULEPURVIEW;
      }
    }
    catch (Exception e)
    {
      return UrlCheckResult.AUOVERTIME;
    }
    return UrlCheckResult.SUCCESS;
  }
}
