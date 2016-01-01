package gnnt.MEBS.espot.mgr.model.fundmanage;

import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.mgr.model.translate.ClassDiscription;
import gnnt.MEBS.espot.mgr.model.firmmanage.MFirm;
import java.util.Date;

public class SubscriptionFlow
  extends StandardModel
{
  private static final long serialVersionUID = 1L;
  @ClassDiscription(name="流水ID", description="")
  private Long flowId;
  @ClassDiscription(name="业务代码", description="")
  private Integer oprcode;
  @ClassDiscription(name="关联的交易商", description="对应交易商代码")
  private MFirm firm;
  @ClassDiscription(name="发生额", description="")
  private Double amount;
  @ClassDiscription(name="余额", description="")
  private Double balance;
  @ClassDiscription(name="创建时间", description="")
  private Date createTime;
  
  public Long getFlowId()
  {
    return this.flowId;
  }
  
  public void setFlowId(Long paramLong)
  {
    this.flowId = paramLong;
  }
  
  public Integer getOprcode()
  {
    return this.oprcode;
  }
  
  public void setOprcode(Integer paramInteger)
  {
    this.oprcode = paramInteger;
  }
  
  public MFirm getFirm()
  {
    return this.firm;
  }
  
  public void setFirm(MFirm paramMFirm)
  {
    this.firm = paramMFirm;
  }
  
  public Double getAmount()
  {
    return this.amount;
  }
  
  public void setAmount(Double paramDouble)
  {
    this.amount = paramDouble;
  }
  
  public Double getBalance()
  {
    return this.balance;
  }
  
  public void setBalance(Double paramDouble)
  {
    this.balance = paramDouble;
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
    return new StandardModel.PrimaryInfo("flowId", this.flowId);
  }
}
