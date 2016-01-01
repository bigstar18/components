package gnnt.MEBS.espot.mgr.model.shopmanage;

import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.mgr.model.translate.ClassDiscription;
import java.util.Date;

public class RecommendShop
  extends StandardModel
{
  private static final long serialVersionUID = 1143108019859496293L;
  @ClassDiscription(name="交易商代码", description="")
  private String firmId;
  @ClassDiscription(name="推荐排序号", description="")
  private Integer num;
  @ClassDiscription(name="推荐时间", description="")
  private Date recommendTime;
  @ClassDiscription(name="交易商店铺", description="对应交易商店铺号")
  private Shop shop;
  
  public void setFirmId(String paramString)
  {
    this.firmId = paramString;
  }
  
  public String getFirmId()
  {
    return this.firmId;
  }
  
  public Integer getNum()
  {
    return this.num;
  }
  
  public void setNum(Integer paramInteger)
  {
    this.num = paramInteger;
  }
  
  public Date getRecommendTime()
  {
    return this.recommendTime;
  }
  
  public void setRecommendTime(Date paramDate)
  {
    this.recommendTime = paramDate;
  }
  
  public Shop getShop()
  {
    return this.shop;
  }
  
  public void setShop(Shop paramShop)
  {
    this.shop = paramShop;
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return new StandardModel.PrimaryInfo("firmId", this.firmId);
  }
}
