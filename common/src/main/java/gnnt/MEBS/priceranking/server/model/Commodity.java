package gnnt.MEBS.priceranking.server.model;

import java.io.Serializable;
import java.util.Date;
import java.util.Map;

public class Commodity
  implements Serializable
{
  private static final long serialVersionUID = 1L;
  private String code;
  private short tradePartition;
  private SystemPartition systemPartition;
  private Date firstTime;
  private String commodityId;
  private Date createTime;
  private short status;
  private short breedId;
  private int splitId;
  private String userId;
  private double amount;
  private double tradeUnit;
  private double minAmount;
  private double maxAmount;
  private short flowAmountAlgr;
  private double flowAmount;
  private Double beginPrice;
  private Double alertPrice;
  private Double stepPrice;
  private Double maxStepPrice;
  private short marginAlgr;
  private Double b_security;
  private Double s_security;
  private short feeAlgr;
  private Double b_fee;
  private Double s_fee;
  private short bs_flag;
  private short authorization;
  private Map<String, Object> commExtMap;
  private long startTime;
  private long endTime;
  private short isOrder;
  private Double newPrice;
  private double tradeAmount;
  private String newOrderTime;
  private String newFirmId;
  public static final short MARGINALGR_PERCENT = 1;
  public static final short MARGINALGR_ABSOLUTE = 2;
  public static final short FEEALGR_PERCENT = 1;
  public static final short FEEALGR_ABSOLUTE = 2;
  public static final short FLOWAMOUNTALGR_ABSOLUTE = 0;
  public static final short FLOWAMOUNTALGR_PERCENT = 1;
  public static final short STATUS_DEAL = 1;
  public static final short STATUS_NODEAL = 2;
  public static final short AUTHORIZATION_ALL = 0;
  public static final short AUTHORIZATION_YES = 1;
  public static final short AUTHORIZATION_NO = 2;
  public static final short ISORDER_NO = 0;
  public static final short ISORDER_YES = 1;
  
  public String getCode()
  {
    return this.code;
  }
  
  public void setCode(String code)
  {
    this.code = code;
  }
  
  public short getTradePartition()
  {
    return this.tradePartition;
  }
  
  public void setTradePartition(short tradePartition)
  {
    this.tradePartition = tradePartition;
  }
  
  public SystemPartition getSystemPartition()
  {
    return this.systemPartition;
  }
  
  public void setSystemPartition(SystemPartition systemPartition)
  {
    this.systemPartition = systemPartition;
  }
  
  public Date getFirstTime()
  {
    return this.firstTime;
  }
  
  public void setFirstTime(Date firstTime)
  {
    this.firstTime = firstTime;
  }
  
  public String getCommodityId()
  {
    return this.commodityId;
  }
  
  public void setCommodityId(String commodityId)
  {
    this.commodityId = commodityId;
  }
  
  public Date getCreateTime()
  {
    return this.createTime;
  }
  
  public void setCreateTime(Date createTime)
  {
    this.createTime = createTime;
  }
  
  public short getStatus()
  {
    return this.status;
  }
  
  public void setStatus(short status)
  {
    this.status = status;
  }
  
  public short getBreedId()
  {
    return this.breedId;
  }
  
  public void setBreedId(short breedId)
  {
    this.breedId = breedId;
  }
  
  public int getSplitId()
  {
    return this.splitId;
  }
  
  public void setSplitId(int splitId)
  {
    this.splitId = splitId;
  }
  
  public String getUserId()
  {
    return this.userId;
  }
  
  public void setUserId(String userId)
  {
    this.userId = userId;
  }
  
  public double getAmount()
  {
    return this.amount;
  }
  
  public void setAmount(double amount)
  {
    this.amount = amount;
  }
  
  public double getTradeUnit()
  {
    return this.tradeUnit;
  }
  
  public void setTradeUnit(double tradeUnit)
  {
    this.tradeUnit = tradeUnit;
  }
  
  public double getMinAmount()
  {
    return this.minAmount;
  }
  
  public void setMinAmount(double minAmount)
  {
    this.minAmount = minAmount;
  }
  
  public double getMaxAmount()
  {
    return this.maxAmount;
  }
  
  public void setMaxAmount(double maxAmount)
  {
    this.maxAmount = maxAmount;
  }
  
  public short getFlowAmountAlgr()
  {
    return this.flowAmountAlgr;
  }
  
  public void setFlowAmountAlgr(short flowAmountAlgr)
  {
    this.flowAmountAlgr = flowAmountAlgr;
  }
  
  public double getFlowAmount()
  {
    return this.flowAmount;
  }
  
  public void setFlowAmount(double flowAmount)
  {
    this.flowAmount = flowAmount;
  }
  
  public Double getBeginPrice()
  {
    return this.beginPrice;
  }
  
  public void setBeginPrice(Double beginPrice)
  {
    this.beginPrice = beginPrice;
  }
  
  public Double getAlertPrice()
  {
    return this.alertPrice;
  }
  
  public void setAlertPrice(Double alertPrice)
  {
    this.alertPrice = alertPrice;
  }
  
  public Double getStepPrice()
  {
    return this.stepPrice;
  }
  
  public void setStepPrice(Double stepPrice)
  {
    this.stepPrice = stepPrice;
  }
  
  public Double getMaxStepPrice()
  {
    return this.maxStepPrice;
  }
  
  public void setMaxStepPrice(Double maxStepPrice)
  {
    this.maxStepPrice = maxStepPrice;
  }
  
  public short getMarginAlgr()
  {
    return this.marginAlgr;
  }
  
  public void setMarginAlgr(short marginAlgr)
  {
    this.marginAlgr = marginAlgr;
  }
  
  public Double getB_security()
  {
    return this.b_security;
  }
  
  public void setB_security(Double bSecurity)
  {
    this.b_security = bSecurity;
  }
  
  public Double getS_security()
  {
    return this.s_security;
  }
  
  public void setS_security(Double sSecurity)
  {
    this.s_security = sSecurity;
  }
  
  public short getFeeAlgr()
  {
    return this.feeAlgr;
  }
  
  public void setFeeAlgr(short feeAlgr)
  {
    this.feeAlgr = feeAlgr;
  }
  
  public Double getB_fee()
  {
    return this.b_fee;
  }
  
  public void setB_fee(Double bFee)
  {
    this.b_fee = bFee;
  }
  
  public Double getS_fee()
  {
    return this.s_fee;
  }
  
  public void setS_fee(Double sFee)
  {
    this.s_fee = sFee;
  }
  
  public short getAuthorization()
  {
    return this.authorization;
  }
  
  public void setAuthorization(short authorization)
  {
    this.authorization = authorization;
  }
  
  public long getStartTime()
  {
    return this.startTime;
  }
  
  public void setStartTime(long startTime)
  {
    this.startTime = startTime;
  }
  
  public long getEndTime()
  {
    return this.endTime;
  }
  
  public void setEndTime(long endTime)
  {
    this.endTime = endTime;
  }
  
  public Double getNewPrice()
  {
    return this.newPrice;
  }
  
  public void setNewPrice(Double newPrice)
  {
    this.newPrice = newPrice;
  }
  
  public double getTradeAmount()
  {
    return this.tradeAmount;
  }
  
  public void setTradeAmount(double tradeAmount)
  {
    this.tradeAmount = tradeAmount;
  }
  
  public String getNewOrderTime()
  {
    return this.newOrderTime;
  }
  
  public void setNewOrderTime(String newOrderTime)
  {
    this.newOrderTime = newOrderTime;
  }
  
  public Map<String, Object> getCommExtMap()
  {
    return this.commExtMap;
  }
  
  public void setCommExtMap(Map<String, Object> commExtMap)
  {
    this.commExtMap = commExtMap;
  }
  
  public String getNewFirmId()
  {
    return this.newFirmId;
  }
  
  public void setNewFirmId(String newFirmId)
  {
    this.newFirmId = newFirmId;
  }
  
  public short getIsOrder()
  {
    return this.isOrder;
  }
  
  public void setIsOrder(short isOrder)
  {
    this.isOrder = isOrder;
  }
  
  public short getBs_flag()
  {
    return this.bs_flag;
  }
  
  public void setBs_flag(short bsFlag)
  {
    this.bs_flag = bsFlag;
  }
}
