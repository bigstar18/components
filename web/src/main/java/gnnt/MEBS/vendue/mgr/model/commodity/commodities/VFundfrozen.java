package gnnt.MEBS.vendue.mgr.model.commodity.commodities;

import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.mgr.model.translate.ClassDiscription;
import java.util.Date;

public class VFundfrozen
  extends StandardModel
{
  private static final long serialVersionUID = 4506232419528315241L;
  @ClassDiscription(name="ID", description="")
  private Long id;
  @ClassDiscription(name="交易用户ID", description="")
  private String userid;
  @ClassDiscription(name="标的号", description="")
  private String code;
  @ClassDiscription(name="冻结保证金", description="")
  private Double frozenmargin;
  @ClassDiscription(name="冻结手续费", description="")
  private Double frozenfee;
  @ClassDiscription(name="冻结时间", description="")
  private Date frozentime;
  
  public VFundfrozen() {}
  
  public VFundfrozen(Long paramLong, String paramString1, String paramString2, Double paramDouble1, Double paramDouble2, Date paramDate)
  {
    this.id = paramLong;
    this.userid = paramString1;
    this.code = paramString2;
    this.frozenmargin = paramDouble1;
    this.frozenfee = paramDouble2;
    this.frozentime = paramDate;
  }
  
  public Long getId()
  {
    return this.id;
  }
  
  public void setId(Long paramLong)
  {
    this.id = paramLong;
  }
  
  public String getUserid()
  {
    return this.userid;
  }
  
  public void setUserid(String paramString)
  {
    this.userid = paramString;
  }
  
  public String getCode()
  {
    return this.code;
  }
  
  public void setCode(String paramString)
  {
    this.code = paramString;
  }
  
  public Double getFrozenmargin()
  {
    return this.frozenmargin;
  }
  
  public void setFrozenmargin(Double paramDouble)
  {
    this.frozenmargin = paramDouble;
  }
  
  public Double getFrozenfee()
  {
    return this.frozenfee;
  }
  
  public void setFrozenfee(Double paramDouble)
  {
    this.frozenfee = paramDouble;
  }
  
  public Date getFrozentime()
  {
    return this.frozentime;
  }
  
  public void setFrozentime(Date paramDate)
  {
    this.frozentime = paramDate;
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return new StandardModel.PrimaryInfo("id", this.id);
  }
}
