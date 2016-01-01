package gnnt.MEBS.vendue.mgr.service.firmSet.specialSet;

import gnnt.MEBS.vendue.mgr.model.firmSet.specialSet.SpecialFee;
import gnnt.MEBS.vendue.mgr.model.firmSet.specialSet.SpecialFeeId;
import gnnt.MEBS.vendue.mgr.model.firmSet.specialSet.SpecialMargin;
import gnnt.MEBS.vendue.mgr.model.firmSet.specialSet.SpecialMarginId;
import java.util.List;

public abstract interface SpecialSetService
{
  public abstract List<?> listBreed();
  
  public abstract Integer addSpecialFee(SpecialFee paramSpecialFee);
  
  public abstract SpecialFee viewSpecialFeeById(SpecialFeeId paramSpecialFeeId);
  
  public abstract Integer updateSpecialFee(SpecialFee paramSpecialFee);
  
  public abstract Integer deleteSpecialFee(String[] paramArrayOfString);
  
  public abstract Integer addSpecialFee(SpecialMargin paramSpecialMargin);
  
  public abstract SpecialMargin viewSpecialMarginById(SpecialMarginId paramSpecialMarginId);
  
  public abstract Integer updateSpecialMargin(SpecialMargin paramSpecialMargin);
  
  public abstract Integer deleteSpecialMargin(String[] paramArrayOfString);
}
