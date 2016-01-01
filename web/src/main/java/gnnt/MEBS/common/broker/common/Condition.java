package gnnt.MEBS.common.broker.common;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Condition
{
  private String field;
  private String operator;
  private Object value;
  
  public Condition() {}
  
  public Condition(String field, String operator, Object value)
  {
    this.field = field;
    this.operator = operator;
    this.value = value;
  }
  
  public String getField()
  {
    return this.field;
  }
  
  public void setField(String field)
  {
    this.field = field;
  }
  
  public String getOperator()
  {
    if ("allLike".equals(this.operator)) {
      return "like";
    }
    return this.operator;
  }
  
  public void setOperator(String operator)
  {
    this.operator = operator;
  }
  
  public Object getValue()
  {
    return this.value;
  }
  
  public void setValue(Object value)
  {
    this.value = value;
  }
  
  public String getSqlClause()
  {
    if ((getField() == null) || (getField().length() == 0) || 
      (this.operator == null) || (this.operator.length() == 0) || (this.value == null)) {
      return "";
    }
    String clause = null;
    if (isPlaceholder()) {
      clause = getField() + " " + getOperator() + " ?";
    } else {
      clause = getField() + " " + this.operator + " " + getValue();
    }
    return clause;
  }
  
  public Integer getSqlDataType()
  {
    if ((getField() == null) || (getField().length() == 0) || 
      (this.operator == null) || (this.operator.length() == 0) || (this.value == null)) {
      return null;
    }
    if (isPlaceholder())
    {
      if ((this.value instanceof String)) {
        return new Integer(12);
      }
      if ((this.value instanceof Long)) {
        return new Integer(-5);
      }
      if ((this.value instanceof java.util.Date)) {
        return new Integer(91);
      }
      if ((this.value instanceof java.sql.Date)) {
        return new Integer(91);
      }
      if ((this.value instanceof Timestamp)) {
        return new Integer(93);
      }
      if ((this.value instanceof BigDecimal)) {
        return new Integer(2);
      }
      return null;
    }
    return null;
  }
  
  public Object getSqlValue()
  {
    if ((getField() == null) || (getField().length() == 0) || 
      (this.operator == null) || (this.operator.length() == 0) || (this.value == null)) {
      return null;
    }
    if (isPlaceholder())
    {
      if ("like".equals(this.operator)) {
        return 
        
          ((String)getValue()).replaceAll("%", "/%").replaceAll("_", "/_") + "%";
      }
      if ("allLike".equals(this.operator)) {
        return 
        
          "%" + ((String)getValue()).replaceAll("%", "/%").replaceAll("_", "/_") + "%";
      }
      return this.value;
    }
    return null;
  }
  
  private boolean isPlaceholder()
  {
    if ("is".equals(this.operator)) {
      return false;
    }
    if ("in".equals(this.operator)) {
      return false;
    }
    if ("not in".equals(this.operator)) {
      return false;
    }
    if (this.operator.trim().length() == 0) {
      return false;
    }
    return true;
  }
}
