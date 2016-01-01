package gnnt.MEBS.common.front.model.front;

import gnnt.MEBS.common.front.model.StandardModel;
import gnnt.MEBS.common.front.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.front.model.translate.ClassDiscription;
import java.util.Set;

public class Menu
  extends StandardModel
{
  private static final long serialVersionUID = 2430870130134342514L;
  @ClassDiscription(name="菜单代码", description="")
  private Long id;
  @ClassDiscription(name="菜单名称", description="")
  private String name;
  @ClassDiscription(name="菜单图标", description="")
  private String icon;
  @ClassDiscription(name="菜单对应的url地址", description="")
  private String url;
  @ClassDiscription(name="模块代码", description="")
  private Integer moduleId;
  @ClassDiscription(name="是否可见 ", description="是否：可见 0：可见  其他：不可见")
  private Integer visible;
  @ClassDiscription(name="序号", description=" 用于属于同一类型的菜单排序")
  private Integer seq;
  @ClassDiscription(name="父菜单ID", description="")
  private Long parentID;
  @ClassDiscription(name="父菜单", description="")
  private Menu parentMenu;
  @ClassDiscription(name="子菜单集合", description="")
  private Set<Menu> childMenuSet;
  
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
  
  public Set<Menu> getChildMenuSet()
  {
    return this.childMenuSet;
  }
  
  public void setChildMenuSet(Set<Menu> childMenuSet)
  {
    this.childMenuSet = childMenuSet;
  }
  
  public Long getParentID()
  {
    return this.parentID;
  }
  
  public void setParentID(Long parentID)
  {
    this.parentID = parentID;
  }
  
  public Menu getParentMenu()
  {
    return this.parentMenu;
  }
  
  public void setParentMenu(Menu menu)
  {
    this.parentMenu = menu;
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return new StandardModel.PrimaryInfo(  "id", this.id);
  }
}
