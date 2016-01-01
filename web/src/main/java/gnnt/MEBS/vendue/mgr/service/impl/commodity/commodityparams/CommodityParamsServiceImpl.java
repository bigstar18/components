package gnnt.MEBS.vendue.mgr.service.impl.commodity.commodityparams;

import gnnt.MEBS.common.mgr.service.StandardService;
import gnnt.MEBS.vendue.mgr.service.commodity.commdityparams.CommodityParamsService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service("commodityParamsService")
@Transactional(propagation=Propagation.REQUIRED, readOnly=false)
public class CommodityParamsServiceImpl
  extends StandardService
  implements CommodityParamsService
{
  public void deleteList(String paramString, String[] paramArrayOfString)
  {
    for (int i = 0; i < paramArrayOfString.length; i++) {
      executeUpdateBySql("delete from v_commodityparams t where t.tradepartition = '" + paramString + "' and t.breedid = '" + paramArrayOfString[i] + "'");
    }
  }
}
