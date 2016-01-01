package gnnt.MEBS.espot.mgr.model.parametermanage;

import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.mgr.model.translate.ClassDiscription;
import gnnt.MEBS.espot.mgr.model.commoditymanage.Category;
import gnnt.MEBS.espot.mgr.model.firmmanage.MFirm;
import java.math.BigDecimal;

public class DeliveryFee
  extends StandardModel
{
  private static final long serialVersionUID = 1L;
  @ClassDiscription(name="代码", description="")
  private Long id;
  @ClassDiscription(name="关联交易商", description="对应交易商代码")
  private MFirm firm;
  @ClassDiscription(name="关联商品分类", description="对应商品分类号")
  private Category category;
  @ClassDiscription(name="手续费算法", description="")
  private Integer deliveryFeeMode;
  @ClassDiscription(name="手续费率", description="")
  private BigDecimal deliveryFeeRate;
  
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
  
  public Integer getDeliveryFeeMode()
  {
    return this.deliveryFeeMode;
  }
  
  public void setDeliveryFeeMode(Integer paramInteger)
  {
    this.deliveryFeeMode = paramInteger;
  }
  
  public BigDecimal getDeliveryFeeRate()
  {
    return this.deliveryFeeRate;
  }
  
  public void setDeliveryFeeRate(BigDecimal paramBigDecimal)
  {
    this.deliveryFeeRate = paramBigDecimal;
  }
  
  public BigDecimal getDeliveryFeeRate_v()
  {
    BigDecimal localBigDecimal;
    if (this.deliveryFeeMode.intValue() == 1) {
      localBigDecimal = getDeliveryFeeRate();
    } else {
      localBigDecimal = formatDecimals(this.deliveryFeeRate.multiply(new BigDecimal(100)), 3);
    }
    return localBigDecimal;
  }
  
  public void setDeliveryFeeRate_v(BigDecimal paramBigDecimal)
  {
    if (this.deliveryFeeMode.intValue() == 1) {
      this.deliveryFeeRate = paramBigDecimal;
    } else {
      this.deliveryFeeRate = paramBigDecimal.divide(new BigDecimal(100));
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
