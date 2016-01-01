package gnnt.MEBS.espot.front.model.trade;

import gnnt.MEBS.common.front.model.StandardModel;
import gnnt.MEBS.common.front.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.front.model.translate.ClassDiscription;
import gnnt.MEBS.common.front.statictools.Tools;
import gnnt.MEBS.espot.front.model.commodity.Breed;
import java.util.Date;

public class TradeBase
  extends StandardModel
{
  private static final long serialVersionUID = 6368337255162937149L;
  @ClassDiscription(name="合同号", description="")
  private Long tradeNo;
  @ClassDiscription(name="商品标题", description="")
  private String orderTitle;
  @ClassDiscription(name="品名", description="对应品名ID")
  private Breed belongtoBreed;
  @ClassDiscription(name="买方交易商代码", description="")
  private String bfirmID;
  @ClassDiscription(name="卖方交易商代码", description="")
  private String sfirmID;
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
  @ClassDiscription(name="交收日期", description="")
  private Date deliveryDay;
  @ClassDiscription(name="买方交收保证金", description="")
  private Double deliveryMargin_B;
  @ClassDiscription(name="卖方交收保证金", description="")
  private Double deliveryMargin_S;
  @ClassDiscription(name="交收类型", description="交收类型　1：注册仓单交收2：指定交收地")
  private String deliveryType;
  @ClassDiscription(name="交收仓库ID", description="")
  private String warehouseID;
  private String deliveryAddress;
  @ClassDiscription(name="合同签订时间", description="")
  private Date time;
  @ClassDiscription(name="合同备注", description="")
  private String remark;
  @ClassDiscription(name="合同状态", description="合同状态 0：订单状态 1：订单阶段违约 2：订单阶段系统撤销 3：成交阶段 4：成交阶段违约 5：货、款到位 6：支付首款 7：支付尾款  8：支付尾款 21：待违约处理(买方违约) 22：待违约处理（卖方违约）")
  private Integer status;
  @ClassDiscription(name="委托号", description="")
  private Long orderID;
  @ClassDiscription(name="买方交易手续费 ", description="")
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
  @ClassDiscription(name="交收类型", description="交收类型 0：协议交收 1：自主交收")
  private Integer tradeType;
  @ClassDiscription(name="付款类型", description="付款类型 0 ：先款后货1：先货后款  2：不限制")
  private Integer payType;
  
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
  
  public Breed getBelongtoBreed()
  {
    return this.belongtoBreed;
  }
  
  public void setBelongtoBreed(Breed paramBreed)
  {
    this.belongtoBreed = paramBreed;
  }
  
  public String getBfirmID()
  {
    return this.bfirmID;
  }
  
  public void setBfirmID(String paramString)
  {
    this.bfirmID = paramString;
  }
  
  public String getSfirmID()
  {
    return this.sfirmID;
  }
  
  public void setSfirmID(String paramString)
  {
    this.sfirmID = paramString;
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
  
  public Long getOrderID()
  {
    return this.orderID;
  }
  
  public void setOrderID(Long paramLong)
  {
    this.orderID = paramLong;
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
  
  public Integer getTradePreHoure()
  {
    return Tools.secondToHour(this.tradePreTime);
  }
  
  public void setTradePreHoure(int paramInt)
  {
    this.tradePreTime = Tools.HoureToSecond(Integer.valueOf(paramInt));
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
