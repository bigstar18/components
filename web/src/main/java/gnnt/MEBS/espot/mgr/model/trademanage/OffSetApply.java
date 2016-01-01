package gnnt.MEBS.espot.mgr.model.trademanage;

import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.mgr.model.translate.ClassDiscription;
import gnnt.MEBS.espot.mgr.model.firmmanage.MFirm;
import java.util.Date;

public class OffSetApply
  extends StandardModel
{
  private static final long serialVersionUID = 1L;
  @ClassDiscription(name="溢短货款申请ID", description="")
  private Long offSetId;
  @ClassDiscription(name="合同号", description="")
  private Long tradeNo;
  @ClassDiscription(name="申请方交易商", description="交易商代码")
  private MFirm firm;
  @ClassDiscription(name="溢短货款金额", description="")
  private Double offSet;
  @ClassDiscription(name="状态", description="状态 0：未处理 1：已撤销 2：已处理")
  private Integer status;
  @ClassDiscription(name="申请时间", description="")
  private Date applyTime;
  @ClassDiscription(name="处理时间", description="")
  private Date processTime;
  
  public Long getOffSetId()
  {
    return this.offSetId;
  }
  
  public void setOffSetId(Long paramLong)
  {
    this.offSetId = paramLong;
  }
  
  public Long getTradeNo()
  {
    return this.tradeNo;
  }
  
  public void setTradeNo(Long paramLong)
  {
    this.tradeNo = paramLong;
  }
  
  public MFirm getFirm()
  {
    return this.firm;
  }
  
  public void setFirm(MFirm paramMFirm)
  {
    this.firm = paramMFirm;
  }
  
  public Double getOffSet()
  {
    return this.offSet;
  }
  
  public void setOffSet(Double paramDouble)
  {
    this.offSet = paramDouble;
  }
  
  public Integer getStatus()
  {
    return this.status;
  }
  
  public void setStatus(Integer paramInteger)
  {
    this.status = paramInteger;
  }
  
  public Date getApplyTime()
  {
    return this.applyTime;
  }
  
  public void setApplyTime(Date paramDate)
  {
    this.applyTime = paramDate;
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
    return new StandardModel.PrimaryInfo("offSetId", this.offSetId);
  }
}
