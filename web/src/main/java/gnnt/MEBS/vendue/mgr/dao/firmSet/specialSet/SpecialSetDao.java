package gnnt.MEBS.vendue.mgr.dao.firmSet.specialSet;

import gnnt.MEBS.vendue.mgr.model.firmSet.specialSet.SpecialFee;
import gnnt.MEBS.vendue.mgr.model.firmSet.specialSet.SpecialFeeId;
import gnnt.MEBS.vendue.mgr.model.firmSet.specialSet.SpecialMargin;
import gnnt.MEBS.vendue.mgr.model.firmSet.specialSet.SpecialMarginId;

public abstract interface SpecialSetDao
{
  public abstract Integer addSpecialFee(SpecialFee paramSpecialFee);
  
  public abstract SpecialFee viewSpecialFeeById(SpecialFeeId paramSpecialFeeId);
  
  public abstract Integer updateSpecialFee(SpecialFee paramSpecialFee);
  
  public abstract Integer deleteSpecialFee(String[] paramArrayOfString);
  
  public abstract Integer addSpecialMargin(SpecialMargin paramSpecialMargin);
  
  public abstract Integer deleteSpecialMargin(String[] paramArrayOfString);
  
  public abstract Integer updateSpecialMargin(SpecialMargin paramSpecialMargin);
  
  public abstract SpecialMargin viewSpecialMarginById(SpecialMarginId paramSpecialMarginId);
}
