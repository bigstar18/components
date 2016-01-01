package gnnt.MEBS.espot.mgr.model.subordermanage;

import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.mgr.model.translate.ClassDiscription;
import gnnt.MEBS.common.mgr.statictools.Tools;
import gnnt.MEBS.espot.mgr.model.ordermanage.OrderHis;
import java.util.Date;

public class SubOrderHis
  extends StandardModel
{
  private static final long serialVersionUID = 1L;
  @ClassDiscription(name="子委托ID", description="")
  private Long subOrderId;
  @ClassDiscription(name="关联委托", description="对应委托号")
  private OrderHis order;
  @ClassDiscription(name="提出议价的交易商", description="")
  private String subFirmId;
  @ClassDiscription(name="数量", description="")
  private Double quantity;
  @ClassDiscription(name="价格", description="")
  private Double price;
  @ClassDiscription(name="交收仓库", description="")
  private String wareHouseId;
  @ClassDiscription(name="保证金支付期限", description="")
  private Integer tradePreTime;
  @ClassDiscription(name="买方履约保证金", description="")
  private Double deliveryMargin_B;
  @ClassDiscription(name="卖方履约保证金", description="")
  private Double deliveryMargin_S;
  @ClassDiscription(name="冻结保证金金额", description="")
  private Double frozenMargin;
  @ClassDiscription(name="备注", description="")
  private String remark;
  @ClassDiscription(name="交收日类型", description="交收日类型 0：指定准备天数 1：指定最后交收日")
  private Integer deliveryDayType;
  @ClassDiscription(name="交收日期", description="")
  private Date deliveryDay;
  @ClassDiscription(name="交收准备期限", description="")
  private Integer deliveryPreTime;
  @ClassDiscription(name="状态", description="状态 0：等待挂牌方答复 1：挂牌方接受 2：挂牌方拒绝 3：摘牌方撤单 4：系统自动撤单 5:管理员撤单")
  private Integer status;
  @ClassDiscription(name="创建时间", description="")
  private Date createTime;
  @ClassDiscription(name="答复", description="")
  private String reply;
  @ClassDiscription(name="答复时间", description="")
  private Date replyTime;
  @ClassDiscription(name="撤单人", description="")
  private String withdrawer;
  @ClassDiscription(name="撤单时间", description="")
  private Date withdrawTime;
  
  public Date getWithdrawTime()
  {
    return this.withdrawTime;
  }
  
  public void setWithdrawTime(Date paramDate)
  {
    this.withdrawTime = paramDate;
  }
  
  public Long getSubOrderId()
  {
    return this.subOrderId;
  }
  
  public void setSubOrderId(Long paramLong)
  {
    this.subOrderId = paramLong;
  }
  
  public OrderHis getOrder()
  {
    return this.order;
  }
  
  public void setOrder(OrderHis paramOrderHis)
  {
    this.order = paramOrderHis;
  }
  
  public Double getQuantity()
  {
    return this.quantity;
  }
  
  public void setQuantity(Double paramDouble)
  {
    this.quantity = paramDouble;
  }
  
  public Double getPrice()
  {
    return this.price;
  }
  
  public void setPrice(Double paramDouble)
  {
    this.price = paramDouble;
  }
  
  public String getWareHouseId()
  {
    return this.wareHouseId;
  }
  
  public void setWareHouseId(String paramString)
  {
    this.wareHouseId = paramString;
  }
  
  public Integer getTradePreTime()
  {
    return this.tradePreTime;
  }
  
  public void setTradePreTime(Integer paramInteger)
  {
    this.tradePreTime = paramInteger;
  }
  
  public Integer getTradePreHour()
  {
    return Tools.secondToHour(this.tradePreTime);
  }
  
  public void setTradePreHour(Integer paramInteger)
  {
    this.tradePreTime = Tools.HourToSecond(paramInteger);
  }
  
  public Double getDeliveryMargin_B()
  {
    return this.deliveryMargin_B;
  }
  
  public void setDeliveryMargin_B(Double paramDouble)
  {
    this.deliveryMargin_B = paramDouble;
  }
  
  public Double getDeliveryMargin_S()
  {
    return this.deliveryMargin_S;
  }
  
  public void setDeliveryMargin_S(Double paramDouble)
  {
    this.deliveryMargin_S = paramDouble;
  }
  
  public Double getFrozenMargin()
  {
    return this.frozenMargin;
  }
  
  public void setFrozenMargin(Double paramDouble)
  {
    this.frozenMargin = paramDouble;
  }
  
  public String getRemark()
  {
    return this.remark;
  }
  
  public void setRemark(String paramString)
  {
    this.remark = paramString;
  }
  
  public Integer getStatus()
  {
    return this.status;
  }
  
  public void setStatus(Integer paramInteger)
  {
    this.status = paramInteger;
  }
  
  public Date getCreateTime()
  {
    return this.createTime;
  }
  
  public void setCreateTime(Date paramDate)
  {
    this.createTime = paramDate;
  }
  
  public String getReply()
  {
    return this.reply;
  }
  
  public void setReply(String paramString)
  {
    this.reply = paramString;
  }
  
  public Date getReplyTime()
  {
    return this.replyTime;
  }
  
  public void setReplyTime(Date paramDate)
  {
    this.replyTime = paramDate;
  }
  
  public String getSubFirmId()
  {
    return this.subFirmId;
  }
  
  public void setSubFirmId(String paramString)
  {
    this.subFirmId = paramString;
  }
  
  public String getWithdrawer()
  {
    return this.withdrawer;
  }
  
  public void setWithdrawer(String paramString)
  {
    this.withdrawer = paramString;
  }
  
  public Integer getDeliveryDayType()
  {
    return this.deliveryDayType;
  }
  
  public void setDeliveryDayType(Integer paramInteger)
  {
    this.deliveryDayType = paramInteger;
  }
  
  public Date getDeliveryDay()
  {
    return this.deliveryDay;
  }
  
  public void setDeliveryDay(Date paramDate)
  {
    this.deliveryDay = paramDate;
  }
  
  public Integer getDeliveryPreTime()
  {
    return this.deliveryPreTime;
  }
  
  public void setDeliveryPreTime(Integer paramInteger)
  {
    this.deliveryPreTime = paramInteger;
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return new StandardModel.PrimaryInfo("subOrderId", this.subOrderId);
  }
}
