package gnnt.MEBS.priceranking.server.model;

import java.io.Serializable;
import java.sql.Timestamp;

public class SystemStatus
  implements Serializable
{
  private static final long serialVersionUID = 1L;
  private int status;
  private int unitId = 1;
  private int nextPartID;
  private Timestamp partStartTime;
  private Timestamp partEndTime;
  private Timestamp partLastEndTime;
  private Timestamp partCompelEndTime;
  private int partitionID;
  private long durativeTime;
  private long spaceTime;
  private int countdownStart;
  private int countdownTime;
  
  public int getStatus()
  {
    return this.status;
  }
  
  public void setStatus(int status)
  {
    this.status = status;
  }
  
  public int getUnitId()
  {
    return this.unitId;
  }
  
  public void setUnitId(int unitId)
  {
    this.unitId = unitId;
  }
  
  public int getNextPartID()
  {
    return this.nextPartID;
  }
  
  public void setNextPartID(int nextPartID)
  {
    this.nextPartID = nextPartID;
  }
  
  public Timestamp getPartStartTime()
  {
    return this.partStartTime;
  }
  
  public void setPartStartTime(Timestamp partStartTime)
  {
    this.partStartTime = partStartTime;
  }
  
  public Timestamp getPartEndTime()
  {
    return this.partEndTime;
  }
  
  public void setPartEndTime(Timestamp partEndTime)
  {
    this.partEndTime = partEndTime;
  }
  
  public Timestamp getPartLastEndTime()
  {
    return this.partLastEndTime;
  }
  
  public void setPartLastEndTime(Timestamp partLastEndTime)
  {
    this.partLastEndTime = partLastEndTime;
  }
  
  public Timestamp getPartCompelEndTime()
  {
    return this.partCompelEndTime;
  }
  
  public void setPartCompelEndTime(Timestamp partCompelEndTime)
  {
    this.partCompelEndTime = partCompelEndTime;
  }
  
  public int getPartitionID()
  {
    return this.partitionID;
  }
  
  public void setPartitionID(int partitionID)
  {
    this.partitionID = partitionID;
  }
  
  public long getDurativeTime()
  {
    return this.durativeTime;
  }
  
  public void setDurativeTime(long durativeTime)
  {
    this.durativeTime = durativeTime;
  }
  
  public long getSpaceTime()
  {
    return this.spaceTime;
  }
  
  public void setSpaceTime(long spaceTime)
  {
    this.spaceTime = spaceTime;
  }
  
  public int getCountdownStart()
  {
    return this.countdownStart;
  }
  
  public void setCountdownStart(int countdownStart)
  {
    this.countdownStart = countdownStart;
  }
  
  public int getCountdownTime()
  {
    return this.countdownTime;
  }
  
  public void setCountdownTime(int countdownTime)
  {
    this.countdownTime = countdownTime;
  }
}
