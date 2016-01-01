package gnnt.MEBS.espot.mgr.model.fundmanage;

import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.mgr.model.translate.ClassDiscription;
import gnnt.MEBS.espot.mgr.model.firmmanage.MFirm;

public class FirmFunds
  extends StandardModel
{
  private static final long serialVersionUID = 949449448813353691L;
  @ClassDiscription(name="交易商代码", description="")
  private String firmId;
  @ClassDiscription(name="保证金", description="")
  private Double margin;
  @ClassDiscription(name="占用贷款", description="")
  private Double goodsMoney;
  @ClassDiscription(name="转让盈亏", description="")
  private Double transferLoss;
  @ClassDiscription(name="诚信保障金", description="")
  private Double subScription;
  @ClassDiscription(name="关联现货交易商", description="对应交易商代码")
  private MFirm firm;
  
  public MFirm getFirm()
  {
    return this.firm;
  }
  
  public void setFirm(MFirm paramMFirm)
  {
    this.firm = paramMFirm;
  }
  
  public String getFirmId()
  {
    return this.firmId;
  }
  
  public void setFirmId(String paramString)
  {
    this.firmId = paramString;
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
  
  public Double getSubScription()
  {
    return this.subScription;
  }
  
  public void setSubScription(Double paramDouble)
  {
    this.subScription = paramDouble;
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return new StandardModel.PrimaryInfo("firmId", this.firmId);
  }
}
