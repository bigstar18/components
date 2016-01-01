package gnnt.MEBS.trademonitor.mgr.communicate;

import gnnt.MEBS.common.communicate.IBalanceRMI;
import gnnt.MEBS.common.communicate.model.BalanceVO;
import gnnt.MEBS.common.mgr.common.ProcedureParameter;
import gnnt.MEBS.common.mgr.dao.StandardDao;
import gnnt.MEBS.common.mgr.service.StandardService;
import gnnt.MEBS.common.mgr.statictools.ApplicationContextInit;
import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class BalanceRMIImpl
  extends UnicastRemoteObject
  implements IBalanceRMI
{
  protected final transient Log logger = LogFactory.getLog(getClass());
  private static final long serialVersionUID = 4235306082924535019L;
  
  protected BalanceRMIImpl()
    throws RemoteException
  {}
  
  public BalanceVO checkBalance()
    throws RemoteException
  {
    BalanceVO localBalanceVO = new BalanceVO();
    localBalanceVO.setBalanceStatus(true);
    return localBalanceVO;
  }
  
  public boolean noticeSubsystemStatus()
    throws RemoteException
  {
    this.logger.info("---------noticeSubsystemStatus----------监控数据导历史--------------");
    StandardService localStandardService = (StandardService)ApplicationContextInit.getBean("com_standardService");
    StandardDao localStandardDao = (StandardDao)ApplicationContextInit.getBean("com_standardDao");
    String str = "select sysdate from dual";
    List localList = localStandardService.getListBySql(str);
    Timestamp localTimestamp = (Timestamp)((Map)localList.get(0)).get("SYSDATE");
    ArrayList localArrayList = new ArrayList();
    ProcedureParameter localProcedureParameter = new ProcedureParameter();
    localProcedureParameter.setParameterType(2);
    localProcedureParameter.setSqlType(93);
    localProcedureParameter.setName("p_EndDate");
    localProcedureParameter.setValue(localTimestamp);
    localArrayList.add(localProcedureParameter);
    try
    {
      localStandardDao.executeProcedure("{call SP_TM_MoveHistory(?) }", localArrayList);
    }
    catch (Exception localException)
    {
      this.logger.error("监控系统转历史报错", localException);
    }
    return true;
  }
}
