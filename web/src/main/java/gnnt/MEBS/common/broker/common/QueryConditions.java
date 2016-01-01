package gnnt.MEBS.common.broker.common;

import java.io.PrintStream;
import java.util.ArrayList;
import java.util.List;

public class QueryConditions
{
  private List<Condition> conditionList = new ArrayList();
  
  public QueryConditions(List<Condition> conditionList)
  {
    this.conditionList = conditionList;
  }
  
  public QueryConditions() {}
  
  public QueryConditions(String field, String operator, Object value)
  {
    addCondition(field, operator, value);
  }
  
  public void addCondition(String field, String operator, Object value)
  {
    this.conditionList.add(new Condition(field, operator, value));
  }
  
  public void removeCondition(String field)
  {
    for (int i = 0; i < this.conditionList.size(); i++)
    {
      Condition cond = (Condition)this.conditionList.get(i);
      if (cond.getField().equals(field)) {
        this.conditionList.remove(i);
      }
    }
  }
  
  public void removeCondition(String field, String operator)
  {
    for (int i = 0; i < this.conditionList.size(); i++)
    {
      Condition cond = (Condition)this.conditionList.get(i);
      if ((cond.getField().equals(field)) && 
        (cond.getOperator().equals(operator))) {
        this.conditionList.remove(i);
      }
    }
  }
  
  public String getFieldsSqlClause()
  {
    String sqlclause = null;
    if ((this.conditionList != null) && (this.conditionList.size() > 0))
    {
      Condition cond = null;
      for (int i = 0; i < this.conditionList.size(); i++)
      {
        cond = (Condition)this.conditionList.get(i);
        if (sqlclause != null) {
          sqlclause = sqlclause + " and " + cond.getSqlClause();
        } else {
          sqlclause = cond.getSqlClause();
        }
      }
    }
    return sqlclause;
  }
  
  public Object[] getValueArray()
  {
    Object[] params = (Object[])null;
    if ((this.conditionList != null) && (this.conditionList.size() > 0))
    {
      Condition cond = null;
      List<Object> lst = new ArrayList();
      for (int i = 0; i < this.conditionList.size(); i++)
      {
        cond = (Condition)this.conditionList.get(i);
        Object obj = cond.getSqlValue();
        if (obj != null) {
          lst.add(obj);
        }
      }
      params = lst.toArray();
    }
    return params;
  }
  
  public Object getConditionValue(String field)
  {
    if (field == null) {
      return null;
    }
    for (int i = 0; i < this.conditionList.size(); i++)
    {
      Condition cond = (Condition)this.conditionList.get(i);
      if (field.equals(cond.getField())) {
        return cond.getValue();
      }
    }
    return null;
  }
  
  public Object getConditionValue(String field, String operator)
  {
    if ((field == null) || (operator == null)) {
      return null;
    }
    for (int i = 0; i < this.conditionList.size(); i++)
    {
      Condition cond = (Condition)this.conditionList.get(i);
      if ((field.equals(cond.getField())) && 
        (operator.equals(cond.getOperator()))) {
        return cond.getValue();
      }
    }
    return null;
  }
  
  public List<Condition> getConditionList()
  {
    return this.conditionList;
  }
  
  public void setConditionList(List<Condition> conditionList)
  {
    this.conditionList = conditionList;
  }
  
  public static void main(String[] args)
  {
    QueryConditions qc = new QueryConditions("code", "=", "");
    qc.addCondition("code", "is", "null");
    qc.addCondition("code", "is", "not null");
    System.out.println(qc.getFieldsSqlClause());
    System.out.println(qc.getValueArray().length);
  }
}
