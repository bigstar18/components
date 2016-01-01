package gnnt.MEBS.common.broker.model;

import java.util.Set;

public class Menu
  extends StandardModel
{
  private static final long serialVersionUID = 2430870130134342514L;
  private Long id;
  private String name;
  private String icon;
  private String url;
  private Integer moduleId;
  private Integer visible;
  private Integer seq;
  private Long parentID;
  private Menu parentMenu;
  private Set<Menu> childMenuSet;
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
  
  public String getOnlyMember()
  {
    return this.onlyMember;
  }
  
  public void setOnlyMember(String onlyMember)
  {
    this.onlyMember = onlyMember;
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return new StandardModel.PrimaryInfo(  "id", this.id);
  }
}
