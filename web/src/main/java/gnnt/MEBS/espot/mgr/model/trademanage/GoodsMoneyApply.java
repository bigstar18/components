package gnnt.MEBS.espot.mgr.model.trademanage;

import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.mgr.model.translate.ClassDiscription;
import java.util.Date;

public class GoodsMoneyApply
  extends StandardModel
{
  private static final long serialVersionUID = -5296136494903304738L;
  @ClassDiscription(name="申请ID", description="")
  private Long id;
  @ClassDiscription(name="合同", description="对应合同号")
  private TradeContract tradeContract;
  @ClassDiscription(name="申请时间", description="")
  private Date createTime;
  @ClassDiscription(name="处理时间", description="")
  private Date processTime;
  @ClassDiscription(name="状态", description="状态  0：卖方申请 1：卖方撤销 2：管理员撤销3：系统撤销4：已处理")
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
  
  public TradeContract getTradeContract()
  {
    return this.tradeContract;
  }
  
  public void setTradeContract(TradeContract paramTradeContract)
  {
    this.tradeContract = paramTradeContract;
  }
  
  public Date getCreateTime()
  {
    return this.createTime;
  }
  
  public void setCreateTime(Date paramDate)
  {
    this.createTime = paramDate;
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
