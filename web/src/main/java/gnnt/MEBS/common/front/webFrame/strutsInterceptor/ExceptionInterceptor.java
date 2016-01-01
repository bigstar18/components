package gnnt.MEBS.common.front.webFrame.strutsInterceptor;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;
import gnnt.MEBS.common.front.action.StandardAction;
import gnnt.MEBS.common.front.common.ReturnValue;
import gnnt.MEBS.common.front.model.OperateLog;
import gnnt.MEBS.common.front.service.StandardService;
import gnnt.MEBS.common.front.statictools.Tools;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.ServletActionContext;

public class ExceptionInterceptor
  extends AbstractInterceptor
{
  private static final long serialVersionUID = 6390831317255258653L;
  private final transient Log logger = LogFactory.getLog(ExceptionInterceptor.class);
  
  public String intercept(ActionInvocation invocation)
    throws Exception
  {
    this.logger.debug("ExceptionInterceptor enter");
    HttpServletRequest request = ServletActionContext.getRequest();
    String result = "";
    try
    {
      result = invocation.invoke();
    }
    catch (Exception e)
    {
      result = "SysException";
      ReturnValue returnValue = new ReturnValue();
      returnValue.setResult(-1);
      
      returnValue.addInfo(9930091L);
      
      request.setAttribute("ReturnValue", returnValue);
      this.logger.error(returnValue.getInfo() + ";详细信息：" + Tools.getExceptionTrace(e));
      
      OperateLog operateLog = (OperateLog)request.getAttribute("operateLog");
      if (request.getAttribute("operateLog") != null)
      {
        operateLog.setOperateResult(Integer.valueOf(0));
        operateLog.setLogType(Integer.valueOf(2));
        operateLog.setMark("失败原因:" + e.getMessage());
        
        StandardAction action = (StandardAction)invocation.getAction();
        
        StandardService service = action.getService();
        service.add(operateLog);
      }
    }
    return result;
  }
}
