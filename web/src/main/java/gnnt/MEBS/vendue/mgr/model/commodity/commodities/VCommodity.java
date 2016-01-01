package gnnt.MEBS.vendue.mgr.model.commodity.commodities;

import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.mgr.model.translate.ClassDiscription;
import java.util.Date;

public class VCommodity
  extends StandardModel
{
  private static final long serialVersionUID = -7363028501250152527L;
  @ClassDiscription(name="标的号", description="")
  private Integer code;
  @ClassDiscription(name="第一次挂标日期", description="")
  private Date firsttime;
  @ClassDiscription(name="商品ID", description="")
  private String commodityid;
  @ClassDiscription(name="录入时间", description="")
  private Date createtime;
  @ClassDiscription(name="交易板块", description="")
  private Short tradepartition;
  @ClassDiscription(name="商品状态", description="")
  private Short status;
  @ClassDiscription(name="品种ID", description="")
  private Long breedid;
  @ClassDiscription(name="拆合标关系", description="")
  private String splitid;
  @ClassDiscription(name="交易用户ID", description="")
  private String userid;
  @ClassDiscription(name="商品数量", description="")
  private Double amount;
  @ClassDiscription(name="交易数量单位", description="")
  private Double tradeunit;
  @ClassDiscription(name="最小报单数量", description="")
  private Double minamount;
  @ClassDiscription(name="最大报单数量", description="")
  private Double maxamount;
  @ClassDiscription(name="流拍数量计算方式", description="")
  private Byte flowamountalgr;
  @ClassDiscription(name="流拍量", description="")
  private Double flowamount;
  @ClassDiscription(name="起拍价", description="")
  private Double beginprice;
  @ClassDiscription(name="报警价", description="")
  private Double alertprice;
  @ClassDiscription(name="加价幅度", description="")
  private Double stepprice;
  @ClassDiscription(name="最高加价幅度", description="")
  private Double maxstepprice;
  @ClassDiscription(name="保证金收取方式", description="")
  private Byte marginalgr;
  @ClassDiscription(name="买方保证金系数", description="")
  private Double BSecurity;
  @ClassDiscription(name="卖方保证金系数", description="")
  private Double SSecurity;
  @ClassDiscription(name="手续费收取方式", description="")
  private Byte feealgr;
  @ClassDiscription(name="买方手续费系数", description="")
  private Double BFee;
  @ClassDiscription(name="卖方手续费系数", description="")
  private Double SFee;
  @ClassDiscription(name="权限设置", description="")
  private Byte authorization;
  @ClassDiscription(name="挂单方是否可下单", description="挂单方是否可下单  0：挂单方不可下单 1：挂单方可下单")
  private Byte isorder;
  @ClassDiscription(name="审核状态", description="审核状态0：未审核 1：审核通过 2：审核失败")
  private Byte auditstatus;
  @ClassDiscription(name="审核人", description="")
  private String audituser;
  @ClassDiscription(name="审核时间", description="")
  private Date audittime;
  @ClassDiscription(name="备注", description="")
  private String remark;
  @ClassDiscription(name="买卖方向", description="买卖方向 1：买 2：买")
  private Byte bsFlag;
  @ClassDiscription(name="招标成交确认", description="招标成交确认 0：未确认成交 1：已确认成交")
  private Byte tendertradeconfirm;
  
  public Integer getCode()
  {
    return this.code;
  }
  
  public void setCode(Integer paramInteger)
  {
    this.code = paramInteger;
  }
  
  public Date getFirsttime()
  {
    return this.firsttime;
  }
  
  public void setFirsttime(Date paramDate)
  {
    this.firsttime = paramDate;
  }
  
  public String getCommodityid()
  {
    return this.commodityid;
  }
  
  public void setCommodityid(String paramString)
  {
    this.commodityid = paramString;
  }
  
  public Date getCreatetime()
  {
    return this.createtime;
  }
  
  public void setCreatetime(Date paramDate)
  {
    this.createtime = paramDate;
  }
  
  public Short getTradepartition()
  {
    return this.tradepartition;
  }
  
  public void setTradepartition(Short paramShort)
  {
    this.tradepartition = paramShort;
  }
  
  public Short getStatus()
  {
    return this.status;
  }
  
  public void setStatus(Short paramShort)
  {
    this.status = paramShort;
  }
  
  public Long getBreedid()
  {
    return this.breedid;
  }
  
  public void setBreedid(Long paramLong)
  {
    this.breedid = paramLong;
  }
  
  public String getSplitid()
  {
    return this.splitid;
  }
  
  public void setSplitid(String paramString)
  {
    this.splitid = paramString;
  }
  
  public String getUserid()
  {
    return this.userid;
  }
  
  public void setUserid(String paramString)
  {
    this.userid = paramString;
  }
  
  public Double getAmount()
  {
    return this.amount;
  }
  
  public void setAmount(Double paramDouble)
  {
    this.amount = paramDouble;
  }
  
  public Double getTradeunit()
  {
    return this.tradeunit;
  }
  
  public void setTradeunit(Double paramDouble)
  {
    this.tradeunit = paramDouble;
  }
  
  public Double getMinamount()
  {
    return this.minamount;
  }
  
  public void setMinamount(Double paramDouble)
  {
    this.minamount = paramDouble;
  }
  
  public Double getMaxamount()
  {
    return this.maxamount;
  }
  
  public void setMaxamount(Double paramDouble)
  {
    this.maxamount = paramDouble;
  }
  
  public Byte getFlowamountalgr()
  {
    return this.flowamountalgr;
  }
  
  public void setFlowamountalgr(Byte paramByte)
  {
    this.flowamountalgr = paramByte;
  }
  
  public Double getFlowamount()
  {
    return this.flowamount;
  }
  
  public void setFlowamount(Double paramDouble)
  {
    this.flowamount = paramDouble;
  }
  
  public Double getBeginprice()
  {
    return this.beginprice;
  }
  
  public void setBeginprice(Double paramDouble)
  {
    this.beginprice = paramDouble;
  }
  
  public Double getAlertprice()
  {
    return this.alertprice;
  }
  
  public void setAlertprice(Double paramDouble)
  {
    this.alertprice = paramDouble;
  }
  
  public Double getStepprice()
  {
    return this.stepprice;
  }
  
  public void setStepprice(Double paramDouble)
  {
    this.stepprice = paramDouble;
  }
  
  public Double getMaxstepprice()
  {
    return this.maxstepprice;
  }
  
  public void setMaxstepprice(Double paramDouble)
  {
    this.maxstepprice = paramDouble;
  }
  
  public Byte getMarginalgr()
  {
    return this.marginalgr;
  }
  
  public void setMarginalgr(Byte paramByte)
  {
    this.marginalgr = paramByte;
  }
  
  public Double getBSecurity()
  {
    return this.BSecurity;
  }
  
  public void setBSecurity(Double paramDouble)
  {
    this.BSecurity = paramDouble;
  }
  
  public Double getSSecurity()
  {
    return this.SSecurity;
  }
  
  public void setSSecurity(Double paramDouble)
  {
    this.SSecurity = paramDouble;
  }
  
  public Byte getFeealgr()
  {
    return this.feealgr;
  }
  
  public void setFeealgr(Byte paramByte)
  {
    this.feealgr = paramByte;
  }
  
  public Double getBFee()
  {
    return this.BFee;
  }
  
  public void setBFee(Double paramDouble)
  {
    this.BFee = paramDouble;
  }
  
  public Double getSFee()
  {
    return this.SFee;
  }
  
  public void setSFee(Double paramDouble)
  {
    this.SFee = paramDouble;
  }
  
  public Byte getAuthorization()
  {
    return this.authorization;
  }
  
  public void setAuthorization(Byte paramByte)
  {
    this.authorization = paramByte;
  }
  
  public Byte getIsorder()
  {
    return this.isorder;
  }
  
  public void setIsorder(Byte paramByte)
  {
    this.isorder = paramByte;
  }
  
  public Byte getAuditstatus()
  {
    return this.auditstatus;
  }
  
  public void setAuditstatus(Byte paramByte)
  {
    this.auditstatus = paramByte;
  }
  
  public String getAudituser()
  {
    return this.audituser;
  }
  
  public void setAudituser(String paramString)
  {
    this.audituser = paramString;
  }
  
  public Date getAudittime()
  {
    return this.audittime;
  }
  
  public void setAudittime(Date paramDate)
  {
    this.audittime = paramDate;
  }
  
  public String getRemark()
  {
    return this.remark;
  }
  
  public void setRemark(String paramString)
  {
    this.remark = paramString;
  }
  
  public Byte getBsFlag()
  {
    return this.bsFlag;
  }
  
  public void setBsFlag(Byte paramByte)
  {
    this.bsFlag = paramByte;
  }
  
  public Byte getTendertradeconfirm()
  {
    return this.tendertradeconfirm;
  }
  
  public void setTendertradeconfirm(Byte paramByte)
  {
    this.tendertradeconfirm = paramByte;
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return new StandardModel.PrimaryInfo("code", this.code);
  }
}
