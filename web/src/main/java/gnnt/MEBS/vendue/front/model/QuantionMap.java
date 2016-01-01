package gnnt.MEBS.vendue.front.model;

import gnnt.MEBS.priceranking.server.model.CommodityOrder;
import gnnt.MEBS.priceranking.server.model.Order;
import gnnt.MEBS.priceranking.server.model.SystemPartition;
import gnnt.MEBS.priceranking.server.rmi.ServerRMI;
import gnnt.MEBS.priceranking.server.rmi.TradeRMI;
import gnnt.MEBS.vendue.front.init.InitLoad;
import gnnt.MEBS.vendue.front.service.TradeService;
import java.rmi.RemoteException;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

public class QuantionMap
{
  TradeService tradeService = (TradeService)InitLoad.getTradeObject("tradeService");
  TradeRMI tradeRMI = this.tradeService.getTradeRMI();
  ServerRMI serverRMI = this.tradeService.getServerRMI();
  Map<Short, Map<String, CommodityOrder>> map = new HashMap();
  Map<Short, Long> mapCnt = new HashMap();
  Map<Short, Integer> mapStatus = new HashMap();
  private static QuantionMap quantionMap;
  
  public int getStatus(short paramShort)
  {
    return ((Integer)this.mapStatus.get(Short.valueOf(paramShort))).intValue();
  }
  
  public void setStatus(int paramInt, short paramShort)
  {
    this.mapStatus.put(Short.valueOf(paramShort), Integer.valueOf(paramInt));
  }
  
  private QuantionMap(Map<Short, SystemPartition> paramMap)
  {
    Iterator localIterator = paramMap.values().iterator();
    while (localIterator.hasNext())
    {
      SystemPartition localSystemPartition = (SystemPartition)localIterator.next();
      HashMap localHashMap = new HashMap();
      this.map.put(Short.valueOf(localSystemPartition.getPartitionId()), localHashMap);
      this.mapCnt.put(Short.valueOf(localSystemPartition.getPartitionId()), Long.valueOf(-1L));
      this.mapStatus.put(Short.valueOf(localSystemPartition.getPartitionId()), Integer.valueOf(0));
    }
  }
  
  public static QuantionMap getInit()
  {
    if (quantionMap == null)
    {
      TradeService localTradeService = (TradeService)InitLoad.getTradeObject("tradeService");
      ServerRMI localServerRMI = localTradeService.getServerRMI();
      try
      {
        Map localMap = localServerRMI.getSystemPartition();
        quantionMap = new QuantionMap(localMap);
      }
      catch (RemoteException localRemoteException)
      {
        localRemoteException.printStackTrace();
      }
    }
    return quantionMap;
  }
  
  public Map<String, CommodityOrder> getHqMap(short paramShort)
  {
    return (Map)this.map.get(Short.valueOf(paramShort));
  }
  
  public void setHqMap(short paramShort, Map paramMap)
  {
    Map localMap = (Map)this.map.get(Short.valueOf(paramShort));
    localMap.clear();
    localMap.putAll(paramMap);
  }
  
  public long getHqCount(short paramShort)
  {
    return ((Long)this.mapCnt.get(Short.valueOf(paramShort))).longValue();
  }
  
  public void setHqCount(short paramShort, long paramLong)
  {
    this.mapCnt.put(Short.valueOf(paramShort), Long.valueOf(paramLong));
  }
  
  public List<Order> getAloneHq(short paramShort, String paramString)
  {
    LinkedList localLinkedList = null;
    CommodityOrder localCommodityOrder = (CommodityOrder)((Map)this.map.get(Short.valueOf(paramShort))).get(paramString);
    localLinkedList = localCommodityOrder.getTradeOrders();
    return localLinkedList;
  }
  
  public void clear(short paramShort)
  {
    ((Map)this.map.get(Short.valueOf(paramShort))).clear();
    this.mapCnt.put(Short.valueOf(paramShort), Long.valueOf(-1L));
  }
}
