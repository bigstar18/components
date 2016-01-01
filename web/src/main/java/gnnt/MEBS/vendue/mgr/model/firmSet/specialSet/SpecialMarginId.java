package gnnt.MEBS.vendue.mgr.model.firmSet.specialSet;

import gnnt.MEBS.common.mgr.model.translate.ClassDiscription;
import java.io.Serializable;

public class SpecialMarginId
  implements Serializable
{
  private static final long serialVersionUID = 8563595154961212240L;
  @ClassDiscription(name="交易商代码", description="")
  private String userCode;
  @ClassDiscription(name="品种ID", description="")
  private Integer breedId;
  @ClassDiscription(name="买卖方向", description="")
  private Byte bs_flag;
  
  public String getUserCode()
  {
    return this.userCode;
  }
  
  public void setUserCode(String paramString)
  {
    this.userCode = paramString;
  }
  
  public Integer getBreedId()
  {
    return this.breedId;
  }
  
  public void setBreedId(Integer paramInteger)
  {
    this.breedId = paramInteger;
  }
  
  public Byte getBs_flag()
  {
    return this.bs_flag;
  }
  
  public void setBs_flag(Byte paramByte)
  {
    this.bs_flag = paramByte;
  }
}
