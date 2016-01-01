package gnnt.MEBS.vendue.mgr.service.impl.system.syspartition;

import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.service.StandardService;
import gnnt.MEBS.vendue.mgr.dao.system.syspartition.SysPartitionDao;
import gnnt.MEBS.vendue.mgr.model.commodity.commodities.VCommodity;
import gnnt.MEBS.vendue.mgr.model.system.sysPartition.VSyspartition;
import gnnt.MEBS.vendue.mgr.service.system.syspartition.SysPartitionService;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service("sysPartitionService")
@Transactional(propagation=Propagation.REQUIRED, readOnly=false)
public class SysPartitionServiceImpl
  extends StandardService
  implements SysPartitionService
{
  @Autowired
  @Qualifier("sysPartitionDao")
  private SysPartitionDao sysPartitionDao;
  
  public Map<String, String> getPartitionsMap()
  {
    HashMap localHashMap = new HashMap();
    List localList = getListBySql("select * from v_syspartition", new VSyspartition());
    Iterator localIterator = localList.iterator();
    while (localIterator.hasNext())
    {
      StandardModel localStandardModel = (StandardModel)localIterator.next();
      VSyspartition localVSyspartition = (VSyspartition)localStandardModel;
      localHashMap.put(localVSyspartition.getPartitionid().toString(), localVSyspartition.getDescription());
    }
    return localHashMap;
  }
  
  public void deleteList(String[] paramArrayOfString)
  {
    for (String str : paramArrayOfString)
    {
      VCommodity localVCommodity = new VCommodity();
      localVCommodity.setCode(Integer.valueOf(Integer.parseInt(str)));
      localVCommodity = (VCommodity)get(localVCommodity);
      delete(localVCommodity);
    }
  }
}
