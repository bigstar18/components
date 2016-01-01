package gnnt.MEBS.common.broker.webframe.securitycheck;

import gnnt.MEBS.common.broker.model.Broker;
import gnnt.MEBS.common.broker.model.BrokerAge;
import gnnt.MEBS.common.broker.model.Right;
import gnnt.MEBS.common.broker.model.User;
import java.io.PrintStream;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class UrlCheckUserPurview
  implements IUrlCheck
{
  public UrlCheckResult check(String url, User user)
  {
    Map<Long, Right> userRight = null;
    if (user.getType().equals("0")) {
      userRight = user.getBroker().getRightMap();
    } else {
      userRight = user.getBrokerAge().getRightMap();
    }
    if (userRight == null) {
      return UrlCheckResult.NOPURVIEW;
    }
    for (Right right : userRight.values()) {
      if ((right.getUrl() != null) && (right.getUrl().length() != 0))
      {
        if (right.getUrl().equals(url)) {
          return UrlCheckResult.SUCCESS;
        }
        if (right.getUrl().endsWith("*")) {
          if (right.getType().intValue() == 0)
          {
            if (right.getVisiturl().contains(url)) {
              return UrlCheckResult.SUCCESS;
            }
          }
          else
          {
            String tempUrl = right.getUrl().substring(0, 
              right.getUrl().length() - 1);
            if (url.contains(tempUrl)) {
              return UrlCheckResult.SUCCESS;
            }
          }
        }
      }
    }
    return UrlCheckResult.NOPURVIEW;
  }
  
  public static void main(String[] args)
  {
    Pattern pattern = Pattern.compile("/user/add.*");
    Matcher matcher = pattern.matcher("/user/add.action");
    if (matcher.matches()) {
      System.out.println("匹配成功！");
    }
  }
}
