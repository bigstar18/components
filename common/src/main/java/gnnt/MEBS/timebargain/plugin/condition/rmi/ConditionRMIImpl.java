package gnnt.MEBS.timebargain.plugin.condition.rmi;

import gnnt.MEBS.timebargain.plugin.condition.CalculateCenter;
import gnnt.MEBS.timebargain.plugin.condition.model.ConditionOrder;
import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;

public class ConditionRMIImpl
  extends UnicastRemoteObject
  implements ConditionRMI
{
  private CalculateCenter center;
  private static final long serialVersionUID = -4357705192130521298L;
  
  public ConditionRMIImpl()
    throws RemoteException
  {}
  
  public ConditionRMIImpl(CalculateCenter center)
    throws RemoteException
  {
    this.center = center;
  }
  
  public int cancelOrder(ConditionOrder order)
    throws RemoteException
  {
    int ret = 0;
    try
    {
      this.center.removeOrder(order);
    }
    catch (Exception e)
    {
      e.printStackTrace();
      ret = -1;
    }
    return ret;
  }
  
  public int receiveOrder(ConditionOrder order)
    throws RemoteException
  {
    int ret = 0;
    try
    {
      this.center.putOrder(order);
    }
    catch (Exception e)
    {
      e.printStackTrace();
      ret = -1;
    }
    return ret;
  }
}
