package gnnt.MEBS.espot.mgr.service.fundService;

import gnnt.MEBS.common.mgr.service.StandardService;
import gnnt.MEBS.espot.mgr.dao.FundDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service("e_fundService")
@Transactional(propagation=Propagation.REQUIRED, readOnly=false)
public class FundService
  extends StandardService
{
  @Autowired
  @Qualifier("e_fundDao")
  private FundDao fundDao;
  
  public FundDao getFundDao()
  {
    return this.fundDao;
  }
  
  public double inmoneymodel(String paramString, double paramDouble)
    throws Exception
  {
    return this.fundDao.inmoneymodel(paramString, paramDouble);
  }
}
