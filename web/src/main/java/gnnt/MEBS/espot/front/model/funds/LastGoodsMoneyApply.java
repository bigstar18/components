package gnnt.MEBS.espot.front.model.funds;

import gnnt.MEBS.common.front.model.StandardModel;
import gnnt.MEBS.common.front.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.front.model.translate.ClassDiscription;
import java.util.Date;

public class LastGoodsMoneyApply
  extends StandardModel
{
  private static final long serialVersionUID = 803507627637478422L;
  @ClassDiscription(name="申请编", description="")
  private Long id;
  @ClassDiscription(name="合同号", description="")
  private Long tradeNO;
  @ClassDiscription(name="状态", description="状态 0：卖方申请，1：卖方撤销，2： 管理员撤销，3： 已处理")
  private Integer status;
  @ClassDiscription(name="记录创建时间", description="")
  private Date createTime;
  @ClassDiscription(name="处理时间", description="")
  private Date processTime;
  
  public Long getId()
  {
    return this.id;
  }
  
  public void setId(Long paramLong)
  {
    this.id = paramLong;
  }
  
  public Long getTradeNO()
  {
    return this.tradeNO;
  }
  
  public void setTradeNO(Long paramLong)
  {
    this.tradeNO = paramLong;
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
  
  public Date getProcessTime()
  {
    return this.processTime;
  }
  
  public void setProcessTime(Date paramDate)
  {
    this.processTime = paramDate;
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return new StandardModel.PrimaryInfo("ID", this.id);
  }
}
