package gnnt.MEBS.common.front.action;

import gnnt.MEBS.common.front.common.Page;
import gnnt.MEBS.common.front.common.PageRequest;
import gnnt.MEBS.common.front.model.StandardModel;
import gnnt.MEBS.common.front.model.integrated.CertificateType;
import gnnt.MEBS.common.front.model.integrated.Industry;
import gnnt.MEBS.common.front.model.integrated.MFirmApply;
import gnnt.MEBS.common.front.model.integrated.Zone;
import gnnt.MEBS.common.front.service.StandardService;
import java.io.PrintStream;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.commons.logging.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

@Controller("com_firmApplyAction")
@Scope("request")
public class FirmApplyAction
  extends StandardAction
{
  private static final long serialVersionUID = 1521609715400531850L;
  @Autowired
  @Resource(name="com_firmTypeMap")
  private Map<String, String> com_firmTypeMap;
  
  public FirmApplyAction()
  {
    super.setEntityName(MFirmApply.class.getName());
  }
  
  public Map<String, String> getCom_firmTypeMap()
  {
    return this.com_firmTypeMap;
  }
  
  public String firmApplyForward()
  {
    PageRequest<String> pageRequest = new PageRequest(" order by sortNo");
    
    Page<StandardModel> zone = getService().getPage(pageRequest, new Zone());
    
    this.request.setAttribute("zoneList", zone.getResult());
    
    Page<StandardModel> industry = getService().getPage(pageRequest, new Industry());
    
    this.request.setAttribute("industryList", industry.getResult());
    
    Page<StandardModel> certificateType = getService().getPage(pageRequest, new CertificateType());
    
    this.request.setAttribute("certificateTypeList", certificateType.getResult());
    
    return "success";
  }
  
  public String firmApply()
  {
    MFirmApply apply = (MFirmApply)this.entity;
    apply.setCreateTime(getService().getSysDate());
    
    String randomicitynum = (String)this.request.getSession().getAttribute(
      "RANDOMICITYNUM");
    
    String imgcode = this.request.getParameter("imgcode");
    if ((randomicitynum == null) || (randomicitynum.trim().length() < 0))
    {
      this.logger.debug("系统生成的验证码为空值");
      addReturnValue(-1, 9930103L);
      return "error";
    }
    if ((imgcode == null) || (imgcode.trim().length() < 0))
    {
      this.logger.debug("用户传入验证码为空值");
      addReturnValue(-1, 9930103L);
      return "error";
    }
    if (!imgcode.equalsIgnoreCase(randomicitynum))
    {
      this.logger.debug("用户输入验证码[" + imgcode + "]与系统生成的验证码[" + randomicitynum + 
        "]不一致");
      
      addReturnValue(-1, 9930103L);
      return "error";
    }
    System.out.println("========");
    
    getService().add(this.entity);
    addReturnValue(1, 10000L);
    return "success";
  }
}
