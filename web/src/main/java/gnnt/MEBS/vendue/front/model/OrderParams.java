package gnnt.MEBS.vendue.front.model;

import java.util.HashMap;

public class OrderParams
{
  protected String commodityId = "";
  protected HashMap<String, ParamValue> map = new HashMap();
  
  public String getCommodityId()
  {
    return this.commodityId;
  }
  
  public void setCommodityId(String paramString)
  {
    this.commodityId = paramString;
  }
  
  public HashMap<String, ParamValue> getMap()
  {
    return this.map;
  }
  
  public void setMap(HashMap<String, ParamValue> paramHashMap)
  {
    this.map = paramHashMap;
  }
  
  public String toString()
  {
    String str = "\n";
    StringBuffer localStringBuffer = new StringBuffer();
    localStringBuffer.append("**" + getClass().getName() + "**" + str);
    return localStringBuffer.toString();
  }
}
