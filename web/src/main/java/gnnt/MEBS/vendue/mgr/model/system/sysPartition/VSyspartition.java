package gnnt.MEBS.vendue.mgr.model.system.sysPartition;

import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.mgr.model.translate.ClassDiscription;

public class VSyspartition
  extends StandardModel
{
  private static final long serialVersionUID = -1876830851987664388L;
  @ClassDiscription(name="板块编号", description="")
  private Short partitionid;
  @ClassDiscription(name="是否加载此项配置数据", description="是否加载此项配置数据 0：不加载 1：加载")
  private Short validflag;
  @ClassDiscription(name="对此板块的描述用户管理后台的现实", description="")
  private String description;
  @ClassDiscription(name="交易模式", description="")
  private VTrademodeparams trademode;
  @ClassDiscription(name="自选商品最大数量", description="")
  private Long selfrate;
  @ClassDiscription(name="节间休息是否显示下一交易节行情", description="")
  private Byte isshowquotation;
  @ClassDiscription(name="品种展示交收属性最大量", description="")
  private Integer maxshowqty;
  @ClassDiscription(name="倒计时模式", description="")
  private Byte countmode;
  @ClassDiscription(name="是否启用无余量倒计时", description="是否启用无余量倒计时0：不启用 1：启用")
  private Byte ismargincount;
  @ClassDiscription(name="是否拆分标的", description="是否拆分标的 0：不拆分 1：拆分")
  private Byte issplittarget;
  @ClassDiscription(name="是否显示起拍价和报警价", description="是否显示起拍价和报警家 0：不显示 1：显示")
  private Byte isshowprice;
  
  public Short getPartitionid()
  {
    return this.partitionid;
  }
  
  public void setPartitionid(Short paramShort)
  {
    this.partitionid = paramShort;
  }
  
  public Short getValidflag()
  {
    return this.validflag;
  }
  
  public void setValidflag(Short paramShort)
  {
    this.validflag = paramShort;
  }
  
  public String getDescription()
  {
    return this.description;
  }
  
  public void setDescription(String paramString)
  {
    this.description = paramString;
  }
  
  public VTrademodeparams getTrademode()
  {
    return this.trademode;
  }
  
  public void setTrademode(VTrademodeparams paramVTrademodeparams)
  {
    this.trademode = paramVTrademodeparams;
  }
  
  public Long getSelfrate()
  {
    return this.selfrate;
  }
  
  public void setSelfrate(Long paramLong)
  {
    this.selfrate = paramLong;
  }
  
  public Byte getIsshowquotation()
  {
    return this.isshowquotation;
  }
  
  public void setIsshowquotation(Byte paramByte)
  {
    this.isshowquotation = paramByte;
  }
  
  public Integer getMaxshowqty()
  {
    return this.maxshowqty;
  }
  
  public void setMaxshowqty(Integer paramInteger)
  {
    this.maxshowqty = paramInteger;
  }
  
  public Byte getCountmode()
  {
    return this.countmode;
  }
  
  public void setCountmode(Byte paramByte)
  {
    this.countmode = paramByte;
  }
  
  public Byte getIsmargincount()
  {
    return this.ismargincount;
  }
  
  public void setIsmargincount(Byte paramByte)
  {
    this.ismargincount = paramByte;
  }
  
  public Byte getIssplittarget()
  {
    return this.issplittarget;
  }
  
  public void setIssplittarget(Byte paramByte)
  {
    this.issplittarget = paramByte;
  }
  
  public Byte getIsshowprice()
  {
    return this.isshowprice;
  }
  
  public void setIsshowprice(Byte paramByte)
  {
    this.isshowprice = paramByte;
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return new StandardModel.PrimaryInfo("partitionid", this.partitionid);
  }
}
