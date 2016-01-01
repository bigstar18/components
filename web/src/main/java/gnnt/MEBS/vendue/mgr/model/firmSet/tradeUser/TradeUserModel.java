package gnnt.MEBS.vendue.mgr.model.firmSet.tradeUser;

import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.mgr.model.translate.ClassDiscription;
import java.util.Date;

public class TradeUserModel
  extends StandardModel
{
  private static final long serialVersionUID = 1L;
  @ClassDiscription(name="交易商代码", description="")
  private String userCode;
  @ClassDiscription(name="虚拟资金", description="")
  private Double Overdraft;
  @ClassDiscription(name="挂单权限", description="挂单权限 0：无挂单权限 1：有挂单权限")
  private Integer isEntry;
  @ClassDiscription(name="成交次数", description="")
  private Long tradeCount;
  @ClassDiscription(name="竞价权限", description="竞价权限  0：全权 1：竞买有权 2：竞卖有权 3：无权")
  private Integer limits;
  @ClassDiscription(name="是否允许连续下单", description="是否允许连续下单  0：不允许连续下单 1：允许连续下单")
  private Integer isContinueOrder;
  @ClassDiscription(name="修改时间", description="")
  private Date modifytime = new Date();
  @ClassDiscription(name="关联交易商", description="")
  private M_Firm firm;
  @ClassDiscription(name="关联交易商资金", description="")
  private FirmFunds firmFunds;
  
  public String getUserCode()
  {
    return this.userCode;
  }
  
  public void setUserCode(String paramString)
  {
    this.userCode = paramString;
  }
  
  public Double getOverdraft()
  {
    return this.Overdraft;
  }
  
  public void setOverdraft(Double paramDouble)
  {
    this.Overdraft = paramDouble;
  }
  
  public Integer getIsEntry()
  {
    return this.isEntry;
  }
  
  public void setIsEntry(Integer paramInteger)
  {
    this.isEntry = paramInteger;
  }
  
  public Long getTradeCount()
  {
    return this.tradeCount;
  }
  
  public void setTradeCount(Long paramLong)
  {
    this.tradeCount = paramLong;
  }
  
  public Integer getLimits()
  {
    return this.limits;
  }
  
  public void setLimits(Integer paramInteger)
  {
    this.limits = paramInteger;
  }
  
  public Integer getIsContinueOrder()
  {
    return this.isContinueOrder;
  }
  
  public void setIsContinueOrder(Integer paramInteger)
  {
    this.isContinueOrder = paramInteger;
  }
  
  public Date getModifytime()
  {
    return this.modifytime;
  }
  
  public void setModifytime(Date paramDate)
  {
    this.modifytime = paramDate;
  }
  
  public M_Firm getFirm()
  {
    return this.firm;
  }
  
  public void setFirm(M_Firm paramM_Firm)
  {
    this.firm = paramM_Firm;
  }
  
  public FirmFunds getFirmFunds()
  {
    return this.firmFunds;
  }
  
  public void setFirmFunds(FirmFunds paramFirmFunds)
  {
    this.firmFunds = paramFirmFunds;
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return new StandardModel.PrimaryInfo("userCode", this.userCode);
  }
}
