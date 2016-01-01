package gnnt.MEBS.espot.front.model.funds;

import gnnt.MEBS.common.front.model.StandardModel;
import gnnt.MEBS.common.front.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.front.model.integrated.MFirm;
import gnnt.MEBS.common.front.model.translate.ClassDiscription;

public class Funds
  extends StandardModel
{
  private static final long serialVersionUID = -5884824287078647961L;
  @ClassDiscription(name="交易商代码", description="")
  private String firmID;
  @ClassDiscription(name="所属交易商", description="")
  private MFirm belongtoFirm;
  @ClassDiscription(name="保证金", description="")
  private Double margin;
  @ClassDiscription(name="占用货款", description="")
  private Double goodsMoney;
  @ClassDiscription(name="转让盈亏", description="")
  private Double transferLoss;
  @ClassDiscription(name="诚信保障金", description="")
  private Double subscription;
  
  public String getFirmID()
  {
    return this.firmID;
  }
  
  public void setFirmID(String paramString)
  {
    this.firmID = paramString;
  }
  
  public MFirm getBelongtoFirm()
  {
    return this.belongtoFirm;
  }
  
  public void setBelongtoFirm(MFirm paramMFirm)
  {
    this.belongtoFirm = paramMFirm;
  }
  
  public Double getMargin()
  {
    return this.margin;
  }
  
  public void setMargin(Double paramDouble)
  {
    this.margin = paramDouble;
  }
  
  public Double getGoodsMoney()
  {
    return this.goodsMoney;
  }
  
  public void setGoodsMoney(Double paramDouble)
  {
    this.goodsMoney = paramDouble;
  }
  
  public Double getTransferLoss()
  {
    return this.transferLoss;
  }
  
  public void setTransferLoss(Double paramDouble)
  {
    this.transferLoss = paramDouble;
  }
  
  public Double getSubscription()
  {
    return this.subscription;
  }
  
  public void setSubscription(Double paramDouble)
  {
    this.subscription = paramDouble;
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return new StandardModel.PrimaryInfo("firmID", this.firmID);
  }
}
