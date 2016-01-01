package gnnt.MEBS.espot.mgr.action.fundmanage;

import gnnt.MEBS.common.mgr.action.EcsideAction;
import gnnt.MEBS.common.mgr.common.PageRequest;
import gnnt.MEBS.common.mgr.service.StandardService;
import gnnt.MEBS.common.mgr.statictools.ApplicationContextInit;
import gnnt.MEBS.common.mgr.statictools.Tools;
import gnnt.MEBS.espot.core.kernel.IFundsProcess;
import gnnt.MEBS.espot.core.vo.ResultVO;
import gnnt.MEBS.espot.mgr.model.firmmanage.MFirm;
import gnnt.MEBS.espot.mgr.model.parametermanage.SystemProps;
import gnnt.MEBS.espot.mgr.service.fundService.FundService;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.logging.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

@Controller("fundAction")
@Scope("request")
public class FundAciton
  extends EcsideAction
{
  private static final long serialVersionUID = 1L;
  private static final String LEASTSUBSCRIPTION = "LeastSubscription";
  @Resource(name="oprcodeMap")
  protected Map<Integer, String> oprcodeMap;
  @Autowired
  @Qualifier("e_fundService")
  private FundService fundService;
  @Autowired
  @Qualifier("processService")
  private IFundsProcess processService;
  private String firmId;
  
  public Map<Integer, String> getOprcodeMap()
  {
    return this.oprcodeMap;
  }
  
  public IFundsProcess getProcessService()
  {
    return this.processService;
  }
  
  public FundService getFundService()
  {
    return this.fundService;
  }
  
  public String getFirmId()
  {
    return this.firmId;
  }
  
  public void setFirmId(String paramString)
  {
    this.firmId = paramString;
  }
  
  public String fundsList()
    throws Exception
  {
    PageRequest localPageRequest = getPageRequest(this.request);
    localPageRequest.setSortColumns("order by firmId desc");
    listByLimit(localPageRequest);
    SystemProps localSystemProps = new SystemProps();
    localSystemProps.setPropsKey("LeastSubscription");
    localSystemProps = (SystemProps)getService().get(localSystemProps);
    this.request.setAttribute("lastScription", localSystemProps.getRunTimeValue());
    return "success";
  }
  
  public String forwardfund()
  {
    return "success";
  }
  
  public String queryfund()
  {
    this.logger.debug("交易商诚信保障金信息查询");
    String str1 = this.request.getParameter("firmId");
    String str2 = "select f.subscription,s.runtimevalue,FN_E_CanOutSubscription('" + str1 + "',0) as canoutsubscription,FN_F_GetRealFunds('" + str1 + "',0) as getrealfunds from E_funds f,E_systemprops s where f.firmid='" + str1 + "' and s.key='LeastSubscription'";
    List localList = getService().getListBySql(str2);
    if ((localList != null) && (localList.size() > 0))
    {
      Map localMap = (Map)localList.get(0);
      if ((localMap != null) && (localMap.size() > 0))
      {
        Iterator localIterator = localMap.keySet().iterator();
        while (localIterator.hasNext())
        {
          Object localObject = localIterator.next();
          this.request.setAttribute(localObject + "", localMap.get(localObject));
        }
      }
    }
    this.request.setAttribute("firmId", str1);
    return "success";
  }
  
  public String paymentSubscription()
  {
    String str1 = this.request.getParameter("firmId");
    if ((str1 == null) || ("".equals(str1)))
    {
      addReturnValue(-1, 230003L, new Object[] { "交易商不存在！" });
      return "success";
    }
    String str2 = this.request.getParameter("inputAmount");
    String str3 = "代交易商：" + str1 + "执行转入诚信保障金";
    try
    {
      ResultVO localResultVO = null;
      if (!"".equals(str2)) {
        localResultVO = this.processService.paymentSubscription(str1, Tools.strToDouble(str2, 0.0D));
      }
      if (localResultVO.getResult() < 0L)
      {
        addReturnValue(-1, 230003L, new Object[] { localResultVO.getErrorInfo() });
        writeOperateLog(2305, str3, 0, localResultVO.getErrorInfo());
      }
      else if (localResultVO.getResult() == 0L)
      {
        addReturnValue(-1, 230005L, new Object[] { localResultVO.getErrorInfo() });
        writeOperateLog(2305, str3, 0, localResultVO.getErrorInfo());
      }
      else
      {
        addReturnValue(1, 236400L);
        writeOperateLog(2305, str3, 1, "");
      }
    }
    catch (Exception localException)
    {
      addReturnValue(-1, 230004L, new Object[] { "转入诚信保障金操作" });
      writeOperateLog(2305, str3, 0, localException.getMessage());
      this.logger.error(Tools.getExceptionTrace(localException));
    }
    return "success";
  }
  
  public String refundmentSubscription()
  {
    String str1 = this.request.getParameter("firmId");
    if ((str1 == null) || ("".equals(str1)))
    {
      addReturnValue(-1, 230003L, new Object[] { "交易商不存在！" });
      return "success";
    }
    String str2 = "代交易商：" + str1 + "转出诚信保障金";
    this.logger.debug(str2);
    String str3 = this.request.getParameter("inputAmount");
    try
    {
      ResultVO localResultVO = null;
      if (!"".equals(str3)) {
        localResultVO = this.processService.refundmentSubscription(str1, Tools.strToDouble(str3, 0.0D));
      }
      if (localResultVO.getResult() < 0L)
      {
        addReturnValue(-1, 230003L, new Object[] { localResultVO });
        writeOperateLog(2305, str2, 0, localResultVO.getErrorInfo());
      }
      else if (localResultVO.getResult() == 0L)
      {
        addReturnValue(-1, 230005L, new Object[] { localResultVO });
        writeOperateLog(2305, str2, 0, localResultVO.getErrorInfo());
      }
      else
      {
        addReturnValue(1, 236401L);
        writeOperateLog(2305, str2, 1, "");
      }
    }
    catch (Exception localException)
    {
      addReturnValue(-1, 230004L, new Object[] { "转出诚信保障金操作" });
      writeOperateLog(2305, str2, 0, localException.getMessage());
      this.logger.error(Tools.getExceptionTrace(localException));
    }
    return "success";
  }
  
  public String inmoneymodel()
  {
    String str1 = "模拟转入资金,转入金额:";
    double d1 = Tools.strToDouble(this.request.getParameter("money"), 10000.0D);
    str1 = str1 + Tools.fmtDouble2(d1);
    String str2 = this.request.getParameter("firmId");
    MFirm localMFirm = new MFirm();
    localMFirm.setFirmId(str2);
    localMFirm = (MFirm)getService().get(localMFirm);
    if (localMFirm == null)
    {
      addReturnValue(-1, 230003L, new Object[] { "交易商不存在" });
      writeOperateLog(2305, str1, 0, String.format(ApplicationContextInit.getErrorInfo("230003"), new Object[] { "交易商不存在" }));
      return "success";
    }
    if (d1 > 0.0D)
    {
      try
      {
        double d2 = this.fundService.inmoneymodel(str2, d1);
        if (d2 < 0.0D)
        {
          addReturnValue(-1, 230003L, new Object[] { "入金操作失败" });
          writeOperateLog(2305, str1, 0, String.format(ApplicationContextInit.getErrorInfo("230003"), new Object[] { "入金操作失败" }));
        }
        else
        {
          addReturnValue(1, 230005L, new Object[] { "入金：" + Tools.fmtDouble2(d1) + " 成功，您的当前余额为：" + Tools.fmtDouble2(d2) });
          writeOperateLog(2305, str1, 1, "");
        }
      }
      catch (Exception localException)
      {
        localException.printStackTrace();
      }
    }
    else
    {
      addReturnValue(-1, 230003L, new Object[] { "输入资金值为" + d1 });
      writeOperateLog(2305, str1, 0, String.format(ApplicationContextInit.getErrorInfo("230003"), new Object[] { "入金操作失败" }));
    }
    return "success";
  }
}
