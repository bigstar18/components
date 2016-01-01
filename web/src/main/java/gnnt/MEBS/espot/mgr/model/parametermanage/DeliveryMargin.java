package gnnt.MEBS.espot.mgr.model.parametermanage;

import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.mgr.model.translate.ClassDiscription;
import gnnt.MEBS.espot.mgr.model.commoditymanage.Category;
import gnnt.MEBS.espot.mgr.model.firmmanage.MFirm;
import java.math.BigDecimal;

public class DeliveryMargin
  extends StandardModel
{
  private static final long serialVersionUID = 1L;
  @ClassDiscription(name="代码", description="")
  private Long id;
  @ClassDiscription(name="关联交易商", description="对应交易商代码")
  private MFirm firm;
  @ClassDiscription(name="关联商品分类", description="对应商品分类代码")
  private Category category;
  @ClassDiscription(name="手续费算法", description="")
  private Integer tradeMarginMode;
  @ClassDiscription(name="手续费率", description="")
  private BigDecimal tradeMarginRate;
  
  public Long getId()
  {
    return this.id;
  }
  
  public void setId(Long paramLong)
  {
    this.id = paramLong;
  }
  
  public MFirm getFirm()
  {
    return this.firm;
  }
  
  public void setFirm(MFirm paramMFirm)
  {
    this.firm = paramMFirm;
  }
  
  public Category getCategory()
  {
    return this.category;
  }
  
  public void setCategory(Category paramCategory)
  {
    this.category = paramCategory;
  }
  
  public Integer getTradeMarginMode()
  {
    return this.tradeMarginMode;
  }
  
  public void setTradeMarginMode(Integer paramInteger)
  {
    this.tradeMarginMode = paramInteger;
  }
  
  public BigDecimal getTradeMarginRate()
  {
    return this.tradeMarginRate;
  }
  
  public void setTradeMarginRate(BigDecimal paramBigDecimal)
  {
    this.tradeMarginRate = paramBigDecimal;
  }
  
  public BigDecimal getTradeMarginRate_v()
  {
    BigDecimal localBigDecimal;
    if (this.tradeMarginMode.intValue() == 1) {
      localBigDecimal = getTradeMarginRate();
    } else {
      localBigDecimal = formatDecimals(this.tradeMarginRate.multiply(new BigDecimal(100)), 3);
    }
    return localBigDecimal;
  }
  
  public void setTradeMarginRate_v(BigDecimal paramBigDecimal)
  {
    if (this.tradeMarginMode.intValue() == 1) {
      this.tradeMarginRate = paramBigDecimal;
    } else {
      this.tradeMarginRate = paramBigDecimal.divide(new BigDecimal(100));
    }
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return new StandardModel.PrimaryInfo("id", this.id);
  }
  
  private BigDecimal formatDecimals(BigDecimal paramBigDecimal, int paramInt)
  {
    BigDecimal localBigDecimal = null;
    if (paramBigDecimal != null) {
      localBigDecimal = paramBigDecimal.setScale(paramInt, 4);
    }
    return localBigDecimal;
  }
}
