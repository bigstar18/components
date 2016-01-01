package gnnt.MEBS.vendue.mgr.service.impl.firmSet.specialSet;

import gnnt.MEBS.common.mgr.service.StandardService;
import gnnt.MEBS.common.mgr.statictools.ApplicationContextInit;
import gnnt.MEBS.vendue.mgr.dao.firmSet.specialSet.SpecialSetDao;
import gnnt.MEBS.vendue.mgr.model.firmSet.specialSet.SpecialFee;
import gnnt.MEBS.vendue.mgr.model.firmSet.specialSet.SpecialFeeId;
import gnnt.MEBS.vendue.mgr.model.firmSet.specialSet.SpecialMargin;
import gnnt.MEBS.vendue.mgr.model.firmSet.specialSet.SpecialMarginId;
import gnnt.MEBS.vendue.mgr.service.firmSet.specialSet.SpecialSetService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service("specialSetService")
@Transactional(propagation=Propagation.REQUIRED, readOnly=false)
public class SpecialSetServiceImpl
  extends StandardService
  implements SpecialSetService
{
  @Autowired
  @Qualifier("specialSetDao")
  private SpecialSetDao specialSetDao;
  
  public List<?> listBreed()
  {
    String str1 = ApplicationContextInit.getConfig("SelfModuleID");
    String str2 = "select mb.breedid,mb.breedname from m_breed mb where mb.belongmodule like '%" + str1 + "%' order by mb.breedid";
    return getListBySql(str2);
  }
  
  public Integer addSpecialFee(SpecialFee paramSpecialFee)
  {
    return this.specialSetDao.addSpecialFee(paramSpecialFee);
  }
  
  public SpecialFee viewSpecialFeeById(SpecialFeeId paramSpecialFeeId)
  {
    return this.specialSetDao.viewSpecialFeeById(paramSpecialFeeId);
  }
  
  public Integer updateSpecialFee(SpecialFee paramSpecialFee)
  {
    return this.specialSetDao.updateSpecialFee(paramSpecialFee);
  }
  
  public Integer deleteSpecialFee(String[] paramArrayOfString)
  {
    return this.specialSetDao.deleteSpecialFee(paramArrayOfString);
  }
  
  public Integer addSpecialFee(SpecialMargin paramSpecialMargin)
  {
    return this.specialSetDao.addSpecialMargin(paramSpecialMargin);
  }
  
  public Integer deleteSpecialMargin(String[] paramArrayOfString)
  {
    return this.specialSetDao.deleteSpecialMargin(paramArrayOfString);
  }
  
  public Integer updateSpecialMargin(SpecialMargin paramSpecialMargin)
  {
    return this.specialSetDao.updateSpecialMargin(paramSpecialMargin);
  }
  
  public SpecialMargin viewSpecialMarginById(SpecialMarginId paramSpecialMarginId)
  {
    return this.specialSetDao.viewSpecialMarginById(paramSpecialMarginId);
  }
}
