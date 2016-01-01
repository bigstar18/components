package gnnt.MEBS.vendue.mgr.model.firmSet.tradeAuthority;

import gnnt.MEBS.common.mgr.model.translate.ClassDiscription;
import java.io.Serializable;

public class TradeAuthorityKey
  implements Serializable
{
  private static final long serialVersionUID = 1L;
  @ClassDiscription(name="标的号", description="")
  private String code;
  @ClassDiscription(name="交易商代码", description="")
  private String userCode;
  
  public String getCode()
  {
    return this.code;
  }
  
  public void setCode(String paramString)
  {
    this.code = paramString;
  }
  
  public String getUserCode()
  {
    return this.userCode;
  }
  
  public void setUserCode(String paramString)
  {
    this.userCode = paramString;
  }
}
