package gnnt.MEBS.common.front.model.integrated;

import gnnt.MEBS.common.front.model.StandardModel;
import gnnt.MEBS.common.front.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.front.model.translate.ClassDiscription;

public class TraderModule
  extends StandardModel
{
  private static final long serialVersionUID = -8054488919579229963L;
  @ClassDiscription(name="模块号", description="")
  private Integer moduleID;
  @ClassDiscription(name="交易员", description="")
  private User user;
  @ClassDiscription(name="是否启用", description="是否启用： Y：启用 Ｎ：禁用")
  private String enabled;
  
  public Integer getModuleID()
  {
    return this.moduleID;
  }
  
  public void setModuleID(Integer moduleID)
  {
    this.moduleID = moduleID;
  }
  
  public User getUser()
  {
    return this.user;
  }
  
  public void setUser(User user)
  {
    this.user = user;
  }
  
  public String getEnabled()
  {
    return this.enabled;
  }
  
  public void setEnabled(String enabled)
  {
    this.enabled = enabled;
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return null;
  }
}
