package gnnt.MEBS.espot.front.model;

import gnnt.MEBS.common.front.model.StandardModel;
import gnnt.MEBS.common.front.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.front.model.translate.ClassDiscription;

public class Summary
  extends StandardModel
{
  private static final long serialVersionUID = -3562441339516891037L;
  @ClassDiscription(name="摘要号", description="")
  private String summaryNo;
  @ClassDiscription(name="摘要", description="")
  private String summary;
  @ClassDiscription(name="归入总账项目", description="")
  private String ledgerItem;
  @ClassDiscription(name="资金借贷方向", description="该凭证如果涉及交易商资金，增加资金记贷方 C，减少资金记借方 D。不涉及交易商资金：N")
  private String fundDCFlag;
  @ClassDiscription(name="对方科目代码", description="")
  private String accountCodeOpp;
  @ClassDiscription(name="附加帐", description="除了资金发生变动外，还有附加的财务账户变动。T：增值税 Tax W：担保金 Warranty S：履约保证金 SettleMargin N：无附加")
  private String appendAccount;
  
  public String getSummaryNo()
  {
    return this.summaryNo;
  }
  
  public void setSummaryNo(String paramString)
  {
    this.summaryNo = paramString;
  }
  
  public String getSummary()
  {
    return this.summary;
  }
  
  public void setSummary(String paramString)
  {
    this.summary = paramString;
  }
  
  public String getLedgerItem()
  {
    return this.ledgerItem;
  }
  
  public void setLedgerItem(String paramString)
  {
    this.ledgerItem = paramString;
  }
  
  public String getFundDCFlag()
  {
    return this.fundDCFlag;
  }
  
  public void setFundDCFlag(String paramString)
  {
    this.fundDCFlag = paramString;
  }
  
  public String getAccountCodeOpp()
  {
    return this.accountCodeOpp;
  }
  
  public void setAccountCodeOpp(String paramString)
  {
    this.accountCodeOpp = paramString;
  }
  
  public String getAppendAccount()
  {
    return this.appendAccount;
  }
  
  public void setAppendAccount(String paramString)
  {
    this.appendAccount = paramString;
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return new StandardModel.PrimaryInfo("summaryNo", this.summaryNo);
  }
}
