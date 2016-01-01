package gnnt.MEBS.vendue.mgr.dao.impl.system.flowcontrol;

import gnnt.MEBS.common.mgr.dao.StandardDao;
import gnnt.MEBS.common.mgr.statictools.ApplicationContextInit;
import gnnt.MEBS.vendue.mgr.dao.system.flowControl.SysFlowControlDao;
import gnnt.MEBS.vendue.mgr.model.system.flowcontrol.SysFlowControl;
import java.util.List;
import java.util.Map;
import org.apache.commons.logging.Log;
import org.springframework.stereotype.Repository;

@Repository("sysFlowControlDao")
public class SysFlowControlDaoImpl
  extends StandardDao
  implements SysFlowControlDao
{
  public List<?> listBreed()
  {
    String str1 = ApplicationContextInit.getConfig("SelfModuleID");
    String str2 = "select mb.breedid,mb.breedname from m_breed mb where mb.status = 1 and mb.belongmodule like '%" + str1 + "%' order by mb.breedid";
    return queryBySql(str2);
  }
  
  public Integer viewMaxShowQtyById(Short paramShort)
  {
    String str = "select v.maxshowqty from v_syspartition v where v.partitionid = '" + paramShort + "'";
    return Integer.valueOf(Integer.parseInt(((Map)queryBySql(str).get(0)).get("MAXSHOWQTY").toString()));
  }
  
  public Integer updateSysFlow(SysFlowControl paramSysFlowControl, String paramString)
  {
    this.logger.debug("enter updateSysFlow's DaoImpl");
    try
    {
      deletePropertyList(paramSysFlowControl.getTradePartition());
      addPropertyList(paramString, paramSysFlowControl.getTradePartition(), paramSysFlowControl.getBreedId());
      update(paramSysFlowControl);
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
      return Integer.valueOf(-1);
    }
    return Integer.valueOf(1);
  }
  
  private void addPropertyList(String paramString, Short paramShort, Integer paramInteger)
  {
    if ((paramString != null) && (!"".equals(paramString))) {
      try
      {
        String[] arrayOfString = paramString.split(",");
        String str1 = "";
        String str2 = "";
        String str3 = "";
        for (int i = 0; i < arrayOfString.length; i++)
        {
          str3 = arrayOfString[i].split(":")[0];
          str2 = arrayOfString[i].split(":")[1];
          str1 = "insert into V_SectionAttribute(Id,Partitionid,Breedid,Attributeid,Attributename,Num,Updatetime,UnitId) values(Seq_v_Sectionattribute.Nextval," + paramShort + "," + paramInteger + "," + str3 + ",'" + str2.trim() + "'," + paramInteger + ",trunc(sysdate),-1)";
          executeUpdateBySql(str1);
        }
      }
      catch (Exception localException)
      {
        localException.printStackTrace();
      }
    }
  }
  
  private void deletePropertyList(Short paramShort)
  {
    try
    {
      String str1 = "select count(*) sum from v_sectionattribute where Unitid = -1  and Partitionid = " + paramShort;
      this.logger.debug(queryBySql(str1));
      if (Integer.parseInt(((Map)queryBySql(str1).get(0)).get("SUM").toString()) != 0)
      {
        String str2 = "delete from v_sectionattribute v where Unitid = -1 and Partitionid = " + paramShort;
        executeUpdateBySql(str2);
      }
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
    }
  }
  
  public String listProperty(Short paramShort, Integer paramInteger)
  {
    String str = "select v.attributeid from v_sectionattribute v where v.partitionid  =" + paramShort + " and v.unitid = " + paramInteger;
    List localList = queryBySql(str);
    StringBuffer localStringBuffer = new StringBuffer();
    for (int i = 0; i < localList.size(); i++) {
      localStringBuffer.append(((Map)localList.get(i)).get("ATTRIBUTEID") + ",");
    }
    return localStringBuffer.toString();
  }
}
