package gnnt.MEBS.espot.front.action.display;

import gnnt.MEBS.common.front.action.StandardAction;
import gnnt.MEBS.common.front.statictools.ApplicationContextInit;
import gnnt.MEBS.common.front.statictools.Tools;
import gnnt.MEBS.espot.front.common.XTradeFrontGlobal;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.logging.Log;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

@Controller("categoryAction")
@Scope("request")
public class CategoryAction
  extends StandardAction
{
  private static final long serialVersionUID = 1127474032745120214L;
  
  public String list()
    throws Exception
  {
    this.logger.debug("获取商品分类列表");
    int i = Tools.strToInt(ApplicationContextInit.getConfig("menu"), 1);
    String str1 = "one";
    if (i == 1)
    {
      this.request.setAttribute("pageInfo", XTradeFrontGlobal.getCategoryPage());
    }
    else
    {
      this.request.setAttribute("pageInfo", XTradeFrontGlobal.getCategoryFirstPage());
      str1 = "two";
    }
    this.logger.debug("===================bsFlag:" + this.request.getParameter("bsFlag"));
    String str2 = this.request.getParameter("bsFlag");
    if ((str2 == null) || ("".equals(str2))) {
      str2 = "A";
    }
    this.request.setAttribute("bsFlag", str2);
    String str3 = this.request.getParameter("tbln");
    this.request.setAttribute("tbln", str3);
    return str1;
  }
}
