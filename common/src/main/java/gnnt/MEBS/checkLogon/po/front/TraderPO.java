package gnnt.MEBS.checkLogon.po.front;

import gnnt.MEBS.checkLogon.po.Clone;
import java.util.Date;

public class TraderPO
  extends Clone
{
  private String traderID;
  private String name;
  private String password;
  private Integer forceChangePwd;
  private String status;
  private String firmID;
  private String firmName;
  private String type;
  private String keyCode;
  private String enableKey;
  private Date createTime;
  private Date modifyTime;
  private String trustKey;
  private String lastTime;
  private String lastIP;
  
  public String getTraderID()
  {
    return this.traderID;
  }
  
  public void setTraderID(String traderID)
  {
    this.traderID = traderID;
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
  
  public Integer getForceChangePwd()
  {
    return this.forceChangePwd;
  }
  
  public void setForceChangePwd(Integer forceChangePwd)
  {
    this.forceChangePwd = forceChangePwd;
  }
  
  public String getFirmID()
  {
    return this.firmID;
  }
  
  public void setFirmID(String firmID)
  {
    this.firmID = firmID;
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
  
  public String getKeyCode()
  {
    return this.keyCode;
  }
  
  public void setKeyCode(String keyCode)
  {
    this.keyCode = keyCode;
  }
  
  public String getEnableKey()
  {
    return this.enableKey;
  }
  
  public void setEnableKey(String enableKey)
  {
    this.enableKey = enableKey;
  }
  
  public Date getCreateTime()
  {
    return this.createTime;
  }
  
  public void setCreateTime(Date createTime)
  {
    this.createTime = createTime;
  }
  
  public Date getModifyTime()
  {
    return this.modifyTime;
  }
  
  public void setModifyTime(Date modifyTime)
  {
    this.modifyTime = modifyTime;
  }
  
  public String getStatus()
  {
    return this.status;
  }
  
  public void setStatus(String status)
  {
    this.status = status;
  }
  
  public String getTrustKey()
  {
    return this.trustKey;
  }
  
  public void setTrustKey(String trustKey)
  {
    this.trustKey = trustKey;
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
}
