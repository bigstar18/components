package gnnt.MEBS.espot.mgr.model.stockmanage;

import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.mgr.model.translate.ClassDiscription;
import gnnt.MEBS.espot.mgr.model.trademanage.TradeContract;
import java.util.Date;

public class TradeStock
  extends StandardModel
{
  private static final long serialVersionUID = 8483694614384519897L;
  @ClassDiscription(name="交易仓单编号", description="")
  private Long tradeStockID;
  @ClassDiscription(name="所属的仓单", description="对应仓单号")
  private Stock stock;
  @ClassDiscription(name="关联合同", description="对应合同号")
  private TradeContract trade;
  @ClassDiscription(name="创建时间", description="")
  private Date createTime;
  @ClassDiscription(name="释放时间", description="")
  private Date releaseTime;
  @ClassDiscription(name="状态", description="状态0：仓单使用中 1：交易成功仓单释放状态")
  private Integer status;
  @ClassDiscription(name="模块号", description="各系统的模块号")
  private Integer moduleID;
  @ClassDiscription(name="合同号", description="")
  private String tradeNo;
  
  public String getTradeNo()
  {
    return this.tradeNo;
  }
  
  public void setTradeNo(String paramString)
  {
    this.tradeNo = paramString;
  }
  
  public Long getTradeStockID()
  {
    return this.tradeStockID;
  }
  
  public void setTradeStockID(Long paramLong)
  {
    this.tradeStockID = paramLong;
  }
  
  public Stock getStock()
  {
    return this.stock;
  }
  
  public void setStock(Stock paramStock)
  {
    this.stock = paramStock;
  }
  
  public TradeContract getTrade()
  {
    return this.trade;
  }
  
  public void setTrade(TradeContract paramTradeContract)
  {
    this.trade = paramTradeContract;
  }
  
  public Date getCreateTime()
  {
    return this.createTime;
  }
  
  public void setCreateTime(Date paramDate)
  {
    this.createTime = paramDate;
  }
  
  public Date getReleaseTime()
  {
    return this.releaseTime;
  }
  
  public void setReleaseTime(Date paramDate)
  {
    this.releaseTime = paramDate;
  }
  
  public Integer getStatus()
  {
    return this.status;
  }
  
  public void setStatus(Integer paramInteger)
  {
    this.status = paramInteger;
  }
  
  public Integer getModuleID()
  {
    return this.moduleID;
  }
  
  public void setModuleID(Integer paramInteger)
  {
    this.moduleID = paramInteger;
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return new StandardModel.PrimaryInfo("tradeStockID", this.tradeStockID);
  }
}
