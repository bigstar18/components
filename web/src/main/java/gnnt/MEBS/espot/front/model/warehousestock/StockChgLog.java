package gnnt.MEBS.espot.front.model.warehousestock;

import gnnt.MEBS.common.front.model.StandardModel;
import gnnt.MEBS.common.front.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.front.model.integrated.MFirm;
import gnnt.MEBS.common.front.model.translate.ClassDiscription;
import java.util.Date;

public class StockChgLog
  extends StandardModel
{
  private static final long serialVersionUID = -922720531671899615L;
  @ClassDiscription(name="变更记录ID", description="")
  private Long id;
  @ClassDiscription(name="所属仓单", description="对应仓单号")
  private Stock belongtoStock;
  @ClassDiscription(name="原货权人", description="")
  private MFirm srcFirm;
  @ClassDiscription(name="tarFirm", description="")
  private MFirm tarFirm;
  @ClassDiscription(name="变更时间", description="")
  private Date createTime;
  
  public Long getId()
  {
    return this.id;
  }
  
  public void setId(Long paramLong)
  {
    this.id = paramLong;
  }
  
  public Stock getBelongtoStock()
  {
    return this.belongtoStock;
  }
  
  public void setBelongtoStock(Stock paramStock)
  {
    this.belongtoStock = paramStock;
  }
  
  public MFirm getSrcFirm()
  {
    return this.srcFirm;
  }
  
  public void setSrcFirm(MFirm paramMFirm)
  {
    this.srcFirm = paramMFirm;
  }
  
  public MFirm getTarFirm()
  {
    return this.tarFirm;
  }
  
  public void setTarFirm(MFirm paramMFirm)
  {
    this.tarFirm = paramMFirm;
  }
  
  public Date getCreateTime()
  {
    return this.createTime;
  }
  
  public void setCreateTime(Date paramDate)
  {
    this.createTime = paramDate;
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return new StandardModel.PrimaryInfo("id", this.id);
  }
}
