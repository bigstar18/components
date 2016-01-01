package gnnt.MEBS.vendue.mgr.model.firmSet.specialSet;

import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.mgr.model.translate.ClassDiscription;
import java.util.Date;

public class SpecialMargin
  extends StandardModel
{
  private static final long serialVersionUID = -1807488736784396998L;
  @ClassDiscription(name="交易商特殊保证金主键ID", description="")
  private SpecialMarginId id;
  @ClassDiscription(name="保证金收取方式", description="")
  private Byte marginAlgr;
  @ClassDiscription(name="保证金", description="")
  private Double margin;
  @ClassDiscription(name="修改时间", description="")
  private Date updateTime;
  
  public SpecialMarginId getId()
  {
    return this.id;
  }
  
  public void setId(SpecialMarginId paramSpecialMarginId)
  {
    this.id = paramSpecialMarginId;
  }
  
  public Byte getMarginAlgr()
  {
    return this.marginAlgr;
  }
  
  public void setMarginAlgr(Byte paramByte)
  {
    this.marginAlgr = paramByte;
  }
  
  public Double getMargin()
  {
    return this.margin;
  }
  
  public void setMargin(Double paramDouble)
  {
    this.margin = paramDouble;
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
