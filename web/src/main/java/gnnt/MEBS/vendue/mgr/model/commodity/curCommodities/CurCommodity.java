package gnnt.MEBS.vendue.mgr.model.commodity.curCommodities;

import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.mgr.model.translate.ClassDiscription;
import java.util.Date;

public class CurCommodity
  extends StandardModel
{
  private static final long serialVersionUID = -9123720485892039734L;
  @ClassDiscription(name="标的号", description="")
  private String code;
  @ClassDiscription(name="交易板块", description="")
  private Byte tradePartition;
  @ClassDiscription(name="商品码", description="")
  private String commodityId;
  @ClassDiscription(name="所属交易节", description="")
  private Integer section;
  @ClassDiscription(name="成交状态", description="成交状态 0：未成交 1：全部成交 2：部分成交 3：已流拍")
  private Integer bargainType;
  @ClassDiscription(name="最后修改时间", description="")
  private Date modifyTime;
  
  public String getCode()
  {
    return this.code;
  }
  
  public void setCode(String paramString)
  {
    this.code = paramString;
  }
  
  public Byte getTradePartition()
  {
    return this.tradePartition;
  }
  
  public void setTradePartition(Byte paramByte)
  {
    this.tradePartition = paramByte;
  }
  
  public String getCommodityId()
  {
    return this.commodityId;
  }
  
  public void setCommodityId(String paramString)
  {
    this.commodityId = paramString;
  }
  
  public Integer getSection()
  {
    return this.section;
  }
  
  public void setSection(Integer paramInteger)
  {
    this.section = paramInteger;
  }
  
  public Integer getBargainType()
  {
    return this.bargainType;
  }
  
  public void setBargainType(Integer paramInteger)
  {
    this.bargainType = paramInteger;
  }
  
  public Date getModifyTime()
  {
    return this.modifyTime;
  }
  
  public void setModifyTime(Date paramDate)
  {
    this.modifyTime = paramDate;
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return new StandardModel.PrimaryInfo("code", this.code);
  }
}
