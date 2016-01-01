package gnnt.MEBS.espot.front.model.trade;

import gnnt.MEBS.common.front.model.StandardModel;
import gnnt.MEBS.common.front.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.front.model.translate.ClassDiscription;

public class ReserveBase
  extends StandardModel
{
  private static final long serialVersionUID = 2847206621652605777L;
  @ClassDiscription(name="订单号", description="")
  private Long reserveID;
  @ClassDiscription(name="交易商代码", description="")
  private String firmID;
  @ClassDiscription(name="实际占用资金", description="")
  private Double realMoney;
  @ClassDiscription(name="买卖方向", description="买卖方向 B：买 S：卖")
  private String bsFlag;
  @ClassDiscription(name="应付履约保证金", description="")
  private Double payableReserve;
  @ClassDiscription(name="已付履约保证金", description="")
  private Double payReserve;
  @ClassDiscription(name="清退履约保证金", description="")
  private Double backReserve;
  @ClassDiscription(name="仓单对应货物数量", description="")
  private Double goodsQuantity;
  @ClassDiscription(name="订单状态", description="订单状态 0：正常 1：货到或款到 2：已成交3：违约")
  private Integer status;
  @ClassDiscription(name="违约申请号", description="")
  private Long breachApplyID;
  
  public Long getReserveID()
  {
    return this.reserveID;
  }
  
  public void setReserveID(Long paramLong)
  {
    this.reserveID = paramLong;
  }
  
  public String getFirmID()
  {
    return this.firmID;
  }
  
  public void setFirmID(String paramString)
  {
    this.firmID = paramString;
  }
  
  public Double getRealMoney()
  {
    return this.realMoney;
  }
  
  public void setRealMoney(Double paramDouble)
  {
    this.realMoney = paramDouble;
  }
  
  public String getBsFlag()
  {
    return this.bsFlag;
  }
  
  public void setBsFlag(String paramString)
  {
    this.bsFlag = paramString;
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
  
  public Long getBreachApplyID()
  {
    return this.breachApplyID;
  }
  
  public void setBreachApplyID(Long paramLong)
  {
    this.breachApplyID = paramLong;
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return new StandardModel.PrimaryInfo("reserveID", this.reserveID);
  }
}
