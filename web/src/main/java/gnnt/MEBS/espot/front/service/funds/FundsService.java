package gnnt.MEBS.espot.front.service.funds;

import gnnt.MEBS.common.front.service.StandardService;
import gnnt.MEBS.espot.front.dao.funds.FundsDao;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service("fundsService")
@Transactional(propagation=Propagation.REQUIRED, readOnly=false)
public class FundsService
  extends StandardService
{
  @Autowired
  @Qualifier("fundsDao")
  private FundsDao fundsDao;
  
  public FundsDao getFundsDao()
  {
    return this.fundsDao;
  }
  
  public Map<String, Double> getFirmScription(String paramString)
  {
    return this.fundsDao.getFirmScription(paramString);
  }
  
  public double inmoneymodel(String paramString, double paramDouble)
    throws Exception
  {
    return this.fundsDao.inmoneymodel(paramString, paramDouble);
  }
}
