package gnnt.MEBS.common.broker.model;

public class MyMenu
  extends StandardModel
{
  private static final long serialVersionUID = 1L;
  private Broker broker;
  private Right right;
  
  public Broker getBroker()
  {
    return this.broker;
  }
  
  public void setBroker(Broker broker)
  {
    this.broker = broker;
  }
  
  public Right getRight()
  {
    return this.right;
  }
  
  public void setRight(Right right)
  {
    this.right = right;
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return null;
  }
}
