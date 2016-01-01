package gnnt.MEBS.vendue.mgr.action.firmSet;

import gnnt.MEBS.common.mgr.action.EcsideAction;
import gnnt.MEBS.common.mgr.common.Page;
import gnnt.MEBS.common.mgr.common.PageRequest;
import gnnt.MEBS.common.mgr.service.StandardService;
import gnnt.MEBS.priceranking.server.rmi.ServerRMI;
import gnnt.MEBS.vendue.mgr.model.firmSet.specialSet.SpecialFee;
import gnnt.MEBS.vendue.mgr.model.firmSet.specialSet.SpecialFeeId;
import gnnt.MEBS.vendue.mgr.model.firmSet.specialSet.SpecialMargin;
import gnnt.MEBS.vendue.mgr.model.firmSet.specialSet.SpecialMarginId;
import gnnt.MEBS.vendue.mgr.service.firmSet.specialSet.SpecialSetService;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.logging.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

@Controller("specialSetAction")
@Scope("request")
public class SpecialSetAction
  extends EcsideAction
{
  private static final long serialVersionUID = -3508367453229206033L;
  @Autowired
  @Qualifier("specialSetService")
  private SpecialSetService specialSetService;
  @Autowired
  @Qualifier("serverRMIService")
  private ServerRMI serverRMIService;
  @Resource(name="specialSet_bs_flag")
  private Map<Byte, String> specialSet_bs_flag;
  @Resource(name="specialSet_algrMap")
  private Map<Byte, String> specialSet_algrMap;
  
  public Map<Byte, String> getSpecialSet_bs_flag()
  {
    return this.specialSet_bs_flag;
  }
  
  public void setSpecialSet_bs_flag(Map<Byte, String> paramMap)
  {
    this.specialSet_bs_flag = paramMap;
  }
  
  public Map<Byte, String> getSpecialSet_algrMap()
  {
    return this.specialSet_algrMap;
  }
  
  public void setSpecialSet_algrMap(Map<Byte, String> paramMap)
  {
    this.specialSet_algrMap = paramMap;
  }
  
  public String listSpecialFee()
  {
    this.logger.debug("enter Action_listSpecialFee");
    try
    {
      PageRequest localPageRequest = getPageRequest(this.request);
      Page localPage = getService().getPage(localPageRequest, new SpecialFee());
      this.request.setAttribute("pageInfo", localPage);
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
    }
    return "success";
  }
  
  public String forwardAddSpecialFee()
  {
    this.logger.debug("enter Action_forwardAddSpecialFee");
    List localList = this.specialSetService.listBreed();
    this.request.setAttribute("breedList", localList);
    return "success";
  }
  
  public String addSpecialFee()
  {
    this.logger.debug("enter Action_addSpecialFee");
    SpecialFee localSpecialFee = (SpecialFee)this.entity;
    Integer localInteger = this.specialSetService.addSpecialFee(localSpecialFee);
    if (localInteger.intValue() == 1)
    {
      addReturnValue(1, 211001L);
      writeOperateLog(2104, "添加特殊手续费设置成功", 1, "");
    }
    else
    {
      addReturnValue(-1, 213004L);
      writeOperateLog(2104, "添加特殊手续费设置失败", 0, "");
    }
    return "success";
  }
  
  public String forwardUpdateSpecialFee()
  {
    this.logger.debug("enter Action_forwardUpdateSpecialFee");
    SpecialFeeId localSpecialFeeId = new SpecialFeeId();
    String str = this.request.getParameter("userCode");
    Integer localInteger = new Integer(this.request.getParameter("breedId"));
    Byte localByte = new Byte(this.request.getParameter("bs_flag"));
    localSpecialFeeId.setBreedId(localInteger);
    localSpecialFeeId.setBs_flag(localByte);
    localSpecialFeeId.setUserCode(str);
    SpecialFee localSpecialFee = this.specialSetService.viewSpecialFeeById(localSpecialFeeId);
    this.request.setAttribute("specialFee", localSpecialFee);
    return "success";
  }
  
  public String updateSpecialFee()
  {
    this.logger.debug("enter Action_updateSpecialFee");
    SpecialFee localSpecialFee = (SpecialFee)this.entity;
    Integer localInteger = this.specialSetService.updateSpecialFee(localSpecialFee);
    if (localInteger.intValue() == 1)
    {
      addReturnValue(1, 211000L);
      writeOperateLog(2104, "修改特殊手续费成功", 1, "");
    }
    else
    {
      addReturnValue(-1, 213000L);
      writeOperateLog(2104, "修改特殊手续费失败", 0, "");
    }
    return "success";
  }
  
  public String deleteSpecialFee()
  {
    this.logger.debug("enter Action_deleteSpecialFee");
    String[] arrayOfString = this.request.getParameterValues("ids");
    Integer localInteger = this.specialSetService.deleteSpecialFee(arrayOfString);
    if (localInteger.intValue() == 1)
    {
      addReturnValue(1, 211002L);
      writeOperateLog(2104, "删除特殊手续费成功", 1, "");
    }
    else
    {
      addReturnValue(-1, 213005L);
      writeOperateLog(2104, "删除特殊手续费失败", 0, "");
    }
    return "success";
  }
  
  public String listSpecialMargin()
  {
    this.logger.debug("enter Action_listSpecialMargin");
    try
    {
      PageRequest localPageRequest = getPageRequest(this.request);
      Page localPage = getService().getPage(localPageRequest, new SpecialMargin());
      this.request.setAttribute("pageInfo", localPage);
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
    }
    return "success";
  }
  
  public String forwardAddSpecialMargin()
  {
    this.logger.debug("enter Action_forwardAddSpecialMargin");
    List localList = this.specialSetService.listBreed();
    this.request.setAttribute("breedList", localList);
    return "success";
  }
  
  public String addSpecialMargin()
  {
    this.logger.debug("enter Action_addSpecialMargin");
    SpecialMargin localSpecialMargin = (SpecialMargin)this.entity;
    Integer localInteger = this.specialSetService.addSpecialFee(localSpecialMargin);
    if (localInteger.intValue() == 1)
    {
      addReturnValue(1, 211001L);
      writeOperateLog(2104, "添加特殊保证金设置成功", 1, "");
    }
    else
    {
      addReturnValue(0, 213004L);
      writeOperateLog(2104, "添加特殊保证金设置失败", 0, "");
    }
    return "success";
  }
  
  public String forwardUpdateSpecialMargin()
  {
    this.logger.debug("enter Action_forwardUpdateSpecialMargin");
    SpecialMarginId localSpecialMarginId = new SpecialMarginId();
    String str = this.request.getParameter("userCode");
    Integer localInteger = new Integer(this.request.getParameter("breedId"));
    Byte localByte = new Byte(this.request.getParameter("bs_flag"));
    localSpecialMarginId.setBreedId(localInteger);
    localSpecialMarginId.setBs_flag(localByte);
    localSpecialMarginId.setUserCode(str);
    SpecialMargin localSpecialMargin = this.specialSetService.viewSpecialMarginById(localSpecialMarginId);
    this.request.setAttribute("specialMargin", localSpecialMargin);
    return "success";
  }
  
  public String updateSpecialMargin()
  {
    this.logger.debug("enter Action_updateSpecialMargin");
    SpecialMargin localSpecialMargin = (SpecialMargin)this.entity;
    Integer localInteger = this.specialSetService.updateSpecialMargin(localSpecialMargin);
    if (localInteger.intValue() == 1)
    {
      addReturnValue(1, 211000L);
      writeOperateLog(2104, "修改特殊保证金成功", 1, "");
    }
    else
    {
      addReturnValue(0, 213000L);
      writeOperateLog(2104, "修改特殊保证金失败", 0, "");
    }
    return "success";
  }
  
  public String deleteSpecialMargin()
  {
    this.logger.debug("enter Action_deleteSpecialMargin");
    String[] arrayOfString = this.request.getParameterValues("ids");
    Integer localInteger = this.specialSetService.deleteSpecialMargin(arrayOfString);
    if (localInteger.intValue() == 1)
    {
      addReturnValue(1, 211002L);
      writeOperateLog(2104, "删除特殊保证金成功", 1, "");
    }
    else
    {
      addReturnValue(0, 213005L);
      writeOperateLog(2104, "删除特殊保证金失败", 0, "");
    }
    return "success";
  }
  
  public String refreshSpecialFee()
  {
    try
    {
      this.serverRMIService.refreshSpecialFee();
      addReturnValue(1, 211016L, new Object[] { "特殊手续费" });
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
      addReturnValue(0, 213027L, new Object[] { "特殊手续费" });
    }
    return "success";
  }
  
  public String refreshSpecialMargin()
  {
    try
    {
      this.serverRMIService.refreshSpecialMargin();
      addReturnValue(1, 211016L, new Object[] { "特殊保证金" });
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
      addReturnValue(0, 213027L, new Object[] { "特殊保证金" });
    }
    return "success";
  }
}
