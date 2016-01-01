package gnnt.MEBS.vendue.mgr.action.commodity;

import gnnt.MEBS.common.mgr.action.EcsideAction;
import gnnt.MEBS.common.mgr.common.Page;
import gnnt.MEBS.common.mgr.common.PageRequest;
import gnnt.MEBS.common.mgr.common.QueryConditions;
import gnnt.MEBS.common.mgr.service.StandardService;
import gnnt.MEBS.priceranking.server.rmi.ServerRMI;
import gnnt.MEBS.vendue.mgr.model.commodity.curCommodities.CurCommodity;
import gnnt.MEBS.vendue.mgr.service.commodity.curCommdity.CurCommodityService;
import java.rmi.RemoteException;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.logging.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

@Controller("curCommoditiesAction")
@Scope("request")
public class CurCommoditiesAction
  extends EcsideAction
{
  private static final long serialVersionUID = -7233405747956452297L;
  @Autowired
  @Qualifier("curCommodityService")
  private CurCommodityService curCommodityService;
  @Autowired
  @Qualifier("serverRMIService")
  private ServerRMI serverRMIService;
  @Resource(name="curCommodity_bargainTypeMap")
  private Map<Byte, String> curCommodity_bargainTypeMap;
  
  public Map<Byte, String> getCurCommodity_bargainTypeMap()
  {
    return this.curCommodity_bargainTypeMap;
  }
  
  public void setCurCommodity_bargainTypeMap(Map<Byte, String> paramMap)
  {
    this.curCommodity_bargainTypeMap = paramMap;
  }
  
  public String listCurCommodity()
  {
    this.logger.debug("enter listCurCommodity");
    try
    {
      Byte localByte = new Byte(this.request.getParameter("partitionid"));
      Short localShort = Short.valueOf(Short.parseShort(this.request.getParameter("trademode")));
      PageRequest localPageRequest = getPageRequest(this.request);
      QueryConditions localQueryConditions = (QueryConditions)localPageRequest.getFilters();
      localQueryConditions.addCondition("tradePartition", "=", localByte);
      Page localPage = getService().getPage(localPageRequest, new CurCommodity());
      this.request.setAttribute("pageInfo", localPage);
      this.request.setAttribute("trademode", localShort);
      this.request.setAttribute("partitionid", localByte);
      this.request.setAttribute("oldParams", getParametersStartingWith(this.request, "gnnt_"));
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
    }
    return "success";
  }
  
  public String addSectionToCurCommodity()
    throws Exception
  {
    this.logger.debug("enter addSectionToCurCommodity");
    Byte localByte = new Byte(this.request.getParameter("partitionid"));
    Short localShort = Short.valueOf(Short.parseShort(this.request.getParameter("trademode")));
    this.request.setAttribute("trademode", localShort);
    this.request.setAttribute("partitionid", localByte);
    String str1 = this.request.getParameter("entity.section");
    StringBuffer localStringBuffer = this.curCommodityService.validateCodes(this.request.getParameterValues("ids"), str1);
    Integer localInteger = Integer.valueOf(0);
    String str2 = "";
    String str3 = "";
    if (localStringBuffer.toString().startsWith("end"))
    {
      str2 = this.curCommodityService.returnInfoAboutDisabledCodes(localStringBuffer.toString().split("end")[1].split(","));
    }
    else if (localStringBuffer.toString().endsWith("end"))
    {
      str3 = this.curCommodityService.returnInfoAboutOldSection(localStringBuffer.toString().split("end")[0].split(","));
      localInteger = this.curCommodityService.addSectionToCurCommodity(str1, localByte, localStringBuffer.toString().split("end")[0].split(","));
    }
    else
    {
      str2 = this.curCommodityService.returnInfoAboutDisabledCodes(localStringBuffer.toString().split("end")[1].split(","));
      str3 = this.curCommodityService.returnInfoAboutOldSection(localStringBuffer.toString().split("end")[0].split(","));
      localInteger = this.curCommodityService.addSectionToCurCommodity(str1, localByte, localStringBuffer.toString().split("end")[0].split(","));
    }
    if (localInteger.intValue() == 1)
    {
      if ("".equals(str2)) {
        addReturnValue(1, 211005L);
      } else {
        addReturnValue(1, 212002L, new Object[] { str2 });
      }
      writeOperateLog(2105, "指定交易节成功", 1, str3);
    }
    else
    {
      if ("".equals(str2)) {
        addReturnValue(0, 213013L);
      } else {
        addReturnValue(1, 213015L, new Object[] { str2 });
      }
      writeOperateLog(2105, "指定交易节失败", 0, "");
    }
    return "success";
  }
  
  public String deleteCurCommodity()
    throws RemoteException
  {
    this.logger.debug("enter deleteCurCommodities");
    Byte localByte = new Byte(this.request.getParameter("partitionid"));
    Short localShort = Short.valueOf(Short.parseShort(this.request.getParameter("trademode")));
    this.request.setAttribute("trademode", localShort);
    this.request.setAttribute("partitionid", localByte);
    String[] arrayOfString1 = this.request.getParameterValues("ids");
    String[] arrayOfString2 = this.curCommodityService.getEnableForDeleteCodes(arrayOfString1);
    Integer localInteger = Integer.valueOf(0);
    if (arrayOfString2 != null) {
      localInteger = this.curCommodityService.deleteCurCommodity(localByte, arrayOfString2);
    }
    String str = this.curCommodityService.getInfoAboutDelete(this.curCommodityService.getDisableForDeleteCodes(arrayOfString1));
    this.logger.debug(str);
    if (localInteger.intValue() == 1)
    {
      if (!"".equals(str)) {
        addReturnValue(0, 212003L, new Object[] { str });
      } else {
        addReturnValue(1, 211002L);
      }
      writeOperateLog(2105, "删除当前商品成功", 1, str);
    }
    else
    {
      if (!"".equals(str)) {
        addReturnValue(-1, 213016L, new Object[] { str });
      } else {
        addReturnValue(-1, 213005L);
      }
      writeOperateLog(2105, "删除当前商品失败", 0, "");
    }
    this.request.removeAttribute("ids");
    return "success";
  }
  
  public String insertSectionToCurCommodity()
  {
    this.logger.debug("enter addSectionToCurCommodity");
    Byte localByte = new Byte(this.request.getParameter("partitionid"));
    Short localShort = Short.valueOf(Short.parseShort(this.request.getParameter("trademode")));
    this.request.setAttribute("trademode", localShort);
    this.request.setAttribute("partitionid", localByte);
    String[] arrayOfString1 = this.request.getParameterValues("ids");
    String[] arrayOfString2 = this.curCommodityService.getenableInsertSectionCodes(arrayOfString1);
    Integer localInteger = Integer.valueOf(0);
    String str1 = "";
    if (arrayOfString2 == null)
    {
      addReturnValue(-1, 213026L, new Object[] { "所选当前商品必须是未成交状态且尚未指定交易节编号" });
      writeOperateLog(2105, "插入交易节失败", 0, "");
      return "success";
    }
    String str2 = this.request.getParameter("entity.section");
    String[] arrayOfString3 = this.curCommodityService.getDisableInsertSectionCodes(arrayOfString1);
    localInteger = this.curCommodityService.insertSection(arrayOfString2, str2, localByte);
    str1 = this.curCommodityService.getinfoAboutInsertSection(arrayOfString3);
    if (localInteger.intValue() == 1)
    {
      if (!"".equals(str1)) {
        addReturnValue(0, 212004L, new Object[] { str1 });
      } else {
        addReturnValue(1, 211015L);
      }
      writeOperateLog(2105, "插入交易节成功", 1, str1);
    }
    else
    {
      addReturnValue(-1, 213026L, new Object[] { "异常！" });
      writeOperateLog(2105, "插入交易节失败", 0, "");
    }
    return "success";
  }
  
  public String refreshCurCommodity()
    throws RemoteException
  {
    this.logger.debug("enter addSectionToCurCommodity");
    Byte localByte = new Byte(this.request.getParameter("partitionid"));
    Short localShort = Short.valueOf(Short.parseShort(this.request.getParameter("trademode")));
    this.request.setAttribute("trademode", localShort);
    this.request.setAttribute("partitionid", localByte);
    this.serverRMIService.refreshCommodity((short)localByte.byteValue());
    return "success";
  }
}
