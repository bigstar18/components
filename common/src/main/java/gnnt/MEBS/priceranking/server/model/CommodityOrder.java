package gnnt.MEBS.priceranking.server.model;

import java.io.PrintStream;
import java.io.Serializable;
import java.util.LinkedList;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class CommodityOrder
  implements Serializable
{
  private static final long serialVersionUID = 1609154039136199699L;
  private Log log = LogFactory.getLog(getClass());
  private Commodity commodity;
  public LinkedList<Order> tradeOrders;
  public LinkedList<Order> tradeOrdersBackups;
  private Double newPrice;
  private double tradeAmount = 0.0D;
  private long startTime;
  private long endTime;
  private short countdownFlag = 0;
  private long orderFlag = 0L;
  private long countdownTime = 0L;
  private long initCount = 0L;
  private long hqCount = 0L;
  private String newOrderTime;
  private String newFirmId = "";
  private int tradeStatus = 0;
  public static final int STATUS_RUNNING = 0;
  public static final int STATUS_CLOSE = 1;
  
  public CommodityOrder(Commodity commodity, long totalCount)
  {
    this.commodity = commodity;
    this.newPrice = commodity.getNewPrice();
    this.startTime = commodity.getStartTime();
    this.endTime = commodity.getEndTime();
    this.tradeAmount = commodity.getTradeAmount();
    this.newOrderTime = commodity.getNewOrderTime();
    this.newFirmId = commodity.getNewFirmId();
    this.hqCount = totalCount;
    this.initCount = totalCount;
    this.tradeOrders = new LinkedList();
    this.tradeOrdersBackups = new LinkedList();
    System.out.println("商品" + commodity.getCode() + "属性及委托对象加载成功,hqCount为：" + this.hqCount + ",initCount为：" + this.initCount);
  }
  
  public Commodity getCommodity()
  {
    return this.commodity;
  }
  
  public void setCommodity(Commodity commodity)
  {
    this.commodity = commodity;
  }
  
  public LinkedList<Order> getTradeOrders()
  {
    return this.tradeOrders;
  }
  
  public void setTradeOrders(LinkedList<Order> tradeOrders)
  {
    this.tradeOrders = tradeOrders;
  }
  
  public LinkedList<Order> getTradeOrdersBackups()
  {
    return this.tradeOrdersBackups;
  }
  
  public void setTradeOrdersBackups(LinkedList<Order> tradeOrdersBackups)
  {
    this.tradeOrdersBackups = tradeOrdersBackups;
  }
  
  public Double getNewPrice()
  {
    return this.newPrice;
  }
  
  public void setNewPrice(Double newPrice)
  {
    this.newPrice = newPrice;
  }
  
  public double getTradeAmount()
  {
    return this.tradeAmount;
  }
  
  public void setTradeAmount(double tradeAmount)
  {
    this.tradeAmount = tradeAmount;
  }
  
  public long getStartTime()
  {
    return this.startTime;
  }
  
  public void setStartTime(long startTime)
  {
    this.startTime = startTime;
  }
  
  public long getEndTime()
  {
    return this.endTime;
  }
  
  public void setEndTime(long endTime)
  {
    this.endTime = endTime;
  }
  
  public short getCountdownFlag()
  {
    return this.countdownFlag;
  }
  
  public void setCountdownFlag(short countdownFlag)
  {
    this.countdownFlag = countdownFlag;
  }
  
  public long getOrderFlag()
  {
    return this.orderFlag;
  }
  
  public void setOrderFlag(long orderFlag)
  {
    this.orderFlag = orderFlag;
  }
  
  public long getCountdownTime()
  {
    return this.countdownTime;
  }
  
  public void setCountdownTime(long countdownTime)
  {
    this.countdownTime = countdownTime;
  }
  
  public long getInitCount()
  {
    return this.initCount;
  }
  
  public void setInitCount(long initCount)
  {
    this.initCount = initCount;
  }
  
  public long getHqCount()
  {
    return this.hqCount;
  }
  
  public void setHqCount(long hqCount)
  {
    this.hqCount = hqCount;
  }
  
  public String getNewOrderTime()
  {
    return this.newOrderTime;
  }
  
  public String getNewFirmId()
  {
    return this.newFirmId;
  }
  
  public void setNewFirmId(String newFirmId)
  {
    this.newFirmId = newFirmId;
  }
  
  public void setNewOrderTime(String newOrderTime)
  {
    this.newOrderTime = newOrderTime;
  }
  
  public int getTradeStatus()
  {
    return this.tradeStatus;
  }
  
  public void setTradeStatus(int tradeStatus)
  {
    this.tradeStatus = tradeStatus;
  }
}
