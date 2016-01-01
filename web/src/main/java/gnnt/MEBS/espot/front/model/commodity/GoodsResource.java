package gnnt.MEBS.espot.front.model.commodity;

import gnnt.MEBS.common.front.model.StandardModel;
import gnnt.MEBS.common.front.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.front.model.integrated.MFirm;
import gnnt.MEBS.common.front.model.translate.ClassDiscription;
import gnnt.MEBS.common.front.statictools.Tools;
import gnnt.MEBS.espot.core.bo.OrderBO;
import gnnt.MEBS.espot.core.po.GoodsPropertyPO;
import gnnt.MEBS.espot.core.po.OrderPO;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

public class GoodsResource
  extends StandardModel
{
  private static final long serialVersionUID = 1724143595733711429L;
  @ClassDiscription(name="商品资源ID", description="")
  private Long resourceID;
  @ClassDiscription(name="商品标题", description="")
  private String orderTitle;
  @ClassDiscription(name="商品分类ID", description="")
  private Long categoryID;
  @ClassDiscription(name="所属品名", description="")
  private Breed belongtoBreed;
  @ClassDiscription(name="买卖方向", description="买卖方向 B：买 S：卖")
  private String bsFlag;
  @ClassDiscription(name="所属交易商", description="对应交易商代码")
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
  @ClassDiscription(name="交收地类型", description="交收地类型1：注册仓单交收 2：指定交交收地")
  private String deliveryType;
  @ClassDiscription(name="交收仓库ID", description="")
  private String warehouseID;
  @ClassDiscription(name="交收地", description="")
  private String deliveryAddress;
  @ClassDiscription(name="备注", description="")
  private String remark;
  @ClassDiscription(name="交易员ID", description="")
  private String traderID;
  @ClassDiscription(name="委托有效期", description="")
  private Integer validTime;
  @ClassDiscription(name="是否挂牌", description="是否已挂牌：0 否 1 是")
  private Integer isOrdered;
  @ClassDiscription(name="最小交易数量", description="")
  private Double minTradeQty;
  @ClassDiscription(name="交易单位", description="")
  private Double tradeUnit;
  @ClassDiscription(name="是否允许摘牌", description="")
  private String isPickOff;
  @ClassDiscription(name="是否允许议价", description="")
  private String isSuborder;
  @ClassDiscription(name="商品资源属性表", description="")
  private Set<GoodsResourceProperty> goodsResourceProperties;
  @ClassDiscription(name="交收类型", description="交收类型 0：协议交收 1：自主交收")
  private Integer tradeType;
  @ClassDiscription(name="", description="付款类型  0 先款后货  1 先货后款 2 不限制")
  private Integer payType;
  
  public Integer getIsOrdered()
  {
    return this.isOrdered;
  }
  
  public void setIsOrdered(Integer paramInteger)
  {
    this.isOrdered = paramInteger;
  }
  
  public Long getResourceID()
  {
    return this.resourceID;
  }
  
  public void setResourceID(Long paramLong)
  {
    this.resourceID = paramLong;
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
  
  public String getRemark()
  {
    return this.remark;
  }
  
  public void setRemark(String paramString)
  {
    this.remark = paramString;
  }
  
  public String getTraderID()
  {
    return this.traderID;
  }
  
  public void setTraderID(String paramString)
  {
    this.traderID = paramString;
  }
  
  public Integer getValidTime()
  {
    return this.validTime;
  }
  
  public void setValidTime(Integer paramInteger)
  {
    this.validTime = paramInteger;
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
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return new StandardModel.PrimaryInfo("resourceID", this.resourceID);
  }
  
  public void addGoodsResourceProperty(GoodsResourceProperty paramGoodsResourceProperty)
  {
    if (this.goodsResourceProperties == null) {
      synchronized (this)
      {
        if (this.goodsResourceProperties == null) {
          this.goodsResourceProperties = new HashSet();
        }
      }
    }
    this.goodsResourceProperties.add(paramGoodsResourceProperty);
  }
  
  public OrderBO getOrderBO()
  {
    OrderBO localOrderBO = new OrderBO();
    localOrderBO.orderPO = new OrderPO();
    localOrderBO.goodsPropertyPOList = new ArrayList();
    localOrderBO.orderPO.setBSFlag(getBsFlag());
    if (getCategoryID() != null) {
      localOrderBO.orderPO.setCategoryID(getCategoryID().longValue());
    }
    localOrderBO.orderPO.setBreedID(this.belongtoBreed.getBreedID().longValue());
    localOrderBO.orderPO.setDeliveryDay(Tools.utilDateTosqlDate(getDeliveryDay()));
    if (getDeliveryMargin_B() != null) {
      localOrderBO.orderPO.setDeliveryMargin_b(getDeliveryMargin_B().doubleValue());
    }
    if (getDeliveryMargin_S() != null) {
      localOrderBO.orderPO.setDeliveryMargin_s(getDeliveryMargin_S().doubleValue());
    }
    if (getDeliveryType() != null) {
      localOrderBO.orderPO.setDeliveryType(Integer.parseInt(getDeliveryType()));
    }
    if (getDeliveryPreTime() != null) {
      localOrderBO.orderPO.setDeliveryPreTime(getDeliveryPreTime().intValue());
    }
    localOrderBO.orderPO.setFirmID(getBelongtoMFirm().getFirmID());
    localOrderBO.orderPO.setOrderTitle(getOrderTitle());
    localOrderBO.orderPO.setValidTime(getValidTime().intValue());
    if (getPrice() != null) {
      localOrderBO.orderPO.setPrice(getPrice().doubleValue());
    }
    if (getQuantity() != null) {
      localOrderBO.orderPO.setQuantity(getQuantity().doubleValue());
    }
    localOrderBO.orderPO.setRemark(getRemark());
    if (getTradeMargin_B() != null) {
      localOrderBO.orderPO.setTradeMargin_b(getTradeMargin_B().doubleValue());
    }
    if (getTradeMargin_S() != null) {
      localOrderBO.orderPO.setTradeMargin_s(getTradeMargin_S().doubleValue());
    }
    if (getTradePreTime() != null) {
      localOrderBO.orderPO.setTradePreTime(getTradePreTime().intValue());
    }
    localOrderBO.orderPO.setTraderID(getTraderID());
    localOrderBO.orderPO.setUnit(getUnit());
    if (getWarehouseID() != null) {
      localOrderBO.orderPO.setWarehouseID(getWarehouseID());
    } else {
      localOrderBO.orderPO.setDeliveryAddress(getDeliveryAddress());
    }
    localOrderBO.orderPO.setTradeUnit(getTradeUnit().doubleValue());
    localOrderBO.orderPO.setMinTradeQty(getMinTradeQty().doubleValue());
    localOrderBO.orderPO.setIsPickoff(getIsPickOff());
    localOrderBO.orderPO.setIsSuborder(getIsSuborder());
    if (getTradeType() != null) {
      localOrderBO.orderPO.setTradeType(getTradeType().intValue());
    }
    if (getPayType() != null) {
      localOrderBO.orderPO.setPayType(getPayType().intValue());
    }
    if (getDeliveryDayType() != null) {
      localOrderBO.orderPO.setDeliveryDayType(getDeliveryDayType().intValue());
    }
    if ((getGoodsResourceProperties() != null) && (getGoodsResourceProperties().size() > 0))
    {
      GoodsPropertyPO localGoodsPropertyPO = null;
      Iterator localIterator = getGoodsResourceProperties().iterator();
      while (localIterator.hasNext())
      {
        GoodsResourceProperty localGoodsResourceProperty = (GoodsResourceProperty)localIterator.next();
        localGoodsPropertyPO = new GoodsPropertyPO();
        if (getResourceID() != null) {
          localGoodsPropertyPO.setOrderID(getResourceID().longValue());
        }
        localGoodsPropertyPO.setPropertyName(localGoodsResourceProperty.getPropertyName());
        localGoodsPropertyPO.setPropertyValue(localGoodsResourceProperty.getPropertyValue());
        localOrderBO.goodsPropertyPOList.add(localGoodsPropertyPO);
      }
    }
    return localOrderBO;
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
}
