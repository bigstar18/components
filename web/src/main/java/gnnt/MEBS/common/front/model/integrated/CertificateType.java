package gnnt.MEBS.common.front.model.integrated;

import gnnt.MEBS.common.front.model.StandardModel;
import gnnt.MEBS.common.front.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.front.model.translate.ClassDiscription;

public class CertificateType
  extends StandardModel
{
  private static final long serialVersionUID = -5164424968558888161L;
  @ClassDiscription(name="证件类型编码", description="")
  private String code;
  @ClassDiscription(name="证件名称", description="")
  private String name;
  @ClassDiscription(name="是否显示", description="是否显示：Y：显示 N：不显示")
  private String isvisibal;
  @ClassDiscription(name="排序号", description="")
  private Integer sortNo;
  
  public String getCode()
  {
    return this.code;
  }
  
  public void setCode(String code)
  {
    this.code = code;
  }
  
  public String getName()
  {
    return this.name;
  }
  
  public void setName(String name)
  {
    this.name = name;
  }
  
  public String getIsvisibal()
  {
    return this.isvisibal;
  }
  
  public void setIsvisibal(String isvisibal)
  {
    this.isvisibal = isvisibal;
  }
  
  public Integer getSortNo()
  {
    return this.sortNo;
  }
  
  public void setSortNo(Integer sortNo)
  {
    this.sortNo = sortNo;
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return new StandardModel.PrimaryInfo(  "code", this.code);
  }
}
