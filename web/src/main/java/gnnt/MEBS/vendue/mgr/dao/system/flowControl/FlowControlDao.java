package gnnt.MEBS.vendue.mgr.dao.system.flowControl;

import gnnt.MEBS.vendue.mgr.model.system.flowcontrol.FlowControl;
import java.util.List;
import java.util.Map;

public abstract interface FlowControlDao
{
  public abstract List<?> listBreed();
  
  public abstract Integer viewMaxShowQtyById(Short paramShort);
  
  public abstract Integer addFlow(FlowControl paramFlowControl, String paramString);
  
  public abstract Integer viewCountModeById(Short paramShort);
  
  public abstract Integer deleteFlow(String[] paramArrayOfString);
  
  public abstract Integer updateFlow(FlowControl paramFlowControl, String paramString, Integer paramInteger, Byte paramByte);
  
  public abstract List<Map<Object, Object>> listProperty(Short paramShort, Integer paramInteger);
}
