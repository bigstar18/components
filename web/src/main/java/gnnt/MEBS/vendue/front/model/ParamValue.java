package gnnt.MEBS.vendue.front.model;

public class ParamValue
{
  protected String code;
  protected String commodityId;
  protected String price;
  protected String amount;
  
  public ParamValue(String paramString1, String paramString2, String paramString3, String paramString4)
  {
    this.code = paramString1;
    this.commodityId = paramString2;
    this.price = paramString3;
    this.amount = paramString4;
  }
  
  public String toString()
  {
    String str = "\n";
    StringBuffer localStringBuffer = new StringBuffer();
    localStringBuffer.append("**" + getClass().getName() + "**" + str);
    localStringBuffer.append("code:" + this.code + str);
    localStringBuffer.append("commodityId:" + this.commodityId + str);
    localStringBuffer.append("price:" + this.price + str);
    localStringBuffer.append("amount:" + this.amount + str);
    localStringBuffer.append(str);
    return localStringBuffer.toString();
  }
  
  public String getCode()
  {
    return this.code;
  }
  
  public void setCode(String paramString)
  {
    this.code = paramString;
  }
  
  public String getCommodityId()
  {
    return this.commodityId;
  }
  
  public void setCommodityId(String paramString)
  {
    this.commodityId = paramString;
  }
  
  public String getPrice()
  {
    return this.price;
  }
  
  public void setPrice(String paramString)
  {
    this.price = paramString;
  }
  
  public String getAmount()
  {
    return this.amount;
  }
  
  public void setAmount(String paramString)
  {
    this.amount = paramString;
  }
}
