package gnnt.MEBS.vendue.mgr.model.commodity.commodities;

import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.mgr.model.translate.ClassDiscription;
import java.util.Date;

public class VCurcommodity
  extends StandardModel
{
  private static final long serialVersionUID = 2218127675948156036L;
  @ClassDiscription(name="标的号", description="")
  private String code;
  @ClassDiscription(name="交易板块", description="")
  private Short tradepartition;
  @ClassDiscription(name="商品码", description="")
  private String commodityid;
  @ClassDiscription(name="所属交易节", description="")
  private Short section;
  @ClassDiscription(name="成交状态", description="成交状态 0：未成交 1：全部成交 2：部分成交 3：已流拍")
  private Byte bargaintype;
  @ClassDiscription(name="最后修改时间", description="")
  private Date modifytime;
  
  public VCurcommodity() {}
  
  public VCurcommodity(String paramString1, Short paramShort, String paramString2, Byte paramByte, Date paramDate)
  {
    this.code = paramString1;
    this.tradepartition = paramShort;
    this.commodityid = paramString2;
    this.bargaintype = paramByte;
    this.modifytime = paramDate;
  }
  
  public VCurcommodity(String paramString1, Short paramShort1, String paramString2, Short paramShort2, Byte paramByte, Date paramDate)
  {
    this.code = paramString1;
    this.tradepartition = paramShort1;
    this.commodityid = paramString2;
    this.section = paramShort2;
    this.bargaintype = paramByte;
    this.modifytime = paramDate;
  }
  
  public String getCode()
  {
    return this.code;
  }
  
  public void setCode(String paramString)
  {
    this.code = paramString;
  }
  
  public Short getTradepartition()
  {
    return this.tradepartition;
  }
  
  public void setTradepartition(Short paramShort)
  {
    this.tradepartition = paramShort;
  }
  
  public String getCommodityid()
  {
    return this.commodityid;
  }
  
  public void setCommodityid(String paramString)
  {
    this.commodityid = paramString;
  }
  
  public Short getSection()
  {
    return this.section;
  }
  
  public void setSection(Short paramShort)
  {
    this.section = paramShort;
  }
  
  public Byte getBargaintype()
  {
    return this.bargaintype;
  }
  
  public void setBargaintype(Byte paramByte)
  {
    this.bargaintype = paramByte;
  }
  
  public Date getModifytime()
  {
    return this.modifytime;
  }
  
  public void setModifytime(Date paramDate)
  {
    this.modifytime = paramDate;
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return new StandardModel.PrimaryInfo("code", this.code);
  }
}
