package gnnt.MEBS.common.front.model.sitemap;

import gnnt.MEBS.common.front.statictools.filetools.XMLWork;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URL;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.servlet.http.HttpServletRequest;

public class ReadSiteMap
{
  private static volatile ReadSiteMap instance;
  private HttpServletRequest request;
  private Map<String, String> sitemap;
  
  public static ReadSiteMap getInstance(HttpServletRequest request)
  {
    if (instance == null) {
      synchronized (ReadSiteMap.class)
      {
        if (instance == null) {
          instance = new ReadSiteMap(request);
        }
      }
    }
    return instance;
  }
  
  private ReadSiteMap(HttpServletRequest request)
  {
    this.request = request;
    this.sitemap = readSiteMapXml();
  }
  
  public Map<String, String> getSiteMap()
  {
    return this.sitemap;
  }
  
  public void reloadSiteMap()
  {
    this.sitemap = instance.readSiteMapXml();
  }
  
  private Map<String, String> readSiteMapXml()
  {
    String xmlURL = getClass().getClassLoader().getResource("").getPath() + 
      "/sitemap.xml";
    try
    {
      xmlURL = 
        getClass().getClassLoader().getResource("").toURI().getPath() + "/sitemap.xml";
    }
    catch (URISyntaxException e)
    {
      e.printStackTrace();
    }
    SiteMapModel siteMapModel = (SiteMapModel)XMLWork.reader(
      SiteMapModel.class, XMLWork.readXMLFile(xmlURL));
    
    return getSitemap(siteMapModel);
  }
  
  private Map<String, String> getSitemap(SiteMapModel siteMapModel)
  {
    Map<String, String> tempMap = new HashMap();
    if ((siteMapModel != null) && 
      (siteMapModel.siteMapNode != null) && 
      (siteMapModel.siteMapNode.size() > 0)) {
      for (SiteMapNode siteMapNode : siteMapModel.siteMapNode) {
        if ((siteMapNode.node != null) && (siteMapNode.node.size() > 0))
        {
          tempMap.putAll(getNodeSiteMap(siteMapNode, ""));
        }
        else if ((siteMapNode.title != null) && (siteMapNode.title.trim().length() > 0))
        {
          String value = siteMapNode.title;
          if ((siteMapNode.href != null) && (siteMapNode.href.trim().length() > 0)) {
            value = "<a href='" + getURL(siteMapNode.href) + "'>" + value + "</a>";
          }
          if ((siteMapNode.path != null) && (siteMapNode.path.trim().length() > 0)) {
            tempMap.put(siteMapNode.path.trim(), value);
          }
        }
      }
    }
    return tempMap;
  }
  
  private Map<String, String> getNodeSiteMap(SiteMapNode siteMapNode, String fatherValue)
  {
    Map<String, String> tempMap = new HashMap();
    
    String path = siteMapNode.path;
    
    String href = siteMapNode.href;
    
    String title = siteMapNode.title;
    if ((title == null) || (title.trim().length() == 0)) {
      return tempMap;
    }
    if ((fatherValue != null) && (fatherValue.trim().length() > 0)) {
      fatherValue = fatherValue + "&nbsp;&gt;&nbsp;";
    } else {
      fatherValue = "";
    }
    if ((href != null) && (href.trim().length() > 0)) {
      fatherValue = fatherValue + "<a href='" + getURL(href) + "'>" + title + "</a>";
    } else {
      fatherValue = fatherValue + title;
    }
    if ((path != null) && (path.trim().length() > 0)) {
      tempMap.put(path.trim(), fatherValue);
    }
    if ((siteMapNode.node != null) && (siteMapNode.node.size() > 0)) {
      for (SiteMapNode childSiteMapNode : siteMapNode.node) {
        tempMap.putAll(getNodeSiteMap(childSiteMapNode, fatherValue));
      }
    }
    return tempMap;
  }
  
  private String getURL(String href)
  {
    if (href == null) {
      return "";
    }
    String regex = "http[s]?://(([a-zA-z0-9]|-){1,}\\.){1,}[a-zA-z0-9]{1,}-*";
    Pattern pattern = Pattern.compile(regex);
    Matcher matcher = pattern.matcher(href);
    if (matcher.matches()) {
      return href;
    }
    if ((!href.startsWith("/")) && (!href.startsWith("\\"))) {
      href = href + "/";
    }
    return this.request.getContextPath() + href;
  }
}
