package gnnt.MEBS.common.broker.webframe.strutsinterceptor;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.ActionProxy;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;
import gnnt.MEBS.common.broker.action.StandardAction;
import gnnt.MEBS.common.broker.model.Apply;
import gnnt.MEBS.common.broker.model.Broker;
import gnnt.MEBS.common.broker.model.StandardModel;
import gnnt.MEBS.common.broker.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.broker.service.StandardService;
import java.util.Date;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class AuditInterceptor
  extends AbstractInterceptor
{
  private static final long serialVersionUID = 6829986728782120166L;
  
  public String intercept(ActionInvocation invocation)
    throws Exception
  {
    ActionContext actionContext = invocation.getInvocationContext();
    HttpServletRequest request = (HttpServletRequest)actionContext
      .get("com.opensymphony.xwork2.dispatcher.HttpServletRequest");
    
    StandardAction action = (StandardAction)invocation.getAction();
    
    StandardModel entity = action.getEntity();
    if ((action.getAuditType() != null) && (action.getAuditType().length() > 0))
    {
      String method = invocation.getProxy().getMethod();
      if ((method.equals("viewById")) || (method.equals("forwardAdd")))
      {
        request.setAttribute("auditType", action.getAuditType());
        return invocation.invoke();
      }
      if ((method.equals("add")) || (method.equals("update")) || 
        (method.equals("delete")) || 
        (method.equals("deleteCollection")))
      {
        Broker broker = (Broker)request.getSession().getAttribute(
          "CurrentUser");
        
        Apply apply = new Apply();
        apply.setOperateType("add");
        apply.setApplyType(action.getAuditType());
        apply.setApplyUser(broker.getBrokerId());
        apply.setEntityClass(entity.getClass().getName());
        apply.setCreateTime(new Date());
        apply.setStatus(Integer.valueOf(0));
        if (method.equals("add"))
        {
          String discribe = "添加数据：" + entity.translate();
          
          apply.setOperateType("add");
          apply.setContent(entity.serialize());
          apply.setDiscribe(discribe);
          
          action.addReturnValue(1, 119904L);
        }
        else if (method.startsWith("delete"))
        {
          String[] ids = request.getParameterValues("ids");
          if ((ids == null) || (ids.length == 0)) {
            throw new IllegalArgumentException("删除主键数组不能为空！");
          }
          if (entity == null) {
            throw new IllegalArgumentException(
              "业务对象为空，所以操作表未知，不允许通过主键数组批量删除！");
          }
          if ((entity.fetchPKey() == null) || 
            (entity.fetchPKey().getKey() == null) || 
            (entity.fetchPKey().getKey().length() == 0)) {
            throw new IllegalArgumentException(
              "业务对象未设置主键，不允许通过主键数组批量删除！");
          }
          String content = "";
          String[] arrayOfString1;
          int j = (arrayOfString1 = ids).length;
          for (int i = 0; i < j; i++)
          {
            String id = arrayOfString1[i];
            content = content + id + ",";
          }
          content = content.substring(0, content.length() - 1);
          
          String discribe = "删除数据：" + 
            content;
          
          apply.setContent(content);
          if (method.equals("delete")) {
            apply.setOperateType("delete");
          } else {
            apply.setOperateType("deleteCollection");
          }
          apply.setDiscribe(discribe);
          
          action.addReturnValue(1, 119906L);
        }
        else if (method.equals("update"))
        {
          StandardModel model = action.getService().get(entity);
          String discribe = "更新数据," + model.compareTranslate(entity);
          
          apply.setOperateType("update");
          apply.setContent(entity.serialize());
          apply.setDiscribe(discribe);
          
          action.addReturnValue(1, 119905L);
        }
        action.getService().add(apply);
        return "success";
      }
      return invocation.invoke();
    }
    return invocation.invoke();
  }
}
