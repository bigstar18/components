package gnnt.MEBS.priceranking.server.model;

import java.io.Serializable;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

public class Firm
  implements Serializable
{
  private static final long serialVersionUID = 4690197650654049821L;
  private String firmId;
  private short limits;
  private short isEntry;
  private short isContinueOrder;
  public static final short STATUS_All = 0;
  public static final short STATUS_BUY = 1;
  public static final short STATUS_SELL = 2;
  public static final short STATUS_NOHAVE = 3;
  public static final short CONTINUE_ORDER_YES = 1;
  public static final short CONTINUE_ORDER_NO = 0;
  
  public String toString()
  {
    return ToStringBuilder.reflectionToString(this, ToStringStyle.MULTI_LINE_STYLE);
  }
  
  public String getFirmId()
  {
    return this.firmId;
  }
  
  public void setFirmId(String firmId)
  {
    this.firmId = firmId;
  }
  
  public short getLimits()
  {
    return this.limits;
  }
  
  public void setLimits(short limits)
  {
    this.limits = limits;
  }
  
  public short getIsEntry()
  {
    return this.isEntry;
  }
  
  public void setIsEntry(short isEntry)
  {
    this.isEntry = isEntry;
  }
  
  public short getIsContinueOrder()
  {
    return this.isContinueOrder;
  }
  
  public void setIsContinueOrder(short isContinueOrder)
  {
    this.isContinueOrder = isContinueOrder;
  }
}
