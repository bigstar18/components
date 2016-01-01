package gnnt.MEBS.espot.front.model.warehousestock;

import gnnt.MEBS.common.front.model.StandardModel;
import gnnt.MEBS.common.front.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.front.model.translate.ClassDiscription;
import gnnt.MEBS.espot.front.model.trade.Trade;
import java.util.Date;

public class TradeStock
  extends StandardModel
{
  private static final long serialVersionUID = 8483694614384519897L;
  @ClassDiscription(name="交易仓单编号", description="")
  private Long tradeStockID;
  @ClassDiscription(name="所属仓单", description="对应仓单号")
  private Stock belongtoStock;
  @ClassDiscription(name="用于交易的合同号", description="")
  private Trade belongtoTrade;
  @ClassDiscription(name="创建时间", description="")
  private Date createTime;
  @ClassDiscription(name="释放时间", description="")
  private Date releaseTime;
  @ClassDiscription(name="状态", description="状态 0：仓单使用中 1：交易成功仓单释放状态")
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
  
  public Stock getBelongtoStock()
  {
    return this.belongtoStock;
  }
  
  public void setBelongtoStock(Stock paramStock)
  {
    this.belongtoStock = paramStock;
  }
  
  public Trade getBelongtoTrade()
  {
    return this.belongtoTrade;
  }
  
  public void setBelongtoTrade(Trade paramTrade)
  {
    this.belongtoTrade = paramTrade;
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
