package gnnt.MEBS.espot.mgr.model.trademanage;

import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.mgr.model.translate.ClassDiscription;
import gnnt.MEBS.common.mgr.statictools.Tools;
import gnnt.MEBS.espot.mgr.model.commoditymanage.Breed;
import gnnt.MEBS.espot.mgr.model.holdingmanage.Holding;
import gnnt.MEBS.espot.mgr.model.reservemanage.Reserve;
import java.util.Date;
import java.util.Map;
import java.util.Set;

public class TradeContract
  extends StandardModel
{
  private static final long serialVersionUID = 1L;
  @ClassDiscription(name="成交合同号", description="")
  private Long tradeNo;
  @ClassDiscription(name="商品标题", description="")
  private String orderTitle;
  @ClassDiscription(name="关联品名", description="对应品名ID")
  private Breed breed;
  @ClassDiscription(name="买方交易商代码", description="")
  private String BFirmId;
  @ClassDiscription(name="卖方交易商代码", description="")
  private String SFirmId;
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
  private Double tradeMargin_s;
  @ClassDiscription(name="交收日期", description="")
  private Date deliveryDay;
  @ClassDiscription(name="买方履约保证金", description="")
  private Double deliveryMargin_B;
  @ClassDiscription(name="", description="卖方履约保证金")
  private Double deliveryMargin_s;
  @ClassDiscription(name="交收地类型", description="交收地类型 1：指定仓库    2：指定交收地")
  private String deliveryType;
  @ClassDiscription(name="交收仓库号", description="")
  private String warehouseId;
  @ClassDiscription(name="交收地点", description="")
  private String deliveryAddress;
  @ClassDiscription(name="合同签订时间", description="")
  private Date time;
  @ClassDiscription(name="合同备注", description="")
  private String remark;
  @ClassDiscription(name="合同状态", description="合同状态0：订单状态 1：订单阶段违约 2：订单阶段系统撤销 3：成交阶段 4：成交阶段违约 5：货、款到位 6：支付首款 7：支付尾款  8：正常结束")
  private Integer status;
  @ClassDiscription(name="委托号", description="")
  private Long orderId;
  @ClassDiscription(name="买方交易手续费", description="")
  private Double buyTradeFee;
  @ClassDiscription(name="买方已付交易手续费", description="")
  private Double buyPayTradeFee;
  @ClassDiscription(name="买方交收手续费", description="")
  private Double buyDeliveryFee;
  @ClassDiscription(name="买方已付交收手续费", description="")
  private Double buyPayDeliveryFee;
  @ClassDiscription(name="卖方交易手续费", description="")
  private Double sellTradeFee;
  @ClassDiscription(name="卖方已付交易手续费", description="")
  private Double sellPayTradeFee;
  @ClassDiscription(name="卖方交收手续费", description="")
  private Double sellDeliveryFee;
  @ClassDiscription(name="卖方已付交收手续费", description="")
  private Double sellPayDeliveryFee;
  @ClassDiscription(name="关联合同商品属性", description="对应合同商品属性ID")
  private Set<TradeGoodsProperty> tradeGoodsProperties;
  @ClassDiscription(name="关联订单", description="对应订单号")
  private Set<Reserve> belongToReserve;
  @ClassDiscription(name="关联持仓", description="对应持仓号")
  private Set<Holding> belongToHolding;
  @ClassDiscription(name="交收类型", description="交收类型 0： 协议交收 1：自主交收")
  private Integer tradeType;
  @ClassDiscription(name="付款类型", description="付款类型  0： 先款后货 1： 先货后款 2：不限制")
  private Integer payType;
  @ClassDiscription(name="买方按钮权限", description="")
  private Map<String, Boolean> buyButtonMap;
  @ClassDiscription(name="卖方按钮权限", description="")
  private Map<String, Boolean> sellButtonMap;
  
  public Map<String, Boolean> getSellButtonMap()
  {
    return this.sellButtonMap;
  }
  
  public void setSellButtonMap(Map<String, Boolean> paramMap)
  {
    this.sellButtonMap = paramMap;
  }
  
  public Map<String, Boolean> getBuyButtonMap()
  {
    return this.buyButtonMap;
  }
  
  public void setBuyButtonMap(Map<String, Boolean> paramMap)
  {
    this.buyButtonMap = paramMap;
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
  
  public Set<TradeGoodsProperty> getTradeGoodsProperties()
  {
    return this.tradeGoodsProperties;
  }
  
  public void setTradeGoodsProperties(Set<TradeGoodsProperty> paramSet)
  {
    this.tradeGoodsProperties = paramSet;
  }
  
  public Set<Reserve> getBelongToReserve()
  {
    return this.belongToReserve;
  }
  
  public void setBelongToReserve(Set<Reserve> paramSet)
  {
    this.belongToReserve = paramSet;
  }
  
  public Set<Holding> getBelongToHolding()
  {
    return this.belongToHolding;
  }
  
  public void setBelongToHolding(Set<Holding> paramSet)
  {
    this.belongToHolding = paramSet;
  }
  
  public Long getTradeNo()
  {
    return this.tradeNo;
  }
  
  public void setTradeNo(Long paramLong)
  {
    this.tradeNo = paramLong;
  }
  
  public String getOrderTitle()
  {
    return this.orderTitle;
  }
  
  public void setOrderTitle(String paramString)
  {
    this.orderTitle = paramString;
  }
  
  public String getBFirmId()
  {
    return this.BFirmId;
  }
  
  public void setBFirmId(String paramString)
  {
    this.BFirmId = paramString;
  }
  
  public String getSFirmId()
  {
    return this.SFirmId;
  }
  
  public void setSFirmId(String paramString)
  {
    this.SFirmId = paramString;
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
  
  public Double getTradeMargin_s()
  {
    return this.tradeMargin_s;
  }
  
  public void setTradeMargin_s(Double paramDouble)
  {
    this.tradeMargin_s = paramDouble;
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
  
  public Double getDeliveryMargin_s()
  {
    return this.deliveryMargin_s;
  }
  
  public void setDeliveryMargin_s(Double paramDouble)
  {
    this.deliveryMargin_s = paramDouble;
  }
  
  public String getWarehouseId()
  {
    return this.warehouseId;
  }
  
  public void setWarehouseId(String paramString)
  {
    this.warehouseId = paramString;
  }
  
  public Date getTime()
  {
    return this.time;
  }
  
  public void setTime(Date paramDate)
  {
    this.time = paramDate;
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
  
  public String getDeliveryType()
  {
    return this.deliveryType;
  }
  
  public void setDeliveryType(String paramString)
  {
    this.deliveryType = paramString;
  }
  
  public String getDeliveryAddress()
  {
    return this.deliveryAddress;
  }
  
  public void setDeliveryAddress(String paramString)
  {
    this.deliveryAddress = paramString;
  }
  
  public Double getBuyTradeFee()
  {
    return this.buyTradeFee;
  }
  
  public void setBuyTradeFee(Double paramDouble)
  {
    this.buyTradeFee = paramDouble;
  }
  
  public Double getBuyPayTradeFee()
  {
    return this.buyPayTradeFee;
  }
  
  public void setBuyPayTradeFee(Double paramDouble)
  {
    this.buyPayTradeFee = paramDouble;
  }
  
  public Double getBuyDeliveryFee()
  {
    return this.buyDeliveryFee;
  }
  
  public void setBuyDeliveryFee(Double paramDouble)
  {
    this.buyDeliveryFee = paramDouble;
  }
  
  public Double getBuyPayDeliveryFee()
  {
    return this.buyPayDeliveryFee;
  }
  
  public void setBuyPayDeliveryFee(Double paramDouble)
  {
    this.buyPayDeliveryFee = paramDouble;
  }
  
  public Double getSellTradeFee()
  {
    return this.sellTradeFee;
  }
  
  public void setSellTradeFee(Double paramDouble)
  {
    this.sellTradeFee = paramDouble;
  }
  
  public Double getSellPayTradeFee()
  {
    return this.sellPayTradeFee;
  }
  
  public void setSellPayTradeFee(Double paramDouble)
  {
    this.sellPayTradeFee = paramDouble;
  }
  
  public Double getSellDeliveryFee()
  {
    return this.sellDeliveryFee;
  }
  
  public void setSellDeliveryFee(Double paramDouble)
  {
    this.sellDeliveryFee = paramDouble;
  }
  
  public Double getSellPayDeliveryFee()
  {
    return this.sellPayDeliveryFee;
  }
  
  public void setSellPayDeliveryFee(Double paramDouble)
  {
    this.sellPayDeliveryFee = paramDouble;
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return new StandardModel.PrimaryInfo("tradeNo", this.tradeNo);
  }
}
