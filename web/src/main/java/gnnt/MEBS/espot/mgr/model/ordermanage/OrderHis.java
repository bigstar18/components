package gnnt.MEBS.espot.mgr.model.ordermanage;

import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.mgr.model.translate.ClassDiscription;
import gnnt.MEBS.common.mgr.statictools.Tools;
import gnnt.MEBS.espot.mgr.model.commoditymanage.Breed;
import java.util.Date;
import java.util.Set;

public class OrderHis
  extends StandardModel
{
  private static final long serialVersionUID = 1L;
  @ClassDiscription(name="委托号 ", description="")
  private Long orderId;
  @ClassDiscription(name="商品标题", description="")
  private String orderTitle;
  @ClassDiscription(name="关联品名", description="")
  private Breed breed;
  @ClassDiscription(name="商品分类号", description="")
  private Long categoryId;
  @ClassDiscription(name="买卖方向", description="买卖方向 B：买 S：卖")
  private String bsFlag;
  @ClassDiscription(name="关联交易商ID", description="")
  private String firmId;
  @ClassDiscription(name="单位价格", description="")
  private Double price;
  @ClassDiscription(name="商品数量", description="")
  private Double quantity;
  @ClassDiscription(name="商品单位", description="")
  private String unit;
  @ClassDiscription(name="保证金支付期限", description="")
  private Integer tradePreTime;
  @ClassDiscription(name="买方诚信保障金", description="")
  private Double tradeMargin_B;
  @ClassDiscription(name="卖方诚信保障金", description="")
  private Double tradeMargin_S;
  @ClassDiscription(name="交收日类型", description="交收日类型0：指定准备天数 1：指定最后交收日")
  private Integer deliveryDayType;
  @ClassDiscription(name="交收地类型", description="交收地类型 1：指定仓库交收 2：指定交收地交收")
  private String deliveryType;
  @ClassDiscription(name="默认备款/备货期限", description="")
  private Integer deliveryPreTime;
  @ClassDiscription(name="最后交收日", description="")
  private Date deliveryDay;
  @ClassDiscription(name="交收地", description="")
  private String deliveryAddress;
  @ClassDiscription(name="买方履约保证金", description="")
  private Double deliveryMargin_B;
  @ClassDiscription(name="卖方履约保证金", description="")
  private Double deliveryMargin_S;
  @ClassDiscription(name="交收仓库号", description="")
  private String warehouseId;
  @ClassDiscription(name="委托状态", description="委托状态 0：未成交 1：部分成交 2：全部成交 3：已下架")
  private Integer status;
  @ClassDiscription(name="已成交数量", description="")
  private Double tradedQty;
  @ClassDiscription(name="备注", description="")
  private String remark;
  @ClassDiscription(name="委托时间", description="")
  private Date orderTime;
  @ClassDiscription(name="委托挂出时间", description="")
  private Date effectOfTime;
  @ClassDiscription(name="交易员ID", description="")
  private String traderId;
  @ClassDiscription(name="撤单时间", description="")
  private Date withdrawTime;
  @ClassDiscription(name="撤单人ID", description="")
  private String withdrawTraderId;
  @ClassDiscription(name="委托有效期限", description="")
  private Integer validTime;
  @ClassDiscription(name="是否卖仓单", description="是否卖仓单 0：否 1： 是")
  private Integer pledgeFlag;
  @ClassDiscription(name="最小交易数量", description="")
  private Double minTradeQty;
  @ClassDiscription(name="交易单位", description="")
  private Double tradeUnit;
  @ClassDiscription(name="是否允许摘牌", description="是否允许摘牌 Y：允许 N：不允许")
  private String isPickOff;
  @ClassDiscription(name="是否允许议价", description="是否允许议价 Y：允许 N：不允许")
  private String isSuborder;
  @ClassDiscription(name="是否以支付保证金", description="是否以支付保证金Y：支付 N：不支付")
  private String isPayMargin;
  @ClassDiscription(name="冻结保证金金额", description="")
  private Double frozenMargin;
  @ClassDiscription(name="交收类型", description="交收类型 0： 协议交收 1：自主交收 ")
  private Integer tradeType;
  @ClassDiscription(name="付款类型", description="付款类型  0： 先款后货 1： 先货后款 2：不限制")
  private Integer payType;
  @ClassDiscription(name="关联 委托商品属性表", description="")
  private Set<OrderGoodsPropertyHis> orderGoodsProperties;
  @ClassDiscription(name="卖仓单号", description="")
  private String stockID;
  
  public Integer getTradeType()
  {
    return this.tradeType;
  }
  
  public void setTradeType(Integer paramInteger)
  {
    this.tradeType = paramInteger;
  }
  
  public Integer getPayType()
  {
    return this.payType;
  }
  
  public void setPayType(Integer paramInteger)
  {
    this.payType = paramInteger;
  }
  
  public Long getOrderId()
  {
    return this.orderId;
  }
  
  public void setOrderId(Long paramLong)
  {
    this.orderId = paramLong;
  }
  
  public Breed getBreed()
  {
    return this.breed;
  }
  
  public void setBreed(Breed paramBreed)
  {
    this.breed = paramBreed;
  }
  
  public Long getCategoryId()
  {
    return this.categoryId;
  }
  
  public void setCategoryId(Long paramLong)
  {
    this.categoryId = paramLong;
  }
  
  public String getBsFlag()
  {
    return this.bsFlag;
  }
  
  public void setBsFlag(String paramString)
  {
    this.bsFlag = paramString;
  }
  
  public String getFirmId()
  {
    return this.firmId;
  }
  
  public void setFirmId(String paramString)
  {
    this.firmId = paramString;
  }
  
  public Double getPrice()
  {
    return this.price;
  }
  
  public void setPrice(Double paramDouble)
  {
    this.price = paramDouble;
  }
  
  public Double getQuantity()
  {
    return this.quantity;
  }
  
  public void setQuantity(Double paramDouble)
  {
    this.quantity = paramDouble;
  }
  
  public String getUnit()
  {
    return this.unit;
  }
  
  public void setUnit(String paramString)
  {
    this.unit = paramString;
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
  
  public Double getTradeMargin_B()
  {
    return this.tradeMargin_B;
  }
  
  public void setTradeMargin_B(Double paramDouble)
  {
    this.tradeMargin_B = paramDouble;
  }
  
  public Double getTradeMargin_S()
  {
    return this.tradeMargin_S;
  }
  
  public void setTradeMargin_S(Double paramDouble)
  {
    this.tradeMargin_S = paramDouble;
  }
  
  public Integer getDeliveryDayType()
  {
    return this.deliveryDayType;
  }
  
  public void setDeliveryDayType(Integer paramInteger)
  {
    this.deliveryDayType = paramInteger;
  }
  
  public String getDeliveryType()
  {
    return this.deliveryType;
  }
  
  public void setDeliveryType(String paramString)
  {
    this.deliveryType = paramString;
  }
  
  public Integer getDeliveryPreTime()
  {
    return this.deliveryPreTime;
  }
  
  public void setDeliveryPreTime(Integer paramInteger)
  {
    this.deliveryPreTime = paramInteger;
  }
  
  public Integer getDeliveryPreHour()
  {
    return Tools.secondToHour(this.deliveryPreTime);
  }
  
  public void setDeliveryPreHour(Integer paramInteger)
  {
    this.deliveryPreTime = Tools.HourToSecond(paramInteger);
  }
  
  public Date getDeliveryDay()
  {
    return this.deliveryDay;
  }
  
  public void setDeliveryDay(Date paramDate)
  {
    this.deliveryDay = paramDate;
  }
  
  public String getDeliveryAddress()
  {
    return this.deliveryAddress;
  }
  
  public void setDeliveryAddress(String paramString)
  {
    this.deliveryAddress = paramString;
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
  
  public String getWarehouseId()
  {
    return this.warehouseId;
  }
  
  public void setWarehouseId(String paramString)
  {
    this.warehouseId = paramString;
  }
  
  public Integer getStatus()
  {
    return this.status;
  }
  
  public void setStatus(Integer paramInteger)
  {
    this.status = paramInteger;
  }
  
  public Double getTradedQty()
  {
    return this.tradedQty;
  }
  
  public void setTradedQty(Double paramDouble)
  {
    this.tradedQty = paramDouble;
  }
  
  public String getRemark()
  {
    return this.remark;
  }
  
  public void setRemark(String paramString)
  {
    this.remark = paramString;
  }
  
  public Date getOrderTime()
  {
    return this.orderTime;
  }
  
  public void setOrderTime(Date paramDate)
  {
    this.orderTime = paramDate;
  }
  
  public Date getEffectOfTime()
  {
    return this.effectOfTime;
  }
  
  public void setEffectOfTime(Date paramDate)
  {
    this.effectOfTime = paramDate;
  }
  
  public Date getWithdrawTime()
  {
    return this.withdrawTime;
  }
  
  public void setWithdrawTime(Date paramDate)
  {
    this.withdrawTime = paramDate;
  }
  
  public String getWithdrawTraderId()
  {
    return this.withdrawTraderId;
  }
  
  public void setWithdrawTraderId(String paramString)
  {
    this.withdrawTraderId = paramString;
  }
  
  public String getTraderId()
  {
    return this.traderId;
  }
  
  public void setTraderId(String paramString)
  {
    this.traderId = paramString;
  }
  
  public Integer getValidTime()
  {
    return this.validTime;
  }
  
  public void setValidTime(Integer paramInteger)
  {
    this.validTime = paramInteger;
  }
  
  public Integer getValidHour()
  {
    return Tools.secondToHour(this.validTime);
  }
  
  public void setValidHour(int paramInt)
  {
    this.validTime = Tools.HourToSecond(Integer.valueOf(paramInt));
  }
  
  public String getOrderTitle()
  {
    return this.orderTitle;
  }
  
  public void setOrderTitle(String paramString)
  {
    this.orderTitle = paramString;
  }
  
  public Integer getPledgeFlag()
  {
    return this.pledgeFlag;
  }
  
  public void setPledgeFlag(Integer paramInteger)
  {
    this.pledgeFlag = paramInteger;
  }
  
  public Double getMinTradeQty()
  {
    return this.minTradeQty;
  }
  
  public void setMinTradeQty(Double paramDouble)
  {
    this.minTradeQty = paramDouble;
  }
  
  public Double getTradeUnit()
  {
    return this.tradeUnit;
  }
  
  public void setTradeUnit(Double paramDouble)
  {
    this.tradeUnit = paramDouble;
  }
  
  public String getIsPickOff()
  {
    return this.isPickOff;
  }
  
  public void setIsPickOff(String paramString)
  {
    this.isPickOff = paramString;
  }
  
  public String getIsSuborder()
  {
    return this.isSuborder;
  }
  
  public void setIsSuborder(String paramString)
  {
    this.isSuborder = paramString;
  }
  
  public String getIsPayMargin()
  {
    return this.isPayMargin;
  }
  
  public void setIsPayMargin(String paramString)
  {
    this.isPayMargin = paramString;
  }
  
  public Double getFrozenMargin()
  {
    return this.frozenMargin;
  }
  
  public void setFrozenMargin(Double paramDouble)
  {
    this.frozenMargin = paramDouble;
  }
  
  public Set<OrderGoodsPropertyHis> getOrderGoodsProperties()
  {
    return this.orderGoodsProperties;
  }
  
  public void setOrderGoodsProperties(Set<OrderGoodsPropertyHis> paramSet)
  {
    this.orderGoodsProperties = paramSet;
  }
  
  public Date getValidTimes()
  {
    Date localDate = null;
    if (getValidTime().intValue() != 0)
    {
      localDate = getOrderTime();
      localDate.setDate(localDate.getDate() + getValidTime().intValue());
    }
    return localDate;
  }
  
  public Float getValidValue()
  {
    Integer localInteger = getDeliveryPreTime();
    if (localInteger != null)
    {
      float f1 = localInteger.intValue();
      float f2 = Float.parseFloat(String.valueOf(localInteger));
      if (getDeliveryDayType().intValue() == 0) {
        f2 = f1 / 60.0F / 60.0F;
      }
      return Float.valueOf(f2);
    }
    return null;
  }
  
  public String getStockID()
  {
    return this.stockID;
  }
  
  public void setStockID(String paramString)
  {
    this.stockID = paramString;
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return new StandardModel.PrimaryInfo("orderId", this.orderId);
  }
}
