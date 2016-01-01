package gnnt.MEBS.vendue.mgr.model.firmSet.tradeUser;

import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.mgr.model.translate.ClassDiscription;

public class FirmFunds
  extends StandardModel
{
  private static final long serialVersionUID = 1L;
  @ClassDiscription(name="交易商ID", description="")
  private String FirmID;
  @ClassDiscription(name="资金余额", description="")
  private double Balance;
  @ClassDiscription(name="冻结资金", description="")
  private double FrozenFunds;
  @ClassDiscription(name="最近结算余额", description="")
  private double LastBalance;
  @ClassDiscription(name="最近结算担保金", description="")
  private double LastWarranty;
  @ClassDiscription(name="交收保证金", description="")
  private double SettleMargin;
  @ClassDiscription(name="上日交收保证金", description="")
  private double LastSettleMargin;
  @ClassDiscription(name="关联竞价系统交易商", description="")
  private TradeUserModel tradeUser;
  
  public String getFirmID()
  {
    return this.FirmID;
  }
  
  public void setFirmID(String paramString)
  {
    this.FirmID = paramString;
  }
  
  public double getBalance()
  {
    return this.Balance;
  }
  
  public void setBalance(double paramDouble)
  {
    this.Balance = paramDouble;
  }
  
  public double getFrozenFunds()
  {
    return this.FrozenFunds;
  }
  
  public void setFrozenFunds(double paramDouble)
  {
    this.FrozenFunds = paramDouble;
  }
  
  public double getLastBalance()
  {
    return this.LastBalance;
  }
  
  public void setLastBalance(double paramDouble)
  {
    this.LastBalance = paramDouble;
  }
  
  public double getLastWarranty()
  {
    return this.LastWarranty;
  }
  
  public void setLastWarranty(double paramDouble)
  {
    this.LastWarranty = paramDouble;
  }
  
  public double getSettleMargin()
  {
    return this.SettleMargin;
  }
  
  public void setSettleMargin(double paramDouble)
  {
    this.SettleMargin = paramDouble;
  }
  
  public double getLastSettleMargin()
  {
    return this.LastSettleMargin;
  }
  
  public void setLastSettleMargin(double paramDouble)
  {
    this.LastSettleMargin = paramDouble;
  }
  
  public TradeUserModel getTradeUser()
  {
    return this.tradeUser;
  }
  
  public void setTradeUser(TradeUserModel paramTradeUserModel)
  {
    this.tradeUser = paramTradeUserModel;
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return new StandardModel.PrimaryInfo("FirmID", this.FirmID);
  }
}
