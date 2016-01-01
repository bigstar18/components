package gnnt.MEBS.priceranking.server.model;

import java.io.Serializable;
import java.sql.Timestamp;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class FirmSpecialMargin
  implements Serializable
{
  private static final long serialVersionUID = 1609154039136199699L;
  private Log log = LogFactory.getLog(getClass());
  String firmId;
  short breedId;
  short bs_flag;
  short marginAlgr;
  double margin;
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
  
  public short getMarginAlgr()
  {
    return this.marginAlgr;
  }
  
  public void setMarginAlgr(short marginAlgr)
  {
    this.marginAlgr = marginAlgr;
  }
  
  public double getMargin()
  {
    return this.margin;
  }
  
  public void setMargin(double margin)
  {
    this.margin = margin;
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
