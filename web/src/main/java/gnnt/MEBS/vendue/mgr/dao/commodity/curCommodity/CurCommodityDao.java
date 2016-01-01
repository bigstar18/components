package gnnt.MEBS.vendue.mgr.dao.commodity.curCommodity;

import java.util.List;

public abstract interface CurCommodityDao
{
  public abstract Integer addSection(String paramString, Byte paramByte, String[] paramArrayOfString);
  
  public abstract List<?> listSection(Byte paramByte);
  
  public abstract Integer deleteCurCommodity(String[] paramArrayOfString);
  
  public abstract Integer insertSection(String[] paramArrayOfString, String paramString, Byte paramByte);
}
