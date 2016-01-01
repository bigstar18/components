package gnnt.MEBS.common.front.common;

public class ProcedureParameter
{
  public static final int OUTPARAMETER = 1;
  public static final int INPARAMETER = 2;
  private int parameterType;
  private int sqlType;
  private String name;
  private Object value;
  
  public int getParameterType()
  {
    return this.parameterType;
  }
  
  public void setParameterType(int parameterType)
  {
    this.parameterType = parameterType;
  }
  
  public int getSqlType()
  {
    return this.sqlType;
  }
  
  public void setSqlType(int sqlType)
  {
    this.sqlType = sqlType;
  }
  
  public String getName()
  {
    return this.name;
  }
  
  public void setName(String name)
  {
    this.name = name;
  }
  
  public Object getValue()
  {
    return this.value;
  }
  
  public void setValue(Object value)
  {
    this.value = value;
  }
}
