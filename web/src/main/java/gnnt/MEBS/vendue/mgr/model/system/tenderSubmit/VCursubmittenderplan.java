package gnnt.MEBS.vendue.mgr.model.system.tenderSubmit;

import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.model.StandardModel.PrimaryInfo;
import java.util.Date;

public class VCursubmittenderplan
  extends StandardModel
{
  private static final long serialVersionUID = 1L;
  private Long id;
  private Short tradepartition;
  private String code;
  private Double price;
  private Double amount;
  private Double confirmamount;
  private String traderid;
  private String userid;
  private Date submittime;
  private Short ordertype;
  private Double validamount;
  private Date modifytime;
  private Double frozenmargin;
  private Double frozenfee;
  private Double unfrozenmargin;
  private Double unfrozenfee;
  private Byte withdrawtype;
  
  public Long getId()
  {
    return this.id;
  }
  
  public void setId(Long paramLong)
  {
    this.id = paramLong;
  }
  
  public Short getTradepartition()
  {
    return this.tradepartition;
  }
  
  public void setTradepartition(Short paramShort)
  {
    this.tradepartition = paramShort;
  }
  
  public String getCode()
  {
    return this.code;
  }
  
  public void setCode(String paramString)
  {
    this.code = paramString;
  }
  
  public Double getPrice()
  {
    return this.price;
  }
  
  public void setPrice(Double paramDouble)
  {
    this.price = paramDouble;
  }
  
  public Double getAmount()
  {
    return this.amount;
  }
  
  public void setAmount(Double paramDouble)
  {
    this.amount = paramDouble;
  }
  
  public Double getConfirmamount()
  {
    return this.confirmamount;
  }
  
  public void setConfirmamount(Double paramDouble)
  {
    this.confirmamount = paramDouble;
  }
  
  public String getTraderid()
  {
    return this.traderid;
  }
  
  public void setTraderid(String paramString)
  {
    this.traderid = paramString;
  }
  
  public String getUserid()
  {
    return this.userid;
  }
  
  public void setUserid(String paramString)
  {
    this.userid = paramString;
  }
  
  public Date getSubmittime()
  {
    return this.submittime;
  }
  
  public void setSubmittime(Date paramDate)
  {
    this.submittime = paramDate;
  }
  
  public Short getOrdertype()
  {
    return this.ordertype;
  }
  
  public void setOrdertype(Short paramShort)
  {
    this.ordertype = paramShort;
  }
  
  public Double getValidamount()
  {
    return this.validamount;
  }
  
  public void setValidamount(Double paramDouble)
  {
    this.validamount = paramDouble;
  }
  
  public Date getModifytime()
  {
    return this.modifytime;
  }
  
  public void setModifytime(Date paramDate)
  {
    this.modifytime = paramDate;
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
  
  public Double getUnfrozenmargin()
  {
    return this.unfrozenmargin;
  }
  
  public void setUnfrozenmargin(Double paramDouble)
  {
    this.unfrozenmargin = paramDouble;
  }
  
  public Double getUnfrozenfee()
  {
    return this.unfrozenfee;
  }
  
  public void setUnfrozenfee(Double paramDouble)
  {
    this.unfrozenfee = paramDouble;
  }
  
  public Byte getWithdrawtype()
  {
    return this.withdrawtype;
  }
  
  public void setWithdrawtype(Byte paramByte)
  {
    this.withdrawtype = paramByte;
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return new StandardModel.PrimaryInfo("id", this.id);
  }
}
