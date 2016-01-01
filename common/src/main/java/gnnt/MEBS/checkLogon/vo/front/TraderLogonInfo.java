package gnnt.MEBS.checkLogon.vo.front;

import java.io.Serializable;

public class TraderLogonInfo
  implements Serializable
{
  private static final long serialVersionUID = 879780951650144132L;
  public static final String TRADER_TYPE_ADMIN = "A";
  public static final String TRADER_TYPE_NORMAL = "N";
  private String traderId;
  private String traderName;
  private String firmId;
  private String firmName;
  private String type;
  private String trustKey;
  private long sessionID;
  private int forceChangePwd;
  private String lastTime;
  private String lastIP;
  private int result;
  private String recode;
  private String message;
  
  public String getTraderId()
  {
    return this.traderId;
  }
  
  public void setTraderId(String traderId)
  {
    this.traderId = traderId;
  }
  
  public String getTraderName()
  {
    return this.traderName;
  }
  
  public void setTraderName(String traderName)
  {
    this.traderName = traderName;
  }
  
  public String getFirmId()
  {
    return this.firmId;
  }
  
  public void setFirmId(String firmId)
  {
    this.firmId = firmId;
  }
  
  public String getFirmName()
  {
    return this.firmName;
  }
  
  public void setFirmName(String firmName)
  {
    this.firmName = firmName;
  }
  
  public String getType()
  {
    return this.type;
  }
  
  public void setType(String type)
  {
    this.type = type;
  }
  
  public String getTrustKey()
  {
    return this.trustKey;
  }
  
  public void setTrustKey(String trustKey)
  {
    this.trustKey = trustKey;
  }
  
  public long getSessionID()
  {
    return this.sessionID;
  }
  
  public void setSessionID(long sessionID)
  {
    this.sessionID = sessionID;
  }
  
  public int getForceChangePwd()
  {
    return this.forceChangePwd;
  }
  
  public void setForceChangePwd(int forceChangePwd)
  {
    this.forceChangePwd = forceChangePwd;
  }
  
  public String getLastTime()
  {
    return this.lastTime;
  }
  
  public void setLastTime(String lastTime)
  {
    this.lastTime = lastTime;
  }
  
  public String getLastIP()
  {
    return this.lastIP;
  }
  
  public void setLastIP(String lastIP)
  {
    this.lastIP = lastIP;
  }
  
  public int getResult()
  {
    return this.result;
  }
  
  public void setResult(int result)
  {
    this.result = result;
  }
  
  public String getRecode()
  {
    return this.recode;
  }
  
  public void setRecode(String recode)
  {
    this.recode = recode;
  }
  
  public String getMessage()
  {
    return this.message;
  }
  
  public void setMessage(String message)
  {
    this.message = message;
  }
}
