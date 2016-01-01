package gnnt.MEBS.espot.front.model.trade;

import gnnt.MEBS.common.front.model.StandardModel;
import gnnt.MEBS.common.front.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.front.model.integrated.MFirm;
import gnnt.MEBS.common.front.model.translate.ClassDiscription;
import gnnt.MEBS.common.front.statictools.Tools;
import java.util.Date;

public class SubOrderBase
  extends StandardModel
{
  private static final long serialVersionUID = -5100900208389276106L;
  @ClassDiscription(name="子委托号", description="")
  private Long subOrderID;
  @ClassDiscription(name="议价交易商编号", description="")
  private String subFirmID;
  @ClassDiscription(name="议价交易商", description="对应交易商代码")
  private MFirm belongtoFirm;
  @ClassDiscription(name="数量", description="")
  private Double quantity;
  @ClassDiscription(name="价格", description="")
  private Double price;
  @ClassDiscription(name="交收仓库", description="")
  private String wareHouseID;
  @ClassDiscription(name="保证金支付期限", description="")
  private Integer tradePreTime;
  @ClassDiscription(name="买方交收保证金", description="")
  private Double deliveryMargin_B;
  @ClassDiscription(name="卖方交收保证金", description="")
  private Double deliveryMargin_S;
  @ClassDiscription(name="备注", description="")
  private String remark;
  @ClassDiscription(name="交收日类型", description="交收日类型 0：指定准备天数 1：指定最后交收日")
  private Integer deliveryDayType;
  @ClassDiscription(name="交收日期", description="")
  private Date deliveryDay;
  @ClassDiscription(name="交收准备期限", description="")
  private Integer deliveryPreTime;
  @ClassDiscription(name="状态", description="状态 0：等待委托方答复 1：委托方接受 2：委托方拒绝 3：摘牌方撤单 4：系统自动撤单 5：管理员撤单")
  private Integer status;
  @ClassDiscription(name="撤单人", description="")
  private String withdrawer;
  @ClassDiscription(name="撤单时间", description="")
  private Date withdrawTime;
  @ClassDiscription(name="创建时间", description="")
  private Date createTime;
  @ClassDiscription(name="答复", description="")
  private String reply;
  @ClassDiscription(name="答复时间", description="")
  private Date replyTime;
  @ClassDiscription(name="已付保证金", description="")
  private Double frozenMargin;
  
  public Long getSubOrderID()
  {
    return this.subOrderID;
  }
  
  public void setSubOrderID(Long paramLong)
  {
    this.subOrderID = paramLong;
  }
  
  public String getSubFirmID()
  {
    return this.subFirmID;
  }
  
  public void setSubFirmID(String paramString)
  {
    this.subFirmID = paramString;
  }
  
  public MFirm getBelongtoFirm()
  {
    return this.belongtoFirm;
  }
  
  public void setBelongtoFirm(MFirm paramMFirm)
  {
    this.belongtoFirm = paramMFirm;
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
  
  public String getWareHouseID()
  {
    return this.wareHouseID;
  }
  
  public void setWareHouseID(String paramString)
  {
    this.wareHouseID = paramString;
  }
  
  public Integer getTradePreTime()
  {
    return this.tradePreTime;
  }
  
  public void setTradePreTime(Integer paramInteger)
  {
    this.tradePreTime = paramInteger;
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
  
  public String getWithdrawer()
  {
    return this.withdrawer;
  }
  
  public void setWithdrawer(String paramString)
  {
    this.withdrawer = paramString;
  }
  
  public Date getWithdrawTime()
  {
    return this.withdrawTime;
  }
  
  public void setWithdrawTime(Date paramDate)
  {
    this.withdrawTime = paramDate;
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
  
  public Double getFrozenMargin()
  {
    return this.frozenMargin;
  }
  
  public void setFrozenMargin(Double paramDouble)
  {
    this.frozenMargin = paramDouble;
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return new StandardModel.PrimaryInfo("subOrderID", this.subOrderID);
  }
  
  public Integer getTradePreHoure()
  {
    return Tools.secondToHour(this.tradePreTime);
  }
  
  public void setTradePreHoure(int paramInt)
  {
    this.tradePreTime = Tools.HoureToSecond(Integer.valueOf(paramInt));
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
  
  public Integer getDeliveryPreHoure()
  {
    return Tools.secondToHour(this.deliveryPreTime);
  }
  
  public void setDeliveryPreHoure(Integer paramInteger)
  {
    this.deliveryPreTime = Tools.HoureToSecond(paramInteger);
  }
}
