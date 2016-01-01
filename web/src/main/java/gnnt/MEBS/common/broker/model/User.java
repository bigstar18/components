package gnnt.MEBS.common.broker.model;

public class User
{
  private static final long serialVersionUID = -1185871234800004202L;
  private String userId;
  private Broker broker;
  private BrokerAge brokerAge;
  private String type;
  private String sql;
  private long sessionId;
  private String logonType;
  private String ipAddress;
  
  public String getLogonType()
  {
    return this.logonType;
  }
  
  public void setLogonType(String logonType)
  {
    this.logonType = logonType;
  }
  
  public String getIpAddress()
  {
    return this.ipAddress;
  }
  
  public void setIpAddress(String ipAddress)
  {
    this.ipAddress = ipAddress;
  }
  
  public String getUserId()
  {
    return this.userId;
  }
  
  public void setUserId(String userId)
  {
    this.userId = userId;
  }
  
  public Broker getBroker()
  {
    return this.broker;
  }
  
  public void setBroker(Broker broker)
  {
    this.broker = broker;
  }
  
  public BrokerAge getBrokerAge()
  {
    return this.brokerAge;
  }
  
  public void setBrokerAge(BrokerAge brokerAge)
  {
    this.brokerAge = brokerAge;
  }
  
  public String getType()
  {
    return this.type;
  }
  
  public void setType(String type)
  {
    this.type = type;
  }
  
  public String getSql()
  {
    return this.sql;
  }
  
  public void setSql(String sql)
  {
    this.sql = sql;
  }
  
  public long getSessionId()
  {
    return this.sessionId;
  }
  
  public void setSessionId(long sessionId)
  {
    this.sessionId = sessionId;
  }
}
