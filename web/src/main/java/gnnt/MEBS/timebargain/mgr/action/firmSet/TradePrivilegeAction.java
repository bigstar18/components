package gnnt.MEBS.timebargain.mgr.action.firmSet;

import gnnt.MEBS.common.mgr.action.EcsideAction;
import gnnt.MEBS.common.mgr.common.Page;
import gnnt.MEBS.common.mgr.common.PageRequest;
import gnnt.MEBS.common.mgr.common.QueryConditions;
import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.mgr.service.StandardService;
import gnnt.MEBS.timebargain.mgr.model.firmSet.TCustomer;
import gnnt.MEBS.timebargain.mgr.model.firmSet.TTrader;
import gnnt.MEBS.timebargain.mgr.model.firmSet.TradePrivilege;
import gnnt.MEBS.timebargain.mgr.service.TradePrivilegeService;
import gnnt.MEBS.timebargain.mgr.statictools.CommonDictionary;
import java.lang.reflect.Field;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.logging.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

@Controller("tradePrivilegeAction")
@Scope("request")
public class TradePrivilegeAction
  extends EcsideAction
{
  private static final long serialVersionUID = 6792576342232310520L;
  @Resource(name="firm_statusMap")
  private Map<Integer, String> firm_statusMap;
  @Resource(name="tradePrivilege_typeMap")
  private Map<Integer, String> tradePrivilege_typeMap;
  @Resource(name="tradePrivilege_kindMap")
  private Map<Integer, String> tradePrivilege_kindMap;
  @Resource(name="privilegeCode_BMap")
  private Map<Integer, String> privilegeCode_BMap;
  @Resource(name="privilegeCode_SMap")
  private Map<Integer, String> privilegeCode_SMap;
  @Autowired
  @Qualifier("tradePrivilegeService")
  private TradePrivilegeService tradePrivilegeService;
  
  public String addFirmPrivilege()
  {
    this.logger.debug("enter addFirmPrivilege");
    getService().add(this.entity);
    addReturnValue(1, 119901L);
    return "success";
  }
  
  public String updateStatus()
  {
    this.logger.debug("enter updateStatus");
    String[] arrayOfString = this.request.getParameterValues("ids");
    String str = this.request.getParameter("status");
    getService().updateBYBulk(this.entity, "status=" + str, arrayOfString);
    return "success";
  }
  
  public String listCustomer()
    throws Exception
  {
    this.logger.debug("enter listCustomer");
    String str = this.request.getParameter("firmID");
    if ((str != null) && (!"".equals(str)))
    {
      PageRequest localPageRequest = super.getPageRequest(this.request);
      QueryConditions localQueryConditions = (QueryConditions)localPageRequest.getFilters();
      localQueryConditions.addCondition("primary.firmIDs", "=", str);
      listByLimit(localPageRequest);
      this.request.setAttribute("firmID", str);
    }
    return "success";
  }
  
  public String forwardAddCustomer()
  {
    this.logger.debug("enter forwardAddCustomer");
    String str = this.request.getParameter("firmID");
    this.request.setAttribute("firmID", str);
    return "success";
  }
  
  public String addCustomer()
    throws Exception
  {
    this.logger.debug("enter addCustomer");
    String str1 = this.request.getParameter("firmID");
    String str2 = this.request.getParameter("code");
    String str3 = this.request.getParameter("startCode");
    String str4 = this.request.getParameter("endCode");
    String str5 = this.request.getParameter("status");
    String[] arrayOfString = null;
    if ((str2 != null) && (!"".equals(str2))) {
      arrayOfString = str2.split(",");
    }
    int i = 0;
    int j = 0;
    if (((str3 != null ? 1 : 0) & (!"".equals(str3) ? 1 : 0)) != 0)
    {
      i = Integer.parseInt(str3);
      j = Integer.parseInt(str4) + 1;
    }
    String str6 = "";
    int k = 0;
    int m;
    TCustomer localTCustomer1;
    TCustomer localTCustomer2;
    if (arrayOfString != null) {
      for (m = 0; m < arrayOfString.length; m++)
      {
        localTCustomer1 = new TCustomer();
        localTCustomer1.setCustomerID(str1 + arrayOfString[m].trim());
        if (arrayOfString[m].trim().length() != 2)
        {
          addReturnValue(0, 151103L, new Object[] { "输入格式不正确，请重新输入！" });
          k++;
        }
        else
        {
          localTCustomer2 = (TCustomer)getService().get(localTCustomer1);
          if (localTCustomer2 != null)
          {
            addReturnValue(-1, 151103L, new Object[] { "添加失败，已存在二级客户代码：" + arrayOfString[m].trim() });
            k++;
            break;
          }
        }
        if (k == 0)
        {
          localTCustomer1.setFirmIDs(str1);
          localTCustomer1.setCode(arrayOfString[m].trim());
          localTCustomer1.setStatus(Integer.valueOf(Integer.parseInt(str5)));
          localTCustomer1.setCreateTime(getService().getSysDate());
          localTCustomer1.setModifyTime(getService().getSysDate());
          getService().add(localTCustomer1);
          addReturnValue(1, 119901L);
        }
      }
    }
    if (i != 0) {
      for (m = i; m < j; m++)
      {
        if (m < 10) {
          str6 = "0" + m;
        } else {
          str6 = m + "";
        }
        localTCustomer1 = new TCustomer();
        localTCustomer1.setCustomerID(str1 + str6);
        localTCustomer2 = (TCustomer)getService().get(localTCustomer1);
        if (localTCustomer2 != null)
        {
          addReturnValue(-1, 151103L, new Object[] { "添加失败，已存在二级客户代码：" + str6 });
          k++;
          break;
        }
        if (k == 0)
        {
          localTCustomer1.setFirmIDs(str1);
          localTCustomer1.setCode(str6);
          localTCustomer1.setStatus(Integer.valueOf(Integer.parseInt(str5)));
          localTCustomer1.setCreateTime(getService().getSysDate());
          localTCustomer1.setModifyTime(getService().getSysDate());
          getService().add(localTCustomer1);
          addReturnValue(1, 119901L);
        }
      }
    }
    return "success";
  }
  
  public String batchSetSaveFirmPrivilege()
    throws Exception
  {
    this.logger.debug("enter batchSetFirmPrivilege");
    String str1 = this.request.getParameter("typeID");
    String str2 = this.request.getParameter("startFirm");
    String str3 = this.request.getParameter("endFirm");
    TradePrivilege localTradePrivilege1 = (TradePrivilege)this.entity;
    try
    {
      String[] arrayOfString = null;
      if ((str1 != null) && (!"".equals(str1))) {
        arrayOfString = str1.split(",");
      }
      String str4 = "";
      TradePrivilege localTradePrivilege4;
      if (arrayOfString != null) {
        for (localTradePrivilege2 = 0; localTradePrivilege2 < arrayOfString.length; localTradePrivilege2++)
        {
          String str5 = arrayOfString[localTradePrivilege2].trim();
          localObject = getService().getListBySql("select * from m_firm where FirmId='" + str5 + "'");
          if ((localObject != null) && (((List)localObject).size() > 0))
          {
            localTradePrivilege4 = new TradePrivilege();
            localTradePrivilege4.setType(localTradePrivilege1.getType());
            localTradePrivilege4.setTypeID(str5);
            localTradePrivilege4.setKind(localTradePrivilege1.getKind());
            localTradePrivilege4.setKindID(localTradePrivilege1.getKindID());
            localTradePrivilege4.setPrivilegeCode_B(localTradePrivilege1.getPrivilegeCode_B());
            localTradePrivilege4.setPrivilegeCode_S(localTradePrivilege1.getPrivilegeCode_S());
            this.tradePrivilegeService.addTradePrivilege(localTradePrivilege4);
            addReturnValue(1, 119907L);
            writeOperateLog(1505, "交易商：" + localTradePrivilege4.getTypeID() + "，添加交易权限", 1, "添加交易商交易权限");
          }
          else
          {
            str4 = str4 + str5 + ",";
          }
        }
      }
      TradePrivilege localTradePrivilege2 = 0;
      TradePrivilege localTradePrivilege3 = 0;
      Object localObject = "";
      if ((str2 != null) && (!"".equals(str2)) && (str3 != null) && (!"".equals(str3)))
      {
        localTradePrivilege2 = Integer.parseInt(str2);
        localTradePrivilege3 = Integer.parseInt(str3) + 1;
        for (localTradePrivilege4 = localTradePrivilege2; localTradePrivilege4 < localTradePrivilege3; localTradePrivilege4++)
        {
          localObject = localTradePrivilege4 + "";
          List localList = getService().getListBySql("select * from m_firm where FirmId='" + (String)localObject + "'");
          if ((localList != null) && (localList.size() > 0))
          {
            TradePrivilege localTradePrivilege5 = new TradePrivilege();
            localTradePrivilege5.setType(localTradePrivilege1.getType());
            localTradePrivilege5.setTypeID((String)localObject);
            localTradePrivilege5.setKind(localTradePrivilege1.getKind());
            localTradePrivilege5.setKindID(localTradePrivilege1.getKindID());
            localTradePrivilege5.setPrivilegeCode_B(localTradePrivilege1.getPrivilegeCode_B());
            localTradePrivilege5.setPrivilegeCode_S(localTradePrivilege1.getPrivilegeCode_S());
            this.tradePrivilegeService.addTradePrivilege(localTradePrivilege5);
            addReturnValue(1, 119907L);
            writeOperateLog(1505, "交易商：" + localTradePrivilege5.getTypeID() + "，添加交易权限", 1, "添加交易商交易权限");
          }
          else
          {
            str4 = str4 + (String)localObject + ",";
          }
        }
      }
      if ((str4 != null) && (!"".equals(str4))) {
        addReturnValue(1, 151103L, new Object[] { "添加失败， 交易商 【" + str4 + "】 不存在" });
      }
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
      addReturnValue(-1, 119908L);
    }
    return "success";
  }
  
  public String batchSetClearFirmPrivilege()
    throws Exception
  {
    this.logger.debug("enter batchSetFirmPrivilege");
    String str1 = this.request.getParameter("typeID");
    String str2 = this.request.getParameter("startFirm");
    String str3 = this.request.getParameter("endFirm");
    TradePrivilege localTradePrivilege1 = (TradePrivilege)this.entity;
    try
    {
      String[] arrayOfString = null;
      if ((str1 != null) && (!"".equals(str1))) {
        arrayOfString = str1.split(",");
      }
      if (arrayOfString != null) {
        for (i = 0; i < arrayOfString.length; i++)
        {
          TradePrivilege localTradePrivilege2 = new TradePrivilege();
          localTradePrivilege2.setType(localTradePrivilege1.getType());
          localTradePrivilege2.setTypeID(arrayOfString[i].trim());
          localTradePrivilege2.setKind(localTradePrivilege1.getKind());
          localTradePrivilege2.setKindID(localTradePrivilege1.getKindID());
          localTradePrivilege2.setPrivilegeCode_B(localTradePrivilege1.getPrivilegeCode_B());
          localTradePrivilege2.setPrivilegeCode_S(localTradePrivilege1.getPrivilegeCode_S());
          this.tradePrivilegeService.deleteTradePrivilege(localTradePrivilege2);
          addReturnValue(1, 119907L);
          writeOperateLog(1505, "交易商：" + localTradePrivilege2.getTypeID() + "，删除交易权限", 1, "删除交易商交易权限");
        }
      }
      int i = 0;
      int j = 0;
      String str4 = "";
      if ((str2 != null) && (!"".equals(str2)) && (str3 != null) && (!"".equals(str3)))
      {
        i = Integer.parseInt(str2);
        j = Integer.parseInt(str3) + 1;
        for (int k = i; k < j; k++)
        {
          str4 = k + "";
          TradePrivilege localTradePrivilege3 = new TradePrivilege();
          localTradePrivilege3.setType(localTradePrivilege1.getType());
          localTradePrivilege3.setTypeID(str4);
          localTradePrivilege3.setKind(localTradePrivilege1.getKind());
          localTradePrivilege3.setKindID(localTradePrivilege1.getKindID());
          localTradePrivilege3.setPrivilegeCode_B(localTradePrivilege1.getPrivilegeCode_B());
          localTradePrivilege3.setPrivilegeCode_S(localTradePrivilege1.getPrivilegeCode_S());
          this.tradePrivilegeService.deleteTradePrivilege(localTradePrivilege3);
          addReturnValue(1, 119907L);
          writeOperateLog(1505, "交易商：" + localTradePrivilege3.getTypeID() + "，删除交易权限", 1, "删除交易商交易权限");
        }
      }
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
      addReturnValue(-1, 119908L);
    }
    return "success";
  }
  
  public String deleteCustomer()
    throws SecurityException, NoSuchFieldException
  {
    this.logger.debug("enter deleteCustomer");
    String[] arrayOfString = this.request.getParameterValues("ids");
    if ((arrayOfString == null) || (arrayOfString.length == 0)) {
      throw new IllegalArgumentException("删除主键数组不能为空！");
    }
    if (this.entity == null) {
      throw new IllegalArgumentException("业务对象为空，所以操作表未知，不允许通过主键数组批量删除！");
    }
    if ((this.entity.fetchPKey() == null) || (this.entity.fetchPKey().getKey() == null) || (this.entity.fetchPKey().getKey().length() == 0)) {
      throw new IllegalArgumentException("业务对象未设置主键，不允许通过主键数组批量删除！");
    }
    int i = 1;
    Object localObject1;
    if (arrayOfString != null)
    {
      localObject1 = "";
      for (String str1 : arrayOfString)
      {
        String str2 = str1.substring(str1.length() - 2, str1.length());
        if ("00".equals(str2)) {
          localObject1 = (String)localObject1 + str1 + " ";
        }
      }
      if (!((String)localObject1).equals(""))
      {
        addReturnValue(-1, 151103L, new Object[] { (String)localObject1 + "是默认客户，不能删除请重新选择！" });
        i = 0;
      }
    }
    if (i != 0)
    {
      localObject1 = this.entity.getClass().getDeclaredField(this.entity.fetchPKey().getKey()).getType();
      if (localObject1.equals(Long.class))
      {
        ??? = new Long[arrayOfString.length];
        for (??? = 0; ??? < arrayOfString.length; ???++) {
          ???[???] = Long.valueOf(arrayOfString[???]);
        }
      }
      else if (localObject1.equals(Integer.class))
      {
        ??? = new Integer[arrayOfString.length];
        for (??? = 0; ??? < arrayOfString.length; ???++) {
          ???[???] = Integer.valueOf(arrayOfString[???]);
        }
      }
      else
      {
        ??? = arrayOfString;
      }
      getService().deleteBYBulk(this.entity, (Object[])???);
      addReturnValue(1, 119903L);
    }
    return "success";
  }
  
  public String listCustomerPrivilege()
    throws Exception
  {
    this.logger.debug("enter listCustomerPrivilege");
    String str1 = this.request.getParameter("firmID");
    String str2 = this.request.getParameter("customerID");
    PageRequest localPageRequest = super.getPageRequest(this.request);
    if ((str2 != null) && (!"".equals(str2)))
    {
      List localList = this.tradePrivilegeService.getCustomerPrivilege(str2);
      Page localPage = new Page(localPageRequest.getPageNumber(), localPageRequest.getPageSize(), localList.size(), localList);
      this.request.setAttribute("pageInfo", localPage);
      this.request.setAttribute("customerID", str2);
      this.request.setAttribute("firmID", str1);
      this.request.setAttribute("FIRMPRIVILEGE_B", CommonDictionary.FIRMPRIVILEGE_B);
      this.request.setAttribute("FIRMPRIVILEGE_S", CommonDictionary.FIRMPRIVILEGE_S);
    }
    return "success";
  }
  
  public String listFirmPrivilege()
    throws Exception
  {
    this.logger.debug("enter listFirmPrivilege");
    String str = this.request.getParameter("firmID");
    PageRequest localPageRequest = super.getPageRequest(this.request);
    if ((str != null) && (!"".equals(str)))
    {
      List localList = this.tradePrivilegeService.getFirmPrivilege(str);
      Page localPage = new Page(localPageRequest.getPageNumber(), localPageRequest.getPageSize(), localList.size(), localList);
      this.request.setAttribute("pageInfo", localPage);
      this.request.setAttribute("firmID", str);
      this.request.setAttribute("FIRMPRIVILEGE_B", CommonDictionary.FIRMPRIVILEGE_B);
      this.request.setAttribute("FIRMPRIVILEGE_S", CommonDictionary.FIRMPRIVILEGE_S);
    }
    return "success";
  }
  
  public String fowardAddPrivilege()
  {
    this.logger.debug("enter addPrivilegeFoward");
    String str = this.request.getParameter("typeID");
    List localList1 = this.tradePrivilegeService.getBreed();
    List localList2 = this.tradePrivilegeService.getCommodity();
    this.request.setAttribute("typeID", str);
    this.request.setAttribute("breedList", localList1);
    this.request.setAttribute("commodityList", localList2);
    return "success";
  }
  
  public String viewPrivilege()
  {
    this.logger.debug("enter viewPrivilege");
    this.entity = getService().get(this.entity);
    List localList1 = this.tradePrivilegeService.getBreed();
    List localList2 = this.tradePrivilegeService.getCommodity();
    this.request.setAttribute("breedList", localList1);
    this.request.setAttribute("commodityList", localList2);
    return "success";
  }
  
  public String listTrader()
    throws Exception
  {
    this.logger.debug("enter listTrader");
    String str = this.request.getParameter("firmID");
    if ((str != null) && (!"".equals(str)))
    {
      PageRequest localPageRequest = super.getPageRequest(this.request);
      QueryConditions localQueryConditions = (QueryConditions)localPageRequest.getFilters();
      localQueryConditions.addCondition("firm.firmID", "=", str);
      listByLimit(localPageRequest);
      this.request.setAttribute("firmID", str);
    }
    return "success";
  }
  
  public String listTraderPrivilege()
    throws Exception
  {
    this.logger.debug("enter listTraderPrivilege");
    String str1 = this.request.getParameter("firmID");
    String str2 = this.request.getParameter("traderID");
    if ((str2 != null) && (!"".equals(str2)))
    {
      PageRequest localPageRequest = super.getPageRequest(this.request);
      List localList = this.tradePrivilegeService.getTraderPrivilege(str2);
      Page localPage = new Page(localPageRequest.getPageNumber(), localPageRequest.getPageSize(), localList.size(), localList);
      this.request.setAttribute("pageInfo", localPage);
      this.request.setAttribute("traderID", str2);
      this.request.setAttribute("firmID", str1);
      this.request.setAttribute("FIRMPRIVILEGE_B", CommonDictionary.FIRMPRIVILEGE_B);
      this.request.setAttribute("FIRMPRIVILEGE_S", CommonDictionary.FIRMPRIVILEGE_S);
    }
    return "success";
  }
  
  public String viewCode()
  {
    this.logger.debug("enter viewCode");
    String str1 = this.request.getParameter("firmID");
    String str2 = this.request.getParameter("traderID");
    List localList = this.tradePrivilegeService.getCodeNotChoose(str1, str2);
    String str3 = this.tradePrivilegeService.getOperateCode(str2);
    this.request.setAttribute("traderID", str2);
    this.request.setAttribute("firmID", str1);
    this.request.setAttribute("codeNotChoose", localList);
    this.request.setAttribute("operateCode", str3);
    return "success";
  }
  
  public String updateCode()
  {
    String str1 = this.request.getParameter("traderID");
    String str2 = this.request.getParameter("code");
    try
    {
      TTrader localTTrader1 = new TTrader();
      localTTrader1.setTraderID(str1);
      TTrader localTTrader2 = (TTrader)getService().get(localTTrader1);
      localTTrader1.setOperateCode(str2);
      localTTrader1.setModifyTime(getService().getSysDate());
      if (localTTrader2 != null) {
        getService().update(localTTrader1);
      } else {
        getService().add(localTTrader1);
      }
      addReturnValue(1, 119907L);
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
      addReturnValue(-1, 119908L);
    }
    return "success";
  }
  
  public Map<Integer, String> getFirm_statusMap()
  {
    return this.firm_statusMap;
  }
  
  public Map<Integer, String> getTradePrivilege_typeMap()
  {
    return this.tradePrivilege_typeMap;
  }
  
  public Map<Integer, String> getTradePrivilege_kindMap()
  {
    return this.tradePrivilege_kindMap;
  }
  
  public Map<Integer, String> getPrivilegeCode_BMap()
  {
    return this.privilegeCode_BMap;
  }
  
  public Map<Integer, String> getPrivilegeCode_SMap()
  {
    return this.privilegeCode_SMap;
  }
  
  public TradePrivilegeService getTradePrivilegeService()
  {
    return this.tradePrivilegeService;
  }
}
