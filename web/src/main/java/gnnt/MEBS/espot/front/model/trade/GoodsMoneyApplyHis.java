package gnnt.MEBS.espot.front.model.trade;

import gnnt.MEBS.common.front.model.StandardModel;
import gnnt.MEBS.common.front.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.front.model.translate.ClassDiscription;
import java.util.Date;

public class GoodsMoneyApplyHis
  extends StandardModel
{
  private static final long serialVersionUID = -5296136494903304738L;
  @ClassDiscription(name="申请ID", description="")
  private Long id;
  @ClassDiscription(name="关联合同", description="对应合同号")
  private TradeHis tradeContract;
  @ClassDiscription(name="申请时间", description="")
  private Date applyTime;
  @ClassDiscription(name="处理时间", description="")
  private Date processTime;
  @ClassDiscription(name="状态", description="状态 0：卖方申请，1：卖方撤销，2：管理员撤销，3：系统撤销，4：已处理")
  private Integer status;
  @ClassDiscription(name="类型", description="类型  0：首款追缴 1：第二笔货款追缴 2：尾款追缴")
  private Integer Type;
  
  public Integer getType()
  {
    return this.Type;
  }
  
  public void setType(Integer paramInteger)
  {
    this.Type = paramInteger;
  }
  
  public Long getId()
  {
    return this.id;
  }
  
  public void setId(Long paramLong)
  {
    this.id = paramLong;
  }
  
  public TradeHis getTradeContract()
  {
    return this.tradeContract;
  }
  
  public void setTradeContract(TradeHis paramTradeHis)
  {
    this.tradeContract = paramTradeHis;
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
  
  public Integer getStatus()
  {
    return this.status;
  }
  
  public void setStatus(Integer paramInteger)
  {
    this.status = paramInteger;
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return new StandardModel.PrimaryInfo("id", this.id);
  }
}
