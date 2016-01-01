package gnnt.MEBS.vendue.mgr.service.system.flowcontrol;

import gnnt.MEBS.vendue.mgr.model.system.flowcontrol.SysFlowControl;
import java.util.List;

public abstract interface SysFlowControlService
{
  public abstract Integer viewMaxShowQtyById(Short paramShort);
  
  public abstract String listProperty(Short paramShort, int paramInt);
  
  public abstract List<?> listBreed();
  
  public abstract Integer updateSysFlow(SysFlowControl paramSysFlowControl, String paramString);
  
  public abstract String viewPartitionname(Short paramShort);
}
