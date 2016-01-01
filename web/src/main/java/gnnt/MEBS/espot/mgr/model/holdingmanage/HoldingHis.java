package gnnt.MEBS.espot.mgr.model.holdingmanage;

import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.mgr.model.translate.ClassDiscription;
import gnnt.MEBS.espot.mgr.model.trademanage.TradeContractHis;

public class HoldingHis
  extends StandardModel
{
  private static final long serialVersionUID = 1L;
  @ClassDiscription(name="持仓号", description="")
  private Long holdingId;
  @ClassDiscription(name="关联合同 ", description="对应合同号")
  private TradeContractHis tradeContract;
  @ClassDiscription(name="交易商ID", description="")
  private String firmId;
  @ClassDiscription(name="买卖方向", description="买卖方向 B：买方 S：卖方")
  private String bSFlag;
  @ClassDiscription(name="实际占用资金", description="")
  private Double realMoney;
  @ClassDiscription(name="实收交易保证金", description="")
  private Double payMargin;
  @ClassDiscription(name="转入货/款", description="如果买方则为转入货款/如果是卖方则为转入货物数量")
  private Double payGoodsMoney;
  @ClassDiscription(name="已付货/款 ", description="如果是买方则为已支付货款/如果是卖方则为已支付货物数量")
  private Double payOff;
  @ClassDiscription(name="转出货/款", description="")
  private Double transferMoney;
  @ClassDiscription(name="已收货/款", description="如果是买方则为已收货物数量/如果是卖方则为已收金额")
  private Double receive;
  @ClassDiscription(name="持仓状态", description="持仓状态 1:正常 2：或款到或者货到 3：交割   4:自己违约 5 对方违约")
  private Integer status;
  @ClassDiscription(name="违约申请号", description="")
  private Integer breachApplyId;
  @ClassDiscription(name="溢短货款申请ID", description="")
  private Integer offSetId;
  
  public Long getHoldingId()
  {
    return this.holdingId;
  }
  
  public void setHoldingId(Long paramLong)
  {
    this.holdingId = paramLong;
  }
  
  public TradeContractHis getTradeContract()
  {
    return this.tradeContract;
  }
  
  public void setTradeContract(TradeContractHis paramTradeContractHis)
  {
    this.tradeContract = paramTradeContractHis;
  }
  
  public String getFirmId()
  {
    return this.firmId;
  }
  
  public void setFirmId(String paramString)
  {
    this.firmId = paramString;
  }
  
  public String getbSFlag()
  {
    return this.bSFlag;
  }
  
  public void setbSFlag(String paramString)
  {
    this.bSFlag = paramString;
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
  
  public Double getPayOff()
  {
    return this.payOff;
  }
  
  public void setPayOff(Double paramDouble)
  {
    this.payOff = paramDouble;
  }
  
  public Double getTransferMoney()
  {
    return this.transferMoney;
  }
  
  public void setTransferMoney(Double paramDouble)
  {
    this.transferMoney = paramDouble;
  }
  
  public Double getReceive()
  {
    return this.receive;
  }
  
  public void setReceive(Double paramDouble)
  {
    this.receive = paramDouble;
  }
  
  public Integer getStatus()
  {
    return this.status;
  }
  
  public void setStatus(Integer paramInteger)
  {
    this.status = paramInteger;
  }
  
  public Integer getBreachApplyId()
  {
    return this.breachApplyId;
  }
  
  public void setBreachApplyId(Integer paramInteger)
  {
    this.breachApplyId = paramInteger;
  }
  
  public Integer getOffSetId()
  {
    return this.offSetId;
  }
  
  public void setOffSetId(Integer paramInteger)
  {
    this.offSetId = paramInteger;
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return new StandardModel.PrimaryInfo("holdingId", this.holdingId);
  }
}
