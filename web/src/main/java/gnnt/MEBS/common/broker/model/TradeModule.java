package gnnt.MEBS.common.broker.model;

public class TradeModule
  extends StandardModel
{
  private static final long serialVersionUID = -3662370087483814027L;
  private Integer moduleId;
  private String cnName;
  private String enName;
  private String shortName;
  private String addFirmFn;
  private String updateFirmStatusFn;
  private String delFirmFn;
  private String isFirmSet;
  
  public Integer getModuleId()
  {
    return this.moduleId;
  }
  
  public void setModuleId(Integer moduleId)
  {
    this.moduleId = moduleId;
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
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return new StandardModel.PrimaryInfo(  "moduleId", this.moduleId);
  }
}
