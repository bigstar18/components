package gnnt.MEBS.timebargain.plugin.condition.model;

import java.io.Serializable;
import java.util.Date;

public class ConditionOrder
  implements Serializable
{
  private static final long serialVersionUID = 591215593662564352L;
  private Long orderNo;
  private String customerID;
  private String firmID;
  private String traderID;
  private Double price;
  private Long amount;
  private Short orderType;
  private Short bs_flag;
  private Integer conditionOperation;
  private Integer conditionType;
  private Double conditionPrice;
  private String conditionCmtyID;
  private String cmtyID;
  private Date endDate;
  
  public Long getOrderNo()
  {
    return this.orderNo;
  }
  
  public void setOrderNo(Long orderNo)
  {
    this.orderNo = orderNo;
  }
  
  public Double getPrice()
  {
    return this.price;
  }
  
  public void setPrice(Double price)
  {
    this.price = price;
  }
  
  public Long getAmount()
  {
    return this.amount;
  }
  
  public void setAmount(Long amount)
  {
    this.amount = amount;
  }
  
  public Short getOrderType()
  {
    return this.orderType;
  }
  
  public void setOrderType(Short orderType)
  {
    this.orderType = orderType;
  }
  
  public Short getBs_flag()
  {
    return this.bs_flag;
  }
  
  public void setBs_flag(Short bs_flag)
  {
    this.bs_flag = bs_flag;
  }
  
  public Integer getConditionType()
  {
    return this.conditionType;
  }
  
  public void setConditionType(Integer conditionType)
  {
    this.conditionType = conditionType;
  }
  
  public Double getConditionPrice()
  {
    return this.conditionPrice;
  }
  
  public void setConditionPrice(Double conditionPrice)
  {
    this.conditionPrice = conditionPrice;
  }
  
  public Integer getConditionOperation()
  {
    return this.conditionOperation;
  }
  
  public void setConditionOperation(Integer conditionOperation)
  {
    this.conditionOperation = conditionOperation;
  }
  
  public String getCmtyID()
  {
    return this.cmtyID;
  }
  
  public void setCmtyID(String cmtyID)
  {
    this.cmtyID = cmtyID;
  }
  
  public String getCustomerID()
  {
    return this.customerID;
  }
  
  public void setCustomerID(String customerID)
  {
    this.customerID = customerID;
  }
  
  public String getFirmID()
  {
    return this.firmID;
  }
  
  public void setFirmID(String firmID)
  {
    this.firmID = firmID;
  }
  
  public String getTraderID()
  {
    return this.traderID;
  }
  
  public void setTraderID(String traderID)
  {
    this.traderID = traderID;
  }
  
  public String getConditionCmtyID()
  {
    return this.conditionCmtyID;
  }
  
  public void setConditionCmtyID(String conditionCmtyID)
  {
    this.conditionCmtyID = conditionCmtyID;
  }
  
  public Date getEndDate()
  {
    return this.endDate;
  }
  
  public void setEndDate(Date endDate)
  {
    this.endDate = endDate;
  }
  
  public int hashCode()
  {
    int prime = 31;
    int result = 1;
    result = 31 * result + (this.orderNo == null ? 0 : this.orderNo.hashCode());
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
    ConditionOrder other = (ConditionOrder)obj;
    if (this.orderNo == null)
    {
      if (other.orderNo != null) {
        return false;
      }
    }
    else if (!this.orderNo.equals(other.orderNo)) {
      return false;
    }
    return true;
  }
  
  public String toString()
  {
    return 
      "OrderNo=" + this.orderNo + ",ConditionPrice=" + this.conditionPrice + ",ConditionType=" + this.conditionType + ",ConditionCommtyId=" + this.conditionCmtyID + ",Operation:" + this.conditionOperation;
  }
}
