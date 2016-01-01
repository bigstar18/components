package gnnt.MEBS.common.broker.model;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

public class Broker
  extends StandardModel
{
  private static final long serialVersionUID = -1185871234800004202L;
  private String brokerId;
  private transient String password;
  private String name;
  private String telephone;
  private String mobile;
  private String email;
  private String address;
  private String note;
  private String firmId;
  private String areaId;
  private String memberType;
  private Date timeLimit;
  private Set<Right> rightSet;
  private Map<Long, Right> rightMap;
  private String ipAddress;
  private long sessionId;
  
  public String getBrokerId()
  {
    return this.brokerId;
  }
  
  public String getPassword()
  {
    return this.password;
  }
  
  public String getName()
  {
    return this.name;
  }
  
  public String getTelephone()
  {
    return this.telephone;
  }
  
  public String getMobile()
  {
    return this.mobile;
  }
  
  public String getEmail()
  {
    return this.email;
  }
  
  public String getAddress()
  {
    return this.address;
  }
  
  public String getNote()
  {
    return this.note;
  }
  
  public String getFirmId()
  {
    return this.firmId;
  }
  
  public String getAreaId()
  {
    return this.areaId;
  }
  
  public String getMemberType()
  {
    return this.memberType;
  }
  
  public Date getTimeLimit()
  {
    return this.timeLimit;
  }
  
  public void setBrokerId(String brokerId)
  {
    this.brokerId = brokerId;
  }
  
  public void setPassword(String password)
  {
    this.password = password;
  }
  
  public void setName(String name)
  {
    this.name = name;
  }
  
  public void setTelephone(String telephone)
  {
    this.telephone = telephone;
  }
  
  public void setMobile(String mobile)
  {
    this.mobile = mobile;
  }
  
  public void setEmail(String email)
  {
    this.email = email;
  }
  
  public void setAddress(String address)
  {
    this.address = address;
  }
  
  public void setNote(String note)
  {
    this.note = note;
  }
  
  public void setFirmId(String firmId)
  {
    this.firmId = firmId;
  }
  
  public void setAreaId(String areaId)
  {
    this.areaId = areaId;
  }
  
  public void setMemberType(String memberType)
  {
    this.memberType = memberType;
  }
  
  public void setTimeLimit(Date timeLimit)
  {
    this.timeLimit = timeLimit;
  }
  
  public String getIpAddress()
  {
    return this.ipAddress;
  }
  
  public void setIpAddress(String ipAddress)
  {
    this.ipAddress = ipAddress;
  }
  
  public long getSessionId()
  {
    return this.sessionId;
  }
  
  public void setSessionId(long sessionId)
  {
    this.sessionId = sessionId;
  }
  
  public Set<Right> getRightSet()
  {
    return this.rightSet;
  }
  
  public void setRightSet(Set<Right> rightSet)
  {
    this.rightSet = rightSet;
  }
  
  public Map<Long, Right> getRightMap()
  {
    if (this.rightMap == null)
    {
      this.rightMap = new HashMap();
      
      Set<Right> rightSet = this.rightSet;
      if (rightSet != null) {
        for (Right right : rightSet) {
          if (!this.rightMap.containsKey(right.getId())) {
            this.rightMap.put(right.getId(), right);
          }
        }
      }
    }
    return this.rightMap;
  }
  
  public boolean equals(Object o)
  {
    boolean sign = true;
    if (((o instanceof Broker)) && (o != null))
    {
      Broker user = (Broker)o;
      if (!getBrokerId().equals(user.getBrokerId())) {
        sign = false;
      }
    }
    else
    {
      sign = false;
    }
    return sign;
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return new StandardModel.PrimaryInfo(  "brokerId", this.brokerId);
  }
}
