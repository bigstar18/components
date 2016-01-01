package gnnt.MEBS.espot.front.dao.jdbc;

import java.util.Map;

public abstract interface UserDAO
  extends DAO
{
  public abstract Map<String, Integer> getTradeSize(String paramString);
}
