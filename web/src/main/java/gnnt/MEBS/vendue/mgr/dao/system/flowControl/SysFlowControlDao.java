package gnnt.MEBS.vendue.mgr.dao.system.flowControl;

import gnnt.MEBS.vendue.mgr.model.system.flowcontrol.SysFlowControl;
import java.util.List;

public abstract interface SysFlowControlDao
{
  public abstract List<?> listBreed();
  
  public abstract Integer viewMaxShowQtyById(Short paramShort);
  
  public abstract Integer updateSysFlow(SysFlowControl paramSysFlowControl, String paramString);
  
  public abstract String listProperty(Short paramShort, Integer paramInteger);
}
