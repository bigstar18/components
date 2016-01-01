package gnnt.MEBS.espot.front.model.funds;

import gnnt.MEBS.common.front.model.StandardModel;
import gnnt.MEBS.common.front.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.front.model.integrated.MFirm;
import gnnt.MEBS.common.front.model.translate.ClassDiscription;
import java.util.Date;

public class SubscriptionFlow
  extends StandardModel
{
  private static final long serialVersionUID = 4832278142006093131L;
  @ClassDiscription(name="划转编号", description="")
  private Long flowID;
  @ClassDiscription(name="流水类型", description="流水类型 1： 入金 2：出金 3：扣款")
  private Integer oprcode;
  @ClassDiscription(name="所属交易商", description="")
  private MFirm belongtoFirm;
  @ClassDiscription(name="划转金额", description="")
  private Double amount;
  @ClassDiscription(name="转后余额", description="")
  private Double balance;
  @ClassDiscription(name="划转时间", description="")
  private Date createTime;
  
  public Long getFlowID()
  {
    return this.flowID;
  }
  
  public void setFlowID(Long paramLong)
  {
    this.flowID = paramLong;
  }
  
  public Integer getOprcode()
  {
    return this.oprcode;
  }
  
  public void setOprcode(Integer paramInteger)
  {
    this.oprcode = paramInteger;
  }
  
  public MFirm getBelongtoFirm()
  {
    return this.belongtoFirm;
  }
  
  public void setBelongtoFirm(MFirm paramMFirm)
  {
    this.belongtoFirm = paramMFirm;
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
    return new StandardModel.PrimaryInfo("flowID", this.flowID);
  }
}
