package gnnt.MEBS.vendue.mgr.service.commodity.curCommdity;

import gnnt.MEBS.common.mgr.service.StandardService;
import gnnt.MEBS.priceranking.server.rmi.ServerRMI;
import gnnt.MEBS.vendue.mgr.dao.commodity.curCommodity.CurCommodityDao;
import gnnt.MEBS.vendue.mgr.model.commodity.curCommodities.CurCommodity;
import java.rmi.RemoteException;
import java.util.List;
import java.util.Map;
import org.apache.commons.logging.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service("curCommodityService")
@Transactional(propagation=Propagation.REQUIRED, readOnly=false, rollbackFor={Exception.class})
public class CurCommodityServiceImpl
  extends StandardService
  implements CurCommodityService
{
  @Autowired
  @Qualifier("curCommodityDao")
  private CurCommodityDao curCommodityDao;
  @Autowired
  @Qualifier("serverRMIService")
  private ServerRMI serverRMIService;
  
  public CurCommodityDao getCurCommodityDao()
  {
    return this.curCommodityDao;
  }
  
  public Integer addSectionToCurCommodity(String paramString, Byte paramByte, String[] paramArrayOfString)
  {
    try
    {
      return this.curCommodityDao.addSection(paramString, paramByte, paramArrayOfString);
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
    }
    return Integer.valueOf(-1);
  }
  
  public List<?> listSection(Byte paramByte)
  {
    return this.curCommodityDao.listSection(paramByte);
  }
  
  public Integer deleteCurCommodity(Byte paramByte, String[] paramArrayOfString)
    throws RemoteException
  {
    Integer localInteger = this.curCommodityDao.deleteCurCommodity(paramArrayOfString);
    for (int i = 0; i < paramArrayOfString.length; i++) {
      this.serverRMIService.removeCommodity((short)paramByte.byteValue(), paramArrayOfString[i]);
    }
    return localInteger;
  }
  
  public StringBuffer validateCodes(String[] paramArrayOfString, String paramString)
  {
    StringBuffer localStringBuffer1 = new StringBuffer();
    StringBuffer localStringBuffer2 = new StringBuffer();
    if (paramArrayOfString.length != 0) {
      for (int i = 0; i < paramArrayOfString.length; i++) {
        if (validateAddSection(paramString, paramArrayOfString[i])) {
          localStringBuffer1.append(paramArrayOfString[i] + ",");
        } else {
          localStringBuffer2.append(paramArrayOfString[i] + ",");
        }
      }
    }
    localStringBuffer1.append("end");
    localStringBuffer1.append(localStringBuffer2);
    return localStringBuffer1;
  }
  
  private boolean validateAddSection(String paramString1, String paramString2)
  {
    try
    {
      CurCommodity localCurCommodity = new CurCommodity();
      localCurCommodity.setCode(paramString2);
      localCurCommodity = (CurCommodity)get(localCurCommodity);
      if (localCurCommodity.getBargainType().intValue() != 0) {
        return false;
      }
      String str = "select Section from v_sysCurStatus where Status in(2,4) and tradePartition = " + localCurCommodity.getTradePartition();
      if (getListBySql(str).size() == 0) {
        return true;
      }
      Integer localInteger = Integer.valueOf(Integer.parseInt(((Map)getListBySql(str).get(0)).get("SECTION").toString()));
      if (localCurCommodity.getSection() == null) {
        return true;
      }
      if (localInteger.compareTo(localCurCommodity.getSection()) != 0) {
        return true;
      }
    }
    catch (Exception localException)
    {
      this.logger.debug(localException);
      return false;
    }
    return false;
  }
  
  public String returnInfoAboutOldSection(String[] paramArrayOfString)
  {
    this.logger.debug("enter returnInfoAboutOldSection");
    StringBuffer localStringBuffer = new StringBuffer();
    if (paramArrayOfString.length != 0)
    {
      for (int i = 0; i < paramArrayOfString.length; i++)
      {
        CurCommodity localCurCommodity = new CurCommodity();
        localCurCommodity.setCode(paramArrayOfString[i]);
        localCurCommodity = (CurCommodity)get(localCurCommodity);
        localStringBuffer.append("标的号：" + paramArrayOfString[i] + "指定交易节之前所属交易节编号为:" + localCurCommodity.getSection() + "。");
      }
      return localStringBuffer.toString();
    }
    return "";
  }
  
  public String returnInfoAboutDisabledCodes(String[] paramArrayOfString)
  {
    if (paramArrayOfString.length != 0)
    {
      StringBuffer localStringBuffer = new StringBuffer();
      localStringBuffer.append("标的号为：");
      for (int i = 0; i < paramArrayOfString.length; i++) {
        if (i == paramArrayOfString.length - 1) {
          localStringBuffer.append(paramArrayOfString[i]);
        } else {
          localStringBuffer.append(paramArrayOfString[i] + ",");
        }
      }
      localStringBuffer.append(" 的商品 无法指定交易节");
      return localStringBuffer.toString();
    }
    return "";
  }
  
  public String[] getEnableForDeleteCodes(String[] paramArrayOfString)
  {
    StringBuffer localStringBuffer = new StringBuffer();
    if (paramArrayOfString.length != 0) {
      try
      {
        for (int i = 0; i < paramArrayOfString.length; i++)
        {
          CurCommodity localCurCommodity = new CurCommodity();
          localCurCommodity.setCode(paramArrayOfString[i]);
          localCurCommodity = (CurCommodity)get(localCurCommodity);
          if (localCurCommodity.getBargainType().intValue() == 0) {
            localStringBuffer.append(paramArrayOfString[i] + ",");
          }
        }
      }
      catch (Exception localException)
      {
        localException.printStackTrace();
        return null;
      }
    }
    if (!"".equals(localStringBuffer.toString())) {
      return localStringBuffer.toString().split(",");
    }
    return null;
  }
  
  public String[] getDisableForDeleteCodes(String[] paramArrayOfString)
  {
    StringBuffer localStringBuffer = new StringBuffer();
    if (paramArrayOfString.length != 0) {
      try
      {
        for (int i = 0; i < paramArrayOfString.length; i++)
        {
          CurCommodity localCurCommodity = new CurCommodity();
          localCurCommodity.setCode(paramArrayOfString[i]);
          localCurCommodity = (CurCommodity)get(localCurCommodity);
          if (localCurCommodity.getBargainType().intValue() != 0) {
            localStringBuffer.append(paramArrayOfString[i] + ",");
          }
        }
      }
      catch (Exception localException)
      {
        localException.printStackTrace();
        return null;
      }
    }
    if (!"".equals(localStringBuffer.toString())) {
      return localStringBuffer.toString().split(",");
    }
    return null;
  }
  
  public String getInfoAboutDelete(String[] paramArrayOfString)
  {
    if (paramArrayOfString != null)
    {
      StringBuffer localStringBuffer = new StringBuffer();
      localStringBuffer.append("标的号为：");
      for (int i = 0; i < paramArrayOfString.length; i++) {
        if (i == paramArrayOfString.length - 1) {
          localStringBuffer.append(paramArrayOfString[i]);
        } else {
          localStringBuffer.append(paramArrayOfString[i] + ",");
        }
      }
      localStringBuffer.append(" 的商品 无法删除。（只有未成交状态的商品可以进行删除操作！）");
      return localStringBuffer.toString();
    }
    return "";
  }
  
  public String[] getenableInsertSectionCodes(String[] paramArrayOfString)
  {
    if (paramArrayOfString.length != 0)
    {
      StringBuffer localStringBuffer = new StringBuffer();
      for (int i = 0; i < paramArrayOfString.length; i++)
      {
        CurCommodity localCurCommodity = new CurCommodity();
        localCurCommodity.setCode(paramArrayOfString[i]);
        localCurCommodity = (CurCommodity)get(localCurCommodity);
        if ((localCurCommodity.getSection() == null) && (localCurCommodity.getBargainType().intValue() == 0)) {
          localStringBuffer.append(paramArrayOfString[i] + ",");
        }
      }
      if (localStringBuffer.length() != 0) {
        return localStringBuffer.toString().split(",");
      }
      return null;
    }
    return null;
  }
  
  public String[] getDisableInsertSectionCodes(String[] paramArrayOfString)
  {
    if (paramArrayOfString.length != 0)
    {
      StringBuffer localStringBuffer = new StringBuffer();
      for (int i = 0; i < paramArrayOfString.length; i++)
      {
        CurCommodity localCurCommodity = new CurCommodity();
        localCurCommodity.setCode(paramArrayOfString[i]);
        localCurCommodity = (CurCommodity)get(localCurCommodity);
        if ((localCurCommodity.getSection() != null) || (localCurCommodity.getBargainType().intValue() != 0)) {
          localStringBuffer.append(paramArrayOfString[i] + ",");
        }
      }
      this.logger.debug("---------------------------->>>>>" + localStringBuffer);
      if (localStringBuffer.length() != 0) {
        return localStringBuffer.toString().split(",");
      }
      return null;
    }
    return null;
  }
  
  public String getinfoAboutInsertSection(String[] paramArrayOfString)
  {
    if (paramArrayOfString != null)
    {
      StringBuffer localStringBuffer = new StringBuffer();
      localStringBuffer.append("标的号为：");
      for (int i = 0; i < paramArrayOfString.length; i++) {
        if (i == paramArrayOfString.length - 1) {
          localStringBuffer.append(paramArrayOfString[i]);
        } else {
          localStringBuffer.append(paramArrayOfString[i] + ",");
        }
      }
      localStringBuffer.append("的商品无法插入交易节 （商品必须是未成交状态且没有指定交易节才可以进行插入交易节操作！）");
      return localStringBuffer.toString();
    }
    return "";
  }
  
  public Integer insertSection(String[] paramArrayOfString, String paramString, Byte paramByte)
  {
    return this.curCommodityDao.insertSection(paramArrayOfString, paramString, paramByte);
  }
  
  public void deleteCurCommodityByRMI(Byte paramByte, String[] paramArrayOfString)
    throws RemoteException
  {
    for (int i = 0; i < paramArrayOfString.length; i++) {
      this.serverRMIService.removeCommodity((short)paramByte.byteValue(), paramArrayOfString[i]);
    }
  }
}
