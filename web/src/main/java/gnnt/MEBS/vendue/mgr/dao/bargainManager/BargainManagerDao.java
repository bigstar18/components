package gnnt.MEBS.vendue.mgr.dao.bargainManager;

public abstract interface BargainManagerDao
{
  public abstract void updateHisBargain(String paramString1, double paramDouble, String paramString2, long paramLong);
  
  public abstract void unfounds(Object[] paramArrayOfObject);
}
