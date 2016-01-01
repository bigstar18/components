package gnnt.MEBS.espot.mgr.model.parametermanage;

import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.mgr.model.translate.ClassDiscription;
import gnnt.MEBS.espot.mgr.model.firmmanage.MFirm;

public class TradeRight
  extends StandardModel
{
  private static final long serialVersionUID = 1L;
  @ClassDiscription(name="权限Id", description="")
  private Long tradeRightId;
  @ClassDiscription(name="交易商", description="对应交易商代码")
  private MFirm firm;
  @ClassDiscription(name="买挂牌权限", description="")
  private Integer buyOrder;
  @ClassDiscription(name="卖挂牌权限", description="")
  private Integer sellOrder;
  @ClassDiscription(name="买摘牌权限", description="")
  private Integer buyPick;
  @ClassDiscription(name="卖摘牌权限", description="")
  private Integer sellPick;
  @ClassDiscription(name="买挂牌审核权限", description="")
  private Integer buyOrderAudit;
  @ClassDiscription(name="卖挂牌审核权限", description="")
  private Integer sellOrderAudit;
  @ClassDiscription(name="卖仓单审核权限", description="")
  private Integer sellPledgeAudit;
  @ClassDiscription(name="摘牌权限", description="")
  private Integer isPickOff;
  
  public Integer getBuyOrderAudit()
  {
    return this.buyOrderAudit;
  }
  
  public void setBuyOrderAudit(Integer paramInteger)
  {
    this.buyOrderAudit = paramInteger;
  }
  
  public Integer getSellOrderAudit()
  {
    return this.sellOrderAudit;
  }
  
  public void setSellOrderAudit(Integer paramInteger)
  {
    this.sellOrderAudit = paramInteger;
  }
  
  public Integer getSellPledgeAudit()
  {
    return this.sellPledgeAudit;
  }
  
  public void setSellPledgeAudit(Integer paramInteger)
  {
    this.sellPledgeAudit = paramInteger;
  }
  
  public Integer getIsPickOff()
  {
    return this.isPickOff;
  }
  
  public void setIsPickOff(Integer paramInteger)
  {
    this.isPickOff = paramInteger;
  }
  
  public Long getTradeRightId()
  {
    return this.tradeRightId;
  }
  
  public void setTradeRightId(Long paramLong)
  {
    this.tradeRightId = paramLong;
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
  
  public MFirm getFirm()
  {
    return this.firm;
  }
  
  public void setFirm(MFirm paramMFirm)
  {
    this.firm = paramMFirm;
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return new StandardModel.PrimaryInfo("tradeRightId", this.tradeRightId);
  }
}
