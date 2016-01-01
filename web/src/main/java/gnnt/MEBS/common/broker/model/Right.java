package gnnt.MEBS.common.broker.model;

import java.util.HashSet;
import java.util.Set;

public class Right
  extends StandardModel
{
  private static final long serialVersionUID = -6128452830189088494L;
  private Long id;
  private String name;
  private String icon;
  private String url;
  private String visiturl;
  private Integer moduleId;
  private Integer visible;
  private Integer seq;
  private Integer type;
  private Set<Right> childRightSet = new HashSet();
  private Set<Broker> brokerSet;
  private Right parentRight;
  private LogCatalog logCatalog;
  private String isWriteLog;
  private String onlyMember;
  
  public Long getId()
  {
    return this.id;
  }
  
  public void setId(Long id)
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
  
  public String getIcon()
  {
    return this.icon;
  }
  
  public void setIcon(String icon)
  {
    this.icon = icon;
  }
  
  public String getUrl()
  {
    return this.url;
  }
  
  public void setUrl(String url)
  {
    this.url = url;
  }
  
  public String getVisiturl()
  {
    return this.visiturl;
  }
  
  public void setVisiturl(String visiturl)
  {
    this.visiturl = visiturl;
  }
  
  public Integer getModuleId()
  {
    return this.moduleId;
  }
  
  public void setModuleId(Integer moduleId)
  {
    this.moduleId = moduleId;
  }
  
  public Integer getVisible()
  {
    return this.visible;
  }
  
  public void setVisible(Integer visible)
  {
    this.visible = visible;
  }
  
  public Integer getSeq()
  {
    return this.seq;
  }
  
  public void setSeq(Integer seq)
  {
    this.seq = seq;
  }
  
  public Integer getType()
  {
    return this.type;
  }
  
  public void setType(Integer type)
  {
    this.type = type;
  }
  
  public Right getParentRight()
  {
    return this.parentRight;
  }
  
  public void setParentRight(Right right)
  {
    this.parentRight = right;
  }
  
  public Set<Right> getChildRightSet()
  {
    return this.childRightSet;
  }
  
  public void setChildRightSet(Set<Right> rightSet)
  {
    this.childRightSet = rightSet;
  }
  
  public Set<Broker> getBrokerSet()
  {
    return this.brokerSet;
  }
  
  public void setBrokerSet(Set<Broker> brokerSet)
  {
    this.brokerSet = brokerSet;
  }
  
  public LogCatalog getLogCatalog()
  {
    return this.logCatalog;
  }
  
  public void setLogCatalog(LogCatalog logCatalog)
  {
    this.logCatalog = logCatalog;
  }
  
  public String getIsWriteLog()
  {
    return this.isWriteLog;
  }
  
  public void setIsWriteLog(String isWriteLog)
  {
    this.isWriteLog = isWriteLog;
  }
  
  public String getOnlyMember()
  {
    return this.onlyMember;
  }
  
  public void setOnlyMember(String onlyMember)
  {
    this.onlyMember = onlyMember;
  }
  
  public boolean equals(Object o)
  {
    boolean sign = true;
    Right r = this;
    if ((o instanceof Right))
    {
      Right r1 = (Right)o;
      if ((r.getId() != r1.getId()) || (!r.getUrl().equals(r1.getUrl()))) {
        sign = false;
      }
    }
    else
    {
      sign = false;
    }
    return sign;
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return new StandardModel.PrimaryInfo(  "id", this.id);
  }
}
