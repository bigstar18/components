package gnnt.MEBS.vendue.mgr.service.system.flowcontrol;

import gnnt.MEBS.vendue.mgr.model.system.flowcontrol.FlowControl;
import java.util.List;

public abstract interface FlowControlService
{
  public abstract List<?> listBreed();
  
  public abstract Integer viewMaxShowQtyById(Short paramShort);
  
  public abstract Integer viewCountModeById(Short paramShort);
  
  public abstract Integer addFlow(FlowControl paramFlowControl, String paramString);
  
  public abstract Integer updateFlow(FlowControl paramFlowControl, String paramString, Integer paramInteger, Byte paramByte);
  
  public abstract Integer deleteFlow(String[] paramArrayOfString);
  
  public abstract String listProperty(Short paramShort, Integer paramInteger);
  
  public abstract String viewPartitionname(Short paramShort);
}
