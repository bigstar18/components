package gnnt.MEBS.vendue.mgr.service.impl.system.flowcontrol;

import gnnt.MEBS.common.mgr.service.StandardService;
import gnnt.MEBS.vendue.mgr.dao.system.flowControl.SysFlowControlDao;
import gnnt.MEBS.vendue.mgr.model.system.flowcontrol.SysFlowControl;
import gnnt.MEBS.vendue.mgr.service.system.flowcontrol.SysFlowControlService;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service("sysFlowControlService")
@Transactional(propagation=Propagation.REQUIRED, readOnly=false)
public class SysFlowControlServiceImpl
  extends StandardService
  implements SysFlowControlService
{
  @Autowired
  @Qualifier("sysFlowControlDao")
  private SysFlowControlDao sysFlowControlDao;
  
  public Integer viewMaxShowQtyById(Short paramShort)
  {
    return this.sysFlowControlDao.viewMaxShowQtyById(paramShort);
  }
  
  public List<?> listBreed()
  {
    return this.sysFlowControlDao.listBreed();
  }
  
  public String listProperty(Short paramShort, int paramInt)
  {
    return this.sysFlowControlDao.listProperty(paramShort, Integer.valueOf(paramInt));
  }
  
  public Integer updateSysFlow(SysFlowControl paramSysFlowControl, String paramString)
  {
    return this.sysFlowControlDao.updateSysFlow(paramSysFlowControl, paramString);
  }
  
  public String viewPartitionname(Short paramShort)
  {
    String str = "select p.description partitionname from v_syspartition p where p.partitionid = " + paramShort;
    return ((Map)getListBySql(str).get(0)).get("PARTITIONNAME").toString();
  }
}
