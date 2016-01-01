package gnnt.MEBS.vendue.mgr.service.impl.system.flowcontrol;

import gnnt.MEBS.common.mgr.service.StandardService;
import gnnt.MEBS.vendue.mgr.dao.system.flowControl.FlowControlDao;
import gnnt.MEBS.vendue.mgr.model.system.flowcontrol.FlowControl;
import gnnt.MEBS.vendue.mgr.service.system.flowcontrol.FlowControlService;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service("flowControlService")
@Transactional(propagation=Propagation.REQUIRED, readOnly=false)
public class FlowControlServiceImpl
  extends StandardService
  implements FlowControlService
{
  @Autowired
  @Qualifier("flowControlDao")
  private FlowControlDao flowControlDao;
  
  public FlowControlDao getFlowControlDao()
  {
    return this.flowControlDao;
  }
  
  public Integer addFlow(FlowControl paramFlowControl, String paramString)
  {
    return this.flowControlDao.addFlow(paramFlowControl, paramString);
  }
  
  public Integer deleteFlow(String[] paramArrayOfString)
  {
    return this.flowControlDao.deleteFlow(paramArrayOfString);
  }
  
  public List<?> listBreed()
  {
    return this.flowControlDao.listBreed();
  }
  
  public Integer updateFlow(FlowControl paramFlowControl, String paramString, Integer paramInteger, Byte paramByte)
  {
    return this.flowControlDao.updateFlow(paramFlowControl, paramString, paramInteger, paramByte);
  }
  
  public Integer viewCountModeById(Short paramShort)
  {
    return this.flowControlDao.viewCountModeById(paramShort);
  }
  
  public Integer viewMaxShowQtyById(Short paramShort)
  {
    return this.flowControlDao.viewMaxShowQtyById(paramShort);
  }
  
  public String listProperty(Short paramShort, Integer paramInteger)
  {
    List localList = this.flowControlDao.listProperty(paramShort, paramInteger);
    StringBuffer localStringBuffer = new StringBuffer();
    for (int i = 0; i < localList.size(); i++) {
      localStringBuffer.append(((Map)localList.get(i)).get("ATTRIBUTEID") + ",");
    }
    return localStringBuffer.toString();
  }
  
  public String viewPartitionname(Short paramShort)
  {
    String str = "select p.description partitionname from v_syspartition p where p.partitionid = " + paramShort;
    return ((Map)getListBySql(str).get(0)).get("PARTITIONNAME").toString();
  }
}
