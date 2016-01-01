package gnnt.MEBS.espot.mgr.model.preordermanage;

import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.mgr.model.translate.ClassDiscription;
import gnnt.MEBS.common.mgr.statictools.Tools;
import gnnt.MEBS.espot.mgr.model.commoditymanage.Breed;
import java.util.Date;
import java.util.Set;

public class GoodsResource
  extends StandardModel
{
  private static final long serialVersionUID = 3383128095313895903L;
  @ClassDiscription(name="商品资源ID", description="")
  private Long resourceId;
  @ClassDiscription(name="商品标题", description="")
  private String orderTitle;
  @ClassDiscription(name="关联品名", description="对应品名ID")
  private Breed breed;
  @ClassDiscription(name="商品分类号ID", description="")
  private Integer categoryId;
  @ClassDiscription(name="买卖方向", description="买卖方向 B：买 S：卖")
  private String bSFlag;
  @ClassDiscription(name="交易商代码", description="")
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
  @ClassDiscription(name="交收日类型", description="")
  private Integer deliveryDayType;
  @ClassDiscription(name="备款/备货期限", description="")
  private Integer deliveryPreTime;
  @ClassDiscription(name="交收日期", description="")
  private Date deliveryDay;
  @ClassDiscription(name="买方交收保证金", description="")
  private Double deliveryMargin_B;
  @ClassDiscription(name="卖方交收保证金", description="")
  private Double deliveryMargin_S;
  @ClassDiscription(name="交收地类型", description="交收地类型 1：指定仓库交收 2：指定交收地交收")
  private Integer deliveryType;
  @ClassDiscription(name="交收仓库ID", description="")
  private String warehouseId;
  @ClassDiscription(name="交收地", description="")
  private String deliveryAddress;
  @ClassDiscription(name="最小交易数量", description="")
  private Double minTradeQty;
  @ClassDiscription(name="交易单位", description="")
  private Double tradeUnit;
  @ClassDiscription(name="备注", description="")
  private String remark;
  @ClassDiscription(name="交易员ID", description="")
  private String traderId;
  @ClassDiscription(name="委托有效期", description="")
  private Integer validTime;
  @ClassDiscription(name="是否允许摘牌", description="")
  private String isPickOff;
  @ClassDiscription(name="是否允许议价", description="是否允许议价Y：允许 N：不允许")
  private String isSuborder;
  @ClassDiscription(name="是否已挂牌", description="是否已挂牌：0 否 1 是")
  private Integer isOrdered;
  @ClassDiscription(name="交收类型", description="交收类型 0： 协议交收 1：自主交收 ")
  private Integer tradeType;
  @ClassDiscription(name="付款类型", description="付款类型  0： 先款后货 1： 先货后款 2：不限制")
  private Integer payType;
  @ClassDiscription(name="关联商品资源属性", description="")
  private Set<GoodsResourceProperty> goodsResourceProperties;
  
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
  
  public Long getResourceId()
  {
    return this.resourceId;
  }
  
  public void setResourceId(Long paramLong)
  {
    this.resourceId = paramLong;
  }
  
  public String getOrderTitle()
  {
    return this.orderTitle;
  }
  
  public void setOrderTitle(String paramString)
  {
    this.orderTitle = paramString;
  }
  
  public Breed getBreed()
  {
    return this.breed;
  }
  
  public void setBreed(Breed paramBreed)
  {
    this.breed = paramBreed;
  }
  
  public Integer getCategoryId()
  {
    return this.categoryId;
  }
  
  public void setCategoryId(Integer paramInteger)
  {
    this.categoryId = paramInteger;
  }
  
  public String getbSFlag()
  {
    return this.bSFlag;
  }
  
  public void setbSFlag(String paramString)
  {
    this.bSFlag = paramString;
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
  
  public void setTradePreHour(int paramInt)
  {
    this.tradePreTime = Tools.HourToSecond(Integer.valueOf(paramInt));
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
  
  public Integer getDeliveryPreHour()
  {
    return Tools.secondToHour(this.deliveryPreTime);
  }
  
  public void setDeliveryPreHour(int paramInt)
  {
    this.deliveryPreTime = Tools.HourToSecond(Integer.valueOf(paramInt));
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
  
  public Integer getDeliveryType()
  {
    return this.deliveryType;
  }
  
  public void setDeliveryType(Integer paramInteger)
  {
    this.deliveryType = paramInteger;
  }
  
  public String getWarehouseId()
  {
    return this.warehouseId;
  }
  
  public void setWarehouseId(String paramString)
  {
    this.warehouseId = paramString;
  }
  
  public String getDeliveryAddress()
  {
    return this.deliveryAddress;
  }
  
  public void setDeliveryAddress(String paramString)
  {
    this.deliveryAddress = paramString;
  }
  
  public String getRemark()
  {
    return this.remark;
  }
  
  public void setRemark(String paramString)
  {
    this.remark = paramString;
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
  
  public Integer getIsOrdered()
  {
    return this.isOrdered;
  }
  
  public void setIsOrdered(Integer paramInteger)
  {
    this.isOrdered = paramInteger;
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
  
  public Set<GoodsResourceProperty> getGoodsResourceProperties()
  {
    return this.goodsResourceProperties;
  }
  
  public void setGoodsResourceProperties(Set<GoodsResourceProperty> paramSet)
  {
    this.goodsResourceProperties = paramSet;
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
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return new StandardModel.PrimaryInfo("resourceId", this.resourceId);
  }
}
