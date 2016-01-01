package gnnt.MEBS.timebargain.mgr.action.settle;

import gnnt.MEBS.bill.core.service.IKernelService;
import gnnt.MEBS.common.mgr.action.EcsideAction;
import gnnt.MEBS.common.mgr.common.Page;
import gnnt.MEBS.common.mgr.common.PageRequest;
import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.model.User;
import gnnt.MEBS.common.mgr.service.StandardService;
import gnnt.MEBS.timebargain.mgr.model.settle.ApplyAheadSettle;
import gnnt.MEBS.timebargain.mgr.model.settle.SettleProps;
import gnnt.MEBS.timebargain.mgr.service.AheadSettleService;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

@Controller("aheadSettleAction")
@Scope("request")
public class AheadSettleAction
  extends EcsideAction
{
  private static final long serialVersionUID = 5131268112367465621L;
  @Autowired
  @Qualifier("billKernelService")
  private IKernelService kernelService;
  @Autowired
  @Qualifier("aheadSettleService")
  private AheadSettleService aheadSettleService;
  @Resource(name="Audit_statusMap")
  private Map<String, String> audit_statusMap;
  
  public IKernelService getKernelService()
  {
    return this.kernelService;
  }
  
  public void setKernelService(IKernelService paramIKernelService)
  {
    this.kernelService = paramIKernelService;
  }
  
  public AheadSettleService getAheadSettleService()
  {
    return this.aheadSettleService;
  }
  
  public void setAheadSettleService(AheadSettleService paramAheadSettleService)
  {
    this.aheadSettleService = paramAheadSettleService;
  }
  
  public Map<String, String> getAudit_statusMap()
  {
    return this.audit_statusMap;
  }
  
  public void setAudit_statusMap(Map<String, String> paramMap)
  {
    this.audit_statusMap = paramMap;
  }
  
  public String forwardAddAheadSettle()
    throws Exception
  {
    this.logger.debug("------------forwardAddAheadSettle 添加跳转--------------");
    String str = "select distinct(commodityid) commodityId from t_commodity order by commodityId";
    List localList1 = getService().getListBySql(str);
    List localList2 = this.aheadSettleService.getCustomerList();
    StringBuffer localStringBuffer = new StringBuffer("[");
    for (int i = 0; i < localList2.size(); i++)
    {
      localStringBuffer.append("\"");
      localStringBuffer.append(localList2.get(i));
      localStringBuffer.append("\",");
    }
    localStringBuffer.deleteCharAt(localStringBuffer.length() - 1);
    localStringBuffer.append("]");
    this.request.setAttribute("json", localStringBuffer.toString());
    this.request.setAttribute("list", localList1);
    this.request.setAttribute("size", Integer.valueOf(0));
    return forwardAdd();
  }
  
  public String getBillList()
    throws Exception
  {
    this.logger.debug("------------getBillList 查询仓单信息--------------");
    long l = 0L;
    List localList1 = null;
    Page localPage = null;
    String str1 = this.request.getParameter("entity.commodityId");
    String str2 = this.request.getParameter("entity.customerId_S");
    String str3 = this.request.getParameter("entity.price");
    String str4 = this.request.getParameter("entity.customerId_B");
    String str5 = this.request.getParameter("entity.remark1");
    String str6 = this.request.getParameter("entity.quantity");
    double d1 = 0.0D;
    if (str6 != null) {
      d1 = Double.parseDouble(str6);
    }
    String str7 = this.request.getParameter("priceType");
    List localList2 = getService().getListBySql("select firmId from t_customer where customerId ='" + str2 + "'");
    String str8 = "";
    double d2 = 0.0D;
    if ((localList2 != null) && (localList2.size() > 0))
    {
      str8 = ((Map)localList2.get(0)).get("FIRMID").toString();
      List localList3 = getService().getListBySql("select * from t_commodity where commodityID = '" + str1 + "'");
      if ((localList3 != null) && (localList3.size() > 0))
      {
        l = Long.parseLong(((Map)localList3.get(0)).get("BREEDID").toString());
        d2 = Double.parseDouble(((Map)localList3.get(0)).get("CONTRACTFACTOR").toString());
        str9 = "select * from T_settleProps  where commodityId = '" + str1 + "'";
        localList4 = getService().getListBySql(str9, this.entity);
        localObject1 = new HashMap();
        localObject2 = null;
        Object localObject3 = localList4.iterator();
        while (((Iterator)localObject3).hasNext())
        {
          StandardModel localStandardModel = (StandardModel)((Iterator)localObject3).next();
          localObject2 = (SettleProps)localStandardModel;
          ((Map)localObject1).put(((SettleProps)localObject2).getPropertyName(), ((SettleProps)localObject2).getPropertyValue());
        }
        localObject3 = null;
        try
        {
          localObject3 = this.kernelService.getUnusedStocks(l, (Map)localObject1, str8, d1 * d2);
        }
        catch (Exception localException)
        {
          localException.printStackTrace();
        }
        if ((localObject3 != null) && (((List)localObject3).size() > 0))
        {
          String str10 = StringUtils.join((Collection)localObject3, ',');
          String str11 = "select bs.stockid stockid,bs.warehouseid warehouseid,tc.breedname breedname,bs.quantity quantity,bs.unit unit,round(bs.quantity / tc.contractfactor,2) stockNum,bs.lasttime lasttime from BI_Stock bs,(select t.BreedID BreedID, t.ContractFactor ContractFactor,e.breedname breedname from t_commodity t, m_breed e  where t.breedId = e.breedId and t.commodityID = '" + str1 + "') tc " + "where tc.breedId = bs.breedId and stockid in (" + str10 + ") order by to_number(stockid)";
          localList1 = getService().getListBySql(str11);
          if ((localList1 != null) && (localList1.size() > 0)) {
            localPage = new Page(1, localList1.size(), localList1.size(), localList1);
          }
        }
        else
        {
          this.request.setAttribute("result", "无任何信息！");
        }
      }
      else
      {
        this.request.setAttribute("result", "商品代码不存在！");
      }
    }
    else
    {
      this.request.setAttribute("result", "客户代码不存在！");
    }
    int i = 0;
    if (localList1 != null) {
      i = localList1.size();
    }
    String str9 = "select distinct(commodityid) commodityId from t_commodity order by commodityId";
    List localList4 = getService().getListBySql(str9);
    this.request.setAttribute("list", localList4);
    Object localObject1 = this.aheadSettleService.getCustomerList();
    Object localObject2 = new StringBuffer("[");
    for (int j = 0; j < ((List)localObject1).size(); j++)
    {
      ((StringBuffer)localObject2).append("\"");
      ((StringBuffer)localObject2).append(((List)localObject1).get(j));
      ((StringBuffer)localObject2).append("\",");
    }
    ((StringBuffer)localObject2).deleteCharAt(((StringBuffer)localObject2).length() - 1);
    ((StringBuffer)localObject2).append("]");
    this.request.setAttribute("json", ((StringBuffer)localObject2).toString());
    this.request.setAttribute("pageInfo", localPage);
    this.request.setAttribute("size", Integer.valueOf(i));
    this.request.setAttribute("priceType", str7);
    this.request.setAttribute("commodityId", str1);
    this.request.setAttribute("customerId_S", str2);
    this.request.setAttribute("quantity", str6);
    this.request.setAttribute("customerId_B", str4);
    this.request.setAttribute("price", str3);
    this.request.setAttribute("remark1", str5);
    return "success";
  }
  
  public String addTransfer()
    throws Exception
  {
    this.logger.debug("------------addTransfer 添加提前交收信息--------------");
    int i = -1;
    List localList1 = getService().getListBySql("select status from t_systemstatus");
    String str1 = ((Map)localList1.get(0)).get("STATUS").toString();
    if (str1.equals("1"))
    {
      String str2 = this.request.getParameter("ids");
      str2 = str2.substring(0, str2.length() - 1);
      String[] arrayOfString = str2.split(",");
      String str3 = ((User)this.request.getSession().getAttribute("CurrentUser")).getUserId();
      ApplyAheadSettle localApplyAheadSettle = (ApplyAheadSettle)this.entity;
      localApplyAheadSettle.setStatus(Integer.valueOf(1));
      localApplyAheadSettle.setCreateTime(new Date());
      localApplyAheadSettle.setCreator(str3);
      List localList2 = getService().getListBySql("select firmId from t_customer where customerId ='" + localApplyAheadSettle.getCustomerId_S() + "'");
      String str4 = "";
      if ((localList2 != null) && (localList2.size() > 0)) {
        str4 = ((Map)localList2.get(0)).get("FIRMID").toString();
      }
      List localList3 = getService().getListBySql("select firmId from t_customer where customerId ='" + localApplyAheadSettle.getCustomerId_B() + "'");
      String str5 = "";
      if ((localList3 != null) && (localList3.size() > 0))
      {
        str5 = ((Map)localList3.get(0)).get("FIRMID").toString();
        i = this.aheadSettleService.addApplyAheadSettle(arrayOfString, localApplyAheadSettle, str5, str4);
      }
      else
      {
        i = -3;
      }
    }
    else
    {
      i = -4;
    }
    if (i == 0)
    {
      addReturnValue(1, 119901L);
      return "success";
    }
    if (i == -2)
    {
      this.request.setAttribute("result", "冻结仓单失败！");
      return "error";
    }
    if (i == -3)
    {
      this.request.setAttribute("result", "买方二级代码不存在！");
      return "error";
    }
    if (i == -4)
    {
      this.request.setAttribute("result", "申请必须在闭式状态下操作");
      return "error";
    }
    if (i == -5)
    {
      this.request.setAttribute("result", "买方可用持仓不足");
      return "error";
    }
    if (i == -6)
    {
      this.request.setAttribute("result", "卖方可用持仓不足");
      return "error";
    }
    this.request.setAttribute("result", "操作失败！");
    return "error";
  }
  
  public String getBillListByApplyId()
    throws Exception
  {
    this.logger.debug("------------getBillListByApplyId 根据提前交收申请号查询所冻结的仓单--------------");
    ApplyAheadSettle localApplyAheadSettle = (ApplyAheadSettle)this.entity;
    String str = "select bs.stockid stockid,bs.warehouseid warehouseid,mb.breedname breedname,bs.quantity quantity,bs.unit unit,bs.lasttime lasttime from BI_Stock bs,m_breed mb where mb.breedid = bs.breedId and stockid in (select billId from T_billFrozen where Operation = '" + localApplyAheadSettle.getApplyId() + "') order by to_number(stockid)";
    List localList = getService().getListBySql(str);
    PageRequest localPageRequest = super.getPageRequest(this.request);
    Page localPage = new Page(localPageRequest.getPageNumber(), localPageRequest.getPageSize(), localList.size(), localList);
    this.request.setAttribute("applyId", localApplyAheadSettle.getApplyId());
    this.request.setAttribute("pageInfo", localPage);
    return "success";
  }
  
  public String viewByApplyId()
    throws Exception
  {
    this.logger.debug("------------viewByApplyId 提前交收审核跳转--------------");
    this.entity = getService().get(this.entity);
    ApplyAheadSettle localApplyAheadSettle = (ApplyAheadSettle)this.entity;
    String str = "select * from BI_Stock where stockid in (select billId from T_billFrozen where Operation = '" + localApplyAheadSettle.getApplyId() + "')";
    List localList = getService().getListBySql(str);
    this.request.setAttribute("list", localList);
    return "success";
  }
  
  public String aheadSettleAuditPass()
    throws Exception
  {
    this.logger.debug("------------aheadSettleAudit 提前交收信息审核通过--------------");
    int i = 0;
    ApplyAheadSettle localApplyAheadSettle1 = (ApplyAheadSettle)this.entity;
    ApplyAheadSettle localApplyAheadSettle2 = (ApplyAheadSettle)getService().get(localApplyAheadSettle1).clone();
    if (localApplyAheadSettle2.getStatus().intValue() == 1)
    {
      String str1 = ((User)this.request.getSession().getAttribute("CurrentUser")).getUserId();
      String str2 = localApplyAheadSettle1.getRemark2();
      localApplyAheadSettle2.setStatus(Integer.valueOf(2));
      localApplyAheadSettle2.setModifier(str1);
      localApplyAheadSettle2.setRemark2(str2);
      localApplyAheadSettle2.setModifyTime(new Date());
      i = this.aheadSettleService.auditApplyAheadSettlePass(localApplyAheadSettle2);
    }
    else
    {
      i = -5;
    }
    if (i == 1)
    {
      addReturnValue(1, 119907L);
      return "success";
    }
    if (i == 2)
    {
      this.request.setAttribute("result", "已处理过！");
      return "error";
    }
    if (i == -1)
    {
      this.request.setAttribute("result", "可交收买持仓数量不足！");
      return "error";
    }
    if (i == -2)
    {
      this.request.setAttribute("result", "可交收买抵顶数量不足！");
      return "error";
    }
    if (i == -3)
    {
      this.request.setAttribute("result", "交收买持仓数量大于可交收买持仓数量！");
      return "error";
    }
    if (i == -4)
    {
      this.request.setAttribute("result", "交收买抵顶数量大于可买抵顶数量！");
      return "error";
    }
    if (i == -11)
    {
      this.request.setAttribute("result", "可交收卖持仓数量不足！");
      return "error";
    }
    if (i == -12)
    {
      this.request.setAttribute("result", "可交收卖抵顶数量不足！");
      return "error";
    }
    if (i == -13)
    {
      this.request.setAttribute("result", "交收卖持仓数量大于可交收卖持仓数量！");
      return "error";
    }
    if (i == -14)
    {
      this.request.setAttribute("result", "交收卖抵顶数量大于可卖抵顶数量！");
      return "error";
    }
    if (i == -100)
    {
      this.request.setAttribute("result", "其它错误！");
      return "error";
    }
    if (i == -5)
    {
      this.request.setAttribute("result", "状态已变更，审核失败！");
      return "error";
    }
    if (i == -6)
    {
      this.request.setAttribute("result", "解冻仓单失败！");
      return "error";
    }
    this.request.setAttribute("result", "操作失败！");
    return "error";
  }
  
  public String aheadSettleAuditFail()
    throws Exception
  {
    this.logger.debug("------------aheadSettleAudit 提前交收信息审核不通过--------------");
    int i = 0;
    ApplyAheadSettle localApplyAheadSettle1 = (ApplyAheadSettle)this.entity;
    ApplyAheadSettle localApplyAheadSettle2 = (ApplyAheadSettle)getService().get(localApplyAheadSettle1);
    if (localApplyAheadSettle2.getStatus().intValue() == 1)
    {
      String str1 = ((User)this.request.getSession().getAttribute("CurrentUser")).getUserId();
      String str2 = localApplyAheadSettle1.getRemark2();
      localApplyAheadSettle2.setStatus(Integer.valueOf(3));
      localApplyAheadSettle2.setModifier(str1);
      localApplyAheadSettle2.setRemark2(str2);
      localApplyAheadSettle2.setModifyTime(new Date());
      i = this.aheadSettleService.auditApplyAheadSettleFail(localApplyAheadSettle2);
    }
    else
    {
      i = -5;
    }
    if (i == 1)
    {
      addReturnValue(1, 119907L);
      return "success";
    }
    if (i == 2)
    {
      this.request.setAttribute("result", "已处理过！");
      return "error";
    }
    if (i == -1)
    {
      this.request.setAttribute("result", "可交收买持仓数量不足！");
      return "error";
    }
    if (i == -2)
    {
      this.request.setAttribute("result", "可交收买抵顶数量不足！");
      return "error";
    }
    if (i == -3)
    {
      this.request.setAttribute("result", "交收买持仓数量大于可交收买持仓数量！");
      return "error";
    }
    if (i == -4)
    {
      this.request.setAttribute("result", "交收买抵顶数量大于可买抵顶数量！");
      return "error";
    }
    if (i == -11)
    {
      this.request.setAttribute("result", "可交收卖持仓数量不足！");
      return "error";
    }
    if (i == -12)
    {
      this.request.setAttribute("result", "可交收卖抵顶数量不足！");
      return "error";
    }
    if (i == -13)
    {
      this.request.setAttribute("result", "交收卖持仓数量大于可交收卖持仓数量！");
      return "error";
    }
    if (i == -14)
    {
      this.request.setAttribute("result", "交收卖抵顶数量大于可卖抵顶数量！");
      return "error";
    }
    if (i == -100)
    {
      this.request.setAttribute("result", "其它错误！");
      return "error";
    }
    if (i == -5)
    {
      this.request.setAttribute("result", "状态已变更，审核失败！");
      return "error";
    }
    if (i == -6)
    {
      this.request.setAttribute("result", "解冻仓单失败！");
      return "error";
    }
    this.request.setAttribute("result", "操作失败！");
    return "error";
  }
}
