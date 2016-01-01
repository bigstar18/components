package gnnt.MEBS.vendue.mgr.model.commodity.hisCommodities;

import gnnt.MEBS.common.mgr.model.translate.ClassDiscription;
import java.io.Serializable;
import java.util.Date;

public class VHiscommodityId
  implements Serializable
{
  private static final long serialVersionUID = 1L;
  @ClassDiscription(name="交易日期", description="")
  private Date tradedate;
  @ClassDiscription(name="标的号", description="")
  private String code;
  
  public VHiscommodityId() {}
  
  public VHiscommodityId(Date paramDate, String paramString)
  {
    this.tradedate = paramDate;
    this.code = paramString;
  }
  
  public Date getTradedate()
  {
    return this.tradedate;
  }
  
  public void setTradedate(Date paramDate)
  {
    this.tradedate = paramDate;
  }
  
  public String getCode()
  {
    return this.code;
  }
  
  public void setCode(String paramString)
  {
    this.code = paramString;
  }
  
  public boolean equals(Object paramObject)
  {
    if (this == paramObject) {
      return true;
    }
    if (paramObject == null) {
      return false;
    }
    if (!(paramObject instanceof VHiscommodityId)) {
      return false;
    }
    VHiscommodityId localVHiscommodityId = (VHiscommodityId)paramObject;
    return ((getTradedate() == localVHiscommodityId.getTradedate()) || ((getTradedate() != null) && (localVHiscommodityId.getTradedate() != null) && (getTradedate().equals(localVHiscommodityId.getTradedate())))) && ((getCode() == localVHiscommodityId.getCode()) || ((getCode() != null) && (localVHiscommodityId.getCode() != null) && (getCode().equals(localVHiscommodityId.getCode()))));
  }
  
  public int hashCode()
  {
    int i = 17;
    i = 37 * i + (getTradedate() == null ? 0 : getTradedate().hashCode());
    i = 37 * i + (getCode() == null ? 0 : getCode().hashCode());
    return i;
  }
}
