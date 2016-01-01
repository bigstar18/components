package gnnt.MEBS.vendue.mgr.model.commodity.hisCommodities;

import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.mgr.model.translate.ClassDiscription;
import java.util.Date;

public class VHiscommodity
  extends StandardModel
{
  private static final long serialVersionUID = 1L;
  @ClassDiscription(name="关联历史交易商品主键", description="")
  private VHiscommodityId id;
  @ClassDiscription(name="交易板块", description="")
  private Short tradepartition;
  @ClassDiscription(name="商品码", description="")
  private String commodityid;
  @ClassDiscription(name="所属交易节", description="")
  private Integer section;
  @ClassDiscription(name="成交状态", description="成交状态 0：未成交 1：全部成交 2：部分成交 3：已流拍")
  private Integer bargaintype;
  @ClassDiscription(name="最后修改时间", description="")
  private Date modifytime;
  
  public VHiscommodityId getId()
  {
    return this.id;
  }
  
  public void setId(VHiscommodityId paramVHiscommodityId)
  {
    this.id = paramVHiscommodityId;
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
  
  public Integer getSection()
  {
    return this.section;
  }
  
  public void setSection(Integer paramInteger)
  {
    this.section = paramInteger;
  }
  
  public Integer getBargaintype()
  {
    return this.bargaintype;
  }
  
  public void setBargaintype(Integer paramInteger)
  {
    this.bargaintype = paramInteger;
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
    return new StandardModel.PrimaryInfo("id", this.id);
  }
}
