package gnnt.MEBS.vendue.mgr.model.firmSet.specialSet;

import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.mgr.model.translate.ClassDiscription;
import java.util.Date;

public class SpecialFee
  extends StandardModel
{
  private static final long serialVersionUID = -7935328585945126159L;
  @ClassDiscription(name="交易商特殊手续费主键", description="")
  private SpecialFeeId id;
  @ClassDiscription(name="手续费收取方式", description="")
  private Byte feeAlgr;
  @ClassDiscription(name="手续费", description="")
  private Double fee;
  @ClassDiscription(name="修改时间", description="")
  private Date updateTime;
  
  public SpecialFeeId getId()
  {
    return this.id;
  }
  
  public void setId(SpecialFeeId paramSpecialFeeId)
  {
    this.id = paramSpecialFeeId;
  }
  
  public Byte getFeeAlgr()
  {
    return this.feeAlgr;
  }
  
  public void setFeeAlgr(Byte paramByte)
  {
    this.feeAlgr = paramByte;
  }
  
  public Double getFee()
  {
    return this.fee;
  }
  
  public void setFee(Double paramDouble)
  {
    this.fee = paramDouble;
  }
  
  public Date getUpdateTime()
  {
    return this.updateTime;
  }
  
  public void setUpdateTime(Date paramDate)
  {
    this.updateTime = paramDate;
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return new StandardModel.PrimaryInfo("id", this.id);
  }
}
