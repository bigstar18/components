package gnnt.MEBS.espot.front.model.warehousestock;

import gnnt.MEBS.common.front.model.StandardModel;
import gnnt.MEBS.common.front.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.front.model.translate.ClassDiscription;
import gnnt.MEBS.espot.front.model.trade.Order;
import java.util.Date;

public class PledgeStock
  extends StandardModel
{
  private static final long serialVersionUID = -3984719229420215554L;
  @ClassDiscription(name="卖仓单编号", description="")
  private Long pledgeStock;
  @ClassDiscription(name="所属仓单", description="对应仓单号")
  private Stock belongtoStock;
  @ClassDiscription(name="所属委托", description="对应委托号")
  private Order belongtoOrder;
  @ClassDiscription(name="状态", description="状态 0：仓单使用中 1：交易成功仓单释放状态")
  private Integer status;
  @ClassDiscription(name="创建时间", description="")
  private Date createTime;
  @ClassDiscription(name="释放时间", description="")
  private Date releaseTime;
  
  public Long getPledgeStock()
  {
    return this.pledgeStock;
  }
  
  public void setPledgeStock(Long paramLong)
  {
    this.pledgeStock = paramLong;
  }
  
  public Stock getBelongtoStock()
  {
    return this.belongtoStock;
  }
  
  public void setBelongtoStock(Stock paramStock)
  {
    this.belongtoStock = paramStock;
  }
  
  public Order getBelongtoOrder()
  {
    return this.belongtoOrder;
  }
  
  public void setBelongtoOrder(Order paramOrder)
  {
    this.belongtoOrder = paramOrder;
  }
  
  public Integer getStatus()
  {
    return this.status;
  }
  
  public void setStatus(Integer paramInteger)
  {
    this.status = paramInteger;
  }
  
  public Date getCreateTime()
  {
    return this.createTime;
  }
  
  public void setCreateTime(Date paramDate)
  {
    this.createTime = paramDate;
  }
  
  public Date getReleaseTime()
  {
    return this.releaseTime;
  }
  
  public void setReleaseTime(Date paramDate)
  {
    this.releaseTime = paramDate;
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return new StandardModel.PrimaryInfo("pledgeStock", this.pledgeStock);
  }
}
