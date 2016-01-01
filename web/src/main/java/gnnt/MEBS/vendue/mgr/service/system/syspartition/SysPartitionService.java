package gnnt.MEBS.vendue.mgr.service.system.syspartition;

import java.util.Map;

public abstract interface SysPartitionService
{
  public abstract Map<String, String> getPartitionsMap();
  
  public abstract void deleteList(String[] paramArrayOfString);
}
