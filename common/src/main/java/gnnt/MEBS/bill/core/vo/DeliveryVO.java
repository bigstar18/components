package gnnt.MEBS.bill.core.vo;

public class DeliveryVO
  extends ResultVO
{
  private static final long serialVersionUID = -5539369788199055647L;
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
