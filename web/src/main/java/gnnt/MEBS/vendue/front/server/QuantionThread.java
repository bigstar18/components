package gnnt.MEBS.vendue.front.server;

import gnnt.MEBS.priceranking.server.model.Commodity;
import gnnt.MEBS.priceranking.server.model.CommodityOrder;
import gnnt.MEBS.priceranking.server.model.CommodityQuotation;
import gnnt.MEBS.priceranking.server.model.SystemPartition;
import gnnt.MEBS.priceranking.server.model.SystemStatus;
import gnnt.MEBS.priceranking.server.rmi.TradeRMI;
import gnnt.MEBS.vendue.front.model.QuantionMap;
import java.util.Collection;
import java.util.Iterator;
import java.util.Map;

public class QuantionThread
  extends Thread
{
  TradeRMI tradeRmi = null;
  QuantionMap q = null;
  Map<Short, SystemPartition> sysPartitions = null;
  
  public void init(TradeRMI paramTradeRMI, QuantionMap paramQuantionMap, Map<Short, SystemPartition> paramMap)
  {
    this.tradeRmi = paramTradeRMI;
    this.q = paramQuantionMap;
    this.sysPartitions = paramMap;
  }
  
  public void run()
  {
    try
    {
      for (;;)
      {
        Iterator localIterator = this.sysPartitions.values().iterator();
        while (localIterator.hasNext())
        {
          SystemPartition localSystemPartition = (SystemPartition)localIterator.next();
          hqCompare(localSystemPartition.getPartitionId());
        }
        Thread.sleep(100L);
      }
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
    }
  }
  
  public void hqCompare(short paramShort)
  {
    try
    {
      SystemStatus localSystemStatus = this.tradeRmi.getSystemStatus(paramShort);
      if (localSystemStatus != null)
      {
        int i = localSystemStatus.getStatus();
        long l1 = this.q.getHqCount(paramShort);
        Map localMap1 = this.q.getHqMap(paramShort);
        int j = this.q.getStatus(paramShort);
        if ((i != 5) && (i != 6))
        {
          if ((j == 2) && (i == 3))
          {
            this.q.clear(paramShort);
          }
          else
          {
            CommodityQuotation localCommodityQuotation;
            Map localMap2;
            long l2;
            if (l1 > 0L)
            {
              localCommodityQuotation = this.tradeRmi.getAllCommodityQuotationByCount(paramShort, l1);
              localMap2 = localCommodityQuotation.getCommodityOrderMap();
              l2 = localCommodityQuotation.getCount();
              Iterator localIterator = localMap2.values().iterator();
              while (localIterator.hasNext())
              {
                CommodityOrder localCommodityOrder = (CommodityOrder)localIterator.next();
                localMap1.put(localCommodityOrder.getCommodity().getCode(), localCommodityOrder);
              }
              this.q.setHqCount(paramShort, l2);
            }
            else if (l1 == -1L)
            {
              localCommodityQuotation = this.tradeRmi.getAllCommodityQuotation(paramShort);
              localMap2 = localCommodityQuotation.getCommodityOrderMap();
              l2 = localCommodityQuotation.getCount();
              if ((localMap2 != null) && (localMap2.size() > 0))
              {
                this.q.setHqMap(paramShort, localMap2);
                this.q.setHqCount(paramShort, l2);
              }
            }
          }
        }
        else if ((localMap1.size() != 0) || (l1 > 0L)) {
          this.q.clear(paramShort);
        }
        this.q.setStatus(i, paramShort);
      }
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
    }
  }
}
