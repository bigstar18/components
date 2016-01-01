package gnnt.MEBS.common.front.model.front;

import gnnt.MEBS.common.front.model.LogCatalog;
import gnnt.MEBS.common.front.model.StandardModel;
import gnnt.MEBS.common.front.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.front.model.translate.ClassDiscription;
import java.util.HashSet;
import java.util.Set;

public class Right
  extends StandardModel
{
  private static final long serialVersionUID = -4426226027751923168L;
  @ClassDiscription(name="权限代码", description="")
  private Long id;
  @ClassDiscription(name="权限名称", description="")
  private String name;
  @ClassDiscription(name="权限使用的图标", description="")
  private String icon;
  @ClassDiscription(name="对应的权限路径", description="")
  private String url;
  @ClassDiscription(name="对应的资源路径", description="")
  private String visiturl;
  @ClassDiscription(name="所属模块号", description="")
  private Integer moduleID;
  @ClassDiscription(name="是否可见 ", description="是否可见：0：可见、 其他：不可见 ")
  private Integer visible;
  @ClassDiscription(name="序号", description="用于属于同一类型的菜单排序")
  private Integer seq;
  @ClassDiscription(name="权限类型", description="权限类型：-3：只检查session不检查权限的url -2：无需判断权限的URL -1： 父菜单类型 0：子菜单类型   1：页面内增删改查权限")
  private Integer type;
  @ClassDiscription(name="当前权限所拥有的子权限集合", description="")
  private Set<Right> childRightSet = new HashSet();
  @ClassDiscription(name="父权限", description="")
  private Right parentRight;
  @ClassDiscription(name="日志对应的分类", description="")
  private LogCatalog logCatalog;
  @ClassDiscription(name="是否自动写日志", description="是否自动写日志 Y：写日志 N：不写日志")
  private String isWriteLog;
  
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
  
  public Integer getModuleID()
  {
    return this.moduleID;
  }
  
  public void setModuleID(Integer moduleID)
  {
    this.moduleID = moduleID;
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
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return new StandardModel.PrimaryInfo(  "id", this.id);
  }
}
