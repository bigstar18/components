package gnnt.MEBS.priceranking.server.model;

import java.io.Serializable;
import java.util.List;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

public class Trader
  implements Serializable
{
  private static final long serialVersionUID = 3690197650654049833L;
  private String traderID;
  private String name;
  private String password;
  private short status;
  private String firmID;
  private List operateCustomerList;
  private String regWord;
  private String keyCode;
  private short keyStatus;
  private String logonIP;
  
  public String toString()
  {
    return ToStringBuilder.reflectionToString(this, ToStringStyle.MULTI_LINE_STYLE);
  }
  
  public String getFirmID()
  {
    return this.firmID;
  }
  
  public void setFirmID(String firmID)
  {
    this.firmID = firmID;
  }
  
  public String getName()
  {
    return this.name;
  }
  
  public void setName(String name)
  {
    this.name = name;
  }
  
  public String getPassword()
  {
    return this.password;
  }
  
  public void setPassword(String password)
  {
    this.password = password;
  }
  
  public String getRegWord()
  {
    return this.regWord;
  }
  
  public void setRegWord(String regWord)
  {
    this.regWord = regWord;
  }
  
  public short getStatus()
  {
    return this.status;
  }
  
  public void setStatus(short status)
  {
    this.status = status;
  }
  
  public String getTraderID()
  {
    return this.traderID;
  }
  
  public void setTraderID(String traderID)
  {
    this.traderID = traderID;
  }
  
  public List getOperateCustomerList()
  {
    return this.operateCustomerList;
  }
  
  public void setOperateCustomerList(List operateCustomerList)
  {
    this.operateCustomerList = operateCustomerList;
  }
  
  public String getLogonIP()
  {
    return this.logonIP;
  }
  
  public void setLogonIP(String logonIP)
  {
    this.logonIP = logonIP;
  }
  
  public String getKeyCode()
  {
    return this.keyCode;
  }
  
  public void setKeyCode(String keyCode)
  {
    this.keyCode = keyCode;
  }
  
  public short getKeyStatus()
  {
    return this.keyStatus;
  }
  
  public void setKeyStatus(short keyStatus)
  {
    this.keyStatus = keyStatus;
  }
}
