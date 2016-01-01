package gnnt.MEBS.priceranking.server.model;

import java.io.Serializable;

public class TradeTime
  implements Serializable
{
  private static final long serialVersionUID = 1L;
  private int unitId;
  private short unitType;
  private short tradePartition;
  private short startMode;
  private String startTime;
  private long durativeTime;
  private String countdownStart;
  private String countdownTime;
  private long quarterTime;
  private String forcedEndTime;
  private short isMarginCount;
  public static final short UNITTYPE_TRADE = 1;
  public static final short UNITTYPE_REST = 2;
  public static final short STARTMODE_TIME = 1;
  public static final short STARTMODE_MANUAL = 2;
  public static final short STARTMODE_FLOW = 3;
  
  public int getUnitId()
  {
    return this.unitId;
  }
  
  public void setUnitId(int unitId)
  {
    this.unitId = unitId;
  }
  
  public short getUnitType()
  {
    return this.unitType;
  }
  
  public void setUnitType(short unitType)
  {
    this.unitType = unitType;
  }
  
  public short getTradePartition()
  {
    return this.tradePartition;
  }
  
  public void setTradePartition(short tradePartition)
  {
    this.tradePartition = tradePartition;
  }
  
  public short getStartMode()
  {
    return this.startMode;
  }
  
  public void setStartMode(short startMode)
  {
    this.startMode = startMode;
  }
  
  public String getStartTime()
  {
    return this.startTime;
  }
  
  public void setStartTime(String startTime)
  {
    this.startTime = startTime;
  }
  
  public long getDurativeTime()
  {
    return this.durativeTime;
  }
  
  public void setDurativeTime(long durativeTime)
  {
    this.durativeTime = durativeTime;
  }
  
  public String getForcedEndTime()
  {
    return this.forcedEndTime;
  }
  
  public void setForcedEndTime(String forcedEndTime)
  {
    this.forcedEndTime = forcedEndTime;
  }
  
  public String getCountdownStart()
  {
    return this.countdownStart;
  }
  
  public void setCountdownStart(String countdownStart)
  {
    this.countdownStart = countdownStart;
  }
  
  public String getCountdownTime()
  {
    return this.countdownTime;
  }
  
  public void setCountdownTime(String countdownTime)
  {
    this.countdownTime = countdownTime;
  }
  
  public long getQuarterTime()
  {
    return this.quarterTime;
  }
  
  public void setQuarterTime(long quarterTime)
  {
    this.quarterTime = quarterTime;
  }
  
  public short getIsMarginCount()
  {
    return this.isMarginCount;
  }
  
  public void setIsMarginCount(short isMarginCount)
  {
    this.isMarginCount = isMarginCount;
  }
}
