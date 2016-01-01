package gnnt.MEBS.common.broker.model;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

public class BrokerAge
  extends StandardModel
{
  private static final long serialVersionUID = -1185871234812304202L;
  private String brokerAgeId;
  private String name;
  private transient String password;
  private String idCard;
  private String telephone;
  private String mobile;
  private String email;
  private String address;
  private String postCode;
  private String note;
  private String brokerId;
  private Broker broker;
  private String pbrokerAgeId;
  private BrokerAge brokerAge;
  private Date creatTime;
  private Map<Long, Right> rightMap;
  private String ipAddress;
  private long sessionId;
  
  public String getBrokerAgeId()
  {
    return this.brokerAgeId;
  }
  
  public void setBrokerAgeId(String brokerAgeId)
  {
    this.brokerAgeId = brokerAgeId;
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
  
  public String getIdCard()
  {
    return this.idCard;
  }
  
  public void setIdCard(String idCard)
  {
    this.idCard = idCard;
  }
  
  public String getTelephone()
  {
    return this.telephone;
  }
  
  public void setTelephone(String telephone)
  {
    this.telephone = telephone;
  }
  
  public String getMobile()
  {
    return this.mobile;
  }
  
  public void setMobile(String mobile)
  {
    this.mobile = mobile;
  }
  
  public String getEmail()
  {
    return this.email;
  }
  
  public void setEmail(String email)
  {
    this.email = email;
  }
  
  public String getAddress()
  {
    return this.address;
  }
  
  public void setAddress(String address)
  {
    this.address = address;
  }
  
  public String getPostCode()
  {
    return this.postCode;
  }
  
  public void setPostCode(String postCode)
  {
    this.postCode = postCode;
  }
  
  public String getNote()
  {
    return this.note;
  }
  
  public void setNote(String note)
  {
    this.note = note;
  }
  
  public String getBrokerId()
  {
    return this.brokerId;
  }
  
  public void setBrokerId(String brokerId)
  {
    this.brokerId = brokerId;
  }
  
  public Broker getBroker()
  {
    return this.broker;
  }
  
  public void setBroker(Broker broker)
  {
    this.broker = broker;
  }
  
  public String getPbrokerAgeId()
  {
    return this.pbrokerAgeId;
  }
  
  public void setPbrokerAgeId(String pbrokerAgeId)
  {
    this.pbrokerAgeId = pbrokerAgeId;
  }
  
  public BrokerAge getBrokerAge()
  {
    return this.brokerAge;
  }
  
  public void setBrokerAge(BrokerAge brokerAge)
  {
    this.brokerAge = brokerAge;
  }
  
  public Date getCreatTime()
  {
    return this.creatTime;
  }
  
  public void setCreatTime(Date creatTime)
  {
    this.creatTime = creatTime;
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
  
  public Map<Long, Right> getRightMap()
  {
    if (this.rightMap == null)
    {
      this.rightMap = new HashMap();
      
      Set<Right> rightSet = this.broker.getRightSet();
      if (rightSet != null) {
        for (Right right : rightSet) {
          if ((!this.rightMap.containsKey(right.getId())) && 
            (right.getOnlyMember().equals("0"))) {
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
    if (((o instanceof BrokerAge)) && (o != null))
    {
      BrokerAge user = (BrokerAge)o;
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
    return new StandardModel.PrimaryInfo(  "brokerAgeId", this.brokerAgeId);
  }
}
