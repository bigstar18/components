package gnnt.MEBS.espot.mgr.model.trademanage;

import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.mgr.model.translate.ClassDiscription;
import java.util.Date;

public class Arbitration
  extends StandardModel
{
  private static final long serialVersionUID = -8294944388996645292L;
  @ClassDiscription(name="仲裁ID", description="")
  private Integer arbitrationId;
  @ClassDiscription(name="合同号", description="")
  private Long tradeNo;
  @ClassDiscription(name="仲裁类型", description="仲裁类型1： 退货 2：退款 3：投诉")
  private Integer type;
  @ClassDiscription(name="申请仲裁描述", description="")
  private String apply;
  @ClassDiscription(name="申请人", description="")
  private String applicant;
  @ClassDiscription(name="申请时间", description="")
  private Date applyTime;
  @ClassDiscription(name="处理结果", description="处理结果0：未处理 1：已处理")
  private Integer result;
  @ClassDiscription(name="处理说明", description="")
  private String processNote;
  @ClassDiscription(name="处理人", description="")
  private String processUser;
  @ClassDiscription(name="处理时间", description="")
  private Date processTime;
  
  public Integer getArbitrationId()
  {
    return this.arbitrationId;
  }
  
  public void setArbitrationId(Integer paramInteger)
  {
    this.arbitrationId = paramInteger;
  }
  
  public Long getTradeNo()
  {
    return this.tradeNo;
  }
  
  public void setTradeNo(Long paramLong)
  {
    this.tradeNo = paramLong;
  }
  
  public Integer getType()
  {
    return this.type;
  }
  
  public void setType(Integer paramInteger)
  {
    this.type = paramInteger;
  }
  
  public String getApply()
  {
    return this.apply;
  }
  
  public void setApply(String paramString)
  {
    this.apply = paramString;
  }
  
  public Date getApplyTime()
  {
    return this.applyTime;
  }
  
  public void setApplyTime(Date paramDate)
  {
    this.applyTime = paramDate;
  }
  
  public Integer getResult()
  {
    return this.result;
  }
  
  public void setResult(Integer paramInteger)
  {
    this.result = paramInteger;
  }
  
  public String getProcessNote()
  {
    return this.processNote;
  }
  
  public void setProcessNote(String paramString)
  {
    this.processNote = paramString;
  }
  
  public Date getProcessTime()
  {
    return this.processTime;
  }
  
  public void setProcessTime(Date paramDate)
  {
    this.processTime = paramDate;
  }
  
  public String getApplicant()
  {
    return this.applicant;
  }
  
  public void setApplicant(String paramString)
  {
    this.applicant = paramString;
  }
  
  public String getProcessUser()
  {
    return this.processUser;
  }
  
  public void setProcessUser(String paramString)
  {
    this.processUser = paramString;
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return new StandardModel.PrimaryInfo("arbitrationId", this.arbitrationId);
  }
}
