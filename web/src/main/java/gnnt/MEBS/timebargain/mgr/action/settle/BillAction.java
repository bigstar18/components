package gnnt.MEBS.timebargain.mgr.action.settle;

import gnnt.MEBS.bill.core.service.IKernelService;
import gnnt.MEBS.common.mgr.common.Page;
import gnnt.MEBS.common.mgr.common.PageRequest;
import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.service.StandardService;
import gnnt.MEBS.common.mgr.statictools.Tools;
import gnnt.MEBS.timebargain.mgr.action.ECSideAction;
import gnnt.MEBS.timebargain.mgr.model.settle.BillFrozen;
import gnnt.MEBS.timebargain.mgr.model.settle.SettleProps;
import gnnt.MEBS.timebargain.mgr.service.BillService;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.ecside.core.ECSideContext;
import org.ecside.util.RequestUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

@Controller
@Scope("request")
public class BillAction
  extends ECSideAction
{
  private static final long serialVersionUID = -7848335526358113367L;
  private List<?> cmdtySortList;
  @Autowired
  @Qualifier("billService")
  private BillService billService;
  @Autowired
  @Qualifier("billKernelService")
  private IKernelService kernelService;
  @Resource(name="BS_flagMap")
  Map<String, String> bs_flagMap;
  @Resource(name="settleMatch_settleTypeMap")
  Map<String, String> settleTypeMap;
  
  public List<?> getCmdtySortList()
  {
    return this.cmdtySortList;
  }
  
  public void setCmdtySortList(List<?> paramList)
  {
    this.cmdtySortList = paramList;
  }
  
  public static long getSerialversionuid()
  {
    return -7848335526358113367L;
  }
  
  public Map<String, String> getSettleTypeMap()
  {
    return this.settleTypeMap;
  }
  
  public void setSettleTypeMap(Map<String, String> paramMap)
  {
    this.settleTypeMap = paramMap;
  }
  
  public Map<String, String> getBs_flagMap()
  {
    return this.bs_flagMap;
  }
  
  public void setBs_flagMap(Map<String, String> paramMap)
  {
    this.bs_flagMap = paramMap;
  }
  
  public IKernelService getKernelService()
  {
    return this.kernelService;
  }
  
  public void setKernelService(IKernelService paramIKernelService)
  {
    this.kernelService = paramIKernelService;
  }
  
  public BillService getBillService()
  {
    return this.billService;
  }
  
  public void setBillService(BillService paramBillService)
  {
    this.billService = paramBillService;
  }
  
  public String gageBillList()
    throws Exception
  {
    this.logger.debug("------------gageBillList 跳转到仓单列表--------------");
    PageRequest localPageRequest = super.getPageRequest(this.request);
    int i = RequestUtils.getPageNo(this.request);
    if (i <= 0) {
      i = 1;
    }
    localPageRequest.setPageNumber(i);
    int j = RequestUtils.getCurrentRowsDisplayed(this.request);
    if (j <= 0) {
      j = ECSideContext.DEFAULT_PAGE_SIZE;
    }
    localPageRequest.setPageSize(j);
    String str1 = trim(this.request.getParameter("gnnt_gageBill.commodityID"));
    String str2 = trim(this.request.getParameter("gnnt_gageBill.firmId"));
    String str3 = "SELECT e.id, e.firmID, e.commodityId, e.quantity, e.remark, e.createtime, e.modifytime FROM T_E_GageBill e where 1=1";
    if ((!"".equals(str1)) && (str1 != null)) {
      str3 = str3 + " AND e.commodityId like '%" + str1 + "%'";
    }
    if ((!"".equals(str2)) && (str2 != null)) {
      str3 = str3 + " AND e.firmId like '%" + str2 + "%'";
    }
    List localList = getService().getListBySql(str3);
    Object localObject = localList.iterator();
    while (((Iterator)localObject).hasNext())
    {
      Map localMap = (Map)((Iterator)localObject).next();
      String str4 = String.valueOf(localMap.get("REMARK"));
      if ((str4 != null) && (str4.length() > 16))
      {
        str4 = str4.substring(0, 15);
        str4 = str4 + "…";
        localMap.put("REMARK", str4);
      }
    }
    localObject = new Page(localPageRequest.getPageNumber(), localPageRequest.getPageSize(), localList.size(), localList);
    this.request.setAttribute("pageInfo", localObject);
    this.request.setAttribute("oldParams", getParametersStartingWith(this.request, "gnnt_"));
    return "success";
  }
  
  public String getCommodity()
    throws Exception
  {
    this.logger.debug("------------getCommodity 跳转到仓单添加仓单详细列表页面--------------");
    List localList1 = getService().getListBySql("select commodityId,name from t_commodity ");
    this.request.setAttribute("list", localList1);
    List localList2 = this.billService.getFirmList();
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
    return "success";
  }
  
  public String getBillList()
    throws Exception
  {
    this.logger.debug("---------------根据交易商代码和商品代码查询仓单详细信息 开始------------");
    List localList1 = getService().getListBySql("select commodityId,name from t_commodity ");
    this.request.setAttribute("list", localList1);
    List localList2 = this.billService.getFirmList();
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
    String str1 = this.request.getParameter("gnnt_stock.commodityID");
    String str2 = trim(this.request.getParameter("gnnt_stock.firmID"));
    if (!localList2.contains(str2))
    {
      this.request.setAttribute("oldParams", getParametersStartingWith(this.request, "gnnt_"));
      this.request.setAttribute("firmMsg", "交易商代码不存在！");
      return "success";
    }
    if ((str1 == null) || ("".equals(str1)) || (str2 == null) || ("".equals(str2)))
    {
      this.logger.debug("---------------根据交易商代码和商品代码查询仓单详细信息 结束(交易商代码或者商品代码为空)------------");
      return "success";
    }
    String str3 = "SELECT s.* FROM T_settleProps s WHERE s.CommodityID = '" + str1 + "'";
    List localList3 = getService().getListBySql(str3, this.entity);
    this.logger.debug("根据商品代码查询商品属性信息 成功");
    HashMap localHashMap = new HashMap();
    SettleProps localSettleProps = null;
    Object localObject1 = localList3.iterator();
    while (((Iterator)localObject1).hasNext())
    {
      localObject2 = (StandardModel)((Iterator)localObject1).next();
      localSettleProps = (SettleProps)localObject2;
      localHashMap.put(localSettleProps.getPropertyName(), localSettleProps.getPropertyValue());
    }
    localObject1 = getService().getListBySql("select BreedID, ContractFactor from t_commodity where commodityID = '" + str1 + "'");
    Object localObject2 = String.valueOf(((Map)((List)localObject1).get(0)).get("BREEDID"));
    BigDecimal localBigDecimal = (BigDecimal)((Map)((List)localObject1).get(0)).get("CONTRACTFACTOR");
    List localList4 = null;
    localList4 = this.kernelService.getUnusedStocks(Long.valueOf((String)localObject2).longValue(), localHashMap, str2);
    this.logger.debug("******调用rmi获取仓单编号集合 成功******");
    writeOperateLog(1508, "通过RMI获取仓单编号集合", 1, "");
    if ((localList4 == null) || (localList4.size() == 0))
    {
      this.request.setAttribute("oldParams", getParametersStartingWith(this.request, "gnnt_"));
      this.logger.debug("---------------根据交易商代码和商品代码查询仓单详细信息 结束(回仓单号数组长度为0)------------");
      return "success";
    }
    Page localPage = getBillDetail(localList4, localBigDecimal);
    this.request.setAttribute("pageInfo", localPage);
    this.request.setAttribute("oldParams", getParametersStartingWith(this.request, "gnnt_"));
    this.logger.debug("---------------根据交易商代码和商品代码查询仓单详细信息 结束------------");
    return "success";
  }
  
  private Page<Map<Object, Object>> getBillDetail(List<String> paramList, BigDecimal paramBigDecimal)
    throws Exception
  {
    PageRequest localPageRequest = super.getPageRequest(this.request);
    int i = RequestUtils.getPageNo(this.request);
    if (i <= 0) {
      i = 1;
    }
    localPageRequest.setPageNumber(i);
    int j = RequestUtils.getCurrentRowsDisplayed(this.request);
    if (j <= 0) {
      j = ECSideContext.DEFAULT_PAGE_SIZE;
    }
    localPageRequest.setPageSize(j);
    String str1 = "select bs.stockid, bs.realstockcode, bs.breedid, bs.warehouseid, bs.quantity, bs.unit, bs.ownerfirm, to_char(bs.lasttime,'yyyy-MM-dd HH24:MI:SS') lasttime, bs.createtime, bs.stockstatus from BI_Stock bs where bs.stockid in (" + StringUtils.join(paramList, ',') + ")";
    List localList = getService().getListBySql(str1);
    String str2 = "";
    if (localList.size() != 0)
    {
      localObject = getService().getListBySql("select BreedName from M_Breed where BreedID = " + ((Map)localList.get(0)).get("BREEDID"));
      if (((List)localObject).size() != 0) {
        str2 = String.valueOf(((Map)((List)localObject).get(0)).get("BREEDNAME"));
      } else {
        str2 = String.valueOf(((Map)localList.get(0)).get("BREEDID"));
      }
    }
    Object localObject = localList.iterator();
    while (((Iterator)localObject).hasNext())
    {
      Map localMap = (Map)((Iterator)localObject).next();
      localMap.put("QUANTITYUNIT", localMap.get("QUANTITY") + "(" + String.valueOf(localMap.get("UNIT")) + ")");
      localMap.put("BREEDNAME", str2);
      BigDecimal localBigDecimal = (BigDecimal)localMap.get("QUANTITY");
      if (paramBigDecimal != null)
      {
        double d = localBigDecimal.doubleValue() / paramBigDecimal.doubleValue();
        if (Math.round(d) != d)
        {
          String str3 = String.valueOf(d);
          int k = str3.indexOf(".");
          if (str3.substring(k + 1).length() >= 4) {
            str3 = str3.substring(0, k + 4);
          }
          localMap.put("BILLNUM", str3);
        }
        else
        {
          localMap.put("BILLNUM", Long.valueOf(d));
        }
      }
    }
    localObject = new Page(localPageRequest.getPageNumber(), localPageRequest.getPageSize(), localList.size(), localList);
    return (Page<Map<Object, Object>>)localObject;
  }
  
  public String addGageBill()
    throws Exception
  {
    this.logger.debug("------------addBill 添加仓单--------------");
    try
    {
      String[] arrayOfString = this.request.getParameterValues("ids");
      if ((arrayOfString == null) || (arrayOfString.length == 0)) {
        throw new IllegalArgumentException("添加仓单，仓单不能为空!");
      }
      String str1 = this.request.getParameter("commodityID");
      String str2 = this.request.getParameter("remarkHdden");
      int i = this.billService.addBill(arrayOfString, str1, str2);
      if (i == 1)
      {
        addReturnValue(1, 150809L);
        writeOperateLog(1508, "添加仓单成功", 1, "");
      }
      else if (i == -1)
      {
        addReturnValue(1, 150825L);
        writeOperateLog(1508, "添加仓单失败", 0, "所选仓单数量出现小数");
      }
    }
    catch (Exception localException)
    {
      this.logger.debug("添加仓单 出错：" + localException.getMessage());
      localException.printStackTrace();
      addReturnValue(-1, 150816L, new Object[] { "操作失败，原因：" + localException.getMessage() });
      writeOperateLog(1508, "添加仓单失败", 0, "操作失败，原因：" + localException.getMessage());
    }
    return "success";
  }
  
  public String gageBillDetail()
    throws Exception
  {
    this.logger.debug("-------------------仓单详情---------------");
    String str1 = this.request.getParameter("gageBillID");
    String str2 = this.request.getParameter("commodityID");
    List localList1 = getService().getListBySql("select BreedID, ContractFactor from t_commodity where commodityID = '" + str2 + "'");
    BigDecimal localBigDecimal = (BigDecimal)((Map)localList1.get(0)).get("CONTRACTFACTOR");
    List localList2 = getService().getListBySql("select * from T_billFrozen  where operation = '" + str1 + "'", this.entity);
    ArrayList localArrayList = new ArrayList(localList2.size());
    if ((localList2 != null) && (localList2.size() != 0))
    {
      for (int i = 0; i < localList2.size(); i++) {
        localArrayList.add(i, ((BillFrozen)localList2.get(i)).getBillID());
      }
      List localList3 = getService().getListBySql("select remark from T_E_GageBill where id = '" + str1 + "'");
      Page localPage = getBillDetail(localArrayList, localBigDecimal);
      this.request.setAttribute("remark", localList3);
      this.request.setAttribute("gageBillID", str1);
      this.request.setAttribute("pageInfo", localPage);
    }
    this.request.setAttribute("oldParams", getParametersStartingWith(this.request, "gnnt_"));
    return "success";
  }
  
  public String queryBillList()
    throws Exception
  {
    this.logger.debug("------------ 跳转到仓单撤销列表-------------");
    List localList1 = getService().getListBySql("select commodityId,name from t_commodity ");
    this.request.setAttribute("list", localList1);
    List localList2 = this.billService.getFirmList();
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
    String str1 = this.request.getParameter("gnnt_stock.commodityID");
    String str2 = trim(this.request.getParameter("gnnt_stock.firmID"));
    String str3 = trim(this.request.getParameter("gnnt_stock.billID"));
    String str4 = "select e.id, b.id as billFrozenId, e.firmID, e.commodityId, e.quantity, e.remark, to_char(e.createtime,'yyyy-MM-dd HH24:MI:SS') createtime, e.modifytime, b.BillID, b.Operation from T_billFrozen b , T_E_GageBill e where 1=1 AND b.operationtype = 0 AND b.Operation = e.id ";
    if ((str3 != null) && (!"".equals(str3))) {
      str4 = str4 + " AND b.BillID = '" + str3 + "'";
    }
    if ((str2 != null) && (!"".equals(str2))) {
      str4 = str4 + " AND e.firmID like '%" + str2 + "%'";
    }
    if ((str1 != null) && (!"".equals(str1))) {
      str4 = str4 + " AND e.commodityId = '" + str1 + "'";
    }
    str4 = str4 + " order by e.createtime";
    List localList3 = getService().getListBySql(str4);
    if ((localList3 == null) || (localList3.size() == 0))
    {
      this.request.setAttribute("oldParams", getParametersStartingWith(this.request, "gnnt_"));
      return "success";
    }
    ArrayList localArrayList = new ArrayList();
    for (int j = 0; j < localList3.size(); j++)
    {
      localObject1 = (Map)localList3.get(j);
      localArrayList.add(String.valueOf(((Map)localObject1).get("BILLID")));
    }
    String str5 = "select bs.stockid, bs.quantity, bs.unit from BI_Stock bs where bs.stockid in (" + StringUtils.join(localArrayList, ',') + ")";
    Object localObject1 = getService().getListBySql(str5);
    HashMap localHashMap = new HashMap();
    Iterator localIterator = ((List)localObject1).iterator();
    Map localMap;
    Object localObject2;
    while (localIterator.hasNext())
    {
      localMap = (Map)localIterator.next();
      localObject2 = (BigDecimal)localMap.get("QUANTITY");
      localHashMap.put(String.valueOf(localMap.get("STOCKID")), localObject2);
    }
    for (int k = 0; k < localList3.size(); k++)
    {
      localMap = (Map)localList3.get(k);
      localObject2 = (String)localMap.get("COMMODITYID");
      localObject3 = getService().getListBySql("select Name, ContractFactor from t_commodity where commodityID = '" + (String)localObject2 + "'");
      BigDecimal localBigDecimal = (BigDecimal)((Map)((List)localObject3).get(0)).get("CONTRACTFACTOR");
      localMap.put("COMMODITYNAME", ((Map)((List)localObject3).get(0)).get("NAME"));
      localMap.put("BILLNUM", Long.valueOf((((BigDecimal)localHashMap.get(localMap.get("BILLID"))).doubleValue() / localBigDecimal.doubleValue())));
    }
    PageRequest localPageRequest = super.getPageRequest(this.request);
    int m = RequestUtils.getPageNo(this.request);
    if (m <= 0) {
      m = 1;
    }
    localPageRequest.setPageNumber(m);
    int n = RequestUtils.getCurrentRowsDisplayed(this.request);
    if (n <= 0) {
      n = ECSideContext.DEFAULT_PAGE_SIZE;
    }
    localPageRequest.setPageSize(n);
    Object localObject3 = new Page(localPageRequest.getPageNumber(), localPageRequest.getPageSize(), localList3.size(), localList3);
    this.request.setAttribute("pageInfo", localObject3);
    this.request.setAttribute("oldParams", getParametersStartingWith(this.request, "gnnt_"));
    return "success";
  }
  
  public String billCancel()
    throws Exception
  {
    this.logger.debug("------------仓单撤销---------------");
    ArrayList localArrayList1 = new ArrayList();
    ArrayList localArrayList2 = new ArrayList();
    ArrayList localArrayList3 = new ArrayList();
    try
    {
      String[] arrayOfString1 = this.request.getParameterValues("ids");
      for (int i = 0; i < arrayOfString1.length; i++)
      {
        String[] arrayOfString2 = arrayOfString1[i].split("&");
        String str2 = arrayOfString2[0];
        Long localLong1 = Long.valueOf(arrayOfString2[1]);
        String str3 = arrayOfString2[2];
        String str4 = arrayOfString2[3];
        Long localLong2 = Long.valueOf(arrayOfString2[4]);
        Long localLong3 = Long.valueOf(arrayOfString2[5]);
        this.logger.debug("待撤销仓单：仓单号【" + str2 + "】仓单数量【" + localLong1 + "】商品id【" + str4 + "】交易商id【" + str3 + "】操作码【" + localLong2 + "】id【" + localLong3 + "】");
        Long localLong4 = this.billService.billCancel(str2, str3, localLong1, str4, localLong2, localLong3);
        if (localLong4.longValue() == 1L) {
          localArrayList1.add(str2);
        }
        if (localLong4.longValue() == -1L) {
          localArrayList2.add(str2);
        }
        if (localLong4.longValue() == -2L) {
          localArrayList3.add(str2);
        }
      }
      String str1 = "";
      if (!localArrayList3.isEmpty())
      {
        str1 = str1 + localArrayList3.toString() + "失败,撤销后仓单将出现负数！\\n";
        writeOperateLog(1508, "撤销仓单" + localArrayList3.toString() + "】失败,撤销后仓单将出现负数！", 0, "撤销后仓单将出现负数");
      }
      if (!localArrayList2.isEmpty())
      {
        str1 = str1 + localArrayList2.toString() + "失败,可用仓单数量不足！\\n";
        writeOperateLog(1508, "撤销仓单【" + localArrayList2.toString() + "】失败,可用仓单数量不足！", 0, "可用仓单数量不足");
      }
      if (!localArrayList1.isEmpty())
      {
        str1 = str1 + localArrayList1.toString() + "撤销成功！";
        writeOperateLog(1508, "撤销仓单【" + localArrayList1.toString() + "】成功", 1, "");
      }
      addReturnValue(-1, 150806L, new Object[] { str1 });
    }
    catch (Exception localException)
    {
      this.logger.debug("仓单撤销 出错：" + localException.getMessage());
      localException.printStackTrace();
      addReturnValue(-1, 150808L, new Object[] { "操作失败，原因：" + localException.getMessage() });
      writeOperateLog(1508, "撤销仓单失败", 0, "操作失败，原因：" + localException.getMessage());
    }
    return "success";
  }
  
  public String gageDataQuery()
    throws Exception
  {
    this.logger.debug("------------抵顶数据查询---------------");
    PageRequest localPageRequest = super.getPageRequest(this.request);
    int i = RequestUtils.getPageNo(this.request);
    if (i <= 0) {
      i = 1;
    }
    localPageRequest.setPageNumber(i);
    int j = RequestUtils.getCurrentRowsDisplayed(this.request);
    if (j <= 0) {
      j = ECSideContext.DEFAULT_PAGE_SIZE;
    }
    localPageRequest.setPageSize(j);
    String str1 = trim(this.request.getParameter("gnnt_gageBill.commodityID"));
    String str2 = trim(this.request.getParameter("gnnt_gageBill.firmId"));
    String str3 = "select t.firmid,t.customerid,t.commodityid,t.bs_flag flag,(t.HoldQty + t.GageQty) HoldQty,t.gageqty  from t_customerholdsum t where t.BS_Flag=2 and t.GageQty > 0";
    if ((!"".equals(str1)) && (str1 != null)) {
      str3 = str3 + " AND t.commodityId like '%" + str1 + "%'";
    }
    if ((!"".equals(str2)) && (str2 != null)) {
      str3 = str3 + " AND t.firmId like '%" + str2 + "%'";
    }
    List localList = getService().getListBySql(str3);
    Page localPage = new Page(localPageRequest.getPageNumber(), localPageRequest.getPageSize(), localList.size(), localList);
    this.request.setAttribute("pageInfo", localPage);
    this.request.setAttribute("oldParams", getParametersStartingWith(this.request, "gnnt_"));
    return "success";
  }
  
  public String showSettleData()
  {
    return "success";
  }
  
  public String listSettleDataDetail()
    throws Exception
  {
    this.logger.debug("------------交收数据明细查询---------------");
    PageRequest localPageRequest = super.getPageRequest(this.request);
    int i = RequestUtils.getPageNo(this.request);
    if (i <= 0) {
      i = 1;
    }
    localPageRequest.setPageNumber(i);
    int j = RequestUtils.getCurrentRowsDisplayed(this.request);
    if (j <= 0) {
      j = ECSideContext.DEFAULT_PAGE_SIZE;
    }
    localPageRequest.setPageSize(j);
    String str1 = trim(this.request.getParameter("gnnt_gageBill.commodityID"));
    String str2 = trim(this.request.getParameter("gnnt_gageBill.firmId"));
    String str3 = this.request.getParameter("gnnt_settleDate");
    String str4 = this.request.getParameter("gnnt_bsFlag");
    String str5 = this.request.getParameter("gnnt_settleType");
    String str6 = "select shp.settleprocessdate, shp.firmid, shp.commodityid, shp.bs_flag, (shp.HoldQty + shp.GageQty) settleQty, shp.a_HoldNo, shp.openQty, shp.settleMargin, shp.payout, shp.settleFee, shp.settle_PL, shp.SettleAddedTax, shp.Price, shp.SettlePrice, shp.SettleType from T_SettleHoldPosition shp where 1=1";
    if ((!"".equals(str1)) && (str1 != null)) {
      str6 = str6 + " AND shp.commodityId like '%" + str1 + "%'";
    }
    if ((!"".equals(str2)) && (str2 != null)) {
      str6 = str6 + " AND shp.firmId like '%" + str2 + "%'";
    }
    if ((!"".equals(str3)) && (str3 != null)) {
      str6 = str6 + " AND shp.SettleProcessDate = to_date('" + str3 + "','yyyy-mm-dd')";
    }
    if ((!"".equals(str3)) && (str3 != null))
    {
      str6 = str6 + " AND shp.SettleProcessDate = to_date('" + str3 + "','yyyy-mm-dd')";
    }
    else
    {
      localObject = Tools.fmtDate(new Date());
      str6 = str6 + " AND shp.SettleProcessDate = to_date('" + (String)localObject + "','yyyy-mm-dd')";
      this.request.setAttribute("settleDateDefault", localObject);
    }
    if ((!"0".equals(str4)) && (!"".equals(str4)) && (str4 != null)) {
      str6 = str6 + " AND shp.bs_flag = " + str4;
    }
    if ((!"0".equals(str5)) && (!"".equals(str5)) && (str5 != null)) {
      str6 = str6 + " AND shp.SettleType = " + str5;
    }
    Object localObject = getService().getListBySql(str6);
    Page localPage = new Page(localPageRequest.getPageNumber(), localPageRequest.getPageSize(), ((List)localObject).size(), (List)localObject);
    this.request.setAttribute("pageInfo", localPage);
    this.request.setAttribute("oldParams", getParametersStartingWith(this.request, "gnnt_"));
    return "success";
  }
  
  public String notPairTotal()
  {
    List localList1 = getService().getListBySql("select distinct(s.CommodityID) from T_SettleHoldPosition s");
    this.request.setAttribute("commodityIDList", localList1);
    String str1 = "select s.firmid, nvl(sum(s.holdqty+s.gageqty-s.Happenmatchqty),0) notPairTotal from T_SettleHoldPosition s where 1=1 ";
    String str2 = str1 + " AND s.bs_flag = 1 ";
    String str3 = this.request.getParameter("gnnt_commodityID");
    if ((!"".equals(str3)) && (str3 != null))
    {
      str2 = str2 + " AND s.commodityid = '" + str3 + "'";
      this.request.setAttribute("commodityID", str3);
    }
    else if ((localList1 != null) && (localList1.size() != 0))
    {
      str4 = String.valueOf(((Map)localList1.get(0)).get("COMMODITYID"));
      str2 = str2 + "AND s.commodityid = '" + str4 + "'";
      this.request.setAttribute("commodityID", str4);
    }
    String str4 = this.request.getParameter("gnnt_settleDate");
    if ((!"".equals(str4)) && (str4 != null))
    {
      str2 = str2 + " AND s.SettleProcessDate = to_date('" + str4 + "','yyyy-mm-dd')";
    }
    else
    {
      localObject = Tools.fmtDate(new Date());
      str2 = str2 + " AND s.SettleProcessDate = to_date('" + (String)localObject + "','yyyy-mm-dd')";
      this.request.setAttribute("settleDateDefault", localObject);
    }
    str2 = str2 + " group by s.firmid";
    Object localObject = getService().getListBySql(str2);
    String str5 = str2.replace("bs_flag = 1", "bs_flag = 2");
    List localList2 = getService().getListBySql(str5);
    this.request.setAttribute("buyerNotPairTotalList", localObject);
    this.request.setAttribute("sellerNotPairTotalList", localList2);
    this.request.setAttribute("oldParams", getParametersStartingWith(this.request, "gnnt_"));
    return "success";
  }
  
  public String alreadyPairTotal()
  {
    List localList1 = getService().getListBySql("select distinct(s.CommodityID) from T_SettleHoldPosition s");
    this.request.setAttribute("commodityIDList", localList1);
    String str1 = "select s.firmid,nvl(sum(s.Happenmatchqty),0) alreadyPairTotal from T_SettleHoldPosition s where 1=1 ";
    String str2 = str1 + " AND s.bs_flag = 1 ";
    String str3 = this.request.getParameter("gnnt_commodityID");
    if ((!"".equals(str3)) && (str3 != null))
    {
      str2 = str2 + " AND s.commodityid = '" + str3 + "'";
      this.request.setAttribute("commodityID", str3);
    }
    else if ((localList1 != null) && (localList1.size() != 0))
    {
      str4 = String.valueOf(((Map)localList1.get(0)).get("COMMODITYID"));
      str2 = str2 + "AND s.commodityid = '" + str4 + "'";
      this.request.setAttribute("commodityID", str4);
    }
    String str4 = this.request.getParameter("gnnt_settleDate");
    if ((!"".equals(str4)) && (str4 != null))
    {
      str2 = str2 + " AND s.SettleProcessDate = to_date('" + str4 + "','yyyy-mm-dd')";
    }
    else
    {
      localObject = Tools.fmtDate(new Date());
      str2 = str2 + " AND s.SettleProcessDate = to_date('" + (String)localObject + "','yyyy-mm-dd')";
      this.request.setAttribute("settleDateDefault", localObject);
    }
    str2 = str2 + " group by s.firmid";
    Object localObject = getService().getListBySql(str2);
    String str5 = str2.replace("bs_flag = 1", "bs_flag = 2");
    List localList2 = getService().getListBySql(str5);
    this.request.setAttribute("buyeralreadyPairTotalList", localObject);
    this.request.setAttribute("selleralreadyPairTotalList", localList2);
    this.request.setAttribute("oldParams", getParametersStartingWith(this.request, "gnnt_"));
    return "success";
  }
  
  public String getValidGageBill()
    throws Exception
  {
    this.logger.debug("------------ 跳转有效仓单数量列表-------------");
    List localList1 = getService().getListBySql("select commodityId,name from t_commodity ");
    this.request.setAttribute("list", localList1);
    List localList2 = this.billService.getFirmList();
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
    String str1 = this.request.getParameter("gnnt_stock.commodityID");
    String str2 = trim(this.request.getParameter("gnnt_stock.firmID"));
    String str3 = "select v.commodityid,t.name,v.firmid,v.quantity,v.frozenqty from T_ValidGageBill v,t_commodity t where t.commodityid = v.commodityid  ";
    if ((str2 != null) && (!"".equals(str2))) {
      str3 = str3 + " AND v.firmID like '%" + str2 + "%'";
    }
    if ((str1 != null) && (!"".equals(str1))) {
      str3 = str3 + " AND v.commodityId = '" + str1 + "'";
    }
    List localList3 = getService().getListBySql(str3);
    PageRequest localPageRequest = super.getPageRequest(this.request);
    int j = RequestUtils.getPageNo(this.request);
    if (j <= 0) {
      j = 1;
    }
    localPageRequest.setPageNumber(j);
    int k = RequestUtils.getCurrentRowsDisplayed(this.request);
    if (k <= 0) {
      k = ECSideContext.DEFAULT_PAGE_SIZE;
    }
    localPageRequest.setPageSize(k);
    Page localPage = new Page(localPageRequest.getPageNumber(), localPageRequest.getPageSize(), localList3.size(), localList3);
    this.request.setAttribute("pageInfo", localPage);
    this.request.setAttribute("oldParams", getParametersStartingWith(this.request, "gnnt_"));
    return "success";
  }
  
  private String trim(String paramString)
  {
    if (paramString == null) {
      return null;
    }
    return paramString.replaceAll("\\s", "");
  }
}
