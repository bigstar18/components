package gnnt.MEBS.vendue.mgr.action.bargain;

import gnnt.MEBS.common.mgr.action.EcsideAction;
import gnnt.MEBS.common.mgr.common.Condition;
import gnnt.MEBS.common.mgr.common.Page;
import gnnt.MEBS.common.mgr.common.PageRequest;
import gnnt.MEBS.common.mgr.common.QueryConditions;
import gnnt.MEBS.common.mgr.service.StandardService;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.logging.Log;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

@Controller("bargainAction")
@Scope("request")
public class BargainAction
  extends EcsideAction
{
  private static final long serialVersionUID = 1L;
  @Resource(name="batgainCurSubmit_OrderType")
  private Map<Integer, String> batgainCurSubmit_OrderType;
  
  public Map<Integer, String> getBatgainCurSubmit_OrderType()
  {
    return this.batgainCurSubmit_OrderType;
  }
  
  public void setBatgainCurSubmit_OrderType(Map<Integer, String> paramMap)
  {
    this.batgainCurSubmit_OrderType = paramMap;
  }
  
  public String getBargainList()
    throws Exception
  {
    int i = -1;
    String str = this.request.getParameter("partitionid");
    if ((str != null) && (!str.equals(""))) {
      i = Integer.parseInt(str);
    }
    StringBuffer localStringBuffer = new StringBuffer();
    localStringBuffer.append("select * from(select c.*, m.name ").append("from (select b.*, vc.userid firmid ").append("\t   from (select vb.*,to_char(vb.tradetime,'yyyy-MM-DD HH24:MI:SS') ttime, mf.name username").append("\t\t\t  from v_bargain vb, m_firm mf").append("\t\t\t\t\twhere vb.userid = mf.firmid and vb.tradepartition =").append(i).append(") b,v_commodity vc").append("\t   where b.code = vc.code) c,m_firm m ").append("where c.firmid = m.firmid)");
    getListBySQL(localStringBuffer);
    this.request.setAttribute("tradePartition", Integer.valueOf(i));
    return "success";
  }
  
  public String getHisBargainList()
    throws Exception
  {
    int i = -1;
    String str = this.request.getParameter("partitionid");
    if ((str != null) && (!str.equals(""))) {
      i = Integer.parseInt(str);
    }
    StringBuffer localStringBuffer = new StringBuffer();
    localStringBuffer.append("select * from(select c.*, m.name ").append("from (select b.*, vc.userid firmid ").append("\t   from (select vb.*, to_char(vb.tradetime,'yyyy-MM-DD HH24:MI:SS') ttime,mf.name username").append("\t\t\t  from v_hisBargain vb, m_firm mf").append("\t\t\t\t\twhere vb.userid = mf.firmid and vb.tradepartition =").append(i).append(") b,v_commodity vc").append("\t   where b.code = vc.code) c,m_firm m ").append("where c.firmid = m.firmid)");
    getListBySQL(localStringBuffer);
    this.request.setAttribute("tradePartition", Integer.valueOf(i));
    return "success";
  }
  
  public String getCurSubmitList()
    throws Exception
  {
    int i = -1;
    String str = this.request.getParameter("partitionid");
    if ((str != null) && (!str.equals(""))) {
      i = Integer.parseInt(str);
    }
    StringBuffer localStringBuffer = new StringBuffer();
    localStringBuffer.append("select * from(select c.*, m.name ").append("from (select b.*, vc.userid firmid,vc.commodityID commodityID").append("\t   from (select vb.*, mf.name username").append("\t\t\t  from v_curSubmit vb, m_firm mf").append("\t\t\t\t\twhere vb.userid = mf.firmid and vb.tradepartition =").append(i).append(") b,v_commodity vc").append("\t   where b.code = vc.code) c,m_firm m ").append("where c.firmid = m.firmid)");
    getListBySQL(localStringBuffer);
    this.request.setAttribute("tradePartition", Integer.valueOf(i));
    return "success";
  }
  
  public String getHisSubmitList()
    throws Exception
  {
    int i = -1;
    String str = this.request.getParameter("partitionid");
    if ((str != null) && (!str.equals(""))) {
      i = Integer.parseInt(str);
    }
    StringBuffer localStringBuffer = new StringBuffer();
    localStringBuffer.append("select * from(select c.*, m.name ").append("from (select b.*, vc.userid firmid,vc.commodityID commodityID").append("\t   from (select vb.*, mf.name username").append("\t\t\t  from v_hisSubmit vb, m_firm mf").append("\t\t\t\t\twhere vb.userid = mf.firmid and vb.tradepartition =").append(i).append(") b,v_commodity vc").append("\t   where b.code = vc.code) c,m_firm m ").append("where c.firmid = m.firmid)");
    getListBySQL(localStringBuffer);
    this.request.setAttribute("tradePartition", Integer.valueOf(i));
    return "success";
  }
  
  public void getListBySQL(StringBuffer paramStringBuffer)
    throws Exception
  {
    List localList = null;
    int i = -1;
    String str1 = this.request.getParameter("trademode");
    if ((str1 != null) && (!str1.equals(""))) {
      i = Integer.parseInt(str1);
    }
    PageRequest localPageRequest = super.getPageRequest(this.request);
    QueryConditions localQueryConditions = (QueryConditions)localPageRequest.getFilters();
    String str2 = getFieldsSqlClause(localQueryConditions);
    paramStringBuffer.append(str2);
    localList = getService().getListBySql(paramStringBuffer.toString());
    Page localPage = new Page(localPageRequest.getPageNumber(), localPageRequest.getPageSize(), localList.size(), localList);
    this.request.setAttribute("pageInfo", localPage);
    this.request.setAttribute("oldParams", getParametersStartingWith(this.request, "gnnt_"));
    this.request.setAttribute("tradeMode", Integer.valueOf(i));
  }
  
  public String getFieldsSqlClause(QueryConditions paramQueryConditions)
  {
    String str1 = "where 1=1";
    String str2 = null;
    String str3 = null;
    List localList = paramQueryConditions.getConditionList();
    if ((localList != null) && (localList.size() > 0))
    {
      Condition localCondition = null;
      for (int i = 0; i < localList.size(); i++)
      {
        localCondition = (Condition)localList.get(i);
        str2 = localCondition.getOperator();
        str3 = localCondition.getField();
        if ((str3 == null) || (str3.length() == 0) || (str2 == null) || (str2.length() == 0) || (localCondition.getValue() == null)) {
          return "";
        }
        if (localCondition.getOperator().equals("like"))
        {
          str1 = str1 + " and " + localCondition.getField() + " " + str2 + " '%" + localCondition.getValue() + "%'";
        }
        else
        {
          String str4 = isDateType(str3, str2);
          if (str4.equals("no&date")) {
            str1 = str1 + " and " + localCondition.getField() + str2 + localCondition.getValue();
          } else {
            str1 = str1 + " and trunc(" + localCondition.getField() + ")" + str2 + "to_date('" + str4 + "','yyyy-MM-dd')";
          }
        }
      }
    }
    return str1;
  }
  
  public String isDateType(String paramString1, String paramString2)
  {
    Map localMap = getParametersStartingWith(this.request, "gnnt_");
    Pattern localPattern = Pattern.compile("(.+?)\\[(.+)]\\[(.+)]");
    Iterator localIterator = localMap.keySet().iterator();
    while (localIterator.hasNext())
    {
      String str1 = (String)localIterator.next();
      Object localObject = localMap.get(str1);
      this.logger.debug("parameter:" + str1);
      Matcher localMatcher = localPattern.matcher(str1);
      if (localMatcher.matches())
      {
        String str2 = localMatcher.group(1);
        String str3 = localMatcher.group(2);
        String str4 = localMatcher.group(3);
        if ((str2.equals(paramString1)) && (str3.equals(paramString2)) && (str4.toLowerCase().equals("date"))) {
          return localObject.toString();
        }
      }
    }
    return "no&date";
  }
}
