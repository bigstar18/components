package gnnt.MEBS.vendue.mgr.service.impl.bargainManager;

import gnnt.MEBS.common.mgr.service.StandardService;
import gnnt.MEBS.vendue.mgr.dao.bargainManager.BargainManagerDao;
import gnnt.MEBS.vendue.mgr.service.bargainManager.BargainManagerService;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

@Service("bargainManagerService")
@Transactional(propagation=Propagation.REQUIRED, readOnly=false, rollbackFor={Exception.class})
public class BargainManagerServiceImpl
  extends StandardService
  implements BargainManagerService
{
  @Resource(name="bargainManagerDao")
  private BargainManagerDao bargainManager;
  
  public BargainManagerDao getBargainManager()
  {
    return this.bargainManager;
  }
  
  public void setBargainManager(BargainManagerDao paramBargainManagerDao)
  {
    this.bargainManager = paramBargainManagerDao;
  }
  
  public int unfounds(String paramString1, double paramDouble, String paramString2, long paramLong, Object[] paramArrayOfObject)
  {
    int i = 0;
    try
    {
      this.bargainManager.unfounds(paramArrayOfObject);
      this.bargainManager.updateHisBargain(paramString1, paramDouble, paramString2, paramLong);
      i = 1;
    }
    catch (Exception localException)
    {
      TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
      localException.printStackTrace();
      i = -1;
    }
    return i;
  }
}
