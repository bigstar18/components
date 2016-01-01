package gnnt.MEBS.integrated.warehouse.service.writeopreatelog;

import gnnt.MEBS.common.warehouse.model.LogCatalog;
import gnnt.MEBS.common.warehouse.model.OperateLog;
import gnnt.MEBS.common.warehouse.model.User;
import gnnt.MEBS.common.warehouse.service.StandardService;
import gnnt.MEBS.common.warehouse.statictools.Tools;
import org.apache.commons.logging.Log;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service("writeOperateLogService")
@Transactional(propagation=Propagation.REQUIRED, readOnly=false, rollbackFor={Exception.class})
public class WriteOperateLogService
  extends StandardService
{
  public void writeOperateLog(int paramInt1, User paramUser, String paramString1, int paramInt2, String paramString2)
  {
    OperateLog localOperateLog = new OperateLog();
    localOperateLog.setLogType(Integer.valueOf(1));
    localOperateLog.setOperator(paramUser.getUserId());
    localOperateLog.setWareHouseID(paramUser.getWarehouseID());
    localOperateLog.setOperateIp(paramUser.getIpAddress());
    try
    {
      localOperateLog.setOperateTime(getSysDate());
    }
    catch (Exception localException)
    {
      this.logger.error(Tools.getExceptionTrace(localException));
    }
    LogCatalog localLogCatalog = new LogCatalog();
    localLogCatalog.setCatalogID(Integer.valueOf(paramInt1));
    localOperateLog.setLogCatalog(localLogCatalog);
    localOperateLog.setOperatorType(paramUser.getType());
    localOperateLog.setOperateContent(paramString1);
    localOperateLog.setOperateResult(Integer.valueOf(paramInt2));
    localOperateLog.setMark(paramString2);
    add(localOperateLog);
  }
}
