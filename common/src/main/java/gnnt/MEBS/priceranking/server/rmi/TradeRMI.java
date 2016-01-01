package gnnt.MEBS.priceranking.server.rmi;

import gnnt.MEBS.checkLogon.vo.front.TraderLogonInfo;
import gnnt.MEBS.priceranking.server.model.Commodity;
import gnnt.MEBS.priceranking.server.model.CommodityQuotation;
import gnnt.MEBS.priceranking.server.model.Order;
import gnnt.MEBS.priceranking.server.model.ResultOrder;
import gnnt.MEBS.priceranking.server.model.SystemStatus;
import gnnt.MEBS.priceranking.server.model.Trader;
import java.rmi.Remote;
import java.rmi.RemoteException;
import java.util.List;
import java.util.Map;

public abstract interface TradeRMI
  extends Remote
{
  public abstract TraderLogonInfo logon(Trader paramTrader)
    throws RemoteException, Exception;
  
  public abstract void loadLoginUserInfoByTraderID(String paramString)
    throws RemoteException, Exception;
  
  public abstract List getTraders()
    throws RemoteException, Exception;
  
  public abstract boolean isLogon(String paramString, long paramLong)
    throws RemoteException, Exception;
  
  public abstract TraderLogonInfo remoteLogon(String paramString1, long paramLong, String paramString2)
    throws RemoteException, Exception;
  
  public abstract void logoff(long paramLong)
    throws Exception;
  
  public abstract String getUserID(long paramLong, int paramInt, String paramString)
    throws RemoteException, Exception;
  
  public abstract int changePassowrd(String paramString1, String paramString2, String paramString3, String paramString4)
    throws RemoteException;
  
  public abstract TraderLogonInfo getTraderInfo(String paramString)
    throws RemoteException;
  
  public abstract ResultOrder addOrder(short paramShort, Order paramOrder, long paramLong, int paramInt, String paramString)
    throws RemoteException, Exception;
  
  public abstract SystemStatus getSystemStatus(short paramShort)
    throws RemoteException;
  
  public abstract List getCommodityCode(short paramShort)
    throws RemoteException;
  
  public abstract String getCounterCommodity(short paramShort, String paramString)
    throws RemoteException;
  
  public abstract Map getCommodityHQ(short paramShort, String paramString)
    throws RemoteException;
  
  public abstract Map getCommodityHQCount(short paramShort, String paramString)
    throws RemoteException;
  
  public abstract void setCountdownFlag(short paramShort1, String paramString, short paramShort2)
    throws RemoteException;
  
  public abstract int getRightNowCountdown(short paramShort, String paramString)
    throws RemoteException;
  
  public abstract Commodity getCurCommodity(short paramShort, String paramString)
    throws RemoteException;
  
  public abstract CommodityQuotation getAllCommodityQuotation(short paramShort)
    throws RemoteException;
  
  public abstract CommodityQuotation getAllCommodityQuotationByCount(short paramShort, long paramLong)
    throws RemoteException;
  
  public abstract String getCounterCommodity(short paramShort)
    throws RemoteException;
  
  public abstract int getRightNowCountdown(short paramShort)
    throws RemoteException;
  
  public abstract int getNextSection(short paramShort)
    throws RemoteException;
}
