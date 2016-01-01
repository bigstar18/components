package gnnt.MEBS.vendue.mgr.beanforajax;

import gnnt.MEBS.common.mgr.beanforajax.BaseAjax;
import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.service.StandardService;
import gnnt.MEBS.vendue.mgr.model.commodity.commext.MBreedprops;
import gnnt.MEBS.vendue.mgr.model.commodity.commext.MBreedpropsId;
import gnnt.MEBS.vendue.mgr.model.commodity.commext.MProperty;
import gnnt.MEBS.vendue.mgr.model.commodity.commext.VCommext;
import gnnt.MEBS.vendue.mgr.model.firmSet.tradeUser.TradeUserModel;
import gnnt.MEBS.vendue.mgr.model.system.sysPartition.VSyspartition;
import gnnt.MEBS.vendue.mgr.model.system.sysPartition.VTrademodeparams;
import java.io.PrintStream;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.commons.logging.Log;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

@Controller("ajaxQueryCommodityAction")
@Scope("request")
public class AjaxQueryCommodityAction
  extends BaseAjax
{
  public String getCommodityParams()
  {
    this.logger.debug("========== getCommodityParams ajax查询商品默认属性 ==========");
    String str1 = getRequest().getParameter("partitionid");
    String str2 = getRequest().getParameter("breedid");
    String str3 = "select * from v_commodityparams where tradepartition = '" + str1 + "' " + "and breedid = '" + str2 + "'";
    List localList = getService().getListBySql(str3);
    Map[] arrayOfMap = new Map[1];
    arrayOfMap[0] = null;
    if ((localList != null) && (localList.size() > 0)) {
      arrayOfMap[0] = ((Map)localList.get(0));
    }
    this.jsonValidateReturn = createJSONArray(arrayOfMap);
    System.out.println(this.jsonValidateReturn);
    getClass();
    return "success";
  }
  
  public String getPropertyByBreed()
  {
    this.logger.debug("========== getPropertyByBreed ajax查询商品品种属性 ==========");
    Long localLong1 = Long.valueOf(Long.parseLong(getRequest().getParameter("breedid")));
    JSONArray localJSONArray1 = new JSONArray();
    String str1 = "select p.* from m_property p where p.CATEGORYID in (select b.categoryid from m_breed b where b.breedid = '" + localLong1 + "')";
    List localList1 = getService().getListBySql(str1, new MProperty());
    int i = 0;
    Iterator localIterator1 = localList1.iterator();
    while (localIterator1.hasNext())
    {
      StandardModel localStandardModel1 = (StandardModel)localIterator1.next();
      MProperty localMProperty = (MProperty)localStandardModel1;
      Long localLong2 = localMProperty.getPropertyid();
      JSONObject localJSONObject = new JSONObject();
      localJSONObject.put("index", Integer.valueOf(i));
      i++;
      localJSONObject.put("propertyid", localMProperty.getPropertyid());
      localJSONObject.put("propertyname", localMProperty.getPropertyname());
      localJSONObject.put("hasvaluedict", localMProperty.getHasvaluedict());
      localJSONObject.put("isnecessary", localMProperty.getIsnecessary());
      localJSONObject.put("fieldtype", localMProperty.getFieldtype());
      JSONArray localJSONArray2 = new JSONArray();
      String str2 = "select * from m_breedprops where breedid = '" + localLong1 + "' " + "and propertyid = '" + localLong2 + "'";
      List localList2 = getService().getListBySql(str2, new MBreedprops());
      Iterator localIterator2 = localList2.iterator();
      while (localIterator2.hasNext())
      {
        StandardModel localStandardModel2 = (StandardModel)localIterator2.next();
        MBreedprops localMBreedprops = (MBreedprops)localStandardModel2;
        localJSONArray2.add(localMBreedprops.getId().getPropertyvalue());
      }
      localJSONObject.put("values", localJSONArray2);
      localJSONArray1.add(localJSONObject);
    }
    this.jsonValidateReturn = localJSONArray1;
    getClass();
    return "success";
  }
  
  public String getCommextByCode()
  {
    String str1 = getRequest().getParameter("code");
    String str2 = "select * from v_commext where code = '" + str1 + "'";
    List localList = getService().getListBySql(str2, new VCommext());
    Object[] arrayOfObject = new Object[localList.size()];
    for (int i = 0; i < localList.size(); i++) {
      arrayOfObject[i] = localList.get(i);
    }
    this.jsonValidateReturn = createJSONArray(arrayOfObject);
    getClass();
    return "success";
  }
  
  public String getIssplittarget()
  {
    String str = getRequest().getParameter("partitionid");
    VSyspartition localVSyspartition = new VSyspartition();
    localVSyspartition.setPartitionid(Short.valueOf(Short.parseShort(str)));
    localVSyspartition = (VSyspartition)getService().get(localVSyspartition);
    this.jsonValidateReturn = new JSONArray();
    if (localVSyspartition.getIssplittarget().byteValue() == 0) {
      this.jsonValidateReturn.add(Boolean.valueOf(false));
    } else {
      this.jsonValidateReturn.add(Boolean.valueOf(true));
    }
    getClass();
    return "success";
  }
  
  public String getTrademode()
  {
    String str = getRequest().getParameter("partitionid");
    VSyspartition localVSyspartition = new VSyspartition();
    localVSyspartition.setPartitionid(Short.valueOf(Short.parseShort(str)));
    localVSyspartition = (VSyspartition)getService().get(localVSyspartition);
    this.jsonValidateReturn = new JSONArray();
    this.jsonValidateReturn.add(localVSyspartition.getTrademode().getId());
    getClass();
    return "success";
  }
  
  public String isUseridExist()
  {
    String str1 = getRequest().getParameter("userid");
    String str2 = getRequest().getParameter("check");
    TradeUserModel localTradeUserModel = new TradeUserModel();
    localTradeUserModel.setUserCode(str1);
    localTradeUserModel = (TradeUserModel)getService().get(localTradeUserModel);
    this.jsonValidateReturn = new JSONArray();
    if (localTradeUserModel == null) {
      this.jsonValidateReturn.add(Boolean.valueOf(false));
    } else if ((str2 != null) && (str2.equals("true")) && (localTradeUserModel.getIsEntry().intValue() == 0)) {
      this.jsonValidateReturn.add(Boolean.valueOf(false));
    } else {
      this.jsonValidateReturn.add(Boolean.valueOf(true));
    }
    getClass();
    return "success";
  }
}
