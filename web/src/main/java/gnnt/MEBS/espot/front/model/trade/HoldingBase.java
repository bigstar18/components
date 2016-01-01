package gnnt.MEBS.espot.front.model.trade;

import gnnt.MEBS.common.front.model.StandardModel;
import gnnt.MEBS.common.front.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.front.model.translate.ClassDiscription;

public class HoldingBase
  extends StandardModel
{
  private static final long serialVersionUID = -6872210545006444554L;
  @ClassDiscription(name="持仓号", description="")
  private Long holdingID;
  @ClassDiscription(name="交易商代码", description="")
  private String firmID;
  @ClassDiscription(name="买卖方向", description="买卖方向 B：买 S：卖")
  private String bsFlag;
  @ClassDiscription(name="实际占用资金", description="")
  private Double realMoney;
  @ClassDiscription(name="实收诚信保障金", description="")
  private Double payMargin;
  @ClassDiscription(name="转入货/款", description="")
  private Double payGoodsMoney;
  @ClassDiscription(name="已付货/款", description="")
  private Double payoff;
  @ClassDiscription(name="已收货/款", description="")
  private Double receive;
  @ClassDiscription(name="转出货款", description="")
  private Double transferMoney;
  @ClassDiscription(name="持仓状态", description="持仓状态 1:正常 2：或款到或者货到 3：交割   4:违约")
  private Integer status;
  @ClassDiscription(name="违约申请ID", description="")
  private Long breachApplyID;
  @ClassDiscription(name="溢短货款申请ID", description="")
  private Long offsetID;
  
  public Long getHoldingID()
  {
    return this.holdingID;
  }
  
  public void setHoldingID(Long paramLong)
  {
    this.holdingID = paramLong;
  }
  
  public String getFirmID()
  {
    return this.firmID;
  }
  
  public void setFirmID(String paramString)
  {
    this.firmID = paramString;
  }
  
  public String getBsFlag()
  {
    return this.bsFlag;
  }
  
  public void setBsFlag(String paramString)
  {
    this.bsFlag = paramString;
  }
  
  public Double getRealMoney()
  {
    return this.realMoney;
  }
  
  public void setRealMoney(Double paramDouble)
  {
    this.realMoney = paramDouble;
  }
  
  public Double getPayMargin()
  {
    return this.payMargin;
  }
  
  public void setPayMargin(Double paramDouble)
  {
    this.payMargin = paramDouble;
  }
  
  public Double getPayGoodsMoney()
  {
    return this.payGoodsMoney;
  }
  
  public void setPayGoodsMoney(Double paramDouble)
  {
    this.payGoodsMoney = paramDouble;
  }
  
  public Double getPayoff()
  {
    return this.payoff;
  }
  
  public void setPayoff(Double paramDouble)
  {
    this.payoff = paramDouble;
  }
  
  public Double getReceive()
  {
    return this.receive;
  }
  
  public void setReceive(Double paramDouble)
  {
    this.receive = paramDouble;
  }
  
  public Double getTransferMoney()
  {
    return this.transferMoney;
  }
  
  public void setTransferMoney(Double paramDouble)
  {
    this.transferMoney = paramDouble;
  }
  
  public Integer getStatus()
  {
    return this.status;
  }
  
  public void setStatus(Integer paramInteger)
  {
    this.status = paramInteger;
  }
  
  public Long getBreachApplyID()
  {
    return this.breachApplyID;
  }
  
  public void setBreachApplyID(Long paramLong)
  {
    this.breachApplyID = paramLong;
  }
  
  public Long getOffsetID()
  {
    return this.offsetID;
  }
  
  public void setOffsetID(Long paramLong)
  {
    this.offsetID = paramLong;
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return new StandardModel.PrimaryInfo("holdingID", this.holdingID);
  }
}
