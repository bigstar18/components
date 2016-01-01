package gnnt.MEBS.common.front.model;

import gnnt.MEBS.common.front.model.translate.ClassDiscription;

public class TradeModule
  extends StandardModel
{
  private static final long serialVersionUID = 986212660584678601L;
  @ClassDiscription(name="交易模块ID", description="")
  private Integer moduleID;
  @ClassDiscription(name="交易模块中文名称", description="")
  private String cnName;
  @ClassDiscription(name="交易模块英文简称", description="")
  private String enName;
  @ClassDiscription(name="交易模块简称", description="")
  private String shortName;
  @ClassDiscription(name="添加交易商函数 ", description="")
  private String addFirmFn;
  @ClassDiscription(name="修改交易商状态函数", description="")
  private String updateFirmStatusFn;
  @ClassDiscription(name="删除交易商函数", description="")
  private String delFirmFn;
  @ClassDiscription(name="是否用于交易商设置", description="是否用于交易商设置 Y：是 N：否 ")
  private String isFirmSet;
  @ClassDiscription(name="是否需要综合系统增加商品", description="是否需要综合系统增加商品： 需要 N：不需要")
  private String isNeedBreed;
  
  public Integer getModuleID()
  {
    return this.moduleID;
  }
  
  public void setModuleID(Integer moduleID)
  {
    this.moduleID = moduleID;
  }
  
  public String getCnName()
  {
    return this.cnName;
  }
  
  public void setCnName(String cnName)
  {
    this.cnName = cnName;
  }
  
  public String getEnName()
  {
    return this.enName;
  }
  
  public void setEnName(String enName)
  {
    this.enName = enName;
  }
  
  public String getShortName()
  {
    return this.shortName;
  }
  
  public void setShortName(String shortName)
  {
    this.shortName = shortName;
  }
  
  public String getAddFirmFn()
  {
    return this.addFirmFn;
  }
  
  public void setAddFirmFn(String addFirmFn)
  {
    this.addFirmFn = addFirmFn;
  }
  
  public String getUpdateFirmStatusFn()
  {
    return this.updateFirmStatusFn;
  }
  
  public void setUpdateFirmStatusFn(String updateFirmStatusFn)
  {
    this.updateFirmStatusFn = updateFirmStatusFn;
  }
  
  public String getDelFirmFn()
  {
    return this.delFirmFn;
  }
  
  public void setDelFirmFn(String delFirmFn)
  {
    this.delFirmFn = delFirmFn;
  }
  
  public String getIsFirmSet()
  {
    return this.isFirmSet;
  }
  
  public void setIsFirmSet(String isFirmSet)
  {
    this.isFirmSet = isFirmSet;
  }
  
  public String getIsNeedBreed()
  {
    return this.isNeedBreed;
  }
  
  public void setIsNeedBreed(String isNeedBreed)
  {
    this.isNeedBreed = isNeedBreed;
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return new StandardModel.PrimaryInfo(  "moduleID", this.moduleID);
  }
}
