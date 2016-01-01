package gnnt.MEBS.espot.front.model.funds;

import gnnt.MEBS.common.front.model.StandardModel;
import gnnt.MEBS.common.front.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.front.model.integrated.MFirm;
import gnnt.MEBS.common.front.model.translate.ClassDiscription;
import gnnt.MEBS.espot.front.model.Summary;
import java.util.Date;

public class FundFlowBase
  extends StandardModel
{
  private static final long serialVersionUID = -7224787620835667203L;
  @ClassDiscription(name="资金流水号", description="")
  private Long fundFlowID;
  @ClassDiscription(name="所属交易商", description="")
  private MFirm belongtoFirm;
  @ClassDiscription(name="业务代码", description="")
  private String oprCode;
  @ClassDiscription(name="务信息", description="")
  private Summary belongtoSummary;
  @ClassDiscription(name="成交合同号", description="")
  private String contractNo;
  @ClassDiscription(name="商品代码", description="")
  private String commodityID;
  @ClassDiscription(name="发生额", description="")
  private Double amount;
  @ClassDiscription(name="资金余额", description="")
  private Double balance;
  @ClassDiscription(name="附加帐金额", description="")
  private Double appendAmount;
  @ClassDiscription(name="凭证号", description="")
  private Long voucherNo;
  @ClassDiscription(name="发生时间", description="")
  private Date createTime;
  @ClassDiscription(name="结算日期", description="")
  private Date bdate;
  
  public Long getFundFlowID()
  {
    return this.fundFlowID;
  }
  
  public void setFundFlowID(Long paramLong)
  {
    this.fundFlowID = paramLong;
  }
  
  public MFirm getBelongtoFirm()
  {
    return this.belongtoFirm;
  }
  
  public void setBelongtoFirm(MFirm paramMFirm)
  {
    this.belongtoFirm = paramMFirm;
  }
  
  public String getOprCode()
  {
    return this.oprCode;
  }
  
  public void setOprCode(String paramString)
  {
    this.oprCode = paramString;
  }
  
  public Summary getBelongtoSummary()
  {
    return this.belongtoSummary;
  }
  
  public void setBelongtoSummary(Summary paramSummary)
  {
    this.belongtoSummary = paramSummary;
  }
  
  public String getContractNo()
  {
    return this.contractNo;
  }
  
  public void setContractNo(String paramString)
  {
    this.contractNo = paramString;
  }
  
  public String getCommodityID()
  {
    return this.commodityID;
  }
  
  public void setCommodityID(String paramString)
  {
    this.commodityID = paramString;
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
  
  public Double getAppendAmount()
  {
    return this.appendAmount;
  }
  
  public void setAppendAmount(Double paramDouble)
  {
    this.appendAmount = paramDouble;
  }
  
  public Long getVoucherNo()
  {
    return this.voucherNo;
  }
  
  public void setVoucherNo(Long paramLong)
  {
    this.voucherNo = paramLong;
  }
  
  public Date getCreateTime()
  {
    return this.createTime;
  }
  
  public void setCreateTime(Date paramDate)
  {
    this.createTime = paramDate;
  }
  
  public Date getBdate()
  {
    return this.bdate;
  }
  
  public void setBdate(Date paramDate)
  {
    this.bdate = paramDate;
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return new StandardModel.PrimaryInfo("fundFlowID", this.fundFlowID);
  }
}
