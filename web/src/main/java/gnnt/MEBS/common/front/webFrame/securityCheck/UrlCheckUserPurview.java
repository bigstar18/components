package gnnt.MEBS.common.front.webFrame.securityCheck;

import gnnt.MEBS.common.front.common.Page;
import gnnt.MEBS.common.front.common.PageRequest;
import gnnt.MEBS.common.front.model.StandardModel;
import gnnt.MEBS.common.front.model.front.Right;
import gnnt.MEBS.common.front.model.integrated.User;
import gnnt.MEBS.common.front.service.StandardService;
import gnnt.MEBS.common.front.statictools.ApplicationContextInit;
import java.io.PrintStream;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class UrlCheckUserPurview
  implements IUrlCheck
{
  private final transient Log logger = LogFactory.getLog(UrlCheckUserPurview.class);
  private static Map<String, Right> needlessCheckRightUrl;
  
  public UrlCheckResult check(String url, User user)
  {
    Map<Long, Right> userRight = user.getRightMap();
    if (userRight == null) {
      return UrlCheckResult.NOPURVIEW;
    }
    Page<StandardModel> page;
    if (needlessCheckRightUrl == null)
    {
      needlessCheckRightUrl = new HashMap();
      
      StandardService standardService = (StandardService)
        ApplicationContextInit.getBean("com_standardService");
      
      PageRequest<String> pageRequest = new PageRequest(
        " and type=-3 ");
      
      pageRequest.setPageSize(100);
      
      page = standardService.getPage(pageRequest, 
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
    Right needlessRight = (Right)needlessCheckRightUrl.get(url);
    if (needlessRight != null) {
      return UrlCheckResult.NEEDLESSCHECKRIGHT;
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
