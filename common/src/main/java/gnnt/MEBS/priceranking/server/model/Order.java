package gnnt.MEBS.priceranking.server.model;

import java.io.Serializable;
import java.util.Date;

public class Order
  implements Serializable
{
  private static final long serialVersionUID = 1L;
  private long orderId;
  private short tradePartition;
  private String code;
  private String commodityId;
  private Double price;
  private double amount;
  private String traderId;
  private String userId;
  private long submitTime;
  private short tradeFlag;
  private double validAmount;
  private Date modifytime;
  private double totalAmount;
  private Double frozenMargin;
  private Double frozenFee;
  private Double unFrozenMargin;
  private Double unFrozenFee;
  private short withdrawType;
  private short authorization;
  private short toitsType;
  public static final short TRADEFLAG_NODEAL = 0;
  public static final short TRADEFLAG_ALLDEAL = 1;
  public static final short TRADEFLAG_SOMEDEAL = 2;
  public static final short TRADEFLAG_REMOVE = 3;
  public static final short TRADEFLAG_DEALANDREMOVE = 4;
  public static final short TRADEFLAG_PARTREMOVE = 5;
  public static final short WITHDRAWTYPE_ORDERREMOVE = 0;
  public static final short WITHDRAWTYPE_FLOW = 1;
  public static final short AUTHORIZATION_All = 0;
  public static final short AUTHORIZATION_YES = 1;
  public static final short AUTHORIZATION_NO = 2;
  public static final short TOITSTYPE_ORDER = 0;
  public static final short TOITSTYPE_LOSEEFFECTIVE = 1;
  public static final short TOITSTYPE_EFFECTIVE = 2;
  
  public long getOrderId()
  {
    return this.orderId;
  }
  
  public void setOrderId(long orderId)
  {
    this.orderId = orderId;
  }
  
  public short getTradePartition()
  {
    return this.tradePartition;
  }
  
  public void setTradePartition(short tradePartition)
  {
    this.tradePartition = tradePartition;
  }
  
  public String getCode()
  {
    return this.code;
  }
  
  public void setCode(String code)
  {
    this.code = code;
  }
  
  public Double getPrice()
  {
    return this.price;
  }
  
  public void setPrice(Double price)
  {
    this.price = price;
  }
  
  public double getAmount()
  {
    return this.amount;
  }
  
  public void setAmount(double amount)
  {
    this.amount = amount;
  }
  
  public String getTraderId()
  {
    return this.traderId;
  }
  
  public void setTraderId(String traderId)
  {
    this.traderId = traderId;
  }
  
  public String getUserId()
  {
    return this.userId;
  }
  
  public void setUserId(String userId)
  {
    this.userId = userId;
  }
  
  public long getSubmitTime()
  {
    return this.submitTime;
  }
  
  public void setSubmitTime(long submitTime)
  {
    this.submitTime = submitTime;
  }
  
  public short getTradeFlag()
  {
    return this.tradeFlag;
  }
  
  public void setTradeFlag(short tradeFlag)
  {
    this.tradeFlag = tradeFlag;
  }
  
  public double getValidAmount()
  {
    return this.validAmount;
  }
  
  public void setValidAmount(double validAmount)
  {
    this.validAmount = validAmount;
  }
  
  public Date getModifytime()
  {
    return this.modifytime;
  }
  
  public void setModifytime(Date modifytime)
  {
    this.modifytime = modifytime;
  }
  
  public double getTotalAmount()
  {
    return this.totalAmount;
  }
  
  public void setTotalAmount(double totalAmount)
  {
    this.totalAmount = totalAmount;
  }
  
  public Double getFrozenMargin()
  {
    return this.frozenMargin;
  }
  
  public void setFrozenMargin(Double frozenMargin)
  {
    this.frozenMargin = frozenMargin;
  }
  
  public Double getFrozenFee()
  {
    return this.frozenFee;
  }
  
  public void setFrozenFee(Double frozenFee)
  {
    this.frozenFee = frozenFee;
  }
  
  public Double getUnFrozenMargin()
  {
    return this.unFrozenMargin;
  }
  
  public void setUnFrozenMargin(Double unFrozenMargin)
  {
    this.unFrozenMargin = unFrozenMargin;
  }
  
  public Double getUnFrozenFee()
  {
    return this.unFrozenFee;
  }
  
  public void setUnFrozenFee(Double unFrozenFee)
  {
    this.unFrozenFee = unFrozenFee;
  }
  
  public short getWithdrawType()
  {
    return this.withdrawType;
  }
  
  public void setWithdrawType(short withdrawType)
  {
    this.withdrawType = withdrawType;
  }
  
  public short getAuthorization()
  {
    return this.authorization;
  }
  
  public void setAuthorization(short authorization)
  {
    this.authorization = authorization;
  }
  
  public short getToitsType()
  {
    return this.toitsType;
  }
  
  public void setToitsType(short toitsType)
  {
    this.toitsType = toitsType;
  }
  
  public String getCommodityId()
  {
    return this.commodityId;
  }
  
  public void setCommodityId(String commodityId)
  {
    this.commodityId = commodityId;
  }
}
