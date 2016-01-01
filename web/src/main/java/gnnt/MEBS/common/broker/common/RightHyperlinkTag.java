package gnnt.MEBS.common.broker.common;

import gnnt.MEBS.common.broker.model.User;
import gnnt.MEBS.common.broker.statictools.ApplicationContextInit;
import gnnt.MEBS.common.broker.webframe.securitycheck.UrlCheck;
import gnnt.MEBS.common.broker.webframe.securitycheck.UrlCheckResult;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.TagSupport;

public class RightHyperlinkTag
  extends TagSupport
{
  private static final long serialVersionUID = 8362880742737834205L;
  private String id;
  private String name;
  private String title;
  private String text;
  private String className;
  private String style;
  private String target;
  private String display;
  private String onclick;
  private String action;
  private String href;
  
  public String getId()
  {
    return this.id;
  }
  
  public void setId(String id)
  {
    this.id = id;
  }
  
  public String getName()
  {
    return this.name;
  }
  
  public void setName(String name)
  {
    this.name = name;
  }
  
  public String getTitle()
  {
    return this.title;
  }
  
  public void setTitle(String title)
  {
    this.title = title;
  }
  
  public String getText()
  {
    return this.text;
  }
  
  public void setText(String text)
  {
    this.text = text;
  }
  
  public String getClassName()
  {
    return this.className;
  }
  
  public void setClassName(String className)
  {
    this.className = className;
  }
  
  public String getStyle()
  {
    return this.style;
  }
  
  public void setStyle(String style)
  {
    this.style = style;
  }
  
  public String getTarget()
  {
    return this.target;
  }
  
  public void setTarget(String target)
  {
    this.target = target;
  }
  
  public String getDisplay()
  {
    return this.display;
  }
  
  public void setDisplay(String display)
  {
    this.display = display;
  }
  
  public String getOnclick()
  {
    return this.onclick;
  }
  
  public void setOnclick(String onclick)
  {
    this.onclick = onclick;
  }
  
  public String getAction()
  {
    return this.action;
  }
  
  public void setAction(String action)
  {
    this.action = action;
  }
  
  public String getHref()
  {
    return this.href;
  }
  
  public void setHref(String href)
  {
    this.href = href;
  }
  
  public int doEndTag()
  {
    try
    {
      HttpServletRequest request = (HttpServletRequest)this.pageContext.getRequest();
      
      User user = (User)request.getSession().getAttribute("CurrentUser");
      UrlCheck urlCheck = (UrlCheck)ApplicationContextInit.getBean("urlCheck");
      
      UrlCheckResult urlCheckResult = UrlCheckResult.NOPURVIEW;
      if ((this.href != null) && (this.href.trim().length() > 0) && (!this.href.trim().equals("#"))) {
        urlCheckResult = urlCheck.check(this.href, user);
      } else if ((this.action != null) && (this.action.trim().length() > 0)) {
        urlCheckResult = urlCheck.check(this.action, user);
      }
      boolean isRight = false;
      switch (urlCheckResult)
      {
      case AUOVERTIME: 
      case AUUSERKICK: 
      case USERISNULL: 
        isRight = true;
        break;
      case NEEDLESSCHECK: 
      case NEEDLESSCHECKRIGHT: 
      case NOPURVIEW: 
      case SUCCESS: 
        isRight = false;
        break;
      default: 
        isRight = false;
      }
      if (isRight)
      {
        JspWriter out = this.pageContext.getOut();
        out.println("<a " + (
          (this.id == null) || (this.id.trim().length() <= 0) ? "" : new StringBuilder("id=\"").append(this.id.trim()).append("\" ").toString()) + (
          (this.name == null) || (this.name.trim().length() <= 0) ? "" : new StringBuilder("name=\"").append(this.name.trim()).append("\" ").toString()) + (
          (this.title == null) || (this.title.trim().length() <= 0) ? "" : new StringBuilder("title=\"").append(this.title.trim()).append("\" ").toString()) + (
          (this.className == null) || (this.className.trim().length() <= 0) ? "" : new StringBuilder("class=\"").append(this.className.trim()).append("\" ").toString()) + (
          (this.style == null) || (this.style.trim().length() <= 0) ? "" : new StringBuilder("style=\"").append(this.style.trim()).append("\" ").toString()) + (
          (this.target == null) || (this.target.trim().length() <= 0) ? "" : new StringBuilder("target=\"").append(this.target.trim()).append("\" ").toString()) + (
          (this.onclick == null) || (this.onclick.trim().length() <= 0) ? "" : new StringBuilder("onclick=\"").append(this.onclick.trim()).append("\" ").toString()) + (
          (this.action == null) || (this.action.trim().length() <= 0) ? "" : new StringBuilder("action=\"").append(this.action.trim()).append("\" ").toString()) + (
          (this.href == null) || (this.href.trim().length() <= 0) ? "href=\"#\"" : new StringBuilder("href=\"").append(this.href.trim()).append("\" ").toString()) + 
          ">" + this.text + "</a>");
      }
      else if ((this.display == null) || (this.display.trim().equalsIgnoreCase("true")))
      {
        JspWriter out = this.pageContext.getOut();
        out.println(this.text);
      }
    }
    catch (Exception localException) {}
    return 6;
  }
}
