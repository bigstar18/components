package gnnt.MEBS.timebargain.plugin.condition.model;

import java.sql.Timestamp;
import java.util.Date;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

public class Quotation
{
  private Date updateTime;
  private String commodityID;
  private Double yesterBalancePrice = Double.valueOf(0.0D);
  private Double closePrice = Double.valueOf(0.0D);
  private Double openPrice = Double.valueOf(0.0D);
  private Double highPrice = Double.valueOf(0.0D);
  private Double lowPrice = Double.valueOf(0.0D);
  private Double curPrice = Double.valueOf(0.0D);
  private Long curAmount = Long.valueOf(0L);
  private Long openAmount = Long.valueOf(0L);
  private Long buyOpenAmount = Long.valueOf(0L);
  private Long sellOpenAmount = Long.valueOf(0L);
  private Long closeAmount = Long.valueOf(0L);
  private Long buyCloseAmount = Long.valueOf(0L);
  private Long sellCloseAmount = Long.valueOf(0L);
  private Long reserveCount = Long.valueOf(0L);
  private Double price = Double.valueOf(0.0D);
  private Double totalMoney = Double.valueOf(0.0D);
  private Long totalAmount = Long.valueOf(0L);
  private Long outAmount = Long.valueOf(0L);
  private Long inAmount = Long.valueOf(0L);
  private Timestamp createTime = null;
  private double buy1;
  private double sell1;
  private long buyqty1;
  private long sellqty1;
  
  public String toString()
  {
    return ToStringBuilder.reflectionToString(this, ToStringStyle.MULTI_LINE_STYLE);
  }
  
  public Date getUpdateTime()
  {
    return this.updateTime;
  }
  
  public void setUpdateTime(Date updateTime)
  {
    this.updateTime = updateTime;
  }
  
  public String getCommodityID()
  {
    return this.commodityID;
  }
  
  public void setCommodityID(String commodityID)
  {
    this.commodityID = commodityID;
  }
  
  public Double getYesterBalancePrice()
  {
    return this.yesterBalancePrice;
  }
  
  public void setYesterBalancePrice(Double yesterBalancePrice)
  {
    this.yesterBalancePrice = yesterBalancePrice;
  }
  
  public Double getClosePrice()
  {
    return this.closePrice;
  }
  
  public void setClosePrice(Double closePrice)
  {
    this.closePrice = closePrice;
  }
  
  public Double getOpenPrice()
  {
    return this.openPrice;
  }
  
  public void setOpenPrice(Double openPrice)
  {
    this.openPrice = openPrice;
  }
  
  public Double getHighPrice()
  {
    return this.highPrice;
  }
  
  public void setHighPrice(Double highPrice)
  {
    this.highPrice = highPrice;
  }
  
  public Double getLowPrice()
  {
    return this.lowPrice;
  }
  
  public void setLowPrice(Double lowPrice)
  {
    this.lowPrice = lowPrice;
  }
  
  public Double getCurPrice()
  {
    return this.curPrice;
  }
  
  public void setCurPrice(Double curPrice)
  {
    this.curPrice = curPrice;
  }
  
  public Long getCurAmount()
  {
    return this.curAmount;
  }
  
  public void setCurAmount(Long curAmount)
  {
    this.curAmount = curAmount;
  }
  
  public Long getOpenAmount()
  {
    return this.openAmount;
  }
  
  public void setOpenAmount(Long openAmount)
  {
    this.openAmount = openAmount;
  }
  
  public Long getBuyOpenAmount()
  {
    return this.buyOpenAmount;
  }
  
  public void setBuyOpenAmount(Long buyOpenAmount)
  {
    this.buyOpenAmount = buyOpenAmount;
  }
  
  public Long getSellOpenAmount()
  {
    return this.sellOpenAmount;
  }
  
  public void setSellOpenAmount(Long sellOpenAmount)
  {
    this.sellOpenAmount = sellOpenAmount;
  }
  
  public Long getCloseAmount()
  {
    return this.closeAmount;
  }
  
  public void setCloseAmount(Long closeAmount)
  {
    this.closeAmount = closeAmount;
  }
  
  public Long getBuyCloseAmount()
  {
    return this.buyCloseAmount;
  }
  
  public void setBuyCloseAmount(Long buyCloseAmount)
  {
    this.buyCloseAmount = buyCloseAmount;
  }
  
  public Long getSellCloseAmount()
  {
    return this.sellCloseAmount;
  }
  
  public void setSellCloseAmount(Long sellCloseAmount)
  {
    this.sellCloseAmount = sellCloseAmount;
  }
  
  public Long getReserveCount()
  {
    return this.reserveCount;
  }
  
  public void setReserveCount(Long reserveCount)
  {
    this.reserveCount = reserveCount;
  }
  
  public Double getPrice()
  {
    return this.price;
  }
  
  public void setPrice(Double price)
  {
    this.price = price;
  }
  
  public Double getTotalMoney()
  {
    return this.totalMoney;
  }
  
  public void setTotalMoney(Double totalMoney)
  {
    this.totalMoney = totalMoney;
  }
  
  public Long getTotalAmount()
  {
    return this.totalAmount;
  }
  
  public void setTotalAmount(Long totalAmount)
  {
    this.totalAmount = totalAmount;
  }
  
  public Long getOutAmount()
  {
    return this.outAmount;
  }
  
  public void setOutAmount(Long outAmount)
  {
    this.outAmount = outAmount;
  }
  
  public Long getInAmount()
  {
    return this.inAmount;
  }
  
  public void setInAmount(Long inAmount)
  {
    this.inAmount = inAmount;
  }
  
  public Timestamp getCreateTime()
  {
    return this.createTime;
  }
  
  public void setCreateTime(Timestamp createTime)
  {
    this.createTime = createTime;
  }
  
  public double getBuy1()
  {
    return this.buy1;
  }
  
  public void setBuy1(double buy1)
  {
    this.buy1 = buy1;
  }
  
  public double getSell1()
  {
    return this.sell1;
  }
  
  public void setSell1(double sell1)
  {
    this.sell1 = sell1;
  }
  
  public long getBuyqty1()
  {
    return this.buyqty1;
  }
  
  public void setBuyqty1(long buyqty1)
  {
    this.buyqty1 = buyqty1;
  }
  
  public long getSellqty1()
  {
    return this.sellqty1;
  }
  
  public void setSellqty1(long sellqty1)
  {
    this.sellqty1 = sellqty1;
  }
  
  public int hashCode()
  {
    int prime = 31;
    int result = 1;
    
    long temp = Double.doubleToLongBits(this.buy1);
    result = 31 * result + (int)(temp ^ temp >>> 32);
    result = 31 * result + (this.price == null ? 0 : this.price.hashCode());
    temp = Double.doubleToLongBits(this.sell1);
    result = 31 * result + (int)(temp ^ temp >>> 32);
    return result;
  }
  
  public boolean equals(Object obj)
  {
    if (this == obj) {
      return true;
    }
    if (obj == null) {
      return false;
    }
    if (getClass() != obj.getClass()) {
      return false;
    }
    Quotation other = (Quotation)obj;
    if (Double.doubleToLongBits(this.buy1) != 
      Double.doubleToLongBits(other.buy1)) {
      return false;
    }
    if (this.price == null)
    {
      if (other.price != null) {
        return false;
      }
    }
    else if (!this.price.equals(other.price)) {
      return false;
    }
    if (Double.doubleToLongBits(this.sell1) != 
      Double.doubleToLongBits(other.sell1)) {
      return false;
    }
    return true;
  }
}
