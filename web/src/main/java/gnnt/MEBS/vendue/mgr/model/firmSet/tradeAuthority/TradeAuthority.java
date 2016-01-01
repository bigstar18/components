package gnnt.MEBS.vendue.mgr.model.firmSet.tradeAuthority;

import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.mgr.model.translate.ClassDiscription;
import java.util.Date;

public class TradeAuthority
  extends StandardModel
{
  private static final long serialVersionUID = 1L;
  @ClassDiscription(name="关联交易权限主键", description="")
  private TradeAuthorityKey key;
  @ClassDiscription(name="修改时间", description="")
  private Date ModifTime = new Date();
  
  public Date getModifTime()
  {
    return this.ModifTime;
  }
  
  public void setModifTime(Date paramDate)
  {
    this.ModifTime = paramDate;
  }
  
  public TradeAuthorityKey getKey()
  {
    return this.key;
  }
  
  public void setKey(TradeAuthorityKey paramTradeAuthorityKey)
  {
    this.key = paramTradeAuthorityKey;
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return new StandardModel.PrimaryInfo("key", this.key);
  }
}
