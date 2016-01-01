package gnnt.MEBS.common.front.common;

import gnnt.MEBS.common.front.model.integrated.User;
import gnnt.MEBS.common.front.statictools.ApplicationContextInit;
import gnnt.MEBS.common.front.webFrame.securityCheck.UrlCheck;
import gnnt.MEBS.common.front.webFrame.securityCheck.UrlCheckResult;
import java.io.IOException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.TagSupport;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class RightButtonTag
  extends TagSupport
{
  private static final long serialVersionUID = -3558314216634059969L;
  private final transient Log logger = LogFactory.getLog(RightButtonTag.class);
  private String className;
  private String onclick;
  private String id;
  private String name;
  private String action;
  
  public String getName()
  {
    return this.name;
  }
  
  public void setName(String name)
  {
    this.name = name;
  }
  
  public String getClassName()
  {
    return this.className;
  }
  
  public void setClassName(String className)
  {
    this.className = className;
  }
  
  public String getOnclick()
  {
    return this.onclick;
  }
  
  public void setOnclick(String onclick)
  {
    this.onclick = onclick;
  }
  
  public String getId()
  {
    return this.id;
  }
  
  public void setId(String id)
  {
    this.id = id;
  }
  
  public String getAction()
  {
    return this.action;
  }
  
  public void setAction(String action)
  {
    this.action = action;
  }
  
  public int doEndTag()
  {
    try
    {
      HttpServletRequest request = (HttpServletRequest)this.pageContext
        .getRequest();
      
      User user = (User)request.getSession()
        .getAttribute("CurrentUser");
      
      UrlCheck urlCheck = (UrlCheck)
        ApplicationContextInit.getBean("urlCheck");
      
      UrlCheckResult urlCheckResult = urlCheck.check(this.action, user);
      
      boolean isRight = false;
      switch (urlCheckResult)
      {
      case AUOVERTIME: 
      case AUUSERKICK: 
      case SUCCESS: 
        isRight = true;
        break;
      case NEEDLESSCHECK: 
      case NEEDLESSCHECKRIGHT: 
      case NOMODULEPURVIEW: 
      case NOPURVIEW: 
      case USERISNULL: 
        isRight = false;
        break;
      default: 
        isRight = false;
      }
      if (isRight)
      {
        JspWriter out = this.pageContext.getOut();
        out.println("<button class=\"" + this.className + "\" id=\"" + this.id + 
          "\" action=\"" + this.action + "\" onclick=\"" + this.onclick + 
          "\">" + this.name + "</button>");
      }
    }
    catch (IOException e)
    {
      this.logger.error("rightButton occor Exception ;exception info " + 
        e.getMessage());
    }
    return 6;
  }
}
