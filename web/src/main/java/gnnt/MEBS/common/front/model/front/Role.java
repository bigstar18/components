package gnnt.MEBS.common.front.model.front;

import gnnt.MEBS.common.front.model.StandardModel;
import gnnt.MEBS.common.front.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.front.model.translate.ClassDiscription;
import java.util.Set;

public class Role
  extends StandardModel
{
  private static final long serialVersionUID = 377527086315861256L;
  @ClassDiscription(name="角色代码", description="")
  private Long id;
  @ClassDiscription(name="角色名称", description="")
  private String name;
  @ClassDiscription(name="角色描述", description="")
  private String description;
  @ClassDiscription(name="获取角色拥有的权限集合", description="")
  private Set<Right> rightSet;
  
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
  
  public String getDescription()
  {
    return this.description;
  }
  
  public void setDescription(String description)
  {
    this.description = description;
  }
  
  public Set<Right> getRightSet()
  {
    return this.rightSet;
  }
  
  public void setRightSet(Set<Right> rightSet)
  {
    this.rightSet = rightSet;
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return new StandardModel.PrimaryInfo(  "id", this.id);
  }
}
