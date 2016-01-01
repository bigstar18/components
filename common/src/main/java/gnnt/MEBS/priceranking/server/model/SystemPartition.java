package gnnt.MEBS.priceranking.server.model;

import java.io.Serializable;

public class SystemPartition
  implements Serializable
{
  private static final long serialVersionUID = 1L;
  private short partitionId;
  private String firmLimitClass;
  private String validetCommodityClass;
  private String tradeRuleClass;
  private String bargainActionClass;
  private String kernelEngineClass;
  private String countdownClass;
  private short validFlag;
  private String description;
  private short tradeMode;
  private short isShowQuotation;
  private short countMode;
  private short isMarginCount;
  private short isSplitTarget;
  private short isShowPrice;
  public static final short VALIDFLAG_NO = 0;
  public static final short VALIDFLAG_YES = 1;
  public static final short TRADEMODE_BUY = 1;
  public static final short TRADEMODE_SELL = 2;
  public static final short TRADEMODE_BID = 3;
  public static final short SHOWQUOTATION_YES = 0;
  public static final short SHOWQUOTATION_NO = 1;
  public static final short COUNTMODE_COMMODITY = 0;
  public static final short COUNTMODE_TRADETIME = 1;
  public static final short MARGINCOUNT_YES = 1;
  public static final short MARGINCOUNT_NO = 0;
  public static final short SPLITTARGET_YES = 1;
  public static final short SPLITTARGET_NO = 0;
  
  public short getPartitionId()
  {
    return this.partitionId;
  }
  
  public void setPartitionId(short partitionId)
  {
    this.partitionId = partitionId;
  }
  
  public String getFirmLimitClass()
  {
    return this.firmLimitClass;
  }
  
  public void setFirmLimitClass(String firmLimitClass)
  {
    this.firmLimitClass = firmLimitClass;
  }
  
  public String getValidetCommodityClass()
  {
    return this.validetCommodityClass;
  }
  
  public void setValidetCommodityClass(String validetCommodityClass)
  {
    this.validetCommodityClass = validetCommodityClass;
  }
  
  public String getTradeRuleClass()
  {
    return this.tradeRuleClass;
  }
  
  public void setTradeRuleClass(String tradeRuleClass)
  {
    this.tradeRuleClass = tradeRuleClass;
  }
  
  public String getBargainActionClass()
  {
    return this.bargainActionClass;
  }
  
  public void setBargainActionClass(String bargainActionClass)
  {
    this.bargainActionClass = bargainActionClass;
  }
  
  public String getKernelEngineClass()
  {
    return this.kernelEngineClass;
  }
  
  public void setKernelEngineClass(String kernelEngineClass)
  {
    this.kernelEngineClass = kernelEngineClass;
  }
  
  public String getCountdownClass()
  {
    return this.countdownClass;
  }
  
  public void setCountdownClass(String countdownClass)
  {
    this.countdownClass = countdownClass;
  }
  
  public short getValidFlag()
  {
    return this.validFlag;
  }
  
  public void setValidFlag(short validFlag)
  {
    this.validFlag = validFlag;
  }
  
  public String getDescription()
  {
    return this.description;
  }
  
  public void setDescription(String description)
  {
    this.description = description;
  }
  
  public short getTradeMode()
  {
    return this.tradeMode;
  }
  
  public void setTradeMode(short tradeMode)
  {
    this.tradeMode = tradeMode;
  }
  
  public short getIsShowQuotation()
  {
    return this.isShowQuotation;
  }
  
  public void setIsShowQuotation(short isShowQuotation)
  {
    this.isShowQuotation = isShowQuotation;
  }
  
  public short getCountMode()
  {
    return this.countMode;
  }
  
  public void setCountMode(short countMode)
  {
    this.countMode = countMode;
  }
  
  public short getIsMarginCount()
  {
    return this.isMarginCount;
  }
  
  public void setIsMarginCount(short isMarginCount)
  {
    this.isMarginCount = isMarginCount;
  }
  
  public short getIsSplitTarget()
  {
    return this.isSplitTarget;
  }
  
  public void setIsSplitTarget(short isSplitTarget)
  {
    this.isSplitTarget = isSplitTarget;
  }
  
  public short getIsShowPrice()
  {
    return this.isShowPrice;
  }
  
  public void setIsShowPrice(short isShowPrice)
  {
    this.isShowPrice = isShowPrice;
  }
}
