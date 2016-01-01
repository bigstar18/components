package gnnt.MEBS.vendue.mgr.model.commodity.commodityparams;

import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.mgr.model.translate.ClassDiscription;

public class VCommodityparams
  extends StandardModel
{
  private static final long serialVersionUID = 6019328423094068953L;
  @ClassDiscription(name="交易板块", description="")
  private Short tradepartition;
  @ClassDiscription(name="品种ID", description="")
  private Long breedid;
  @ClassDiscription(name="交易数量单位", description="")
  private String tradeunit;
  @ClassDiscription(name="最小报单数量", description="")
  private String minamount;
  @ClassDiscription(name="最大报单数量", description="")
  private String maxamount;
  @ClassDiscription(name="加价幅度", description="")
  private String stepprice;
  @ClassDiscription(name="最高加价幅度", description="")
  private String maxstepprice;
  @ClassDiscription(name="保证金收取方式", description="")
  private Byte marginalgr;
  @ClassDiscription(name="买方保证金系数", description="")
  private String BSecurity;
  @ClassDiscription(name="卖方保证金系数", description="")
  private String SSecurity;
  @ClassDiscription(name="手续费收取方式", description="")
  private Byte feealgr;
  @ClassDiscription(name="买方手续费系数", description="")
  private String BFee;
  @ClassDiscription(name="卖方手续费系数", description="")
  private String SFee;
  @ClassDiscription(name="流拍数量计算方式", description="")
  private Byte flowamountalgr;
  @ClassDiscription(name="流拍量", description="")
  private String flowamount;
  
  public Short getTradepartition()
  {
    return this.tradepartition;
  }
  
  public void setTradepartition(Short paramShort)
  {
    this.tradepartition = paramShort;
  }
  
  public Long getBreedid()
  {
    return this.breedid;
  }
  
  public void setBreedid(Long paramLong)
  {
    this.breedid = paramLong;
  }
  
  public String getTradeunit()
  {
    return this.tradeunit;
  }
  
  public void setTradeunit(String paramString)
  {
    this.tradeunit = paramString;
  }
  
  public String getMinamount()
  {
    return this.minamount;
  }
  
  public void setMinamount(String paramString)
  {
    this.minamount = paramString;
  }
  
  public String getMaxamount()
  {
    return this.maxamount;
  }
  
  public void setMaxamount(String paramString)
  {
    this.maxamount = paramString;
  }
  
  public String getStepprice()
  {
    return this.stepprice;
  }
  
  public void setStepprice(String paramString)
  {
    this.stepprice = paramString;
  }
  
  public String getMaxstepprice()
  {
    return this.maxstepprice;
  }
  
  public void setMaxstepprice(String paramString)
  {
    this.maxstepprice = paramString;
  }
  
  public Byte getMarginalgr()
  {
    return this.marginalgr;
  }
  
  public void setMarginalgr(Byte paramByte)
  {
    this.marginalgr = paramByte;
  }
  
  public String getBSecurity()
  {
    return this.BSecurity;
  }
  
  public void setBSecurity(String paramString)
  {
    this.BSecurity = paramString;
  }
  
  public String getSSecurity()
  {
    return this.SSecurity;
  }
  
  public void setSSecurity(String paramString)
  {
    this.SSecurity = paramString;
  }
  
  public Byte getFeealgr()
  {
    return this.feealgr;
  }
  
  public void setFeealgr(Byte paramByte)
  {
    this.feealgr = paramByte;
  }
  
  public String getBFee()
  {
    return this.BFee;
  }
  
  public void setBFee(String paramString)
  {
    this.BFee = paramString;
  }
  
  public String getSFee()
  {
    return this.SFee;
  }
  
  public void setSFee(String paramString)
  {
    this.SFee = paramString;
  }
  
  public Byte getFlowamountalgr()
  {
    return this.flowamountalgr;
  }
  
  public void setFlowamountalgr(Byte paramByte)
  {
    this.flowamountalgr = paramByte;
  }
  
  public String getFlowamount()
  {
    return this.flowamount;
  }
  
  public void setFlowamount(String paramString)
  {
    this.flowamount = paramString;
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return new StandardModel.PrimaryInfo("breedid", this.breedid);
  }
}
