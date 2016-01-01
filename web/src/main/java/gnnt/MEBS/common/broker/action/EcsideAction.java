package gnnt.MEBS.common.broker.action;

import gnnt.MEBS.common.broker.common.Condition;
import gnnt.MEBS.common.broker.common.Page;
import gnnt.MEBS.common.broker.common.PageRequest;
import gnnt.MEBS.common.broker.common.QueryConditions;
import gnnt.MEBS.common.broker.model.StandardModel;
import gnnt.MEBS.common.broker.service.StandardService;
import gnnt.MEBS.common.broker.statictools.Tools;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.logging.Log;
import org.ecside.core.ECSideContext;
import org.ecside.table.limit.Filter;
import org.ecside.table.limit.FilterSet;
import org.ecside.table.limit.Limit;
import org.ecside.table.limit.Sort;
import org.ecside.util.RequestUtils;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

@Controller("com_ecsideAction")
@Scope("request")
public class EcsideAction
  extends StandardAction
{
  private static final long serialVersionUID = 1L;
  
  public String listByLimit()
    throws Exception
  {
    this.logger.debug("enter listByLimit");
    
    PageRequest<QueryConditions> pageRequest = 
      super.getPageRequest(this.request);
    listByLimit(pageRequest);
    
    return "success";
  }
  
  public void listByLimit(PageRequest<QueryConditions> pageRequest)
    throws Exception
  {
    this.logger.debug("enter listByLimit");
    
    List<Condition> ecsideConditions = getECSideQueryConditions();
    if ((ecsideConditions != null) && (ecsideConditions.size() > 0)) {
      if (((QueryConditions)pageRequest.getFilters()).getConditionList() != null) {
        ((QueryConditions)pageRequest.getFilters()).getConditionList().addAll(
          ecsideConditions);
      } else {
        ((QueryConditions)pageRequest.getFilters()).setConditionList(ecsideConditions);
      }
    }
    String ecisdeSortColumns = getEcisdeSortColumns();
    if ((ecisdeSortColumns != null) && (ecisdeSortColumns.length() > 0))
    {
      String sortColumn = pageRequest.getSortColumns();
      if ((sortColumn != null) && (sortColumn.trim().length() > 0)) {
        sortColumn = 
          " order by " + ecisdeSortColumns + "," + sortColumn.replace("order by", "");
      } else {
        sortColumn = " order by " + ecisdeSortColumns;
      }
      pageRequest.setSortColumns(sortColumn);
    }
    int maxExportedCount = 10000;
    if (!isExported())
    {
      pageRequest.setPageNumber(getEcsidePageNumber());
      pageRequest.setPageSize(getEcsidePageSize());
    }
    else
    {
      pageRequest.setPageNumber(1);
      pageRequest.setPageSize(maxExportedCount);
    }
    Page<StandardModel> page = getService().getPage(pageRequest, this.entity);
    if ((!isExported()) || (page.getTotalCount() <= maxExportedCount))
    {
      this.request.setAttribute("pageInfo", page);
      
      this.request.setAttribute("oldParams", getParametersStartingWith(
        this.request, "gnnt_"));
      
      setECSideRowAttributes(page.getTotalCount());
    }
  }
  
  private boolean isExported()
  {
    boolean isExported = false;
    Limit limit = RequestUtils.getLimit(this.request);
    if (limit.isExported()) {
      isExported = true;
    }
    return isExported;
  }
  
  private int getEcsidePageNumber()
  {
    int pageNumber = RequestUtils.getPageNo(this.request);
    if (pageNumber <= 0) {
      pageNumber = 1;
    }
    return pageNumber;
  }
  
  private int getEcsidePageSize()
  {
    int pageSize = RequestUtils.getCurrentRowsDisplayed(this.request);
    if (pageSize <= 0) {
      pageSize = ECSideContext.DEFAULT_PAGE_SIZE;
    }
    return pageSize;
  }
  
  private void setECSideRowAttributes(int rowCount)
  {
    Limit limit = RequestUtils.getLimit(this.request);
    limit.setRowAttributes(rowCount, ECSideContext.DEFAULT_PAGE_SIZE);
  }
  
  private List<Condition> getECSideQueryConditions()
    throws Exception
  {
    this.logger.debug("通过 Ecside 获取查询条件");
    List<Condition> conditionList = new ArrayList();
    Limit limit = RequestUtils.getLimit(this.request);
    FilterSet filterSet = limit.getFilterSet();
    Filter[] filters = filterSet.getFilters();
    if ((filters != null) && (filters.length > 0))
    {
      Pattern pOperatorAndType = Pattern.compile("\\[(.+)]\\[(.+)]");
      
      Pattern pOperator = Pattern.compile("\\[(.+)]");
      Filter[] arrayOfFilter1;
      int j = (arrayOfFilter1 = filters).length;
      for (int i = 0; i < j; i++)
      {
        Filter filter = arrayOfFilter1[i];
        
        String filed = filter.getProperty();
        
        Object value = filter.getValue();
        
        String operator = "=";
        
        String alias = filter.getAlias();
        if ((alias != null) && (alias.length() > 0))
        {
          String filedType = null;
          Matcher m = pOperatorAndType.matcher(alias);
          if (m.matches())
          {
            operator = m.group(1);
            filedType = m.group(2);
          }
          else
          {
            m = pOperator.matcher(alias);
            if (m.matches()) {
              operator = m.group(1);
            }
          }
          if ((filedType != null) && (filedType.length() > 0)) {
            value = Tools.convert(value, filedType);
          }
        }
        conditionList.add(new Condition(filed, operator, value));
      }
    }
    return conditionList;
  }
  
  private String getEcisdeSortColumns()
  {
    this.logger.debug("通过 Ecside 获取排序方案");
    Limit limit = RequestUtils.getLimit(this.request);
    Sort sort = limit.getSort();
    String sortName = sort.getProperty();
    String sortOrder = sort.getSortOrder();
    if ((sortName == null) || (sortName.trim().length() <= 0)) {
      return null;
    }
    if ((sortOrder == null) || (sortOrder.trim().length() <= 0)) {
      return null;
    }
    if (!"desc".equalsIgnoreCase(sortOrder)) {
      sortOrder = "";
    }
    return sortName + " " + sortOrder;
  }
}
