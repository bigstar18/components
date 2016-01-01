package gnnt.MEBS.espot.mgr.model.trademanage;

import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.mgr.model.translate.ClassDiscription;
import gnnt.MEBS.espot.mgr.model.firmmanage.MFirm;
import java.util.Date;

public class TradeContractLog
  extends StandardModel
{
  private static final long serialVersionUID = 1L;
  @ClassDiscription(name="日志编号", description="")
  private Long logId;
  @ClassDiscription(name="关联的交易商", description="对应交易商代码")
  private MFirm firm;
  @ClassDiscription(name="操作人", description="")
  private String operator;
  @ClassDiscription(name="处理信息", description="")
  private String processInfo;
  @ClassDiscription(name="处理时间", description="")
  private Date processTime;
  @ClassDiscription(name="关联的合同", description="对应合同号")
  private TradeContract trade;
  
  public Long getLogId()
  {
    return this.logId;
  }
  
  public void setLogId(Long paramLong)
  {
    this.logId = paramLong;
  }
  
  public MFirm getFirm()
  {
    return this.firm;
  }
  
  public void setFirm(MFirm paramMFirm)
  {
    this.firm = paramMFirm;
  }
  
  public String getOperator()
  {
    return this.operator;
  }
  
  public void setOperator(String paramString)
  {
    this.operator = paramString;
  }
  
  public String getProcessInfo()
  {
    return this.processInfo;
  }
  
  public void setProcessInfo(String paramString)
  {
    this.processInfo = paramString;
  }
  
  public Date getProcessTime()
  {
    return this.processTime;
  }
  
  public void setProcessTime(Date paramDate)
  {
    this.processTime = paramDate;
  }
  
  public TradeContract getTrade()
  {
    return this.trade;
  }
  
  public void setTrade(TradeContract paramTradeContract)
  {
    this.trade = paramTradeContract;
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return null;
  }
}
