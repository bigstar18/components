package gnnt.MEBS.espot.mgr.model.preordermanage;

import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.mgr.model.translate.ClassDiscription;
import gnnt.MEBS.common.mgr.statictools.Tools;
import gnnt.MEBS.espot.mgr.model.commoditymanage.Breed;
import java.util.Date;
import java.util.LinkedHashSet;
import java.util.Set;

public class GoodsTemplate
  extends StandardModel
{
  private static final long serialVersionUID = -6595522714095141979L;
  @ClassDiscription(name="模板号", description="")
  private Long templateID;
  @ClassDiscription(name="商品标题", description="")
  private String orderTitle;
  @ClassDiscription(name="品名", description="对应品名ID")
  private Breed breed;
  @ClassDiscription(name="商品分类ID", description="")
  private Long categoryID;
  @ClassDiscription(name="买卖方向", description="买卖方向 B：买 S：卖")
  private String bsFlag;
  @ClassDiscription(name="单位价格", description="")
  private Double price;
  @ClassDiscription(name="商品数量", description="")
  private Double quantity;
  @ClassDiscription(name="商品单位", description="")
  private String unit;
  @ClassDiscription(name="保证金支付权限", description="")
  private Integer tradePreTime;
  @ClassDiscription(name="买方交易保证金", description="")
  private Double tradeMargin_b;
  @ClassDiscription(name="卖方交易保证金", description="")
  private Double tradeMargin_s;
  @ClassDiscription(name="交收日类型", description="交收日类型      0：指定准备天数 1：指定最后交收日")
  private Integer deliveryDayType;
  @ClassDiscription(name="备款/备货期限", description="")
  private Integer deliveryPreTime;
  @ClassDiscription(name="交收日期", description="")
  private Date deliveryDay;
  @ClassDiscription(name="买方交收保证金", description="")
  private Double deliveryMargin_b;
  @ClassDiscription(name="卖方交收保证金", description="")
  private Double deliveryMargin_s;
  @ClassDiscription(name="交收地类型", description="交收地类型1：指定仓库 2：指定交收地")
  private String deliveryType;
  @ClassDiscription(name="交收仓库ID", description="")
  private String warehouseID;
  @ClassDiscription(name="交收地", description="")
  private String deliveryAddress;
  @ClassDiscription(name="备注", description="")
  private String remark;
  @ClassDiscription(name="委托有效期", description="")
  private Integer validTime;
  @ClassDiscription(name="最小交易数量", description="")
  private Double minTradeQty;
  @ClassDiscription(name="交易单位", description="")
  private Double tradeUnit;
  @ClassDiscription(name="是否允许摘牌", description="")
  private Character isPickOff;
  @ClassDiscription(name="是否允许议价", description="是否允许议价 Y：允许 N：不允许")
  private Character isSuborder;
  @ClassDiscription(name="所属用户", description="")
  private String belongTOUser;
  @ClassDiscription(name="属性集合", description="")
  private Set<GoodsTemplateProperty> containGoodsTemplateProperty;
  @ClassDiscription(name="交易类型", description="交易类型 0： 协议交收 1：自主交收 ")
  private Integer tradeType;
  @ClassDiscription(name="付款类型", description="付款类型  0： 先款后货 1： 先货后款 2：不限制")
  private Integer payType;
  @ClassDiscription(name="模版类型", description="模版类型 0：系统模版 1：用户模版")
  private Integer templateType;
  
  public Integer getTemplateType()
  {
    return this.templateType;
  }
  
  public void setTemplateType(Integer paramInteger)
  {
    this.templateType = paramInteger;
  }
  
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
  
  public Long getTemplateID()
  {
    return this.templateID;
  }
  
  public void setTemplateID(Long paramLong)
  {
    this.templateID = paramLong;
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
  
  public Long getCategoryID()
  {
    return this.categoryID;
  }
  
  public void setCategoryID(Long paramLong)
  {
    this.categoryID = paramLong;
  }
  
  public String getBsFlag()
  {
    return this.bsFlag;
  }
  
  public void setBsFlag(String paramString)
  {
    this.bsFlag = paramString;
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
  
  public Double getTradeMargin_b()
  {
    return this.tradeMargin_b;
  }
  
  public void setTradeMargin_b(Double paramDouble)
  {
    this.tradeMargin_b = paramDouble;
  }
  
  public Double getTradeMargin_s()
  {
    return this.tradeMargin_s;
  }
  
  public void setTradeMargin_s(Double paramDouble)
  {
    this.tradeMargin_s = paramDouble;
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
  
  public Double getDeliveryMargin_b()
  {
    return this.deliveryMargin_b;
  }
  
  public void setDeliveryMargin_b(Double paramDouble)
  {
    this.deliveryMargin_b = paramDouble;
  }
  
  public Double getDeliveryMargin_s()
  {
    return this.deliveryMargin_s;
  }
  
  public void setDeliveryMargin_s(Double paramDouble)
  {
    this.deliveryMargin_s = paramDouble;
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
  
  public String getRemark()
  {
    return this.remark;
  }
  
  public void setRemark(String paramString)
  {
    this.remark = paramString;
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
  
  public Character getIsPickOff()
  {
    return this.isPickOff;
  }
  
  public void setIsPickOff(Character paramCharacter)
  {
    this.isPickOff = paramCharacter;
  }
  
  public Character getIsSuborder()
  {
    return this.isSuborder;
  }
  
  public void setIsSuborder(Character paramCharacter)
  {
    this.isSuborder = paramCharacter;
  }
  
  public String getBelongTOUser()
  {
    return this.belongTOUser;
  }
  
  public void setBelongTOUser(String paramString)
  {
    this.belongTOUser = paramString;
  }
  
  public Set<GoodsTemplateProperty> getContainGoodsTemplateProperty()
  {
    return this.containGoodsTemplateProperty;
  }
  
  public void setContainGoodsTemplateProperty(Set<GoodsTemplateProperty> paramSet)
  {
    this.containGoodsTemplateProperty = paramSet;
  }
  
  public void addContainGoodsTemplateProperty(GoodsTemplateProperty paramGoodsTemplateProperty)
  {
    if (this.containGoodsTemplateProperty == null) {
      synchronized (this)
      {
        if (this.containGoodsTemplateProperty == null) {
          this.containGoodsTemplateProperty = new LinkedHashSet();
        }
      }
    }
    this.containGoodsTemplateProperty.add(paramGoodsTemplateProperty);
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
    return new StandardModel.PrimaryInfo("templateID", this.templateID);
  }
}
