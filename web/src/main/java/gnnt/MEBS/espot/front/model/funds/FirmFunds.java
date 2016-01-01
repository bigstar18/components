package gnnt.MEBS.espot.front.model.funds;

import gnnt.MEBS.common.front.model.StandardModel;
import gnnt.MEBS.common.front.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.front.model.integrated.MFirm;
import gnnt.MEBS.common.front.model.translate.ClassDiscription;

public class FirmFunds
  extends StandardModel
{
  private static final long serialVersionUID = 8656472400394401452L;
  @ClassDiscription(name="交易商代码", description="")
  private String firmID;
  @ClassDiscription(name="资金余额", description="")
  private Double balance;
  @ClassDiscription(name="冻结资金", description="")
  private Double frozenFunds;
  @ClassDiscription(name="最近结算余额", description="")
  private Double lastBalance;
  @ClassDiscription(name="最近结算担保金", description="")
  private Double lastWarranty;
  @ClassDiscription(name="履约保证金", description="")
  private Double settleMargin;
  @ClassDiscription(name="上日履约保证金", description="")
  private Double lastSettleMargin;
  @ClassDiscription(name="所属交易商", description="")
  private MFirm belongtoFirm;
  
  public String getFirmID()
  {
    return this.firmID;
  }
  
  public void setFirmID(String paramString)
  {
    this.firmID = paramString;
  }
  
  public Double getBalance()
  {
    return this.balance;
  }
  
  public void setBalance(Double paramDouble)
  {
    this.balance = paramDouble;
  }
  
  public Double getFrozenFunds()
  {
    return this.frozenFunds;
  }
  
  public void setFrozenFunds(Double paramDouble)
  {
    this.frozenFunds = paramDouble;
  }
  
  public Double getLastBalance()
  {
    return this.lastBalance;
  }
  
  public void setLastBalance(Double paramDouble)
  {
    this.lastBalance = paramDouble;
  }
  
  public Double getLastWarranty()
  {
    return this.lastWarranty;
  }
  
  public void setLastWarranty(Double paramDouble)
  {
    this.lastWarranty = paramDouble;
  }
  
  public Double getSettleMargin()
  {
    return this.settleMargin;
  }
  
  public void setSettleMargin(Double paramDouble)
  {
    this.settleMargin = paramDouble;
  }
  
  public Double getLastSettleMargin()
  {
    return this.lastSettleMargin;
  }
  
  public void setLastSettleMargin(Double paramDouble)
  {
    this.lastSettleMargin = paramDouble;
  }
  
  public MFirm getBelongtoFirm()
  {
    return this.belongtoFirm;
  }
  
  public void setBelongtoFirm(MFirm paramMFirm)
  {
    this.belongtoFirm = paramMFirm;
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return new StandardModel.PrimaryInfo("firmID", this.firmID);
  }
}
