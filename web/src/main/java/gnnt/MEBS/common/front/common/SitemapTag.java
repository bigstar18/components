package gnnt.MEBS.common.front.common;

import gnnt.MEBS.common.front.model.sitemap.ReadSiteMap;
import java.io.PrintStream;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.TagSupport;

public class SitemapTag
  extends TagSupport
{
  private static final long serialVersionUID = 1416560963438146973L;
  
  public int doStartTag()
  {
    try
    {
      JspWriter out = this.pageContext.getOut();
      out.print(getOutter());
    }
    catch (Exception e)
    {
      e.printStackTrace();
    }
    return 1;
  }
  
  public int doEndTag()
  {
    return 6;
  }
  
  public String getOutter()
  {
    String result = "";
    HttpServletRequest request = (HttpServletRequest)this.pageContext
      .getRequest();
    String currentFilePath = request.getRequestURI().replaceFirst(request.getContextPath(), "");
    System.out.println("currentFilePath[" + currentFilePath + "]");
    result = (String)ReadSiteMap.getInstance(request).getSiteMap().get(currentFilePath);
    return result;
  }
}
