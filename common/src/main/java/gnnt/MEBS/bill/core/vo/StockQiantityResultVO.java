package gnnt.MEBS.bill.core.vo;

public class StockQiantityResultVO
  extends ResultVO
{
  private static final long serialVersionUID = 6364908498625245935L;
  private double quantity;
  
  public double getQuantity()
  {
    return this.quantity;
  }
  
  public void setQuantity(double paramDouble)
  {
    this.quantity = paramDouble;
  }
}
