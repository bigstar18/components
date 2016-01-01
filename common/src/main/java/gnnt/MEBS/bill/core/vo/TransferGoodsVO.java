package gnnt.MEBS.bill.core.vo;

public class TransferGoodsVO
  extends ResultVO
{
  private static final long serialVersionUID = -834115733146395050L;
  private int moduleid;
  private String tradeNO;
  private double quantity;
  
  public double getQuantity()
  {
    return this.quantity;
  }
  
  public void setQuantity(double paramDouble)
  {
    this.quantity = paramDouble;
  }
  
  public int getModuleid()
  {
    return this.moduleid;
  }
  
  public void setModuleid(int paramInt)
  {
    this.moduleid = paramInt;
  }
  
  public String getTradeNO()
  {
    return this.tradeNO;
  }
  
  public void setTradeNO(String paramString)
  {
    this.tradeNO = paramString;
  }
}
