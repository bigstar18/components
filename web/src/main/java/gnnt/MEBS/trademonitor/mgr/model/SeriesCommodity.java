package gnnt.MEBS.trademonitor.mgr.model;

import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.model.StandardModel.PrimaryInfo;
import java.util.Date;

public class SeriesCommodity
  extends StandardModel
{
  private static final long serialVersionUID = 1681297488637871075L;
  private String commodityId;
  private String name;
  private int status;
  private Date marketDate;
  
  public Date getMarketDate()
  {
    return this.marketDate;
  }
  
  public void setMarketDate(Date paramDate)
  {
    this.marketDate = paramDate;
  }
  
  public String getCommodityId()
  {
    return this.commodityId;
  }
  
  public void setCommodityId(String paramString)
  {
    this.commodityId = paramString;
  }
  
  public String getName()
  {
    return this.name;
  }
  
  public void setName(String paramString)
  {
    this.name = paramString;
  }
  
  public int getStatus()
  {
    return this.status;
  }
  
  public void setStatus(int paramInt)
  {
    this.status = paramInt;
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return new StandardModel.PrimaryInfo(this, "commodityId", this.commodityId);
  }
}
