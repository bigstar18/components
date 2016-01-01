package gnnt.MEBS.espot.mgr.model.trademanage;

import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.mgr.model.translate.ClassDiscription;
import java.util.Date;

public class NoOffset
  extends StandardModel
{
  private static final long serialVersionUID = -1052829548288510970L;
  @ClassDiscription(name="无溢短货款确认编号", description="")
  private Long id;
  @ClassDiscription(name="合同号", description="")
  private Long tradeNo;
  @ClassDiscription(name="确认时间", description="")
  private Date createTime;
  
  public Long getId()
  {
    return this.id;
  }
  
  public void setId(Long paramLong)
  {
    this.id = paramLong;
  }
  
  public Long getTradeNo()
  {
    return this.tradeNo;
  }
  
  public void setTradeNo(Long paramLong)
  {
    this.tradeNo = paramLong;
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
