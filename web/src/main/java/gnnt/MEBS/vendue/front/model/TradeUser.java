package gnnt.MEBS.vendue.front.model;

public class TradeUser
{
  private String userCode;
  private Double Overdraft;
  private int isEntry;
  private int tradeCount;
  private int limits;
  private int isContinueOrder;
  
  public String getUserCode()
  {
    return this.userCode;
  }
  
  public void setUserCode(String paramString)
  {
    this.userCode = paramString;
  }
  
  public Double getOverdraft()
  {
    return this.Overdraft;
  }
  
  public void setOverdraft(Double paramDouble)
  {
    this.Overdraft = paramDouble;
  }
  
  public int getIsEntry()
  {
    return this.isEntry;
  }
  
  public void setIsEntry(int paramInt)
  {
    this.isEntry = paramInt;
  }
  
  public int getTradeCount()
  {
    return this.tradeCount;
  }
  
  public void setTradeCount(int paramInt)
  {
    this.tradeCount = paramInt;
  }
  
  public int getLimits()
  {
    return this.limits;
  }
  
  public void setLimits(int paramInt)
  {
    this.limits = paramInt;
  }
  
  public int getIsContinueOrder()
  {
    return this.isContinueOrder;
  }
  
  public void setIsContinueOrder(int paramInt)
  {
    this.isContinueOrder = paramInt;
  }
}
