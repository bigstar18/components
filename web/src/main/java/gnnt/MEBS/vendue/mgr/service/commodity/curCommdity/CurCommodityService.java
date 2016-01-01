package gnnt.MEBS.vendue.mgr.service.commodity.curCommdity;

import java.rmi.RemoteException;
import java.util.List;

public abstract interface CurCommodityService
{
  public abstract Integer addSectionToCurCommodity(String paramString, Byte paramByte, String[] paramArrayOfString)
    throws Exception;
  
  public abstract List<?> listSection(Byte paramByte);
  
  public abstract Integer deleteCurCommodity(Byte paramByte, String[] paramArrayOfString)
    throws RemoteException;
  
  public abstract StringBuffer validateCodes(String[] paramArrayOfString, String paramString);
  
  public abstract String returnInfoAboutOldSection(String[] paramArrayOfString);
  
  public abstract String returnInfoAboutDisabledCodes(String[] paramArrayOfString);
  
  public abstract String[] getEnableForDeleteCodes(String[] paramArrayOfString);
  
  public abstract String[] getDisableForDeleteCodes(String[] paramArrayOfString);
  
  public abstract String getInfoAboutDelete(String[] paramArrayOfString);
  
  public abstract String[] getenableInsertSectionCodes(String[] paramArrayOfString);
  
  public abstract String[] getDisableInsertSectionCodes(String[] paramArrayOfString);
  
  public abstract Integer insertSection(String[] paramArrayOfString, String paramString, Byte paramByte);
  
  public abstract String getinfoAboutInsertSection(String[] paramArrayOfString);
}
