package gnnt.MEBS.common.broker.beanforajax;

import gnnt.MEBS.common.broker.service.StandardService;
import gnnt.MEBS.common.broker.statictools.Tools;
import java.util.Date;
import org.apache.commons.logging.Log;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

@Controller("com_ajaxQuery")
@Scope("request")
public class AjaxQuery
  extends BaseAjax
{
  private static Long diffTime;
  
  public String getSystemTimeJson()
  {
    if (diffTime == null) {
      synchronized (getClass())
      {
        if (diffTime == null) {
          try
          {
            Date sysdate = getService().getSysDate();
            if (sysdate != null) {
              diffTime = Long.valueOf(sysdate.getTime() - System.currentTimeMillis());
            }
          }
          catch (Exception e)
          {
            this.logger.debug(Tools.getExceptionTrace(e));
          }
        }
      }
    }
    long dif = 0L;
    if (diffTime != null) {
      dif = diffTime.longValue();
    }
    String dbdate = Tools.fmtTime(new Date(System.currentTimeMillis() + dif));
    this.jsonValidateReturn = createJSONArray(new Object[] { dbdate });
    return "success";
  }
}
