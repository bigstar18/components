package gnnt.MEBS.espot.mgr.model.trademanage;

import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.mgr.model.translate.ClassDiscription;
import gnnt.MEBS.espot.mgr.model.firmmanage.MFirm;
import java.util.Date;

public class EndTradeApply
  extends StandardModel
{
  private static final long serialVersionUID = -4299646921606259412L;
  @ClassDiscription(name="终止合同申请号", description="")
  private Long applyId;
  @ClassDiscription(name="合同号", description="")
  private Long tradeNo;
  @ClassDiscription(name=" 关联申请方交易商", description="对应交易商代码")
  private MFirm firm;
  @ClassDiscription(name="状态", description="状态 0：未处理 1：已撤销 2：已处理")
  private Integer status;
  @ClassDiscription(name="申请时间", description="")
  private Date applyTime;
  @ClassDiscription(name="处理时间", description="")
  private Date processTime;
  
  public Long getApplyId()
  {
    return this.applyId;
  }
  
  public void setApplyId(Long paramLong)
  {
    this.applyId = paramLong;
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
    return new StandardModel.PrimaryInfo("applyId", this.applyId);
  }
}
