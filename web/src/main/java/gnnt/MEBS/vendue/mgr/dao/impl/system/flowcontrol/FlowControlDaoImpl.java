package gnnt.MEBS.vendue.mgr.dao.impl.system.flowcontrol;

import gnnt.MEBS.common.mgr.dao.StandardDao;
import gnnt.MEBS.common.mgr.statictools.ApplicationContextInit;
import gnnt.MEBS.vendue.mgr.dao.system.flowControl.FlowControlDao;
import gnnt.MEBS.vendue.mgr.model.system.flowcontrol.FlowControl;
import gnnt.MEBS.vendue.mgr.model.system.flowcontrol.FlowcontrolId;
import gnnt.MEBS.vendue.mgr.model.system.sysPartition.VSyspartition;
import java.util.List;
import java.util.Map;
import org.apache.commons.logging.Log;
import org.springframework.stereotype.Repository;

@Repository("flowControlDao")
public class FlowControlDaoImpl
  extends StandardDao
  implements FlowControlDao
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
  
  public Integer addFlow(FlowControl paramFlowControl, String paramString)
  {
    try
    {
      this.logger.debug("enter addFlow daoimpl");
      if (paramFlowControl.getBreedid() == null) {
        paramFlowControl.setBreedid(new Long(-1L));
      }
      add(paramFlowControl);
      addPropertyList(paramString, paramFlowControl.getId().getTradepartition(), paramFlowControl.getBreedid(), paramFlowControl.getId().getUnitid());
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
      return Integer.valueOf(0);
    }
    return Integer.valueOf(1);
  }
  
  public Integer viewCountModeById(Short paramShort)
  {
    VSyspartition localVSyspartition = new VSyspartition();
    localVSyspartition.setPartitionid(paramShort);
    localVSyspartition = (VSyspartition)get(localVSyspartition);
    if ((localVSyspartition.getCountmode().byteValue() == 0) && (localVSyspartition.getIssplittarget().byteValue() == 1)) {
      return Integer.valueOf(1);
    }
    return Integer.valueOf(0);
  }
  
  public void addPropertyList(String paramString, Short paramShort, Long paramLong, Integer paramInteger)
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
          str3 = arrayOfString[i].split(":")[0].trim();
          str2 = arrayOfString[i].split(":")[1].trim();
          str1 = "insert into V_SectionAttribute(Id,Partitionid,Breedid,Attributeid,Attributename,Num,Updatetime,unitId) values(Seq_v_Sectionattribute.Nextval," + paramShort + "," + paramLong + "," + str3 + ",'" + str2 + "'," + (i + 1) + ",trunc(sysdate)," + paramInteger + ")";
          executeUpdateBySql(str1);
        }
      }
      catch (Exception localException)
      {
        localException.printStackTrace();
      }
    }
  }
  
  public Integer deleteFlow(String[] paramArrayOfString)
  {
    this.logger.debug("enter deleteFlow's DaoImpl");
    try
    {
      if (paramArrayOfString.length != 0)
      {
        FlowcontrolId[] arrayOfFlowcontrolId = new FlowcontrolId[paramArrayOfString.length];
        for (int i = 0; i < paramArrayOfString.length; i++)
        {
          String[] arrayOfString = paramArrayOfString[i].split(",");
          FlowcontrolId localFlowcontrolId = new FlowcontrolId(new Short(arrayOfString[0]), new Byte(arrayOfString[1]), new Integer(arrayOfString[2]));
          arrayOfFlowcontrolId[i] = localFlowcontrolId;
          deletePropertyList(localFlowcontrolId.getTradepartition(), localFlowcontrolId.getUnitid());
        }
        deleteBYBulk(new FlowControl(), arrayOfFlowcontrolId);
      }
      else
      {
        return Integer.valueOf(0);
      }
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
      return Integer.valueOf(-1);
    }
    return Integer.valueOf(1);
  }
  
  public void deletePropertyList(Short paramShort, Integer paramInteger)
  {
    try
    {
      String str1 = "select count(*) sum from v_sectionattribute where Unitid = " + paramInteger + " and Partitionid = " + paramShort;
      this.logger.debug(queryBySql(str1));
      if (Integer.parseInt(((Map)queryBySql(str1).get(0)).get("SUM").toString()) != 0)
      {
        String str2 = "delete from v_sectionattribute v where Unitid = " + paramInteger + " and Partitionid = " + paramShort;
        executeUpdateBySql(str2);
      }
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
    }
  }
  
  public Integer updateFlow(FlowControl paramFlowControl, String paramString, Integer paramInteger, Byte paramByte)
  {
    this.logger.debug("enter updateFlow's DaoImpl");
    try
    {
      deletePropertyList(paramFlowControl.getId().getTradepartition(), paramFlowControl.getId().getUnitid());
      addPropertyList(paramString, paramFlowControl.getId().getTradepartition(), paramFlowControl.getBreedid(), paramFlowControl.getId().getUnitid());
      String str = "update v_flowcontrol set unitid = " + paramFlowControl.getId().getUnitid() + ",breedid = " + paramFlowControl.getBreedid() + ",unittype=" + paramFlowControl.getId().getUnittype() + ",startmode=" + paramFlowControl.getStartmode() + ",durativetime= " + paramFlowControl.getDurativetime() + ",quartertime= " + paramFlowControl.getQuartertime() + ",ismargincount=" + paramFlowControl.getIsmargincount();
      if ((paramFlowControl.getStarttime() != null) && (!"".equals(paramFlowControl.getStarttime()))) {
        str = str + ",starttime = '" + paramFlowControl.getStarttime() + "'";
      } else {
        str = str + ",starttime = null";
      }
      if ((paramFlowControl.getCountdownstart() != null) && (!"".equals(paramFlowControl.getCountdownstart()))) {
        str = str + ",countdownstart = '" + paramFlowControl.getCountdownstart() + "'";
      } else {
        str = str + ",countdownstart = null";
      }
      if ((paramFlowControl.getCountdowntime() != null) && (!"".equals(paramFlowControl.getCountdowntime()))) {
        str = str + ",countdowntime = " + paramFlowControl.getCountdowntime();
      } else {
        str = str + ",countdowntime = null";
      }
      if ((paramFlowControl.getForcedendtime() != null) && (!"".equals(paramFlowControl.getForcedendtime()))) {
        str = str + ",forcedendtime = '" + paramFlowControl.getForcedendtime() + "'";
      } else {
        str = str + ",forcedendtime = null ";
      }
      str = str + " where unitid = " + paramInteger + " and tradepartition= " + paramFlowControl.getId().getTradepartition() + " and unittype = " + paramByte;
      executeUpdateBySql(str);
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
      return Integer.valueOf(-1);
    }
    return Integer.valueOf(1);
  }
  
  public List<Map<Object, Object>> listProperty(Short paramShort, Integer paramInteger)
  {
    String str = "select v.attributeid from v_sectionattribute v where v.partitionid  =" + paramShort + " and v.unitid = " + paramInteger;
    return queryBySql(str);
  }
}
