package gnnt.MEBS.vendue.front.service.impl;

import gnnt.MEBS.vendue.front.model.TradeUser;
import gnnt.MEBS.vendue.front.service.FirmLimit;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class FirmLimitImpl
  implements FirmLimit
{
  public int validateFirm(String paramString, HttpServletRequest paramHttpServletRequest, int paramInt, short paramShort)
  {
    TradeUser localTradeUser = (TradeUser)paramHttpServletRequest.getSession().getAttribute("tradeUser");
    List localList = (List)paramHttpServletRequest.getSession().getAttribute("authList");
    int i = localTradeUser.getLimits();
    int j = 1;
    int k = 0;
    if (i == 3) {
      return -101;
    }
    if ((paramShort == 1) && (i == 2)) {
      return -102;
    }
    if ((paramShort == 2) && (i == 1)) {
      return -103;
    }
    for (int m = 0; m < localList.size(); m++) {
      if (((String)localList.get(m)).equals(paramString))
      {
        k = 1;
        break;
      }
    }
    if (paramInt == 1)
    {
      if (k != 1) {
        return -104;
      }
    }
    else if ((paramInt == 2) && (k != 0)) {
      return -104;
    }
    return j;
  }
}
