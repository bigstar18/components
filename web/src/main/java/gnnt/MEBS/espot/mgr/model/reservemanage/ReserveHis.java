package gnnt.MEBS.espot.mgr.model.reservemanage;

import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.mgr.model.translate.ClassDiscription;
import gnnt.MEBS.espot.mgr.model.trademanage.TradeContractHis;
import java.util.Date;

public class ReserveHis
  extends StandardModel
{
  private static final long serialVersionUID = 8582863542811431645L;
  @ClassDiscription(name="订单号", description="")
  private Long reserveId;
  @ClassDiscription(name="关联合同", description="对应合同号")
  private TradeContractHis tradeContract;
  @ClassDiscription(name="交易商代码", description="")
  private String firmId;
  @ClassDiscription(name="实际占用资金", description="")
  private Double realMoney;
  @ClassDiscription(name="买卖方向", description="买卖方向B：买 S：卖")
  private String bSFlag;
  @ClassDiscription(name="应付准备金", description="")
  private Double payableReserve;
  @ClassDiscription(name="已付准备金", description="")
  private Double payReserve;
  @ClassDiscription(name="清退准备金", description="")
  private Double backReserve;
  @ClassDiscription(name="仓库对应的货物数量", description="")
  private Double goodsQuantity;
  @ClassDiscription(name="订单状态", description="订单状态0：正常 1：货到或款到 2：已成交3：自己违约 4：对方违约")
  private Integer status;
  @ClassDiscription(name="违约申请号", description="")
  private Integer breachApplyId;
  
  public Long getReserveId()
  {
    return this.reserveId;
  }
  
  public void setReserveId(Long paramLong)
  {
    this.reserveId = paramLong;
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
  
  public Double getRealMoney()
  {
    return this.realMoney;
  }
  
  public void setRealMoney(Double paramDouble)
  {
    this.realMoney = paramDouble;
  }
  
  public String getbSFlag()
  {
    return this.bSFlag;
  }
  
  public void setbSFlag(String paramString)
  {
    this.bSFlag = paramString;
  }
  
  public Double getPayableReserve()
  {
    return this.payableReserve;
  }
  
  public void setPayableReserve(Double paramDouble)
  {
    this.payableReserve = paramDouble;
  }
  
  public Double getPayReserve()
  {
    return this.payReserve;
  }
  
  public void setPayReserve(Double paramDouble)
  {
    this.payReserve = paramDouble;
  }
  
  public Double getBackReserve()
  {
    return this.backReserve;
  }
  
  public void setBackReserve(Double paramDouble)
  {
    this.backReserve = paramDouble;
  }
  
  public Double getGoodsQuantity()
  {
    return this.goodsQuantity;
  }
  
  public void setGoodsQuantity(Double paramDouble)
  {
    this.goodsQuantity = paramDouble;
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
  
  public Date getValidTime()
  {
    Date localDate = null;
    localDate = getTradeContract().getTime();
    localDate.setDate(localDate.getDate() + getTradeContract().getTradePreTime().intValue());
    return localDate;
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return new StandardModel.PrimaryInfo("reserveId", this.reserveId);
  }
}
