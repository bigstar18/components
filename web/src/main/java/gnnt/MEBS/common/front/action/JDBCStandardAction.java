package gnnt.MEBS.common.front.action;

import com.opensymphony.xwork2.ActionSupport;
import gnnt.MEBS.common.front.common.ReturnValue;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

public class JDBCStandardAction
  extends ActionSupport
  implements ServletRequestAware, ServletResponseAware
{
  private static final long serialVersionUID = 1479876290655836738L;
  protected final transient Log logger = LogFactory.getLog(getClass());
  protected HttpServletRequest request;
  protected HttpServletResponse response;
  
  public void setServletRequest(HttpServletRequest request)
  {
    this.request = request;
  }
  
  public void setServletResponse(HttpServletResponse response)
  {
    this.response = response;
  }
  
  public void addReturnValue(int result, long code)
  {
    addReturnValue(result, code, null);
  }
  
  public void addReturnValue(int result, long code, Object[] args)
  {
    ReturnValue returnValue = new ReturnValue();
    returnValue.setResult(result);
    if (args == null) {
      returnValue.addInfo(code);
    } else {
      returnValue.addInfo(code, args);
    }
    this.request.setAttribute("ReturnValue", returnValue);
  }
}
