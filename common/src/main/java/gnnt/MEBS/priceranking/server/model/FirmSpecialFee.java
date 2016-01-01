package gnnt.MEBS.priceranking.server.model;

import java.io.Serializable;
import java.sql.Timestamp;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class FirmSpecialFee
  implements Serializable
{
  private static final long serialVersionUID = 1609154039136199699L;
  private Log log = LogFactory.getLog(getClass());
  String firmId;
  short breedId;
  short bs_flag;
  short feeAlgr;
  double fee;
  Timestamp updateTime;
  public static final int BS_FLAG_BUY = 1;
  public static final int BS_FLAG_SELL = 2;
  
  public String getFirmId()
  {
    return this.firmId;
  }
  
  public void setFirmId(String firmId)
  {
    this.firmId = firmId;
  }
  
  public short getBreedId()
  {
    return this.breedId;
  }
  
  public void setBreedId(short breedId)
  {
    this.breedId = breedId;
  }
  
  public short getBs_flag()
  {
    return this.bs_flag;
  }
  
  public void setBs_flag(short bsFlag)
  {
    this.bs_flag = bsFlag;
  }
  
  public short getFeeAlgr()
  {
    return this.feeAlgr;
  }
  
  public void setFeeAlgr(short feeAlgr)
  {
    this.feeAlgr = feeAlgr;
  }
  
  public double getFee()
  {
    return this.fee;
  }
  
  public void setFee(double fee)
  {
    this.fee = fee;
  }
  
  public Timestamp getUpdateTime()
  {
    return this.updateTime;
  }
  
  public void setUpdateTime(Timestamp updateTime)
  {
    this.updateTime = updateTime;
  }
}
