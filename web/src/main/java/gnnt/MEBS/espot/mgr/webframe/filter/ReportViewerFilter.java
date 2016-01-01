package gnnt.MEBS.espot.mgr.webframe.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

public class ReportViewerFilter
  implements Filter
{
  protected String encoding = "UTF-8";
  protected FilterConfig filterConfig = null;
  
  public void destroy()
  {
    this.encoding = null;
    this.filterConfig = null;
  }
  
  public void doFilter(ServletRequest paramServletRequest, ServletResponse paramServletResponse, FilterChain paramFilterChain)
    throws IOException, ServletException
  {
    if ((this.encoding != null) && (!paramServletRequest.getCharacterEncoding().equals(this.encoding)))
    {
      paramServletRequest.setCharacterEncoding(this.encoding);
      paramServletResponse.setCharacterEncoding(this.encoding);
    }
    paramFilterChain.doFilter(paramServletRequest, paramServletResponse);
  }
  
  public void init(FilterConfig paramFilterConfig)
    throws ServletException
  {
    this.filterConfig = paramFilterConfig;
  }
}
