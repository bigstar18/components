package gnnt.MEBS.espot.front.model.trade;

import gnnt.MEBS.common.front.model.StandardModel;
import gnnt.MEBS.common.front.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.front.model.integrated.MFirm;
import gnnt.MEBS.common.front.model.translate.ClassDiscription;
import gnnt.MEBS.common.front.statictools.Tools;
import gnnt.MEBS.espot.front.model.commodity.Breed;
import java.util.Date;

public class OrderBase
  extends StandardModel
{
  private static final long serialVersionUID = -2135435843921993812L;
  @ClassDiscription(name="委托号", description="")
  private Long orderID;
  @ClassDiscription(name="商品标题", description="")
  private String orderTitle;
  @ClassDiscription(name="商品分类ID", description="")
  private Long categoryID;
  @ClassDiscription(name="品名", description="对应品名ID")
  private Breed belongtoBreed;
  @ClassDiscription(name="买卖方向", description="买卖方向 B：买 S：卖")
  private String bsFlag;
  @ClassDiscription(name="交易商代码", description="")
  private MFirm belongtoMFirm;
  @ClassDiscription(name="单位", description="")
  private String unit;
  @ClassDiscription(name="单位价格", description="")
  private Double price;
  @ClassDiscription(name="商品数量", description="")
  private Double quantity;
  @ClassDiscription(name="保证金支付期限", description="")
  private Integer tradePreTime;
  @ClassDiscription(name="买方诚信保障金", description="")
  private Double tradeMargin_B;
  @ClassDiscription(name="卖方诚信保障金", description="")
  private Double tradeMargin_S;
  @ClassDiscription(name="交收日类型", description="交收日类型 0：指定准备天数 1：指定最后交收日")
  private Integer deliveryDayType;
  @ClassDiscription(name="交收准备天数", description="")
  private Integer deliveryPreTime;
  @ClassDiscription(name="交收日期", description="")
  private Date deliveryDay;
  @ClassDiscription(name="买方交收保证金", description="")
  private Double deliveryMargin_B;
  @ClassDiscription(name="卖方交收保证金", description="")
  private Double deliveryMargin_S;
  @ClassDiscription(name="交收类型", description="交收类型　1：注册仓单交收 2：指定交收地")
  private String deliveryType;
  @ClassDiscription(name="交收仓库ID", description="")
  private String warehouseID;
  @ClassDiscription(name="交收地", description="")
  private String deliveryAddress;
  @ClassDiscription(name="委托状态", description="0：未成交 1：部分成交 2：全部成交 3：已下架 11：待后台管理员审核")
  private Integer status;
  @ClassDiscription(name="已成交数量", description="")
  private Double tradedQty;
  @ClassDiscription(name="备注", description="")
  private String remark;
  @ClassDiscription(name="委托时间", description="")
  private Date orderTime;
  private Date effectOfTime;
  @ClassDiscription(name="交易员ID", description="")
  private String traderID;
  @ClassDiscription(name="撤单时间", description="")
  private Date withdrawTime;
  @ClassDiscription(name="撤单人ID", description="")
  private String withdrawTraderID;
  @ClassDiscription(name="委托有效期", description="")
  private Integer validTime;
  @ClassDiscription(name="是否卖仓单", description="是否卖仓单0：否 1：是")
  private Integer pledgeFlag;
  @ClassDiscription(name="最小交易数量", description="")
  private Double minTradeQty;
  @ClassDiscription(name="交易单位", description="")
  private Double tradeUnit;
  @ClassDiscription(name="是否允许摘牌", description="是否允许摘牌 0：否 1：是")
  private String isPickOff;
  @ClassDiscription(name="是否允许议价", description="")
  private String isSuborder;
  @ClassDiscription(name="是否已支付保证金", description="")
  private String isPayMargin;
  @ClassDiscription(name="已付保证金", description="")
  private Double frozenMargin;
  @ClassDiscription(name="交收类型", description="0：协议交收 1：自主交收")
  private Integer tradeType;
  @ClassDiscription(name="付款类型", description="付款类型 0： 先款后货 1：先货后款 2:\t不限制")
  private Integer payType;
  @ClassDiscription(name="卖仓单号", description="")
  private String stockID;
  
  public Long getOrderID()
  {
    return this.orderID;
  }
  
  public void setOrderID(Long paramLong)
  {
    this.orderID = paramLong;
  }
  
  public String getUnit()
  {
    return this.unit;
  }
  
  public void setUnit(String paramString)
  {
    this.unit = paramString;
  }
  
  public String getOrderTitle()
  {
    return this.orderTitle;
  }
  
  public void setOrderTitle(String paramString)
  {
    this.orderTitle = paramString;
  }
  
  public Long getCategoryID()
  {
    return this.categoryID;
  }
  
  public void setCategoryID(Long paramLong)
  {
    this.categoryID = paramLong;
  }
  
  public Breed getBelongtoBreed()
  {
    return this.belongtoBreed;
  }
  
  public void setBelongtoBreed(Breed paramBreed)
  {
    this.belongtoBreed = paramBreed;
  }
  
  public String getBsFlag()
  {
    return this.bsFlag;
  }
  
  public void setBsFlag(String paramString)
  {
    this.bsFlag = paramString;
  }
  
  public MFirm getBelongtoMFirm()
  {
    return this.belongtoMFirm;
  }
  
  public void setBelongtoMFirm(MFirm paramMFirm)
  {
    this.belongtoMFirm = paramMFirm;
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
  
  public Integer getTradePreTime()
  {
    return this.tradePreTime;
  }
  
  public void setTradePreTime(Integer paramInteger)
  {
    this.tradePreTime = paramInteger;
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
  
  public Integer getDeliveryPreTime()
  {
    return this.deliveryPreTime;
  }
  
  public void setDeliveryPreTime(Integer paramInteger)
  {
    this.deliveryPreTime = paramInteger;
  }
  
  public Date getDeliveryDay()
  {
    return this.deliveryDay;
  }
  
  public void setDeliveryDay(Date paramDate)
  {
    this.deliveryDay = paramDate;
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
  
  public String getDeliveryType()
  {
    return this.deliveryType;
  }
  
  public void setDeliveryType(String paramString)
  {
    this.deliveryType = paramString;
  }
  
  public String getWarehouseID()
  {
    return this.warehouseID;
  }
  
  public void setWarehouseID(String paramString)
  {
    this.warehouseID = paramString;
  }
  
  public String getDeliveryAddress()
  {
    return this.deliveryAddress;
  }
  
  public void setDeliveryAddress(String paramString)
  {
    this.deliveryAddress = paramString;
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
  
  public String getTraderID()
  {
    return this.traderID;
  }
  
  public void setTraderID(String paramString)
  {
    this.traderID = paramString;
  }
  
  public Date getWithdrawTime()
  {
    return this.withdrawTime;
  }
  
  public void setWithdrawTime(Date paramDate)
  {
    this.withdrawTime = paramDate;
  }
  
  public String getWithdrawTraderID()
  {
    return this.withdrawTraderID;
  }
  
  public void setWithdrawTraderID(String paramString)
  {
    this.withdrawTraderID = paramString;
  }
  
  public Integer getValidTime()
  {
    return this.validTime;
  }
  
  public void setValidTime(Integer paramInteger)
  {
    this.validTime = paramInteger;
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
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return new StandardModel.PrimaryInfo("orderID", this.orderID);
  }
  
  public Integer getTradePreHoure()
  {
    return Tools.secondToHour(this.tradePreTime);
  }
  
  public void setTradePreHoure(int paramInt)
  {
    this.tradePreTime = Tools.HoureToSecond(Integer.valueOf(paramInt));
  }
  
  public Integer getDeliveryPreHoure()
  {
    return Tools.secondToHour(this.deliveryPreTime);
  }
  
  public void setDeliveryPreHoure(int paramInt)
  {
    this.deliveryPreTime = Tools.HoureToSecond(Integer.valueOf(paramInt));
  }
  
  public Integer getValidHoure()
  {
    return Tools.secondToHour(this.validTime);
  }
  
  public void setValidHoure(int paramInt)
  {
    this.validTime = Tools.HoureToSecond(Integer.valueOf(paramInt));
  }
  
  public Integer getPayType()
  {
    return this.payType;
  }
  
  public void setPayType(Integer paramInteger)
  {
    this.payType = paramInteger;
  }
  
  public Integer getTradeType()
  {
    return this.tradeType;
  }
  
  public void setTradeType(Integer paramInteger)
  {
    this.tradeType = paramInteger;
  }
  
  public String getStockID()
  {
    return this.stockID;
  }
  
  public void setStockID(String paramString)
  {
    this.stockID = paramString;
  }
}
