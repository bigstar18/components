package gnnt.MEBS.espot.mgr.model.parametermanage;

import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.mgr.model.translate.ClassDiscription;
import gnnt.MEBS.espot.mgr.model.commoditymanage.Category;
import gnnt.MEBS.espot.mgr.model.firmmanage.MFirm;
import java.math.BigDecimal;

public class TradeFee
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
  private Integer tradeFeeMode;
  @ClassDiscription(name="手续费率", description="")
  private BigDecimal tradeFeeRate;
  
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
  
  public Integer getTradeFeeMode()
  {
    return this.tradeFeeMode;
  }
  
  public void setTradeFeeMode(Integer paramInteger)
  {
    this.tradeFeeMode = paramInteger;
  }
  
  public BigDecimal getTradeFeeRate()
  {
    return this.tradeFeeRate;
  }
  
  public void setTradeFeeRate(BigDecimal paramBigDecimal)
  {
    this.tradeFeeRate = paramBigDecimal;
  }
  
  public BigDecimal getTradeFeeRate_v()
  {
    BigDecimal localBigDecimal;
    if (this.tradeFeeMode.intValue() == 1) {
      localBigDecimal = formatDecimals(getTradeFeeRate(), 2);
    } else {
      localBigDecimal = formatDecimals(this.tradeFeeRate.multiply(new BigDecimal(100)), 3);
    }
    return localBigDecimal;
  }
  
  public void setTradeFeeRate_v(BigDecimal paramBigDecimal)
  {
    if (this.tradeFeeMode.intValue() == 1) {
      this.tradeFeeRate = formatDecimals(paramBigDecimal, 2);
    } else {
      this.tradeFeeRate = paramBigDecimal.divide(new BigDecimal(100));
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
