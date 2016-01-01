package gnnt.MEBS.espot.front.model.trade;

import gnnt.MEBS.common.front.model.StandardModel;
import gnnt.MEBS.common.front.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.front.model.translate.ClassDiscription;

public class TradeRight
  extends StandardModel
{
  private static final long serialVersionUID = -3693598025240719455L;
  @ClassDiscription(name="特殊权限ID", description="")
  private Long tradeRightID;
  @ClassDiscription(name="交易商代码", description="")
  private String firmID;
  @ClassDiscription(name="买委托", description="买委托  0：无权 1：有权")
  private Integer buyOrder;
  @ClassDiscription(name="卖委托", description="卖委托  0：无权 1：有权")
  private Integer sellOrder;
  @ClassDiscription(name="买摘牌", description="买摘牌 0：无权 1：有权")
  private Integer buyPick;
  @ClassDiscription(name="卖摘牌", description="卖摘牌0：无权 1：有权")
  private Integer sellPick;
  @ClassDiscription(name="不允许摘牌 ", description="不允许摘牌0：无权 1：有权 ")
  private Integer isPickoff;
  
  public Long getTradeRightID()
  {
    return this.tradeRightID;
  }
  
  public void setTradeRightID(Long paramLong)
  {
    this.tradeRightID = paramLong;
  }
  
  public String getFirmID()
  {
    return this.firmID;
  }
  
  public void setFirmID(String paramString)
  {
    this.firmID = paramString;
  }
  
  public Integer getBuyOrder()
  {
    return this.buyOrder;
  }
  
  public void setBuyOrder(Integer paramInteger)
  {
    this.buyOrder = paramInteger;
  }
  
  public Integer getSellOrder()
  {
    return this.sellOrder;
  }
  
  public void setSellOrder(Integer paramInteger)
  {
    this.sellOrder = paramInteger;
  }
  
  public Integer getBuyPick()
  {
    return this.buyPick;
  }
  
  public void setBuyPick(Integer paramInteger)
  {
    this.buyPick = paramInteger;
  }
  
  public Integer getSellPick()
  {
    return this.sellPick;
  }
  
  public void setSellPick(Integer paramInteger)
  {
    this.sellPick = paramInteger;
  }
  
  public Integer getIsPickoff()
  {
    return this.isPickoff;
  }
  
  public void setIsPickoff(Integer paramInteger)
  {
    this.isPickoff = paramInteger;
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return new StandardModel.PrimaryInfo("tradeRightID", this.tradeRightID);
  }
}
