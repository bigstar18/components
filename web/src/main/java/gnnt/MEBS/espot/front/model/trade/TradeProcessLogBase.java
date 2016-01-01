package gnnt.MEBS.espot.front.model.trade;

import gnnt.MEBS.common.front.model.StandardModel;
import gnnt.MEBS.common.front.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.front.model.integrated.MFirm;
import gnnt.MEBS.common.front.model.translate.ClassDiscription;
import java.util.Date;

public class TradeProcessLogBase
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
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return null;
  }
}
