package gnnt.MEBS.priceranking.server.rmi;

import gnnt.MEBS.priceranking.server.model.SystemPartition;
import gnnt.MEBS.priceranking.server.model.SystemStatus;
import java.rmi.Remote;
import java.rmi.RemoteException;
import java.util.Map;

public abstract interface ServerRMI
  extends Remote
{
  public abstract int openSystem(short paramShort)
    throws RemoteException;
  
  public abstract int startSystem(short paramShort)
    throws RemoteException;
  
  public abstract int forceStartTrade(short paramShort)
    throws RemoteException;
  
  public abstract int ctlSystem(short paramShort, int paramInt)
    throws RemoteException;
  
  public abstract int endSystem(short paramShort)
    throws RemoteException;
  
  public abstract int endSystemUpdateTrade(short paramShort)
    throws RemoteException;
  
  public abstract int closeSystem(short paramShort)
    throws RemoteException;
  
  public abstract SystemStatus getSystemStatus(short paramShort)
    throws RemoteException;
  
  public abstract long getDiffTime()
    throws RemoteException;
  
  public abstract String getSystemTime()
    throws RemoteException;
  
  public abstract Map<Short, SystemPartition> getSystemPartition()
    throws RemoteException;
  
  public abstract void refreshCommodity(short paramShort)
    throws RemoteException;
  
  public abstract void refreshFirm()
    throws RemoteException;
  
  public abstract void refreshFirmModeAndAmout()
    throws RemoteException;
  
  public abstract void refreshSystemPartition()
    throws RemoteException;
  
  public abstract void refreshSpecialFee()
    throws RemoteException;
  
  public abstract void refreshSpecialMargin()
    throws RemoteException;
  
  public abstract void removeCommodity(short paramShort, String paramString)
    throws RemoteException;
}
